"""Matched first-order TFIM product formula with 14 steps."""

import numpy as np
from qrisp import QuantumFloat, cx, h, ry, rz

from resource_evaluator import evaluate_quantum_program, print_report


TIME = np.pi / 4
STEPS = 14


def _pauli_exp(state, theta, paulis):
    active = [index for index, pauli in enumerate(paulis) if pauli != "I"]
    target = active[-1]
    for index, pauli in enumerate(paulis):
        if pauli == "X":
            h(state[index])
    for index in active[:-1]:
        cx(state[index], state[target])
    rz(2 * theta, state[target])
    for index in reversed(active[:-1]):
        cx(state[index], state[target])
    for index, pauli in enumerate(paulis):
        if pauli == "X":
            h(state[index])


def build_program():
    state = QuantumFloat(2)
    ry(np.pi / 7, state[0])
    ry(np.pi / 9, state[1])
    for _ in range(STEPS):
        _pauli_exp(state, TIME * (-0.25) / STEPS, "ZZ")
        _pauli_exp(state, TIME * 0.5 / STEPS, "XI")
        _pauli_exp(state, TIME * 0.5 / STEPS, "IX")
    return state


def main() -> None:
    print_report(evaluate_quantum_program(
        build_program,
        label="TFIM product formula (t=pi/4, 14 steps)",
    ))


if __name__ == "__main__":
    main()
