from qrisp import *
from qrisp.block_encodings import BlockEncoding
from qrisp.operators import X, Z

from resource_evaluator import evaluate_block_encoding, print_report


H = 0.5 * X(0) + 0.5 * X(1) - 0.25 * Z(0) * Z(1)
BE = BlockEncoding.from_operator(H)

BE_cheb = BE.chebyshev(2,rescale=False)


def operand_factory():
    return QuantumFloat(2)

report = evaluate_block_encoding(
    BE_cheb,
    operand_factory,
    label="Chebyshev order-2 block encoding resources",
)

print_report(report)

operand = QuantumFloat(2)

ancillas = BE_cheb.create_ancillas()

BE_cheb.unitary(*ancillas, operand)

print(operand.qs.statevector(return_type="sympy", decimals=6))