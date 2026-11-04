"""Five-qubit controlled phase benchmark."""

import numpy as np
from qrisp import QuantumFloat, h, mcp, x

from resource_evaluator import evaluate_quantum_program, print_report


def build_program():
    qs = QuantumFloat(5)
    for i in range(4):
        h(qs[i])
    x(qs[4])
    mcp(np.pi / 4, qs)
    return qs


def main() -> None:
    print_report(evaluate_quantum_program(
        build_program,
        label="5-qubit controlled phase (phi=pi/4)",
    ))


if __name__ == "__main__":
    main()
