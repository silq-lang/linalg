# Silq-Qrisp-CUDA-Q library resource comparison

Unitary rows use qasmviz Clifford+T synthesis (`--opt 3 --eps 1e-06`).
The QQ-adder row retains mid-circuit measurement/feed-forward and is costed in its exact Clifford+T form.
Only plain Silq source is included; there is no hand-optimized Silq column.

| Benchmark | Silq | Qrisp (width-matched workspace) | CUDA-Q |
|---|---:|---:|---:|
| **Circuit-level compiler comparisons** | | | |
| QFT on a generic product state, 5 qubits | width=7, depth=1971, T=1726 | width=7, depth=2702, T=2752 | width=5, depth=4478, T=2742 |
| QPE: pi/4 phase, superposed input, precision=3 | width=6, depth=1045, T=544 | width=6, depth=1623, T=892 | — |
| Amplitude estimation: Ry(pi/3), precision=5 | width=8, depth=4459, T=2318 | width=8, depth=5132, T=2766 | — |
| Quantum-quantum addition, 4 bits | width=8, depth=52, T=8 | width=10, depth=52, T=24 | width=9, depth=77, T=42 |
| Coherent comparison: 5-bit x < 6 | width=8, depth=71, T=20 | width=11, depth=84, T=32 | width=12, depth=109, T=55 |
| Two-term Pauli product formula, 5 qubits | width=5, depth=968, T=503 | width=5, depth=964, T=503 | width=5, depth=971, T=503 |
| Controlled phase: phi=pi/4, 5 qubits | width=11, depth=157, T=49 | width=11, depth=59, T=33 | width=8, depth=972, T=408 |
| TFIM product formula: t=pi/4, 14 steps | width=2, depth=1624, T=1251 | width=2, depth=1624, T=1251 | width=2, depth=1624, T=1251 |
| **Task-level library comparisons** | | | |
| 4x4 non-cyclic tridiagonal block encoding | width=5, depth=1786, T=1045, α=1 | width=6, depth=1367, T=1021, α=1 | width=5, depth=2684, T=1411, α=1 |
| Two-qubit TFIM block encoding | width=5, depth=1730, T=1025, α=1.25 | width=5, depth=2012, T=1023, α=1.25 | width=5, depth=2023, T=1285, α=1.25 |
| Two-qubit Heisenberg block encoding | width=5, depth=961, T=597, α=0.75 | width=6, depth=871, T=587, α=0.75 | width=5, depth=1859, T=1129, α=0.75 |
| TFIM Chebyshev polynomial T_2 | width=9, depth=3597, T=1841, α_in=1.25, β=1 | width=9, depth=3835, T=2197, α_in=1.25, β=1 | width=5, depth=5415, T=3545, α_in=1.25, β=1 |
| TFIM QSP simulation: t=pi/4, target degree 28 | width=11, depth=107944, T=47677, α_in=1.25, β=1 | width=11, depth=86775, T=41094, α_in=1.25, β=1 | width=5, depth=166848, T=103962, α_in=1.25, β=2 |
| 2x2 pseudoinverse: A=[[1,-1/3],[-1/3,1]], epsilon=0.02 | width=5, depth=52262, T=23308, α_in=1.33333, β=3.61616 | width=6, depth=65935, T=28070, α_in=1.33333, β=3.61616 | width=2, depth=2391, T=1122, α_in=1.33333, β=2.17026 |
| Eigenstate filter: lambda=0.65, degree 28 | width=10, depth=51914, T=22444, α_in=2, β=1.01 | width=10, depth=20289, T=10164, α_in=2, β=1.01 | — |
| HHL: A=[[3/4,-1/4],[-1/4,3/4]], b=|1>, precision=3 | width=7, depth=5154, T=2306 | width=7, depth=12113, T=5552 | — |
| Cubic convolution, one coherent attempt | width=4, depth=1363, T=522 | width=4, depth=1358, T=527 | — |
| Fourier loader: 6 qubits, five modes | width=10, depth=9941, T=4210 | width=10, depth=7623, T=5377 | — |

- `T` includes T and T-dagger gates.
- Qrisp is compiled with the largest extra workspace that matches the final plain-Silq width. If Qrisp's workspace=0 circuit is already wider, workspace remains 0. The selected value is stored as `qrisp_workspace` in `outputs/results.json`.
- Operands of symmetric gates (cp, cz, swap) and the controls of ccx/ctrl(k) gates are sorted before costing, for all three frameworks; HQIR emits them in a run-dependent order and qasmviz's optimizer is order-sensitive. Fresh Silq compiles of the four largest task-level rows can still differ by a few percent (see README); --reuse-qasm is exactly reproducible.
- QQ adder: Silq uncomputes carries by measurement (mid-circuit measurement and feed-forward); Qrisp's gidney_adder and CUDA-Q Algorithms' add_register primitive uncompute unitarily. All three are costed in exact Clifford+T without qasmviz optimization, after merging directly adjacent phase gates on the same qubit.
- Full-state rows and the explicitly postselected logical outputs are checked by verify_states.py; the report is outputs/state_verification.json.
- Block-encoding rows apply the encoding to the same generic operand Ry(pi/7) x Ry(pi/9)|00>, so neither compiler can specialize to a known input.
- CUDA-Q QSVT Hamiltonian simulation and pseudoinversion use the public QSVT API plus the phase-generation workflows from NVIDIA's official repository examples, rather than the Silq/Qrisp polynomial. Their reported beta is the resulting subnormalization constant in target/beta. CUDA-Q eigenstate filtering is unavailable because NVIDIA provides no built-in filter or official phase workflow.
- For every block-encoding process, alpha is the encoded-input normalization (<0|U|0> = A/alpha). Transformation rows additionally report beta for the final good-subspace operation target/beta.
- CUDA-Q Hamiltonian simulation is NVIDIA's two-circuit cosine/sine workflow: width is the maximum component width, while depth and T count are summed across both circuits before classical recover_real_time_evolution.
- Multi-controlled gates (ctrl(k) @ g, k >= 2) are lowered with a Toffoli ladder on clean ancillas before costing, for all three frameworks; qasmviz's ancilla-free lowering would otherwise dominate the T count of whichever toolchain emits them.
- Task-level rows compare library implementations of the same mathematical operation; they do not isolate compiler lowering because the libraries can choose different decompositions. HHL's Silq-Qrisp ratio depends on qasmviz's optimizer; see README.
- CUDA-Q uses the CPU-only qpp-cpu target on macOS. Its column uses CUDA-Q core gates or public cudaq-algorithms 0.2.0rc1 primitives from pinned commit 4891dbe. A dash means that the package has no matching exportable circuit primitive; no hand-written substitute is reported.
- Full machine-readable results and gate breakdowns are in `outputs/results.json`.
