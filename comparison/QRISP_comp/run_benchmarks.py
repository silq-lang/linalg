"""Build all three implementations and generate a common-basis resource table."""

from __future__ import annotations

import argparse
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
import time

from resource_evaluator import _find_quantum_session


HERE = Path(__file__).resolve().parent
PROJECT_ROOT = HERE.parents[1]
OUTPUT_DIR = HERE / "outputs"
QASM_DIR = OUTPUT_DIR / "qasm"
EPSILON = 1e-6

os.environ.setdefault("MPLCONFIGDIR", str(PROJECT_ROOT / ".mplconfig"))
os.environ.setdefault("XDG_CACHE_HOME", str(PROJECT_ROOT / ".cache"))

BENCHMARKS = [
    ("qft", "QFT on a generic product state, 5 qubits", "qft_slq.slq", "qft_Q", "qft_cudaq"),
    ("qpe", "QPE: pi/4 phase, superposed input, precision=3", "qpe_slq.slq", "qpe_Q", None),
    ("qae", "Amplitude estimation: Ry(pi/3), precision=5", "qae_slq.slq", "qae_Q", None),
    ("qq_adder", "Quantum-quantum addition, 4 bits", "qq_adder_slq.slq", "qq_adder_Q", "qq_adder_cudaq"),
    ("comparator", "Coherent comparison: 5-bit x < 6", "comparator_slq.slq", "comparator_Q", "comparator_cudaq"),
    ("pauli_evolution", "Two-term Pauli product formula, 5 qubits", "pauli_evolution_slq.slq", "pauli_evolution_Q", "pauli_evolution_cudaq"),
    ("controlled_phase", "Controlled phase: phi=pi/4, 5 qubits", "phase_slq.slq", "phase_Q", "phase_cudaq"),
    ("tridiagonal", "4x4 non-cyclic tridiagonal block encoding", "tridiag_slq.slq", "tridiag", "tridiag_cudaq"),
    ("tfim", "Two-qubit TFIM block encoding", "TFIM_slq.slq", "TFIM_Q", "TFIM_cudaq"),
    ("heisenberg", "Two-qubit Heisenberg block encoding", "Heisen_slq.slq", "Heisen_Q", "Heisen_cudaq"),
    ("chebyshev", "TFIM Chebyshev polynomial T_2", "cheby_slq.slq", "cheby_Q", "cheby_cudaq"),
    ("hamiltonian_simulation", "TFIM product formula: t=pi/4, 14 steps", "HS_slq.slq", "HS_Q", "HS_cudaq"),
    ("hamiltonian_simulation_qsp", "TFIM QSP simulation: t=pi/4, target degree 28", "HS_qsp_slq.slq", "HS_qsp_Q", "HS_qsp_cudaq"),
    ("matrix_inversion", "2x2 pseudoinverse: A=[[1,-1/3],[-1/3,1]], epsilon=0.02", "inv_slq.slq", "inv_Q", "inv_cudaq"),
    ("eigenstate_filter", "Eigenstate filter: lambda=0.65, degree 28", "filter_slq.slq", "filter_Q", None),
    ("hhl", "HHL: A=[[3/4,-1/4],[-1/4,3/4]], b=|1>, precision=3", "hhl_slq.slq", "hhl_Q", None),
    ("convolution", "Cubic convolution, one coherent attempt", "conv_slq.slq", "conv_Q", None),
    ("fourier_loader", "Fourier loader: 6 qubits, five modes", "fourier_slq.slq", "fourier_Q", None),
]


CIRCUIT_LEVEL = {
    "qft", "qpe", "qae", "qq_adder", "comparator", "pauli_evolution", "controlled_phase",
    "hamiltonian_simulation",
}

CUDAQ_UNAVAILABLE = {
    "qpe": "CUDA-Q Algorithms PhaseEstimation targets qubitization walks, not this arbitrary-unitary QPE row",
    "qae": "no CUDA-Q Algorithms amplitude-estimation primitive",
    "hhl": "no CUDA-Q Algorithms HHL circuit primitive",
    "convolution": "no CUDA-Q Algorithms convolution-state primitive",
    "fourier_loader": "CUDA-Q amplitude_encode is an opaque simulator state initializer, not an exportable gate circuit",
    "eigenstate_filter": "CUDA-Q Algorithms has QSVT but no built-in eigenstate-filter function or official filter-phase workflow",
}

