"""Build the ECC challenge from Silq sources with the local HQIR compiler.

Temporary HQIR circuit-call boundaries prevent whole-program expansion. Each
boundary is replaced by a separately compiled implementation from the same Silq
source tree. Phase tags in temporary boundary definitions carry build metadata;
they never enter the linked circuit. No pre-existing QASM is read.
"""
from concurrent.futures import ThreadPoolExecutor, as_completed
from compression import zstd
from dataclasses import dataclass
import hashlib
import json
import math
from pathlib import Path
import re
import subprocess
import time

import challenge_export as backend

P = backend.SECP_P
UNIT = math.pi/4096
# The build compiles challenge_point_add_runtime of ecc_challenge.slq.
ROOT_KERNEL = 'runtime'
# Its kernel calls become separately compiled boundaries.
RUNTIME_KERNELS = {'challenge_field_add', 'challenge_field_sub', 'challenge_field_rsub',
                   'challenge_tangent_sub', 'challenge_zero_flag', 'challenge_square_sub',
                   'pp_modular_map'}


@dataclass(frozen=True)
class Kernel:
    name: str
    a: int = 0
    b: int = 0

    @property
    def key(self):
        return f'{self.name}_{self.a}_{self.b}'


@dataclass
class Compiled:
    inputs: int
    block: backend.Block
    dependencies: dict


COMPOSITE = {'runtime', 'tangent', 'pp_map', 'binary_map', 'square'}
PP_LEAVES = {'pp_step_narrow', 'pp_unstep_narrow', 'pp_cell_div', 'pp_cell_mul',
             'pp_seed_div', 'pp_seed_mul', 'pp_end_div', 'pp_end_mul',
             'pp_cell_div_full', 'pp_cell_mul_full', 'pp_cell_div_quad', 'pp_cell_mul_quad', 'pp_cell_div_wide', 'pp_cell_mul_wide',
             'pp_step', 'pp_unstep'}
BINARY_LEAVES = {'binary_gcd_step', 'binary_gcd_unstep', 'binary_payload_step'}
MULT_LEAVES = {'modmult_addsub', 'undo_modmult_addsub', 'double_modp', 'half_modp'}


