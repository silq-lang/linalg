"""Generate common-basis Silq versus CUDA-Q Algorithms resource metrics."""

from __future__ import annotations

import importlib
import importlib.metadata
import json
import math
import os
from pathlib import Path
import re
import shutil
import subprocess
import sys
import tempfile

sys.dont_write_bytecode = True

from cudaq_trace_export import trace_to_qasm


HERE = Path(__file__).resolve().parent
OUTPUT = HERE / "outputs"
EPSILON = 1e-6

BENCHMARKS = [
    ("qft", "Quantum Fourier transform, 5 qubits"),
    ("givens", "Adjacent Givens rotation, 2 qubits"),
    ("slater", "Real Slater determinant, 4 orbitals / 2 electrons"),
    ("qq_adder", "In-place register addition, 4+4 qubits"),
    ("comparator", r"Constant comparator ($x<6$), 5-bit input"),
    ("trotter", "Second-order product formula, 2 steps"),
    ("qroam", "Paper QROAM, 8 two-bit entries, block size 2"),
    ("pauli_prepare", "Pauli-LCU PREPARE, 3 terms"),
    ("pauli_select", "Signed Pauli-LCU SELECT, 3 terms"),
    ("walk", "Pauli-LCU qubitization walk, power 2"),
    ("qsvt", "Degree-3 QSVT sequence"),
]
DYNAMIC_SILQ = {"qroam"}
EXACT_DYNAMIC_ROWS = {"qq_adder"}
QROAM_DATA_MEASUREMENTS = 4
QROAM_CLEANUP_MEASUREMENTS = 1
QROAM_BRANCH_COUNT = 1 << (
    QROAM_DATA_MEASUREMENTS + QROAM_CLEANUP_MEASUREMENTS
)


def run(
    command: list[str],
    *,
    stdin: str | None = None,
    cwd: Path = HERE,
    extra_env: dict[str, str] | None = None,
) -> str:
    environment = {
        **os.environ,
        "MPLCONFIGDIR": str(HERE / ".mplconfig"),
        "XDG_CACHE_HOME": str(HERE / ".cache"),
        **(extra_env or {}),
    }
    process = subprocess.run(
        command,
        input=stdin,
        text=True,
        capture_output=True,
        cwd=cwd,
        check=False,
        timeout=1800,
        env=environment,
    )
    if process.returncode:
        raise RuntimeError(
            f"Command failed ({process.returncode}): {' '.join(command)}\n"
            f"stdout:\n{process.stdout}\nstderr:\n{process.stderr}"
        )
    return process.stdout


def export_silq(name: str) -> str:
    compiler = shutil.which("silq")
    if compiler is None:
        raise RuntimeError("silq executable is not on PATH")
    source = (HERE / f"{name}.slq").read_text()
    hqir = run([compiler, "--compile", "--stdin"], stdin=source)
    hqir = hqir.replace("circuit_call[", "mfree_call[")
    return run(
        ["hqir", "--stdin", "hqir", "-O3", "--flatten", "-R3", "--qasm"],
        stdin=hqir,
    )


