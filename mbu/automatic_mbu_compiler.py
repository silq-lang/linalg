"""Standalone certified ``m_forget`` frontend; requires only Python 3.10+ stdlib."""

from dataclasses import dataclass
from functools import lru_cache
import re
import sys


class CompileError(Exception):
    pass


# ---------------------------------------------------------------------------
# Boolean expressions


class _Interned(type):
    @lru_cache(maxsize=None)
    def __call__(cls, *args):
        return super().__call__(*args)


@dataclass(frozen=True, slots=True, eq=False)
class Const(metaclass=_Interned):
    value: bool


@dataclass(frozen=True, slots=True, eq=False)
class Var(metaclass=_Interned):
    name: str


@dataclass(frozen=True, slots=True, eq=False)
class Op(metaclass=_Interned):
    kind: str
    args: tuple["Expr", ...]


Expr = Const | Var | Op

ZERO, ONE = Const(False), Const(True)


@lru_cache(maxsize=None)
def xor_parts(*values: Expr, parity: bool = False) -> tuple[bool, tuple[Expr, ...]]:
    terms: dict[Expr, None] = {}
    for value in values:
        if isinstance(value, Const):
            bit, nested = value.value, ()
        elif isinstance(value, Op) and value.kind in {"not", "xor"}:
            bit, nested = xor_parts(*value.args, parity=value.kind == "not")
        else:
            bit, nested = False, (value,)
        parity ^= bit
        for term in nested:
            if term in terms:
                del terms[term]
            else:
                terms[term] = None
    return parity, tuple(terms)


def xor(*values: Expr) -> Expr:
    parity, terms = xor_parts(*values)
    if not terms:
        return Const(parity)
    result = terms[0] if len(terms) == 1 else Op("xor", tuple(terms))
    return Op("not", (result,)) if parity else result


def negate(value: Expr) -> Expr:
    return xor(ONE, value)


def conjunction(*values: Expr) -> Expr:
    factors: list[Expr] = []
    for value in values:
        if value is ZERO:
            return ZERO
        nested = value.args if isinstance(value, Op) and value.kind == "and" else (value,)
        for factor in nested:
            if factor is not ONE and factor not in factors:
                factors.append(factor)
    if any(negate(factor) in factors for factor in factors):
        return ZERO
    # a(a XOR r) = a NOT r; this keeps reverse constraints small.
    for atom in tuple(factors):
        for factor in tuple(factors):
            parity, terms = xor_parts(factor)
            if factor is atom or atom not in terms:
                continue
            factors.remove(factor)
            replacement = xor(Const(not parity), *(term for term in terms if term is not atom))
            if replacement is ZERO:
                return ZERO
            if replacement is not ONE:
                factors.append(replacement)
            return conjunction(*factors)
    if not factors:
        return ONE
    return factors[0] if len(factors) == 1 else Op("and", tuple(factors))


@lru_cache(maxsize=None)
def variables(value: Expr) -> frozenset[str]:
    if isinstance(value, Const):
        return frozenset()
    if isinstance(value, Var):
        return frozenset((value.name,))
    return frozenset().union(*(variables(argument) for argument in value.args))


def substitute(value: Expr, environment: dict[str, Expr]) -> Expr:
    @lru_cache(maxsize=None)
    def visit(node: Expr) -> Expr:
        if isinstance(node, Const):
            return node
        if isinstance(node, Var):
            return environment.get(node.name, node)
        return {"not": negate, "xor": xor, "and": conjunction}[node.kind](
            *(visit(argument) for argument in node.args))
    return visit(value)


# The parser accepts the frontend's Silq subset and rejects unknown syntax.

_TOKEN = re.compile(
    r'\s+|//[^\r\n]*|/\*[\s\S]*?\*/|/\+|"(?:\\.|[^"\\])*"'
    r'|[0-9]+(?:\.[0-9]+)?(?:[eE][+-]?[0-9]+)?|[^\W\d]\w*'
    r'|:=|!=|&&|\|\||==|>=|<=|<<|>>|\.\.|->|=>|[^\s]', re.UNICODE)
