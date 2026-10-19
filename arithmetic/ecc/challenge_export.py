"""Export Silq to QECCOPSZ; --run builds and runs the pinned official evaluator.

Requires Python 3.14+, Silq, hqir-rs, Git and Cargo.
"""
import argparse
from compression import zstd
from dataclasses import dataclass
import math
from pathlib import Path
import re
import shutil
import struct
import subprocess
import time

ROOT = Path(__file__).resolve().parent
ARITHMETIC_ROOT = ROOT.parent
HARNESS_URL = 'https://github.com/Layr-Labs/ecdsafail-challenge.git'
HARNESS_COMMIT = '33f23d39484475aeb5e94728b87a8e6e1ab4b10f'
NONE = (1 << 64) - 1
RECORD = struct.Struct('<II6Q')
SECP_P = 2**256 - 2**32 - 977


@dataclass
class Block:
    width: int
    bits: int
    body: list


def qids(text):
    items = text.split(',') if text.strip() else []
    result = []
    for item in items:
        m = re.fullmatch(r'\s*q(?:\[(\d+)\]|(\d+))\s*', item)
        if not m:
            raise ValueError(f'Unsupported quantum operand: {item}')
        result.append(int(m[1] or m[2]))
    return tuple(result)


def parse_body(lines):
    body, bits, i, depth = [], 0, 0, 0
    condition_sizes = []
    while i < len(lines):
        line = lines[i].strip()
        i += 1
        if not line or line.startswith('//'):
            continue
        m = re.fullmatch(r'bit m(\d+);', line)
        if m:
            bits = max(bits, int(m[1])+1)
            continue
        if line.startswith('if (') and line.endswith(') {'):
            parts = line[4:-3].split(' && ')
            for part in parts:
                m = re.fullmatch(r'm(\d+)==(true|false)', part.strip('()'))
                if not m:
                    raise ValueError(f'Unsupported classical condition: {line}')
                body.append(('if', int(m[1]), m[2] == 'true'))
            condition_sizes.append(len(parts)); depth += len(parts)
            continue
        if line == '}':
            if not condition_sizes:
                raise ValueError('Unmatched conditional end')
            size = condition_sizes.pop(); depth -= size
            body.extend([('endif',)] * size)
            continue
        m = re.fullmatch(r'h (q\d+);', line)
        if m:
            # HMR must match H, measurement, then reset exactly.
            if i+1 >= len(lines):
                raise ValueError('Unmatched Hadamard')
            measure = re.fullmatch(r'm(\d+) = measure '+m[1]+r';', lines[i].strip())
            if not measure or lines[i+1].strip() != f'reset {m[1]};':
                raise ValueError(f'Unsupported non-HMR Hadamard: {line}')
            body.append(('hmr', int(m[1][1:]), int(measure[1])))
            i += 2
            continue
        m = re.fullmatch(r'(silq_function_\w+)\((.*)\);', line)
        if not m:
            m = re.fullmatch(r'(silq_function_\w+) (.*);', line)
        if m:
            body.append(('call', m[1], qids(m[2])))
            continue
        m = re.fullmatch(r'reset q(\d+);', line)
        if m:
            body.append(('reset', int(m[1])))
            continue
        controls = []
        parts = line.rstrip(';').split(' @ ')
        for part in parts[:-1]:
            m = re.fullmatch(r'(negctrl|ctrl)(?:\((\d+)\))?', part)
            if not m:
                raise ValueError(f'Unsupported modifier: {line}')
            controls.extend([m[1] == 'negctrl'] * int(m[2] or 1))
        m = re.fullmatch(r'(\w+)(?:\(([^()]*)\))?(?: (.*))?', parts[-1])
        if not m:
            raise ValueError(f'Unsupported statement: {line}')
        name, angle, operands = m.groups()
        qs = qids(operands or '')
        if name in ('cx', 'ccx', 'cswap', 'cp', 'cz', 'ccz'):
            controls.extend([False] * (2 if name in ('ccx', 'ccz') else 1))
            name = {'cx': 'x', 'ccx': 'x', 'cswap': 'swap', 'cp': 'p', 'cz': 'z', 'ccz': 'z'}[name]
        if name in ('p', 'gphase'):
            multiple = float(angle) / math.pi
            if abs(multiple-round(multiple)) > 1e-12:
                raise ValueError(f'Non-native phase: {line}')
            if round(multiple) % 2 == 0:
                continue
            name = 'z' if name == 'p' else 'phase'
        elif angle is not None:
            raise ValueError(f'Unexpected gate parameter: {line}')
        arity = {'x': 1, 'z': 1, 'phase': 0, 'swap': 2}.get(name)
        if arity is None or len(qs) != len(controls)+arity:
            raise ValueError(f'Unsupported gate/arity: {line}')
        body.append(('gate', name, tuple(controls), qs))
    if depth:
        raise ValueError('Unclosed conditional')
    return bits, body


