"""CUDA-Q Algorithms' official QSVT Hamiltonian-simulation workflow.

The phase preprocessing is the Jacobi--Anger/QSPPACK procedure from NVIDIA's
``02_hamiltonian_simulation.py`` example at the pinned repository commit. The
quantum circuits themselves are produced by the public ``QSVT.kernel`` API.
CUDA-Q's documented recovery runs the cosine and sine circuits separately and
combines their good-subspace vectors classically.
"""

from __future__ import annotations

import contextlib
import io

import cudaq
import numpy as np
from scipy import special

from cudaq_algorithms import PauliLCU, PhaseSequence, QSVT


USE_TRACE_EXPORT = True
WORKFLOW_COMPONENTS = ("cos", "sin")
TIME = np.pi / 4.0
DEGREE = 28
ENCODING = PauliLCU([(-0.25, "ZZ"), (0.5, "XI"), (0.5, "IX")])


def jacobi_anger_phases(tau: float, degree: int):
    """NVIDIA example's Jacobi--Anger/QSPPACK preprocessing."""
    import qsppack

    cos_coeffs = np.array(
        [0.5 * special.jv(0, tau)]
        + [((-1) ** k) * special.jv(2 * k, tau)
           for k in range(1, degree // 2 + 1)]
    )
    sin_coeffs = np.array(
        [((-1) ** k) * special.jv(2 * k + 1, tau)
         for k in range(degree // 2)]
    )
    options = {
        "criteria": 1e-12,
        "method": "Newton",
        "typePhi": "full",
        "useReal": True,
    }
    with contextlib.redirect_stdout(io.StringIO()):
        cos_phases, _ = qsppack.solve(
            cos_coeffs, 0, {**options, "targetPre": True}
        )
        sin_phases, _ = qsppack.solve(
            sin_coeffs, 1, {**options, "targetPre": False}
        )
    return tuple(float(value) for value in cos_phases), tuple(
        float(value) for value in sin_phases
    )


COS_PHASES, SIN_PHASES = jacobi_anger_phases(ENCODING.alpha * TIME, DEGREE)


@cudaq.kernel
def prepare_operand(state: cudaq.qview):
    ry(3.141592653589793 / 7.0, state[0])
    ry(3.141592653589793 / 9.0, state[1])


def build_kernels():
    transformer = QSVT(ENCODING)
    return {
        "cos": transformer.kernel(
            PhaseSequence(COS_PHASES, convention="qsp"),
            state_prep=prepare_operand,
        ),
        "sin": transformer.kernel(
            PhaseSequence(SIN_PHASES, convention="qsp"),
            state_prep=prepare_operand,
        ),
    }


def trace_angles(component: str):
    phases = COS_PHASES if component == "cos" else SIN_PHASES
    prepare_angles = ENCODING.kernel_args[0]
    return (
        np.pi / 7.0,
        np.pi / 9.0,
        *(2.0 * value for value in phases),
        *prepare_angles,
        *(-value for value in prepare_angles),
    )


def subnormalization_constant() -> float:
    # recover_real_time_evolution multiplies the two good-subspace components
    # by 2, so each circuit encodes its component with beta=2.
    return 2.0


def workflow_metadata() -> dict:
    return {
        "source": "CUDA-Q Algorithms official Hamiltonian-simulation example",
        "time": float(TIME),
        "tau": float(ENCODING.alpha * TIME),
        "degree": DEGREE,
        "cosine_phase_count": len(COS_PHASES),
        "sine_phase_count": len(SIN_PHASES),
        "recovery": "recover_real_time_evolution (classical combination)",
    }
