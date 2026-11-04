# Reproducible Silq-Qrisp-CUDA-Q benchmarks

This directory compares plain, idiomatic Silq programs with Qrisp and CUDA-Q
programs that implement the same benchmark specification. It intentionally
has no hand-optimized Silq column.

## Method

1. Silq is compiled to OpenQASM with `hqir -O3 --flatten -R3`.
2. Qrisp is compiled, fully transpiled, and exported as OpenQASM 3.
3. CUDA-Q rows call CUDA-Q core gates or public CUDA-Q Algorithms primitives.
   Kernels supported by CUDA-Q's translator are exported through OpenQASM 2;
   library kernels containing captured lists are exported from CUDA-Q's fully
   expanded execution trace (see `cudaq_trace_export.py`).
4. All three QASM circuits are passed through the same command:

   ```text
   qasmviz --clifford-t --opt 3 --eps 1e-6 --cost --json
   ```

The reported width, depth, and T count therefore use one gate basis and one
arbitrary-rotation synthesis tolerance. `T` includes both T and T-dagger
gates. Full gate breakdowns remain available in the JSON results.

CUDA-Q's official QSVT Hamiltonian-simulation workflow contains separate
cosine and sine circuits followed by classical recovery. Its table entry uses
the maximum component width and the sum of the two depths and T counts. The
additional `beta` metric is the reported subnormalization in `target / beta`.

Every block-encoding row now reports normalization explicitly. Direct rows use
`alpha` in `<0|U|0> = A/alpha`. Polynomial/QSVT rows report the input encoding
`alpha_in` and the resulting good-subspace subnormalization `beta`. The values
are:

| Process | `alpha` / `alpha_in` | Silq/Qrisp `beta` | CUDA-Q `beta` |
|---|---:|---:|---:|
| Tridiagonal encoding | 1 | — | — |
| TFIM encoding | 1.25 | — | — |
| Heisenberg encoding | 0.75 | — | — |
| TFIM Chebyshev `T_2` | 1.25 | 1 | 1 |
| TFIM QSP simulation | 1.25 | 1 | 2 |
| Pseudoinverse | 4/3 | 3.616161 | 2.170264 |
| Eigenstate filter | 2 | 1.01 | unavailable |

The Silq/Qrisp pseudoinverse `beta` is recovered from the verified
good-subspace amplitude for this matrix and input; CUDA-Q's value is the
official CKS expression `1/(scale*alpha)`. The filter's `1.01` is the explicit
polynomial rescaling present in both sources.

CUDA-Q 0.16.0 runs with the CPU-only `qpp-cpu` target on this macOS system.
CUDA-Q Algorithms is pinned to official commit
`4891dbe62c0baeac4569bf608562ffee59635cca` (package version `0.2.0rc1`).
The trace exporter restores full-precision angles supplied by each benchmark;
state verification nevertheless allows a maximum CUDA-Q amplitude error of
`2e-6` and independently requires near-unit fidelity.

The quantum-quantum adder is the sole dynamic-circuit exception. Silq's
`QQ_adder` uses mid-circuit measurement and feed-forward, so all three adders are
kept in their exact Clifford+T forms and costed without a unitary-only
transpilation pass. Its depth includes the dynamic operations reported by
qasmviz. Because qasmviz optimization is not used on this row, the runner first
merges directly adjacent phase gates on the same qubit (an exact peephole, for
all three frameworks); otherwise cancelling pairs such as `p(pi/4) p(-pi/4)` would be
counted as two T gates. The T differences on this row come from the
uncomputation strategy: Silq uncomputes carries by measurement, while Qrisp's
`gidney_adder` and CUDA-Q Algorithms' `add_register` primitive uncompute them
unitarily.

### Multi-controlled gates

HQIR leaves multi-controlled gates (`ctrl(k) @ x`, `ctrl(k) @ ry`,
`ctrl(k) @ gphase`) for the backend, while Qrisp exports its own
decomposition. qasmviz lowers such gates without ancillas and at a very high
cost: one `ctrl(3) @ x` becomes 1905 T and one `ctrl(2) @ ry` 738 T, where the
standard Toffoli-ladder construction needs a few dozen T plus the controlled
rotation. Left alone, the common pipeline would penalize whichever toolchain
emits high-level gates. The runner therefore lowers every `ctrl(k) @ g` with
k >= 2 using a Toffoli ladder on clean ancillas before costing, for every framework.
The ancillas are returned to `|0>` (checked by simulation) and are counted in
width; they add one qubit to the inversion and filter rows. Zero-angle
controlled global phases are dropped.

