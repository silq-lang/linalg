include "stdgates.inc";
qubit[8] q;

h q[0]; // inplace_h
h q[1]; // inplace_h
h q[2]; // inplace_h
h q[3]; // inplace_h
h q[4]; // inplace_h
// BEGIN lifted_x
h q[5];
t q[5];
cx q[1], q[5];
x q[5];
inv @ t q[5];
cx q[2], q[5];
t q[5];
cx q[1], q[5];
x q[5];
inv @ t q[5];
h q[5];
// END lifted_x
x q[2]; // want_negated=True
cx q[2], q[5]; // alloc
// BEGIN dup
h q[6];
t q[6];
cx q[5], q[6];
inv @ t q[6];
cx q[3], q[6];
x q[6];
t q[6];
cx q[5], q[6];
inv @ t q[6];
h q[6];
// END dup
// BEGIN dup
s q[7];
h q[7];
cx q[4], q[7];
x q[7];
t q[7];
cx q[6], q[7];
inv @ t q[7];
cx q[4], q[7];
x q[7];
t q[7];
cx q[6], q[7];
inv @ t q[7];
h q[7];
sdg q[7];
// END dup
// BEGIN undup
h q[6];
t q[6];
cx q[5], q[6];
inv @ t q[6];
cx q[3], q[6];
x q[6];
t q[6];
cx q[5], q[6];
inv @ t q[6];
h q[6];
// END undup
cx q[2], q[5]; // dealloc
// BEGIN unlifted_x
h q[5];
t q[5];
cx q[1], q[5];
x q[5];
inv @ t q[5];
cx q[2], q[5];
x q[5];
t q[5];
cx q[1], q[5];
x q[5];
inv @ t q[5];
h q[5];
// END unlifted_x
x q[2];
swap q[5], q[7];