def probe(kernel):
    name, a, b = kernel.name, kernel.a, kernel.b
    imports = KERNEL_IMPORTS
    if name == 'runtime':
        imports = 'import arithmetic.ecc.ecc_challenge;\n'
        size = 1280
        layout = '(x:𝔹^256)~(y:𝔹^256)~(bx:𝔹^256)~(by:𝔹^256)~(mu:𝔹^256)'
        state, result = 'x,y,bx,by,mu', 'x~y~bx~by~mu'
        call = f'challenge_point_add_runtime[{P}][256]((x,y,bx,by,mu))'
        target = 'challenge_point_add_runtime'
    elif name == 'square':
        size = 512
        layout = '(x:𝔹^256)~(y:𝔹^256)'
        state, result = 'x,y', 'x~y'
        # A non-inlined entry keeps the probe boundary for the staged build.
        call = f'challenge_square_sub[{P}][256]((x,y))'
        target = 'challenge_square_sub'
    elif name == 'eq_flag':
        size = 513
        layout = '(v:𝔹^256)~(x:𝔹^256)~(z,)'
        state, result = 'v,x,z', 'v~x~(z,)'
        call = 'challenge_eq_flag[256]((v,x,z))'
        target = 'challenge_eq_flag'
    elif name == 'zero_flag':
        size = 257
        layout = '(x:𝔹^256)~(z,)'
        state, result = 'x,z', 'x~(z,)'
        call = 'challenge_zero_flag[256]((x,z))'
        target = 'challenge_zero_flag'
    elif name == 'tangent':
        size = 768
        layout = '(bx:𝔹^256)~(by:𝔹^256)~(mu:𝔹^256)'
        state, result = 'bx,by,mu', 'bx~by~mu'
        call = f'challenge_tangent[{P}][0][256](({state}))'
        target = 'challenge_tangent'
    elif name in ('field_add', 'field_sub', 'field_rsub'):
        size = 512
        layout = '(x:𝔹^256)~(y:𝔹^256)'
        state, result = 'x,y', 'x~y'
        target = 'challenge_'+name
        call = f'{target}[{P}][256]((x,y))'
    elif name in ('tangent_sub', 'tangent_add'):
        size = 513
        layout = '(c,)~(x:𝔹^256)~(y:𝔹^256)'
        state, result = 'c,x,y', '(c,)~x~y'
        target = 'challenge_'+name
        call = f'{target}[{P}][256]((c,x,y))'
    elif name in ('pp_map', 'binary_map'):
        size = 512
        layout = '(x:𝔹^256)~(y:𝔹^256)'
        state, result = 'x,y', 'x~y'
        if name == 'pp_map':
            call = f'pp_modular_map[{a}:!𝔹][{P}][256][pp_rounds[256]()]((x,y))'
            target = 'pp_modular_map'
        else:
            call = f'binary_modular_map[{a}:!𝔹][{P}][256]((x,y))'
            target = 'binary_modular_map'
    elif name in ('pp_step_narrow', 'pp_unstep_narrow', 'pp_step', 'pp_unstep'):
        size = 2*a+1
        layout = f'(u:𝔹^{a})~(v:𝔹^{a})~(s,)'
        state, result = 'u,v,s', 'u~v~(s,)'
        params = f'[{a}]'+(f'[{b}:!𝔹]' if name.startswith('pp_unstep') else '')
        call = f'{name}{params}(({state}))'
        target = name
    elif name in PP_LEAVES:
        two_signs = name in ('pp_end_div', 'pp_seed_mul')
        size = 514 if two_signs else 513
        prefix = '(s,t)' if two_signs else '(s,)'
        layout = prefix+'~(x:𝔹^256)~(y:𝔹^256)'
        state = 's,t,x,y' if two_signs else 's,x,y'
        result = prefix+'~x~y'
        call = f'{name}[4294968273][256](({state}))'
        target = name
    elif name == 'square_row':
        size = 768
        layout = '(y:𝔹^256)~(z:𝔹^512)'
        state, result = 'y,z', 'y~z'
        call = f'square_row[{b}:!𝔹][256,{a}]((y,z))'
        target = name
    elif name in ('double_modp', 'half_modp'):
        if a != 256:
            raise ValueError(f'Unexpected field width: {kernel}')
        size, layout, state, result = a, f'(x:𝔹^{a})', 'x', 'x'
        call = f'{name}[{P}][{a}](x)'
        target = name
    elif name in ('binary_gcd_step', 'binary_gcd_unstep', 'binary_payload_step'):
        width = 256 if name == 'binary_payload_step' else a
        size = 2*width+2
        layout = f'(u:𝔹^{width})~(v:𝔹^{width})~(s,o)'
        state, result = 'u,v,s,o', 'u~v~(s,o)'
        params = f'[{a}:!𝔹][{P}][256]' if name == 'binary_payload_step' else f'[{a}]'
        call = f'{name}{params}(({state}))'
        target = name
    elif name in ('modmult_addsub', 'undo_modmult_addsub'):
        w, n = a, b
        size = 2*(w+n)
        layout = f'(x:𝔹^{w})~(y:𝔹^{n})~(g:𝔹^{w})~(z:𝔹^{n})'
        state, result = 'x,y,g,z', 'x~y~g~z'
        pinv = pow(P, -1, 1 << w)
        call = f'{name}[{P},{pinv}][{n},{w}](({state}))'
        target = name
    else:
        raise ValueError(kernel)
    lhs = f'({state})' if ',' in state else state
    text = imports+f'''def main(){{
    q := 0:uint[{size}] as 𝔹^{size};
    for j in [0..{size}){{q[j] := H(q[j]);}}
    {layout} := q;
    {lhs} := {call};
    q := {result};
    return q;
}}
'''
    return size, target, text


