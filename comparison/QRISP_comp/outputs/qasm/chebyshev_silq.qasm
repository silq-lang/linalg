include "stdgates.inc";
qubit[9] q;

ry(0.4487989505128276) q[0]; // inplace_rot
ry(0.3490658503988659) q[1]; // inplace_rot
ry(1.3694384060045657) q[2]; // inplace_rot
x q[2]; // want_negated=True
ctrl(1) @ ry(1.9106332362490186) q[2], q[3]; // inplace_rot
x q[3]; // want_negated=True
cp(0.0) q[2], q[3];
x q[3]; // want_negated=False
cp(0.0) q[3], q[2];
x q[2]; // want_negated=False
ctrl(1) @ ry(0.0) q[2], q[3]; // inplace_rot
x q[3]; // want_negated=True
cp(0.0) q[2], q[3];
x q[3]; // want_negated=False
cp(0.0) q[2], q[3];
// BEGIN lifted_x
s q[4];
h q[4];
cx q[3], q[4];
x q[4];
t q[4];
cx q[2], q[4];
x q[4];
inv @ t q[4];
cx q[3], q[4];
x q[4];
t q[4];
cx q[2], q[4];
x q[4];
inv @ t q[4];
h q[4];
sdg q[4];
// END lifted_x
cp(3.141592653589793) q[0], q[4];
cp(3.141592653589793) q[1], q[4];
// BEGIN unlifted_x
s q[4];
h q[4];
t q[4];
cx q[2], q[4];
x q[4];
inv @ t q[4];
cx q[3], q[4];
x q[4];
t q[4];
cx q[2], q[4];
x q[4];
inv @ t q[4];
cx q[3], q[4];
x q[4];
h q[4];
sdg q[4];
// END unlifted_x
// BEGIN lifted_x
h q[4];
t q[4];
cx q[2], q[4];
x q[4];
inv @ t q[4];
cx q[3], q[4];
t q[4];
cx q[2], q[4];
x q[4];
inv @ t q[4];
h q[4];
// END lifted_x
cx q[4], q[0]; // inplace_x
// BEGIN unlifted_x
h q[4];
t q[4];
cx q[2], q[4];
x q[4];
inv @ t q[4];
cx q[3], q[4];
t q[4];
cx q[2], q[4];
x q[4];
inv @ t q[4];
h q[4];
// END unlifted_x
// BEGIN dup
s q[4];
h q[4];
cx q[3], q[4];
x q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
cx q[3], q[4];
x q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
h q[4];
sdg q[4];
// END dup
cx q[4], q[1]; // inplace_x
// BEGIN undup
s q[4];
h q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
cx q[3], q[4];
x q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
cx q[3], q[4];
x q[4];
h q[4];
sdg q[4];
// END undup
// BEGIN lifted_x
s q[4];
h q[4];
cx q[3], q[4];
x q[4];
t q[4];
cx q[2], q[4];
x q[4];
inv @ t q[4];
cx q[3], q[4];
x q[4];
t q[4];
cx q[2], q[4];
x q[4];
inv @ t q[4];
h q[4];
sdg q[4];
// END lifted_x
p(3.141592653589793) q[4];
// BEGIN unlifted_x
s q[4];
h q[4];
t q[4];
cx q[2], q[4];
x q[4];
inv @ t q[4];
cx q[3], q[4];
x q[4];
t q[4];
cx q[2], q[4];
x q[4];
inv @ t q[4];
cx q[3], q[4];
x q[4];
h q[4];
sdg q[4];
// END unlifted_x
// BEGIN lifted_x
h q[4];
t q[4];
cx q[2], q[4];
x q[4];
inv @ t q[4];
cx q[3], q[4];
t q[4];
cx q[2], q[4];
x q[4];
inv @ t q[4];
h q[4];
// END lifted_x
p(0.0) q[4];
// BEGIN unlifted_x
h q[4];
t q[4];
cx q[2], q[4];
x q[4];
inv @ t q[4];
cx q[3], q[4];
t q[4];
cx q[2], q[4];
x q[4];
inv @ t q[4];
h q[4];
// END unlifted_x
// BEGIN dup
s q[4];
h q[4];
cx q[3], q[4];
x q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
cx q[3], q[4];
x q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
h q[4];
sdg q[4];
// END dup
p(0.0) q[4];
// BEGIN undup
s q[4];
h q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
cx q[3], q[4];
x q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
cx q[3], q[4];
x q[4];
h q[4];
sdg q[4];
// END undup
cp(0.0) q[3], q[2];
x q[3]; // want_negated=True
cp(0.0) q[2], q[3];
x q[3]; // want_negated=False
ctrl(1) @ ry(-0.0) q[2], q[3]; // inplace_rot
x q[2]; // want_negated=True
cp(0.0) q[3], q[2];
x q[3]; // want_negated=True
cp(0.0) q[3], q[2];
x q[3]; // want_negated=False
ctrl(1) @ ry(-1.9106332362490186) q[2], q[3]; // inplace_rot
x q[2]; // want_negated=False
ry(-1.3694384060045657) q[2]; // inplace_rot
cx q[3], q[4]; // alloc
// BEGIN dup
h q[5];
t q[5];
cx q[2], q[5];
inv @ t q[5];
cx q[3], q[5];
x q[5];
t q[5];
cx q[2], q[5];
inv @ t q[5];
h q[5];
// END dup
// BEGIN dup
h q[6];
t q[6];
cx q[2], q[6];
inv @ t q[6];
cx q[3], q[6];
x q[6];
t q[6];
cx q[2], q[6];
inv @ t q[6];
h q[6];
// END dup
// BEGIN dup
s q[7];
h q[7];
cx q[3], q[7];
x q[7];
t q[7];
cx q[5], q[7];
inv @ t q[7];
cx q[3], q[7];
x q[7];
t q[7];
cx q[5], q[7];
inv @ t q[7];
h q[7];
sdg q[7];
// END dup
cx q[3], q[7]; // alloc
// BEGIN dup
s q[4];
h q[4];
cx q[3], q[4];
x q[4];
t q[4];
cx q[6], q[4];
inv @ t q[4];
cx q[3], q[4];
x q[4];
t q[4];
cx q[6], q[4];
inv @ t q[4];
h q[4];
sdg q[4];
// END dup
// BEGIN dup
s q[8];
h q[8];
cx q[7], q[8];
t q[8];
cx q[4], q[8];
inv @ t q[8];
cx q[7], q[8];
t q[8];
cx q[4], q[8];
inv @ t q[8];
h q[8];
sdg q[8];
// END dup
p(3.141592653589793) q[8];
// BEGIN undup
s q[8];
h q[8];
t q[8];
cx q[4], q[8];
inv @ t q[8];
cx q[7], q[8];
t q[8];
cx q[4], q[8];
inv @ t q[8];
cx q[7], q[8];
h q[8];
sdg q[8];
// END undup
// BEGIN undup
s q[4];
h q[4];
t q[4];
cx q[6], q[4];
inv @ t q[4];
cx q[3], q[4];
x q[4];
t q[4];
cx q[6], q[4];
inv @ t q[4];
cx q[3], q[4];
x q[4];
h q[4];
sdg q[4];
// END undup
// BEGIN undup
s q[7];
h q[7];
t q[7];
cx q[5], q[7];
inv @ t q[7];
cx q[3], q[7];
x q[7];
t q[7];
cx q[5], q[7];
inv @ t q[7];
cx q[3], q[7];
x q[7];
h q[7];
sdg q[7];
// END undup
cx q[3], q[7]; // dealloc
// BEGIN undup
h q[6];
t q[6];
cx q[2], q[6];
inv @ t q[6];
cx q[3], q[6];
x q[6];
t q[6];
cx q[2], q[6];
inv @ t q[6];
h q[6];
// END undup
// BEGIN dup
s q[6];
h q[6];
cx q[3], q[6];
x q[6];
t q[6];
cx q[2], q[6];
inv @ t q[6];
cx q[3], q[6];
x q[6];
t q[6];
cx q[2], q[6];
inv @ t q[6];
h q[6];
sdg q[6];
// END dup
// BEGIN undup
s q[6];
h q[6];
t q[6];
cx q[5], q[6];
inv @ t q[6];
cx q[3], q[6];
x q[6];
t q[6];
cx q[5], q[6];
inv @ t q[6];
cx q[3], q[6];
x q[6];
h q[6];
sdg q[6];
// END undup
// BEGIN undup
h q[5];
t q[5];
cx q[2], q[5];
inv @ t q[5];
cx q[3], q[5];
x q[5];
t q[5];
cx q[2], q[5];
inv @ t q[5];
h q[5];
// END undup
cx q[3], q[4]; // dealloc
ry(1.3694384060045657) q[2]; // inplace_rot
x q[2]; // want_negated=True
ctrl(1) @ ry(1.9106332362490186) q[2], q[3]; // inplace_rot
x q[3]; // want_negated=True
cp(0.0) q[3], q[2];
x q[3]; // want_negated=False
cp(0.0) q[3], q[2];
x q[2]; // want_negated=False
ctrl(1) @ ry(0.0) q[2], q[3]; // inplace_rot
x q[3]; // want_negated=True
cp(0.0) q[2], q[3];
x q[3]; // want_negated=False
cp(0.0) q[2], q[3];
// BEGIN dup
s q[4];
h q[4];
cx q[3], q[4];
x q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
cx q[3], q[4];
x q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
h q[4];
sdg q[4];
// END dup
p(0.0) q[4];
// BEGIN undup
s q[4];
h q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
cx q[3], q[4];
x q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
cx q[3], q[4];
x q[4];
h q[4];
sdg q[4];
// END undup
// BEGIN lifted_x
h q[4];
t q[4];
cx q[2], q[4];
x q[4];
inv @ t q[4];
cx q[3], q[4];
t q[4];
cx q[2], q[4];
x q[4];
inv @ t q[4];
h q[4];
// END lifted_x
p(0.0) q[4];
// BEGIN unlifted_x
h q[4];
t q[4];
cx q[2], q[4];
x q[4];
inv @ t q[4];
cx q[3], q[4];
t q[4];
cx q[2], q[4];
x q[4];
inv @ t q[4];
h q[4];
// END unlifted_x
// BEGIN lifted_x
s q[4];
h q[4];
cx q[3], q[4];
x q[4];
t q[4];
cx q[2], q[4];
x q[4];
inv @ t q[4];
cx q[3], q[4];
x q[4];
t q[4];
cx q[2], q[4];
x q[4];
inv @ t q[4];
h q[4];
sdg q[4];
// END lifted_x
p(-3.141592653589793) q[4];
// BEGIN unlifted_x
s q[4];
h q[4];
t q[4];
cx q[2], q[4];
x q[4];
inv @ t q[4];
cx q[3], q[4];
x q[4];
t q[4];
cx q[2], q[4];
x q[4];
inv @ t q[4];
cx q[3], q[4];
x q[4];
h q[4];
sdg q[4];
// END unlifted_x
// BEGIN dup
s q[4];
h q[4];
cx q[3], q[4];
x q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
cx q[3], q[4];
x q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
h q[4];
sdg q[4];
// END dup
cx q[4], q[1]; // inplace_x
// BEGIN undup
s q[4];
h q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
cx q[3], q[4];
x q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
cx q[3], q[4];
x q[4];
h q[4];
sdg q[4];
// END undup
// BEGIN lifted_x
h q[4];
t q[4];
cx q[2], q[4];
x q[4];
inv @ t q[4];
cx q[3], q[4];
t q[4];
cx q[2], q[4];
x q[4];
inv @ t q[4];
h q[4];
// END lifted_x
cx q[4], q[0]; // inplace_x
// BEGIN unlifted_x
h q[4];
t q[4];
cx q[2], q[4];
x q[4];
inv @ t q[4];
cx q[3], q[4];
t q[4];
cx q[2], q[4];
x q[4];
inv @ t q[4];
h q[4];
// END unlifted_x
// BEGIN lifted_x
s q[4];
h q[4];
cx q[3], q[4];
x q[4];
t q[4];
cx q[2], q[4];
x q[4];
inv @ t q[4];
cx q[3], q[4];
x q[4];
t q[4];
cx q[2], q[4];
x q[4];
inv @ t q[4];
h q[4];
sdg q[4];
// END lifted_x
cp(-3.141592653589793) q[1], q[4];
cp(-3.141592653589793) q[0], q[4];
// BEGIN unlifted_x
s q[4];
h q[4];
t q[4];
cx q[2], q[4];
x q[4];
inv @ t q[4];
cx q[3], q[4];
x q[4];
t q[4];
cx q[2], q[4];
x q[4];
inv @ t q[4];
cx q[3], q[4];
x q[4];
h q[4];
sdg q[4];
// END unlifted_x
cp(0.0) q[3], q[2];
x q[3]; // want_negated=True
cp(0.0) q[2], q[3];
x q[3]; // want_negated=False
ctrl(1) @ ry(-0.0) q[2], q[3]; // inplace_rot
x q[2]; // want_negated=True
cp(0.0) q[3], q[2];
x q[3]; // want_negated=True
cp(0.0) q[2], q[3];
x q[3]; // want_negated=False
ctrl(1) @ ry(-1.9106332362490186) q[2], q[3]; // inplace_rot
x q[2]; // want_negated=False
ry(-1.3694384060045657) q[2]; // inplace_rot
swap q[0], q[3];
swap q[1], q[2];
swap q[2], q[3];

