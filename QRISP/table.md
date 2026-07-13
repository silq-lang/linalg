All resource estimations for Silq codes are done by runing `hqir <FOLDER NAME>/<FILE NAME> -O3 --flatten -R3 --qasm | qasmviz --cost` in qasmviz.

Kindly mind that modifications to the parameters might lead to different circuit metrics.

- Controlled Phase:
    - Silq without optimization: `QRISP/phase_no_slq.slq`
    - Silq with optimization: `QRISP/phase_o_slq.slq` 
    - Qrisp: run `QRISP/phase_Q.py`

- Tridiagonal matrix BE:
    - Silq without optimization: `QRISP/tridiag_no_slq.slq`
    - Silq with optimization: `QRISP/tridiag_o_slq.slq`
    - Qirsp: run `QRISP/tridiag.py`

- TFIM BE:
    - Silq: `QRISP/TFIM_slq.slq`
    - Qrisp: run `QRISP/TFIM_Q.py`

- Heisen BE:
    - Silq: `QRISP/Heisen_slq.slq`
    - Qrisp: run `QRISP/Heisen_Q.py`

- Chebyshev polynomial:
    - Silq without optimization: `QRISP/cheby_no_slq.slq`
    - Silq with optimization: `QRISP/cheby_o_slq.slq`
    - Qrisp: `QRISP/cheby_Q.py`

- Hamiltonian simulation:
    - Silq without optimization: `QRISP/HS_no_slq.slq` 
    - Silq with optimization: `QRISP/HS_o_slq.slq`
    - Qrisp: `QRISP/HS_Q.py` 

- Matrix inversion:
    - Silq without optimization: `QRISP/inv_no_slq.slq`
    - Silq with optimization: `QRISP/inv_o_slq.slq`
    - Qrisp: `QRISP/inv_Q.py`

- Eigenstate filtering:
    - Silq without optimization: `QRISP/filter_no_slq.slq`
    - Silq with optimization: `QRISP/filter_o_slq.slq` 
    - Qrisp: `QRISP/filter_Q.py` 

- Convolution state:
    - Silq: run `QRISP/conv_slq.slq`
    - Qrisp: run `QRISP/conv_Q.py`

- Fourier series loader:
    - Silq without optimization: run `state_prep/fourier_loader.slq`
    - Silq with optimization: run `QRISP/fourier_slq.slq`
    - Qrisp: run `QRISP/fourier_Q.py`