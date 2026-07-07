import numpy as np
from qrisp import *
from qrisp.block_encodings import BlockEncoding
from qrisp.operators import QubitOperator

from resource_evaluator import evaluate_block_encoding, print_report

def create_tridiagonal_matrix(n_qubits):
    N = 2**n_qubits

    A = np.zeros((N, N), dtype=complex)

    for i in range(N):
        A[i, i] = 0.5

        if i + 1 < N:
            A[i, i + 1] = -0.25
            A[i + 1, i] = -0.25

    return A

n = 2

A = create_tridiagonal_matrix(n)

print("Matrix A:")
print(A)


H = QubitOperator.from_matrix(A).to_pauli()

BE_A = BlockEncoding.from_operator(H)


def operand_factory():
    return QuantumFloat(n)

report = evaluate_block_encoding(
    BE_A,
    operand_factory,
    label="Block encoding of tridiagonal matrix resources",
)

print_report(report)

operand = QuantumFloat(n)

ancillas = BE_A.create_ancillas()

BE_A.unitary(*ancillas, operand)

print()
print("Resulting statevector of ancillas + operand:")
print(operand.qs.statevector(return_type="sympy", decimals=6))