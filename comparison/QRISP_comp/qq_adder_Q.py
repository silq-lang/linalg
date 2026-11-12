"""Native four-bit quantum-quantum addition benchmark."""

from qrisp import QuantumFloat, gidney_adder, h, x

from resource_evaluator import evaluate_quantum_program, print_report


def build_program():
    addend = QuantumFloat(4)
    target = QuantumFloat(4)
    for qubit in addend:
        h(qubit)
    x(target[1])
    gidney_adder(addend, target)
    return addend, target


def main() -> None:
    print_report(evaluate_quantum_program(
        build_program, label="Native quantum-quantum addition, 4 bits"
    ))


if __name__ == "__main__":
    main()
