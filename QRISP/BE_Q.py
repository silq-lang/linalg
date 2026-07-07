from qrisp import *
from qrisp.block_encodings import BlockEncoding
from qrisp.operators import X, Y, Z

from resource_evaluator import evaluate_block_encoding, print_report

H =  0.25 * X(0) * X(1) +  0.25 * Y(0) * Y(1) + 0.25 * Z(0) * Z(1)

BE_H = BlockEncoding.from_operator(H)


def operand_factory():
    return QuantumFloat(2)

report = evaluate_block_encoding(
    BE_H,
    operand_factory,
    label="Block encoding of H resources",
)

print_report(report)

operand = QuantumFloat(2)
operand[:] = 2

ancillas = BE_H.create_ancillas()

BE_H.unitary(*ancillas, operand)

print(operand.qs.statevector(return_type="sympy", decimals=6))