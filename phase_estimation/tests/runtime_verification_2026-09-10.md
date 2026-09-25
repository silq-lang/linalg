# Runtime verification — 2026-09-10

Verified after removing `gqsp_degenerate_angles` and its dispatch branch. QRISP was excluded. No production code was changed during this verification.

`gqsp_angles.slq` SHA-256: `e841f23807ae6f998f0cb085ccfb20f19764ca9dbff34b1240f8f7aa28f60f67`.

## Native example entry points

All eleven examples below completed in native Silq. Every emitted state was finite and normalized within the simulator’s six-significant-digit display precision. Numerical comparisons listed below provide additional correctness checks.

| Example | Result | Runtime |
| --- | --- | ---: |
| [matrix_inversion.slq](/Users/crc03/Desktop/slq/GQSVT/matrix_inversion.slq) | Passed; solution-state error 1.55e-6 | 802.7 s |
| [GQSVT/matrix_poly.slq](/Users/crc03/Desktop/slq/GQSVT/matrix_poly.slq) | Passed | 5.9 s |
| [GQSVT/hamiltonian_simulation.slq](/Users/crc03/Desktop/slq/GQSVT/hamiltonian_simulation.slq) | Passed | 11.4 s |
| [GQSVT/multi_GQET.slq](/Users/crc03/Desktop/slq/GQSVT/multi_GQET.slq) | Passed | 16.1 s |
| [state_prep/poly_prep.slq](/Users/crc03/Desktop/slq/state_prep/poly_prep.slq) | Passed | 6.2 s |
| [state_prep/convolution.slq](/Users/crc03/Desktop/slq/state_prep/convolution.slq) | Passed | 6.3 s |
| [applications/ode_solver.slq](/Users/crc03/Desktop/slq/applications/ode_solver.slq) | Passed | 27.9 s |
| [Amplitude_Amplification/singular_value_amp.slq](/Users/crc03/Desktop/slq/Amplitude_Amplification/singular_value_amp.slq) | Passed | 21.5 s |
| [GQSVT/log_unitary.slq](/Users/crc03/Desktop/slq/GQSVT/log_unitary.slq) | Passed | 71.4 s |
| [GQSVT/threshold.slq](/Users/crc03/Desktop/slq/GQSVT/threshold.slq) | Passed | 65.5 s |
| [GQSVT/augmentation.slq](/Users/crc03/Desktop/slq/GQSVT/augmentation.slq) | Passed; solution-state error 3.16e-07 | 290.6 s |

## Numerical checks

- Native inverse main: normalized state approximately `[0.3162262982483128, 0.9486837873054271]`, phase-invariant error `1.54716347349e-06`, success probability `0.0338386175075`.
- Native augmentation main: normalized solution agrees with `(1,3,0,0)/sqrt(10)` to state error `3.16e-7`.
- `matrix_poly`: successful branch matches `0.9 T2` of the encoded matrix.
- Hamiltonian simulation: normalized state error `2.46e-6` against the exact matrix exponential.
- Bivariate GQET: polynomial-action error `6.21e-11`.
- Logarithm example: normalized state error `9.33e-7`.
- ODE example: normalized state error `6.68e-8`.
- Threshold example: polynomial-action error `3.89e-7`.
- Convolution: successful branch matches the specified cyclic convolution within `8e-7`.

## Targeted regressions

- Passed: normalization bounds.
- Passed: GQET/GQSVT circuits.
- Passed: bivariate GQET circuit.
- Passed: native complement and INLFFT.
- Passed: inverse polynomial and circuit fixture.
- Passed: augmented kernel and cleanup circuit.
- Passed: complete small augmented solver.
- Passed: history embedding and RHS circuits.
- Passed: history coefficients and numerical SVD.

All 18 affected modules typechecked individually.

## Coverage limits

The full 64-step `eigen_solver` main and the MaxCut main were not simulated end to end. History coefficients, small native embedding/RHS circuits, and the 64-step classical SVD comparison passed. The additional full complex nonnormal inverse rerun was intentionally cancelled after the main inverse passed; the native nonnormal augmented-circuit regression passed.

The roughly 13-minute inverse runtime explains the earlier 300-second timeout; this successful run used the restored native complement routine.
