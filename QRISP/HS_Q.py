from __future__ import annotations

import numpy as np
from qrisp import QuantumFloat
from qrisp.block_encodings import BlockEncoding
from qrisp.operators import X, Z

from resource_evaluator import evaluate_block_encoding, print_report

def create_ising_hamiltonian(L: int, J: float, B: float):
    return sum(J * Z(i) * Z(i + 1) for i in range(L - 1)) + sum(B * X(i) for i in range(L))

def build_time_evolution_block_encoding(L: int, J: float, B: float, t: float, N: int):
    H = create_ising_hamiltonian(L, J, B)
    be_h = BlockEncoding.from_operator(H)
    return H, be_h.sim(t=t, N=N)

def main() -> None:
    L = 2
    J = 0.25
    B = 0.5
    t = np.pi / 4
    N = 14

    H, be_time_evolution = build_time_evolution_block_encoding(L, J, B, t, N)

    report = evaluate_block_encoding(
        be_time_evolution,
        operand_factory=lambda: QuantumFloat(L),
        label="HS time-evolution block encoding",
        apply_unitary_for_rotation_depth=True,
        include_statevector=True,
    )
    print_report(report)


if __name__ == "__main__":
    main()