_PRECEDENCE = {
    ":=": 20, "←": 20, "as": 30, "coerce": 30, "pun": 30, ":": 31,
    "||": 50, "∨": 50, "⊻": 55, "&&": 60, "∧": 60,
    "|": 70, "⊕": 80, "&": 90,
    "=": 100, "==": 100, "!=": 100, "≠": 100,
    "<": 100, ">": 100, "<=": 100, ">=": 100, "≤": 100, "≥": 100,
    "<<": 110, ">>": 110, "+": 120, "-": 120, "sub": 120, "~": 120,
    "*": 130, "·": 130, "/": 130, "%": 130, "div": 130, "×": 130, "^": 150,
}


def _tokens(source):
    """Tokenize without interpreting strings or any Silq comment syntax."""
    position = 0
    while position < len(source):
        match = _TOKEN.match(source, position)
        if match is None:
            raise CompileError("tokenizer could not advance")
        value, start, position = match.group(), match.start(), match.end()
        if value == "/+":
            depth = 1
            for boundary in re.finditer(r"/\+|\+/", source[position:]):
                depth += 1 if boundary.group() == "/+" else -1
                if not depth:
                    position += boundary.end()
                    break
            if depth:
                yield ("unterminated comment", start, len(source))
                return
        elif not value.isspace() and not value.startswith(("//", "/*")):
            yield value, start, position


def _has_marker(source):
    """Leave unrelated Silq text untouched, even outside the parsed subset."""
    if not isinstance(source, str):
        raise TypeError("source must be Silq text")
    tokens, depth = list(_tokens(source)), 0
    for index, (value, _, _) in enumerate(tokens):
        if not depth and value == "import" and [item[0] for item in tokens[index + 1:index + 3]] == [
                "automatic_mbu_compiler", ";"]:
            return True
        if value in {"(", "[", "{"}:
            depth += 1
        elif value in {")", "]", "}"}:
            depth -= 1
    return False