def read_qasm(path, n, marker='_challenge_point_add_runtime_', registers=5):
    lines = iter(path.read_text().splitlines())
    blocks, main = {}, []
    for raw in lines:
        line = raw.strip()
        if not line or line.startswith(('include ', 'OPENQASM ', '//')):
            continue
        m = re.fullmatch(r'def (\w+)\((.*)\) \{', line)
        gate = re.fullmatch(r'gate (\w+) (.*) \{', line)
        if gate:
            m = gate
        if not m:
            main.append(line)
            continue
        name, params = m.groups()
        params = params.split(',') if params else []
        prefix = '' if gate else 'qubit '
        if any(param.strip() != f'{prefix}q{i}' for i, param in enumerate(params)):
            raise ValueError('Only quantum-parameter subroutines are supported')
        depth, body = 1, []
        for raw in lines:
            depth += raw.count('{')-raw.count('}')
            if depth == 0:
                break
            body.append(raw)
        else:
            raise ValueError('Unclosed subroutine')
        bits, body = parse_body(body)
        blocks[name] = Block(len(params), bits, body)
    roots = [name for name in blocks if marker in name]
    if len(roots) != 1:
        raise ValueError('Expected one runtime point-add subroutine')
    root = roots[0]
    # Input order comes from the call signature.
    calls = [re.fullmatch(re.escape(root)+r'\((.*)\);', line) for line in main]
    calls = [m for m in calls if m]
    if len(calls) != 1:
        raise ValueError('Expected exactly one point-add call in the probe')
    callqs = qids(calls[0][1])
    hs = [int(m[1]) for line in main if (m := re.fullmatch(r'h q\[(\d+)\];', line))]
    if len(hs) != registers*n or set(hs) != set(callqs[:registers*n]):
        raise ValueError('Probe input preparation does not match its registers')
    for line in main:
        if not (re.fullmatch(r'qubit\[\d+\] q;', line) or
                re.fullmatch(r'h q\[\d+\];', line) or
                re.fullmatch(r'swap q\[\d+\], q\[\d+\];', line) or
                re.fullmatch(re.escape(root)+r'\(.*\);', line)):
            raise ValueError(f'Unexpected probe operation: {line}')
    return blocks, root