# Normalization metadata for every row whose quantum process starts from a
# block encoding. Direct rows encode target / alpha. Transformation rows also
# report beta for the final good-subspace target / beta.
DIRECT_BLOCK_ENCODING_ALPHA = {
    "tridiagonal": 1.0,
    "tfim": 1.25,
    "heisenberg": 0.75,
}

TRANSFORM_INPUT_ALPHA = {
    "chebyshev": 1.25,
    "hamiltonian_simulation_qsp": 1.25,
    "matrix_inversion": 4.0 / 3.0,
    "eigenstate_filter": 2.0,
}

TRANSFORM_OUTPUT_BETA = {
    "chebyshev": {"silq": 1.0, "qrisp": 1.0, "cudaq": 1.0},
    "hamiltonian_simulation_qsp": {
        "silq": 1.0,
        "qrisp": 1.0,
        "cudaq": 2.0,
    },
    # Silq/Qrisp's matched degree-25 circuit gives A^-1|b>/beta; beta is
    # recovered from its verified good-subspace amplitude for this matrix and
    # |b>. CUDA-Q reports the CKS workflow's analytic 1/(scale * alpha).
    "matrix_inversion": {
        "silq": 3.61616147677523,
        "qrisp": 3.61616147677523,
        "cudaq": 2.1702640212459205,
    },
    "eigenstate_filter": {"silq": 1.01, "qrisp": 1.01},
}

NOTES = [
    "`T` includes T and T-dagger gates.",
    "Qrisp is compiled with the largest extra workspace that matches the final plain-Silq width. "
    "If Qrisp's workspace=0 circuit is already wider, workspace remains 0. The selected value is "
    "stored as `qrisp_workspace` in `outputs/results.json`.",
    "Operands of symmetric gates (cp, cz, swap) and the controls of ccx/ctrl(k) gates are sorted "
    "before costing, for all three frameworks; HQIR emits them in a run-dependent order and qasmviz's "
    "optimizer is order-sensitive. Fresh Silq compiles of the four largest task-level rows can "
    "still differ by a few percent (see README); --reuse-qasm is exactly reproducible.",
    "QQ adder: Silq uncomputes carries by measurement (mid-circuit measurement and feed-forward); "
    "Qrisp's gidney_adder and CUDA-Q Algorithms' add_register primitive uncompute unitarily. "
    "All three are costed in exact Clifford+T without "
    "qasmviz optimization, after merging directly adjacent phase gates on the same qubit.",
    "Full-state rows and the explicitly postselected logical outputs are checked by verify_states.py; "
    "the report is outputs/state_verification.json.",
    "Block-encoding rows apply the encoding to the same generic operand Ry(pi/7) x Ry(pi/9)|00>, "
    "so neither compiler can specialize to a known input.",
    "CUDA-Q QSVT Hamiltonian simulation and pseudoinversion use the public QSVT API plus the "
    "phase-generation workflows from NVIDIA's official repository examples, rather than the "
    "Silq/Qrisp polynomial. Their reported beta is the resulting subnormalization constant in "
    "target/beta. CUDA-Q eigenstate filtering is unavailable because NVIDIA provides no built-in "
    "filter or official phase workflow.",
    "For every block-encoding process, alpha is the encoded-input normalization "
    "(<0|U|0> = A/alpha). Transformation rows additionally report beta for the final "
    "good-subspace operation target/beta.",
    "CUDA-Q Hamiltonian simulation is NVIDIA's two-circuit cosine/sine workflow: width is the "
    "maximum component width, while depth and T count are summed across both circuits before "
    "classical recover_real_time_evolution.",
    "Multi-controlled gates (ctrl(k) @ g, k >= 2) are lowered with a Toffoli ladder on clean "
    "ancillas before costing, for all three frameworks; qasmviz's ancilla-free lowering would otherwise "
    "dominate the T count of whichever toolchain emits them.",
    "Task-level rows compare library implementations of the same mathematical operation; they do "
    "not isolate compiler lowering because the libraries can choose different decompositions. "
    "HHL's Silq-Qrisp ratio depends on qasmviz's optimizer; see README.",
    "CUDA-Q uses the CPU-only qpp-cpu target on macOS. Its column uses CUDA-Q core gates or public "
    "cudaq-algorithms 0.2.0rc1 primitives from pinned commit 4891dbe. A dash means that the package "
    "has no matching exportable circuit primitive; no hand-written substitute is reported.",
    "Full machine-readable results and gate breakdowns are in `outputs/results.json`.",
]


