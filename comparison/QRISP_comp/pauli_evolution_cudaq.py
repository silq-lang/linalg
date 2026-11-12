"""Two-term product formula using CUDA-Q Algorithms' Trotter factory."""

import cudaq

from cudaq_algorithms import Trotter


USE_TRACE_EXPORT = True


@cudaq.kernel
def prepare_operand(state: cudaq.qview):
    h(state[0])
    h(state[2])
    ry(3.141592653589793 / 3.0, state[4])
    x.ctrl(state[0], state[1])
    x.ctrl(state[2], state[3])
    x.ctrl(state[1], state[4])
    rx(3.141592653589793 / 5.0, state[3])


def build_kernel():
    evolution = Trotter([
        (3.141592653589793 / 6.0, "XYZXI"),
        (-3.141592653589793 / 5.0, "ZYXIX"),
    ])
    return evolution.kernel(time=1.0, steps=1, order=1,
                            state_prep=prepare_operand)


def trace_angles():
    pi = 3.141592653589793
    return (pi / 3.0, pi / 5.0, -pi / 5.0,
            pi / 2.0, -pi / 2.0, -2.0 * pi / 5.0)


if __name__ == "__main__":
    print(cudaq.translate(build_kernel(), format="openqasm2"))