class ClassicalControls:
    """Exact classical-control propagation and clean-wire reuse in native output.

    Affine expressions are certificates only: quantum values are never read.
    Nonlinear quantum updates receive fresh symbols; large certificates are
    conservatively forgotten. Classical input/tangent bits remain immutable.
    """
    def __init__(self, emit, inputs, temporary, immutable):
        self.output = emit
        self.inputs = inputs
        self.mapping = {q: q for q in range(inputs)}
        self.expr = {q: (False, frozenset({-q-1})) for q in range(inputs)}
        self.symbol = -inputs-1
        self.free = []
        self.peak = inputs
        self.temporary = temporary
        self.immutable = set(immutable)
        self.depth = 0
        self.scopes = []
        self.classical_values = {bit: (False, frozenset({bit+1})) for bit in immutable}
        self.products = {}
        self.factors = {}
        self.product_limit = 16384
        self.pending_scope = None
        self.implications = {}

    def value(self, q):
        return self.expr.get(q, (False, frozenset()))

    def fresh(self):
        self.symbol -= 1
        return False, frozenset({self.symbol})

    def xor(self, a, b):
        value = a[0] ^ b[0], a[1] ^ b[1]
        return self.fresh() if len(value[1]) > 32 and not self.classical(value) else value

    @staticmethod
    def classical(value):
        return all(bit >= 0 for bit in value[1])

    def toggle_classical(self, physical, value):
        if value[0]:
            self.output(6, (physical,))
        for token in sorted(value[1]):
            self.output(6, (physical,), condition=token-1)

    def wire(self, q):
        if q not in self.mapping:
            if self.free:
                physical = self.free.pop()
            else:
                physical = self.peak
                self.peak += 1
            self.mapping[q] = physical
            value = self.value(q)
            if not self.classical(value):
                raise ValueError('Missing live quantum value')
            self.toggle_classical(physical, value)
        return self.mapping[q]

    def assign(self, q, value, cleared=False):
        self.expr[q] = value
        if not self.scopes and q >= self.inputs and q in self.mapping and self.classical(value):
            physical = self.mapping.pop(q)
            if not cleared:
                self.toggle_classical(physical, value)
                self.output(11, (physical,))
            self.free.append(physical)

    def product(self, a, b):
        # Boolean products certify guarded XORs; they never evaluate a qubit.
        if not a[1]:
            return b if a[0] else a
        if not b[1]:
            return a if b[0] else b
        if a == b:
            return a
        if len(self.products) > self.product_limit:
            values = [a, b, *self.expr.values(), *self.classical_values.values()]
            scopes = self.scopes + ([self.pending_scope] if self.pending_scope else [])
            for previous, guard, journal in scopes:
                values.extend(previous.values()); values.append(guard); values.extend(journal.values())
            live = {token for value in values for token in value[1]}
            self.products = {key: token for key, token in self.products.items() if token in live}
            self.factors = {token: factors for token, factors in self.factors.items() if token in live}
            self.product_limit = max(16384, 2*len(self.products))
        key = tuple(sorted((a, b), key=lambda v: (v[0], tuple(sorted(v[1])))))
        terms = set()
        def toggle(token):
            if token in terms:
                terms.remove(token)
            else:
                terms.add(token)
        if a[0]:
            terms.update(b[1])
        if b[0]:
            for token in a[1]:
                toggle(token)
        for left in a[1]:
            for right in b[1]:
                factors = self.factors.get(left, frozenset({left})) | self.factors.get(right, frozenset({right}))
                if len(factors) == 1:
                    token = next(iter(factors))
                else:
                    monomial = ('monomial', factors)
                    if monomial not in self.products:
                        token = next(iter(self.fresh()[1]))
                        self.products[monomial] = token
                        self.factors[token] = factors
                    token = self.products[monomial]
                toggle(token)
        if len(terms) > 32:
            opaque = ('product', key)
            if opaque not in self.products:
                self.products[opaque] = next(iter(self.fresh()[1]))
            return False, frozenset({self.products[opaque]})
        return a[0] and b[0], frozenset(terms)

    def implied(self, value):
        result = {value}
        todo = [value]
        for _ in range(16):
            if not todo:
                break
            for parent in self.implications.get(todo.pop(), ()):
                if parent not in result:
                    result.add(parent); todo.append(parent)
        return result

    def redundant_controls(self, values):
        if len(values) < 2 or not any(value in self.implications for value in values):
            return set()
        remove = set()
        for i, value in enumerate(values):
            if i in remove:
                continue
            implied = self.implied(value)
            for j, other in enumerate(values):
                if i == j or j in remove:
                    continue
                if (not other[0], other[1]) in implied:
                    return None
                if other in implied:
                    remove.add(j)
        return remove

    def remember_and(self, value, controls):
        self.implications[value] = tuple(controls)
        if len(self.implications) <= 16384:
            return
        values = [*self.expr.values(), *self.classical_values.values(), value]
        scopes = self.scopes + ([self.pending_scope] if self.pending_scope else [])
        for previous, guard, journal in scopes:
            values.extend(previous.values()); values.append(guard); values.extend(journal.values())
        live = {token for val in values for token in val[1]}
        keep = {}
        todo = [key for key in self.implications if key[1] & live]
        while todo:
            key = todo.pop()
            if key in keep:
                continue
            parents = self.implications[key]; keep[key] = parents
            for parent in parents:
                if parent in self.implications:
                    todo.append(parent)
        self.implications = keep

    def classical_value(self, bit):
        return self.classical_values.get(bit, (False, frozenset()))

    def set_classical(self, bit, value):
        before = self.classical_value(bit)
        for _, _, journal in self.scopes:
            journal.setdefault(bit, before)
        self.classical_values[bit] = value

    def begin_scope(self, qs, bit, positive):
        # Bind wires before the branch, then freeze their physical locations.
        previous = {q: self.value(q) for q in qs}
        for q in sorted(qs):
            self.wire(q)
        guard = self.classical_value(bit)
        if not positive:
            guard = not guard[0], guard[1]
        self.scopes.append((previous, guard, {}))

    def end_scope(self):
        previous, guard, journal = self.scopes.pop()
        self.pending_scope = previous, guard, journal
        for q, before in previous.items():
            # Preserve correlations across separately emitted feedback blocks.
            delta = self.xor(before, self.value(q))
            self.assign(q, self.xor(before, self.product(guard, delta)))
        for bit, before in journal.items():
            delta = self.xor(before, self.classical_value(bit))
            self.set_classical(bit, self.xor(before, self.product(guard, delta)))
        self.pending_scope = None

    def conditions(self, values):
        for j, value in enumerate(values):
            if not value[0] and len(value[1]) == 1:
                bit = next(iter(value[1]))-1
            else:
                bit = self.temporary+j
                self.output(5 if value[0] else 4, bit=bit)
                for token in sorted(value[1]):
                    self.output(3, bit=bit, condition=token-1)
            self.output(15, condition=bit)

    def phase(self, qs, negative=(), condition=NONE):
        quantum, classical, flips = [], [], []
        seen = set()
        values = [(self.value(q)[0] ^ (j < len(negative) and negative[j]), self.value(q)[1]) for j, q in enumerate(qs)]
        redundant = self.redundant_controls(values)
        if redundant is None:
            return
        for j, q in enumerate(qs):
            if j in redundant:
                continue
            value = self.value(q)
            neg = j < len(negative) and negative[j]
            signed = value[0] ^ neg, value[1]
            if (not signed[0], signed[1]) in seen:
                return
            if signed in seen:
                continue
            seen.add(signed)
            if self.classical(value):
                value = value[0] ^ neg, value[1]
                if not value[1]:
                    if not value[0]:
                        return
                else:
                    classical.append(value)
            else:
                physical = self.wire(q)
                quantum.append(physical)
                if neg:
                    flips.append(physical)
        if len(quantum) > 3:
            raise ValueError('Classical propagation requires decomposed phase gates')
        self.conditions(classical)
        for physical in flips:
            self.output(6, (physical,))
        self.output((0, 7, 9, 14)[len(quantum)], tuple(quantum), condition=condition)
        for physical in reversed(flips):
            self.output(6, (physical,))
        for _ in classical:
            self.output(16)

    def emit(self, kind, qs=(), bit=NONE, condition=NONE, register=NONE):
        if kind == 15:
            self.depth += 1
            self.output(kind, qs, bit, condition, register)
            return
        if kind == 16:
            self.depth -= 1
            self.output(kind, qs, bit, condition, register)
            return
        if kind in (3, 4, 5):
            if kind == 3:
                term = (True, frozenset()) if condition == NONE else self.classical_value(condition)
                value = self.xor(self.classical_value(bit), term)
            else:
                value = kind == 5, frozenset()
            self.set_classical(bit, value)
        if kind not in (0, 6, 7, 8, 9, 10, 11, 12, 13, 14):
            self.output(kind, qs, bit, condition, register)
            return
        if kind == 0:
            self.output(kind, qs, bit, condition, register)
            return
        if kind in (11, 12):
            q = qs[0]
            if (self.depth and not self.scopes) or condition != NONE:
                raise ValueError('Conditional reset is not supported by classical propagation')
            if kind == 12:
                self.set_classical(bit, (False, frozenset()) if self.classical(self.value(q)) else self.fresh())
            if kind == 12 and self.classical(self.value(q)):
                # Erase a classically known state coherently and select the
                # zero measurement branch; later phase repair is then idle.
                if q in self.mapping:
                    self.toggle_classical(self.mapping[q], self.value(q))
                self.assign(q, (False, frozenset()), cleared=True)
                self.output(4, bit=bit)
            else:
                if q in self.mapping:
                    self.output(kind, (self.mapping[q],), bit, condition, register)
                self.assign(q, (False, frozenset()), cleared=True)
            return
        if kind == 10:
            if (self.depth and not self.scopes) or condition != NONE:
                raise ValueError('Conditional swap is not supported by classical propagation')
            a, b = qs
            va, vb = self.value(a), self.value(b)
            if self.classical(va) and self.classical(vb) and a not in self.mapping and b not in self.mapping:
                self.assign(a, vb); self.assign(b, va)
            else:
                self.output(10, (self.wire(a), self.wire(b)))
                self.assign(a, vb); self.assign(b, va)
            return
        phase = kind in (7, 9, 14)
        controls = qs if phase else qs[:-1]
        quantum, classical = [], []
        seen = set()
        redundant = self.redundant_controls([self.value(q) for q in controls])
        if redundant is None:
            return
        for index, q in enumerate(controls):
            if index in redundant:
                continue
            value = self.value(q)
            if (not value[0], value[1]) in seen:
                return
            if value in seen:
                continue
            seen.add(value)
            if self.classical(value):
                if not value[1]:
                    if not value[0]:
                        return
                else:
                    classical.append(value)
            else:
                quantum.append(q)
        if phase:
            self.conditions(classical)
            self.output((0, 7, 9, 14)[len(quantum)], tuple(self.wire(q) for q in quantum), condition=condition)
            for _ in classical:
                self.output(16)
            return
        target = qs[-1]
        old = self.value(target)
        if self.depth and not self.scopes:
            raise ValueError('Classically scoped quantum arithmetic is not supported')
        if condition != NONE:
            if kind != 6 or condition not in self.immutable:
                raise ValueError('Unexpected mutable classical arithmetic control')
            classical.append((False, frozenset({condition+1})))
        if not quantum and len(classical) <= 1:
            term = classical[0] if classical else (True, frozenset())
            value = self.xor(old, term)
            if target in self.mapping:
                self.toggle_classical(self.mapping[target], term)
            self.assign(target, value)
            return
        if len(quantum) == 2 and not classical:
            controls = tuple(self.value(q) for q in quantum)
            for constant in (False, True):
                literal = old[0] ^ constant, old[1]
                factors = self.implications.get(literal)
                if factors is not None and frozenset(factors) == frozenset(controls):
                    physical = self.wire(target)
                    scratch = self.temporary+3
                    self.output(12, (physical,), bit=scratch)
                    self.set_classical(scratch, self.fresh())
                    self.output(9, tuple(self.wire(q) for q in quantum), condition=scratch)
                    if constant:
                        self.output(0, condition=scratch)
                        self.output(6, (physical,))
                    self.assign(target, (constant, frozenset()), cleared=not constant)
                    return
        value = self.xor(old, self.value(quantum[0])) if len(quantum) == 1 and not classical else self.fresh()
        if len(quantum) == 2 and not classical and not old[1]:
            literal = value[0] ^ old[0], value[1]
            self.remember_and(literal, [self.value(q) for q in quantum])
        physical = tuple(self.wire(q) for q in quantum)+(self.wire(target),)
        self.conditions(classical)
        self.output((6, 8, 13)[len(quantum)], physical)
        for _ in classical:
            self.output(16)
        self.assign(target, value)


