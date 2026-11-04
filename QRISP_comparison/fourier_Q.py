"""Six-qubit Fourier-series state loader with five nonzero modes."""

import os
os.environ["QRISP_SIMULATOR_FLOAT_THRESH"] = "1e-10"

import numpy as np
from qrisp import QuantumFloat
from qrisp.gqsp import fourier_series_loader

from resource_evaluator import evaluate_quantum_program, print_report


N_QUBITS = 6
FREQUENCY_CUTOFF = 2


def signal_function(x):
    return 3 + 2 * np.cos(2 * np.pi * x) - np.sin(4 * np.pi * x)


def build_program():
    points = np.arange(2**N_QUBITS) / 2**N_QUBITS
    signal = signal_function(points)
    signal = signal / np.linalg.norm(signal)
    state = QuantumFloat(N_QUBITS)
    ancilla = fourier_series_loader(state, signal, k=FREQUENCY_CUTOFF)
    return state, ancilla


def main() -> None:
    print_report(evaluate_quantum_program(
        build_program,
        label="Fourier loader: 6 qubits, five modes",
    ))


if __name__ == "__main__":
    main()