class _Parser:
    def __init__(self, source):
        self.source = source
        self.tokens = list(_tokens(source))
        self.tokens.append(("", len(source), len(source)))
        self.position = 0

    def peek(self):
        return self.tokens[self.position][0]

    def take(self, expected=None):
        token = self.tokens[self.position]
        if not token[0] or expected is not None and token[0] != expected:
            self.fail(f"expected {expected or 'an expression'!r}")
        self.position += 1
        return token

    def fail(self, message):
        line = self.source.count("\n", 0, self.tokens[self.position][1]) + 1
        raise CompileError(f"line {line}: {message}; found {self.peek()!r}")

    def node(self, kind, start, children=(), **fields):
        return dict(kind=kind, start=start, end=self.tokens[self.position - 1][2],
                    line=self.source.count("\n", 0, start) + 1,
                    children=list(children), **fields)

    def identifier(self):
        value, start, _ = self.take()
        if not value.isidentifier():
            self.fail("expected an identifier")
        return self.node("identifier", start, name=value)

    def sequence(self, closing):
        start = self.tokens[self.position - 1][1]
        values, comma = [], False
        while self.peek() != closing:
            values.append(self.expression())
            if self.peek() != ",":
                break
            self.take(",")
            comma = True
        self.take(closing)
        if len(values) == 1 and not comma:
            return dict(values[0], start=start, end=self.tokens[self.position - 1][2])
        return self.node("ast.expression.TupleExp", start, values)

    def expression(self, minimum=0, statement=False):
        value, start, _ = self.take()
        if value == "(":
            left = self.sequence(")")
        elif value in {"!", "¬", "+", "-", "~"}:
            left = self.node("unary", start, [self.expression(140)],
                             operator="¬" if value == "!" else value)
        elif value == "[":
            lower = self.expression()
            self.take("..")
            upper = self.expression()
            if self.peek() not in {")", "]"}:
                self.fail("expected a range endpoint")
            self.take()
            left = self.node("range", start, [lower, upper])
        elif value in {"true", "false"} or value[0].isdigit():
            left = self.node("literal", start, token="0",
                             value={"true": "1", "false": "0"}.get(value, value))
        elif value.startswith('"'):
            left = self.node("literal", start, token="string", value=value)
        elif value.isidentifier():
            left = self.node("identifier", start, name=value)
        else:
            self.fail("unsupported expression")
        compared = False
        while True:
            operator = self.peek()
            if operator in {"(", "["} and 160 > minimum:
                self.take()
                argument = self.sequence(")" if operator == "(" else "]")
                left = (self.node("call", start, [left, argument], square=False, classical=False)
                        if operator == "(" else
                        self.node("ast.expression.IndexExp", start, [left, argument]))
                continue
            precedence = 20 if operator == "=" and statement else _PRECEDENCE.get(operator, -1)
            if precedence <= minimum:
                return left
            if precedence == 100:
                if compared:
                    self.fail("parenthesize chained comparisons")
                compared = True
            self.take()
            if operator == "=" and statement:
                operator = "←"
            right = self.expression(precedence - (operator in {":=", "←", ":", "^"}))
            if operator in {":", "as", "coerce", "pun"}:
                left = self.node("typed", start, [left, right],
                                 annotation={":": "annotation", "as": "conversion"}.get(operator, operator))
            else:
                left = self.node("binary", start, [left, right], operator=operator)

    def block(self):
        _, start, _ = self.take("{")
        children = []
        while self.peek() != "}":
            children.append(self.statement())
        self.take("}")
        return self.node("ast.expression.CompoundExp", start, children)

    def function(self, name=None, start=None):
        if name is None:
            _, start, _ = self.take("def")
            name = self.identifier()["name"]
        opening, param_start, _ = self.take()
        if opening not in {"(", "["}:
            self.fail("expected function parameters")
        square, parameters = opening == "[", []
        closing = "]" if square else ")"
        while self.peek() != closing:
            begin = self.tokens[self.position][1]
            const = square
            if self.peek() == "const":
                self.take()
                const = True
            parameter = self.identifier()["name"]
            self.take(":")
            dtype = self.expression(30)
            parameters.append(self.node("parameter", begin, const=const, name=parameter, dtype=dtype))
            if self.peek() != ",":
                break
            self.take(",")
        self.take(closing)
        annotation, infer = "qfree", True
        if self.peek() in {"qfree", "mfree", "lifted", "wild"}:
            annotation, infer = self.take()[0], False
        returns = None
        if self.peek() == ":":
            self.take()
            returns = self.expression(30)
        if self.peek() in {"(", "["}:
            nested = self.function("", self.tokens[self.position][1])
            lam = self.node("lambda", nested["start"], function=nested)
            returned = self.node("ast.expression.ReturnExp", nested["start"], [lam])
            body = self.node("ast.expression.CompoundExp", nested["start"], [returned])
        elif self.peek() == ";":
            body = None
            infer = False
        else:
            body = self.block()
        return self.node("function", start if start is not None else param_start,
                         name=name, square=square, parameters=parameters, body=body,
                         annotation=annotation, inferAnnotation=infer, returns=returns)

    def statement(self):
        start = self.tokens[self.position][1]
        word = self.peek()
        compound = word in {"def", "if", "for", "while", "{"}
        if word == "def":
            result = self.function()
        elif word == "{":
            result = self.block()
        elif word == "if":
            self.take()
            condition, then, otherwise = self.expression(), self.block(), None
            if self.peek() == "else":
                self.take()
                otherwise = self.statement() if self.peek() == "if" else self.block()
            result = self.node("if", start, [condition, then, otherwise])
        elif word in {"for", "while"}:
            self.take()
            condition = self.expression()
            if word == "for":
                self.take("in")
                condition = self.node("binary", condition["start"],
                                      [condition, self.expression()], operator="←")
            result = self.node("ast.expression.ForExp" if word == "for" else "while",
                               start, [condition, self.block()])
        elif word == "import":
            self.take()
            path = [self.identifier()]
            while self.peek() == ".":
                self.take()
                path.append(self.identifier())
            imported = path[0] if len(path) == 1 else self.node("qualified", path[0]["start"], path)
            result = self.node("import", start, [imported])
        elif word == "return":
            self.take()
            result = self.node("ast.expression.ReturnExp", start, [self.expression()])
        else:
            result = self.expression(statement=True)
        if self.peek() == ";":
            self.take()
        elif not compound and self.peek() != "}":
            self.fail("expected ';'")
        result["statementEnd"] = self.tokens[self.position - 1][2]
        return result


@lru_cache(maxsize=8)
def _syntax(source: str) -> list[dict]:
    """Parse the supported Silq subset with character source offsets."""
    if not isinstance(source, str):
        raise TypeError("source must be Silq text")
    parser = _Parser(source)
    result = []
    while parser.peek():
        result.append(parser.statement())
    return result


