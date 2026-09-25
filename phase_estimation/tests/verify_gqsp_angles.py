#!/usr/bin/env python3
"""Check native GQSP angle synthesis, including the reported inverse failure.

Run: python3 tests/verify_gqsp_angles.py [--silq /path/to/silq]
Requires NumPy for independent polynomial/circuit oracles. All angles are made
by the repository's native Silq function. Modest complements are also native.
The inverse fixture below stores native degree-45 P,Q from the original failure;
it isolates the angle bug without rerunning its expensive complement FFT.
The fixture's original kappa=2 is deliberately retained here, and is not a
correctly configured inverse-accuracy test. The production example uses kappa=3.
"""

import argparse

import numpy as np
from numpy.polynomial.chebyshev import chebval

from verify_augmented_solver import classical_value, run_silq, zero_ancilla_vector


def literal(values):
    return "(" + ",".join(repr(complex(z)).replace("j", "i") for z in values) + ",)"


def reconstruct(angles, z):
    theta, phi, phase = angles
    assert np.all(np.isfinite(np.concatenate((theta, phi, [phase]))))
    upper = np.ones(len(z), complex)
    lower = np.zeros(len(z), complex)
    for j, (angle, azimuth) in enumerate(zip(theta, phi)):
        if j:
            upper *= z
        c = np.cos(angle / 2)
        s = np.sin(angle / 2) * np.exp(1j * azimuth)
        upper, lower = c * upper - s * lower, s.conjugate() * upper + c * lower
    return np.exp(1j * phase) * upper, np.exp(1j * phase) * lower


def verify_pair(p, q, angles, tolerance=1e-10):
    z = np.exp(2j * np.pi * np.arange(8192) / 8192)
    actual_p, actual_q = reconstruct(angles, z)
    target_p = np.polynomial.polynomial.polyval(z, p)
    target_q = np.polynomial.polynomial.polyval(z, q)
    complement_error = np.max(abs(abs(target_p) ** 2 + abs(target_q) ** 2 - 1))
    assert complement_error < tolerance, complement_error
    error = max(np.max(abs(actual_p - target_p)), np.max(abs(actual_q - target_q)))
    assert error < tolerance, error
    return error


def native_pair(silq, p, q=None, tolerance=1e-10):
    d = len(p) - 1
    q_statement = (f"q := complement[{d}](p,1e-10);" if q is None else
                   f"q := {literal(q)}:!ℂ^{d+1};")
    source = f"""import GQSVT.gqsp_angles;
def main(){{
    p := {literal(p)}:!ℂ^{d+1};
    {q_statement}
    assert(is_complement[1024][{d}](p,q,{tolerance}));
    return (p,q,gqsp_compute_angles[{d}](p,q));
}}
"""
    return classical_value(run_silq(silq, source, timeout=120))


def verify_native_complements(silq):
    cases = {
        "degree zero": [0.2 + 0.3j],
        "zero polynomial": [0, 0, 0, 0],
        "constant with padding": [0.2 + 0.3j, 0, 0, 0],
        "complex dense": [0.13 + 0.04j, -0.11j, 0.09, -0.05 + 0.1j, 0.03j],
        "tiny leading coefficient": [0.2, 0.1j, -0.05, 1e-300],
        "monomial": [0, 0, 0, 0, 0.6j],
    }
    maximum = 0
    for name, p in cases.items():
        p, q, angles = native_pair(silq, p)
        error = verify_pair(p, q, angles)
        maximum = max(maximum, error)
        print(f"Native complement + angles: {name}, reconstruction error {error:.3g}", flush=True)
    return maximum


