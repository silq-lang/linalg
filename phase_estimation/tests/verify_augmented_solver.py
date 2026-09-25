#!/usr/bin/env python3
"""Check the augmented history solver using native Silq and NumPy.

Usage: python3 tests/verify_augmented_solver.py [--silq /path/to/silq]

The 64-step check evaluates native source polynomials and native angle synthesis,
then uses numerical SVD; it is not a full 64-step circuit simulation. By default,
NumPy computes the large complementary polynomials using an adaptive version of
the source's FFT construction. Use --full-native-synthesis for the complete
native complement calculation. Small native circuits always exercise the full
native synthesis, right-kernel operation, reserved-state rejection, and cleanup.
"""

import argparse
import ast
from concurrent.futures import ThreadPoolExecutor
from pathlib import Path
import re
import subprocess
import tempfile
import time

import numpy as np
from numpy.polynomial.chebyshev import chebval

from verify_eigen_solver import verify_angles


IMPORT_ROOT = Path(__file__).resolve().parents[2]


def run_silq(silq, source, argument=None, timeout=600):
    with tempfile.TemporaryDirectory(prefix="augmented_solver_check_") as folder:
        path = Path(folder) / "probe.slq"
        path.write_text(source, encoding="utf-8")
        command = [silq, str(path), "--coords=cartesian", "--style=compact", "--seed=271828"]
        command += ["--run" if argument is None else "--run-on=" + repr(argument)]
        result = subprocess.run(command, cwd=IMPORT_ROOT, capture_output=True,
                                text=True, timeout=timeout)
        if result.returncode:
            raise RuntimeError(result.stderr or result.stdout)
        return result.stdout.strip()


def classical_value(output):
    output = re.sub(
        r"0x[\da-fA-F]+(?:\.[\da-fA-F]*)?[pP][+-]?\d+",
        lambda match: repr(float.fromhex(match.group())), output,
    )
    return ast.literal_eval(output.replace("i", "j"))


def zero_ancilla_vector(output, dimension):
    """Read successful amplitudes; Silq tuples store the least significant bit first."""
    vector = np.zeros(dimension, complex)
    terms = re.findall(r"\(([^()]+)\)·\|([^⟩]+)⟩", output)
    assert terms, output[:500]
    for amplitude, basis in terms:
        registers = ast.literal_eval(basis)
        *ancillas, system = registers
        if all(not any(register) for register in ancillas):
            index = sum(bit << j for j, bit in enumerate(system))
            vector[index] += complex(amplitude.replace("i", "j"))
    return vector


def even_transform(matrix, polynomial):
    """Even QSVT on the right singular subspace, including the exact kernel."""
    _, singular, vh = np.linalg.svd(matrix)
    return vh.conj().T @ np.diag(chebval(singular, polynomial)) @ vh


def history_problem(clock_steps=64, eigenvalue=1 / 8):
    shift = np.eye(clock_steps, k=-1)
    matrix = (np.eye(clock_steps) + shift @ shift - 2 * eigenvalue * shift) / 4
    rhs = (np.eye(clock_steps)[:, 0] - np.eye(clock_steps)[:, 2]) / np.sqrt(2)
    angles = np.arange(clock_steps) * np.arccos(eigenvalue)
    expected = np.cos(angles)
    expected[0] = 0.5
    exact = np.linalg.solve(matrix, rhs)
    np.testing.assert_allclose(exact, 4 * np.sqrt(2) * expected, atol=2e-12)
    return matrix, rhs, exact / np.linalg.norm(exact), np.linalg.norm(exact)


def augmented_output(matrix, rhs, t, reflection):
    n = len(rhs)
    # The extra-qubit implementation has additional identity spectators. They
    # cannot couple to b or e, so removing them leaves this same active block.
    augmented = np.zeros((n + 1, n + 1))
    augmented[:n, :n] = matrix
    augmented[-1, -1] = 1 / t
    augmented_rhs = np.append(rhs, 1) / np.sqrt(2)
    kernel_matrix = (np.eye(n + 1) - np.outer(augmented_rhs, augmented_rhs)) @ augmented
    output = even_transform(kernel_matrix, reflection)[:, -1]
    # kernel_aug marks e and excludes it from the successful branch.
    return output[:-1]


