"""CUDA-Q Algorithms partner for ``qroam.slq``."""

import cudaq
from cudaq_algorithms.primitives import QROM


_LOOKUP = QROM(
    [0, 1, 2, 3, 1, 0, 3, 2],
    address_bits=3,
    output_bits=2,
    variant="select_swap",
    block_size=2,
)
_KERNEL = _LOOKUP.kernel
_LADDER = _LOOKUP.num_ladder


@cudaq.kernel
def _benchmark():
    address = cudaq.qvector(3)
    h(address)
    ladder = cudaq.qvector(_LADDER)
    output = cudaq.qvector(2)
    _KERNEL(address, ladder, output)


def build_kernel():
    return _benchmark


def known_angles() -> list[float]:
    return []
