# Silq resource comparisons

This directory reproduces the two resource tables in `paper_tables.tex`:

- `QRISP_comp/`: Silq versus Qrisp (Table `tab:silq-qrisp`). Its README
  documents the benchmark specifications and costing method.
- `cudaq_comp/`: Silq versus CUDA-Q Algorithms (Table `tab:silq-cudaq`).

## Toolchain

The tables were generated on macOS with Python 3.12 and these exact versions:

| Tool | Repository | Commit |
|---|---|---|
| Silq | https://github.com/silq-lang/silq | `19b66448ff3aad32f554edac2dd57ef1924aa341` |
| HQIR | https://github.com/silq-lang/hqir | `ebf0128` |
| qasmviz | https://github.com/silq-lang/qasmviz | `2e48f2a` |

`silq`, `hqir`, and `qasmviz` must be on `PATH`. The resource counts depend on
the qasmviz version in particular: its Clifford+T synthesis changed on
2026-11-10, which roughly halved the T counts of every synthesized row.

Python packages are pinned in each folder's `requirements.txt` (Qrisp 0.9.10,
CUDA-Q 0.16.0). The two folders pin different CUDA-Q Algorithms commits, so
each has its own virtual environment.

Silq programs import modules relative to the repository root
(`arithmetic/`, `phase_estimation/`, `GQSVT/`, ...), and the runners set the
working directory accordingly.

## Running

```bash
cd QRISP_comp
python3.12 -m venv .venv
.venv/bin/python -m pip install -r requirements.txt
.venv/bin/python run_benchmarks.py
.venv/bin/python verify_states.py
```

```bash
cd cudaq_comp
python3.12 -m venv .venv
.venv/bin/python -m pip install cudaq==0.16.0 qiskit==2.6.2 setuptools==84.2.1 numpy==2.5.4 scipy==1.18.1
.venv/bin/python -m pip install --no-deps --no-build-isolation -r requirements.txt
.venv/bin/python run_benchmarks.py
```

Each run takes about two minutes and writes `table.md`, `table.tex`, and
`outputs/results.json` in its folder. The CUDA-Q runner verifies output
states as part of the run; the Qrisp side writes
`outputs/state_verification.json` from `verify_states.py`.

HQIR is not fully deterministic, so fresh compiles of the largest Silq rows
can differ by a few percent. `QRISP_comp/run_benchmarks.py --reuse-qasm`
recomputes the published numbers exactly from the committed QASM.