def _walk(value):
    if isinstance(value, dict):
        yield value
        for child in value.values():
            yield from _walk(child)
    elif isinstance(value, list):
        for child in value:
            yield from _walk(child)


def _ids(node) -> set[str]:
    return {item["name"] for item in _walk(node) if item.get("kind") == "identifier"}


def _name(node) -> str:
    if node and node["kind"] == "identifier":
        return node["name"]
    raise CompileError("expected a simple wire or function name")


def _items(node) -> list[dict]:
    return node["children"] if node["kind"] == "ast.expression.TupleExp" else [node]


def _names(node) -> tuple[str, ...]:
    names = tuple(map(_name, _items(node)))
    if len(names) != len(set(names)):
        raise CompileError("duplicate tuple binding")
    return names


def _assignment(node):
    if node.get("operator") != ":=":
        raise CompileError("expected an assignment")
    return node["children"]


def _call(node):
    if node["kind"] != "call" or node["square"] or node["classical"]:
        raise CompileError("expected a direct function call")
    callee, argument = node["children"]
    generics = []
    while callee["kind"] == "ast.expression.IndexExp":
        callee, parameters = callee["children"]
        generics += _items(parameters)
    return _name(callee), _items(argument), generics


def _definition(tree, name):
    matches = [node for node in tree if node["kind"] == "function" and node["name"] == name]
    if len(matches) != 1:
        raise CompileError(f"expected one local definition of {name!r}")
    return matches[0]


def _runtime(function):
    parameters = []
    while True:
        parameters += function["parameters"]
        if not function["square"]:
            return function, parameters
        body = function["body"]
        if not body or len(body["children"]) != 1:
            raise CompileError("unsupported generic function body")
        returned = body["children"][0]
        if returned["kind"] != "ast.expression.ReturnExp" or returned["children"][0]["kind"] != "lambda":
            raise CompileError("unsupported generic function body")
        function = returned["children"][0]["function"]


def _boolean(node) -> Expr:
    match node:
        case {"kind": "literal", "token": "0", "value": value} if value in {"0", "1"}:
            return Const(value == "1")
        case {"kind": "identifier", "name": name}:
            return Var(name)
        case {"kind": "unary", "operator": "¬", "children": [argument]}:
            return negate(_boolean(argument))
        case {"kind": "binary", "operator": operator, "children": [left, right]} if operator in {"!=", "≠", "⊕", "&&"}:
            return (conjunction if operator == "&&" else xor)(_boolean(left), _boolean(right))
    raise CompileError("unsupported Boolean expression")


# ---------------------------------------------------------------------------
# Restricted qfree producer and forgetability certificate


Gate = tuple[str, Expr]


@dataclass(frozen=True, slots=True)
class Producer:
    name: str
    input_wires: tuple[str, ...]
    garbage_wires: tuple[str, ...]
    output_wires: tuple[str, ...]
    output_garbage: tuple[str, ...]
    gates: tuple[Gate, ...]


BUILTINS = frozenset({"X", "CNOT", "H", "Z", "measure", "phase", "vector", "reverse"})


def _width(node) -> int:
    match node:
        case {"operator": "^", "children": [{"kind": "identifier", "name": "𝔹"},
                                            {"kind": "literal", "token": "0", "value": width}]} if width.isdecimal():
            return int(width)
    raise CompileError("producer registers must have fixed Boolean widths")


def _zero(node) -> bool:
    match node:
        case {"kind": "typed", "annotation": "annotation",
              "children": [{"kind": "literal", "value": "0"},
                           {"kind": "identifier", "name": "𝔹"}]}:
            return True
    return False


def _gate(node) -> Gate:
    lhs, rhs = _assignment(node)
    target = _name(lhs)
    name, args, generic = _call(rhs)
    if generic or name not in {"X", "CNOT"} or len(args) != (1 if name == "X" else 2):
        raise CompileError("expected an in-place X or CNOT")
    if _name(args[-1]) != target:
        raise CompileError("gate must update its target in place")
    return target, ONE if name == "X" else _boolean(args[0])


