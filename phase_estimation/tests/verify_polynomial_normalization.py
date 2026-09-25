#!/usr/bin/env python3
"""Native checks for shared GQET/GQSVT polynomial normalization.

Run: python3 tests/verify_polynomial_normalization.py [--silq /path/to/silq]
Requires NumPy. Silq computes all normalization bounds, coefficients, complements,
angles, and circuit amplitudes; NumPy supplies independent numerical checks.
"""

import argparse

import numpy as np

from verify_augmented_solver import classical_value, run_silq, zero_ancilla_vector


def literal(values):
    return "(" + ",".join(repr(complex(z)).replace("j", "i") for z in values) + ",)"


def verify_bounds(silq):
    cases = [
        [0], [2j], [1, 1, -1], [2 + 1j, -0.5 + 2j, 0, -3j],
        np.exp(-1j * np.arange(8) * np.pi / 1024),
    ]
    z = np.exp(2j * np.pi * np.arange(16384) / 16384)
    for coefficients in cases:
        p = np.asarray(coefficients, complex)
        d = len(p) - 1
        source = f"""import GQSVT.matrix_poly;
def main(){{
    p := {literal(p)}:!ℂ^{d+1};
    return (polynomial_normalization_bound[{d}](p),normalize_polynomial[{d}](p));
}}
"""
        bound, normalized = classical_value(run_silq(silq, source))
        normalized = np.asarray(normalized, complex)
        assert np.all(np.isfinite(normalized))
        if not np.any(p):
            assert bound == 0 and not np.any(normalized)
            continue
        peak = np.max(abs(np.polynomial.polynomial.polyval(z, p)))
        assert peak <= bound + 2e-12
        assert bound <= np.sum(abs(p)) * (1 + 2e-12)
        np.testing.assert_allclose(normalized, p * (0.9 / bound), atol=2e-14)
        assert np.max(abs(np.polynomial.polynomial.polyval(z, normalized))) <= 0.9 + 2e-12
        assert normalized[-1] != 0  # The highest-degree entry must also be scaled.
        if d == 2:
            assert bound < 0.9 * np.sum(abs(p))  # Exercise the sharper FFT bound.
    print("Native bounds: zero/constant/complex polynomials, between-sample peaks and full coefficient scaling pass")


def verify_basis_and_circuits(silq):
    # A reflection block encoding gives eigenvalues +1 and -1. The target
    # monomial polynomial 1+2x becomes Chebyshev coefficients [1,2].
    for transform, ancillas in (("gqet", 2), ("gqsvt", 3)):
        source = f"""import GQSVT.matrix_poly;
import GQSVT.gqsp_angles;
def f(anc:𝔹^1,qs:𝔹^1) mfree{{qs[0] := Z(qs[0]);return (anc,qs);}}
def main(){{
    p := normalize_polynomial[1](chebyshev_coef[1]((1,2):!ℂ^2));
    q := complement[1](p,1e-8);
    assert(is_complement[num_samples(1,1e-8)][1](p,q,1e-8));
    (θs,φs,λ) := gqsp_compute_angles[1](p,q);
    qs := 0:uint[1] as 𝔹^1;qs[0] := H(qs[0]);
    return {transform}[0][1](θs,φs,λ)(f)(0:uint[{ancillas}] as 𝔹^{ancillas},qs);
}}
"""
        output = run_silq(silq, source)
        actual = zero_ancilla_vector(output, 2)
        if transform == "gqet":
            np.testing.assert_allclose(actual, np.array([0.9, -0.3]) / np.sqrt(2), atol=8e-7)
        else:
            # Dilation input/output zero selects only the even part for this
            # mixed-parity polynomial: the normalized constant is 0.3.
            np.testing.assert_allclose(actual, np.array([0.3, 0.3]) / np.sqrt(2), atol=8e-7)
    source = """import GQSVT.matrix_poly;
def main(){return normalize_polynomial[2](chebyshev_coef[2]((-1,0,2):!ℂ^3));}
"""
    np.testing.assert_allclose(classical_value(run_silq(silq, source)), [0, 0, 0.9], atol=2e-12)
    print("Native basis conversion and small GQET/GQSVT success amplitudes pass")


def verify_coherent_rows(silq):
    source = """import GQSVT.multi_GQET;
def main(){
    def f(anc:𝔹^1,qs:𝔹^1)mfree{qs[0]:=Z(qs[0]);return(anc,qs);}
    def g(anc:𝔹^1,qs:𝔹^1)mfree{return(anc,qs);}
    p := [[1,2],[5,0]]:(!ℂ^2)^2;
    qs := 0:uint[1] as 𝔹^1;qs[0] := H(qs[0]);
    return biv_GQET[1](p)[1,1,1,1](0:uint[4] as 𝔹^4,qs,f,g);
}
"""
    actual = zero_ancilla_vector(run_silq(silq, source), 2)
    np.testing.assert_allclose(actual, np.array([0.72, -0.18]) / np.sqrt(2), atol=8e-7)
    print("Native bivariate circuit preserves relative amplitudes using one common row scale")


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--silq", default="silq")
    args = parser.parse_args()
    verify_bounds(args.silq)
    verify_basis_and_circuits(args.silq)
    verify_coherent_rows(args.silq)


if __name__ == "__main__":
    main()
