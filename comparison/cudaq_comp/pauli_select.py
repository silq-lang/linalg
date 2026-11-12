"""CUDA-Q Algorithms partner for ``pauli_select.slq``."""

import cudaq
from cudaq_algorithms import PauliLCU
from cudaq_algorithms.pauli_lcu import select


_ENCODING = PauliLCU({"ZZ": 0.5, "XI": -0.3, "XZ": 0.2})
_, _CONTROLS, _OPS, _LENGTHS, _SIGNS = _ENCODING.kernel_args


@cudaq.kernel
def _benchmark():
    ancilla = cudaq.qvector(2)
    system = cudaq.qvector(2)
    h(ancilla)
    h(system)
    select(ancilla, system, _CONTROLS, _OPS, _LENGTHS, _SIGNS)


def build_kernel():
    return _benchmark


def known_angles() -> list[float]:
    return []