def export_qroam_branches() -> list[str]:
    """Export every static branch of the paper's adaptive QROAM.

    The four X-basis data measurements and the final unary-cleanup
    measurement are unbiased, so the 32 branches have equal probability.
    Measurement/reset operations remain in each circuit; only their classical
    outcomes are specialized for the feed-forward gates.
    """
    compiler = shutil.which("silq")
    if compiler is None:
        raise RuntimeError("silq executable is not on PATH")
    source = (HERE / "qroam.slq").read_text()
    source = source[:source.index("def main():")]
    source += """def unary2binary_branch(const low_address:𝔹^1,
    xs:𝔹^2,final_bit:!𝔹){
    (lo:𝔹^1)~(hi:𝔹^1) := xs;
    lo[0] := CNOT(hi[0],lo[0]);
    (hi[0],ignored) := measure_x_reset(hi[0]);
    if final_bit&&low_address[0]{lo[0] := Z(lo[0]);}
    forget(hi=0:uint[1] as 𝔹^1);
    forget(lo=1:uint[1] as 𝔹^1);
}

def qroam_uncomp_branch[M:!ℕ](const f:!ℕ !→ lifted !𝔹^M)
    [m:!ℕ,k:!ℕ](address:𝔹^m,qs:(𝔹^M)^k,d:!ℕ,
        measurements:!ℕ,final_bit:!𝔹){
    for i in [0..k){
        for j in [0..M){(qs[i][j],ignored) := measure_x_reset(qs[i][j]);}
    }
    forget(qs=vector(k,vector(M,0:𝔹)));
    ml := floor(log₂(k)) coerce !ℕ;
    assert(ml=1);
    (l:𝔹^1)~(h:𝔹^(m sub 1)) := address;
    xs := binary2unary[1](l);
    for i in [0..k){xs[i] := H(xs[i]);}
    for i in [0..2^(m sub 1)){
        uses := 0:!ℕ;
        for j in [0..k div 2){
            q := (k div 2)*i+j;
            fix0 := negate_bit[M](f)[k](measurements,2*q,d);
            fix1 := negate_bit[M](f)[k](measurements,2*q+1,d);
            if fix0{uses += 1;}
            if fix1{uses += 1;}
        }
        if uses<3{
            for j in [0..k div 2){
                q := (k div 2)*i+j;
                fix0 := negate_bit[M](f)[k](measurements,2*q,d);
                fix1 := negate_bit[M](f)[k](measurements,2*q+1,d);
                if fix0{xs[2*j] := match_x[m sub 1](i,h,xs[2*j]);}
                if fix1{xs[2*j+1] := match_x[m sub 1](i,h,xs[2*j+1]);}
            }
        }else{
            selected := 0:𝔹;
            selected := match_x[m sub 1](i,h,selected);
            for j in [0..k div 2){
                q := (k div 2)*i+j;
                fix0 := negate_bit[M](f)[k](measurements,2*q,d);
                fix1 := negate_bit[M](f)[k](measurements,2*q+1,d);
                if fix0{xs[2*j] := CNOT(selected,xs[2*j]);}
                if fix1{xs[2*j+1] := CNOT(selected,xs[2*j+1]);}
            }
            selected := match_x[m sub 1](i,h,selected);
            forget(selected=0:𝔹);
        }
    }
    for i in [0..k){xs[i] := H(xs[i]);}
    unary2binary_branch(l,xs,final_bit);
    return l~h;
}
"""
    for branch in range(QROAM_BRANCH_COUNT):
        measurements, final_bit = divmod(branch, 2)
        bit_literal = "true" if final_bit else "false"
        source += f"""def branch_{branch}():𝔹^5{{
    address := 0:uint[3] as 𝔹^3;
    for j in [0..3){{address[j] := H(address[j]);}}
    (address,qs) := qroam_comp[2](table)[3](address,2);
    output := 0:uint[2] as 𝔹^2;
    for j in [0..2){{output[j] := CNOT(qs[0][j],output[j]);}}
    address := qroam_uncomp_branch[2](table)[3,2](
        address,qs,8,{measurements},{bit_literal});
    return address~output;
}}
"""
    hqir = run([compiler, "--compile", "--stdin"], stdin=source)
    hqir = hqir.replace("circuit_call[", "mfree_call[")
    circuits = []
    for branch in range(QROAM_BRANCH_COUNT):
        circuits.append(run(
            [
                "hqir", "--stdin", "hqir",
                "--main-function", f"silq_function.stdin.branch_{branch}",
                "-O3", "--flatten", "-R3", "--qasm",
            ],
            stdin=hqir,
        ))
    return circuits


def export_cudaq(name: str) -> str:
    module = importlib.import_module(name)
    values = [
        0.0,
        math.pi,
        math.pi / 2.0,
        math.pi / 4.0,
        math.pi / 6.0,
        math.pi / 12.0,
        *module.known_angles(),
    ]
    angles = {
        scale * float(value)
        for value in values
        for scale in (-2.0, -1.0, -0.5, 0.5, 1.0, 2.0)
    }
    return trace_to_qasm(
        module.build_kernel(), known_angles=sorted(angles)
    )