def _producer(tree, wanted: str) -> Producer:
    if _bindings(tree) & BUILTINS:
        raise CompileError("source shadows a Silq primitive")
    function = _definition(tree, wanted)
    params, returns, body = function["parameters"], function["returns"], function["body"]
    if (function["square"] or function["inferAnnotation"] or function["annotation"] != "qfree"
            or len(params) != 1 or params[0]["const"] or not body
            or not returns or returns.get("operator") != "×"):
        raise CompileError("expected a fixed-width qfree producer")
    n = _width(params[0]["dtype"])
    out_n, m = map(_width, returns["children"])
    if n != out_n or not m:
        raise CompileError("producer must preserve input width and return nonempty garbage")
    statements = body["children"]
    if not statements or statements[-1]["kind"] != "ast.expression.ReturnExp":
        raise CompileError("producer must end with its retained/garbage tuple")
    output = _items(statements[-1]["children"][0])
    if len(output) != 2 or any(item["kind"] != "ast.expression.TupleExp" for item in output):
        raise CompileError("expected retained and garbage tuples")
    outputs, garbage = map(_names, output)
    inputs, zeros, gates = None, [], []
    for statement in statements[:-1]:
        if statement["kind"] == "if":
            condition, then, otherwise = statement["children"]
            if otherwise or len(then["children"]) != 1:
                raise CompileError("if body must contain one in-place X")
            target, unconditional = _gate(then["children"][0])
            if unconditional is not ONE:
                raise CompileError("if body must contain one in-place X")
            gates.append((target, _boolean(condition)))
            continue
        lhs, rhs = _assignment(statement)
        if rhs.get("name") == params[0]["name"]:
            if inputs is not None or gates or lhs["kind"] != "ast.expression.TupleExp":
                raise CompileError("input must be unpacked once before gates")
            inputs = _names(lhs)
            continue
        allocation = None
        if _zero(rhs):
            allocation = (_name(lhs),)
        elif rhs["kind"] == "call" and rhs["children"][0].get("name") == "vector":
            name, args, generic = _call(rhs)
            if (generic or len(args) != 2 or args[0].get("kind") != "literal"
                    or not args[0].get("value", "").isdecimal() or not _zero(args[1])):
                raise CompileError("garbage must be a fixed-size zero vector")
            allocation = _names(lhs)
            if len(allocation) != int(args[0]["value"]):
                raise CompileError("garbage allocation width mismatch")
        if allocation is not None:
            if gates:
                raise CompileError("garbage must be allocated before gates")
            zeros.extend(allocation)
        else:
            gates.append(_gate(statement))
    if inputs is None or tuple(map(len, (inputs, outputs, zeros, garbage))) != (n, n, m, m):
        raise CompileError("producer widths do not match its signature")
    wires = set((*inputs, *zeros))
    if len(wires) != n + m or wires != set((*outputs, *garbage)) or wires & BUILTINS:
        raise CompileError("all distinct wires must be returned once without shadowing primitives")
    for target, control in gates:
        controls = variables(control)
        if target in controls or (controls | {target}) - wires:
            raise CompileError(f"invalid controlled update of {target!r}")
    return Producer(wanted, inputs, tuple(zeros), outputs, garbage, tuple(gates))


def solve(producer: Producer) -> tuple[tuple[str, Expr], ...]:
    environment = {wire: Var(wire) for wire in (*producer.output_wires, *producer.output_garbage)}
    for target, control in reversed(producer.gates):
        environment[target] = xor(environment[target], substitute(control, environment))
    equations = [environment[wire] for wire in producer.garbage_wires]
    pending = list(producer.output_garbage)
    all_garbage, solved, result = set(pending), set(), []
    while pending:
        choice = next(((i, name, rhs) for name in pending for i, equation in enumerate(equations)
                       if (rhs := _isolate(equation, name)) is not None
                       and variables(rhs) & all_garbage <= solved), None)
        if choice is None:
            tail = _affine(equations, pending)
            if tail is None:
                raise CompileError("garbage reconstruction is nonlinear/cyclic; no certificate found")
            result.extend(tail)
            break
        index, name, rhs = choice
        equations.pop(index)
        pending.remove(name)
        solved.add(name)
        result.append((name, rhs))
    allowed, targets = set(producer.output_wires), set()
    for target, rhs in result:
        if target in targets or variables(rhs) - allowed:
            raise CompileError("invalid garbage reconstruction order")
        targets.add(target)
        allowed.add(target)
    if targets != set(producer.output_garbage):
        raise CompileError("incomplete garbage reconstruction")
    return tuple(result)


