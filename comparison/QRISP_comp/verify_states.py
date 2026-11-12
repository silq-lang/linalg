"""Compare exported Silq, Qrisp, and CUDA-Q output states."""

from __future__ import annotations

import argparse
import cmath
import itertools
import json
from pathlib import Path
import subprocess

from run_benchmarks import BENCHMARKS, QASM_DIR


TOLERANCE = 1e-8
# CUDA-Q's OpenQASM exporter rounds every angle to roughly six decimal
# places.  The error can accumulate across a long QSVT sequence, so allow two
# units of the configured 1e-6 synthesis/export precision while retaining the
# independent near-unit-fidelity guard below.
CUDAQ_TOLERANCE = 2e-6

# These rows define their algorithmic output on the all-zero signal/ancilla
# branch. The qubit indices are explicit compiler-output layouts, not values
# discovered by searching for a convenient matching branch.
POSTSELECT_LAYOUTS = {
    "tridiagonal": {"silq": (2, 3), "qrisp": (0, 1)},
    "tfim": {"silq": (2, 3), "qrisp": (0, 1)},
    "heisenberg": {"silq": (2, 3), "qrisp": (0, 1)},
    "chebyshev": {"silq": (2, 3), "qrisp": (0, 1)},
    "hamiltonian_simulation_qsp": {"silq": (3, 4), "qrisp": (0, 1)},
    "matrix_inversion": {"silq": (3,), "qrisp": (0,)},
    "eigenstate_filter": {"silq": (3,), "qrisp": (0,)},
    "convolution": {"silq": (1, 2), "qrisp": (0, 1)},
    "fourier_loader": {"silq": (0, 1, 2, 3, 4, 5), "qrisp": (0, 1, 2, 3, 4, 5)},
}

# Explicit Qrisp/CUDA-Q logical registers in the exported QASM. Every other
# wire is required to be zero. CUDA-Q's translator can prepend clean work
# qubits when lowering multi-controlled operations, hence the shifted layouts.
CUDAQ_LAYOUTS = {
    "qft": {"qrisp": (0, 1, 2, 3, 4), "cudaq": (0, 1, 2, 3, 4)},
    "qq_adder": {"qrisp": tuple(range(8)), "cudaq": tuple(range(8))},
    # cmp_ge_constant allocates value[0:5], work[5:10], carry[10], flag[11].
    "comparator": {"qrisp": tuple(range(6)), "cudaq": (0, 1, 2, 3, 4, 11)},
    "pauli_evolution": {"qrisp": tuple(range(5)), "cudaq": tuple(range(5))},
    "controlled_phase": {"qrisp": tuple(range(5)), "cudaq": (3, 4, 5, 6, 7)},
    "tridiagonal": {"qrisp": (0, 1), "cudaq": (0, 1)},
    "tfim": {"qrisp": (0, 1), "cudaq": (0, 1)},
    "heisenberg": {"qrisp": (0, 1), "cudaq": (0, 1)},
    "chebyshev": {"qrisp": (0, 1), "cudaq": (0, 1)},
    "hamiltonian_simulation": {"qrisp": (0, 1), "cudaq": (0, 1)},
    "hamiltonian_simulation_qsp": {"qrisp": (0, 1), "cudaq": (0, 1)},
    "matrix_inversion": {"qrisp": (0,), "cudaq": (0,)},
}

# Retain a fidelity guard for approximate algorithmic rows.
MIN_LOGICAL_FIDELITY = 0.999


def simulate(path: Path, *, prefer_explicit_lowering: bool = True) -> dict[str, complex]:
    # Prefer the explicit CX/U lowering. qasmviz's generic-operation simulator
    # can discard phases attached to composite controlled gates; those phases
    # become observable when a block encoding is controlled inside QSP.
    commands = [
        ["qasmviz", str(path), "--cx-u", "--run", "--json"],
        ["qasmviz", str(path), "--run", "--json"],
    ]
    if not prefer_explicit_lowering:
        commands.reverse()
    errors = []
    for command in commands:
        process = subprocess.run(command, text=True, capture_output=True, check=False)
        if process.returncode:
            errors.append(process.stderr.strip())
            continue
        payload = json.loads(process.stdout[process.stdout.find("{"):])
        return {
            item["basis"]: complex(item["re"], item["im"])
            for item in payload["statevector"]
            if abs(complex(item["re"], item["im"])) > TOLERANCE
        }
    raise RuntimeError("; ".join(errors))


def remove_clean_zero_qubits(state: dict[str, complex]) -> tuple[dict[str, complex], list[int]]:
    width = len(next(iter(state)))
    active = [index for index in range(width) if any(bits[index] == "1" for bits in state)]
    reduced: dict[str, complex] = {}
    for bits, amplitude in state.items():
        key = "".join(bits[index] for index in active)
        reduced[key] = reduced.get(key, 0j) + amplitude
    return reduced, active