def validate_dynamic_silq(name: str) -> dict:
    """Execute a measurement/feed-forward Silq circuit without flattening it."""
    compiler = shutil.which("silq")
    if compiler is None:
        raise RuntimeError("silq executable is not on PATH")
    output = run([
        compiler,
        "--run",
        "--repeat=32",
        "--seed=7",
        "--print-format=json-stream",
        str(HERE / f"{name}.slq"),
    ])
    events = [json.loads(line) for line in output.splitlines() if line.strip()]
    passed = (
        len(events) == 32
        and all(event.get("event") == "finished" for event in events)
        and all(event.get("error_probability") == 0.0 for event in events)
    )
    if not passed:
        raise RuntimeError(f"Dynamic Silq validation failed for {name}")
    return {
        "dynamic_circuit": True,
        "width": None,
        "depth": None,
        "t-count": None,
        "validation_runs": len(events),
        "note": "Mid-circuit measurement/feed-forward; static QASM metrics unavailable.",
    }


SYMMETRIC_GATE = re.compile(
    r"^(\s*)(cp\([^)]*\)|cz|swap)\s+([^,;]+),\s*([^;]+);"
)
CONTROLLED_GATE = re.compile(
    r"^(\s*)(ccx|ctrl(?:\((\d+)\))?\s*@\s*[a-z]+(?:\([^)]*\))?)\s+([^;@]+);"
)
MULTI_CONTROLLED = re.compile(
    r"^(\s*)ctrl\((\d+)\)\s*@\s*([a-z]+)(\(([^)]*)\))?\s+([^;@]+);"
)
PHASE_GATE = re.compile(
    r"^(p\(([^)]*)\)|t|tdg|inv @ t|s|sdg|inv @ s|z)\s+([^,;]+);$"
)
PHASE_ANGLES = {
    "t": math.pi / 4,
    "tdg": -math.pi / 4,
    "inv @ t": -math.pi / 4,
    "s": math.pi / 2,
    "sdg": -math.pi / 2,
    "inv @ s": -math.pi / 2,
    "z": math.pi,
}


def merge_adjacent_phases(qasm: str) -> str:
    """Apply the same exact phase peephole used by the earlier comparison."""

    def phase_of(line: str):
        if line[:1].isspace():
            return None
        match = PHASE_GATE.match(line.split("//")[0].strip())
        if not match:
            return None
        if match.group(2) is not None:
            angle = float(eval(
                match.group(2), {"pi": math.pi, "__builtins__": {}}
            ))
        else:
            angle = PHASE_ANGLES[match.group(1)]
        return match.group(3).strip(), angle

    output: list[str] = []
    pending: tuple[str, float] | None = None

    def flush() -> None:
        if pending is None:
            return
        angle = math.remainder(pending[1], 2 * math.pi)
        if abs(angle) > 1e-12:
            output.append(f"p({angle!r}) {pending[0]};")

    for line in qasm.splitlines():
        phase = phase_of(line)
        if phase and pending and phase[0] == pending[0]:
            pending = (pending[0], pending[1] + phase[1])
            continue
        flush()
        pending = phase
        if phase is None:
            output.append(line)
    flush()
    return "\n".join(output) + "\n"


def canonicalize(qasm: str) -> str:
    """Make symmetric-operand ordering deterministic for both toolchains."""
    lines = []
    for line in qasm.splitlines():
        code = line.split("//")[0]
        match = SYMMETRIC_GATE.match(code)
        if match:
            first, second = sorted([match.group(3).strip(), match.group(4).strip()])
            line = f"{match.group(1)}{match.group(2)} {first}, {second};"
        elif match := CONTROLLED_GATE.match(code):
            operands = [item.strip() for item in match.group(4).split(",")]
            count = 2 if match.group(2) == "ccx" else int(match.group(3) or 1)
            if "gphase" in match.group(2):
                count = len(operands)
            operands = sorted(operands[:count]) + operands[count:]
            line = f"{match.group(1)}{match.group(2)} {', '.join(operands)};"
        lines.append(line)
    return "\n".join(lines) + "\n"


