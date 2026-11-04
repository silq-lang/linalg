"""Three-bit coherent phase estimation of a pi/4 phase."""

import numpy as np
from qrisp import QPE, QuantumFloat, p, ry

from resource_evaluator import evaluate_quantum_program, print_report


PRECISION = 3


def _phase_unitary(system):
    p(np.pi / 4, system[0])


def build_program():
    system = QuantumFloat(1)
    ry(np.pi / 5, system[0])
    phase = QPE(system, _phase_unitary, precision=PRECISION)
    return phase, system


def main() -> None:
    print_report(evaluate_quantum_program(
        build_program, label="QPE: pi/4 phase, superposed input, precision=3"
    ))


if __name__ == "__main__":
    main()