# Kernels are the measurement-based arithmetic of the arithmetic/ modules.
KERNEL_IMPORTS = ''.join(f'import arithmetic.{m};\n' for m in (
    'CQ_adder', 'QQ_adder', 'QQ_mult', 'miscellaneous', 'ecc.mod_div', 'ecc.pingpong', 'ecc.kernels'))


def library(text, bare=False):
    return text


def boundary_names(kernel):
    if kernel.name == 'runtime':
        return RUNTIME_KERNELS
    if kernel.name == 'square':
        return {'square_row'}
    if kernel.name == 'tangent':
        return {'binary_modular_map'} | MULT_LEAVES
    if kernel.name == 'pp_map':
        return PP_LEAVES
    if kernel.name == 'binary_map':
        return BINARY_LEAVES | {'double_modp', 'half_modp'}
    return set()


def metadata(name):
    """Encode only the small specialization parameters needed by the linker."""
    integer, flag = None, None
    if name in ('pp_step_narrow', 'pp_step', 'binary_gcd_step', 'binary_gcd_unstep',
                'double_modp', 'half_modp', 'modmult_addsub', 'undo_modmult_addsub'):
        integer = '$0'
    elif name in ('pp_unstep_narrow', 'pp_unstep'):
        integer, flag = '$0', '$1'
    elif name == 'square_row':
        integer, flag = '$1', '$2'
    elif name == 'pp_modular_map':
        flag = '$3'
    elif name == 'binary_modular_map':
        flag = '$2'
    elif name == 'binary_payload_step':
        flag = '$1'
    lines = []
    if flag:
        lines += ['    $metaZero := literal[0]', '    $metaOne := literal[1]',
                  f'    $metaFlag := cond({flag}, $metaZero, $metaOne)']
    if integer and flag:
        lines += [f'    $metaEncoded := int_linear[1, 2, 1]({integer}, $metaFlag)']
    elif integer:
        lines += [f'    $metaEncoded := int_linear[1, 1]({integer})']
    elif flag:
        lines += ['    $metaEncoded := int_linear[1, 1]($metaFlag)']
    else:
        lines += ['    $metaEncoded := literal[1]']
    return lines+['    $metaReal := float_from_int($metaEncoded)',
                  '    $metaUnit := literal[float(884279719003555, -60)]',
                  '    $metaAngle := float_mul($metaReal, $metaUnit)',
                  '    mfree_call[qbuiltin.phase]($metaAngle)']