def lower_multi_controlled(qasm: str) -> str:
    """Use the same clean-ancilla Toffoli ladder for both frameworks."""
    needed = 0

    def and_chain(controls: list[str], indent: str):
        nonlocal needed
        if len(controls) == 1:
            return controls[0], []
        operations = []
        top = controls[0]
        for index, control in enumerate(controls[1:]):
            ancilla = f"_mc_anc[{index}]"
            operations.append(f"{indent}ccx {top}, {control}, {ancilla};")
            top = ancilla
        needed = max(needed, len(controls) - 1)
        return top, operations

    lines = []
    for line in qasm.splitlines():
        match = MULTI_CONTROLLED.match(line.split("//")[0])
        if not match or int(match.group(2)) < 2:
            lines.append(line)
            continue
        indent = match.group(1)
        count = int(match.group(2))
        gate = match.group(3)
        params = match.group(4) or ""
        parameter = match.group(5)
        operands = [item.strip() for item in match.group(6).split(",")]
        controls, targets = operands[:count], operands[count:]
        if gate == "gphase":
            angle = float(eval(parameter, {"pi": math.pi, "__builtins__": {}}))
            if abs(math.remainder(angle, 2 * math.pi)) < 1e-12:
                continue
            top, operations = and_chain(controls[:-1], indent)
            body = [f"{indent}cp({parameter}) {top}, {controls[-1]};"]
        elif gate == "x":
            top, operations = and_chain(controls[:-1], indent)
            body = [f"{indent}ccx {top}, {controls[-1]}, {targets[0]};"]
        else:
            top, operations = and_chain(controls, indent)
            body = [
                f"{indent}ctrl(1) @ {gate}{params} {top}, {', '.join(targets)};"
            ]
        lines.extend(operations + body + operations[::-1])

    if needed:
        declarations = [
            index
            for index, line in enumerate(lines)
            if re.match(r"\s*(qubit|qreg)\b", line)
        ]
        lines.insert(declarations[-1] + 1, f"qubit[{needed}] _mc_anc;")
    return "\n".join(lines) + "\n"


def metrics(qasm: str) -> dict:
    normalized = lower_multi_controlled(canonicalize(qasm))
    output = run(
        [
            "qasmviz",
            "--clifford-t",
            "--eps",
            str(EPSILON),
            "--opt",
            "3",
            "--cost",
            "--json",
        ],
        stdin=normalized,
    )
    marker = output.rfind("\n{\n  \"width\"")
    if marker < 0:
        marker = output.find("{\n  \"width\"")
    if marker < 0:
        raise RuntimeError(f"Could not locate qasmviz JSON:\n{output}")
    return json.loads(output[marker + (1 if output[marker] == "\n" else 0):])


def dynamic_clifford_t_metrics(qasm: str) -> dict:
    """Cost an exact Clifford+T circuit while retaining feed-forward."""
    normalized = merge_adjacent_phases(canonicalize(qasm))
    output = run(["qasmviz", "--cost", "--json"], stdin=normalized)
    marker = output.rfind("\n{\n  \"width\"")
    if marker < 0:
        marker = output.find("{\n  \"width\"")
    if marker < 0:
        raise RuntimeError(f"Could not locate qasmviz JSON:\n{output}")
    result = json.loads(
        output[marker + (1 if output[marker] == "\n" else 0):]
    )
    rotations = result.get("rotations", {})
    gates = result.get("gates", {}).get("gates", {})
    result["t-count"] = (
        rotations.get("t-count", 0)
        + gates.get("t", 0)
        + gates.get("tdg", 0)
    )
    return result


