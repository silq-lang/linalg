# Plain Silq versus CUDA-Q Algorithms

Unitary rows use qasmviz Clifford+T synthesis (`--opt 3 --eps 1e-6`).

| Benchmark | Silq width | Silq depth | Silq T | CUDA-Q width | CUDA-Q depth | CUDA-Q T |
|---|---:|---:|---:|---:|---:|---:|
| Quantum Fourier transform, 5 qubits | 7 | 996 | 902 | 5 | 2227 | 1379 |
| Adjacent Givens rotation, 2 qubits | 2 | 163 | 124 | 2 | 175 | 124 |
| Real Slater determinant, 4 orbitals / 2 electrons | 4 | 174 | 126 | 4 | 335 | 126 |
| In-place register addition, 4+4 qubits | 8 | 52 | 8 | 9 | 74 | 36 |
| Constant comparator ($x<6$), 5-bit input | 8 | 71 | 20 | 12 | 109 | 55 |
| Second-order product formula, 2 steps | 2 | 496 | 373 | 2 | 516 | 380 |
| Paper QROAM, 8 two-bit entries, block size 2 | 8 | 163 | 63 | 11 | 93 | 52 |
| Pauli-LCU PREPARE, 3 terms | 2 | 367 | 194 | 2 | 367 | 194 |
| Signed Pauli-LCU SELECT, 3 terms | 5 | 163 | 30 | 5 | 106 | 50 |
| Pauli-LCU qubitization walk, power 2 | 9 | 2261 | 922 | 5 | 2912 | 1726 |
| Degree-3 QSVT sequence | 6 | 3822 | 1524 | 5 | 5222 | 3233 |

- T includes T and T-dagger gates.
- The QQ-adder row retains Silq's mid-circuit measurement/feed-forward and is costed in exact Clifford+T without unitary-only optimization; CUDA-Q uncomputes its carry coherently.
- PREPARE, SELECT, Walk, and QSVT use the same Pauli LCU with alpha=1.
- Silq QROAM reports the worst-case complete adaptive branch; min/average/max branch metrics are stored in `outputs/results.json`.
- CUDA-Q reports its complete coherent built-in QROM; Silq uses the paper's measurement-based uncomputation.
- State equivalence is recorded in `outputs/state_verification.json`.
