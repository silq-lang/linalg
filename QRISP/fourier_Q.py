import os
os.environ["QRISP_SIMULATOR_FLOAT_THRESH"] = "1e-10"

import numpy as np
from qrisp import *
from qrisp.gqsp import fourier_series_loader

from resource_evaluator import evaluate_quantum_program, print_report


def f(x):
    return 3 + 2 * np.cos(2 * np.pi * x) - np.sin(4 * np.pi * x)

n = 6

k = 5

N_samples = 2**n
x_vals = np.arange(N_samples) / N_samples

signal = f(x_vals)
signal = signal / np.linalg.norm(signal)


def resource_program():
    qv = QuantumFloat(n)
    anc = fourier_series_loader(qv, signal, k=k)
    return qv, anc


report = evaluate_quantum_program(
    resource_program,
    label="Fourier series loader resources: 6 data qubits, 5 Fourier modes",
)

print_report(report)