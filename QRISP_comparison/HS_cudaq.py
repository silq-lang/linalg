"""Fourteen-step TFIM product formula using CUDA-Q Algorithms' Trotter."""

import cudaq

from cudaq_algorithms import Trotter


USE_TRACE_EXPORT = True


@cudaq.kernel
def prepare_operand(state: cudaq.qview):
    ry(3.141592653589793 / 7.0, state[0])
    ry(3.141592653589793 / 9.0, state[1])


def build_kernel():
    evolution = Trotter([(-0.25, "ZZ"), (0.5, "XI"), (0.5, "IX")])
    return evolution.kernel(time=3.141592653589793 / 4.0,
                            steps=14, order=1,
                            state_prep=prepare_operand)


def trace_angles():
    pi = 3.141592653589793
    return (pi / 7.0, pi / 9.0, -pi / 112.0, pi / 56.0)


if __name__ == "__main__":
    print(cudaq.translate(build_kernel(), format="openqasm2"))
