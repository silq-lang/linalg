"""Reusable Qrisp resource-evaluation helpers.

This module has two intended uses:

1. Evaluate any Qrisp ``BlockEncoding`` via its native ``resources`` method.
2. Evaluate a more general Qrisp program by compiling the quantum session
   produced by a user-provided builder function.

The rotation metrics follow the convention from the original script:
T/Tdg and arbitrary single-qubit rotations count toward ``rot-count``;
S/Sdg are reported separately in brackets as Clifford rotations.  For the
rotation depth, T/Tdg, S/Sdg, and arbitrary single-qubit rotations each
contribute one layer.
"""

from __future__ import annotations

from dataclasses import asdict, dataclass, field
from typing import Any, Callable, Iterable, Mapping, Optional, Sequence


T_GATE_NAMES = {"t", "t_dg", "tdg"}
CLIFFORD_ROTATION_NAMES = {"s", "s_dg", "sdg"}
APPROX_ROTATION_NAMES = {"rx", "ry", "rz", "p", "u1", "u2", "u3"}
ROTATION_DEPTH_NAMES = T_GATE_NAMES | CLIFFORD_ROTATION_NAMES | APPROX_ROTATION_NAMES

PREFERRED_GATE_ORDER = [
    "cx",
    "cz",
    "h",
    "s",
    "s_dg",
    "sdg",
    "t",
    "t_dg",
    "tdg",
    "x",
    "y",
    "z",
    "rx",
    "ry",
    "rz",
    "p",
    "u1",
    "u2",
    "u3",
    "gphase",
]

DISPLAY_ALIASES = {
    "t_dg": "tdg",
    "s_dg": "sdg",
}


@dataclass
class ResourceReport:
    """Container for resource metrics."""

    label: str = "resources"
    width: Optional[int] = None
    depth: Optional[int] = None
    total_gates: int = 0
    gate_counts: dict[str, int] = field(default_factory=dict)
    t_count: int = 0
    approx_rotation_count: int = 0
    clifford_rotation_count: int = 0
    rotation_count: int = 0
    rotation_depth: Optional[int] = None
    statevector: Optional[str] = None
    notes: list[str] = field(default_factory=list)

    def as_dict(self) -> dict[str, Any]:
        return asdict(self)


def _normalise_gate_name(name: Any) -> str:
    return str(name).lower().replace("-", "_")


def _operation_name(operation: Any) -> str:
    """Extract a robust lower-case gate name from a Qrisp/Qiskit-like op."""

    name = getattr(operation, "name", None)
    if name is None and isinstance(operation, (tuple, list)) and operation:
        name = getattr(operation[0], "name", operation[0])
    if name is None:
        name = str(operation)
    return _normalise_gate_name(name)


def rotation_depth_indicator(operation: Any) -> int:
    """Depth indicator for T, S, and arbitrary single-qubit rotations."""

    return 1 if _operation_name(operation) in ROTATION_DEPTH_NAMES else 0


def _as_operands(obj: Any) -> tuple[Any, ...]:
    if isinstance(obj, tuple):
        return obj
    if isinstance(obj, list):
        return tuple(obj)
    return (obj,)


def _flatten(items: Any) -> Iterable[Any]:
    if isinstance(items, (list, tuple)):
        for item in items:
            yield from _flatten(item)
    else:
        yield items


def _find_quantum_session(items: Any) -> Any:
    for item in _flatten(items):
        qs = getattr(item, "qs", None)
        if qs is not None:
            return qs
    raise ValueError("Could not find a Qrisp QuantumSession. Return at least one QuantumVariable.")


def _normalise_gate_counts(gate_counts: Mapping[Any, Any] | None) -> dict[str, int]:
    if not gate_counts:
        return {}

    counts: dict[str, int] = {}
    for raw_name, raw_count in gate_counts.items():
        name = _normalise_gate_name(raw_name)
        try:
            count = int(raw_count)
        except Exception:
            count = raw_count
        counts[name] = counts.get(name, 0) + count
    return counts


