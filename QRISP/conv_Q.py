import numpy as np
from qrisp import *
from qrisp.gqsp import convolve

from resource_evaluator import evaluate_quantum_program, print_report

p = np.array([0.07, 0.35, 0.35, 0.2])


def qs_prep():
    qs = QuantumFloat(2)

    h(qs[0])

    return qs


def program():
    qs = qs_prep()

    anc = convolve(qs, p)

    return qs, anc


report = evaluate_quantum_program(
    program,
    label="Convolution resources for p=(0.07,0.35,0.35,0.2)",
)

print_report(report)


@RUS
def conv_qs_prep():
    qs = qs_prep()

    anc = convolve(qs, p)

    success_bool = measure(anc) == 0

    reset(anc)
    anc.delete()

    return success_bool, qs


@terminal_sampling
def main():
    qs_conv = conv_qs_prep()
    return qs_conv


res_dict = main()

print()
print("sampled output probabilities:")
print(res_dict)

print()
print("amplitudes, rescaled by max probability:")
max_ = max(res_dict.values())
amps = np.sqrt([
    res_dict.get(k, 0) / max_
    for k in range(4)
])
print(amps)