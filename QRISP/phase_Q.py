import numpy as np
from qrisp import *

from resource_evaluator import evaluate_quantum_program, print_report

def program():
    qs = QuantumFloat(5)

    # First four qubits: H|0>
    for i in range(4):
        h(qs[i])

    # Fifth qubit: |1>
    x(qs[4])

    # Controlled pi/4 phase on all five qubits
    mcp(np.pi / 4, qs)

    return qs

report = evaluate_quantum_program(
    program,
    label="5-controlled pi/4 phase resources",
)

print_report(report)

qs = program()

print()
print("Resulting statevector:")
print(qs.qs.statevector(return_type="sympy", decimals=6))