def probability_signatures(state: dict[str, complex], width: int) -> list[tuple[float, tuple[float, ...]]]:
    probabilities = {bits: abs(amplitude) ** 2 for bits, amplitude in state.items()}
    one = [sum(prob for bits, prob in probabilities.items() if bits[i] == "1") for i in range(width)]
    signatures = []
    for i in range(width):
        pair = sorted(
            sum(prob for bits, prob in probabilities.items() if bits[i] == bits[j] == "1")
            for j in range(width)
            if j != i
        )
        signatures.append((one[i], tuple(pair)))
    return signatures


def close_signature(left, right, tolerance: float) -> bool:
    return abs(left[0] - right[0]) <= tolerance and all(
        abs(a - b) <= tolerance for a, b in zip(left[1], right[1])
    )


def state_error(
    silq: dict[str, complex], qrisp: dict[str, complex], permutation: tuple[int, ...]
) -> float:
    mapped = {
        "".join(bits[index] for index in permutation): amplitude
        for bits, amplitude in qrisp.items()
    }
    keys = set(silq) | set(mapped)
    overlap = sum(mapped.get(key, 0j).conjugate() * silq.get(key, 0j) for key in keys)
    phase = overlap / abs(overlap) if abs(overlap) > TOLERANCE else 1
    return max(abs(silq.get(key, 0j) - phase * mapped.get(key, 0j)) for key in keys)


def find_permutation(
    silq: dict[str, complex], qrisp: dict[str, complex], tolerance: float
) -> tuple[tuple[int, ...] | None, float, int]:
    width = len(next(iter(silq)))
    if width != len(next(iter(qrisp))):
        return None, float("inf"), 0
    silq_signatures = probability_signatures(silq, width)
    qrisp_signatures = probability_signatures(qrisp, width)
    candidates = [
        [j for j in range(width) if close_signature(silq_signatures[i], qrisp_signatures[j], tolerance)]
        for i in range(width)
    ]
    order = sorted(range(width), key=lambda index: len(candidates[index]))
    assignment = [-1] * width
    checked = 0
    best_error = float("inf")
    best_permutation = None

    def search(level: int, used: set[int]) -> bool:
        nonlocal checked, best_error, best_permutation
        if level == width:
            checked += 1
            permutation = tuple(assignment)
            error = state_error(silq, qrisp, permutation)
            if error < best_error:
                best_error = error
                best_permutation = permutation
            return error <= tolerance
        silq_index = order[level]
        for qrisp_index in candidates[silq_index]:
            if qrisp_index in used:
                continue
            assignment[silq_index] = qrisp_index
            if search(level + 1, used | {qrisp_index}):
                return True
        assignment[silq_index] = -1
        return False

    search(0, set())
    return best_permutation, best_error, checked


def zero_postselected_branch(state: dict[str, complex], logical: tuple[int, ...]):
    width = len(next(iter(state)))
    rest = tuple(index for index in range(width) if index not in logical)
    branch: dict[str, complex] = {}
    for bits, amplitude in state.items():
        if any(bits[index] != "0" for index in rest):
            continue
        key = "".join(bits[index] for index in logical)
        branch[key] = branch.get(key, 0j) + amplitude
    probability = sum(abs(amplitude) ** 2 for amplitude in branch.values())
    if probability <= TOLERANCE:
        raise ValueError(f"zero postselection has probability {probability}")
    scale = probability**0.5
    return {key: amplitude / scale for key, amplitude in branch.items()}, probability, rest


def best_logical_match(silq: dict[str, complex], qrisp: dict[str, complex]):
    width = len(next(iter(silq)))
    best = None
    for permutation in itertools.permutations(range(width)):
        mapped = {
            "".join(bits[index] for index in permutation): amplitude
            for bits, amplitude in qrisp.items()
        }
        keys = set(silq) | set(mapped)
        overlap = sum(silq.get(key, 0j).conjugate() * mapped.get(key, 0j) for key in keys)
        fidelity = abs(overlap) ** 2
        phase = overlap.conjugate() / abs(overlap) if abs(overlap) > TOLERANCE else 1
        error = max(abs(silq.get(key, 0j) - phase * mapped.get(key, 0j)) for key in keys)
        candidate = (fidelity, -error)
        if best is None or candidate > best[0]:
            best = (candidate, permutation, error)
    return best[0][0], best[1], best[2]


