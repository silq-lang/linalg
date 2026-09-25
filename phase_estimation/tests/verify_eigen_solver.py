#!/usr/bin/env python3

import argparse
import ast
import math
from pathlib import Path
import re
import subprocess
import tempfile

import numpy as np


IMPORT_ROOT = Path(__file__).resolve().parents[2]

HISTORY_PROBE = """\
import phase_estimation.eigen_solver;
import block_encodings.symtwobytwo;
def matrix(anc:𝔹^2,xs:𝔹^1)mfree{return twosym_block(anc,xs,1/4,0);}
def b(xs:𝔹^1)mfree{return xs;}
def main(){
    (clock,xs) := chebyshev_history_state[2][2,1](6,7,8,1e-1,2e-2,matrix,b);
    return (clock,xs);
}
"""

QFT_PROBE = """\
import phase_estimation.QFT;
def main(m:!ℕ){clock := m as uint[3] as 𝔹^3;clock := QFT(clock);return semiclassical_qft[3](clock);}
"""


def run_silq(silq, source, argument=None, timeout=600):
    with tempfile.TemporaryDirectory(prefix="eigen_solver_check_") as folder:
        path = Path(folder) / "probe.slq"
        path.write_text(source, encoding="utf-8")
        command = [silq, str(path), "--seed=271828", "--coords=cartesian", "--style=compact"]
        command.append("--run" if argument is None else "--run-on=" + str(argument))
        result = subprocess.run(command, cwd=IMPORT_ROOT, capture_output=True,
                                text=True, timeout=timeout)
    if result.returncode:
        raise RuntimeError(result.stderr or result.stdout)
    return result.stdout.strip()


def verify_angles(p, angles):
    theta, phi, phase = angles
    z = np.exp(1j * np.linspace(0, 2 * np.pi, 1025))
    upper, lower = np.ones(len(z), complex), np.zeros(len(z), complex)
    for j, (angle, azimuth) in enumerate(zip(theta, phi)):
        if j:
            upper *= z
        c = np.cos(angle / 2)
        s = np.sin(angle / 2) * np.exp(1j * azimuth)
        upper, lower = c * upper - s * lower, s.conjugate() * upper + c * lower
    upper *= np.exp(1j * phase)
    error = np.max(abs(upper - np.polynomial.polynomial.polyval(z, p)))
    assert error < 1e-8, error
    return error


def history_vector(output):
    vector = np.zeros(8, complex)
    terms = re.findall(r"\(([^()]+)\)·\|([^⟩]+)⟩", output)
    assert terms, output
    for amplitude, basis in terms:
        clock, system = ast.literal_eval(basis)
        clock_index = sum(bit << j for j, bit in enumerate(clock))
        system_index = sum(bit << j for j, bit in enumerate(system))
        vector[2 * clock_index + system_index] = complex(amplitude.replace("i", "j"))
    return vector


def verify_history_state(silq):
    actual = history_vector(run_silq(silq, HISTORY_PROBE))
    chebyshev = np.array([1 / 2, 1 / 8, -31 / 32, -47 / 128])
    expected = np.zeros(8)
    expected[::2] = chebyshev / np.linalg.norm(chebyshev)
    overlap = np.vdot(expected, actual)
    error = np.linalg.norm(actual * np.exp(-1j * np.angle(overlap)) - expected)
    np.testing.assert_allclose(np.linalg.norm(actual), 1, atol=2e-6)
    assert error < 2e-2, error
    assert abs(actual[6]) > 0.2
    print(f"Native history state error {error:.6g}; all four clock entries preserved")


def verify_semiclassical_qft(silq):
    for value in range(8):
        assert int(run_silq(silq, QFT_PROBE, value)) == value
    print("Semiclassical QFT recovered all eight three-bit Fourier phases")


def verify_single_history_example():
    size = 16
    alpha = 1 / (2 * math.sqrt(2 - math.sqrt(2)))
    encoded = 1 / (4 * alpha)
    theta = math.acos(encoded)
    history = np.array([math.cos(j * theta) for j in range(size)])
    history[0] = 1 / 2
    probabilities = abs(np.fft.fft(history / np.linalg.norm(history), norm="ortho")) ** 2
    folded = np.zeros(size // 2 + 1)
    for sample, probability in enumerate(probabilities):
        folded[min(sample, size - sample)] += probability
    mode = int(np.argmax(folded))
    estimate = alpha * math.cos(2 * math.pi * mode / size)
    assert mode == 3
    np.testing.assert_allclose(estimate, 1 / 4, atol=1e-15)
    np.testing.assert_allclose(folded[mode], 225 / 232, atol=1e-14)
    print(f"Ideal rescaled history targets bin {mode}/16 with probability {folded[mode]:.6f}")


def verify_direct_solver(silq):
    source = (IMPORT_ROOT / "GQSVT/augmentation.slq").read_text().split("\ndef main(){", 1)[0]
    source += """
def main(){
    def b(xs:𝔹^1) mfree{xs[0] := X(xs[0]);return xs;}
    def matrix(anc:𝔹^1,xs:𝔹^1) mfree{return (anc,xs);}
    results := vector(3,0:!ℕ);
    for j in [0..3){results[j] = measure(qlss[1,1](1,1,2,1e-1,1e-1,matrix,b)) as !uint[1] as !ℕ;}
    return results;
}
"""
    assert tuple(ast.literal_eval(run_silq(silq, source, timeout=20))) == (1, 1, 1)
    print("Three native direct solves passed")


def verify_estimator_readout(silq):
    source = (IMPORT_ROOT / "phase_estimation/eigen_solver.slq").read_text()
    start = source.index("def eigenvalue_estimator[")
    source = source[start:source.index("\ndef main(){", start)]
    readout = """        (clock,xs) := chebyshev_history_state[ν][m,n](L,R,κ,η,ϵ,f,b);
        sample := semiclassical_qft[ν](clock);
        measure(xs);"""
    assert source.count(readout) == 1
    body = source[source.index("{\n") + 2:]
    body = body.replace(readout, "        sample := samples[j];\n        print(1002);")
    for samples in ([0, 0, 14, 13, 12], [3, 13, 3], [0, 4, 8, 12], [13]):
        probe = f"def main(samples:!ℕ^{len(samples)}){{\n"
        probe += f"    shots := {len(samples)}:!ℕ;ν := 4:!ℕ;α := 1:!ℝ;\n" + body
        output = run_silq(silq, probe, tuple(samples)).splitlines()
        assert output.count("1002") == len(samples), output
        counts = np.bincount([min(j, 16 - j) for j in samples], minlength=9)
        phase = np.argmax(counts) / 16
        expected = (phase, math.cos(2 * math.pi * phase))
        np.testing.assert_allclose(ast.literal_eval(output[-1]), expected, atol=1e-6)
    print("Histogram readout passed folded-phase, tie, even-shot, and single-shot cases")


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--silq", default="silq")
    args = parser.parse_args()
    verify_direct_solver(args.silq)
    verify_estimator_readout(args.silq)
    verify_history_state(args.silq)
    verify_semiclassical_qft(args.silq)
    verify_single_history_example()


if __name__ == "__main__":
    main()
