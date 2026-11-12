"""Coherent comparison of a five-bit value with the classical value six."""

from qrisp import QuantumFloat, gidney_adder, h, uint_lt

from resource_evaluator import evaluate_quantum_program, print_report


def build_program():
    value = QuantumFloat(5)
    for qubit in value:
        h(qubit)
    flag = uint_lt(value, 6, gidney_adder)
    return value, flag


def main() -> None:
    print_report(evaluate_quantum_program(
        build_program, label="Coherent comparison: 5-bit x < 6"
    ))


if __name__ == "__main__":
    main()
