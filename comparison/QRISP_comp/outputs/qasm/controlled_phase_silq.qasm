include "stdgates.inc";
qubit[11] q;

h q[0]; // inplace_h
h q[1]; // inplace_h
h q[2]; // inplace_h
h q[3]; // inplace_h
// BEGIN lifted_x
h q[5];
t q[5];
cx q[1], q[5];
x q[5];
inv @ t q[5];
cx q[0], q[5];
t q[5];
cx q[1], q[5];
x q[5];
inv @ t q[5];
h q[5];
// END lifted_x
// BEGIN dup
s q[6];
h q[6];
cx q[0], q[6];
t q[6];
cx q[5], q[6];
inv @ t q[6];
cx q[0], q[6];
t q[6];
cx q[5], q[6];
inv @ t q[6];
h q[6];
sdg q[6];
// END dup
x q[0]; // want_negated=True
cx q[0], q[6]; // alloc
// BEGIN lifted_x
h q[7];
t q[7];
cx q[2], q[7];
x q[7];
inv @ t q[7];
cx q[6], q[7];
x q[7];
t q[7];
cx q[2], q[7];
x q[7];
inv @ t q[7];
h q[7];
// END lifted_x
// BEGIN dup
s q[8];
h q[8];
cx q[6], q[8];
x q[8];
t q[8];
cx q[7], q[8];
inv @ t q[8];
cx q[6], q[8];
x q[8];
t q[8];
cx q[7], q[8];
inv @ t q[8];
h q[8];
sdg q[8];
// END dup
cx q[6], q[8]; // alloc
// BEGIN lifted_x
h q[9];
t q[9];
cx q[3], q[9];
x q[9];
inv @ t q[9];
cx q[8], q[9];
x q[9];
t q[9];
cx q[3], q[9];
x q[9];
inv @ t q[9];
h q[9];
// END lifted_x
// BEGIN dup
s q[10];
h q[10];
cx q[8], q[10];
x q[10];
t q[10];
cx q[9], q[10];
inv @ t q[10];
cx q[8], q[10];
x q[10];
t q[10];
cx q[9], q[10];
inv @ t q[10];
h q[10];
sdg q[10];
// END dup
cx q[8], q[10]; // alloc
x q[10]; // want_negated=True
p(0.7853981633974483) q[10];
x q[10]; // want_negated=False
cx q[8], q[10]; // dealloc
// BEGIN undup
s q[10];
h q[10];
t q[10];
cx q[9], q[10];
inv @ t q[10];
cx q[8], q[10];
x q[10];
t q[10];
cx q[9], q[10];
inv @ t q[10];
cx q[8], q[10];
x q[10];
h q[10];
sdg q[10];
// END undup
// BEGIN unlifted_x
h q[9];
t q[9];
cx q[3], q[9];
x q[9];
inv @ t q[9];
cx q[8], q[9];
x q[9];
t q[9];
cx q[3], q[9];
x q[9];
inv @ t q[9];
h q[9];
// END unlifted_x
cx q[6], q[8]; // dealloc
// BEGIN undup
s q[8];
h q[8];
t q[8];
cx q[7], q[8];
inv @ t q[8];
cx q[6], q[8];
x q[8];
t q[8];
cx q[7], q[8];
inv @ t q[8];
cx q[6], q[8];
x q[8];
h q[8];
sdg q[8];
// END undup
// BEGIN unlifted_x
h q[7];
t q[7];
cx q[2], q[7];
x q[7];
inv @ t q[7];
cx q[6], q[7];
x q[7];
t q[7];
cx q[2], q[7];
x q[7];
inv @ t q[7];
h q[7];
// END unlifted_x
cx q[0], q[6]; // dealloc
// BEGIN undup
s q[6];
h q[6];
t q[6];
cx q[5], q[6];
inv @ t q[6];
cx q[0], q[6];
x q[6];
t q[6];
cx q[5], q[6];
inv @ t q[6];
cx q[0], q[6];
x q[6];
h q[6];
sdg q[6];
// END undup
// BEGIN unlifted_x
h q[5];
t q[5];
cx q[1], q[5];
x q[5];
inv @ t q[5];
cx q[0], q[5];
x q[5];
t q[5];
cx q[1], q[5];
x q[5];
inv @ t q[5];
h q[5];
// END unlifted_x
x q[0];
x q[4];

