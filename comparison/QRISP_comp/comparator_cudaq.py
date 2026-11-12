"""Five-bit x < 6 using CUDA-Q Algorithms' public CDKM comparator."""

import cudaq

from cudaq_algorithms.primitives import cmp_ge_constant


USE_TRACE_EXPORT = True


@cudaq.kernel
def comparator_benchmark(complement_of_six: list[int]):
    value = cudaq.qvector(5)
    work = cudaq.qvector(5)
    carry = cudaq.qvector(1)
    flag = cudaq.qvector(1)
    for index in range(5):
        h(value[index])
    cmp_ge_constant(value, complement_of_six, 0, work, carry, flag)
    x(flag[0])  # x < 6 is the complement of x >= 6.


def build_kernel():
    return comparator_benchmark


def kernel_arguments():
    # Little-endian bits of 2^5 - 6 = 26.
    return ([0, 1, 0, 1, 1],)


def trace_angles():
    return ()


if __name__ == "__main__":
    print(cudaq.translate(build_kernel(), format="openqasm2"))