class Exporter:
    def __init__(self, blocks, root, n, write, tangent=None, classical_controls=False):
        self.blocks, self.root, self.n, self.write = blocks, root, n, write
        self.width = blocks[root].width
        self.scratch_bit = 2*n
        self.next_bit = self.scratch_bit+1
        self.count = 0
        self.peak = self.width
        self.tangent = tangent
        self.classical_controls = classical_controls
        self.optimizer = None

    def raw_emit(self, kind, qs=(), bit=NONE, condition=NONE, register=NONE):
        if len(set(qs)) != len(qs):
            raise ValueError('Aliased quantum operands')
        target = qs[-1] if qs else NONE
        control1 = qs[-2] if len(qs) >= 2 else NONE
        control2 = qs[-3] if len(qs) >= 3 else NONE
        self.write(RECORD.pack(kind, 0, control2, control1, target, bit, condition, register))
        self.count += 1

    def emit(self, kind, qs=(), bit=NONE, condition=NONE, register=NONE):
        if self.optimizer is None:
            self.raw_emit(kind, qs, bit, condition, register)
        else:
            self.optimizer.emit(kind, qs, bit, condition, register)

    def controlled(self, name, controls, targets):
        # Clean AND ladder; erase each temporary AND by HMR and a CZ fixup.
        if name == 'swap':
            a, b = targets
            if not controls:
                self.emit(10, (a, b))
            else:
                self.emit(8, (b, a))
                self.controlled('x', controls+(a,), (b,))
                self.emit(8, (b, a))
            return
        if name == 'phase':
            if not controls:
                self.emit(0)
                return
            controls, targets = controls[:-1], controls[-1:]
            name = 'z'
        if len(controls) <= 2:
            kinds = (6, 8, 13) if name == 'x' else (7, 9, 14)
            self.emit(kinds[len(controls)], controls+targets)
            return
        anc = tuple(range(self.width, self.width+len(controls)-2))
        self.peak = max(self.peak, anc[-1]+1)
        chain = [(controls[0], controls[1], anc[0])]
        chain += [(anc[j-1], controls[j+1], anc[j]) for j in range(1, len(anc))]
        for operands in chain:
            self.emit(13, operands)
        self.controlled(name, (anc[-1], controls[-1]), targets)
        for operands in reversed(chain):
            self.emit(12, (operands[2],), bit=self.scratch_bit)
            self.emit(9, operands[:2], condition=self.scratch_bit)

    def scope_operands(self, instructions, mapping):
        touched, writes = set(), False
        for inst in instructions:
            if inst[0] == 'call':
                qs, changed = self.scope_operands(self.blocks[inst[1]].body,
                    tuple(mapping[q] for q in inst[2]))
                touched.update(qs); writes |= changed
            elif inst[0] == 'gate':
                _, gate, signs, qs = inst
                touched.update(mapping[q] for q in qs)
                writes |= gate in ('x', 'swap')
                count = len(signs) - (gate == 'phase')
                if count > 2:
                    touched.update(range(self.width, self.width+count-2))
            elif inst[0] in ('hmr', 'reset'):
                touched.add(mapping[inst[1]]); writes = True
        return touched, writes

    def block(self, name, mapping, bitbase):
        block = self.blocks[name]
        if len(mapping) != block.width or len(set(mapping)) != len(mapping):
            raise ValueError(f'Invalid subroutine arguments: {name}')
        # Child measurements must not overwrite their parent's bits.
        childbase = bitbase+block.bits
        self.next_bit = max(self.next_bit, childbase)
        condition_stack = []
        for index, inst in enumerate(block.body):
            op = inst[0]
            if op == 'call':
                self.block(inst[1], tuple(mapping[q] for q in inst[2]), childbase)
            elif op == 'if':
                scoped = False
                if self.optimizer is not None:
                    end, level = index+1, 1
                    while level:
                        level += (block.body[end][0] == 'if') - (block.body[end][0] == 'endif')
                        end += 1
                    touched, changed = self.scope_operands(block.body[index+1:end-1], mapping)
                    if changed:
                        self.optimizer.begin_scope(touched, bitbase+inst[1], inst[2])
                        scoped = True
                bit = bitbase+inst[1]
                if not inst[2]:
                    self.emit(3, bit=bit)
                self.emit(15, condition=bit)
                condition_stack.append((bit, inst[2], scoped))
            elif op == 'endif':
                self.emit(16)
                bit, positive, scoped = condition_stack.pop()
                if scoped:
                    self.optimizer.end_scope()
                if not positive:
                    self.emit(3, bit=bit)
            elif op == 'hmr':
                self.emit(12, (mapping[inst[1]],), bitbase+inst[2])
            elif op == 'reset':
                self.emit(11, (mapping[inst[1]],))
            else:
                _, gate, signs, qs = inst
                qs = tuple(mapping[q] for q in qs)
                if self.optimizer is not None and gate in ('z', 'phase') and len(qs) <= 3:
                    self.optimizer.phase(qs, signs)
                    continue
                negative = [q for q, neg in zip(qs, signs) if neg]
                for q in negative:
                    self.emit(6, (q,))
                self.controlled(gate, qs[:len(signs)], qs[len(signs):])
                for q in reversed(negative):
                    self.emit(6, (q,))

    def classical_block(self, blocks, name, mapping, bitbase):
        """Classical Boolean evaluation: discard phases, select zero HMR outcomes."""
        block = blocks[name]
        self.next_bit = max(self.next_bit, bitbase+block.bits)
        stack = []
        for inst in block.body:
            op = inst[0]
            if op == 'call':
                self.classical_block(blocks, inst[1], tuple(mapping[q] for q in inst[2]), bitbase+block.bits)
            elif op == 'if':
                bit = bitbase+inst[1]
                if not inst[2]:
                    self.emit(3, bit=bit)
                self.emit(15, condition=bit)
                stack.append((bit, inst[2]))
            elif op == 'endif':
                self.emit(16)
                bit, positive = stack.pop()
                if not positive:
                    self.emit(3, bit=bit)
            elif op == 'hmr':
                self.emit(4, bit=mapping[inst[1]])
                self.emit(4, bit=bitbase+inst[2])
            elif op == 'reset':
                self.emit(4, bit=mapping[inst[1]])
            else:
                _, gate, signs, qs = inst
                if gate in ('z', 'phase'):
                    continue
                qs = tuple(mapping[q] for q in qs)
                controls, targets = qs[:len(signs)], qs[len(signs):]
                negative = [q for q, neg in zip(controls, signs) if neg]
                for bit in negative:
                    self.emit(3, bit=bit)
                for bit in controls:
                    self.emit(15, condition=bit)
                if gate == 'x':
                    self.emit(3, bit=targets[0])
                else:
                    a, b = targets
                    self.emit(3, bit=a, condition=b)
                    self.emit(3, bit=b, condition=a)
                    self.emit(3, bit=a, condition=b)
                for _ in controls:
                    self.emit(16)
                for bit in reversed(negative):
                    self.emit(3, bit=bit)

    def run(self):
        n = self.n
        for r in range(4):
            self.emit(1, register=r)
            for j in range(n):
                if r < 2:
                    self.emit(2, (r*n+j,), register=r)
                else:
                    self.emit(2, bit=(r-2)*n+j, register=r)
        if self.tangent is None:
            raise ValueError('Runtime tangent circuit is required')
        classical, tangent_root = self.tangent
        cwidth = classical[tangent_root].width
        cbase = self.scratch_bit+1
        for j in range(2*n):
            self.emit(3, bit=cbase+j, condition=j)
        self.classical_block(classical, tangent_root,
                             tuple(range(cbase, cbase+cwidth)), cbase+cwidth)
        tangent_bits = tuple(range(cbase+2*n, cbase+3*n))
        if self.classical_controls:
            from functools import lru_cache
            @lru_cache(None)
            def bit_depth(name):
                block = self.blocks[name]
                return block.bits+max((bit_depth(i[1]) for i in block.body if i[0] == 'call'), default=0)
            temporary = self.next_bit+bit_depth(self.root)+1
            self.optimizer = ClassicalControls(self.raw_emit, 2*n, temporary,
                                              tuple(range(2*n))+tangent_bits)
        for j in range(2*n):
            self.emit(6, (2*n+j,), condition=j)
        for j, bit in enumerate(tangent_bits):
            self.emit(6, (4*n+j,), condition=bit)
        self.block(self.root, tuple(range(self.width)), self.next_bit)
        for j in range(2*n):
            self.emit(6, (2*n+j,), condition=j)
            self.emit(11, (2*n+j,))
        for j, bit in enumerate(tangent_bits):
            self.emit(6, (4*n+j,), condition=bit)
            self.emit(11, (4*n+j,))
        if self.optimizer is not None:
            self.peak = self.optimizer.peak
            self.next_bit = max(self.next_bit, self.optimizer.temporary+4)


