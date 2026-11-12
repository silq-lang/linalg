"""CUDA-Q Algorithms partner for ``qq_adder.slq``."""

import cudaq
from cudaq_algorithms.primitives import add_register


@cudaq.kernel
def _benchmark():
    addend = cudaq.qvector(4)
    target = cudaq.qvector(4)
    carry = cudaq.qvector(1)
    h(addend)
    x(target[1])
    add_register(addend, target, carry)


def build_kernel():
    return _benchmark


def known_angles() -> list[float]:
    return []