def run(command: list[str], *, stdin: str | None = None, timeout: int = 1800) -> str:
    process = subprocess.run(
        command,
        input=stdin,
        text=True,
        capture_output=True,
        cwd=PROJECT_ROOT,
        timeout=timeout,
        check=False,
        env={
            **os.environ,
            "MPLCONFIGDIR": str(PROJECT_ROOT / ".mplconfig"),
            "XDG_CACHE_HOME": str(PROJECT_ROOT / ".cache"),
        },
    )
    if process.returncode:
        raise RuntimeError(
            f"Command failed ({process.returncode}): {' '.join(command)}\n"
            f"stdout:\n{process.stdout}\nstderr:\n{process.stderr}"
        )
    return process.stdout


def export_qrisp(module_name: str, target_width: int | None = None) -> tuple[str, int, int]:
    """Export Qrisp with as much workspace as the Silq width budget permits."""
    module = importlib.import_module(module_name)
    result = module.build_program()
    session = _find_quantum_session(result)
    base_circuit = session.compile(workspace=0).transpile()
    base_width = base_circuit.num_qubits()
    workspace = max(0, (target_width or base_width) - base_width)
    circuit = (
        base_circuit
        if workspace == 0
        else session.compile(workspace=workspace).transpile()
    )
    return circuit.to_qasm3(), workspace, base_width


def _export_cudaq_kernel(module, kernel, *, component: str | None = None) -> str:
    """Export one CUDA-Q or CUDA-Q Algorithms kernel to static OpenQASM."""
    import cudaq
    from cudaq.kernel.kernel_decorator import PyKernelDecorator
    from qiskit import qasm2, qasm3

    arguments = module.kernel_arguments() if hasattr(module, "kernel_arguments") else ()
    if getattr(module, "USE_TRACE_EXPORT", False):
        from cudaq_trace_export import trace_to_qasm
        if hasattr(module, "trace_angles"):
            angles = module.trace_angles(component) if component else module.trace_angles()
        else:
            angles = ()
        return trace_to_qasm(kernel, *arguments, known_angles=angles)
    if arguments:
        kernel = cudaq.synthesize(kernel, *arguments)
    elif hasattr(kernel, "beta_reduction"):
        kernel.compile()
        specialized = kernel.beta_reduction(True)
        if not specialized.is_fully_specialized:
            raise RuntimeError("CUDA-Q kernel still has unresolved arguments")
        kernel = PyKernelDecorator(
            None,
            module=specialized.mlir_module,
            kernelName=specialized.name,
            decorator=kernel,
        )
    qasm_2 = cudaq.translate(kernel, format="openqasm2")
    return qasm3.dumps(qasm2.loads(qasm_2))


def export_cudaq(module_name: str) -> str:
    module = importlib.import_module(module_name)
    return _export_cudaq_kernel(module, module.build_kernel())


def export_cudaq_workflow(module_name: str) -> dict[str, str]:
    """Export every circuit in an official multi-circuit CUDA-Q workflow."""
    module = importlib.import_module(module_name)
    return {
        name: _export_cudaq_kernel(module, kernel, component=name)
        for name, kernel in module.build_kernels().items()
    }


def export_silq(source_name: str) -> tuple[str, int]:
    source = (HERE / source_name).read_text()
    compiler = shutil.which("silq") or "/Users/crc03/.local/bin/silq"
    hqir_text = run([compiler, "--compile", "--stdin"], stdin=source)

    # Silq commit 19b66448 emits a new name for the circuit-wrapper call.
    # HQIR commit ebf0128 still calls the same operation mfree_call. The only
    # occurrence is the compiler-provided wrap_circuit helper; benchmark code
    # does not use it directly. Remove this shim when HQIR accepts circuit_call.
    compatibility_rewrites = hqir_text.count("circuit_call[")
    hqir_text = hqir_text.replace("circuit_call[", "mfree_call[")

    qasm = run(
        ["hqir", "--stdin", "hqir", "-O3", "--flatten", "-R3", "--qasm"],
        stdin=hqir_text,
    )
    return qasm, compatibility_rewrites


SYMMETRIC_GATE = re.compile(r"^(\s*)(cp\([^)]*\)|cz|swap)\s+([^,;]+),\s*([^;]+);")
CONTROLLED_GATE = re.compile(
    r"^(\s*)(ccx|ctrl(?:\((\d+)\))?\s*@\s*[a-z]+(?:\([^)]*\))?)\s+([^;@]+);"
)
PHASE_GATE = re.compile(r"^(p\(([^)]*)\)|t|tdg|inv @ t|s|sdg|inv @ s|z)\s+([^,;]+);$")
PHASE_ANGLES = {
    "t": math.pi / 4, "tdg": -math.pi / 4, "inv @ t": -math.pi / 4,
    "s": math.pi / 2, "sdg": -math.pi / 2, "inv @ s": -math.pi / 2, "z": math.pi,
}


