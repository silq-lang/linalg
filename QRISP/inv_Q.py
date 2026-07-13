from qrisp import *
from qrisp.block_encodings import BlockEncoding
from qrisp.operators import QubitOperator
import numpy as np

from resource_evaluator import evaluate_block_encoding, print_report


A = np.array([
    [1, -1/3],
    [-1/3,1],
])

b = np.array([0, 1])

H = QubitOperator.from_matrix(A).to_pauli()

BE_H = BlockEncoding.from_operator(H)

BE_H_inv = BE_H.pseudo_inv(
    eps=0.02,
    theta=0.33,
    delta=0.05,
)


def operand_factory():
    return QuantumFloat(1)


report = evaluate_block_encoding(
    BE_H_inv,
    operand_factory,
    label="Block encoding of A^{-1} resources",
)

print_report(report)


operand = QuantumFloat(1)

x(operand[0])

ancillas = BE_H_inv.create_ancillas()

BE_H_inv.unitary(*ancillas, operand)

print()
print("Resulting statevector of ancillas + operand:")
print(operand.qs.statevector(return_type="sympy", decimals=6))


x_classical = np.linalg.inv(A) @ b
x_classical = x_classical / np.linalg.norm(x_classical)

print()
print("Classical normalized solution:")
print(x_classical)