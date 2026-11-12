"""CUDA-Q Algorithms partner for ``trotter.slq``."""

from cudaq_algorithms import Trotter


_TERMS = {"ZZ": 0.5, "XI": 0.3, "IY": 0.2}


def build_kernel():
    return Trotter(_TERMS).kernel(time=1.0, steps=2, order=2)


def known_angles() -> list[float]:
    return [0.05, 0.075, 0.1, 0.125, 0.15, 0.25]