def canonicalize_symmetric_gates(qasm: str) -> str:
    """Sort the operands of symmetric gates and the controls of controlled gates.

    HQIR emits cp/cz operands and ccx/ctrl(k) controls in a run-dependent order. The gates are
    identical, but qasmviz's optimizer is order-sensitive, so the same circuit
    could receive different T counts. Sorting makes the cost deterministic and
    is applied to all three toolchains.
    """
    lines = []
    for line in qasm.splitlines():
        code = line.split("//")[0]
        match = SYMMETRIC_GATE.match(code)
        if match:
            first, second = sorted([match.group(3).strip(), match.group(4).strip()])
            line = f"{match.group(1)}{match.group(2)} {first}, {second};"
        elif match := CONTROLLED_GATE.match(code):
            # Controls of ccx / ctrl(k) @ g commute; HQIR also varies their order.
            operands = [q.strip() for q in match.group(4).split(",")]
            count = 2 if match.group(2) == "ccx" else int(match.group(3) or 1)
            if "gphase" in match.group(2):
                count = len(operands)
            operands = sorted(operands[:count]) + operands[count:]
            line = f"{match.group(1)}{match.group(2)} {', '.join(operands)};"
        lines.append(line)
    return "\n".join(lines) + "\n"


def merge_adjacent_phases(qasm: str) -> str:
    """Merge consecutive diagonal phase gates on the same qubit (exact peephole).

    The dynamic-circuit path cannot use qasmviz --opt, so adjacent pairs such as
    p(pi/4) p(-pi/4) would otherwise be counted as two T gates. Only directly
    adjacent top-level lines are merged; feed-forward blocks are left untouched.
    """
    def phase_of(line: str):
        if line[:1].isspace():
            return None
        match = PHASE_GATE.match(line.split("//")[0].strip())
        if not match:
            return None
        if match.group(2) is not None:
            angle = float(eval(match.group(2), {"pi": math.pi, "__builtins__": {}}))
        else:
            angle = PHASE_ANGLES[match.group(1)]
        return match.group(3).strip(), angle

    out: list[str] = []
    pending: tuple[str, float] | None = None

    def flush():
        if pending is not None:
            angle = math.remainder(pending[1], 2 * math.pi)
            if abs(angle) > 1e-12:
                out.append(f"p({angle!r}) {pending[0]};")

    for line in qasm.splitlines():
        phase = phase_of(line)
        if phase and pending and phase[0] == pending[0]:
            pending = (pending[0], pending[1] + phase[1])
            continue
        flush()
        pending = phase
        if phase is None:
            out.append(line)
    flush()
    return "\n".join(out) + "\n"


MULTI_CONTROLLED = re.compile(
    r"^(\s*)ctrl\((\d+)\)\s*@\s*([a-z]+)(\(([^)]*)\))?\s+([^;@]+);"
)
MC_ANCILLA = "_mc_anc"


def lower_multi_controlled(qasm: str) -> str:
    """Lower ctrl(k) @ g with k >= 2 using a Toffoli ladder on clean ancillas.

    qasmviz lowers these gates without ancillas, at a cost far above the
    standard construction (1905 T for one ctrl(3) @ x, 738 T for one
    ctrl(2) @ ry). HQIR leaves them to the backend, whereas Qrisp exports its
    own decomposition, so the common pipeline would otherwise penalize
    whichever toolchain emits high-level gates. The ancillas are declared as an
    extra register, are returned to |0>, and count toward width.
    """
    needed = 0

    def and_chain(controls: list[str], indent: str) -> tuple[str, list[str]]:
        nonlocal needed
        if len(controls) == 1:
            return controls[0], []
        ops, top = [], controls[0]
        for index, control in enumerate(controls[1:]):
            ancilla = f"{MC_ANCILLA}[{index}]"
            ops.append(f"{indent}ccx {top}, {control}, {ancilla};")
            top = ancilla
        needed = max(needed, len(controls) - 1)
        return top, ops

    lines = []
    for line in qasm.splitlines():
        match = MULTI_CONTROLLED.match(line.split("//")[0])
        if not match or int(match.group(2)) < 2:
            lines.append(line)
            continue
        indent, count, gate = match.group(1), int(match.group(2)), match.group(3)
        params, param_text = match.group(4) or "", match.group(5)
        operands = [q.strip() for q in match.group(6).split(",")]
        controls, targets = operands[:count], operands[count:]
        if gate == "gphase":
            angle = float(eval(param_text, {"pi": math.pi, "__builtins__": {}}))
            if abs(math.remainder(angle, 2 * math.pi)) < 1e-12:
                continue
            top, ops = and_chain(controls[:-1], indent)
            body = [f"{indent}cp({param_text}) {top}, {controls[-1]};"]
        elif gate == "x":
            top, ops = and_chain(controls[:-1], indent)
            body = [f"{indent}ccx {top}, {controls[-1]}, {targets[0]};"]
        else:
            top, ops = and_chain(controls, indent)
            body = [f"{indent}ctrl(1) @ {gate}{params} {top}, {', '.join(targets)};"]
        lines.extend(ops + body + ops[::-1])

    if not needed:
        return "\n".join(lines) + "\n"
    declarations = [i for i, line in enumerate(lines) if re.match(r"\s*(qubit|qreg)\b", line)]
    lines.insert(declarations[-1] + 1, f"qubit[{needed}] {MC_ANCILLA};")
    return "\n".join(lines) + "\n"


