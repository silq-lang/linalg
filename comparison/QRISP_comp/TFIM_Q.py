"""Two-qubit transverse-field Ising block encoding."""

import numpy as np
from qrisp import QuantumFloat, gphase, ry, x, z
from matched_qsp_Q import matched_lcu

from resource_evaluator import evaluate_block_encoding, print_report


def _negative_zz(operand):
    z(operand[0])
    z(operand[1])
    gphase(np.pi, operand[0])


def _x0(operand):
    x(operand[0])


def _x1(operand):
    x(operand[1])


def build_block_encoding():
    # Explicitly match TFIM_slq.slq term order and Hermitian
    # PREP-SELECT-PREP^dagger convention. alpha = 0.25 + 0.5 + 0.5 = 1.25.
    return matched_lcu(
        np.array([0.25, 0.5, 0.5]),
        [_negative_zz, _x0, _x1],
    )


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
        build_block_encoding(), lambda: QuantumFloat(2), label="2-qubit TFIM block encoding"
    ))


if __name__ == "__main__":
    main()
