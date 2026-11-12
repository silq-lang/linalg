include "stdgates.inc";
bit m0;
bit m1;
bit m2;
qubit[8] q;

h q[0]; // inplace_h
h q[1]; // inplace_h
h q[2]; // inplace_h
h q[3]; // inplace_h
h q[4]; // inplace_h
cx q[0], q[4]; // inplace_x
p(0.7853981633974483) q[4];
p(-0.7853981633974483) q[4];
cx q[0], q[4]; // inplace_x
p(0.7853981633974483) q[4];
p(-0.7853981633974483) q[4];
h q[4]; // inplace_h
p(-1.5707963267948966) q[4];
cx q[4], q[1]; // inplace_x
h q[5]; // inplace_h
cx q[1], q[5]; // inplace_x
p(0.7853981633974483) q[5];
x q[4]; // want_negated=True
cx q[4], q[5]; // inplace_x
p(-0.7853981633974483) q[5];
cx q[1], q[5]; // inplace_x
p(0.7853981633974483) q[5];
cx q[4], q[5]; // inplace_x
p(-0.7853981633974483) q[5];
h q[5]; // inplace_h
p(-1.5707963267948966) q[5];
x q[4]; // want_negated=False
cx q[4], q[5]; // inplace_x
cx q[5], q[2]; // inplace_x
h q[6]; // inplace_h
cx q[2], q[6]; // inplace_x
p(0.7853981633974483) q[6];
cx q[5], q[6]; // inplace_x
p(-0.7853981633974483) q[6];
cx q[2], q[6]; // inplace_x
p(0.7853981633974483) q[6];
cx q[5], q[6]; // inplace_x
p(-0.7853981633974483) q[6];
h q[6]; // inplace_h
p(-1.5707963267948966) q[6];
cx q[5], q[6]; // inplace_x
cx q[3], q[7]; // lifted_xor/uncontrolled
cx q[6], q[7]; // lifted_xor/uncontrolled
cx q[5], q[6]; // inplace_x
h q[6]; // inplace_h
m0 = measure q[6];
reset q[6];
if ((m0==true)) {
	cx q[2], q[6]; // dup
}
cp(3.141592653589793) q[6], q[5];
if ((m0==true)) {
	cx q[2], q[6]; // undup
}
cx q[5], q[2]; // inplace_x
cx q[5], q[6]; // lifted_xor/uncontrolled
cx q[2], q[6]; // lifted_xor/uncontrolled
cx q[4], q[5]; // inplace_x
h q[5]; // inplace_h
m1 = measure q[5];
reset q[5];
if ((m1==true)) {
	cx q[1], q[5]; // dup
}
x q[4]; // want_negated=True
cp(3.141592653589793) q[4], q[5];
if ((m1==true)) {
	cx q[1], q[5]; // undup
}
x q[4]; // want_negated=False
cx q[4], q[1]; // inplace_x
cx q[4], q[5]; // lifted_xor/uncontrolled
cx q[1], q[5]; // lifted_xor/uncontrolled
h q[4]; // inplace_h
m2 = measure q[4];
reset q[4];
cx q[0], q[4]; // dup
x q[5];
swap q[0], q[4];

