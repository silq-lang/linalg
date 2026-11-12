"""CUDA-Q Algorithms partner for ``slater.slq``."""

import math

import cudaq
import numpy as np
from cudaq_algorithms import stateprep


_MATRIX = np.asarray([
    [math.cos(math.pi / 6.0), 0.0],
    [0.0, math.cos(math.pi / 4.0)],
    [-math.sin(math.pi / 6.0), 0.0],
    [0.0, -math.sin(math.pi / 4.0)],
])
_SCHEDULE = stateprep.make_givens_rotation_schedule(_MATRIX)
_PREPARE = stateprep.slater_determinant_kernel(_SCHEDULE)


@cudaq.kernel
def _benchmark():
    qubits = cudaq.qvector(4)
    _PREPARE(qubits)


def build_kernel():
    return _benchmark


def known_angles() -> list[float]:
    return [rotation.theta for rotation in _SCHEDULE.rotations]