def distance_up_to_phase(actual, expected):
    actual = actual / np.linalg.norm(actual)
    expected = expected / np.linalg.norm(expected)
    overlap = np.vdot(expected, actual)
    return float(np.linalg.norm(actual * np.exp(-1j * np.angle(overlap)) - expected))


def verify_history(reflection, cleanup):
    matrix, rhs, target, solution_norm = history_problem()
    inverse_norm = 1 / np.linalg.svd(matrix, compute_uv=False)[-1]
    assert inverse_norm < 85 and 31 < solution_norm < 33
    assert abs(target[-1]) > 0.05  # The last clock sample must survive augmentation.
    kernel_matrix = (np.eye(64) - np.outer(rhs, rhs)) @ matrix
    projector = even_transform(kernel_matrix, cleanup)
    metrics = []
    for t in np.linspace(31, 33, 17):
        reflected = augmented_output(matrix, rhs, t, reflection)
        kr_success = float(np.vdot(reflected, reflected).real)
        output = projector @ reflected
        joint_success = float(np.vdot(output, output).real)
        conditional_kp = joint_success / kr_success
        distance = distance_up_to_phase(output, target)
        assert kr_success > 0.05 and conditional_kp > 0.5
        assert joint_success > 0.025 and distance < 2e-4
        metrics.append((kr_success, conditional_kp, joint_success, distance))
    metrics = np.asarray(metrics)
    print(f"N=64 matrix SVD: inverse norm {inverse_norm:.9f}, solution norm {solution_norm:.9f}")
    print(f"t in [31,33]: KR success {metrics[:, 0].min():.6f}..{metrics[:, 0].max():.6f}, "
          f"conditional cleanup {metrics[:, 1].min():.6f}..{metrics[:, 1].max():.6f}")
    print(f"Joint success {metrics[:, 2].min():.6f}..{metrics[:, 2].max():.6f}, "
          f"maximum state error {metrics[:, 3].max():.3g}")
    expected_work = (len(reflection) - 1) / metrics[:, 2] + (len(cleanup) - 1) / metrics[:, 1]
    print(f"Idealized expected QSVT degree budget {expected_work.min():.1f}..{expected_work.max():.1f} "
          "(excludes block/preparation overhead)")
    return metrics


POLYNOMIAL_PROBE = """\
import GQSVT.augmentation;
import GQSVT.func_approx;
import GQSVT.matrix_poly;
def main(k:!ℕ,l:!ℕ){
    κ := 85:!ℝ; η := 0.02:!ℝ; ϵ := 2e-4:!ℝ;
    L := 31:!ℝ; R := 33:!ℝ;
    assert(k=(ceil(κ*log(2/η)/2) coerce !ℕ));
    μ := (η/(1-η))*sqrt(3+2*log((R^2+L^2)/(2*L^2)));
    η_kp := (ϵ*sqrt(1-μ^2))/(μ*sqrt(1-ϵ^2));
    assert(l=(ceil(κ*log(2/η_kp)/2) coerce !ℕ));
    raw_kr := kernel_reflection(k,1/κ);
    raw_kp := eigen_filt(l,1/κ);
    p_kr := normalize_polynomial[2*k](raw_kr);
    p_kp := normalize_polynomial[2*l](raw_kp);
    return (k,l,raw_kr,raw_kp,p_kr,p_kp);
}
"""


NATIVE_PIPELINE_PROBE = """\
import GQSVT.augmentation;
import GQSVT.func_approx;
import GQSVT.gqsp_angles;
import GQSVT.matrix_poly;
def f(anc:𝔹^1,qs:𝔹^2) mfree{
    (x:𝔹^1)~(extension:𝔹^1) := qs;
    if !extension[0]{
        if !x[0]{anc[0] := rotY(2*acos(0.5),anc[0]);}
        if x[0]{anc[0] := rotY(2*acos(0.25),anc[0]);}
        x[0] := rotY(0.7,x[0]);
    }
    return (anc,x~extension);
}
def b(qs:𝔹^2) mfree{qs[0] := X(qs[0]);return qs;}
def main(){
    kr := (0.3,0,-0.2,0,0.1):!ℂ^5;
    kp := (0.4,0,-0.3,0,0.1):!ℂ^5;
    q_kr := complement[4](kr,1e-8);
    angles_kr := gqsp_compute_angles[4](kr,q_kr);
    (anc_kr,qs) := kernel_aug[2,1,4](3,3,angles_kr,
        0:uint[6] as 𝔹^6,3:uint[2] as 𝔹^2,f,b);
    def G_nt(anc:𝔹^2,qs:𝔹^2) mfree{return G[2,1](anc,qs,f,b);}
    q_kp := complement[4](kp,1e-8);
    (θs,φs,λ) := gqsp_compute_angles[4](kp,q_kp);
    (anc_kp,qs) := gqsvt[0][4](θs,φs,λ)(G_nt)(2:uint[4] as 𝔹^4,qs);
    anc_kp[1] := X(anc_kp[1]);
    return (anc_kr,anc_kp,qs);
}
"""