### Determinism

`silq` output and `qasmviz` (for a fixed input) are deterministic, but `hqir`
is not. Most of its variation is cosmetic: it emits the operands of symmetric
gates (`cp`, `cz`) and the controls of `ccx` / `ctrl(k) @` gates in a
run-dependent order. The circuits are identical, yet qasmviz's optimizer is
order-sensitive: on the QAE circuit, operand order alone moved the T count
between 2492 and 3566. The runner therefore sorts these operands before
costing, for all three toolchains. This leaves the gates and the simulated states
unchanged.

A smaller residual remains. HQIR names some values by memory address
(`hqir/cval.py`, `f'.{id(self)}'`), so on the largest Silq circuits
(inversion, filter, convolution, Fourier loading) a fresh compile can
reorder commuting gates or choose a different equivalent instruction sequence.
In repeated fresh runs this changed those rows by less than 0.5% in T count.
Separately, the arbitrary choice of canonical order itself moves large rows by
a few percent (5% on inversion), so treat differences of that size on the
large rows as optimizer noise. Results from `--reuse-qasm` are exactly
reproducible, and the table is generated from the QASM kept in `outputs/qasm/`.

Run everything from this directory with:

```bash
python3.12 -m venv .venv
.venv/bin/python -m pip install -r requirements.txt
.venv/bin/python run_benchmarks.py
```

Use `--reuse-qasm` to regenerate metrics and tables without recompiling the
source programs. Generated QASM is kept under `outputs/qasm/` but ignored by
Git. Machine-readable metrics are in `outputs/results.json`; the generated
tables are `table.md`, `table.tex`, and `table_styled.tex`. Exported circuits
include `*_silq.qasm`, `*_qrisp.qasm`, and `*_cudaq.qasm`.

## Corrected specifications

- Controlled phase uses five qubits and angle pi/4 in all three frameworks.
- The tridiagonal case is the same non-cyclic 4-by-4 matrix in all three frameworks.
  `QubitOperator.from_matrix` reads row indices big-endian, so the Qrisp side
  bit-reverses the matrix first; otherwise it would encode the matrix with the
  operand qubits swapped.
- All block-encoding rows (tridiagonal, TFIM, Heisenberg, and Chebyshev)
  apply the encoding to the same generic operand
  `Ry(pi/7) x Ry(pi/9)|00>`. With a literal `|00>` operand, HQIR folds the
  known input and the Silq circuit is only correct on that one input, whereas
  Qrisp exports the full unitary.
- TFIM is `-0.25 Z0 Z1 + 0.5 X0 + 0.5 X1`.
- Heisenberg is `0.25 (X0 X1 + Y0 Y1 + Z0 Z1)`.
- The Chebyshev case is `T_2` in all three frameworks.
- Hamiltonian simulation uses the same first-order product formula for the
  TFIM (including the sign of the ZZ term), `t=pi/4`, and 14 steps. This row
  is a full-state circuit comparison, not a comparison between two different
  Hamiltonian-simulation approximations.
- A separate task-level row, "TFIM QSP simulation", approximates
  `exp(-iHt)` for the same TFIM and `t=pi/4` with a polynomial of the
  qubitized walk operator (`HS_qsp_slq.slq`, `HS_qsp_Q.py`). Both use the
  exact same degree-28 phase arrays, with 14 forward and 14 inverse calls to
  the same alpha=1.25 TFIM walk. Their full coherent states agree to numerical
  precision; this row does not use Qrisp's independently chosen `sim(N)` phases.
  CUDA-Q instead follows NVIDIA's official example: `PauliLCU`, the public
  `QSVT.kernel` API, and QSPPACK phases generated from the Jacobi--Anger
  cosine/sine expansions at degree 28. It runs two circuits and applies
  `recover_real_time_evolution` classically. The CUDA-Q table cost therefore
  uses maximum component width and summed component depth/T count.
- Matrix inversion uses `[[1,-1/3],[-1/3,1]]` and input `|1>`. Silq and Qrisp
  retain their matched degree-25 polynomial. CUDA-Q follows NVIDIA's official
  matrix-inversion example instead: a CKS inverse with `epsilon=0.02`,
  `x_min=0.5`, degree 31, and real-part recovery after removing the QSP global
  phase. All implementations use the `(I-X/3)/(4/3)` LCU.
