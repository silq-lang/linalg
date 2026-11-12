"""CUDA-Q Algorithms partner for ``walk.slq``."""

import cudaq
from cudaq_algorithms import PauliLCU, Walk


_TERMS = {"ZZ": 0.5, "XI": -0.3, "XZ": 0.2}


@cudaq.kernel
def _zero_state(qubits: cudaq.qview):
    pass


def build_kernel():
    return Walk(PauliLCU(_TERMS)).kernel(
        power=2, uncompute=True, state_prep=_zero_state
    )


def known_angles() -> list[float]:
    return list(PauliLCU(_TERMS).kernel_args[0])