def _isolate(equation: Expr, unknown: str) -> Expr | None:
    parity, terms = xor_parts(equation)
    node = Var(unknown)
    if terms.count(node) != 1:
        return None
    rest = tuple(term for term in terms if term is not node)
    return None if any(unknown in variables(term) for term in rest) else xor(Const(parity), *rest)


def _affine(equations: list[Expr], unknowns: list[str]) -> tuple[tuple[str, Expr], ...] | None:
    unknown_set = set(unknowns)
    rows: list[tuple[set[str], Expr]] = []
    for equation in equations:
        parity, terms = xor_parts(equation)
        coefficients: set[str] = set()
        rhs: list[Expr] = [Const(parity)]
        for term in terms:
            if isinstance(term, Var) and term.name in unknown_set:
                coefficients.symmetric_difference_update((term.name,))
            elif variables(term) & unknown_set:
                return None
            else:
                rhs.append(term)
        rows.append((coefficients, xor(*rhs)))
    for column, unknown in enumerate(unknowns):
        pivot = next((row for row in range(column, len(rows)) if unknown in rows[row][0]), None)
        if pivot is None:
            return None
        rows[column], rows[pivot] = rows[pivot], rows[column]
        for row in range(len(rows)):
            if row != column and unknown in rows[row][0]:
                rows[row][0].symmetric_difference_update(rows[column][0])
                rows[row] = (rows[row][0], xor(rows[row][1], rows[column][1]))
    if any(rows[index][0] != {name} for index, name in enumerate(unknowns)):
        return None
    return tuple((name, rows[index][1]) for index, name in enumerate(unknowns))


# ---------------------------------------------------------------------------
# ANF diagonal synthesis


def _anf(value: Expr, limit: int) -> frozenset[frozenset[str]]:
    def toggle(output: set[frozenset[str]], term: frozenset[str]) -> None:
        output.remove(term) if term in output else output.add(term)
        if len(output) > limit:
            raise CompileError("phase ANF exceeds its term budget")

    @lru_cache(maxsize=None)
    def visit(expression: Expr) -> frozenset[frozenset[str]]:
        if isinstance(expression, Const):
            return frozenset((frozenset(),)) if expression.value else frozenset()
        if isinstance(expression, Var):
            return frozenset((frozenset((expression.name,)),))
        if expression.kind in {"not", "xor"}:
            terms: set[frozenset[str]] = {frozenset()} if expression.kind == "not" else set()
            for argument in expression.args:
                for term in visit(argument):
                    toggle(terms, term)
            return frozenset(terms)
        else:
            terms = {frozenset()}
            for argument in expression.args:
                product: set[frozenset[str]] = set()
                for left in terms:
                    for right in visit(argument):
                        toggle(product, left | right)
                terms = product
            return frozenset(terms)

    return visit(value)


def _tuple(names: tuple[str, ...]) -> str:
    return f"({','.join(names)}{',' if len(names) == 1 else ''})"


