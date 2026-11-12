"""Four-bit addition using CUDA-Q Algorithms' public CDKM adder."""

import cudaq

from cudaq_algorithms.primitives import add_register


@cudaq.kernel
def qq_adder_benchmark():
    addend = cudaq.qvector(4)
    target = cudaq.qvector(4)
    carry = cudaq.qvector(1)
    for index in range(4):
        h(addend[index])
    x(target[1])
    add_register(addend, target, carry)


def build_kernel():
    return qq_adder_benchmark


if __name__ == "__main__":
    print(cudaq.translate(build_kernel(), format="openqasm2"))
