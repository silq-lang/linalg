"""Tridiagonal block encoding using CUDA-Q Algorithms' PauliLCU."""

import cudaq

from cudaq_algorithms import PauliLCU


USE_TRACE_EXPORT = True
ENCODING = PauliLCU([
    (0.5, "II"),
    (-0.25, "XI"),
    (-0.125, "XX"),
    (-0.125, "YY"),
])


@cudaq.kernel
def prepare_operand(state: cudaq.qview):
    ry(3.141592653589793 / 7.0, state[0])
    ry(3.141592653589793 / 9.0, state[1])


def build_kernel():
    return ENCODING.encode_kernel(state_prep=prepare_operand)


def trace_angles():
    prep = ENCODING.kernel_args[0]
    return (3.141592653589793 / 7.0, 3.141592653589793 / 9.0,
            *prep, *(-value for value in prep))


if __name__ == "__main__":
    print(cudaq.translate(build_kernel(), format="openqasm2"))