def verify_reported_inverse(silq):
    # complement_alg2 deliberately scales its local P by 1-1e-8/4; its
    # stored Q therefore has a 4.05e-9 complement residual, within tolerance.
    p, q, angles = native_pair(silq, INVERSE_P, INVERSE_Q, tolerance=1e-8)
    error = verify_pair(p, q, angles, tolerance=1e-8)
    print(f"Native degree-45 inverse fixture: P and Q reconstruction error {error:.3g}", flush=True)
    # The outer-Q INLFFT convention must preserve Q's global phase as well.
    rotated_q = np.asarray(INVERSE_Q) * np.exp(0.71j)
    rp, rq, rotated_angles = native_pair(silq, INVERSE_P, rotated_q, tolerance=1e-8)
    rotated_error = verify_pair(rp, rq, rotated_angles, tolerance=1e-8)
    print(f"Native INLFFT with complex Q0: reconstruction error {rotated_error:.3g}", flush=True)
    # Exercise the actual GQSVT circuit on the same block encoding and initial
    # state as matrix_inversion.slq. The complete successful vector must match
    # the intended polynomial, including its relative complex phase.
    source = f"""import GQSVT.matrix_poly;
import GQSVT.gqsp_angles;
import block_encodings.symtwobytwo;
def main(){{
    p := {literal(p)}:!ℂ^46;
    q := {literal(q)}:!ℂ^46;
    (θs,φs,λ) := gqsp_compute_angles[45](p,q);
    def f(anc:𝔹^2,xs:𝔹^1){{return twosym_block(anc,xs,1,-1/3);}}
    return gqsvt[0][45](θs,φs,λ)(f)(2:uint[4] as 𝔹^4,1:uint[1] as 𝔹^1);
}}
"""
    actual = zero_ancilla_vector(run_silq(silq, source, timeout=120), 2)
    values = chebval(np.array([1 / 3, 2 / 3]), p)
    expected = np.array([values[0] - values[1], values[0] + values[1]]) / 2
    # Silq's compact state display rounds amplitudes to six significant digits.
    np.testing.assert_allclose(actual, expected, atol=8e-7)
    assert np.max(abs(actual.imag)) < 8e-7
    print(f"Native degree-45 GQSVT: success amplitudes {actual}; match intended polynomial", flush=True)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--silq", default="silq")
    args = parser.parse_args()
    verify_native_complements(args.silq)
    verify_reported_inverse(args.silq)


# Frozen native coefficients follow; generated by the repository's Silq
# inverse_func, normalization, and complement functions before the angle fix.

INVERSE_P = (0j, (0.24179280617102353+0j), 0j, -0.19314415737934104, 0j, 0.1483361913870019, 0j, -0.10927283641932166, 0j, 0.07704556857098545, 0j, -0.051892579030820604, 0j, 0.0333272772273656, 0j, -0.020374741085420235, 0j, 0.011837842264592608, 0j, -0.006525994109410978, 0j, 0.0034081701922391494, 0j, -0.0016834165359313302, 0j, 0.0007851073399376744, 0j, -0.0003451191623081286, 0j, 0.00014272460059853767, 0j, -5.541714260616509e-05, 0j, 2.015836149386078e-05, 0j, -6.853161074123297e-06, 0j, 2.1717016671786296e-06, 0j, -6.395876794512833e-07, 0j, 1.7448164746262468e-07, 0j, -4.392556830791348e-08, 0j, 1.0161065078246788e-08)

INVERSE_Q = ((0.90233904314543+1.4822143648189367e-19j), (-0-0j), (0.15351760070569123-3.662225010461877e-18j), (-0-0j), (-0.11032893304408367+3.7789393213013875e-18j), (-0-0j), (0.07626594655016034-7.464462187157167e-18j), (-0-0j), (-0.05060846941026223-1.2485605690391898e-18j), (-0-0j), (0.03217704188933541-1.1041855097538896e-18j), (-0-0j), (-0.01956631936583862-2.063847665947804e-19j), (-0-0j), (0.011359116729851147-2.561835488449277e-18j), (-0-0j), (-0.0062849025814739785+2.087630219163622e-18j), (-0-0j), (0.003308430736625609-5.934246425595464e-19j), (-0-0j), (-0.0016540986573396052-9.92010277024264e-20j), (-0-0j), (0.0007840589877952098-2.7301832867160695e-18j), (-0-0j), (-0.0003517157569719636+3.870003003097624e-18j), (-0-0j), (0.0001490265115343222-1.447339732510288e-18j), (-0-0j), (-5.95237481097233e-05+1.6645257254327572e-18j), (-0-0j), (2.236344979933515e-05-3.815464102720343e-18j), (-0-0j), (-7.884957185604567e-06-7.60045573893597e-19j), (-0-0j), (2.602299018911782e-06+1.669247686559843e-18j), (-0-0j), (-8.015318488549685e-07-2.152025080042626e-18j), (-0-0j), (2.294881753092953e-07+2.5825472691793227e-19j), (-0-0j), (-6.061136487183085e-08-1.9913621675163024e-18j), (-0-0j), (1.440858816685496e-08-5.464794286107772e-19j), (-0-0j), (-2.72278191276532e-09+1.7398233917509168e-18j), (-0-0j))


if __name__ == "__main__":
    main()