def compare_postselected(silq_full, qrisp_full, layout):
    silq, silq_probability, silq_rest = zero_postselected_branch(
        silq_full, layout["silq"]
    )
    qrisp, qrisp_probability, qrisp_rest = zero_postselected_branch(
        qrisp_full, layout["qrisp"]
    )
    fidelity, permutation, error = best_logical_match(silq, qrisp)
    return {
        "passed": fidelity >= MIN_LOGICAL_FIDELITY,
        "fidelity": fidelity,
        "max_normalized_amplitude_error": error,
        "silq_success_probability": silq_probability,
        "qrisp_success_probability": qrisp_probability,
        "silq_logical_qubits": layout["silq"],
        "silq_postselect_qubits": silq_rest,
        "qrisp_logical_qubits": layout["qrisp"],
        "qrisp_postselect_qubits": qrisp_rest,
        "logical_wire_permutation": permutation,
    }


def compare_cudaq(qrisp_full, cudaq_full, layout):
    qrisp, qrisp_probability, qrisp_rest = zero_postselected_branch(
        qrisp_full, layout["qrisp"]
    )
    cudaq, cudaq_probability, cudaq_rest = zero_postselected_branch(
        cudaq_full, layout["cudaq"]
    )
    fidelity, permutation, error = best_logical_match(qrisp, cudaq)
    return {
        "passed": fidelity >= 1 - 1e-10 and error <= CUDAQ_TOLERANCE,
        "fidelity": fidelity,
        "max_normalized_amplitude_error": error,
        "qrisp_success_probability": qrisp_probability,
        "cudaq_success_probability": cudaq_probability,
        "qrisp_logical_qubits": layout["qrisp"],
        "qrisp_postselect_qubits": qrisp_rest,
        "cudaq_logical_qubits": layout["cudaq"],
        "cudaq_postselect_qubits": cudaq_rest,
        "logical_wire_permutation": permutation,
    }


def raw_zero_branch(state: dict[str, complex], logical: tuple[int, ...]):
    width = len(next(iter(state)))
    rest = tuple(index for index in range(width) if index not in logical)
    branch: dict[str, complex] = {}
    for bits, amplitude in state.items():
        if any(bits[index] != "0" for index in rest):
            continue
        key = "".join(bits[index] for index in logical)
        branch[key] = branch.get(key, 0j) + amplitude
    return branch, rest


def normalize_state(state: dict[str, complex]):
    norm_squared = sum(abs(amplitude) ** 2 for amplitude in state.values())
    if norm_squared <= TOLERANCE:
        raise ValueError(f"recovered state has norm squared {norm_squared}")
    norm = norm_squared**0.5
    return {key: value / norm for key, value in state.items()}, norm_squared