def numpy_complement(polynomial):
    """The source's alg1 construction, with an adaptive residual certificate."""
    d = len(polynomial) - 1
    samples = 2 ** int(np.ceil(np.log2(max(1024, 8 * (d + 1)))))
    tolerance = 1e-8 / (2 * (2 * d + 1))
    while samples <= 65536:
        signal = np.fft.fft(polynomial, n=samples)
        logarithm = np.fft.ifft(np.log1p(-abs(signal) ** 2))
        analytic = np.zeros(samples, complex)
        analytic[0] = logarithm[0] / 2
        analytic[1:samples // 2 + 1] = logarithm[1:samples // 2 + 1]
        complement = np.fft.ifft(np.exp(np.fft.fft(analytic)))[:d + 1]
        residual = max(abs(abs(signal) ** 2 + abs(np.fft.fft(complement, n=samples)) ** 2 - 1))
        if residual < tolerance:
            return complement, samples, residual * (2 * d + 1)
        samples *= 2
    raise AssertionError("Complement failed the source residual certificate")


def native_angles(silq, polynomial, full_native=False):
    d = len(polynomial) - 1
    literal = "(" + ",".join(repr(complex(z)).replace("j", "i") for z in polynomial) + ")"
    source = f"import GQSVT.augmentation;\nimport GQSVT.gqsp_angles;\ndef main(){{p := {literal}:!ℂ^{d+1};\n"
    if full_native:
        source += f"q := complement[{d}](p,1e-8);return gqsp_compute_angles[{d}](p,q);}}"
    else:
        complement, samples, bound = numpy_complement(polynomial)
        q_literal = "(" + ",".join(repr(complex(z)).replace("j", "i") for z in complement) + ")"
        source += f"q := {q_literal}:!ℂ^{d+1};return gqsp_compute_angles[{d}](p,q);}}"
        print(f"NumPy degree-{d} complement: FFT {samples}, continuous residual bound {bound:.3g}")
    started = time.monotonic()
    angles = classical_value(run_silq(silq, source, timeout=600))
    print(f"Native degree-{d} angle synthesis: {time.monotonic()-started:.1f}s")
    return angles


def verify_source_polynomials(silq, full_native=False, polynomial_output=None):
    started = time.monotonic()
    output = polynomial_output or run_silq(silq, POLYNOMIAL_PROBE, (196, 251))
    values = classical_value(output)
    print(f"Native degree-392/502 coefficients: {'reusing emitted output' if polynomial_output else str(round(time.monotonic()-started,1))+'s'}")
    k, l, raw_kr, raw_kp, reflection, cleanup = values
    assert (k, l) == (196, 251)
    raw_kr, raw_kp = np.asarray(raw_kr, complex), np.asarray(raw_kp, complex)
    reflection, cleanup = np.asarray(reflection, complex), np.asarray(cleanup, complex)
    # These independent classical syntheses can run on separate CPU cores.
    with ThreadPoolExecutor(max_workers=2) as pool:
        kr_future = pool.submit(native_angles, silq, reflection, full_native)
        kp_future = pool.submit(native_angles, silq, cleanup, full_native)
        kr_angles, kp_angles = kr_future.result(), kp_future.result()
    x = np.concatenate(([0, 1 / 85], np.linspace(1 / 85, 1, 4097)))
    y = (2 * x * x - (1 + 85**-2)) / (1 - 85**-2)
    denominator_kr = chebval(-(1 + 85**-2) / (1 - 85**-2), [0] * k + [1])
    denominator_kp = chebval(-(1 + 85**-2) / (1 - 85**-2), [0] * l + [1])
    filter_kr = chebval(y, [0] * k + [1]) / denominator_kr
    filter_kp = chebval(y, [0] * l + [1]) / denominator_kp
    floor = chebval(-1, [0] * k + [1]) / denominator_kr
    expected_kr = (2 * filter_kr + floor - 1) / (1 + floor)
    np.testing.assert_allclose(chebval(x, raw_kr), expected_kr, atol=5e-10)
    np.testing.assert_allclose(chebval(x, raw_kp), filter_kp, atol=5e-10)
    assert np.max(abs(chebval(x[1:], raw_kp))) < 0.0055367

    for name, raw, polynomial, angles in (
        ("reflection", raw_kr, reflection, kr_angles),
        ("cleanup", raw_kp, cleanup, kp_angles),
    ):
        assert np.all(np.isfinite(polynomial))
        assert np.max(abs(polynomial[1::2])) < 1e-13
        # Check source normalization changes only a global amplitude.
        scale = np.vdot(raw, polynomial) / np.vdot(raw, raw)
        np.testing.assert_allclose(polynomial, scale * raw, atol=1e-14)
        assert 0 < scale.real <= 1 and abs(scale.imag) < 1e-14
        z = np.exp(1j * np.linspace(0, 2 * np.pi, 16385))
        peak = np.max(abs(np.polynomial.polynomial.polyval(z, polynomial)))
        assert peak <= 0.90000001
        # Extend the grid check to every angle by the derivative bound.
        derivative_bound = np.dot(np.arange(len(polynomial)), abs(polynomial))
        certificate = min(sum(abs(polynomial)), peak + np.pi * derivative_bound / 16384)
        assert certificate <= 0.90000001
        error = verify_angles(polynomial, angles)
        print(f"Native {name}: degree {len(polynomial)-1}, unit-circle sampled peak "
              f"{peak:.9f}, synthesized angle error {error:.3g}")
    return reflection, cleanup


def verify_native_pipeline(silq):
    output = run_silq(silq, NATIVE_PIPELINE_PROBE)
    actual = zero_ancilla_vector(output, 4)
    matrix = np.eye(4)
    c, s = np.cos(0.35), np.sin(0.35)
    matrix[:2, :2] = np.array([[c, -s], [s, c]]) @ np.diag([0.5, 0.25])
    rhs = np.array([0, 1, 0, 0])
    augmented = matrix.copy()
    augmented[-1, -1] = 1 / 3
    augmented_rhs = (rhs + np.array([0, 0, 0, 1])) / np.sqrt(2)
    gt = (np.eye(4) - np.outer(augmented_rhs, augmented_rhs)) @ augmented
    reflected = even_transform(gt, [0.3, 0, -0.2, 0, 0.1])[:, -1]
    reflected[-1] = 0
    g = (np.eye(4) - np.outer(rhs, rhs)) @ matrix
    expected = even_transform(g, [0.4, 0, -0.3, 0, 0.1]) @ reflected
    # Simulator output prints six significant figures.
    np.testing.assert_allclose(actual, expected, atol=8e-7)
    assert abs(actual[-1]) < 1e-10 and abs(actual[0]) > 1e-4
    print("Native nonnormal circuit: KR, reserved-state rejection and cleanup match right-SVD operator")


def verify_native_postselection(silq):
    source = NATIVE_PIPELINE_PROBE.split("def main(){", 1)[0] + """\
def main(){
    qs := qlss[2,1](3,4,4,0.1,0.05,f,b);
    return (0:uint[1] as 𝔹^1,qs);
}
"""
    actual = zero_ancilla_vector(run_silq(silq, source), 4)
    c, s = np.cos(0.35), np.sin(0.35)
    matrix = np.eye(4)
    matrix[:2, :2] = np.array([[c, -s], [s, c]]) @ np.diag([0.5, 0.25])
    target = np.linalg.solve(matrix, np.array([0, 1, 0, 0]))
    # A missing final cleanup measurement would leave probability outside anc=0.
    assert abs(np.linalg.norm(actual) - 1) < 2e-6
    assert distance_up_to_phase(actual, target) < 0.05
    print("Native complete small solver: final postselection returns normalized solution and clean ancillas")


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--silq", default="silq")
    parser.add_argument("--full-native-synthesis", action="store_true",
                        help="also run large complementary-polynomial FFTs in the Silq interpreter")
    args = parser.parse_args()
    reflection, cleanup = verify_source_polynomials(args.silq, args.full_native_synthesis)
    verify_history(reflection, cleanup)
    verify_native_pipeline(args.silq)
    verify_native_postselection(args.silq)


if __name__ == "__main__":
    main()
