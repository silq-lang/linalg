"""CUDA-Q Algorithms partner for ``qsvt.slq``."""

import cudaq
from cudaq_algorithms import PauliLCU, PhaseSequence, QSVT


_TERMS = {"ZZ": 0.5, "XI": -0.3, "XZ": 0.2}
_PHASES = [0.3, -0.7, 1.1, 0.4]


@cudaq.kernel
def _zero_state(qubits: cudaq.qview):
    pass


def build_kernel():
    encoding = PauliLCU(_TERMS)
    sequence = PhaseSequence(_PHASES, walk_directions=[0, 1, 0])
    return QSVT(encoding).kernel(sequence, state_prep=_zero_state)


def known_angles() -> list[float]:
    return [*PauliLCU(_TERMS).kernel_args[0], *_PHASES]
