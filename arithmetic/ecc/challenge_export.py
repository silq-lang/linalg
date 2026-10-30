"""Build Silq from source and run the pinned official evaluator.

Requires Python 3.14+, Silq, hqir-rs, Git and Cargo.
Running this file without arguments recompiles all secp256k1 stages without
cached QASM, exports the circuit, and reports the verified resource metrics.
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
    preserves: tuple = ()


def qids(text):
    items = text.split(',') if text.strip() else []
    result = []
    for item in items:
        m = re.fullmatch(r'\s*q(?:\[(\d+)\]|(\d+))\s*', item)
        if not m:
            raise ValueError(f'Unsupported quantum operand: {item}')
        result.append(int(m[1] or m[2]))
    return tuple(result)


def collapse_mbu_ands(lines):
    """Represent an exact four-T fresh-target AND as one logical Toffoli."""
    lines = list(lines)
    result, i = [], 0
    q = r'(q(?:\[\d+\]|\d+))'
    def pi_phase(controls):
        modifiers = ' @ '.join('negctrl' if negative else 'ctrl'
                               for _,negative in controls)
        operands = ', '.join(wire for wire,_ in controls)
        return f'{modifiers} @ gphase({math.pi}) {operands};'
    def condition_boundary(line):
        line = line.strip()
        return line == '}' or bool(re.fullmatch(r'if \(.*\) \{', line))
    while i < len(lines):
        # The same AND template constant-folds both controls true to this
        # Clifford sequence. Its target is fresh |0>, on which it is exactly X.
        if i+4 < len(lines):
            unary = lines[i:i+5]
            h0 = re.fullmatch(r'h '+q+r';', unary[0].strip())
            gp = re.fullmatch(r'negctrl @ gphase\(([^)]+)\) '+q+r';', unary[1].strip())
            p1 = re.fullmatch(r'p\(([^)]+)\) '+q+r';', unary[2].strip())
            h1 = re.fullmatch(r'h '+q+r';', unary[3].strip())
            p2 = re.fullmatch(r'p\(([^)]+)\) '+q+r';', unary[4].strip())
            if all((h0,gp,p1,h1,p2)) and len({h0[1],gp[2],p1[2],h1[1],p2[2]})==1:
                angles = (float(gp[1]),float(p1[1]),float(p2[1]))
                if all(abs(x-y)<1e-12 for x,y in zip(angles,
                                                     (math.pi/2,-math.pi/2,-math.pi/2))):
                    result.append(f'x {h0[1]};')
                    i += 5
                    continue
        if re.fullmatch(r'h '+q+r';', lines[i].strip()):
            target = re.fullmatch(r'h '+q+r';', lines[i].strip())[1]
            # Scheduling may interleave preparation of a control before that
            # control's first use. Such operations commute left across H(target).
            window, hoisted, consumed = [], [], 0
            for offset, line in enumerate(lines[i:i+24]):
                if target in re.findall(q, line):
                    window.append(line)
                    if len(window) == 11:
                        consumed = offset+1
                        break
                else:
                    hoisted.append((offset, line))
            if len(window) != 11:
                window = []
        else:
            window = []
        if window:
            h0 = re.fullmatch(r'h '+q+r';', window[0].strip())
            controlled_x = r'(?:(negctrl) @ x|cx) '+q+r', '+q+r';'
            c1 = re.fullmatch(controlled_x, window[1].strip())
            p1 = re.fullmatch(r'p\(([^)]+)\) '+q+r';', window[2].strip())
            c2 = re.fullmatch(controlled_x, window[3].strip())
            p2 = re.fullmatch(r'p\(([^)]+)\) '+q+r';', window[4].strip())
            c3 = re.fullmatch(controlled_x, window[5].strip())
            p3 = re.fullmatch(r'p\(([^)]+)\) '+q+r';', window[6].strip())
            c4 = re.fullmatch(controlled_x, window[7].strip())
            p4 = re.fullmatch(r'p\(([^)]+)\) '+q+r';', window[8].strip())
            h1 = re.fullmatch(r'h '+q+r';', window[9].strip())
            ps = re.fullmatch(r'p\(([^)]+)\) '+q+r';', window[10].strip())
            u1 = re.fullmatch(r'x '+q+r';', window[1].strip())
            u3 = re.fullmatch(r'x '+q+r';', window[5].strip())
            constant_matches = (h0,u1,p1,c2,p2,u3,p3,c4,p4,h1,ps)
            if all(constant_matches):
                target, b = h0[1], c2[2]
                same_target = (u1[1]==c2[3]==u3[1]==c4[3]
                    ==p1[2]==p2[2]==p3[2]==p4[2]==h1[1]==ps[2]==target)
                angles = tuple(float(m[1])/math.pi for m in (p1,p2,p3,p4,ps))
                expected = (0.25,-0.25,0.25,-0.25)
                first_use = next(offset for offset,line in enumerate(lines[i:i+consumed])
                                 if (match := re.fullmatch(controlled_x,line.strip()))
                                 and match[2]==b and match[3]==target)
                safe_hoist = all(condition_boundary(line)
                                 or (unary := re.fullmatch(r'x '+q+r';',line.strip()))
                                 and offset < first_use and unary[1]==b
                                 or (cnot := re.fullmatch(controlled_x,line.strip()))
                                 and offset < first_use and cnot[3]==b
                                 for offset,line in hoisted)
                if (same_target and c4[2]==b and c4[1]==c2[1] and safe_hoist
                        and all(abs(x-y)<1e-12 for x,y in zip(angles,expected))
                        and abs(abs(angles[4])-0.5)<1e-12):
                    result.extend(line for _,line in hoisted)
                    result.append(window[3])
                    if angles[4] > 0:
                        result.append(pi_phase([(b,bool(c2[1]))]))
                    i += consumed
                    continue
            u2 = re.fullmatch(r'x '+q+r';', window[3].strip())
            u4 = re.fullmatch(r'x '+q+r';', window[7].strip())
            constant_matches = (h0,c1,p1,u2,p2,c3,p3,u4,p4,h1,ps)
            if all(constant_matches):
                target, a = h0[1], c1[2]
                same_target = (c1[3]==u2[1]==c3[3]==u4[1]
                    ==p1[2]==p2[2]==p3[2]==p4[2]==h1[1]==ps[2]==target)
                angles = tuple(float(m[1])/math.pi for m in (p1,p2,p3,p4,ps))
                expected = (0.25,-0.25,0.25,-0.25)
                first_use = next(offset for offset,line in enumerate(lines[i:i+consumed])
                                 if (match := re.fullmatch(controlled_x,line.strip()))
                                 and match[2]==a and match[3]==target)
                safe_hoist = all(condition_boundary(line)
                                 or (unary := re.fullmatch(r'x '+q+r';',line.strip()))
                                 and offset < first_use and unary[1]==a
                                 or (cnot := re.fullmatch(controlled_x,line.strip()))
                                 and offset < first_use and cnot[3]==a
                                 for offset,line in hoisted)
                if (same_target and c3[2]==a and c3[1]==c1[1] and safe_hoist
                        and all(abs(x-y)<1e-12 for x,y in zip(angles,expected))
                        and abs(abs(angles[4])-0.5)<1e-12):
                    result.extend(line for _,line in hoisted)
                    result.append(window[1])
                    if angles[4] > 0:
                        result.append(pi_phase([(a,bool(c1[1]))]))
                    i += consumed
                    continue
            matches = (h0,c1,p1,c2,p2,c3,p3,c4,p4,h1,ps)
            if all(matches):
                target, a, b = h0[1], c1[2], c2[2]
                same_target = (c1[3]==c2[3]==c3[3]==c4[3]
                    ==p1[2]==p2[2]==p3[2]==p4[2]==h1[1]==ps[2]==target)
                angles = tuple(float(m[1])/math.pi for m in (p1,p2,p3,p4,ps))
                expected = (0.25,-0.25,0.25,-0.25)
                first_use = {
                    wire: next(offset for offset, line in enumerate(lines[i:i+consumed])
                               if (match := re.fullmatch(controlled_x, line.strip()))
                               and match[2] == wire and match[3] == target)
                    for wire in (a,b)
                }
                def changed_wire(line):
                    unary = re.fullmatch(r'x '+q+r';', line.strip())
                    cnot = re.fullmatch(controlled_x, line.strip())
                    return unary[1] if unary else cnot[3] if cnot else None
                safe_hoist = all(condition_boundary(line)
                                 or (wire := changed_wire(line)) is not None
                                 and offset < first_use.get(wire, consumed)
                                 for offset, line in hoisted)
                same_controls = (c3[2]==a and c4[2]==b
                                 and c3[1]==c1[1] and c4[1]==c2[1])
                if (same_target and same_controls and safe_hoist
                        and all(abs(x-y)<1e-12 for x,y in zip(angles,expected))
                        and abs(abs(angles[4])-0.5)<1e-12):
                    result.extend(line for _,line in hoisted)
                    result.extend(f'x {wire};' for wire,negative in
                                  ((a,c1[1]),(b,c2[1])) if negative)
                    result.append(f'ccx {a}, {b}, {target};')
                    result.extend(f'x {wire};' for wire,negative in
                                  ((b,c2[1]),(a,c1[1])) if negative)
                    if angles[4] > 0:
                        result.append(pi_phase([(a,bool(c1[1])),(b,bool(c2[1]))]))
                    i += consumed
                    continue
        result.append(lines[i])
        i += 1
    return result


def parse_body(lines):
    lines = collapse_mbu_ands(lines)
    body, bits, i, depth = [], 0, 0, 0
    condition_sizes = []
    named_bits = {}

    def bit_id(name):
        nonlocal bits
        numbered = re.fullmatch(r'm(\d+)', name)
        if numbered:
            result = int(numbered[1])
            bits = max(bits, result+1)
            return result
        if name not in named_bits:
            named_bits[name] = bits
            bits += 1
        return named_bits[name]

    while i < len(lines):
        line = lines[i].strip()
        i += 1
        if not line or line.startswith('//'):
            continue
        m = re.fullmatch(r'bit ([A-Za-z_]\w*);', line)
        if m:
            bit_id(m[1])
            continue
        if line.startswith('if (') and line.endswith(') {'):
            parts = line[4:-3].split(' && ')
            for part in parts:
                condition = part.strip('()')
                m = re.fullmatch(r'([A-Za-z_]\w*)==(true|false)', condition)
                if not m:
                    m = re.fullmatch(r'(!?)([A-Za-z_]\w*)', condition)
                    if m:
                        body.append(('if', bit_id(m[2]), m[1] != '!'))
                        continue
                if not m:
                    raise ValueError(f'Unsupported classical condition: {line}')
                body.append(('if', bit_id(m[1]), m[2] == 'true'))
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
            measure = re.fullmatch(r'([A-Za-z_]\w*) = measure '+m[1]+r';', lines[i].strip())
            if not measure or lines[i+1].strip() != f'reset {m[1]};':
                context = ' | '.join(item.strip() for item in lines[max(0,i-4):i+12])
                raise ValueError(f'Unsupported non-HMR Hadamard: {context}')
            body.append(('hmr', int(m[1][1:]), bit_id(measure[1])))
            i += 2
            continue
        m = re.fullmatch(r'((?:silq_function|primitive_wrap_circuit)_\w+)\((.*)\);', line)
        if not m:
            m = re.fullmatch(r'((?:silq_function|primitive_wrap_circuit)_\w+) (.*);', line)
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
        self.dynamic_next = temporary+4
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
        if not self.scopes and q in self.mapping and self.classical(value):
            physical = self.mapping.pop(q)
            if not cleared:
                self.toggle_classical(physical, value)
                self.output(11, (physical,))
            self.free.append(physical)

    def restore_outputs(self):
        """Return logical outputs to the harness ABI using Clifford swaps.

        Input wires may join the scratch pool only after a Boolean certificate
        proves them classical and they are cleared. Their logical identities
        stay in expr; only physical locations change.
        """
        for q in range(self.inputs):
            self.wire(q)
        for q in range(self.inputs):
            physical = self.mapping[q]
            if physical == q:
                continue
            other = next((owner for owner, wire in self.mapping.items()
                          if wire == q), None)
            self.output(10, (physical, q))
            self.mapping[q] = q
            if other is not None:
                self.mapping[other] = physical
            else:
                self.free.remove(q)
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
        if not quantum:
            # Snapshot nonlinear classical controls into a fresh immutable bit.
            # Retain a classical certificate instead of inventing a quantum one.
            token = self.dynamic_next
            self.dynamic_next += 1
            self.output(4, bit=token)
            self.conditions(classical)
            self.output(5, bit=token)
            for _ in classical:
                self.output(16)
            self.immutable.add(token)
            term = (False, frozenset({token+1}))
            if target in self.mapping:
                self.toggle_classical(self.mapping[target], term)
            self.assign(target, self.xor(old, term))
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
            elif inst[0] == 'tangent':
                touched.update(mapping[q] for q in inst[1]); writes = True
        return touched, writes

    def block(self, name, mapping, bitbase):
        block = self.blocks[name]
        if len(mapping) != block.width or len(set(mapping)) != len(mapping):
            raise ValueError(f'Invalid subroutine arguments: {name}')
        # Source-declared unchanged operands retain their Boolean certificates.
        # Gates and phases are still emitted normally; this only prevents a
        # verified classical input from becoming an opaque quantum value.
        preserved = ([(mapping[q], self.optimizer.value(mapping[q]))
                      for q in block.preserves] if self.optimizer is not None else [])
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
            elif op == 'tangent':
                # XOR the exactly precomputed classical tangent slope.
                for q, bit in zip(inst[1], self.tangent_bits, strict=True):
                    self.emit(6, (mapping[q],), condition=bit)
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
        for q, value in preserved:
            self.optimizer.assign(q, value)

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
        tangent_bits = self.tangent_bits = tuple(range(cbase+2*n, cbase+3*n))
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
            self.optimizer.restore_outputs()
            self.peak = self.optimizer.peak
            self.next_bit = max(self.next_bit, self.optimizer.dynamic_next)


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
    parser.add_argument('--jobs', type=int, default=4, help='Parallel source compilation jobs')
    mode = parser.add_mutually_exclusive_group()
    mode.add_argument('--run', dest='run', action='store_true', default=True,
                      help='Build, export and run the official evaluation (default)')
    mode.add_argument('--export-only', dest='run', action='store_false',
                      help='Build and export without running the official evaluation')
    parser.add_argument('--evaluate-only', action='store_true', help='Re-evaluate the existing ops.bin')
    parser.add_argument('--harness', type=Path, default=ROOT/'.challenge/harness')
    args = parser.parse_args()
    args.work_dir = args.work_dir.resolve()
    args.harness = args.harness.resolve()
    run = args.run or args.evaluate_only
    if args.evaluate_only and not (args.work_dir/'ops.bin').is_file():
        parser.error('No ops.bin to evaluate; use --run first')
    evaluator = prepare_evaluator(args.harness) if run else None
    args.work_dir.mkdir(parents=True, exist_ok=True)
    if not args.evaluate_only:
        from source_build import export_source
        export_source(args.work_dir, args.hqir, args.jobs)
    if run:
        evaluate(evaluator, args.harness, args.work_dir)


if __name__ == '__main__':
    main()
