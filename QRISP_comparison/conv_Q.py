"""Cubic convolution benchmark; resources cover one coherent attempt."""

import numpy as np
from qrisp import QuantumBool, QuantumFloat, gidney_adder, h
from qrisp.gqsp import GQSP

from resource_evaluator import evaluate_quantum_program, print_report


COEFFICIENTS = np.array([0.07, 0.35, 0.35, 0.2])


def _increment(state):
    gidney_adder(1, state)


def build_program():
    # Apply sum_k p_k U^k with U = increment, as conv_slq.slq does.
    # qrisp.gqsp.convolve treats the weights as a centred filter (k=len//2),
    # which would apply sum_k p_k U^(k-2) instead.
    state = QuantumFloat(2)
    h(state[0])
    ancilla = QuantumBool()
    GQSP(ancilla, state, unitary=_increment, p=COEFFICIENTS, k=0)
    return state, ancilla


def main() -> None:
    print_report(evaluate_quantum_program(
        build_program, label="cubic convolution (one coherent attempt)"
    ))


if __name__ == "__main__":
    main()