def compile_qasm(work, hqir, p, n, ca=0, tangent=False):
    source = work/'source'
    arithmetic = source/'arithmetic'
    arithmetic.mkdir(parents=True, exist_ok=True)
    for path in ARITHMETIC_ROOT.glob('*.slq'):
        shutil.copy2(path, arithmetic/path.name)
    challenge = arithmetic/'ecc'
    challenge.mkdir(parents=True, exist_ok=True)
    for path in ROOT.glob('*.slq'):
        shutil.copy2(path, challenge/path.name)
    primitives = source/'primitives'
    primitives.mkdir(parents=True, exist_ok=True)
    for path in (ARITHMETIC_ROOT.parent/'primitives').glob('*.slq'):
        shutil.copy2(path, primitives/path.name)
    probe = f'challenge_tangent_probe[{p}][{ca}][{n}]' if tangent else f'challenge_runtime_probe[{p}][{n}]'
    (source/'probe.slq').write_text('import arithmetic.ecc.ecc_challenge;\n'
        f'def main(){{return {probe}();}}\n')
    output = work/('tangent.qasm' if tangent else 'circuit.qasm')
    started = time.monotonic()
    with output.open('w') as out, output.with_suffix('.compile.log').open('w') as err:
        subprocess.run([hqir, 'probe.slq', '-O3', '--flatten', '-R3',
                        '--no-use-rccx', '--qasm'], cwd=source,
                       stdout=out, stderr=err, check=True)
    print(f'Compiled native-basis QASM in {time.monotonic()-started:.2f}s', flush=True)
    return output


