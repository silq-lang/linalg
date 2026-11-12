"""CUDA-Q Algorithms partner for ``comparator.slq``."""

import cudaq
from cudaq_algorithms.primitives import cmp_ge_constant


_COMPLEMENT_BITS = [0, 1, 0, 1, 1]  # 2^5 - 6 = 26, little endian.


@cudaq.kernel
def _benchmark():
    value = cudaq.qvector(5)
    work = cudaq.qvector(5)
    carry = cudaq.qvector(1)
    flag = cudaq.qvector(1)
    h(value)
    cmp_ge_constant(value, _COMPLEMENT_BITS, 0, work, carry, flag)
    x(flag[0])  # Convert x >= 6 into x < 6.


def build_kernel():
    return _benchmark


def known_angles() -> list[float]:
    return []