def stage_program(text, selected, target):
    headers = list(re.finditer(r'^def ([\w.]+)(?:\(([^\n]*)\))? <- (%\w+) \[([^\n]*)\]$', text, re.M))
    proxies, definitions = {}, []
    for match in headers:
        full, arguments, state, _ = match.groups()
        name = next((n for n in selected if re.search(r'\.'+n+r'\.\d+(?:\.\d+)*$', full)), None)
        if not name:
            continue
        args = arguments or ''
        if '%' in args:
            raise ValueError('A staged boundary cannot have borrowed quantum arguments')
        proxy = 'silq_function.stage.'+full
        definitions.append(f'def {proxy}($nctl, $reverse'+(', '+args if args else '')+
                           f') <- %controls, {state}\n'+'\n'.join(metadata(name))+
                           f'\n    return %controls, {state}\n')
        proxies[proxy.replace('.', '_')] = name
        text = re.sub(r'(?<![\w_])(?:call|mfree_call|qfree_call)\['+re.escape(full)+r'\]',
                      'circuit_call['+proxy+']', text)
    # An explicit identity boundary prevents preparation H gates from folding
    # through domain assertions in an isolated kernel probe.
    input_proxy = 'silq_function.stage_input'
    definitions.append(f'def {input_proxy}($nctl, $reverse) <- %controls, %state\n'+
                       '\n'.join(metadata('input'))+'\n    return %controls, %state\n')
    proxies[input_proxy.replace('.', '_')] = 'input'
    main_start = text.index('def silq_function.main')
    before, main = text[:main_start], text[main_start:]
    pattern = re.compile(r'^(    )(?P<left>[^\n]*?)(?P<op>call|mfree_call|qfree_call)'
                         r'\[(?P<fn>[^]]*\.'+re.escape(target)+r'(?:\.\d+)*)\]'
                         r'(?P<args>[^\n]*?) <- (?P<q>%\w+)(?P<tail>[^\n]*)$', re.M)
    match = pattern.search(main)
    if not match:
        raise ValueError(f'Cannot find probe call for {target}')
    line = match[0]
    changed = line[:line.rfind(' <- ')]+' <- %stageInput'+match['tail']
    main = main[:match.start()]+f'    %stageInput := circuit_call[{input_proxy}] <- {match["q"]}\n'+changed+main[match.end():]
    text = before+main
    # Preserve zero-valued array deallocations as explicit circuit boundaries.
    # Native QASM otherwise omits these source lifetime events, leaving the
    # exporter unable to release clean scratch whose symbolic proof was lost.
    for kind in ('zero', 'one'):
        proxy = 'silq_function.stage_'+kind
        definitions.append(f'def {proxy}($nctl, $reverse) <- %controls, %state\n'+
                           '\n'.join(metadata(kind))+'\n    return %controls, %state\n')
        proxies[proxy.replace('.', '_')] = kind
    zero_names, zero_bits, one_bits, sequence, rewritten = set(), set(), set(), 0, []
    for line in text.splitlines():
        if line.startswith('def '):
            zero_names = set()
            zero_bits, one_bits = set(), set()
        if literal := re.fullmatch(r'    (\$\w+) := literal\[0\]', line):
            zero_names.add(literal[1])
        if literal := re.fullmatch(r'    (\$\w+) := literal\[box\[builtin.bitvec\]\((false|true)\)\]', line):
            (one_bits if literal[2] == 'true' else zero_bits).add(literal[1])
        release = re.fullmatch(r'(?P<prefix>    (?:if\[[^]]+\] )?)'
            r'qfree_call_rev\[(?P<builtin>silq_builtin.alloc_uint|qbuiltin.alloc_bitvec)\]'
            r'\([^,]+, (?P<value>\$\w+)\) <- (?P<q>%\w+)'
            r'(?P<suffix> !garbage_in \d+)?', line)
        scalar_release = re.fullmatch(r'(?P<prefix>    (?:if\[[^]]+\] )?)'
            r'qfree_call_rev\[qbuiltin.alloc_(?P<literal>[01])\] <- (?P<q>%\w+)'
            r'(?P<suffix> !garbage_in \d+)?', line)
        array_release = release and (release['value'] in zero_names
            if release['builtin'] == 'silq_builtin.alloc_uint'
            else release['value'] in zero_bits | one_bits)
        if scalar_release or array_release:
            release = scalar_release or release
            variable = f'%stageZero{sequence}'
            sequence += 1
            kind = ('one' if (scalar_release and scalar_release['literal'] == '1')
                    or (not scalar_release and release['value'] in one_bits) else 'zero')
            proxy = 'silq_function.stage_'+kind
            rewritten.append(release['prefix']+variable+
                             f' := circuit_call[{proxy}] <- '+release['q'])
            suffix = release['suffix'] or ''
            line = line[:line.rfind(' <- ')]+' <- '+variable+suffix
        rewritten.append(line)
    return '\n'.join(rewritten)+'\n'+'\n'.join(definitions), proxies


