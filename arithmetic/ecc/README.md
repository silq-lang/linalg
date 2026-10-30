# secp256k1 point addition for the ECDSA.Fail challenge

`ecc_challenge.slq` adds a classical point B = (bx, by) to a quantum point
A = (x, y) in place, with one call per step to the measurement-based kernels of
`kernels.slq`, `pingpong.slq` and the `arithmetic/` modules:

    x := x-bx, y := y-by, y := y/x          λ = (y-by)/(x-bx)
    x := x-y^2+3*bx                         x := bx-x3
    y := y*x                                λ*(bx-x3)
    x := bx-x, y := y-by                    (x3, y3)

As in the challenge's evaluator, the points are finite with distinct x
coordinates. For A=-2B (x3 = bx) the classical tangent slope 3*bx^2/(2*by) is
used. The code needs stock Silq and hqir-rs only.

## Reproduce

Requirements: Python 3.14+, Git, Cargo, and on `PATH`:

- Silq `silq-lang/silq` at 19b66448ff3aad32f554edac2dd57ef1924aa341
  (submodules ast fd66d827ae3a986342f26b0f3e9a61d1dc3f2384,
  util eb0ec8b9454ebeadbaa870d32394b9c300461a54), built with `./build-release.sh`;
- hqir-rs `silq-lang/hqir-rs` at 746242204aa1073356734c1f68f57e8faaef6f49.

From the `arithmetic/` directory:

    python3 ecc/challenge_export.py --work-dir ecc/.challenge/run

This compiles every kernel from the Silq sources with hqir-rs (`source_build.py`,
about 15 minutes, 8 parallel jobs), writes `ops.bin`, clones the official
evaluator at its pinned commit and runs it on all 9,024 Fiat-Shamir shots
(about 15 GB of RAM). The op stream has no nonce or other tunable bits.

## Bounded error

The ping-pong inversion uses 736 rounds with narrowed rails, and the field
kernels use bounded pseudo-Mersenne carry windows (64 bits; 66 in division)
and 40-bit carry comparisons. These are bounded-error choices: the circuit is
not correct for every input. The error rate measured on fresh test sets is
reported below.

## Result

**1,041,402 Toffolis × 1,368 qubits = 1,424,637,936**, all 9,024 shots correct
with no classical, phase or ancilla errors. The op stream has no nonce, and this
was the only evaluation of this circuit's official test set. Building with
stock Silq gives a byte-identical `ops.bin`. On fresh test sets (the same
circuit with 4 extra unused-bit records) 17 of 18 passed, so the error rate is
about 1 wrong addition in 160,000 (one observed failure, in the multiplication).
