from qrisp import *
from qrisp.block_encodings import BlockEncoding
from qrisp.operators import QubitOperator
import numpy as np
from numpy.polynomial.chebyshev import Chebyshev

from resource_evaluator import evaluate_block_encoding, print_report

A = np.array([
    [1.0, 0.35],
    [0.35, 1.0],
])

target_eigenvalue = 0.65

alpha = 1.35
target_normalized = target_eigenvalue / alpha

H = QubitOperator.from_matrix(A).to_pauli()

BE_H = BlockEncoding.from_operator(H)

degree = 14
sigma = 0.08

def gaussian_filter(x):
    return np.exp(-((x - target_normalized) ** 2) / (2 * sigma**2))

cheb_poly = Chebyshev.interpolate(
    gaussian_filter,
    deg=degree,
    domain=[-1, 1],
)

cheb_coeffs = cheb_poly.coef

BE_filter = BE_H.poly(
    cheb_coeffs,
    kind="Chebyshev",
)


def operand_factory():
    return QuantumFloat(1)

report = evaluate_block_encoding(
    BE_filter,
    operand_factory,
    label="Eigenvalue filtering resources for eigenvalue 0.65",
)

print_report(report)

operand = QuantumFloat(1)

ancillas = BE_filter.create_ancillas()

BE_filter.unitary(*ancillas, operand)

print()
print("Resulting statevector of ancillas + operand:")
print(operand.qs.statevector(return_type="sympy", decimals=6))

eigvals, eigvecs = np.linalg.eigh(A)

print()
print("Classical eigenvalues:")
print(eigvals)

print()
print("Eigenvector for eigenvalue 0.65:")
idx = np.argmin(np.abs(eigvals - target_eigenvalue))
target_vec = eigvecs[:, idx]

if target_vec[0] < 0:
    target_vec = -target_vec

print(target_vec)