"""Five-qubit QFT using CUDA-Q Algorithms' public QFT primitive."""

import cudaq

from cudaq_algorithms.primitives import qft


@cudaq.kernel
def qft_benchmark():
    state = cudaq.qvector(5)
    for index in range(5):
        ry((index + 1) * 3.141592653589793 / 11.0, state[index])
        rz((index + 1) * 3.141592653589793 / 13.0, state[index])
    qft(state)
    # cudaq_algorithms.qft deliberately omits the final bit reversal.
    for index in range(2):
        swap(state[index], state[4 - index])


def build_kernel():
    return qft_benchmark


if __name__ == "__main__":
    print(cudaq.translate(build_kernel(), format="openqasm2"))
