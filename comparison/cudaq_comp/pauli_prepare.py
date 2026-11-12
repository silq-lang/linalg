"""CUDA-Q Algorithms partner for ``pauli_prepare.slq``."""

import cudaq
from cudaq_algorithms import PauliLCU


_ENCODING = PauliLCU({"ZZ": 0.5, "XI": -0.3, "XZ": 0.2})
_PREPARE = _ENCODING.prepare_kernel()


@cudaq.kernel
def _benchmark():
    ancilla = cudaq.qvector(2)
    _PREPARE(ancilla)


def build_kernel():
    return _benchmark


def known_angles() -> list[float]:
    return list(_ENCODING.kernel_args[0])
