"""Canonical amplitude estimation matching qae_slq.slq gate conventions."""

import numpy as np
from qrisp import QPE, QuantumFloat, ry, x, z

from resource_evaluator import evaluate_quantum_program, print_report


PRECISION = 5


def _state_preparation(system):
    ry(np.pi / 3, system[0])


def _tag_zero(system):
    x(system[0])
    z(system[0])
    x(system[0])


def _prepared_state_reflection(system):
    ry(-np.pi / 3, system[0])
    _tag_zero(system)
    ry(np.pi / 3, system[0])


def _grover_operator(system):
    _tag_zero(system)
    _prepared_state_reflection(system)


def build_program():
    system = QuantumFloat(1)
    _state_preparation(system)
    phase = QPE(system, _grover_operator, precision=PRECISION)
    return phase, system


def main() -> None:
    print_report(evaluate_quantum_program(
        build_program, label="QAE: Ry(pi/3), good state |0>, precision=5"
    ))


if __name__ == "__main__":
    main()
