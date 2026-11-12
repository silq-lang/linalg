"""Qrisp implementation of the exact GQSP sequence used by plain_gqet.slq."""

from __future__ import annotations

import math
from collections.abc import Callable, Sequence

import numpy as np
from qrisp import QuantumFloat, control, gphase, invert, reflection, ry, rz, x
from qrisp.block_encodings import BlockEncoding


LCU_PHASE = 0.0


def signal_rotation(flag, theta: float, phi: float) -> None:
    """Apply Silq's Rz(phi) Ry(theta) Rz(-phi) signal rotation."""
    rz(phi, flag)
    ry(theta, flag)
    rz(-phi, flag)


def silq_prepare(qubits: Sequence, amplitudes: Sequence[float]) -> None:
    """Reproduce the recursive real state preparation in pauli_lcu.slq."""
    values = np.asarray(amplitudes, dtype=float)
    norm = float(np.linalg.norm(values))
    if norm == 0:
        return
    values = values / norm
    if len(qubits) == 1:
        ry(2 * math.acos(float(np.clip(values[0], -1.0, 1.0))), qubits[0])
        return
    midpoint = len(values) // 2
    lower = values[:midpoint]
    upper = values[midpoint:]
    lower_norm = float(np.linalg.norm(lower))
    ry(2 * math.acos(float(np.clip(lower_norm, -1.0, 1.0))), qubits[-1])
    with control(qubits[-1], ctrl_state=0):
        silq_prepare(qubits[:-1], lower)
    with control(qubits[-1], ctrl_state=1):
        silq_prepare(qubits[:-1], upper)


def matched_lcu(coefficients: Sequence[float], unitaries: Sequence[Callable]) -> BlockEncoding:
    """Build the same real Hermitian PREP-SELECT-PREP^dagger LCU as Silq."""
    coefficients = np.asarray(coefficients, dtype=float)
    if len(coefficients) != len(unitaries) or np.any(coefficients < 0):
        raise ValueError("matched LCU expects one non-negative coefficient per unitary")
    width = max(1, (len(coefficients) - 1).bit_length())
    padded = np.pad(coefficients, (0, 2**width - len(coefficients)))
    alpha = float(np.sum(padded))
    amplitudes = np.sqrt(padded / alpha)
    completion_phase = LCU_PHASE

    def unitary(index, operand):
        qubits = [index[position] for position in range(width)]
        silq_prepare(qubits, amplitudes)
        for value, selected in enumerate(unitaries):
            with control(index, ctrl_state=value):
                selected(operand)
        with invert():
            silq_prepare(qubits, amplitudes)
        if completion_phase:
            gphase(completion_phase, operand[0])

    return BlockEncoding(
        alpha,
        [QuantumFloat(width).template()],
        unitary,
        num_ops=1,
        is_hermitian=True,
    )


def apply_plain_gqsp(
    flag,
    unitary: Callable[[], None],
    theta: Sequence[float],
    phi: Sequence[float],
    rho: float,
    *,
    k: int = 0,
) -> None:
    """Apply exactly the forward/inverse sequence in Silq plain_gqsp[k][d]."""
    if len(theta) != len(phi):
        raise ValueError("theta and phi must have equal length")
    degree = len(theta) - 1
    signal_rotation(flag, theta[0], phi[0])
    for index in range(1, degree - k + 1):
        with control(flag, ctrl_state=0):
            unitary()
        signal_rotation(flag, theta[index], phi[index])
    for index in range(degree - k + 1, degree + 1):
        with control(flag, ctrl_state=1):
            with invert():
                unitary()
        signal_rotation(flag, theta[index], phi[index])
    gphase(rho, flag)


def qubitized_walk(block_encoding, ancillas, operand) -> None:
    """Apply U followed by the all-zero ancilla reflection, as in Silq."""
    block_encoding.unitary(*ancillas, operand)
    reflection(list(ancillas))


def hermitianized_walk(side, block_encoding, ancillas, operand) -> None:
    """Apply the exact hermitianized walk used by Silq plain_gqsvt."""
    x(side)
    with control(side, ctrl_state=0):
        qubitized_walk(block_encoding, ancillas, operand)
    with control(side, ctrl_state=1):
        with invert():
            block_encoding.unitary(*ancillas, operand)
        reflection(list(ancillas))