def common_metrics(qasm: str) -> dict:
    qasm = lower_multi_controlled(canonicalize_symmetric_gates(qasm))
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
        stdin=qasm,
    )
    marker = output.rfind('\n{\n  "width"')
    if marker < 0:
        marker = output.find('{\n  "width"')
    if marker < 0:
        raise RuntimeError(f"Could not locate qasmviz JSON in:\n{output}")
    return json.loads(output[marker + (1 if output[marker] == "\n" else 0):])


def dynamic_clifford_t_metrics(qasm: str) -> dict:
    """Cost an already-Clifford+T dynamic circuit without removing feed-forward."""
    qasm = merge_adjacent_phases(canonicalize_symmetric_gates(qasm))
    output = run(["qasmviz", "--cost", "--json"], stdin=qasm)
    marker = output.rfind('\n{\n  "width"')
    if marker < 0:
        marker = output.find('{\n  "width"')
    if marker < 0:
        raise RuntimeError(f"Could not locate qasmviz JSON in:\n{output}")
    metric = json.loads(output[marker + (1 if output[marker] == "\n" else 0):])
    rotations = metric.get("rotations", {})
    gates = metric.get("gates", {}).get("gates", {})
    metric["t-count"] = (
        rotations.get("t-count", 0) + gates.get("t", 0) + gates.get("tdg", 0)
    )
    return metric


def annotate_block_encoding_normalization(entry: dict) -> None:
    benchmark_id = entry["id"]
    if benchmark_id in DIRECT_BLOCK_ENCODING_ALPHA:
        alpha = DIRECT_BLOCK_ENCODING_ALPHA[benchmark_id]
        for framework in ("silq", "qrisp", "cudaq"):
            if entry.get(framework) is not None:
                entry[framework]["block_encoding_normalization"] = alpha
    if benchmark_id in TRANSFORM_INPUT_ALPHA:
        alpha = TRANSFORM_INPUT_ALPHA[benchmark_id]
        betas = TRANSFORM_OUTPUT_BETA[benchmark_id]
        for framework in ("silq", "qrisp", "cudaq"):
            if entry.get(framework) is None:
                continue
            entry[framework]["input_block_encoding_normalization"] = alpha
            if framework in betas:
                entry[framework]["subnormalization"] = betas[framework]


def normalization_cell(metric: dict | None, *, tex: bool = False) -> str:
    if metric is None:
        return r"\textemdash" if tex else "—"
    parts = []
    if "block_encoding_normalization" in metric:
        label = r"\alpha" if tex else "α"
        parts.append(f"{label}={metric['block_encoding_normalization']:.6g}")
    if "input_block_encoding_normalization" in metric:
        label = r"\alpha_{\rm in}" if tex else "α_in"
        parts.append(f"{label}={metric['input_block_encoding_normalization']:.6g}")
    if "subnormalization" in metric:
        label = r"\beta" if tex else "β"
        parts.append(f"{label}={metric['subnormalization']:.6g}")
    if not parts:
        return r"\textemdash" if tex else "—"
    if tex:
        return r"$\substack{" + r"\\".join(parts) + r"}$"
    return ", ".join(parts)


def metric_cell(metric: dict | None) -> str:
    if metric is None:
        return "—"
    value = (
        f"width={metric['width']}, depth={metric['depth']}, "
        f"T={metric.get('t-count', 0)}"
    )
    normalization = normalization_cell(metric)
    if normalization != "—":
        value += f", {normalization}"
    return value


