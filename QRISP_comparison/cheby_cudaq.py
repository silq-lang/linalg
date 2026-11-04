"""TFIM T_2 transform using CUDA-Q Algorithms' PauliLCU walk factory."""

import cudaq

from cudaq_algorithms import PauliLCU

from TFIM_cudaq import ENCODING, prepare_operand, trace_angles


USE_TRACE_EXPORT = True


def build_kernel():
    # PauliLCU.walk_kernel(power=2) has all-zero block T_2(H / alpha).
    return ENCODING.walk_kernel(power=2, state_prep=prepare_operand)


if __name__ == "__main__":
    print(cudaq.translate(build_kernel(), format="openqasm2"))