- Eigenstate filtering uses the same shifted block normalization (alpha=2) and
  the same order-14 even Chebyshev filter polynomial (degree 28), applied to
  A/alpha. Silq and Qrisp write the shift with non-negative LCU coefficients and a
  `-I` SELECT unitary, then apply the same explicit degree-28 GQSP phases. This
  avoids Qrisp's PREP_R/PREP_L path for negative coefficients and removes any
  phase-solver or rescaling difference.
- Convolution applies `sum_k p_k U^k` with `U` the increment in Silq and Qrisp
  and reports one coherent attempt. `qrisp.gqsp.convolve` treats the
  weights as a centred filter (`sum_k p_k U^(k-2)` here), so the Qrisp side
  calls `GQSP(..., k=0)` directly with the same increment unitary.
- The Fourier signal is `3 + 2 cos(2 pi x) - sin(4 pi x)` with six data
  qubits. It has five nonzero Fourier modes, so Qrisp uses cutoff `k=2`.
  Silq uses six coefficient qubits so its QFT reconstructs all 64 samples.

A QPE-based HHL benchmark is adapted from `phase_estimation/HHL.slq` using
the matrix `[[3/4,-1/4],[-1/4,3/4]]`, input `|1>`, condition parameter 2,
three phase qubits, and one Trotter step. The Silq and Qrisp resource counts
cover one coherent HHL attempt rather than repeat-until-success postselection.

The additional circuit-level baseline is a five-qubit QFT on the same generic
rotated product input in all three frameworks.

Two further coherent examples are adapted from the `phase_estimation`
directory: three-bit QPE for a pi/4 phase and five-bit canonical amplitude
estimation for an `Ry(pi/3)` state. Shot loops and final measurements are deliberately excluded
so Silq and Qrisp export the same unitary workload. The QPE system starts in
`Ry(pi/5)|0>` instead of a known eigenstate. This prevents either compiler
from replacing the controlled powers with compile-time phase constants. In
QAE, all versions prepare `Ry(pi/3)|0>` before QPE and apply the same
good-state reflection followed by the same prepared-state reflection.

Additional matched examples use the measurement-based four-bit `QQ_adder`,
a coherent five-bit comparison with 6, and the two-term five-qubit Pauli
product formula from `primitives/trotter.slq`. The QRISP adder uses its native
Gidney primitive on the same registers and input state.

Each CUDA-Q source file is beside its matching Silq and Qrisp file. The CUDA-Q
column now contains only public CUDA-Q core operations or primitives from the
official CUDA-Q Algorithms repository:

- QFT uses `cudaq_algorithms.primitives.qft`.
- The QQ adder and comparator use `add_register` and `cmp_ge_constant`.
- Both product-formula rows use `cudaq_algorithms.Trotter`.
- The tridiagonal, TFIM, and Heisenberg block encodings use `PauliLCU`; the
  Chebyshev row uses `PauliLCU.walk_kernel(power=2)`.
- QSP simulation and pseudoinversion use `PauliLCU`, `PhaseSequence`, and the
  public `QSVT.kernel` API. Their classical preprocessing is copied from
  NVIDIA's official Hamiltonian-simulation and matrix-inversion examples,
  respectively; it is not the polynomial used by Silq/Qrisp.
- Controlled phase uses CUDA-Q core's multi-controlled `cr1` operation.

No CUDA-Q value is reported for arbitrary-unitary QPE, QAE, HHL, eigenstate
filtering, convolution, or Fourier loading. The current package has no matching
application primitive or official workflow: its `PhaseEstimation` class is for qubitization walks, and
`cudaq.contrib.amplitude_encode` is an opaque simulator state initializer
rather than an exportable gate circuit. In particular, CUDA-Q Algorithms has a
generic QSVT circuit but no built-in eigenstate-filter function or NVIDIA filter
phase workflow. A dash in the table therefore means
"no comparable CUDA-Q library primitive," not a failed benchmark.