def metric_cells_tex(metric: dict | None) -> str:
    if metric is None:
        return r"\multicolumn{4}{c}{\textemdash}"
    return (
        f"{metric['width']} & {metric['depth']} & {metric.get('t-count', 0)} & "
        f"{normalization_cell(metric, tex=True)}"
    )


def aggregate_workflow_metrics(components: dict[str, dict]) -> dict:
    """Sequential cost of a documented multi-circuit classical workflow."""
    return {
        "width": max(metric["width"] for metric in components.values()),
        "depth": sum(metric["depth"] for metric in components.values()),
        "t-count": sum(metric.get("t-count", 0) for metric in components.values()),
        "aggregation": "maximum width; summed depth and T count",
        "components": components,
    }


def escape_tex(value: str) -> str:
    return value.replace("_", r"\_")


TEX_DESCRIPTIONS = {
    "qft": r"QFT (5 qubits)",
    "qpe": r"QPE ($\phi=\pi/4$, precision 3)",
    "qae": r"QAE ($R_y(\pi/3)$, precision 5)",
    "qq_adder": r"Quantum--quantum addition (4 bits)",
    "comparator": r"Coherent comparator ($x<6$, 5-bit input)",
    "pauli_evolution": r"Two-term Pauli product formula (5 qubits)",
    "controlled_phase": r"Controlled phase ($\phi=\pi/4$, 5 qubits)",
    "hamiltonian_simulation": r"TFIM product formula ($t=\pi/4$, 14 steps)",
    "tridiagonal": r"Tridiagonal block encoding ($4\times4$)",
    "tfim": r"TFIM block encoding (2 qubits)",
    "heisenberg": r"Heisenberg block encoding (2 qubits)",
    "chebyshev": r"TFIM Chebyshev polynomial $T_2$",
    "hamiltonian_simulation_qsp": r"TFIM QSP simulation ($t=\pi/4$, target degree 28)",
    "matrix_inversion": r"Pseudoinverse ($\epsilon=0.02$)",
    "eigenstate_filter": r"Eigenstate filter ($\lambda=0.65$, degree 28)",
    "hhl": r"HHL ($A=\left[\begin{smallmatrix}3/4&-1/4\\-1/4&3/4\end{smallmatrix}\right]$, $b=\lvert1\rangle$, precision 3)",
    "convolution": r"Cubic convolution (one coherent attempt)",
    "fourier_loader": r"Fourier loader (6 qubits, five modes)",
}


def write_tables(results: list[dict]) -> None:
    markdown = [
        "# Silq-Qrisp-CUDA-Q library resource comparison",
        "",
        f"Unitary rows use qasmviz Clifford+T synthesis (`--opt 3 --eps {EPSILON}`).",
        "The QQ-adder row retains mid-circuit measurement/feed-forward and is costed in its exact Clifford+T form.",
        "Only plain Silq source is included; there is no hand-optimized Silq column.",
        "",
        "| Benchmark | Silq | Qrisp (width-matched workspace) | CUDA-Q |",
        "|---|---:|---:|---:|",
    ]
    for section, rows in (
        ("Circuit-level compiler comparisons", [r for r in results if r["id"] in CIRCUIT_LEVEL]),
        ("Task-level library comparisons", [r for r in results if r["id"] not in CIRCUIT_LEVEL]),
    ):
        if not rows:
            continue
        markdown.append(f"| **{section}** | | | |")
        for result in rows:
            markdown.append(
                f"| {result['description']} | {metric_cell(result.get('silq'))} | "
                f"{metric_cell(result.get('qrisp'))} | {metric_cell(result.get('cudaq'))} |"
            )
    markdown.append("")
    markdown.extend(f"- {note}" for note in NOTES)
    markdown.append("")
    (HERE / "table.md").write_text("\n".join(markdown))

    tex = [
        r"\begin{table}[h]",
        r"\centering",
        r"\caption{Resource comparison between plain Silq, Qrisp, and CUDA-Q implementations.}",
        r"\label{tab:silq-qrisp-fair}",
        r"\small",
        r"\setlength{\tabcolsep}{3pt}",
        r"\renewcommand{\arraystretch}{1.1}",
        "",
        r"\begin{tabularx}{\columnwidth}{",
        r"    >{\raggedright\arraybackslash}X",
        r"    *{3}{",
        r"      >{\centering\arraybackslash}p{0.042\columnwidth}",
        r"      >{\centering\arraybackslash}p{0.052\columnwidth}",
        r"      >{\centering\arraybackslash}p{0.046\columnwidth}",
        r"      >{\centering\arraybackslash}p{0.086\columnwidth}",
        r"    }",
        r"}",
        r"    & \multicolumn{4}{c}{Plain Silq}",
        r"    & \multicolumn{4}{c}{Qrisp (width matched)}",
        r"    & \multicolumn{4}{c}{CUDA-Q} \\",
        "",
        r"Benchmark",
        r"    & width & depth & T-count & norm.",
        r"    & width & depth & T-count & norm.",
        r"    & width & depth & T-count & norm. \\",
        "",
        r"\cmidrule(lr){2-5}",
        r"\cmidrule(lr){6-9}",
        r"\cmidrule(lr){10-13}",
        "",
    ]
    for section, rows in (
        ("Circuit-level compiler comparisons", [r for r in results if r["id"] in CIRCUIT_LEVEL]),
        ("Task-level library comparisons", [r for r in results if r["id"] not in CIRCUIT_LEVEL]),
    ):
        if not rows:
            continue
        tex.extend([rf"\multicolumn{{13}}{{l}}{{\textit{{{section}}}}} \\", ""])
        for result in rows:
            tex.extend([
                f"{TEX_DESCRIPTIONS.get(result['id'], escape_tex(result['description']))} & "
                f"{metric_cells_tex(result.get('silq'))} & "
                f"{metric_cells_tex(result.get('qrisp'))} & "
                f"{metric_cells_tex(result.get('cudaq'))} \\\\",
                "",
            ])
    tex.extend([
        r"\end{tabularx}",
        r"\end{table}",
        "",
    ])
    tex_text = "\n".join(tex)
    (HERE / "table.tex").write_text(tex_text)
    (HERE / "table_styled.tex").write_text(tex_text)


