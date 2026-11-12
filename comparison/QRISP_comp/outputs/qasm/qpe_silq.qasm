include "stdgates.inc";
qubit[6] q;

h q[0]; // inplace_h
h q[1]; // inplace_h
h q[2]; // inplace_h
ry(0.6283185307179586) q[3]; // inplace_rot
cp(0.7853981633974483) q[3], q[0];
cp(0.7853981633974483) q[1], q[3];
cp(0.7853981633974483) q[1], q[3];
cp(0.7853981633974483) q[2], q[3];
cp(0.7853981633974483) q[2], q[3];
cp(0.7853981633974483) q[2], q[3];
cp(0.7853981633974483) q[2], q[3];
h q[2]; // inplace_h
// BEGIN dup
h q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
cx q[1], q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
h q[4];
// END dup
p(-1.5707963267948966) q[4];
// BEGIN dup
s q[5];
h q[5];
cx q[1], q[5];
t q[5];
cx q[2], q[5];
inv @ t q[5];
cx q[1], q[5];
t q[5];
cx q[2], q[5];
inv @ t q[5];
h q[5];
sdg q[5];
// END dup
// BEGIN undup
s q[5];
h q[5];
t q[5];
cx q[4], q[5];
inv @ t q[5];
cx q[1], q[5];
t q[5];
cx q[4], q[5];
inv @ t q[5];
cx q[1], q[5];
h q[5];
sdg q[5];
// END undup
// BEGIN undup
h q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
cx q[1], q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
h q[4];
// END undup
h q[1]; // inplace_h
// BEGIN dup
h q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
cx q[0], q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
h q[4];
// END dup
p(-0.7853981633974483) q[4];
// BEGIN dup
s q[5];
h q[5];
cx q[0], q[5];
t q[5];
cx q[2], q[5];
inv @ t q[5];
cx q[0], q[5];
t q[5];
cx q[2], q[5];
inv @ t q[5];
h q[5];
sdg q[5];
// END dup
// BEGIN undup
s q[5];
h q[5];
t q[5];
cx q[4], q[5];
inv @ t q[5];
cx q[0], q[5];
t q[5];
cx q[4], q[5];
inv @ t q[5];
cx q[0], q[5];
h q[5];
sdg q[5];
// END undup
// BEGIN undup
h q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
cx q[0], q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
h q[4];
// END undup
// BEGIN dup
h q[4];
t q[4];
cx q[1], q[4];
inv @ t q[4];
cx q[0], q[4];
t q[4];
cx q[1], q[4];
inv @ t q[4];
h q[4];
// END dup
p(-1.5707963267948966) q[4];
// BEGIN dup
s q[5];
h q[5];
cx q[0], q[5];
t q[5];
cx q[1], q[5];
inv @ t q[5];
cx q[0], q[5];
t q[5];
cx q[1], q[5];
inv @ t q[5];
h q[5];
sdg q[5];
// END dup
// BEGIN undup
s q[5];
h q[5];
t q[5];
cx q[4], q[5];
inv @ t q[5];
cx q[0], q[5];
t q[5];
cx q[4], q[5];
inv @ t q[5];
cx q[0], q[5];
h q[5];
sdg q[5];
// END undup
// BEGIN undup
h q[4];
t q[4];
cx q[1], q[4];
inv @ t q[4];
cx q[0], q[4];
t q[4];
cx q[1], q[4];
inv @ t q[4];
h q[4];
// END undup
h q[0]; // inplace_h
swap q[0], q[2];

