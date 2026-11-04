"""Matched two-term, first-order Pauli product formula."""

import numpy as np
from qrisp import QuantumFloat, cx, h, rx, ry, rz, s, s_dg

from resource_evaluator import evaluate_quantum_program, print_report


def _pauli_exp(state, theta, paulis):
    active = [index for index, pauli in enumerate(paulis) if pauli != "I"]
    target = active[-1]
    for index, pauli in enumerate(paulis):
        if pauli == "X":
            h(state[index])
        elif pauli == "Y":
            s_dg(state[index])
            h(state[index])
    for index in active[:-1]:
        cx(state[index], state[target])
    rz(2 * theta, state[target])
    for index in reversed(active[:-1]):
        cx(state[index], state[target])
    for index, pauli in enumerate(paulis):
        if pauli == "X":
            h(state[index])
        elif pauli == "Y":
            h(state[index])
            s(state[index])


def build_program():
    state = QuantumFloat(5)
    h(state[0])
    h(state[2])
    ry(np.pi / 3, state[4])
    cx(state[0], state[1])
    cx(state[2], state[3])
    cx(state[1], state[4])
    rx(np.pi / 5, state[3])
    _pauli_exp(state, np.pi / 6, "XYZXI")
    _pauli_exp(state, -np.pi / 5, "ZYXIX")
    return state


def main() -> None:
    print_report(evaluate_quantum_program(
        build_program, label="Two-term Pauli product formula, 5 qubits"
    ))


if __name__ == "__main__":
    main()