def _safe_count_ops(circuit: Any) -> dict[str, int]:
    if hasattr(circuit, "count_ops"):
        raw = circuit.count_ops()
        # Qiskit returns an OrderedDict.  Some APIs return a list of tuples.
        if isinstance(raw, Mapping):
            return _normalise_gate_counts(raw)
        if isinstance(raw, (list, tuple)):
            return _normalise_gate_counts(dict(raw))
    raise AttributeError("The compiled circuit does not expose count_ops().")


def _safe_depth(circuit: Any, *, depth_indicator: Optional[Callable[[Any], int]] = None) -> Optional[int]:
    if not hasattr(circuit, "depth"):
        return None

    try:
        if depth_indicator is None:
            return int(circuit.depth(transpile=False))
        return int(circuit.depth(depth_indicator=depth_indicator, transpile=False))
    except TypeError:
        if depth_indicator is None:
            return int(circuit.depth())
        return int(circuit.depth(depth_indicator=depth_indicator))


def _safe_width_from_circuit(circuit: Any) -> Optional[int]:
    for attr in ("num_qubits", "n_qubits"):
        if hasattr(circuit, attr):
            value = getattr(circuit, attr)
            return int(value() if callable(value) else value)
    if hasattr(circuit, "qubits"):
        return len(circuit.qubits)
    return None


def _resource_width(resources: Mapping[str, Any]) -> Optional[int]:
    for key in ("qubits", "width", "num_qubits"):
        if key in resources:
            return int(resources[key])
    return None


def _rotation_counts(gate_counts: Mapping[str, int]) -> tuple[int, int, int, int]:
    t_count = sum(gate_counts.get(name, 0) for name in T_GATE_NAMES)
    approx_count = sum(gate_counts.get(name, 0) for name in APPROX_ROTATION_NAMES)
    clifford_count = sum(gate_counts.get(name, 0) for name in CLIFFORD_ROTATION_NAMES)
    rotation_count = t_count + approx_count
    return t_count, approx_count, clifford_count, rotation_count


def report_from_gate_counts(
    gate_counts: Mapping[Any, Any],
    *,
    label: str = "resources",
    width: Optional[int] = None,
    depth: Optional[int] = None,
    rotation_depth: Optional[int] = None,
    statevector: Optional[str] = None,
    notes: Optional[Sequence[str]] = None,
) -> ResourceReport:
    counts = _normalise_gate_counts(gate_counts)
    t_count, approx_count, clifford_count, rotation_count = _rotation_counts(counts)

    return ResourceReport(
        label=label,
        width=width,
        depth=depth,
        total_gates=sum(counts.values()),
        gate_counts=counts,
        t_count=t_count,
        approx_rotation_count=approx_count,
        clifford_rotation_count=clifford_count,
        rotation_count=rotation_count,
        rotation_depth=rotation_depth,
        statevector=statevector,
        notes=list(notes or []),
    )


def report_from_qrisp_resources(
    resources: Mapping[str, Any],
    *,
    label: str = "resources",
    rotation_depth: Optional[int] = None,
    statevector: Optional[str] = None,
    notes: Optional[Sequence[str]] = None,
) -> ResourceReport:
    return report_from_gate_counts(
        resources.get("gate counts", {}),
        label=label,
        width=_resource_width(resources),
        depth=int(resources["depth"]) if "depth" in resources else None,
        rotation_depth=rotation_depth,
        statevector=statevector,
        notes=notes,
    )


