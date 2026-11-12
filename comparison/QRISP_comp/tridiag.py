"""Block encoding of the same 4x4 non-cyclic tridiagonal matrix as Silq."""

import numpy as np
from qrisp import QuantumFloat, ry
from qrisp.block_encodings import BlockEncoding
from qrisp.operators import QubitOperator

from resource_evaluator import evaluate_block_encoding, print_report


N_QUBITS = 2


def matrix() -> np.ndarray:
    size = 2**N_QUBITS
    result = 0.5 * np.eye(size, dtype=complex)
    result += -0.25 * np.eye(size, k=1)
    result += -0.25 * np.eye(size, k=-1)
    return result


def build_block_encoding():
    # from_matrix reads the row index big-endian, while QuantumFloat values are
    # little-endian. Bit-reverse the matrix so the block is A in the operand's
    # integer basis, matching Silq.
    size = 2**N_QUBITS
    reverse = [int(format(i, f"0{N_QUBITS}b")[::-1], 2) for i in range(size)]
    reordered = matrix()[np.ix_(reverse, reverse)]
    operator = QubitOperator.from_matrix(reordered).to_pauli()
    return BlockEncoding.from_operator(operator)


def build_program():
    operand = QuantumFloat(N_QUBITS)
    # Generic operand, matching the Silq source.
    ry(np.pi / 7, operand[0])
    ry(np.pi / 9, operand[1])
    block_encoding = build_block_encoding()
    ancillas = block_encoding.create_ancillas()
    block_encoding.unitary(*ancillas, operand)
    return operand, ancillas


def main() -> None:
    print_report(evaluate_block_encoding(
        build_block_encoding(),
        lambda: QuantumFloat(N_QUBITS),
        label="4x4 non-cyclic tridiagonal block encoding",
    ))


if __name__ == "__main__":
    main()