def aggregate_branch_metrics(branches: list[dict]) -> dict:
    """Summarize equiprobable adaptive branches; primary values are worst case."""
    if not branches:
        raise ValueError("At least one adaptive branch is required")
    summary = {}
    for key in ("width", "depth", "t-count", "cx-count", "t-depth", "cx-depth"):
        values = [branch[key] for branch in branches]
        summary[key] = {
            "minimum": min(values),
            "average": sum(values) / len(values),
            "maximum": max(values),
        }
    return {
        "dynamic_circuit": True,
        "branch_count": len(branches),
        "branch_probability": 1.0 / len(branches),
        "aggregation": "minimum, equiprobable average, and worst case",
        "width": summary["width"]["maximum"],
        "depth": summary["depth"]["maximum"],
        "t-count": summary["t-count"]["maximum"],
        "cx-count": summary["cx-count"]["maximum"],
        "t-depth": summary["t-depth"]["maximum"],
        "cx-depth": summary["cx-depth"]["maximum"],
        "branch_summary": summary,
        "branches": branches,
    }


def write_tables(results: list[dict]) -> None:
    markdown = [
        "# Plain Silq versus CUDA-Q Algorithms",
        "",
        "Unitary rows use qasmviz Clifford+T synthesis (`--opt 3 --eps 1e-6`).",
        "",
        "| Benchmark | Silq width | Silq depth | Silq T | CUDA-Q width | CUDA-Q depth | CUDA-Q T |",
        "|---|---:|---:|---:|---:|---:|---:|",
    ]
    for result in results:
        silq, cudaq = result["silq"], result["cudaq"]
        sw = "--" if silq["width"] is None else silq["width"]
        sd = "--" if silq["depth"] is None else silq["depth"]
        st = "--" if silq["t-count"] is None else silq["t-count"]
        markdown.append(
            f"| {result['description']} | {sw} | {sd} | "
            f"{st} | {cudaq['width']} | {cudaq['depth']} | "
            f"{cudaq['t-count']} |"
        )
    markdown.extend([
        "",
        "- T includes T and T-dagger gates.",
        "- The QQ-adder row retains Silq's mid-circuit measurement/feed-forward and is costed in exact Clifford+T without unitary-only optimization; CUDA-Q uncomputes its carry coherently.",
        "- PREPARE, SELECT, Walk, and QSVT use the same Pauli LCU with alpha=1.",
        "- Silq QROAM reports the worst-case complete adaptive branch; min/average/max branch metrics are stored in `outputs/results.json`.",
        "- CUDA-Q reports its complete coherent built-in QROM; Silq uses the paper's measurement-based uncomputation.",
        "- State equivalence is recorded in `outputs/state_verification.json`.",
        "",
    ])
    (HERE / "table.md").write_text("\n".join(markdown))

    rows = []
    for result in results:
        silq, cudaq = result["silq"], result["cudaq"]
        sw = "--" if silq["width"] is None else silq["width"]
        sd = "--" if silq["depth"] is None else silq["depth"]
        st = "--" if silq["t-count"] is None else silq["t-count"]
        description = result["description"].replace("_", r"\_")
        rows.append(
            f"{description} & {sw} & {sd} & "
            f"{st} & {cudaq['width']} & {cudaq['depth']} & "
            f"{cudaq['t-count']} \\\\"
        )
    tex = "\n".join([
        r"\documentclass[10pt]{article}",
        r"\usepackage[T1]{fontenc}",
        r"\usepackage[margin=0.6in]{geometry}",
        r"\usepackage{amsmath}",
        r"\usepackage{array}",
        r"\usepackage{booktabs}",
        r"\usepackage{tabularx}",
        r"\pagestyle{empty}",
        r"\begin{document}",
        "",
        r"\begin{table}[h]",
        r"\centering",
        r"\caption{Resource comparison between plain Silq and CUDA-Q Algorithms.}",
        r"\label{tab:silq-cudaq}",
        r"\small",
        r"\setlength{\tabcolsep}{3pt}",
        r"\renewcommand{\arraystretch}{1.1}",
        r"\begin{tabularx}{\columnwidth}{",
        r"    >{\raggedright\arraybackslash}X",
        r"    *{6}{>{\centering\arraybackslash}p{0.075\columnwidth}}",
        r"}",
        r"    & \multicolumn{3}{c}{Plain Silq}",
        r"    & \multicolumn{3}{c}{CUDA-Q} \\",
        r"Algorithm",
        r"    & width & depth & T-count",
        r"    & width & depth & T-count \\",
        r"\cmidrule(lr){2-4}",
        r"\cmidrule(lr){5-7}",
        *rows,
        r"\end{tabularx}",
        r"\end{table}",
        "",
        r"\end{document}",
        "",
    ])
    (HERE / "table.tex").write_text(tex)