def compare_recovered_workflow(qrisp_full, recovered, qrisp_logical, metadata):
    qrisp, qrisp_probability, qrisp_rest = zero_postselected_branch(
        qrisp_full, qrisp_logical
    )
    cudaq, recovered_norm_squared = normalize_state(recovered)
    fidelity, permutation, error = best_logical_match(qrisp, cudaq)
    return {
        "passed": fidelity >= MIN_LOGICAL_FIDELITY,
        "comparison_kind": "classically_recovered_official_workflow",
        "fidelity": fidelity,
        "max_normalized_amplitude_error": error,
        "qrisp_success_probability": qrisp_probability,
        "qrisp_logical_qubits": qrisp_logical,
        "qrisp_postselect_qubits": qrisp_rest,
        "recovered_vector_norm_squared": recovered_norm_squared,
        "logical_wire_permutation": permutation,
        **metadata,
    }


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("--only", action="append", default=[])
    parser.add_argument("--tolerance", type=float, default=TOLERANCE)
    args = parser.parse_args()
    selected = set(args.only)
    failed = False
    reports = []
    for benchmark_id, description, *_ in BENCHMARKS:
        if selected and benchmark_id not in selected:
            continue
        print(f"[{benchmark_id}] simulating", flush=True)
        try:
            silq_full = simulate(QASM_DIR / f"{benchmark_id}_silq.qasm")
            qrisp_full = simulate(QASM_DIR / f"{benchmark_id}_qrisp.qasm")
            silq, silq_active = remove_clean_zero_qubits(silq_full)
            qrisp, qrisp_active = remove_clean_zero_qubits(qrisp_full)
            permutation, error, checked = find_permutation(silq, qrisp, args.tolerance)
            full_state_equivalent = permutation is not None and error <= args.tolerance
            report = {
                "id": benchmark_id,
                "description": description,
                "full_state_equivalent": full_state_equivalent,
                "full_state_max_amplitude_error": error,
                "silq_width": len(next(iter(silq_full))),
                "qrisp_width": len(next(iter(qrisp_full))),
                "silq_active_qubits": silq_active,
                "qrisp_active_qubits": qrisp_active,
                "logical_wire_permutation": permutation,
                "permutations_checked": checked,
            }
            if benchmark_id in POSTSELECT_LAYOUTS:
                report["comparison_kind"] = "postselected_logical_state"
                report["postselected_comparison"] = compare_postselected(
                    silq_full, qrisp_full, POSTSELECT_LAYOUTS[benchmark_id]
                )
                passed = report["postselected_comparison"]["passed"]
            else:
                report["comparison_kind"] = "full_coherent_state"
                passed = full_state_equivalent
            cudaq_path = QASM_DIR / f"{benchmark_id}_cudaq.qasm"
            if benchmark_id == "hamiltonian_simulation_qsp":
                import HS_qsp_cudaq as cudaq_workflow

                cos_full = simulate(
                    QASM_DIR / f"{benchmark_id}_cudaq_cos.qasm",
                    prefer_explicit_lowering=False,
                )
                sin_full = simulate(
                    QASM_DIR / f"{benchmark_id}_cudaq_sin.qasm",
                    prefer_explicit_lowering=False,
                )
                cos_branch, cos_rest = raw_zero_branch(cos_full, (0, 1))
                sin_branch, sin_rest = raw_zero_branch(sin_full, (0, 1))
                cos_phase = cmath.exp(-1j * sum(cudaq_workflow.COS_PHASES))
                sin_phase = cmath.exp(-1j * sum(cudaq_workflow.SIN_PHASES))
                keys = set(cos_branch) | set(sin_branch)
                recovered = {
                    key: 2.0 * (
                        (cos_phase * cos_branch.get(key, 0j)).real
                        + 1j * (sin_phase * sin_branch.get(key, 0j)).imag
                    )
                    for key in keys
                }
                report["cudaq_width"] = max(
                    len(next(iter(cos_full))), len(next(iter(sin_full)))
                )
                report["cudaq_comparison"] = compare_recovered_workflow(
                    qrisp_full,
                    recovered,
                    CUDAQ_LAYOUTS[benchmark_id]["qrisp"],
                    {
                        "cudaq_component_postselect_qubits": {
                            "cos": cos_rest,
                            "sin": sin_rest,
                        },
                        "cudaq_component_success_probabilities": {
                            "cos": sum(abs(value) ** 2 for value in cos_branch.values()),
                            "sin": sum(abs(value) ** 2 for value in sin_branch.values()),
                        },
                        "cudaq_subnormalization": cudaq_workflow.subnormalization_constant(),
                    },
                )
                passed = passed and report["cudaq_comparison"]["passed"]
            elif benchmark_id == "matrix_inversion" and cudaq_path.exists():
                import inv_cudaq as cudaq_workflow

                cudaq_full = simulate(cudaq_path, prefer_explicit_lowering=True)
                branch, cudaq_rest = raw_zero_branch(cudaq_full, (0,))
                phase = cmath.exp(-1j * sum(cudaq_workflow.PHASES))
                recovered = {
                    key: complex((phase * amplitude).real, 0.0)
                    for key, amplitude in branch.items()
                }
                report["cudaq_width"] = len(next(iter(cudaq_full)))
                report["cudaq_comparison"] = compare_recovered_workflow(
                    qrisp_full,
                    recovered,
                    CUDAQ_LAYOUTS[benchmark_id]["qrisp"],
                    {
                        "cudaq_postselect_qubits": cudaq_rest,
                        "cudaq_raw_success_probability": sum(
                            abs(value) ** 2 for value in branch.values()
                        ),
                        "cudaq_subnormalization": cudaq_workflow.subnormalization_constant(),
                    },
                )
                passed = passed and report["cudaq_comparison"]["passed"]
            elif benchmark_id in CUDAQ_LAYOUTS and cudaq_path.exists():
                # The CUDA-Q Algorithms QASM is reconstructed from CUDA-Q's
                # fully expanded execution trace. Its high-level controlled
                # gates simulate exactly as written; decomposing them again to
                # CX/U can accumulate avoidable numerical error in qasmviz.
                cudaq_full = simulate(cudaq_path, prefer_explicit_lowering=False)
                report["cudaq_width"] = len(next(iter(cudaq_full)))
                report["cudaq_comparison"] = compare_cudaq(
                    qrisp_full, cudaq_full, CUDAQ_LAYOUTS[benchmark_id]
                )
                passed = passed and report["cudaq_comparison"]["passed"]
            else:
                report["cudaq_comparison"] = {
                    "passed": None,
                    "status": "unavailable",
                }
            report["passed"] = passed
        except Exception as exc:
            passed = False
            report = {"id": benchmark_id, "description": description, "passed": False, "error": str(exc)}
        failed |= not passed
        reports.append(report)
        print(json.dumps(report, indent=2), flush=True)
    output = Path(__file__).resolve().parent / "outputs" / "state_verification.json"
    output.write_text(json.dumps(reports, indent=2))
    raise SystemExit(1 if failed else 0)


if __name__ == "__main__":
    main()
