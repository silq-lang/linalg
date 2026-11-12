"""CUDA-Q Algorithms partner for ``givens.slq``."""

import math

import cudaq
from cudaq_algorithms import stateprep


@cudaq.kernel
def _benchmark():
    qubits = cudaq.qvector(2)
    h(qubits)
    stateprep.givens_rotation(qubits, math.pi / 6.0, 0, 1)


def build_kernel():
    return _benchmark


def known_angles() -> list[float]:
    return [math.pi / 6.0]
