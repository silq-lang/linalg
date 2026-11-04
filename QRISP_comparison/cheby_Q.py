"""Degree-two Chebyshev transform of the TFIM block encoding."""

import numpy as np
from qrisp import QuantumFloat, ry

from TFIM_Q import build_block_encoding as build_tfim
from resource_evaluator import evaluate_block_encoding, print_report


DEGREE = 2


def build_block_encoding():
    return build_tfim().chebyshev(DEGREE, rescale=False)


def build_program():
    operand = QuantumFloat(2)
    # Generic operand, matching the Silq source.
    ry(np.pi / 7, operand[0])
    ry(np.pi / 9, operand[1])
    block_encoding = build_block_encoding()
    ancillas = block_encoding.create_ancillas()
    block_encoding.unitary(*ancillas, operand)
    return operand, ancillas


def main() -> None:
    print_report(evaluate_block_encoding(
        build_block_encoding(), lambda: QuantumFloat(2), label="TFIM Chebyshev T_2 block encoding"
    ))


if __name__ == "__main__":
    main()