def evaluate_block_encoding(
    block_encoding: Any,
    operand_factory: Callable[[], Any],
    *,
    label: str = "BlockEncoding",
    apply_unitary_for_rotation_depth: bool = True,
    include_statevector: bool = False,
    statevector_return_type: str = "sympy",
    statevector_decimals: int = 6,
) -> ResourceReport:
    """Evaluate resources for a Qrisp BlockEncoding.

    Parameters
    ----------
    block_encoding:
        Qrisp BlockEncoding object.
    operand_factory:
        Callable returning a fresh QuantumVariable, or a tuple/list of operands.
        It is called twice when rotation depth or a statevector is requested.
    label:
        Report label.
    apply_unitary_for_rotation_depth:
        If True, builds the actual block-encoding unitary on fresh operands and
        compiles the resulting session to estimate ``rot-depth`` using the same
        convention as in the original script.
    include_statevector:
        If True, attach the statevector of the built unitary application.
    """

    operands = _as_operands(operand_factory())
    resources = block_encoding.resources(*operands)

    rotation_depth = None
    statevector = None
    notes: list[str] = []

    if apply_unitary_for_rotation_depth or include_statevector:
        try:
            operands_for_circuit = _as_operands(operand_factory())
            ancillas = tuple(block_encoding.create_ancillas())
            block_encoding.unitary(*ancillas, *operands_for_circuit)
            qs = _find_quantum_session((*ancillas, *operands_for_circuit))
            compiled = qs.compile()

            if apply_unitary_for_rotation_depth:
                rotation_depth = _safe_depth(compiled, depth_indicator=rotation_depth_indicator)
            if include_statevector:
                statevector = str(
                    qs.statevector(return_type=statevector_return_type, decimals=statevector_decimals)
                )
        except Exception as exc:  # Keep resource evaluation usable even if compilation fails.
            notes.append(f"Could not compute compiled-circuit extras: {type(exc).__name__}: {exc}")

    return report_from_qrisp_resources(
        resources,
        label=label,
        rotation_depth=rotation_depth,
        statevector=statevector,
        notes=notes,
    )


def evaluate_quantum_program(
    program_factory: Callable[[], Any],
    *,
    label: str = "Qrisp program",
    include_statevector: bool = False,
    statevector_return_type: str = "sympy",
    statevector_decimals: int = 6,
) -> ResourceReport:
    """Evaluate a general Qrisp program by compiling its resulting session.

    The ``program_factory`` should build the Qrisp circuit and return at least
    one QuantumVariable, or a nested tuple/list containing QuantumVariables.
    """

    result = program_factory()
    qs = _find_quantum_session(result)
    compiled = qs.compile()

    gate_counts = _safe_count_ops(compiled)
    depth = _safe_depth(compiled)
    rotation_depth = _safe_depth(compiled, depth_indicator=rotation_depth_indicator)
    width = _safe_width_from_circuit(compiled)
    statevector = None
    if include_statevector:
        statevector = str(qs.statevector(return_type=statevector_return_type, decimals=statevector_decimals))

    return report_from_gate_counts(
        gate_counts,
        label=label,
        width=width,
        depth=depth,
        rotation_depth=rotation_depth,
        statevector=statevector,
    )


def display_gate_name(name: str) -> str:
    return DISPLAY_ALIASES.get(name, name)


def format_gate_counts(gate_counts: Mapping[str, int]) -> str:
    ordered_names: list[str] = []
    for name in PREFERRED_GATE_ORDER:
        if name in gate_counts and name not in ordered_names:
            ordered_names.append(name)
    for name in sorted(gate_counts):
        if name not in ordered_names:
            ordered_names.append(name)
    return ", ".join(f"{display_gate_name(name)}={int(gate_counts[name])}" for name in ordered_names)


def format_report(report: ResourceReport) -> str:
    lines = [str(report.label)]
    if report.width is not None:
        lines.append(f"width: {report.width}")
    if report.depth is not None:
        lines.append(f"depth: {report.depth}")
    lines.append(f"gates: {report.total_gates}  ({format_gate_counts(report.gate_counts)})")
    lines.append(
        f"rot-count: {report.rotation_count}[+{report.clifford_rotation_count}]  "
        f"(T={report.t_count}, approx={report.approx_rotation_count}; "
        f"clifford={report.clifford_rotation_count})"
    )
    if report.rotation_depth is not None:
        lines.append(f"rot-depth: {report.rotation_depth}")
    if report.statevector is not None:
        lines.append("\nResulting statevector:")
        lines.append(report.statevector)
    if report.notes:
        lines.append("\nNotes:")
        lines.extend(f"- {note}" for note in report.notes)
    return "\n".join(lines)


def print_report(report: ResourceReport) -> None:
    print(format_report(report))
