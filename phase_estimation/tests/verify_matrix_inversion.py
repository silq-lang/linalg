#!/usr/bin/env python3
"""Run the actual Silq inverse solver and compare successful states to A^-1 b.

Usage: python3 tests/verify_matrix_inversion.py [--silq /path/to/silq]
All coefficients, complements, angles and circuits are evaluated in native Silq.
NumPy is used only for the classical inverse and numerical comparisons.
"""

import argparse
from concurrent.futures import ThreadPoolExecutor
import subprocess

import numpy as np

import verify_augmented_solver as helper


def check_output(output, matrix, rhs, epsilon=2e-4):
    actual = helper.zero_ancilla_vector(output, len(rhs))
    expected = np.linalg.solve(matrix, rhs)
    error = helper.distance_up_to_phase(actual, expected)
    probability = float(np.vdot(actual, actual).real)
    assert error < epsilon, (actual, expected, error)
    assert probability > 0.001
    return actual / np.sqrt(probability), error, probability


def verify_example(silq):
    result = subprocess.run(
        [silq, "GQSVT/matrix_inversion.slq", "--run", "--coords=cartesian", "--style=compact"],
        cwd=helper.IMPORT_ROOT, capture_output=True, text=True, timeout=300,
    )
    if result.returncode:
        raise RuntimeError(result.stdout + result.stderr)
    matrix = np.array([[0.5, -1 / 6], [-1 / 6, 0.5]])
    state, error, probability = check_output(result.stdout, matrix, [0, 1])
    print(f"Native matrix_inversion main: state {state}, error {error:.3g}, success {probability:.7f}")


def verify_nonnormal(silq):
    source = """import GQSVT.matrix_inversion;
def f(anc:𝔹^1,qs:𝔹^1)mfree{
    if !qs[0]{anc[0] := rotY(2*acos(0.5),anc[0]);}
    if qs[0]{anc[0] := rotY(2*acos(0.25),anc[0]);}
    qs[0] := rotY(0.7,qs[0]);
    if qs[0]{phase(π/5);}
    return (anc,qs);
}
def main(){
    qs := 0:uint[1] as 𝔹^1;qs[0] := H(qs[0]);
    return invert_matrix[1,1](2:uint[3] as 𝔹^3,qs,f,2e-4,4);
}
"""
    c, s = np.cos(0.35), np.sin(0.35)
    matrix = np.diag([1, np.exp(1j * np.pi / 5)]) @ np.array([[c, -s], [s, c]]) @ np.diag([0.5, 0.25])
    rhs = np.ones(2) / np.sqrt(2)
    assert helper.distance_up_to_phase(np.linalg.solve(matrix, rhs), np.linalg.solve(matrix.conj().T, rhs)) > 0.1
    state, error, probability = check_output(helper.run_silq(silq, source, timeout=300), matrix, rhs)
    print(f"Native complex nonnormal inverse: state {state}, error {error:.3g}, success {probability:.7f}")


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--silq", default="silq")
    args = parser.parse_args()
    with ThreadPoolExecutor(max_workers=2) as pool:
        futures = [pool.submit(check, args.silq) for check in (verify_example, verify_nonnormal)]
        for future in futures:
            future.result()


if __name__ == "__main__":
    main()