def export(qasm, tangent_qasm, destination, n):
    blocks, root = read_qasm(qasm, n)
    tangent = read_qasm(tangent_qasm, n, '_challenge_tangent_', 3)
    temporary = destination.with_suffix('.bin.tmp')
    with temporary.open('w+b') as raw:
        raw.write(b'QECCOPSZ'+struct.pack('<Q', 0))
        with zstd.ZstdFile(raw, 'w', level=3) as compressed:
            exporter = Exporter(blocks, root, n, compressed.write, tangent, classical_controls=True)
            exporter.run()
        raw.seek(8)
        raw.write(struct.pack('<Q', exporter.count))
    temporary.replace(destination)
    print(f'Exported {exporter.count:,} native operations; '
          f'{exporter.peak} qubits; {exporter.next_bit} classical bits', flush=True)
    return exporter


def prepare_evaluator(harness):
    if not harness.exists():
        harness.parent.mkdir(parents=True, exist_ok=True)
        subprocess.run(['git', 'clone', HARNESS_URL, str(harness)], check=True)
        subprocess.run(['git', '-C', str(harness), 'checkout', '--detach', HARNESS_COMMIT], check=True)
    revision = subprocess.check_output(['git', '-C', str(harness), 'rev-parse', 'HEAD'], text=True).strip()
    if revision != HARNESS_COMMIT:
        raise ValueError(f'Harness must be at {HARNESS_COMMIT}; found {revision}')
    trusted = ['Cargo.toml', 'Cargo.lock', 'rust-toolchain', 'src/lib.rs',
               'src/circuit.rs', 'src/sim.rs', 'src/weierstrass_elliptic_curve.rs',
               'src/bin/eval_circuit.rs']
    subprocess.run(['git', '-C', str(harness), 'diff', '--exit-code', 'HEAD', '--', *trusted], check=True)
    target = harness.parent/'target'
    subprocess.run(['cargo', 'build', '--locked', '--release', '--bin', 'eval_circuit',
                    '--manifest-path', str(harness/'Cargo.toml'), '--target-dir', str(target)],
                   cwd=harness, check=True)
    return target/'release/eval_circuit'