def generate_code(producer: Producer, solution: tuple[tuple[str, Expr], ...],
                  term_limit: int) -> str:
    helper = f"m_forget_{producer.name}"
    reserved = {producer.name, helper, *producer.output_wires, *producer.output_garbage}
    counters: dict[str, int] = {}
    lines: list[str] = []

    def fresh(base: str) -> str:
        while True:
            index = counters.get(base, 0)
            counters[base] = index + 1
            name = base if not index else f"{base}_{index}"
            if name not in reserved:
                reserved.add(name)
                return name

    def add(text: str, indent: int = 1) -> None:
        lines.append("    " * indent + text)

    def measure(target: str, indent: int) -> str:
        outcome = fresh("_mf_s")
        add(f"{target} := H({target});", indent)
        add(f"{outcome} := measure({target}) as !𝔹;", indent)
        return outcome

    def monomial(term: tuple[str, ...], indent: int) -> None:
        if not term:
            add("phase(π);", indent)
        elif len(term) == 1:
            add(f"{term[0]} := Z({term[0]});", indent)
        elif len(term) == 2:
            add(f"if {term[0]}{{{term[1]} := Z({term[1]});}}", indent)
        else:
            chain, left = [], term[0]
            for right in term[1:-1]:
                target = fresh("_mf_and")
                add(f"{target} := 0:𝔹;", indent)
                add(f"if {left} && {right}{{{target} := X({target});}}", indent)
                chain.append((target, left, right))
                left = target
            add(f"if {left}{{{term[-1]} := Z({term[-1]});}}", indent)
            for target, left, right in reversed(chain):
                outcome = measure(target, indent)
                add(f"if {outcome}{{", indent)
                monomial((left, right), indent + 1)
                add("}", indent)

    retained, garbage = fresh("retained"), fresh("garbage")
    out, trash = _tuple(producer.output_wires), _tuple(producer.output_garbage)
    live_type = f"𝔹^{len(producer.output_wires)}"
    trash_type = f"𝔹^{len(producer.output_garbage)}"
    lines.extend([f"    {out} := {retained};", f"    {trash} := {garbage};"])
    for target, rhs in reversed(solution):
        outcome = measure(target, 1)
        terms = sorted((tuple(sorted(term)) for term in _anf(rhs, term_limit)),
                       key=lambda term: (len(term), term))
        if terms:
            add(f"if {outcome}{{")
            for term in terms:
                monomial(term, 2)
            add("}")
    add(f"return {out};")

    parameters = f"{retained}:{live_type},{garbage}:{trash_type}"
    return "\n".join([f"def {helper}({parameters}):{live_type}{{", *lines, "}"])


@dataclass(frozen=True, slots=True)
class Compilation:
    producer: Producer
    solution: tuple[tuple[str, Expr], ...]
    generated: str
    source: str

    @property
    def silq(self) -> str:
        return _lower(self.source, _syntax(self.source), {self.producer.name: self})


def compile_source(source: str, function_name: str, *, term_limit: int = 4096) -> Compilation:
    if type(term_limit) is not int or not 1 <= term_limit <= 4096:
        raise CompileError("invalid synthesis budget")
    tree = _syntax(source)
    definitions = {node["name"] for node in tree if node["kind"] == "function"}
    if "m_forget" in definitions:
        raise CompileError("m_forget is reserved for the compiler intrinsic")
    helper = f"m_forget_{function_name}"
    if helper in definitions:
        raise CompileError(f"generated helper {helper!r} already exists; compile original source")
    producer = _producer(tree, function_name)
    solution = solve(producer)
    return Compilation(producer, solution, generate_code(producer, solution, term_limit), source)


def m_forget(source: str, function_name: str = "compute_example", **options) -> Compilation:
    result = compile_source(source, function_name, **options)
    _call_sites(_syntax(source))
    return result


# ---------------------------------------------------------------------------
# Safe one-file frontend


def _markers(tree):
    return [node for node in tree if node["kind"] == "import" and len(node["children"]) == 1
            and node["children"][0].get("name") == "automatic_mbu_compiler"]


def _bindings(nodes) -> set[str]:
    names = set()
    for node in _walk(nodes):
        if node.get("operator") in {":=", "←"}:
            names.update(_ids(node["children"][0]))
        if node["kind"] == "function":
            names.add(node["name"])
    return names


def _preserving_calls(tree, statements, protected) -> tuple[str, ...]:
    callees = []
    for statement in statements:
        lhs, rhs = _assignment(statement)
        outputs = _names(lhs)
        name, args, generics = _call(rhs)
        function, _ = _runtime(_definition(tree, name))
        contracts = function["parameters"]
        if len(args) != len(contracts) or _ids(generics) & protected:
            raise CompileError("intervening call signature or generic arguments are unsupported")
        if set(outputs) & protected:
            raise CompileError("intervening call overwrites a certified binding")
        for argument, parameter in zip(args, contracts):
            view = argument
            if view["kind"] == "ast.expression.IndexExp":
                view, index = view["children"]
                if index["kind"] not in {"identifier", "literal"}:
                    raise CompileError("intervening arguments must be variables or array elements")
            base = _name(view)
            mentions = _ids(argument) & protected
            if mentions and (mentions != {base} or not parameter["const"]):
                raise CompileError("certified registers require const parameters")
        callees.append(name)
    return tuple(callees)


