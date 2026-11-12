"""Verify Silq and CUDA-Q outputs up to clean ancillas, wire order, and phase."""

from __future__ import annotations

import itertools
import json
import os
from pathlib import Path
import subprocess


HERE = Path(__file__).resolve().parent
QASM = Path(os.environ.get("QASM_DIR", HERE / "outputs" / "qasm"))
NAMES = (
    "qft",
    "givens",
    "slater",
    "comparator",
    "trotter",
    "pauli_prepare",
    "pauli_select",
    "walk",
    "qsvt",
)
TOLERANCE = 2e-6


def simulate(path: Path) -> dict[str, complex]:
    process = subprocess.run(
        ["qasmviz", str(path), "--run", "--json"],
        text=True,
        capture_output=True,
        check=False,
    )
    if process.returncode:
        raise RuntimeError(process.stderr)
    payload = json.loads(process.stdout[process.stdout.find("{"):])
    return {
        item["basis"]: complex(item["re"], item["im"])
        for item in payload["statevector"]
        if abs(complex(item["re"], item["im"])) > 1e-10
    }


def simulate_dynamic_silq(path: Path) -> dict[str, complex]:
    process = subprocess.run(
        [
            "silq", "--run", "--repeat=16", "--seed=19",
            "--print-format=json-stream", str(path),
        ],
        text=True,
        capture_output=True,
        check=False,
    )
    if process.returncode:
        raise RuntimeError(process.stderr)
    states = []
    for line in process.stdout.splitlines():
        payload = json.loads(line)
        if payload.get("error_probability") != 0.0:
            raise RuntimeError("Silq dynamic run reported nonzero error probability")
        states.append({
            "".join("1" if bit else "0" for bit in item["basis_state"]):
                complex(*item["amplitude"])
            for item in payload["entries"]
            if abs(complex(*item["amplitude"])) > 1e-10
        })
    if len(states) != 16:
        raise RuntimeError("Silq dynamic validation did not produce 16 runs")
    reference = states[0]
    identity = tuple(range(len(next(iter(reference)))))
    if any(error(reference, state, identity) > TOLERANCE for state in states[1:]):
        raise RuntimeError("Silq measurement branches do not produce one output state")
    return reference


def remove_clean_qubits(state: dict[str, complex]):
    width = len(next(iter(state)))
    active = [
        index
        for index in range(width)
        if any(bits[index] == "1" for bits in state)
    ]
    reduced = {
        "".join(bits[index] for index in active): amplitude
        for bits, amplitude in state.items()
    }
    return reduced, active


def error(left, right, permutation):
    mapped = {
        "".join(bits[index] for index in permutation): amplitude
        for bits, amplitude in right.items()
    }
    keys = set(left) | set(mapped)
    overlap = sum(
        mapped.get(key, 0j).conjugate() * left.get(key, 0j) for key in keys
    )
    phase = overlap / abs(overlap) if abs(overlap) > 1e-12 else 1.0
    return max(
        abs(left.get(key, 0j) - phase * mapped.get(key, 0j)) for key in keys
    )


def compare_states(name, silq_full, cudaq_full):
    silq, silq_active = remove_clean_qubits(silq_full)
    cudaq, cudaq_active = remove_clean_qubits(cudaq_full)
    best = (float("inf"), None)
    if len(next(iter(silq))) == len(next(iter(cudaq))):
        for permutation in itertools.permutations(range(len(next(iter(silq))))):
            candidate = error(silq, cudaq, permutation)
            if candidate < best[0]:
                best = (candidate, permutation)
    return {
        "id": name,
        "passed": best[0] <= TOLERANCE,
        "max_amplitude_error": best[0],
        "wire_permutation": best[1],
        "silq_active_qubits": silq_active,
        "cudaq_active_qubits": cudaq_active,
    }


def main() -> None:
    reports = []
    failed = False
    for name in ("qq_adder", "qroam"):
        report = compare_states(
            name,
            simulate_dynamic_silq(HERE / f"{name}.slq"),
            simulate(QASM / f"{name}_cudaq.qasm"),
        )
        reports.append(report)
        failed |= not report["passed"]
    for name in NAMES:
        silq_full = simulate(QASM / f"{name}_silq.qasm")
        cudaq_full = simulate(QASM / f"{name}_cudaq.qasm")
        report = compare_states(name, silq_full, cudaq_full)
        failed |= not report["passed"]
        reports.append(report)
    (HERE / "outputs" / "state_verification.json").write_text(
        json.dumps(reports, indent=2)
    )
    if failed:
        raise SystemExit(1)


if __name__ == "__main__":
    main()