def main() -> None:
    OUTPUT.mkdir(exist_ok=True)
    temporary_qasm = tempfile.TemporaryDirectory(prefix="cudaq_comp_qasm_")
    qasm_dir = Path(temporary_qasm.name)
    results = []
    for name, description in BENCHMARKS:
        if name in DYNAMIC_SILQ:
            print(f"[{name}] Silq dynamic validation", flush=True)
            dynamic_validation = validate_dynamic_silq(name)
            print(f"[{name}] Silq 32-branch resource analysis", flush=True)
            branch_qasm = export_qroam_branches()
            if len(branch_qasm) != QROAM_BRANCH_COUNT:
                raise RuntimeError(
                    f"Expected {QROAM_BRANCH_COUNT} QROAM branches, "
                    f"got {len(branch_qasm)}"
                )
            branch_results = []
            for branch, qasm in enumerate(branch_qasm):
                branch_result = metrics(qasm)
                ops = branch_result.get("gates", {}).get("ops", {})
                expected_ops = {
                    "measure": QROAM_DATA_MEASUREMENTS
                    + QROAM_CLEANUP_MEASUREMENTS,
                    "reset": QROAM_DATA_MEASUREMENTS
                    + QROAM_CLEANUP_MEASUREMENTS,
                }
                if ops != expected_ops:
                    raise RuntimeError(
                        f"QROAM branch {branch} lost dynamic operations: "
                        f"expected {expected_ops}, got {ops}"
                    )
                branch_result["branch"] = branch
                branch_result["data_measurements"] = branch // 2
                branch_result["unary_measurement"] = branch % 2
                branch_results.append(branch_result)
            silq_result = aggregate_branch_metrics(branch_results)
            silq_result["scope"] = "complete paper QROAM, branch-aware"
            silq_result["full_dynamic_validation"] = dynamic_validation
            print(f"[{name}] CUDA-Q coherent reference", flush=True)
            cudaq_qasm = export_cudaq(name)
            (qasm_dir / f"{name}_cudaq.qasm").write_text(cudaq_qasm)
            results.append({
                "id": name,
                "description": description,
                "silq": silq_result,
                "cudaq": metrics(cudaq_qasm),
                "directly_comparable": False,
            })
            continue
        print(f"[{name}] Silq", flush=True)
        silq_qasm = export_silq(name)
        print(f"[{name}] CUDA-Q", flush=True)
        cudaq_qasm = export_cudaq(name)
        (qasm_dir / f"{name}_silq.qasm").write_text(silq_qasm)
        (qasm_dir / f"{name}_cudaq.qasm").write_text(cudaq_qasm)
        silq_metric_function = (
            dynamic_clifford_t_metrics if name in EXACT_DYNAMIC_ROWS else metrics
        )
        results.append({
            "id": name,
            "description": description,
            "silq": silq_metric_function(silq_qasm),
            "cudaq": metrics(cudaq_qasm),
        })

    payload = {
        "configuration": {
            "cudaq_algorithms_commit": "e46eea91aa7a54b59aebacc0492902acecf87a0a",
            "cudaq": importlib.metadata.version("cudaq"),
            "cudaq_algorithms": "official Git commit e46eea91",
            "qasmviz_optimization": 3,
            "rotation_synthesis_epsilon": EPSILON,
        },
        "benchmarks": results,
    }
    (OUTPUT / "results.json").write_text(json.dumps(payload, indent=2))
    write_tables(results)
    print("[verify] comparing output states", flush=True)
    run(
        [sys.executable, str(HERE / "verify_states.py")],
        extra_env={"QASM_DIR": str(qasm_dir)},
    )
    temporary_qasm.cleanup()


if __name__ == "__main__":
    main()