def evaluate(evaluator, harness, work):
    score = work/'score.json'
    score.unlink(missing_ok=True)
    (harness/'score.json').unlink(missing_ok=True)
    started = time.monotonic()
    with (work/'evaluation.log').open('w') as log:
        process = subprocess.Popen([str(evaluator), '--note', 'Silq runtime-offset binary divider'],
                                   cwd=work, text=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
        for line in process.stdout:
            print(line, end='', flush=True)
            log.write(line)
            log.flush()
        if process.wait():
            raise subprocess.CalledProcessError(process.returncode, process.args)
    shutil.copy2(harness/'score.json', score)
    print(f'Evaluated in {time.monotonic()-started:.2f}s; score: {score}', flush=True)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--work-dir', type=Path, default=ROOT/'.challenge/run_final')
    parser.add_argument('--hqir', default=str(Path.home()/'.local/bin/hqir-rs'))
    parser.add_argument('--qasm', type=Path, help='Reuse a previously compiled native-basis probe')
    parser.add_argument('--tangent-qasm', type=Path)
    parser.add_argument('--bits', type=int, default=256)
    parser.add_argument('--prime', type=int, default=SECP_P)
    parser.add_argument('--curve-a', type=int, default=0)
    parser.add_argument('--run', action='store_true', help='Build, export and run the official evaluation')
    parser.add_argument('--evaluate-only', action='store_true', help='Re-evaluate the existing ops.bin')
    parser.add_argument('--harness', type=Path, default=ROOT/'.challenge/harness')
    args = parser.parse_args()
    args.work_dir = args.work_dir.resolve()
    args.harness = args.harness.resolve()
    run = args.run or args.evaluate_only
    if args.prime.bit_length() != args.bits:
        parser.error('--bits must equal the field modulus bit length')
    if run and (args.bits != 256 or args.prime != SECP_P or args.curve_a != 0):
        parser.error('The official evaluator requires exact secp256k1 parameters')
    if args.evaluate_only and not (args.work_dir/'ops.bin').is_file():
        parser.error('No ops.bin to evaluate; use --run first')
    evaluator = prepare_evaluator(args.harness) if run else None
    args.work_dir.mkdir(parents=True, exist_ok=True)
    if not args.evaluate_only:
        qasm = args.qasm or compile_qasm(args.work_dir, args.hqir, args.prime, args.bits)
        tangent_qasm = args.tangent_qasm or compile_qasm(args.work_dir, args.hqir, args.prime, args.bits, args.curve_a, True)
        export(qasm, tangent_qasm, args.work_dir/'ops.bin', args.bits)
    if run:
        evaluate(evaluator, args.harness, args.work_dir)


if __name__ == '__main__':
    main()