def decode(name, value, inputs):
    if name in ('square', 'zero_flag', 'eq_flag'):
        return Kernel(name)
    if name in ('challenge_zero_flag', 'challenge_eq_flag'):
        return Kernel(name.removeprefix('challenge_'))
    if name == 'challenge_square_sub':
        return Kernel('square')
    if name in ('challenge_tangent_sub', 'challenge_tangent_add'):
        return Kernel(name.removeprefix('challenge_'))
    if name in ('challenge_field_add', 'challenge_field_sub', 'challenge_field_rsub'):
        return Kernel(name.removeprefix('challenge_'))
    if name == 'pp_modular_map':
        return Kernel('pp_map', value)
    if name == 'binary_modular_map':
        return Kernel('binary_map', value)
    if name in ('pp_unstep_narrow', 'pp_unstep'):
        return Kernel(name, value//2, value%2)
    if name == 'square_row':
        return Kernel(name, value//2, value%2)
    if name in ('modmult_addsub', 'undo_modmult_addsub'):
        return Kernel(name, value, inputs//2-value)
    return Kernel(name, value)


def parse_qasm(path, key, size, proxies):
    lines = iter(path.read_text().splitlines())
    raw, main = {}, []
    for line in lines:
        line = line.strip()
        if not line or line.startswith(('include ', 'OPENQASM ', '//')):
            continue
        match = re.fullmatch(r'(?:def|gate) (\w+)(?:\((.*)\)| (.*)) \{', line)
        if not match:
            main.append(line)
            continue
        name, p1, p2 = match.groups()
        args = (p1 if p1 is not None else p2).split(',')
        inputs = len(args) if args != [''] else 0
        body, depth = [], 1
        for child in lines:
            depth += child.count('{')-child.count('}')
            if depth == 0:
                break
            body.append(child.strip())
        raw[name] = (inputs, body)
    references, dependencies, helpers, input_names = {}, {}, {}, set()
    def native_body(lines):
        # Clean indexing lifetimes may lie between H and its measurement. Move
        # only disjoint clean-wire markers before H; the HMR stays atomic.
        clean = []
        for line in lines:
            call = re.fullmatch(r'(silq_function_\w+)\((.*)\);', line)
            if call and call[1] in references and references[call[1]] is None:
                continue
            clean.append(line)
        index = 0
        while index < len(clean):
            hadamard = re.fullmatch(r'h q(\d+);', clean[index])
            if hadamard:
                end = index+1
                while end < len(clean):
                    call = re.fullmatch(r'(silq_function_\w+)\((.*)\);', clean[end])
                    if (not call or references.get(call[1]) not in ('@zero', '@one')
                            or int(hadamard[1]) in backend.qids(call[2])):
                        break
                    end += 1
                if end > index+1:
                    clean[index:end] = clean[index+1:end]+[clean[index]]
                    index = end-1
            index += 1
        return backend.parse_body(clean)
    for name, (inputs, body) in raw.items():
        proxy = next((p for p in proxies if name.startswith(p+'_circuit_fwd0')
                      or (proxies[p] in ('zero', 'one') and
                          re.match(re.escape(p)+r'_circuit_(?:fwd|rev)\d+', name))), None)
        if proxy is not None:
            if len(body) != 1 or not (phase := re.fullmatch(r'gphase\(([^)]+)\);', body[0])):
                raise ValueError(f'Unexpected temporary boundary: {name}: {body[:3]}')
            encoded = float(phase[1])/UNIT
            if proxies[proxy] in ('zero', 'one'):
                encoded = abs(encoded)
            if abs(encoded-round(encoded)) > 1e-8:
                raise ValueError('Boundary metadata lost precision')
            kind = proxies[proxy]
            if kind == 'tangent_load':
                references[name] = '@tangent'
            elif kind == 'input':
                references[name] = None
                input_names.add(name)
            elif kind in ('zero', 'one'):
                controls = int(re.search(r'_circuit_(?:fwd|rev)(\d+)', name)[1])
                # A quantum-guarded assertion only proves zero in that branch.
                # It cannot justify an unconditional physical release.
                references[name] = None if controls else '@'+kind
            else:
                kernel = decode(kind, round(encoded)-1, inputs)
                references[name] = kernel.key
                dependencies[kernel.key] = (kernel, inputs)
        else:
            references[name] = key+'__'+name
            bits, instructions = native_body(body)
            helpers[references[name]] = Compiled(inputs, backend.Block(inputs, bits, instructions), {})
    width = next(int(m[1]) for line in main if (m := re.fullmatch(r'qubit\[(\d+)\] q;', line)))
    declarations = [line for line in main if line.startswith('bit ')]
    operations = [line for line in main if not line.startswith(('bit ', 'qubit['))]
    inputs, start = [], None
    for index, line in enumerate(operations):
        if match := re.fullmatch(r'h q\[(\d+)\];', line):
            inputs.append(int(match[1]))
            continue
        call = re.fullmatch(r'(silq_function_\w+)\((.*)\);', line)
        if call and call[1] in input_names:
            if backend.qids(call[2]) != tuple(range(size)):
                raise ValueError(f'{key}: probe input boundary changed')
            start = index+1
            break
        if (call and references.get(call[1]) == '@zero'
                and all(q not in inputs for q in backend.qids(call[2]))):
            # Indexed H preparation creates clean temporary bit-vector slots.
            # Their lifetime markers are part of probe preparation as well.
            continue
        raise ValueError(f'{key}: unexpected input preparation: {line}')
    if inputs != list(range(size)):
        raise ValueError(f'{key}: input preparation/layout changed: {inputs[:10]}')
    if start is None:
        raise ValueError(f'{key}: missing probe input boundary')
    body = declarations+operations[start:]
    body = [re.sub(r'q\[(\d+)\]', r'q\1', line) for line in body]
    bits, instructions = native_body(body)
    def rename(instructions):
        out = []
        for op in instructions:
            if op[0] == 'call':
                child = references[op[1]]
                if child == '@zero':
                    out.extend(('reset', q) for q in op[2])
                elif child == '@one':
                    for q in op[2]:
                        out.extend([('gate', 'x', (), (q,)), ('reset', q),
                                    ('gate', 'x', (), (q,))])
                elif child == '@tangent':
                    out.append(('tangent', op[2]))
                elif child is not None:
                    out.append(('call', child, op[2]))
            else:
                out.append(op)
        return out
    for helper in helpers.values():
        helper.block.body = rename(helper.block.body)
    # The probe returns exactly its input-sized state. All other global wires
    # are clean scratch on return, as required by the compiler's boundary ABI.
    body = rename(instructions)+[('reset', q) for q in range(size, width)]
    # Both exact field operations have the upstream map |x,y> -> |x,y +/- x>.
    # Their first register is unchanged, including when it is a classical offset.
    preserves = tuple(range(256)) if key in ('field_add_0_0', 'field_sub_0_0', 'field_rsub_0_0') else ()
    if key in ('tangent_sub_0_0', 'tangent_add_0_0'):preserves = tuple(range(257))
    if key == 'zero_flag_0_0':preserves = tuple(range(256))
    if key == 'eq_flag_0_0':preserves = tuple(range(512))
    if key == 'square_0_0':preserves = tuple(range(256, 512))
    root = Compiled(size, backend.Block(width, bits, body, preserves), dependencies)
    return root, helpers


TEMPLATE_KINDS = {'pp_step', 'pp_unstep', 'binary_gcd_step',
                  'binary_gcd_unstep', 'square_row'}


class ProbeParameter:
    """Classical Silq expression used by the existing probe generator."""
    def __init__(self, text): self.text = text
    def __str__(self): return self.text
    def __add__(self, other): return ProbeParameter(f'({self}+{other})')
    def __radd__(self, other): return ProbeParameter(f'({other}+{self})')
    def __mul__(self, other): return ProbeParameter(f'({self}*{other})')
    def __rmul__(self, other): return ProbeParameter(f'({other}*{self})')


def compile_frontend_template(name, work, hqir):
    """Compile a parameterized probe once; specialize its HQIR entry per width.

    Only the entry's two literal arguments change. Arithmetic definitions and
    all optimizer/export passes are still compiled from the current sources.
    No previously generated QASM is used.
    """
    assert name in TEMPLATE_KINDS
    folder = work/'frontend_templates'/name
    folder.mkdir(parents=True, exist_ok=True)
    _, _, text = probe(Kernel(name, ProbeParameter('a'), ProbeParameter('b')))
    text = text.replace('def main(){', 'def kernel_probe[a:!N,b:!B]() @noinline{')
    text += '\ndef main(){return kernel_probe[137,true]();}\n'
    source = folder/'probe.slq'
    source.write_text(text)
    dump = folder/'source.hqir'
    with dump.open('w') as out, (folder/'frontend.log').open('w') as err:
        subprocess.run([hqir, str(source), '-O3', '--dump'],
                       cwd=backend.ARITHMETIC_ROOT.parent, stdout=out, stderr=err, check=True)
    return dump.read_text()


def specialize_frontend(template, kernel):
    if kernel.name not in TEMPLATE_KINDS or kernel.b not in (0, 1):
        raise ValueError(f'Invalid parameterized probe: {kernel}')
    entry = re.search(r'^def silq_function.main\n(.*?)(?=^def |\Z)', template, re.M | re.S)
    if entry is None:
        raise ValueError('Missing parameterized probe entry')
    body = entry[1]
    values = re.findall(r'literal\[([^]]+)\]', body)
    if '137' not in values or set(values) - {'137', 'true'}:
        raise ValueError(f'Unexpected probe entry literals: {values}')
    body = re.sub(r'literal\[(137|true)\]',
                  lambda m: f'literal[{kernel.a if m[1] == "137" else str(bool(kernel.b)).lower()}]', body)
    return template[:entry.start(1)] + body + template[entry.end(1):]


def compile_one(kernel, work, hqir, template=None):
    folder = work/kernel.key
    folder.mkdir(parents=True, exist_ok=True)
    size, target, text = probe(kernel)
    source = folder/'probe.slq'
    source.write_text(text)
    dump = folder/'source.hqir'
    if template is None:
        with dump.open('w') as out, (folder/'frontend.log').open('w') as err:
            subprocess.run([hqir, str(source), '-O3', '--dump'],
                           cwd=backend.ARITHMETIC_ROOT.parent, stdout=out, stderr=err, check=True)
    else:
        dump.write_text(specialize_frontend(template, kernel))
        (folder/'frontend.log').write_text('Specialized the current parameterized frontend template.\n')
    text, lowered = dump.read_text(), {}
    staged, proxies = stage_program(text, {library(n, True) for n in boundary_names(kernel)}, target)
    proxies.update(lowered)
    program = folder/'staged.hqir'
    program.write_text(staged)
    qasm = folder/'circuit.qasm'
    # The call-only binary dispatcher makes the level-2 pass set oscillate;
    # its arithmetic leaf kernels below still compile at level 2.
    relax = '1' if kernel.name == 'binary_map' else '2'
    flags = ['--no-use-rccx']
    with qasm.open('w') as out, (folder/'compile.log').open('w') as err:
        subprocess.run([hqir, str(program), '-O0', '--flatten', '-R'+relax,
                        *flags, '--qasm'],
                       stdout=out, stderr=err, check=True)
    root, helpers = parse_qasm(qasm, kernel.key, size, proxies)
    return kernel, root, helpers


def progress(label, done, total, width=40):
    filled = width*done//max(total, 1)
    print(f'\r{label} [{"#"*filled}{"."*(width-filled)}] {done}/{total}',
          end='\n' if done == total else '', flush=True)


def link(compiled):
    complete, active = {}, set()
    def finish(key):
        if key in complete:
            return complete[key]
        if key in active:
            raise ValueError('Recursive circuit boundary')
        active.add(key)
        item = compiled[key]
        block = item.block
        child_extra = 0
        instructions = []
        for op in block.body:
            if op[0] == 'call':
                child = finish(op[1])
                inputs = compiled[op[1]].inputs
                if len(op[2]) != inputs:
                    raise ValueError(f'{key}: {op[1]} argument width mismatch')
                extra = child.width-inputs
                child_extra = max(child_extra, extra)
                op = ('call', op[1], op[2]+tuple(range(block.width, block.width+extra)))
            instructions.append(op)
        complete[key] = backend.Block(block.width+child_extra, block.bits, instructions,
                                      block.preserves)
        active.remove(key)
        return complete[key]
    for key in compiled:
        finish(key)
    return complete


def build(work, hqir, jobs):
    pending = {Kernel(ROOT_KERNEL), Kernel('tangent')}
    compiled, expected = {}, {}
    # Composite kernels discover the source-derived dependency graph. They run
    # sequentially to bound memory; independent small kernels compile in parallel.
    stages = 0
    while pending:
        composites = sorted((k for k in pending if k.name in COMPOSITE), key=lambda k:k.key)
        if not composites:
            break
        for kernel in composites:
            pending.remove(kernel)
            # The stage count grows as dependencies are discovered.
            remaining = sum(k.name in COMPOSITE for k in pending)+1
            progress('Compiling stages ', stages, stages+remaining)
            _, item, helpers = compile_one(kernel, work, hqir)
            compiled[kernel.key] = item
            compiled.update(helpers)
            for dep, inputs in item.dependencies.values():
                expected[dep.key] = inputs
                if dep.key not in compiled:
                    pending.add(dep)
            stages += 1
    progress('Compiling stages ', stages, stages)
    kinds = sorted({k.name for k in pending} & TEMPLATE_KINDS)
    with ThreadPoolExecutor(max_workers=min(jobs, len(kinds) or 1)) as pool:
        templates = dict(zip(kinds, pool.map(
            lambda name: compile_frontend_template(name, work, hqir), kinds)))
    with ThreadPoolExecutor(max_workers=jobs) as pool:
        futures = [pool.submit(compile_one, kernel, work, hqir, templates.get(kernel.name))
                   for kernel in sorted(pending, key=lambda k:k.key)]
        for done, future in enumerate(as_completed(futures), 1):
            progress('Compiling kernels', done, len(futures))
            kernel, item, helpers = future.result()
            if item.inputs != expected[kernel.key] or item.dependencies:
                raise ValueError(f'Atomic boundary mismatch: {kernel}')
            compiled[kernel.key] = item
            compiled.update(helpers)
    return link(compiled)


def export_source(work, hqir, jobs=4):
    """Compile every stage afresh and export the linked challenge circuit."""
    if jobs < 1:
        raise ValueError('Compilation jobs must be positive')
    work = Path(work).resolve()
    work.mkdir(parents=True, exist_ok=True)
    started = time.monotonic()
    blocks = build(work, hqir, jobs)
    root = Kernel(ROOT_KERNEL).key
    tangent = (blocks, Kernel('tangent').key)
    with (work/'ops.bin').open('w+b') as raw:
        raw.write(b'QECCOPSZ'+backend.struct.pack('<Q', 0))
        with zstd.ZstdFile(raw, 'w', level=3) as compressed:
            exporter = backend.Exporter(blocks, root, 256, compressed.write, tangent,
                                        classical_controls=True)
            exporter.run()
        raw.seek(8)
        raw.write(backend.struct.pack('<Q', exporter.count))
    print(f'Fresh source build: {exporter.count:,} operations, {exporter.peak} qubits; '
          f'{time.monotonic()-started:.1f}s', flush=True)
    (work/'provenance.json').write_text(json.dumps({
        'preexisting_qasm_read': False, 'compiler': hqir,
        'compiler_sha256': hashlib.sha256(Path(hqir).read_bytes()).hexdigest(),
        'builder_sources': {p.name: hashlib.sha256(p.read_bytes()).hexdigest()
                            for p in (Path(__file__), Path(backend.__file__))},
        'sources': {str(p.relative_to(backend.ARITHMETIC_ROOT)):
                    hashlib.sha256(p.read_bytes()).hexdigest()
                    for p in sorted(backend.ARITHMETIC_ROOT.rglob('*.slq'))
                    if '.challenge' not in p.parts},
        'qubits': exporter.peak, 'operations': exporter.count,
    }, indent=2)+'\n')
