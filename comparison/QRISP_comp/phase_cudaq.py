"""CUDA-Q five-qubit multi-controlled phase benchmark."""

import math
import cudaq


def build_kernel():
    kernel = cudaq.make_kernel()
    controls = kernel.qalloc(4)
    target = kernel.qalloc()
    for index in range(4):
        kernel.h(controls[index])
    kernel.x(target)
    kernel.cr1(math.pi / 4, controls, target)
    return kernel


if __name__ == "__main__":
    print(cudaq.translate(build_kernel(), format="openqasm2"))