CUDA-Q 0.16's OpenQASM translator cannot lower the captured list arguments in
some CUDA-Q Algorithms kernels. `cudaq_trace_export.py` executes the actual
library kernel through CUDA-Q's circuit drawer and converts that fully expanded
gate trace to static OpenQASM 3. It does not substitute a hand-written circuit.
For every trace-exported row, the raw operation count is checked against the
executed CUDA-Q circuit before common-basis costing.

## Interpretation

The table is split into two groups.

**Circuit-level compiler comparisons** (QFT, QPE, QAE, QQ adder, comparator,
Pauli product formulas, controlled phase). Every available implementation has
the same logical specification and its state check agrees, allowing only for
wire order, clean workspace qubits, and global phase. Remaining differences
still reflect the primitive chosen by each library. For example, Silq's QFT
writes each controlled phase as `if a && b {phase(...)}`, which HQIR lowers to
an AND ancilla plus one rotation, while Qrisp uses `cp` (three rotations):
fewer T gates and two more qubits for Silq.

**Task-level library comparisons** (block encodings, inversion, filtering,
HHL, convolution, Fourier loader). The available programs have the same
mathematical targets, verified by simulation, but their libraries can choose
different block-encoding and QSVT decompositions. These rows evaluate the
library implementations as delivered; they are not pure compiler-lowering
comparisons. Silq and Qrisp use exactly matched GQSP constructions for QSP
simulation, pseudoinversion, and filtering. CUDA-Q uses its official repository
workflows for simulation and inversion, so its approximation polynomials and
recovery procedure intentionally differ. CUDA-Q filtering is not reported.

For CUDA-Q, `beta` in the table is the subnormalization constant defined by the
good-subspace transformation `target / beta`. The official two-circuit
Hamiltonian-simulation recovery has `beta=2`. The official CKS inverse has
`beta = 1/(scale*alpha) = 2.170264`, using `scale=0.3455801` and the Pauli-LCU
normalization `alpha=4/3`.

**HHL.** The Silq and Qrisp programs compute the same logical state. Two effects explain
the Silq advantage over Qrisp. First, Silq's inverse QFT turns each controlled pi/4 phase into
an exact T gate on an AND ancilla, while Qrisp's `cp(pi/4)` needs rotations by
±pi/8, which must be synthesized (16 of them, about 126 T each). Second, the
result depends on qasmviz's optimizer: without optimization (`--opt 0`) Qrisp
is cheaper (T=6083 vs 10276), and levels 2-3 collapse Silq's repeated
controlled-U powers, which act only on one control and the system qubit, much
more than Qrisp's workspace-mediated structure. Treat the HHL ratio as
sensitive to the backend optimizer.

Task-level rows count one coherent attempt. Success probabilities with all
ancillas postselected to zero are:

| Row | Silq | Qrisp | CUDA-Q |
|---|---:|---:|---:|
| Matrix inversion | 0.108 | 0.108 | separate real-part recovery |
| Eigenstate filter | 0.490 | 0.490 | — |
| Convolution | 0.521 | 0.543 | — |
| Fourier loader | 1.0 (deterministic) | 0.360 | — |
| TFIM QSP simulation | 1.000 | 1.000 | two circuits: 0.496 / 0.679 |

The Silq Fourier loader is deterministic, while Qrisp needs about 2.8 attempts
on average. Their normalized six-qubit output states nevertheless agree.

`verify_states.py` performs no search for a convenient postselection branch.
It uses the declared logical registers and the all-zero signal/ancilla branch.
Circuit-level rows (and HHL) match as full coherent states. Block encodings,
convolution, and the Fourier loader match their normalized postselected state
to numerical precision across all available frameworks. CUDA-Q comparisons
are additionally checked against Qrisp on declared logical wires and the
all-zero workspace branch. The matched Silq-Qrisp QSP simulation,
pseudoinverse, and filter include equal success amplitudes. CUDA-Q's documented
classical recovery is applied before comparing its simulation and inverse
outputs; the resulting logical fidelities are recorded in
`outputs/state_verification.json`.

No hardware connectivity, routing, error correction, measurement latency, or
repeat-until-success overhead is included. Width includes temporary qubits
introduced by either toolchain. Changing the rotation synthesis tolerance can
substantially change the large T counts.

The installed Silq compiler currently emits `circuit_call` for its built-in
`wrap_circuit` helper, while the installed HQIR parser calls that operation
`mfree_call`. The runner applies that one-name compatibility rewrite before
HQIR parsing and records the rewrite count in `outputs/results.json`.