def _call_sites(tree, source_name="") -> tuple[dict[int, tuple[int, str]], list[str]]:
    requests = {node["start"] for node in _walk(tree)
                if node["kind"] == "identifier" and node["name"] == "m_forget"}
    replacements, matched, producers = {}, set(), []
    for outer in tree:
        if outer["kind"] != "function" or not requests.intersection(
                node["start"] for node in _walk(outer) if node.get("kind") == "identifier"):
            continue
        function, parameters = _runtime(outer)
        body = function["body"]["children"] if function["body"] else []
        for index, statement in enumerate(body):
            if statement["kind"] != "call" or statement["children"][0].get("name") != "m_forget":
                continue
            try:
                _, args, generics = _call(statement)
                if len(args) != 1 or generics:
                    raise CompileError("m_forget expects one garbage register")
                garbage = _name(args[0])
                if not function["inferAnnotation"] and function["annotation"] in {"qfree", "mfree"}:
                    raise CompileError("m_forget requires a measurement-capable function")
                pair = None
                for previous in range(index - 1, -1, -1):
                    candidate = body[previous]
                    if candidate.get("operator") != ":=":
                        continue
                    lhs, rhs = candidate["children"]
                    if lhs["kind"] != "ast.expression.TupleExp" or len(lhs["children"]) != 2:
                        continue
                    if lhs["children"][1].get("name") != garbage:
                        continue
                    retained, _ = _names(lhs)
                    name, arguments, generic = _call(rhs)
                    if len(arguments) != 1 or generic:
                        raise CompileError("expected a fixed-width producer call")
                    _name(arguments[0])
                    _definition(tree, name)
                    pair = previous, retained, name
                    break
                if pair is None:
                    raise CompileError("m_forget is not paired with a local producer call")
                previous, retained, name = pair
                helper = f"m_forget_{name}"
                intervening = body[previous + 1:index]
                callees = _preserving_calls(tree, intervening, {retained, garbage})
                reserved = {name, helper, "m_forget", *callees}
                if (reserved & {retained, garbage}
                        or reserved & {parameter["name"] for parameter in parameters}
                        or reserved & _bindings(body[:previous])
                        or reserved & _bindings(intervening)):
                    raise CompileError("binding shadows a certified function")
                replacements[statement["start"]] = (statement["end"], f"{retained} := {helper}({retained},{garbage})")
                matched.add(statement["children"][0]["start"])
                if name not in producers:
                    producers.append(name)
            except CompileError as error:
                raise CompileError(f"{source_name}:{statement['line']}: {error}") from error
    if matched != requests:
        raise CompileError("m_forget must be a supported call at function top level")
    return replacements, producers


def _replace(source: str, replacements: dict[int, tuple[int, str]]) -> str:
    data = source
    for start, (stop, replacement) in sorted(replacements.items(), reverse=True):
        newlines = "".join(char for char in data[start:stop] if char in "\r\n")
        data = data[:start] + replacement + newlines + data[stop:]
    return data


def _lower(source: str, tree, compilations: dict[str, Compilation] | None = None, *,
           source_name: str = "<memory>", term_limit: int = 4096
           ) -> str:
    replacements, producers = _call_sites(tree, source_name)
    compilations = dict(compilations or {})
    for producer in producers:
        if producer not in compilations:
            compilations[producer] = compile_source(source, producer, term_limit=term_limit)
    replacements.update({node["start"]: (node["statementEnd"], "") for node in _markers(tree)})
    lowered = _replace(source, replacements).rstrip() + "\n"
    lowered += "\n".join(compilation.generated + "\n" for compilation in compilations.values())
    return lowered


def preprocess_source(source: str, *, source_name: str = "<memory>", term_limit: int = 4096) -> str:
    if not _has_marker(source):
        return source
    tree = _syntax(source)
    return (_lower(source, tree, source_name=source_name, term_limit=term_limit)
            if _markers(tree) else source)


def main() -> int:
    if len(sys.argv) not in {2, 3} or sys.argv[1] != "--preprocess-stdin":
        print("usage: automatic_mbu_compiler.py --preprocess-stdin [source]", file=sys.stderr)
        return 2
    name = sys.argv[2] if len(sys.argv) == 3 else "<stdin>"
    try:
        sys.stdout.write(preprocess_source(sys.stdin.read(), source_name=name))
        return 0
    except (CompileError, OSError) as error:
        print(f"{name}: error: {error}", file=sys.stderr)
        return 1


if __name__ == "__main__":
    raise SystemExit(main())
