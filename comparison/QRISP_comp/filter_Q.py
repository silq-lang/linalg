"""Eigenstate-filter benchmark using the same Chebyshev polynomial as Silq."""

import numpy as np
from numpy.polynomial.chebyshev import chebval
from qrisp import QuantumBool, QuantumFloat, gphase, x
from qrisp.block_encodings import BlockEncoding

from matched_qsp_Q import apply_plain_gqsp, qubitized_walk


ORDER = 14
GAP = 0.7
TARGET_EIGENVALUE = 0.65
INPUT_ALPHA = 1.35
FILTER_DELTA = GAP / (2 * INPUT_ALPHA)

# Exact phase sequence produced by filter_slq.slq for the degree-28 polynomial
# below. Sharing the phases removes angle-solver and convention differences.
THETA = [
    3.0944233469791818, 0.0, 0.048271028391483256, 0.0,
    0.07061931250846093, 0.0, 0.09768826570208763, 0.0,
    0.12917087085113513, 0.0, 0.1642121736684469, 0.0,
    0.201210554075707, 0.0, 0.23766073701641866, 0.0,
    0.2701763729251538, 0.0, 0.29485997891881893, 0.0,
    0.3080869698435683, 0.0, 0.3075064574390496, 0.0,
    0.29279771369189794, 0.0, 0.2657489531527303, 0.0,
    0.12474217817589621,
]
PHI = [
    2.5461367877870747e-16, 0.0, -1.426721491027488e-16, 0.0,
    -np.pi, 0.0, -8.216571016847195e-17, 0.0,
    -np.pi, 0.0, -5.989817948262644e-17, 0.0,
    np.pi, 0.0, -6.232064069468513e-17, 0.0,
    np.pi, 0.0, -4.944916419923601e-17, 0.0,
    np.pi, 0.0, -4.273863919602099e-17, 0.0,
    -np.pi, 0.0, -4.143106828206193e-18, 0.0,
    -np.pi,
]
RHO = 2.544963457069891e-16


def eigen_filter_coefficients(order: int, delta: float) -> np.ndarray:
    """Port of GQSVT.func_approx.eigen_filt from the Silq implementation."""
    count = 2 * order + 1
    coefficients = np.zeros(count)
    denominator = chebval(
        -(1 + delta**2) / (1 - delta**2),
        [0] * order + [1],
    )
    for sample in range(count):
        value_x = np.cos(np.pi * (2 * sample + 1) / (2 * count))
        value_y = (2 * value_x**2 - (1 + delta**2)) / (1 - delta**2)
        value = chebval(value_y, [0] * order + [1]) / denominator
        coefficients[0] += value / count
        for degree in range(2, count, 2):
            coefficients[degree] += 2 * value * chebval(
                value_x, [0] * degree + [1]
            ) / count
    return coefficients


def _identity(_operand):
    return None


def _apply_x(operand):
    x(operand[0])


def _negate(operand):
    gphase(np.pi, operand[0])


def build_shifted_block_encoding():
    # 0.35 I + 0.35 X + 0.65 I + 0.65 (-I) = A - 0.65 I, with alpha=2.0 as in
    # det_H in Silq. The sign is carried by the -I unitary so that all LCU
    # coefficients are non-negative: PREP SEL PREP^dagger is then a reflection,
    # which qubitization requires. With a negative coefficient Qrisp uses a
    # PREP_R/PREP_L pair and the qubitized polynomial is wrong.
    # For this symmetric four-term vector, Qrisp's native PREP has the same
    # completion as the recursive Silq PREP (verified as a full state).
    return BlockEncoding.from_lcu(
        np.array([0.35, 0.35, 0.65, 0.65]),
        [_identity, _apply_x, _identity, _negate],
        is_hermitian=True,
    )


def build_block_encoding():
    return build_shifted_block_encoding()


def build_program():
    operand = QuantumFloat(1)
    block_encoding = build_block_encoding()
    ancillas = block_encoding.create_ancillas()
    flag = QuantumBool()

    def walk():
        qubitized_walk(block_encoding, ancillas, operand)

    apply_plain_gqsp(flag, walk, THETA, PHI, RHO, k=0)
    return operand, (flag, *ancillas)


if __name__ == "__main__":
    print(build_program()[0].qs.to_qasm3())
