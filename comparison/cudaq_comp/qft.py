"""CUDA-Q Algorithms partner for ``qft.slq``."""

import math

import cudaq
from cudaq_algorithms.primitives import qft


@cudaq.kernel
def _benchmark():
    qubits = cudaq.qvector(5)
    for j in range(5):
        ry((j + 1) * math.pi / 11.0, qubits[j])
        rz((j + 1) * math.pi / 13.0, qubits[j])
    qft(qubits)
    # cudaq_algorithms.qft intentionally omits the final bit reversal.
    # Silq's QFT returns the conventional output ordering, so include it here.
    for j in range(2):
        swap(qubits[j], qubits[4 - j])


def build_kernel():
    return _benchmark


def known_angles() -> list[float]:
    values = [math.pi / 2, math.pi / 4, math.pi / 8, math.pi / 16]
    values.extend((j + 1) * math.pi / 11.0 for j in range(5))
    values.extend((j + 1) * math.pi / 13.0 for j in range(5))
    return values
