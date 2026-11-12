"""Five-qubit quantum Fourier transform on a generic product state."""

import numpy as np
from qrisp import QFT, QuantumFloat, ry, rz

from resource_evaluator import evaluate_quantum_program, print_report


def build_program():
    state = QuantumFloat(5)
    for index in range(5):
        ry((index + 1) * np.pi / 11, state[index])
        rz((index + 1) * np.pi / 13, state[index])
    QFT(state)
    return state


def main() -> None:
    print_report(evaluate_quantum_program(
        build_program, label="5-qubit QFT on a generic product state"
    ))


if __name__ == "__main__":
    main()
