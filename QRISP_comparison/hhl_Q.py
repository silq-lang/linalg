"""QPE-based HHL benchmark matching phase_estimation/HHL.slq."""

import numpy as np
from qrisp import QuantumFloat, control, ry, x
from qrisp.algorithms.hhl import HHL
from qrisp.operators import X

from resource_evaluator import evaluate_quantum_program, print_report


MATRIX = np.array([[0.75, -0.25], [-0.25, 0.75]])
KAPPA = 2
PRECISION = 3
EVOLUTION_TIME = -np.pi / 2
TROTTER_STEPS = 1


def _evolution(system):
    hamiltonian = 0.75 - 0.25 * X(0)
    unitary = hamiltonian.trotterization(order=1)
    unitary(system, t=EVOLUTION_TIME, steps=TROTTER_STEPS)


def _invert_eigenvalue(phase, flag):
    angles = np.full(2**PRECISION, np.pi)
    for value in range(1, 2 ** (PRECISION - 1)):
        amplitude = KAPPA * 4 * value / (2**PRECISION)
        if amplitude > 1:
            amplitude = 1 / amplitude
        angles[value] = 2 * np.arccos(amplitude)
        angles[2**PRECISION - value] = 2 * np.pi - angles[value]

    for value, angle in enumerate(angles):
        with control(phase, ctrl_state=value):
            ry(angle, flag)


def build_program():
    system = QuantumFloat(1)
    x(system[0])
    flag = HHL(system, _evolution, _invert_eigenvalue, PRECISION)
    return system, flag


def main() -> None:
    print_report(evaluate_quantum_program(
        build_program,
        label="HHL: A=[[3/4,-1/4],[-1/4,3/4]], b=|1>, precision=3",
    ))


if __name__ == "__main__":
    main()