def tool_versions() -> dict:
    compiler = shutil.which("silq") or "/Users/crc03/.local/bin/silq"
    help_process = subprocess.run([compiler, "--help"], text=True, capture_output=True, check=False)
    silq_help = help_process.stdout + help_process.stderr
    silq_build = [line for line in silq_help.splitlines() if line.startswith(("Build:", "Commit:"))]
    return {
        "python": sys.version.split()[0],
        "qrisp": importlib.metadata.version("qrisp"),
        "cudaq": importlib.metadata.version("cudaq"),
        "cudaq_algorithms": importlib.metadata.version("cudaq-algorithms"),
        "cudaq_algorithms_commit": "4891dbe62c0baeac4569bf608562ffee59635cca",
        "qsppack": importlib.metadata.version("qsppack"),
        "qiskit": importlib.metadata.version("qiskit"),
        "silq": silq_build,
        "hqir_executable": shutil.which("hqir"),
        "qasmviz_executable": shutil.which("qasmviz"),
        "common_target": "Clifford+T",
        "qasmviz_optimization": 3,
        "rotation_synthesis_epsilon": EPSILON,
    }


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("--only", action="append", default=[], help="benchmark id to run")
    parser.add_argument(
        "--reuse-qasm",
        action="store_true",
        help="reuse previously exported QASM and rerun only common-basis metrics",
    )
    args = parser.parse_args()

    OUTPUT_DIR.mkdir(exist_ok=True)
    QASM_DIR.mkdir(exist_ok=True)
    selected = set(args.only)
    previous = {}
    results_path = OUTPUT_DIR / "results.json"
    if results_path.exists():
        # Keep metadata for reused QASM and preserve unselected rows for --only.
        previous = {r["id"]: r for r in json.loads(results_path.read_text())["benchmarks"]}
    results = []

    for benchmark_id, description, silq_file, qrisp_module, cudaq_module in BENCHMARKS:
        if selected and benchmark_id not in selected:
            if benchmark_id in previous:
                results.append(previous[benchmark_id])
            continue
        print(f"[{benchmark_id}] exporting Silq", flush=True)
        entry = {"id": benchmark_id, "description": description}
        metric_function = dynamic_clifford_t_metrics if benchmark_id == "qq_adder" else common_metrics
        started = time.monotonic()
        try:
            silq_path = QASM_DIR / f"{benchmark_id}_silq.qasm"
            if args.reuse_qasm:
                silq_qasm = silq_path.read_text()
                rewrites = None
            else:
                silq_qasm, rewrites = export_silq(silq_file)
                silq_path.write_text(silq_qasm)
            entry["silq"] = metric_function(silq_qasm)
            entry["silq_compatibility_rewrites"] = rewrites
        except Exception as exc:
            entry["silq_error"] = str(exc)

        print(f"[{benchmark_id}] exporting Qrisp", flush=True)
        try:
            qrisp_path = QASM_DIR / f"{benchmark_id}_qrisp.qasm"
            if args.reuse_qasm:
                qrisp_qasm = qrisp_path.read_text()
                entry["qrisp_workspace"] = previous.get(benchmark_id, {}).get(
                    "qrisp_workspace", 0
                )
            else:
                silq_width = entry.get("silq", {}).get("width")
                qrisp_qasm, workspace, base_width = export_qrisp(
                    qrisp_module, target_width=silq_width
                )
                entry["qrisp_workspace"] = workspace
                entry["qrisp_width_workspace_0"] = base_width
                qrisp_path.write_text(qrisp_qasm)
            entry["qrisp"] = metric_function(qrisp_qasm)
            if (
                entry.get("silq")
                and entry["qrisp_workspace"] > 0
                and entry["qrisp"]["width"] > entry["silq"]["width"]
            ):
                raise RuntimeError(
                    "Qrisp workspace exceeded the Silq final-width budget: "
                    f"{entry['qrisp']['width']} > {entry['silq']['width']}"
                )
        except Exception as exc:
            entry["qrisp_error"] = str(exc)

        print(f"[{benchmark_id}] exporting CUDA-Q", flush=True)
        if benchmark_id in CUDAQ_UNAVAILABLE:
            entry["cudaq_unavailable"] = True
            entry["cudaq_unavailable_reason"] = CUDAQ_UNAVAILABLE[benchmark_id]
            if not args.reuse_qasm:
                (QASM_DIR / f"{benchmark_id}_cudaq.qasm").unlink(missing_ok=True)
        else:
            try:
                cudaq_python = importlib.import_module(cudaq_module)
                component_names = tuple(
                    getattr(cudaq_python, "WORKFLOW_COMPONENTS", ())
                )
                if component_names:
                    if args.reuse_qasm:
                        component_qasm = {
                            name: (QASM_DIR / f"{benchmark_id}_cudaq_{name}.qasm").read_text()
                            for name in component_names
                        }
                    else:
                        component_qasm = export_cudaq_workflow(cudaq_module)
                        for name, qasm in component_qasm.items():
                            (QASM_DIR / f"{benchmark_id}_cudaq_{name}.qasm").write_text(qasm)
                        (QASM_DIR / f"{benchmark_id}_cudaq.qasm").unlink(missing_ok=True)
                    component_metrics = {
                        name: metric_function(qasm)
                        for name, qasm in component_qasm.items()
                    }
                    entry["cudaq"] = aggregate_workflow_metrics(component_metrics)
                    entry["cudaq_workflow_components"] = list(component_names)
                else:
                    cudaq_path = QASM_DIR / f"{benchmark_id}_cudaq.qasm"
                    if args.reuse_qasm:
                        cudaq_qasm = cudaq_path.read_text()
                    else:
                        cudaq_qasm = export_cudaq(cudaq_module)
                        cudaq_path.write_text(cudaq_qasm)
                    entry["cudaq"] = metric_function(cudaq_qasm)
                if hasattr(cudaq_python, "subnormalization_constant"):
                    entry["cudaq"]["subnormalization"] = float(
                        cudaq_python.subnormalization_constant()
                    )
                if hasattr(cudaq_python, "workflow_metadata"):
                    entry["cudaq_workflow"] = cudaq_python.workflow_metadata()
            except Exception as exc:
                entry["cudaq_error"] = str(exc)

        entry["elapsed_seconds"] = round(time.monotonic() - started, 3)
        annotate_block_encoding_normalization(entry)
        results.append(entry)
        (OUTPUT_DIR / "results.json").write_text(json.dumps({
            "tools": tool_versions(),
            "benchmarks": results,
        }, indent=2))
        write_tables(results)

    # Add normalization metadata to rows carried over by --only as well.
    for entry in results:
        annotate_block_encoding_normalization(entry)
    # Rows carried over by --only after the last processed row are only in memory.
    (OUTPUT_DIR / "results.json").write_text(json.dumps({
        "tools": tool_versions(),
        "benchmarks": results,
    }, indent=2))
    write_tables(results)

    failures = [
        r["id"] for r in results
        if "silq" not in r or "qrisp" not in r
        or (r["id"] not in CUDAQ_UNAVAILABLE and "cudaq" not in r)
    ]
    if failures:
        raise SystemExit(f"Failed benchmarks: {', '.join(failures)}")


if __name__ == "__main__":
    main()
