"""Export an executed CUDA-Q kernel trace as static OpenQASM 3.

CUDA-Q 0.16's OpenQASM translator cannot lower captured list arguments used
by CUDA-Q Algorithms' public device kernels. Its circuit drawer does execute
and fully expand those kernels. This module converts that exact gate trace to
QASM; module-provided angle candidates restore the full-precision values that
the Quantikz renderer shortens for display.
"""

from __future__ import annotations

import math
import re
from collections.abc import Iterable

from cudaq.runtime.draw import _detail_draw


_GATE = re.compile(r"^\\gate\{(.+)\}$")
_CONTROL = re.compile(r"^\\ctrl\{(-?\d+)\}$")
_SWAP = re.compile(r"^\\swap\{(-?\d+)\}$")
_ROTATION = re.compile(r"^R_([xyz1])\(([-+0-9.eE]+)\)$", re.IGNORECASE)


def _rows(quantikz: str) -> list[list[str]]:
    body = quantikz.split("\\begin{quantikz}", 1)[1].split(
        "\\end{quantikz}", 1
    )[0]
    rows = []
    for line in body.splitlines():
        line = line.strip()
        if not line.startswith("\\lstick"):
            continue
        if line.endswith("\\\\"):
            line = line[:-2].rstrip()
        cells = [cell.strip() for cell in line.split("&")]
        rows.append(cells[1:])
    if not rows or len({len(row) for row in rows}) != 1:
        raise ValueError("could not parse CUDA-Q Quantikz trace")
    return rows


def _exact_angle(rendered: str, candidates: tuple[float, ...]) -> float:
    approximate = float(rendered)
    nearest = min(candidates, key=lambda value: abs(value - approximate))
    tolerance = 8e-4 * max(1.0, abs(approximate))
    if abs(nearest - approximate) > tolerance:
        raise ValueError(
            f"no full-precision candidate for rendered angle {rendered}; "
            f"nearest is {nearest}"
        )
    return nearest


def _gate_text(label: str, controls: list[int], target: int,
               candidates: tuple[float, ...]) -> str:
    normalized = label.replace(" ", "")
    simple = {
        "H": "h", "X": "x", "Y": "y", "Z": "z",
        "S": "s", "S^\\dagger": "sdg", "S^\\dag": "sdg",
        "T": "t", "T^\\dagger": "tdg", "T^\\dag": "tdg",
    }
    if normalized in simple:
        gate = simple[normalized]
        parameter = ""
    else:
        match = _ROTATION.match(normalized)
        if not match:
            raise ValueError(f"unsupported CUDA-Q trace gate {label!r}")
        axis = match.group(1).lower()
        gate = "p" if axis == "1" else f"r{axis}"
        parameter = f"({_exact_angle(match.group(2), candidates)!r})"

    operands = [f"q[{index}]" for index in [*controls, target]]
    if not controls:
        return f"{gate}{parameter} {operands[-1]};"
    if gate == "x" and len(controls) == 1:
        return f"cx {operands[0]}, {operands[1]};"
    if gate == "x" and len(controls) == 2:
        return f"ccx {', '.join(operands)};"
    if gate == "z" and len(controls) == 1:
        return f"cz {operands[0]}, {operands[1]};"
    return f"ctrl({len(controls)}) @ {gate}{parameter} {', '.join(operands)};"


def trace_to_qasm(kernel, *arguments, known_angles: Iterable[float] = ()) -> str:
    """Execute ``kernel`` through CUDA-Q's drawer and return static QASM 3."""
    quantikz = _detail_draw("latex", kernel, *arguments)
    rows = _rows(quantikz)
    common = (
        0.0, math.pi, -math.pi, math.pi / 2, -math.pi / 2,
        math.pi / 4, -math.pi / 4, math.pi / 8, -math.pi / 8,
    )
    candidates = tuple(float(value) for value in (*common, *known_angles))
    operations: list[str] = []

    for column in range(len(rows[0])):
        cells = [rows[wire][column] for wire in range(len(rows))]
        controls_by_target: dict[int, list[int]] = {}
        swaps: list[tuple[int, int]] = []
        for wire, cell in enumerate(cells):
            if match := _CONTROL.match(cell):
                target = wire + int(match.group(1))
                controls_by_target.setdefault(target, []).append(wire)
            elif match := _SWAP.match(cell):
                other = wire + int(match.group(1))
                swaps.append(tuple(sorted((wire, other))))

        for first, second in sorted(set(swaps)):
            operations.append(f"swap q[{first}], q[{second}];")

        for wire, cell in enumerate(cells):
            match = _GATE.match(cell)
            if not match:
                continue
            controls = sorted(controls_by_target.get(wire, []))
            operations.append(_gate_text(match.group(1), controls, wire,
                                         candidates))

    return "\n".join([
        "OPENQASM 3.0;",
        'include "stdgates.inc";',
        f"qubit[{len(rows)}] q;",
        *operations,
        "",
    ])
