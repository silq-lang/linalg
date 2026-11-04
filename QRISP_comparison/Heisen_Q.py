"""Two-qubit isotropic Heisenberg block encoding."""

import numpy as np
from qrisp import QuantumFloat, ry
from qrisp.block_encodings import BlockEncoding
from qrisp.operators import X, Y, Z

from resource_evaluator import evaluate_block_encoding, print_report


def hamiltonian():
    return 0.25 * (X(0) * X(1) + Y(0) * Y(1) + Z(0) * Z(1))


def build_block_encoding():
    return BlockEncoding.from_operator(hamiltonian())


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
        build_block_encoding(), lambda: QuantumFloat(2), label="2-qubit Heisenberg block encoding"
    ))


if __name__ == "__main__":
    main()
