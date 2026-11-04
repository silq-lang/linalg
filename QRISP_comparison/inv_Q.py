"""Matched degree-25 pseudoinverse for A=[[1,-1/3],[-1/3,1]]."""

import numpy as np
from qrisp import QuantumBool, QuantumFloat, gphase, x
from matched_qsp_Q import apply_plain_gqsp, hermitianized_walk, matched_lcu


THETA = [
    3.1415274679146443, 0.0, 9.776463271359676e-5, 0.0,
    0.0003800334067763974, 0.0, 0.001427718229960974, 0.0,
    0.004774609203485056, 0.0, 0.014086389389628213, 0.0,
    0.0368683182207828, 0.0, 0.08622753116186589, 0.0,
    0.18111158638146607, 0.0, 0.34078995119489974, 0.0,
    0.5630561253896087, 0.0, 0.7801361606707458, 0.0,
    0.8562941190021919, 0.0,
]
PHI = [
    5.680942197676988e-13, np.pi, -2.8771020558492557e-5, np.pi,
    -3.1415924569828078, np.pi, 2.6227288113888577e-7, np.pi,
    -3.1415926170399557, np.pi, 3.144698095117979e-9, np.pi,
    -3.1415926535228498, np.pi, -4.6545265827882944e-11, np.pi,
    3.141592653579698, np.pi, -3.1578911278100168e-12, np.pi,
    3.1415926535882535, np.pi, 1.1935963058706617e-12, np.pi,
    3.1415926535895826, np.pi,
]


def _identity(_operand):
    return None


def _negative_x(operand):
    x(operand[0])
    gphase(np.pi, operand[0])


def build_block_encoding():
    # Exact match for inv_slq.slq: (I-X/3)/(4/3), using a Hermitian
    # PREP-SELECT-PREP^dagger LCU with the sign carried by SELECT.
    return matched_lcu(
        np.array([1.0, 1.0 / 3.0]),
        [_identity, _negative_x],
    )


def build_program():
    operand = QuantumFloat(1)
    x(operand[0])  # |b> = |1>
    block_encoding = build_block_encoding()
    ancillas = block_encoding.create_ancillas()
    side = QuantumBool()
    flag = QuantumBool()

    def walk():
        hermitianized_walk(side, block_encoding, ancillas, operand)

    apply_plain_gqsp(flag, walk, THETA, PHI, 0.0, k=0)
    x(side)  # Same final side-qubit cleanup as inv_slq.slq.
    return operand, (flag, side, *ancillas)


if __name__ == "__main__":
    print(build_program()[0].qs.to_qasm3())
