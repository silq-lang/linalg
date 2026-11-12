include "stdgates.inc";
qubit[10] q;

gphase(6.179952383167375e-18);
ry(0.6719508964959136) q[0]; // inplace_rot
x q[0]; // want_negated=True
ctrl(1) @ ry(1.963636150735785e-16) q[0], q[1]; // inplace_rot
x q[0]; // want_negated=False
ctrl(1) @ ry(3.141592653589793) q[0], q[1]; // inplace_rot
// BEGIN lifted_x
s q[2];
h q[2];
cx q[0], q[2];
x q[2];
t q[2];
cx q[1], q[2];
x q[2];
inv @ t q[2];
cx q[0], q[2];
x q[2];
t q[2];
cx q[1], q[2];
x q[2];
inv @ t q[2];
h q[2];
sdg q[2];
// END lifted_x
ctrl(1) @ ry(1.2323209568832076e-16) q[2], q[3]; // inplace_rot
// BEGIN unlifted_x
s q[2];
h q[2];
t q[2];
cx q[1], q[2];
x q[2];
inv @ t q[2];
cx q[0], q[2];
x q[2];
t q[2];
cx q[1], q[2];
x q[2];
inv @ t q[2];
cx q[0], q[2];
x q[2];
h q[2];
sdg q[2];
// END unlifted_x
// BEGIN lifted_x
h q[2];
t q[2];
cx q[1], q[2];
x q[2];
inv @ t q[2];
cx q[0], q[2];
t q[2];
cx q[1], q[2];
x q[2];
inv @ t q[2];
h q[2];
// END lifted_x
ctrl(1) @ ry(0.0) q[2], q[3]; // inplace_rot
// BEGIN unlifted_x
h q[2];
t q[2];
cx q[1], q[2];
x q[2];
inv @ t q[2];
cx q[0], q[2];
t q[2];
cx q[1], q[2];
x q[2];
inv @ t q[2];
h q[2];
// END unlifted_x
// BEGIN dup
s q[2];
h q[2];
cx q[0], q[2];
x q[2];
t q[2];
cx q[1], q[2];
inv @ t q[2];
cx q[0], q[2];
x q[2];
t q[2];
cx q[1], q[2];
inv @ t q[2];
h q[2];
sdg q[2];
// END dup
ctrl(1) @ ry(0.0) q[2], q[3]; // inplace_rot
// BEGIN undup
s q[2];
h q[2];
t q[2];
cx q[1], q[2];
inv @ t q[2];
cx q[0], q[2];
x q[2];
t q[2];
cx q[1], q[2];
inv @ t q[2];
cx q[0], q[2];
x q[2];
h q[2];
sdg q[2];
// END undup
// BEGIN dup
h q[2];
t q[2];
cx q[1], q[2];
inv @ t q[2];
cx q[0], q[2];
t q[2];
cx q[1], q[2];
inv @ t q[2];
h q[2];
// END dup
ctrl(1) @ ry(3.141592653589793) q[2], q[3]; // inplace_rot
// BEGIN undup
h q[2];
t q[2];
cx q[1], q[2];
inv @ t q[2];
cx q[0], q[2];
t q[2];
cx q[1], q[2];
inv @ t q[2];
h q[2];
// END undup
// BEGIN lifted_x
s q[2];
h q[2];
cx q[1], q[2];
x q[2];
t q[2];
cx q[3], q[2];
x q[2];
inv @ t q[2];
cx q[1], q[2];
x q[2];
t q[2];
cx q[3], q[2];
x q[2];
inv @ t q[2];
h q[2];
sdg q[2];
// END lifted_x
// BEGIN dup
s q[4];
h q[4];
cx q[0], q[4];
x q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
cx q[0], q[4];
x q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
h q[4];
sdg q[4];
// END dup
ctrl(1) @ ry(6.211085736694741e-17) q[4], q[5]; // inplace_rot
// BEGIN undup
s q[4];
h q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
cx q[0], q[4];
x q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
cx q[0], q[4];
x q[4];
h q[4];
sdg q[4];
// END undup
// BEGIN unlifted_x
s q[2];
h q[2];
t q[2];
cx q[3], q[2];
x q[2];
inv @ t q[2];
cx q[1], q[2];
x q[2];
t q[2];
cx q[3], q[2];
x q[2];
inv @ t q[2];
cx q[1], q[2];
x q[2];
h q[2];
sdg q[2];
// END unlifted_x
// BEGIN lifted_x
s q[2];
h q[2];
cx q[1], q[2];
x q[2];
t q[2];
cx q[3], q[2];
x q[2];
inv @ t q[2];
cx q[1], q[2];
x q[2];
t q[2];
cx q[3], q[2];
x q[2];
inv @ t q[2];
h q[2];
sdg q[2];
// END lifted_x
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
ctrl(1) @ ry(0.0) q[4], q[5]; // inplace_rot
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
// BEGIN unlifted_x
s q[2];
h q[2];
t q[2];
cx q[3], q[2];
x q[2];
inv @ t q[2];
cx q[1], q[2];
x q[2];
t q[2];
cx q[3], q[2];
x q[2];
inv @ t q[2];
cx q[1], q[2];
x q[2];
h q[2];
sdg q[2];
// END unlifted_x
// BEGIN lifted_x
h q[2];
t q[2];
cx q[3], q[2];
x q[2];
inv @ t q[2];
cx q[1], q[2];
t q[2];
cx q[3], q[2];
x q[2];
inv @ t q[2];
h q[2];
// END lifted_x
// BEGIN dup
s q[4];
h q[4];
cx q[0], q[4];
x q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
cx q[0], q[4];
x q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
h q[4];
sdg q[4];
// END dup
ctrl(1) @ ry(0.0) q[4], q[5]; // inplace_rot
// BEGIN undup
s q[4];
h q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
cx q[0], q[4];
x q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
cx q[0], q[4];
x q[4];
h q[4];
sdg q[4];
// END undup
// BEGIN unlifted_x
h q[2];
t q[2];
cx q[3], q[2];
x q[2];
inv @ t q[2];
cx q[1], q[2];
t q[2];
cx q[3], q[2];
x q[2];
inv @ t q[2];
h q[2];
// END unlifted_x
// BEGIN lifted_x
h q[2];
t q[2];
cx q[3], q[2];
x q[2];
inv @ t q[2];
cx q[1], q[2];
t q[2];
cx q[3], q[2];
x q[2];
inv @ t q[2];
h q[2];
// END lifted_x
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
ctrl(1) @ ry(0.0) q[4], q[5]; // inplace_rot
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
// BEGIN unlifted_x
h q[2];
t q[2];
cx q[3], q[2];
x q[2];
inv @ t q[2];
cx q[1], q[2];
t q[2];
cx q[3], q[2];
x q[2];
inv @ t q[2];
h q[2];
// END unlifted_x
// BEGIN dup
s q[2];
h q[2];
cx q[1], q[2];
x q[2];
t q[2];
cx q[3], q[2];
inv @ t q[2];
cx q[1], q[2];
x q[2];
t q[2];
cx q[3], q[2];
inv @ t q[2];
h q[2];
sdg q[2];
// END dup
// BEGIN dup
s q[4];
h q[4];
cx q[0], q[4];
x q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
cx q[0], q[4];
x q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
h q[4];
sdg q[4];
// END dup
ctrl(1) @ ry(0.0) q[4], q[5]; // inplace_rot
// BEGIN undup
s q[4];
h q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
cx q[0], q[4];
x q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
cx q[0], q[4];
x q[4];
h q[4];
sdg q[4];
// END undup
// BEGIN undup
s q[2];
h q[2];
t q[2];
cx q[3], q[2];
inv @ t q[2];
cx q[1], q[2];
x q[2];
t q[2];
cx q[3], q[2];
inv @ t q[2];
cx q[1], q[2];
x q[2];
h q[2];
sdg q[2];
// END undup
// BEGIN dup
s q[2];
h q[2];
cx q[1], q[2];
x q[2];
t q[2];
cx q[3], q[2];
inv @ t q[2];
cx q[1], q[2];
x q[2];
t q[2];
cx q[3], q[2];
inv @ t q[2];
h q[2];
sdg q[2];
// END dup
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
ctrl(1) @ ry(0.0) q[4], q[5]; // inplace_rot
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
// BEGIN undup
s q[2];
h q[2];
t q[2];
cx q[3], q[2];
inv @ t q[2];
cx q[1], q[2];
x q[2];
t q[2];
cx q[3], q[2];
inv @ t q[2];
cx q[1], q[2];
x q[2];
h q[2];
sdg q[2];
// END undup
// BEGIN dup
h q[2];
t q[2];
cx q[3], q[2];
inv @ t q[2];
cx q[1], q[2];
t q[2];
cx q[3], q[2];
inv @ t q[2];
h q[2];
// END dup
// BEGIN dup
s q[4];
h q[4];
cx q[0], q[4];
x q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
cx q[0], q[4];
x q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
h q[4];
sdg q[4];
// END dup
ctrl(1) @ ry(0.0) q[4], q[5]; // inplace_rot
// BEGIN undup
s q[4];
h q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
cx q[0], q[4];
x q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
cx q[0], q[4];
x q[4];
h q[4];
sdg q[4];
// END undup
// BEGIN undup
h q[2];
t q[2];
cx q[3], q[2];
inv @ t q[2];
cx q[1], q[2];
t q[2];
cx q[3], q[2];
inv @ t q[2];
h q[2];
// END undup
// BEGIN dup
h q[2];
t q[2];
cx q[3], q[2];
inv @ t q[2];
cx q[1], q[2];
t q[2];
cx q[3], q[2];
inv @ t q[2];
h q[2];
// END dup
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
ctrl(1) @ ry(3.141592653589793) q[4], q[5]; // inplace_rot
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
// BEGIN undup
h q[2];
t q[2];
cx q[3], q[2];
inv @ t q[2];
cx q[1], q[2];
t q[2];
cx q[3], q[2];
inv @ t q[2];
h q[2];
// END undup
// BEGIN lifted_x
s q[2];
h q[2];
cx q[3], q[2];
x q[2];
t q[2];
cx q[5], q[2];
x q[2];
inv @ t q[2];
cx q[3], q[2];
x q[2];
t q[2];
cx q[5], q[2];
x q[2];
inv @ t q[2];
h q[2];
sdg q[2];
// END lifted_x
// BEGIN dup
s q[4];
h q[4];
cx q[1], q[4];
x q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
cx q[1], q[4];
x q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
h q[4];
sdg q[4];
// END dup
// BEGIN dup
s q[6];
h q[6];
cx q[0], q[6];
x q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[0], q[6];
x q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
h q[6];
sdg q[6];
// END dup
ctrl(1) @ ry(0.3136313706888016) q[6], q[7]; // inplace_rot
// BEGIN undup
s q[6];
h q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[0], q[6];
x q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[0], q[6];
x q[6];
h q[6];
sdg q[6];
// END undup
// BEGIN undup
s q[4];
h q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
cx q[1], q[4];
x q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
cx q[1], q[4];
x q[4];
h q[4];
sdg q[4];
// END undup
// BEGIN unlifted_x
s q[2];
h q[2];
t q[2];
cx q[5], q[2];
x q[2];
inv @ t q[2];
cx q[3], q[2];
x q[2];
t q[2];
cx q[5], q[2];
x q[2];
inv @ t q[2];
cx q[3], q[2];
x q[2];
h q[2];
sdg q[2];
// END unlifted_x
// BEGIN lifted_x
s q[2];
h q[2];
cx q[3], q[2];
x q[2];
t q[2];
cx q[5], q[2];
x q[2];
inv @ t q[2];
cx q[3], q[2];
x q[2];
t q[2];
cx q[5], q[2];
x q[2];
inv @ t q[2];
h q[2];
sdg q[2];
// END lifted_x
// BEGIN dup
s q[4];
h q[4];
cx q[1], q[4];
x q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
cx q[1], q[4];
x q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
h q[4];
sdg q[4];
// END dup
// BEGIN dup
h q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[0], q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
h q[6];
// END dup
ctrl(1) @ ry(0.0) q[6], q[7]; // inplace_rot
// BEGIN undup
h q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[0], q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
h q[6];
// END undup
// BEGIN undup
s q[4];
h q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
cx q[1], q[4];
x q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
cx q[1], q[4];
x q[4];
h q[4];
sdg q[4];
// END undup
// BEGIN unlifted_x
s q[2];
h q[2];
t q[2];
cx q[5], q[2];
x q[2];
inv @ t q[2];
cx q[3], q[2];
x q[2];
t q[2];
cx q[5], q[2];
x q[2];
inv @ t q[2];
cx q[3], q[2];
x q[2];
h q[2];
sdg q[2];
// END unlifted_x
// BEGIN lifted_x
s q[2];
h q[2];
cx q[3], q[2];
x q[2];
t q[2];
cx q[5], q[2];
x q[2];
inv @ t q[2];
cx q[3], q[2];
x q[2];
t q[2];
cx q[5], q[2];
x q[2];
inv @ t q[2];
h q[2];
sdg q[2];
// END lifted_x
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
// BEGIN dup
s q[6];
h q[6];
cx q[0], q[6];
x q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[0], q[6];
x q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
h q[6];
sdg q[6];
// END dup
ctrl(1) @ ry(0.0) q[6], q[7]; // inplace_rot
// BEGIN undup
s q[6];
h q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[0], q[6];
x q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[0], q[6];
x q[6];
h q[6];
sdg q[6];
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
// BEGIN unlifted_x
s q[2];
h q[2];
t q[2];
cx q[5], q[2];
x q[2];
inv @ t q[2];
cx q[3], q[2];
x q[2];
t q[2];
cx q[5], q[2];
x q[2];
inv @ t q[2];
cx q[3], q[2];
x q[2];
h q[2];
sdg q[2];
// END unlifted_x
// BEGIN lifted_x
s q[2];
h q[2];
cx q[3], q[2];
x q[2];
t q[2];
cx q[5], q[2];
x q[2];
inv @ t q[2];
cx q[3], q[2];
x q[2];
t q[2];
cx q[5], q[2];
x q[2];
inv @ t q[2];
h q[2];
sdg q[2];
// END lifted_x
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
// BEGIN dup
h q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[0], q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
h q[6];
// END dup
ctrl(1) @ ry(0.0) q[6], q[7]; // inplace_rot
// BEGIN undup
h q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[0], q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
h q[6];
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
// BEGIN unlifted_x
s q[2];
h q[2];
t q[2];
cx q[5], q[2];
x q[2];
inv @ t q[2];
cx q[3], q[2];
x q[2];
t q[2];
cx q[5], q[2];
x q[2];
inv @ t q[2];
cx q[3], q[2];
x q[2];
h q[2];
sdg q[2];
// END unlifted_x
// BEGIN lifted_x
h q[2];
t q[2];
cx q[5], q[2];
x q[2];
inv @ t q[2];
cx q[3], q[2];
t q[2];
cx q[5], q[2];
x q[2];
inv @ t q[2];
h q[2];
// END lifted_x
// BEGIN dup
s q[4];
h q[4];
cx q[1], q[4];
x q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
cx q[1], q[4];
x q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
h q[4];
sdg q[4];
// END dup
// BEGIN dup
s q[6];
h q[6];
cx q[0], q[6];
x q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[0], q[6];
x q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
h q[6];
sdg q[6];
// END dup
ctrl(1) @ ry(0.0) q[6], q[7]; // inplace_rot
// BEGIN undup
s q[6];
h q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[0], q[6];
x q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[0], q[6];
x q[6];
h q[6];
sdg q[6];
// END undup
// BEGIN undup
s q[4];
h q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
cx q[1], q[4];
x q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
cx q[1], q[4];
x q[4];
h q[4];
sdg q[4];
// END undup
// BEGIN unlifted_x
h q[2];
t q[2];
cx q[5], q[2];
x q[2];
inv @ t q[2];
cx q[3], q[2];
t q[2];
cx q[5], q[2];
x q[2];
inv @ t q[2];
h q[2];
// END unlifted_x
// BEGIN lifted_x
h q[2];
t q[2];
cx q[5], q[2];
x q[2];
inv @ t q[2];
cx q[3], q[2];
t q[2];
cx q[5], q[2];
x q[2];
inv @ t q[2];
h q[2];
// END lifted_x
// BEGIN dup
s q[4];
h q[4];
cx q[1], q[4];
x q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
cx q[1], q[4];
x q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
h q[4];
sdg q[4];
// END dup
// BEGIN dup
h q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[0], q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
h q[6];
// END dup
ctrl(1) @ ry(0.0) q[6], q[7]; // inplace_rot
// BEGIN undup
h q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[0], q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
h q[6];
// END undup
// BEGIN undup
s q[4];
h q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
cx q[1], q[4];
x q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
cx q[1], q[4];
x q[4];
h q[4];
sdg q[4];
// END undup
// BEGIN unlifted_x
h q[2];
t q[2];
cx q[5], q[2];
x q[2];
inv @ t q[2];
cx q[3], q[2];
t q[2];
cx q[5], q[2];
x q[2];
inv @ t q[2];
h q[2];
// END unlifted_x
// BEGIN lifted_x
h q[2];
t q[2];
cx q[5], q[2];
x q[2];
inv @ t q[2];
cx q[3], q[2];
t q[2];
cx q[5], q[2];
x q[2];
inv @ t q[2];
h q[2];
// END lifted_x
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
// BEGIN dup
s q[6];
h q[6];
cx q[0], q[6];
x q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[0], q[6];
x q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
h q[6];
sdg q[6];
// END dup
ctrl(1) @ ry(0.0) q[6], q[7]; // inplace_rot
// BEGIN undup
s q[6];
h q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[0], q[6];
x q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[0], q[6];
x q[6];
h q[6];
sdg q[6];
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
// BEGIN unlifted_x
h q[2];
t q[2];
cx q[5], q[2];
x q[2];
inv @ t q[2];
cx q[3], q[2];
t q[2];
cx q[5], q[2];
x q[2];
inv @ t q[2];
h q[2];
// END unlifted_x
// BEGIN lifted_x
h q[2];
t q[2];
cx q[5], q[2];
x q[2];
inv @ t q[2];
cx q[3], q[2];
t q[2];
cx q[5], q[2];
x q[2];
inv @ t q[2];
h q[2];
// END lifted_x
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
// BEGIN dup
h q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[0], q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
h q[6];
// END dup
ctrl(1) @ ry(0.0) q[6], q[7]; // inplace_rot
// BEGIN undup
h q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[0], q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
h q[6];
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
// BEGIN unlifted_x
h q[2];
t q[2];
cx q[5], q[2];
x q[2];
inv @ t q[2];
cx q[3], q[2];
t q[2];
cx q[5], q[2];
x q[2];
inv @ t q[2];
h q[2];
// END unlifted_x
// BEGIN dup
s q[2];
h q[2];
cx q[3], q[2];
x q[2];
t q[2];
cx q[5], q[2];
inv @ t q[2];
cx q[3], q[2];
x q[2];
t q[2];
cx q[5], q[2];
inv @ t q[2];
h q[2];
sdg q[2];
// END dup
// BEGIN dup
s q[4];
h q[4];
cx q[1], q[4];
x q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
cx q[1], q[4];
x q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
h q[4];
sdg q[4];
// END dup
// BEGIN dup
s q[6];
h q[6];
cx q[0], q[6];
x q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[0], q[6];
x q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
h q[6];
sdg q[6];
// END dup
ctrl(1) @ ry(0.0) q[6], q[7]; // inplace_rot
// BEGIN undup
s q[6];
h q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[0], q[6];
x q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[0], q[6];
x q[6];
h q[6];
sdg q[6];
// END undup
// BEGIN undup
s q[4];
h q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
cx q[1], q[4];
x q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
cx q[1], q[4];
x q[4];
h q[4];
sdg q[4];
// END undup
// BEGIN undup
s q[2];
h q[2];
t q[2];
cx q[5], q[2];
inv @ t q[2];
cx q[3], q[2];
x q[2];
t q[2];
cx q[5], q[2];
inv @ t q[2];
cx q[3], q[2];
x q[2];
h q[2];
sdg q[2];
// END undup
// BEGIN dup
s q[2];
h q[2];
cx q[3], q[2];
x q[2];
t q[2];
cx q[5], q[2];
inv @ t q[2];
cx q[3], q[2];
x q[2];
t q[2];
cx q[5], q[2];
inv @ t q[2];
h q[2];
sdg q[2];
// END dup
// BEGIN dup
s q[4];
h q[4];
cx q[1], q[4];
x q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
cx q[1], q[4];
x q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
h q[4];
sdg q[4];
// END dup
// BEGIN dup
h q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[0], q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
h q[6];
// END dup
ctrl(1) @ ry(0.0) q[6], q[7]; // inplace_rot
// BEGIN undup
h q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[0], q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
h q[6];
// END undup
// BEGIN undup
s q[4];
h q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
cx q[1], q[4];
x q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
cx q[1], q[4];
x q[4];
h q[4];
sdg q[4];
// END undup
// BEGIN undup
s q[2];
h q[2];
t q[2];
cx q[5], q[2];
inv @ t q[2];
cx q[3], q[2];
x q[2];
t q[2];
cx q[5], q[2];
inv @ t q[2];
cx q[3], q[2];
x q[2];
h q[2];
sdg q[2];
// END undup
// BEGIN dup
s q[2];
h q[2];
cx q[3], q[2];
x q[2];
t q[2];
cx q[5], q[2];
inv @ t q[2];
cx q[3], q[2];
x q[2];
t q[2];
cx q[5], q[2];
inv @ t q[2];
h q[2];
sdg q[2];
// END dup
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
// BEGIN dup
s q[6];
h q[6];
cx q[0], q[6];
x q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[0], q[6];
x q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
h q[6];
sdg q[6];
// END dup
ctrl(1) @ ry(0.0) q[6], q[7]; // inplace_rot
// BEGIN undup
s q[6];
h q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[0], q[6];
x q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[0], q[6];
x q[6];
h q[6];
sdg q[6];
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
// BEGIN undup
s q[2];
h q[2];
t q[2];
cx q[5], q[2];
inv @ t q[2];
cx q[3], q[2];
x q[2];
t q[2];
cx q[5], q[2];
inv @ t q[2];
cx q[3], q[2];
x q[2];
h q[2];
sdg q[2];
// END undup
// BEGIN dup
s q[2];
h q[2];
cx q[3], q[2];
x q[2];
t q[2];
cx q[5], q[2];
inv @ t q[2];
cx q[3], q[2];
x q[2];
t q[2];
cx q[5], q[2];
inv @ t q[2];
h q[2];
sdg q[2];
// END dup
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
// BEGIN dup
h q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[0], q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
h q[6];
// END dup
ctrl(1) @ ry(0.0) q[6], q[7]; // inplace_rot
// BEGIN undup
h q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[0], q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
h q[6];
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
// BEGIN undup
s q[2];
h q[2];
t q[2];
cx q[5], q[2];
inv @ t q[2];
cx q[3], q[2];
x q[2];
t q[2];
cx q[5], q[2];
inv @ t q[2];
cx q[3], q[2];
x q[2];
h q[2];
sdg q[2];
// END undup
// BEGIN dup
h q[2];
t q[2];
cx q[5], q[2];
inv @ t q[2];
cx q[3], q[2];
t q[2];
cx q[5], q[2];
inv @ t q[2];
h q[2];
// END dup
// BEGIN dup
s q[4];
h q[4];
cx q[1], q[4];
x q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
cx q[1], q[4];
x q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
h q[4];
sdg q[4];
// END dup
// BEGIN dup
s q[6];
h q[6];
cx q[0], q[6];
x q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[0], q[6];
x q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
h q[6];
sdg q[6];
// END dup
ctrl(1) @ ry(0.0) q[6], q[7]; // inplace_rot
// BEGIN undup
s q[6];
h q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[0], q[6];
x q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[0], q[6];
x q[6];
h q[6];
sdg q[6];
// END undup
// BEGIN undup
s q[4];
h q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
cx q[1], q[4];
x q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
cx q[1], q[4];
x q[4];
h q[4];
sdg q[4];
// END undup
// BEGIN undup
h q[2];
t q[2];
cx q[5], q[2];
inv @ t q[2];
cx q[3], q[2];
t q[2];
cx q[5], q[2];
inv @ t q[2];
h q[2];
// END undup
// BEGIN dup
h q[2];
t q[2];
cx q[5], q[2];
inv @ t q[2];
cx q[3], q[2];
t q[2];
cx q[5], q[2];
inv @ t q[2];
h q[2];
// END dup
// BEGIN dup
s q[4];
h q[4];
cx q[1], q[4];
x q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
cx q[1], q[4];
x q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
h q[4];
sdg q[4];
// END dup
// BEGIN dup
h q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[0], q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
h q[6];
// END dup
ctrl(1) @ ry(0.0) q[6], q[7]; // inplace_rot
// BEGIN undup
h q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[0], q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
h q[6];
// END undup
// BEGIN undup
s q[4];
h q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
cx q[1], q[4];
x q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
cx q[1], q[4];
x q[4];
h q[4];
sdg q[4];
// END undup
// BEGIN undup
h q[2];
t q[2];
cx q[5], q[2];
inv @ t q[2];
cx q[3], q[2];
t q[2];
cx q[5], q[2];
inv @ t q[2];
h q[2];
// END undup
// BEGIN dup
h q[2];
t q[2];
cx q[5], q[2];
inv @ t q[2];
cx q[3], q[2];
t q[2];
cx q[5], q[2];
inv @ t q[2];
h q[2];
// END dup
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
// BEGIN dup
s q[6];
h q[6];
cx q[0], q[6];
x q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[0], q[6];
x q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
h q[6];
sdg q[6];
// END dup
ctrl(1) @ ry(0.0) q[6], q[7]; // inplace_rot
// BEGIN undup
s q[6];
h q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[0], q[6];
x q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[0], q[6];
x q[6];
h q[6];
sdg q[6];
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
// BEGIN undup
h q[2];
t q[2];
cx q[5], q[2];
inv @ t q[2];
cx q[3], q[2];
t q[2];
cx q[5], q[2];
inv @ t q[2];
h q[2];
// END undup
// BEGIN dup
h q[2];
t q[2];
cx q[5], q[2];
inv @ t q[2];
cx q[3], q[2];
t q[2];
cx q[5], q[2];
inv @ t q[2];
h q[2];
// END dup
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
// BEGIN dup
h q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[0], q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
h q[6];
// END dup
ctrl(1) @ ry(3.141592653589793) q[6], q[7]; // inplace_rot
// BEGIN undup
h q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[0], q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
h q[6];
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
// BEGIN undup
h q[2];
t q[2];
cx q[5], q[2];
inv @ t q[2];
cx q[3], q[2];
t q[2];
cx q[5], q[2];
inv @ t q[2];
h q[2];
// END undup
// BEGIN lifted_x
s q[2];
h q[2];
cx q[5], q[2];
x q[2];
t q[2];
cx q[7], q[2];
x q[2];
inv @ t q[2];
cx q[5], q[2];
x q[2];
t q[2];
cx q[7], q[2];
x q[2];
inv @ t q[2];
h q[2];
sdg q[2];
// END lifted_x
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
// BEGIN dup
s q[6];
h q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
h q[6];
sdg q[6];
// END dup
// BEGIN dup
s q[8];
h q[8];
cx q[0], q[8];
x q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
cx q[0], q[8];
x q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
h q[8];
sdg q[8];
// END dup
ctrl(1) @ ry(0.6435011087932844) q[8], q[9]; // inplace_rot
// BEGIN undup
s q[8];
h q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
cx q[0], q[8];
x q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
cx q[0], q[8];
x q[8];
h q[8];
sdg q[8];
// END undup
// BEGIN undup
s q[6];
h q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
h q[6];
sdg q[6];
// END undup
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
// BEGIN unlifted_x
s q[2];
h q[2];
t q[2];
cx q[7], q[2];
x q[2];
inv @ t q[2];
cx q[5], q[2];
x q[2];
t q[2];
cx q[7], q[2];
x q[2];
inv @ t q[2];
cx q[5], q[2];
x q[2];
h q[2];
sdg q[2];
// END unlifted_x
// BEGIN lifted_x
s q[2];
h q[2];
cx q[5], q[2];
x q[2];
t q[2];
cx q[7], q[2];
x q[2];
inv @ t q[2];
cx q[5], q[2];
x q[2];
t q[2];
cx q[7], q[2];
x q[2];
inv @ t q[2];
h q[2];
sdg q[2];
// END lifted_x
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
// BEGIN dup
s q[6];
h q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
h q[6];
sdg q[6];
// END dup
// BEGIN dup
h q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
cx q[0], q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
h q[8];
// END dup
ctrl(1) @ ry(0.0) q[8], q[9]; // inplace_rot
// BEGIN undup
h q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
cx q[0], q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
h q[8];
// END undup
// BEGIN undup
s q[6];
h q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
h q[6];
sdg q[6];
// END undup
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
// BEGIN unlifted_x
s q[2];
h q[2];
t q[2];
cx q[7], q[2];
x q[2];
inv @ t q[2];
cx q[5], q[2];
x q[2];
t q[2];
cx q[7], q[2];
x q[2];
inv @ t q[2];
cx q[5], q[2];
x q[2];
h q[2];
sdg q[2];
// END unlifted_x
// BEGIN lifted_x
s q[2];
h q[2];
cx q[5], q[2];
x q[2];
t q[2];
cx q[7], q[2];
x q[2];
inv @ t q[2];
cx q[5], q[2];
x q[2];
t q[2];
cx q[7], q[2];
x q[2];
inv @ t q[2];
h q[2];
sdg q[2];
// END lifted_x
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
// BEGIN dup
h q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[1], q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
h q[6];
// END dup
// BEGIN dup
s q[8];
h q[8];
cx q[0], q[8];
x q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
cx q[0], q[8];
x q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
h q[8];
sdg q[8];
// END dup
ctrl(1) @ ry(0.0) q[8], q[9]; // inplace_rot
// BEGIN undup
s q[8];
h q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
cx q[0], q[8];
x q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
cx q[0], q[8];
x q[8];
h q[8];
sdg q[8];
// END undup
// BEGIN undup
h q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[1], q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
h q[6];
// END undup
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
// BEGIN unlifted_x
s q[2];
h q[2];
t q[2];
cx q[7], q[2];
x q[2];
inv @ t q[2];
cx q[5], q[2];
x q[2];
t q[2];
cx q[7], q[2];
x q[2];
inv @ t q[2];
cx q[5], q[2];
x q[2];
h q[2];
sdg q[2];
// END unlifted_x
// BEGIN lifted_x
s q[2];
h q[2];
cx q[5], q[2];
x q[2];
t q[2];
cx q[7], q[2];
x q[2];
inv @ t q[2];
cx q[5], q[2];
x q[2];
t q[2];
cx q[7], q[2];
x q[2];
inv @ t q[2];
h q[2];
sdg q[2];
// END lifted_x
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
// BEGIN dup
h q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[1], q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
h q[6];
// END dup
// BEGIN dup
h q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
cx q[0], q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
h q[8];
// END dup
ctrl(1) @ ry(0.0) q[8], q[9]; // inplace_rot
// BEGIN undup
h q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
cx q[0], q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
h q[8];
// END undup
// BEGIN undup
h q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[1], q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
h q[6];
// END undup
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
// BEGIN unlifted_x
s q[2];
h q[2];
t q[2];
cx q[7], q[2];
x q[2];
inv @ t q[2];
cx q[5], q[2];
x q[2];
t q[2];
cx q[7], q[2];
x q[2];
inv @ t q[2];
cx q[5], q[2];
x q[2];
h q[2];
sdg q[2];
// END unlifted_x
// BEGIN lifted_x
s q[2];
h q[2];
cx q[5], q[2];
x q[2];
t q[2];
cx q[7], q[2];
x q[2];
inv @ t q[2];
cx q[5], q[2];
x q[2];
t q[2];
cx q[7], q[2];
x q[2];
inv @ t q[2];
h q[2];
sdg q[2];
// END lifted_x
// BEGIN dup
h q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
cx q[3], q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
h q[4];
// END dup
// BEGIN dup
s q[6];
h q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
h q[6];
sdg q[6];
// END dup
// BEGIN dup
s q[8];
h q[8];
cx q[0], q[8];
x q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
cx q[0], q[8];
x q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
h q[8];
sdg q[8];
// END dup
ctrl(1) @ ry(0.0) q[8], q[9]; // inplace_rot
// BEGIN undup
s q[8];
h q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
cx q[0], q[8];
x q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
cx q[0], q[8];
x q[8];
h q[8];
sdg q[8];
// END undup
// BEGIN undup
s q[6];
h q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
h q[6];
sdg q[6];
// END undup
// BEGIN undup
h q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
cx q[3], q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
h q[4];
// END undup
// BEGIN unlifted_x
s q[2];
h q[2];
t q[2];
cx q[7], q[2];
x q[2];
inv @ t q[2];
cx q[5], q[2];
x q[2];
t q[2];
cx q[7], q[2];
x q[2];
inv @ t q[2];
cx q[5], q[2];
x q[2];
h q[2];
sdg q[2];
// END unlifted_x
// BEGIN lifted_x
s q[2];
h q[2];
cx q[5], q[2];
x q[2];
t q[2];
cx q[7], q[2];
x q[2];
inv @ t q[2];
cx q[5], q[2];
x q[2];
t q[2];
cx q[7], q[2];
x q[2];
inv @ t q[2];
h q[2];
sdg q[2];
// END lifted_x
// BEGIN dup
h q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
cx q[3], q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
h q[4];
// END dup
// BEGIN dup
s q[6];
h q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
h q[6];
sdg q[6];
// END dup
// BEGIN dup
h q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
cx q[0], q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
h q[8];
// END dup
ctrl(1) @ ry(0.0) q[8], q[9]; // inplace_rot
// BEGIN undup
h q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
cx q[0], q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
h q[8];
// END undup
// BEGIN undup
s q[6];
h q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
h q[6];
sdg q[6];
// END undup
// BEGIN undup
h q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
cx q[3], q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
h q[4];
// END undup
// BEGIN unlifted_x
s q[2];
h q[2];
t q[2];
cx q[7], q[2];
x q[2];
inv @ t q[2];
cx q[5], q[2];
x q[2];
t q[2];
cx q[7], q[2];
x q[2];
inv @ t q[2];
cx q[5], q[2];
x q[2];
h q[2];
sdg q[2];
// END unlifted_x
// BEGIN lifted_x
s q[2];
h q[2];
cx q[5], q[2];
x q[2];
t q[2];
cx q[7], q[2];
x q[2];
inv @ t q[2];
cx q[5], q[2];
x q[2];
t q[2];
cx q[7], q[2];
x q[2];
inv @ t q[2];
h q[2];
sdg q[2];
// END lifted_x
// BEGIN dup
h q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
cx q[3], q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
h q[4];
// END dup
// BEGIN dup
h q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[1], q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
h q[6];
// END dup
// BEGIN dup
s q[8];
h q[8];
cx q[0], q[8];
x q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
cx q[0], q[8];
x q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
h q[8];
sdg q[8];
// END dup
ctrl(1) @ ry(0.0) q[8], q[9]; // inplace_rot
// BEGIN undup
s q[8];
h q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
cx q[0], q[8];
x q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
cx q[0], q[8];
x q[8];
h q[8];
sdg q[8];
// END undup
// BEGIN undup
h q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[1], q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
h q[6];
// END undup
// BEGIN undup
h q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
cx q[3], q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
h q[4];
// END undup
// BEGIN unlifted_x
s q[2];
h q[2];
t q[2];
cx q[7], q[2];
x q[2];
inv @ t q[2];
cx q[5], q[2];
x q[2];
t q[2];
cx q[7], q[2];
x q[2];
inv @ t q[2];
cx q[5], q[2];
x q[2];
h q[2];
sdg q[2];
// END unlifted_x
// BEGIN lifted_x
s q[2];
h q[2];
cx q[5], q[2];
x q[2];
t q[2];
cx q[7], q[2];
x q[2];
inv @ t q[2];
cx q[5], q[2];
x q[2];
t q[2];
cx q[7], q[2];
x q[2];
inv @ t q[2];
h q[2];
sdg q[2];
// END lifted_x
// BEGIN dup
h q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
cx q[3], q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
h q[4];
// END dup
// BEGIN dup
h q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[1], q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
h q[6];
// END dup
// BEGIN dup
h q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
cx q[0], q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
h q[8];
// END dup
ctrl(1) @ ry(0.0) q[8], q[9]; // inplace_rot
// BEGIN undup
h q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
cx q[0], q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
h q[8];
// END undup
// BEGIN undup
h q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[1], q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
h q[6];
// END undup
// BEGIN undup
h q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
cx q[3], q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
h q[4];
// END undup
// BEGIN unlifted_x
s q[2];
h q[2];
t q[2];
cx q[7], q[2];
x q[2];
inv @ t q[2];
cx q[5], q[2];
x q[2];
t q[2];
cx q[7], q[2];
x q[2];
inv @ t q[2];
cx q[5], q[2];
x q[2];
h q[2];
sdg q[2];
// END unlifted_x
// BEGIN lifted_x
h q[2];
t q[2];
cx q[7], q[2];
x q[2];
inv @ t q[2];
cx q[5], q[2];
t q[2];
cx q[7], q[2];
x q[2];
inv @ t q[2];
h q[2];
// END lifted_x
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
// BEGIN dup
s q[6];
h q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
h q[6];
sdg q[6];
// END dup
// BEGIN dup
s q[8];
h q[8];
cx q[0], q[8];
x q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
cx q[0], q[8];
x q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
h q[8];
sdg q[8];
// END dup
ctrl(1) @ ry(0.0) q[8], q[9]; // inplace_rot
// BEGIN undup
s q[8];
h q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
cx q[0], q[8];
x q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
cx q[0], q[8];
x q[8];
h q[8];
sdg q[8];
// END undup
// BEGIN undup
s q[6];
h q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
h q[6];
sdg q[6];
// END undup
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
// BEGIN unlifted_x
h q[2];
t q[2];
cx q[7], q[2];
x q[2];
inv @ t q[2];
cx q[5], q[2];
t q[2];
cx q[7], q[2];
x q[2];
inv @ t q[2];
h q[2];
// END unlifted_x
// BEGIN lifted_x
h q[2];
t q[2];
cx q[7], q[2];
x q[2];
inv @ t q[2];
cx q[5], q[2];
t q[2];
cx q[7], q[2];
x q[2];
inv @ t q[2];
h q[2];
// END lifted_x
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
// BEGIN dup
s q[6];
h q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
h q[6];
sdg q[6];
// END dup
// BEGIN dup
h q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
cx q[0], q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
h q[8];
// END dup
ctrl(1) @ ry(0.0) q[8], q[9]; // inplace_rot
// BEGIN undup
h q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
cx q[0], q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
h q[8];
// END undup
// BEGIN undup
s q[6];
h q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
h q[6];
sdg q[6];
// END undup
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
// BEGIN unlifted_x
h q[2];
t q[2];
cx q[7], q[2];
x q[2];
inv @ t q[2];
cx q[5], q[2];
t q[2];
cx q[7], q[2];
x q[2];
inv @ t q[2];
h q[2];
// END unlifted_x
// BEGIN lifted_x
h q[2];
t q[2];
cx q[7], q[2];
x q[2];
inv @ t q[2];
cx q[5], q[2];
t q[2];
cx q[7], q[2];
x q[2];
inv @ t q[2];
h q[2];
// END lifted_x
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
// BEGIN dup
h q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[1], q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
h q[6];
// END dup
// BEGIN dup
s q[8];
h q[8];
cx q[0], q[8];
x q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
cx q[0], q[8];
x q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
h q[8];
sdg q[8];
// END dup
ctrl(1) @ ry(0.0) q[8], q[9]; // inplace_rot
// BEGIN undup
s q[8];
h q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
cx q[0], q[8];
x q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
cx q[0], q[8];
x q[8];
h q[8];
sdg q[8];
// END undup
// BEGIN undup
h q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[1], q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
h q[6];
// END undup
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
// BEGIN unlifted_x
h q[2];
t q[2];
cx q[7], q[2];
x q[2];
inv @ t q[2];
cx q[5], q[2];
t q[2];
cx q[7], q[2];
x q[2];
inv @ t q[2];
h q[2];
// END unlifted_x
// BEGIN lifted_x
h q[2];
t q[2];
cx q[7], q[2];
x q[2];
inv @ t q[2];
cx q[5], q[2];
t q[2];
cx q[7], q[2];
x q[2];
inv @ t q[2];
h q[2];
// END lifted_x
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
// BEGIN dup
h q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[1], q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
h q[6];
// END dup
// BEGIN dup
h q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
cx q[0], q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
h q[8];
// END dup
ctrl(1) @ ry(0.0) q[8], q[9]; // inplace_rot
// BEGIN undup
h q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
cx q[0], q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
h q[8];
// END undup
// BEGIN undup
h q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[1], q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
h q[6];
// END undup
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
// BEGIN unlifted_x
h q[2];
t q[2];
cx q[7], q[2];
x q[2];
inv @ t q[2];
cx q[5], q[2];
t q[2];
cx q[7], q[2];
x q[2];
inv @ t q[2];
h q[2];
// END unlifted_x
// BEGIN lifted_x
h q[2];
t q[2];
cx q[7], q[2];
x q[2];
inv @ t q[2];
cx q[5], q[2];
t q[2];
cx q[7], q[2];
x q[2];
inv @ t q[2];
h q[2];
// END lifted_x
// BEGIN dup
h q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
cx q[3], q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
h q[4];
// END dup
// BEGIN dup
s q[6];
h q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
h q[6];
sdg q[6];
// END dup
// BEGIN dup
s q[8];
h q[8];
cx q[0], q[8];
x q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
cx q[0], q[8];
x q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
h q[8];
sdg q[8];
// END dup
ctrl(1) @ ry(0.0) q[8], q[9]; // inplace_rot
// BEGIN undup
s q[8];
h q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
cx q[0], q[8];
x q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
cx q[0], q[8];
x q[8];
h q[8];
sdg q[8];
// END undup
// BEGIN undup
s q[6];
h q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
h q[6];
sdg q[6];
// END undup
// BEGIN undup
h q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
cx q[3], q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
h q[4];
// END undup
// BEGIN unlifted_x
h q[2];
t q[2];
cx q[7], q[2];
x q[2];
inv @ t q[2];
cx q[5], q[2];
t q[2];
cx q[7], q[2];
x q[2];
inv @ t q[2];
h q[2];
// END unlifted_x
// BEGIN lifted_x
h q[2];
t q[2];
cx q[7], q[2];
x q[2];
inv @ t q[2];
cx q[5], q[2];
t q[2];
cx q[7], q[2];
x q[2];
inv @ t q[2];
h q[2];
// END lifted_x
// BEGIN dup
h q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
cx q[3], q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
h q[4];
// END dup
// BEGIN dup
s q[6];
h q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
h q[6];
sdg q[6];
// END dup
// BEGIN dup
h q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
cx q[0], q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
h q[8];
// END dup
ctrl(1) @ ry(0.0) q[8], q[9]; // inplace_rot
// BEGIN undup
h q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
cx q[0], q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
h q[8];
// END undup
// BEGIN undup
s q[6];
h q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
h q[6];
sdg q[6];
// END undup
// BEGIN undup
h q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
cx q[3], q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
h q[4];
// END undup
// BEGIN unlifted_x
h q[2];
t q[2];
cx q[7], q[2];
x q[2];
inv @ t q[2];
cx q[5], q[2];
t q[2];
cx q[7], q[2];
x q[2];
inv @ t q[2];
h q[2];
// END unlifted_x
// BEGIN lifted_x
h q[2];
t q[2];
cx q[7], q[2];
x q[2];
inv @ t q[2];
cx q[5], q[2];
t q[2];
cx q[7], q[2];
x q[2];
inv @ t q[2];
h q[2];
// END lifted_x
// BEGIN dup
h q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
cx q[3], q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
h q[4];
// END dup
// BEGIN dup
h q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[1], q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
h q[6];
// END dup
// BEGIN dup
s q[8];
h q[8];
cx q[0], q[8];
x q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
cx q[0], q[8];
x q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
h q[8];
sdg q[8];
// END dup
ctrl(1) @ ry(0.0) q[8], q[9]; // inplace_rot
// BEGIN undup
s q[8];
h q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
cx q[0], q[8];
x q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
cx q[0], q[8];
x q[8];
h q[8];
sdg q[8];
// END undup
// BEGIN undup
h q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[1], q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
h q[6];
// END undup
// BEGIN undup
h q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
cx q[3], q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
h q[4];
// END undup
// BEGIN unlifted_x
h q[2];
t q[2];
cx q[7], q[2];
x q[2];
inv @ t q[2];
cx q[5], q[2];
t q[2];
cx q[7], q[2];
x q[2];
inv @ t q[2];
h q[2];
// END unlifted_x
// BEGIN lifted_x
h q[2];
t q[2];
cx q[7], q[2];
x q[2];
inv @ t q[2];
cx q[5], q[2];
t q[2];
cx q[7], q[2];
x q[2];
inv @ t q[2];
h q[2];
// END lifted_x
// BEGIN dup
h q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
cx q[3], q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
h q[4];
// END dup
// BEGIN dup
h q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[1], q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
h q[6];
// END dup
// BEGIN dup
h q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
cx q[0], q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
h q[8];
// END dup
ctrl(1) @ ry(0.0) q[8], q[9]; // inplace_rot
// BEGIN undup
h q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
cx q[0], q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
h q[8];
// END undup
// BEGIN undup
h q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[1], q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
h q[6];
// END undup
// BEGIN undup
h q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
cx q[3], q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
h q[4];
// END undup
// BEGIN unlifted_x
h q[2];
t q[2];
cx q[7], q[2];
x q[2];
inv @ t q[2];
cx q[5], q[2];
t q[2];
cx q[7], q[2];
x q[2];
inv @ t q[2];
h q[2];
// END unlifted_x
// BEGIN dup
s q[2];
h q[2];
cx q[5], q[2];
x q[2];
t q[2];
cx q[7], q[2];
inv @ t q[2];
cx q[5], q[2];
x q[2];
t q[2];
cx q[7], q[2];
inv @ t q[2];
h q[2];
sdg q[2];
// END dup
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
// BEGIN dup
s q[6];
h q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
h q[6];
sdg q[6];
// END dup
// BEGIN dup
s q[8];
h q[8];
cx q[0], q[8];
x q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
cx q[0], q[8];
x q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
h q[8];
sdg q[8];
// END dup
ctrl(1) @ ry(3.840241138254723e-16) q[8], q[9]; // inplace_rot
// BEGIN undup
s q[8];
h q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
cx q[0], q[8];
x q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
cx q[0], q[8];
x q[8];
h q[8];
sdg q[8];
// END undup
// BEGIN undup
s q[6];
h q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
h q[6];
sdg q[6];
// END undup
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
// BEGIN undup
s q[2];
h q[2];
t q[2];
cx q[7], q[2];
inv @ t q[2];
cx q[5], q[2];
x q[2];
t q[2];
cx q[7], q[2];
inv @ t q[2];
cx q[5], q[2];
x q[2];
h q[2];
sdg q[2];
// END undup
// BEGIN dup
s q[2];
h q[2];
cx q[5], q[2];
x q[2];
t q[2];
cx q[7], q[2];
inv @ t q[2];
cx q[5], q[2];
x q[2];
t q[2];
cx q[7], q[2];
inv @ t q[2];
h q[2];
sdg q[2];
// END dup
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
// BEGIN dup
s q[6];
h q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
h q[6];
sdg q[6];
// END dup
// BEGIN dup
h q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
cx q[0], q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
h q[8];
// END dup
ctrl(1) @ ry(0.0) q[8], q[9]; // inplace_rot
// BEGIN undup
h q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
cx q[0], q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
h q[8];
// END undup
// BEGIN undup
s q[6];
h q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
h q[6];
sdg q[6];
// END undup
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
// BEGIN undup
s q[2];
h q[2];
t q[2];
cx q[7], q[2];
inv @ t q[2];
cx q[5], q[2];
x q[2];
t q[2];
cx q[7], q[2];
inv @ t q[2];
cx q[5], q[2];
x q[2];
h q[2];
sdg q[2];
// END undup
// BEGIN dup
s q[2];
h q[2];
cx q[5], q[2];
x q[2];
t q[2];
cx q[7], q[2];
inv @ t q[2];
cx q[5], q[2];
x q[2];
t q[2];
cx q[7], q[2];
inv @ t q[2];
h q[2];
sdg q[2];
// END dup
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
// BEGIN dup
h q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[1], q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
h q[6];
// END dup
// BEGIN dup
s q[8];
h q[8];
cx q[0], q[8];
x q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
cx q[0], q[8];
x q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
h q[8];
sdg q[8];
// END dup
ctrl(1) @ ry(0.0) q[8], q[9]; // inplace_rot
// BEGIN undup
s q[8];
h q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
cx q[0], q[8];
x q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
cx q[0], q[8];
x q[8];
h q[8];
sdg q[8];
// END undup
// BEGIN undup
h q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[1], q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
h q[6];
// END undup
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
// BEGIN undup
s q[2];
h q[2];
t q[2];
cx q[7], q[2];
inv @ t q[2];
cx q[5], q[2];
x q[2];
t q[2];
cx q[7], q[2];
inv @ t q[2];
cx q[5], q[2];
x q[2];
h q[2];
sdg q[2];
// END undup
// BEGIN dup
s q[2];
h q[2];
cx q[5], q[2];
x q[2];
t q[2];
cx q[7], q[2];
inv @ t q[2];
cx q[5], q[2];
x q[2];
t q[2];
cx q[7], q[2];
inv @ t q[2];
h q[2];
sdg q[2];
// END dup
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
// BEGIN dup
h q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[1], q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
h q[6];
// END dup
// BEGIN dup
h q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
cx q[0], q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
h q[8];
// END dup
ctrl(1) @ ry(0.0) q[8], q[9]; // inplace_rot
// BEGIN undup
h q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
cx q[0], q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
h q[8];
// END undup
// BEGIN undup
h q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[1], q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
h q[6];
// END undup
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
// BEGIN undup
s q[2];
h q[2];
t q[2];
cx q[7], q[2];
inv @ t q[2];
cx q[5], q[2];
x q[2];
t q[2];
cx q[7], q[2];
inv @ t q[2];
cx q[5], q[2];
x q[2];
h q[2];
sdg q[2];
// END undup
// BEGIN dup
s q[2];
h q[2];
cx q[5], q[2];
x q[2];
t q[2];
cx q[7], q[2];
inv @ t q[2];
cx q[5], q[2];
x q[2];
t q[2];
cx q[7], q[2];
inv @ t q[2];
h q[2];
sdg q[2];
// END dup
// BEGIN dup
h q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
cx q[3], q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
h q[4];
// END dup
// BEGIN dup
s q[6];
h q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
h q[6];
sdg q[6];
// END dup
// BEGIN dup
s q[8];
h q[8];
cx q[0], q[8];
x q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
cx q[0], q[8];
x q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
h q[8];
sdg q[8];
// END dup
ctrl(1) @ ry(0.0) q[8], q[9]; // inplace_rot
// BEGIN undup
s q[8];
h q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
cx q[0], q[8];
x q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
cx q[0], q[8];
x q[8];
h q[8];
sdg q[8];
// END undup
// BEGIN undup
s q[6];
h q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
h q[6];
sdg q[6];
// END undup
// BEGIN undup
h q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
cx q[3], q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
h q[4];
// END undup
// BEGIN undup
s q[2];
h q[2];
t q[2];
cx q[7], q[2];
inv @ t q[2];
cx q[5], q[2];
x q[2];
t q[2];
cx q[7], q[2];
inv @ t q[2];
cx q[5], q[2];
x q[2];
h q[2];
sdg q[2];
// END undup
// BEGIN dup
s q[2];
h q[2];
cx q[5], q[2];
x q[2];
t q[2];
cx q[7], q[2];
inv @ t q[2];
cx q[5], q[2];
x q[2];
t q[2];
cx q[7], q[2];
inv @ t q[2];
h q[2];
sdg q[2];
// END dup
// BEGIN dup
h q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
cx q[3], q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
h q[4];
// END dup
// BEGIN dup
s q[6];
h q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
h q[6];
sdg q[6];
// END dup
// BEGIN dup
h q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
cx q[0], q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
h q[8];
// END dup
ctrl(1) @ ry(0.0) q[8], q[9]; // inplace_rot
// BEGIN undup
h q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
cx q[0], q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
h q[8];
// END undup
// BEGIN undup
s q[6];
h q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
h q[6];
sdg q[6];
// END undup
// BEGIN undup
h q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
cx q[3], q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
h q[4];
// END undup
// BEGIN undup
s q[2];
h q[2];
t q[2];
cx q[7], q[2];
inv @ t q[2];
cx q[5], q[2];
x q[2];
t q[2];
cx q[7], q[2];
inv @ t q[2];
cx q[5], q[2];
x q[2];
h q[2];
sdg q[2];
// END undup
// BEGIN dup
s q[2];
h q[2];
cx q[5], q[2];
x q[2];
t q[2];
cx q[7], q[2];
inv @ t q[2];
cx q[5], q[2];
x q[2];
t q[2];
cx q[7], q[2];
inv @ t q[2];
h q[2];
sdg q[2];
// END dup
// BEGIN dup
h q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
cx q[3], q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
h q[4];
// END dup
// BEGIN dup
h q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[1], q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
h q[6];
// END dup
// BEGIN dup
s q[8];
h q[8];
cx q[0], q[8];
x q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
cx q[0], q[8];
x q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
h q[8];
sdg q[8];
// END dup
ctrl(1) @ ry(0.0) q[8], q[9]; // inplace_rot
// BEGIN undup
s q[8];
h q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
cx q[0], q[8];
x q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
cx q[0], q[8];
x q[8];
h q[8];
sdg q[8];
// END undup
// BEGIN undup
h q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[1], q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
h q[6];
// END undup
// BEGIN undup
h q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
cx q[3], q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
h q[4];
// END undup
// BEGIN undup
s q[2];
h q[2];
t q[2];
cx q[7], q[2];
inv @ t q[2];
cx q[5], q[2];
x q[2];
t q[2];
cx q[7], q[2];
inv @ t q[2];
cx q[5], q[2];
x q[2];
h q[2];
sdg q[2];
// END undup
// BEGIN dup
s q[2];
h q[2];
cx q[5], q[2];
x q[2];
t q[2];
cx q[7], q[2];
inv @ t q[2];
cx q[5], q[2];
x q[2];
t q[2];
cx q[7], q[2];
inv @ t q[2];
h q[2];
sdg q[2];
// END dup
// BEGIN dup
h q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
cx q[3], q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
h q[4];
// END dup
// BEGIN dup
h q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[1], q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
h q[6];
// END dup
// BEGIN dup
h q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
cx q[0], q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
h q[8];
// END dup
ctrl(1) @ ry(0.0) q[8], q[9]; // inplace_rot
// BEGIN undup
h q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
cx q[0], q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
h q[8];
// END undup
// BEGIN undup
h q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[1], q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
h q[6];
// END undup
// BEGIN undup
h q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
cx q[3], q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
h q[4];
// END undup
// BEGIN undup
s q[2];
h q[2];
t q[2];
cx q[7], q[2];
inv @ t q[2];
cx q[5], q[2];
x q[2];
t q[2];
cx q[7], q[2];
inv @ t q[2];
cx q[5], q[2];
x q[2];
h q[2];
sdg q[2];
// END undup
// BEGIN dup
h q[2];
t q[2];
cx q[7], q[2];
inv @ t q[2];
cx q[5], q[2];
t q[2];
cx q[7], q[2];
inv @ t q[2];
h q[2];
// END dup
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
// BEGIN dup
s q[6];
h q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
h q[6];
sdg q[6];
// END dup
// BEGIN dup
s q[8];
h q[8];
cx q[0], q[8];
x q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
cx q[0], q[8];
x q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
h q[8];
sdg q[8];
// END dup
ctrl(1) @ ry(0.0) q[8], q[9]; // inplace_rot
// BEGIN undup
s q[8];
h q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
cx q[0], q[8];
x q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
cx q[0], q[8];
x q[8];
h q[8];
sdg q[8];
// END undup
// BEGIN undup
s q[6];
h q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
h q[6];
sdg q[6];
// END undup
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
// BEGIN undup
h q[2];
t q[2];
cx q[7], q[2];
inv @ t q[2];
cx q[5], q[2];
t q[2];
cx q[7], q[2];
inv @ t q[2];
h q[2];
// END undup
// BEGIN dup
h q[2];
t q[2];
cx q[7], q[2];
inv @ t q[2];
cx q[5], q[2];
t q[2];
cx q[7], q[2];
inv @ t q[2];
h q[2];
// END dup
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
// BEGIN dup
s q[6];
h q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
h q[6];
sdg q[6];
// END dup
// BEGIN dup
h q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
cx q[0], q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
h q[8];
// END dup
ctrl(1) @ ry(0.0) q[8], q[9]; // inplace_rot
// BEGIN undup
h q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
cx q[0], q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
h q[8];
// END undup
// BEGIN undup
s q[6];
h q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
h q[6];
sdg q[6];
// END undup
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
// BEGIN undup
h q[2];
t q[2];
cx q[7], q[2];
inv @ t q[2];
cx q[5], q[2];
t q[2];
cx q[7], q[2];
inv @ t q[2];
h q[2];
// END undup
// BEGIN dup
h q[2];
t q[2];
cx q[7], q[2];
inv @ t q[2];
cx q[5], q[2];
t q[2];
cx q[7], q[2];
inv @ t q[2];
h q[2];
// END dup
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
// BEGIN dup
h q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[1], q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
h q[6];
// END dup
// BEGIN dup
s q[8];
h q[8];
cx q[0], q[8];
x q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
cx q[0], q[8];
x q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
h q[8];
sdg q[8];
// END dup
ctrl(1) @ ry(0.0) q[8], q[9]; // inplace_rot
// BEGIN undup
s q[8];
h q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
cx q[0], q[8];
x q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
cx q[0], q[8];
x q[8];
h q[8];
sdg q[8];
// END undup
// BEGIN undup
h q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[1], q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
h q[6];
// END undup
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
// BEGIN undup
h q[2];
t q[2];
cx q[7], q[2];
inv @ t q[2];
cx q[5], q[2];
t q[2];
cx q[7], q[2];
inv @ t q[2];
h q[2];
// END undup
// BEGIN dup
h q[2];
t q[2];
cx q[7], q[2];
inv @ t q[2];
cx q[5], q[2];
t q[2];
cx q[7], q[2];
inv @ t q[2];
h q[2];
// END dup
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
// BEGIN dup
h q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[1], q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
h q[6];
// END dup
// BEGIN dup
h q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
cx q[0], q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
h q[8];
// END dup
ctrl(1) @ ry(0.0) q[8], q[9]; // inplace_rot
// BEGIN undup
h q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
cx q[0], q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
h q[8];
// END undup
// BEGIN undup
h q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[1], q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
h q[6];
// END undup
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
// BEGIN undup
h q[2];
t q[2];
cx q[7], q[2];
inv @ t q[2];
cx q[5], q[2];
t q[2];
cx q[7], q[2];
inv @ t q[2];
h q[2];
// END undup
// BEGIN dup
h q[2];
t q[2];
cx q[7], q[2];
inv @ t q[2];
cx q[5], q[2];
t q[2];
cx q[7], q[2];
inv @ t q[2];
h q[2];
// END dup
// BEGIN dup
h q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
cx q[3], q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
h q[4];
// END dup
// BEGIN dup
s q[6];
h q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
h q[6];
sdg q[6];
// END dup
// BEGIN dup
s q[8];
h q[8];
cx q[0], q[8];
x q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
cx q[0], q[8];
x q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
h q[8];
sdg q[8];
// END dup
ctrl(1) @ ry(0.0) q[8], q[9]; // inplace_rot
// BEGIN undup
s q[8];
h q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
cx q[0], q[8];
x q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
cx q[0], q[8];
x q[8];
h q[8];
sdg q[8];
// END undup
// BEGIN undup
s q[6];
h q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
h q[6];
sdg q[6];
// END undup
// BEGIN undup
h q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
cx q[3], q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
h q[4];
// END undup
// BEGIN undup
h q[2];
t q[2];
cx q[7], q[2];
inv @ t q[2];
cx q[5], q[2];
t q[2];
cx q[7], q[2];
inv @ t q[2];
h q[2];
// END undup
// BEGIN dup
h q[2];
t q[2];
cx q[7], q[2];
inv @ t q[2];
cx q[5], q[2];
t q[2];
cx q[7], q[2];
inv @ t q[2];
h q[2];
// END dup
// BEGIN dup
h q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
cx q[3], q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
h q[4];
// END dup
// BEGIN dup
s q[6];
h q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
h q[6];
sdg q[6];
// END dup
// BEGIN dup
h q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
cx q[0], q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
h q[8];
// END dup
ctrl(1) @ ry(0.0) q[8], q[9]; // inplace_rot
// BEGIN undup
h q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
cx q[0], q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
h q[8];
// END undup
// BEGIN undup
s q[6];
h q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
h q[6];
sdg q[6];
// END undup
// BEGIN undup
h q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
cx q[3], q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
h q[4];
// END undup
// BEGIN undup
h q[2];
t q[2];
cx q[7], q[2];
inv @ t q[2];
cx q[5], q[2];
t q[2];
cx q[7], q[2];
inv @ t q[2];
h q[2];
// END undup
// BEGIN dup
h q[2];
t q[2];
cx q[7], q[2];
inv @ t q[2];
cx q[5], q[2];
t q[2];
cx q[7], q[2];
inv @ t q[2];
h q[2];
// END dup
// BEGIN dup
h q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
cx q[3], q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
h q[4];
// END dup
// BEGIN dup
h q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[1], q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
h q[6];
// END dup
// BEGIN dup
s q[8];
h q[8];
cx q[0], q[8];
x q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
cx q[0], q[8];
x q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
h q[8];
sdg q[8];
// END dup
ctrl(1) @ ry(0.0) q[8], q[9]; // inplace_rot
// BEGIN undup
s q[8];
h q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
cx q[0], q[8];
x q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
cx q[0], q[8];
x q[8];
h q[8];
sdg q[8];
// END undup
// BEGIN undup
h q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[1], q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
h q[6];
// END undup
// BEGIN undup
h q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
cx q[3], q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
h q[4];
// END undup
// BEGIN undup
h q[2];
t q[2];
cx q[7], q[2];
inv @ t q[2];
cx q[5], q[2];
t q[2];
cx q[7], q[2];
inv @ t q[2];
h q[2];
// END undup
// BEGIN dup
h q[2];
t q[2];
cx q[7], q[2];
inv @ t q[2];
cx q[5], q[2];
t q[2];
cx q[7], q[2];
inv @ t q[2];
h q[2];
// END dup
// BEGIN dup
h q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
cx q[3], q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
h q[4];
// END dup
// BEGIN dup
h q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[1], q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
h q[6];
// END dup
// BEGIN dup
h q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
cx q[0], q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
h q[8];
// END dup
ctrl(1) @ ry(2.214297435588181) q[8], q[9]; // inplace_rot
// BEGIN undup
h q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
cx q[0], q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
h q[8];
// END undup
// BEGIN undup
h q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[1], q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
h q[6];
// END undup
// BEGIN undup
h q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
cx q[3], q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
h q[4];
// END undup
// BEGIN undup
h q[2];
t q[2];
cx q[7], q[2];
inv @ t q[2];
cx q[5], q[2];
t q[2];
cx q[7], q[2];
inv @ t q[2];
h q[2];
// END undup
gphase(0.0490873852123405);
p(-0.098174770424681) q[0];
x q[0]; // want_negated=True
p(0.049087385212340504) q[0];
cp(-0.09817477042468101) q[0], q[1];
x q[0]; // want_negated=False
p(0.049087385212340476) q[0];
cp(-0.09817477042468095) q[0], q[1];
// BEGIN lifted_x
s q[2];
h q[2];
cx q[0], q[2];
x q[2];
t q[2];
cx q[1], q[2];
x q[2];
inv @ t q[2];
cx q[0], q[2];
x q[2];
t q[2];
cx q[1], q[2];
x q[2];
inv @ t q[2];
h q[2];
sdg q[2];
// END lifted_x
p(0.09817477042468101) q[2];
cp(-0.19634954084936201) q[2], q[3];
// BEGIN unlifted_x
s q[2];
h q[2];
t q[2];
cx q[1], q[2];
x q[2];
inv @ t q[2];
cx q[0], q[2];
x q[2];
t q[2];
cx q[1], q[2];
x q[2];
inv @ t q[2];
cx q[0], q[2];
x q[2];
h q[2];
sdg q[2];
// END unlifted_x
// BEGIN lifted_x
h q[2];
t q[2];
cx q[1], q[2];
x q[2];
inv @ t q[2];
cx q[0], q[2];
t q[2];
cx q[1], q[2];
x q[2];
inv @ t q[2];
h q[2];
// END lifted_x
p(0.0) q[2];
cp(0.0) q[2], q[3];
// BEGIN unlifted_x
h q[2];
t q[2];
cx q[1], q[2];
x q[2];
inv @ t q[2];
cx q[0], q[2];
t q[2];
cx q[1], q[2];
x q[2];
inv @ t q[2];
h q[2];
// END unlifted_x
// BEGIN dup
s q[2];
h q[2];
cx q[0], q[2];
x q[2];
t q[2];
cx q[1], q[2];
inv @ t q[2];
cx q[0], q[2];
x q[2];
t q[2];
cx q[1], q[2];
inv @ t q[2];
h q[2];
sdg q[2];
// END dup
p(0.0) q[2];
cp(0.0) q[3], q[2];
// BEGIN undup
s q[2];
h q[2];
t q[2];
cx q[1], q[2];
inv @ t q[2];
cx q[0], q[2];
x q[2];
t q[2];
cx q[1], q[2];
inv @ t q[2];
cx q[0], q[2];
x q[2];
h q[2];
sdg q[2];
// END undup
// BEGIN dup
h q[2];
t q[2];
cx q[1], q[2];
inv @ t q[2];
cx q[0], q[2];
t q[2];
cx q[1], q[2];
inv @ t q[2];
h q[2];
// END dup
p(0.09817477042468095) q[2];
cp(-0.1963495408493619) q[2], q[3];
// BEGIN undup
h q[2];
t q[2];
cx q[1], q[2];
inv @ t q[2];
cx q[0], q[2];
t q[2];
cx q[1], q[2];
inv @ t q[2];
h q[2];
// END undup
// BEGIN lifted_x
s q[2];
h q[2];
cx q[1], q[2];
x q[2];
t q[2];
cx q[3], q[2];
x q[2];
inv @ t q[2];
cx q[1], q[2];
x q[2];
t q[2];
cx q[3], q[2];
x q[2];
inv @ t q[2];
h q[2];
sdg q[2];
// END lifted_x
// BEGIN dup
s q[4];
h q[4];
cx q[0], q[4];
x q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
cx q[0], q[4];
x q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
h q[4];
sdg q[4];
// END dup
p(0.19634954084936201) q[4];
cp(-0.39269908169872403) q[5], q[4];
// BEGIN undup
s q[4];
h q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
cx q[0], q[4];
x q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
cx q[0], q[4];
x q[4];
h q[4];
sdg q[4];
// END undup
// BEGIN unlifted_x
s q[2];
h q[2];
t q[2];
cx q[3], q[2];
x q[2];
inv @ t q[2];
cx q[1], q[2];
x q[2];
t q[2];
cx q[3], q[2];
x q[2];
inv @ t q[2];
cx q[1], q[2];
x q[2];
h q[2];
sdg q[2];
// END unlifted_x
// BEGIN lifted_x
s q[2];
h q[2];
cx q[1], q[2];
x q[2];
t q[2];
cx q[3], q[2];
x q[2];
inv @ t q[2];
cx q[1], q[2];
x q[2];
t q[2];
cx q[3], q[2];
x q[2];
inv @ t q[2];
h q[2];
sdg q[2];
// END lifted_x
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
p(0.0) q[4];
cp(0.0) q[5], q[4];
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
// BEGIN unlifted_x
s q[2];
h q[2];
t q[2];
cx q[3], q[2];
x q[2];
inv @ t q[2];
cx q[1], q[2];
x q[2];
t q[2];
cx q[3], q[2];
x q[2];
inv @ t q[2];
cx q[1], q[2];
x q[2];
h q[2];
sdg q[2];
// END unlifted_x
// BEGIN lifted_x
h q[2];
t q[2];
cx q[3], q[2];
x q[2];
inv @ t q[2];
cx q[1], q[2];
t q[2];
cx q[3], q[2];
x q[2];
inv @ t q[2];
h q[2];
// END lifted_x
// BEGIN dup
s q[4];
h q[4];
cx q[0], q[4];
x q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
cx q[0], q[4];
x q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
h q[4];
sdg q[4];
// END dup
p(0.0) q[4];
cp(0.0) q[5], q[4];
// BEGIN undup
s q[4];
h q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
cx q[0], q[4];
x q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
cx q[0], q[4];
x q[4];
h q[4];
sdg q[4];
// END undup
// BEGIN unlifted_x
h q[2];
t q[2];
cx q[3], q[2];
x q[2];
inv @ t q[2];
cx q[1], q[2];
t q[2];
cx q[3], q[2];
x q[2];
inv @ t q[2];
h q[2];
// END unlifted_x
// BEGIN lifted_x
h q[2];
t q[2];
cx q[3], q[2];
x q[2];
inv @ t q[2];
cx q[1], q[2];
t q[2];
cx q[3], q[2];
x q[2];
inv @ t q[2];
h q[2];
// END lifted_x
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
p(0.0) q[4];
cp(0.0) q[5], q[4];
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
// BEGIN unlifted_x
h q[2];
t q[2];
cx q[3], q[2];
x q[2];
inv @ t q[2];
cx q[1], q[2];
t q[2];
cx q[3], q[2];
x q[2];
inv @ t q[2];
h q[2];
// END unlifted_x
// BEGIN dup
s q[2];
h q[2];
cx q[1], q[2];
x q[2];
t q[2];
cx q[3], q[2];
inv @ t q[2];
cx q[1], q[2];
x q[2];
t q[2];
cx q[3], q[2];
inv @ t q[2];
h q[2];
sdg q[2];
// END dup
// BEGIN dup
s q[4];
h q[4];
cx q[0], q[4];
x q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
cx q[0], q[4];
x q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
h q[4];
sdg q[4];
// END dup
p(0.0) q[4];
cp(0.0) q[4], q[5];
// BEGIN undup
s q[4];
h q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
cx q[0], q[4];
x q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
cx q[0], q[4];
x q[4];
h q[4];
sdg q[4];
// END undup
// BEGIN undup
s q[2];
h q[2];
t q[2];
cx q[3], q[2];
inv @ t q[2];
cx q[1], q[2];
x q[2];
t q[2];
cx q[3], q[2];
inv @ t q[2];
cx q[1], q[2];
x q[2];
h q[2];
sdg q[2];
// END undup
// BEGIN dup
s q[2];
h q[2];
cx q[1], q[2];
x q[2];
t q[2];
cx q[3], q[2];
inv @ t q[2];
cx q[1], q[2];
x q[2];
t q[2];
cx q[3], q[2];
inv @ t q[2];
h q[2];
sdg q[2];
// END dup
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
p(0.0) q[4];
cp(0.0) q[4], q[5];
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
// BEGIN undup
s q[2];
h q[2];
t q[2];
cx q[3], q[2];
inv @ t q[2];
cx q[1], q[2];
x q[2];
t q[2];
cx q[3], q[2];
inv @ t q[2];
cx q[1], q[2];
x q[2];
h q[2];
sdg q[2];
// END undup
// BEGIN dup
h q[2];
t q[2];
cx q[3], q[2];
inv @ t q[2];
cx q[1], q[2];
t q[2];
cx q[3], q[2];
inv @ t q[2];
h q[2];
// END dup
// BEGIN dup
s q[4];
h q[4];
cx q[0], q[4];
x q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
cx q[0], q[4];
x q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
h q[4];
sdg q[4];
// END dup
p(0.0) q[4];
cp(0.0) q[4], q[5];
// BEGIN undup
s q[4];
h q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
cx q[0], q[4];
x q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
cx q[0], q[4];
x q[4];
h q[4];
sdg q[4];
// END undup
// BEGIN undup
h q[2];
t q[2];
cx q[3], q[2];
inv @ t q[2];
cx q[1], q[2];
t q[2];
cx q[3], q[2];
inv @ t q[2];
h q[2];
// END undup
// BEGIN dup
h q[2];
t q[2];
cx q[3], q[2];
inv @ t q[2];
cx q[1], q[2];
t q[2];
cx q[3], q[2];
inv @ t q[2];
h q[2];
// END dup
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
p(0.1963495408493619) q[4];
cp(-0.3926990816987238) q[4], q[5];
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
// BEGIN undup
h q[2];
t q[2];
cx q[3], q[2];
inv @ t q[2];
cx q[1], q[2];
t q[2];
cx q[3], q[2];
inv @ t q[2];
h q[2];
// END undup
// BEGIN lifted_x
s q[2];
h q[2];
cx q[3], q[2];
x q[2];
t q[2];
cx q[5], q[2];
x q[2];
inv @ t q[2];
cx q[3], q[2];
x q[2];
t q[2];
cx q[5], q[2];
x q[2];
inv @ t q[2];
h q[2];
sdg q[2];
// END lifted_x
// BEGIN dup
s q[4];
h q[4];
cx q[1], q[4];
x q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
cx q[1], q[4];
x q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
h q[4];
sdg q[4];
// END dup
// BEGIN dup
s q[6];
h q[6];
cx q[0], q[6];
x q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[0], q[6];
x q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
h q[6];
sdg q[6];
// END dup
p(-0.39269908169872414) q[6];
cp(0.7853981633974483) q[6], q[7];
// BEGIN undup
s q[6];
h q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[0], q[6];
x q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[0], q[6];
x q[6];
h q[6];
sdg q[6];
// END undup
// BEGIN undup
s q[4];
h q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
cx q[1], q[4];
x q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
cx q[1], q[4];
x q[4];
h q[4];
sdg q[4];
// END undup
// BEGIN unlifted_x
s q[2];
h q[2];
t q[2];
cx q[5], q[2];
x q[2];
inv @ t q[2];
cx q[3], q[2];
x q[2];
t q[2];
cx q[5], q[2];
x q[2];
inv @ t q[2];
cx q[3], q[2];
x q[2];
h q[2];
sdg q[2];
// END unlifted_x
// BEGIN lifted_x
s q[2];
h q[2];
cx q[3], q[2];
x q[2];
t q[2];
cx q[5], q[2];
x q[2];
inv @ t q[2];
cx q[3], q[2];
x q[2];
t q[2];
cx q[5], q[2];
x q[2];
inv @ t q[2];
h q[2];
sdg q[2];
// END lifted_x
// BEGIN dup
s q[4];
h q[4];
cx q[1], q[4];
x q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
cx q[1], q[4];
x q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
h q[4];
sdg q[4];
// END dup
// BEGIN dup
h q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[0], q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
h q[6];
// END dup
p(0.0) q[6];
cp(0.0) q[6], q[7];
// BEGIN undup
h q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[0], q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
h q[6];
// END undup
// BEGIN undup
s q[4];
h q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
cx q[1], q[4];
x q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
cx q[1], q[4];
x q[4];
h q[4];
sdg q[4];
// END undup
// BEGIN unlifted_x
s q[2];
h q[2];
t q[2];
cx q[5], q[2];
x q[2];
inv @ t q[2];
cx q[3], q[2];
x q[2];
t q[2];
cx q[5], q[2];
x q[2];
inv @ t q[2];
cx q[3], q[2];
x q[2];
h q[2];
sdg q[2];
// END unlifted_x
// BEGIN lifted_x
s q[2];
h q[2];
cx q[3], q[2];
x q[2];
t q[2];
cx q[5], q[2];
x q[2];
inv @ t q[2];
cx q[3], q[2];
x q[2];
t q[2];
cx q[5], q[2];
x q[2];
inv @ t q[2];
h q[2];
sdg q[2];
// END lifted_x
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
// BEGIN dup
s q[6];
h q[6];
cx q[0], q[6];
x q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[0], q[6];
x q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
h q[6];
sdg q[6];
// END dup
p(0.0) q[6];
cp(0.0) q[7], q[6];
// BEGIN undup
s q[6];
h q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[0], q[6];
x q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[0], q[6];
x q[6];
h q[6];
sdg q[6];
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
// BEGIN unlifted_x
s q[2];
h q[2];
t q[2];
cx q[5], q[2];
x q[2];
inv @ t q[2];
cx q[3], q[2];
x q[2];
t q[2];
cx q[5], q[2];
x q[2];
inv @ t q[2];
cx q[3], q[2];
x q[2];
h q[2];
sdg q[2];
// END unlifted_x
// BEGIN lifted_x
s q[2];
h q[2];
cx q[3], q[2];
x q[2];
t q[2];
cx q[5], q[2];
x q[2];
inv @ t q[2];
cx q[3], q[2];
x q[2];
t q[2];
cx q[5], q[2];
x q[2];
inv @ t q[2];
h q[2];
sdg q[2];
// END lifted_x
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
// BEGIN dup
h q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[0], q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
h q[6];
// END dup
p(0.0) q[6];
cp(0.0) q[6], q[7];
// BEGIN undup
h q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[0], q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
h q[6];
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
// BEGIN unlifted_x
s q[2];
h q[2];
t q[2];
cx q[5], q[2];
x q[2];
inv @ t q[2];
cx q[3], q[2];
x q[2];
t q[2];
cx q[5], q[2];
x q[2];
inv @ t q[2];
cx q[3], q[2];
x q[2];
h q[2];
sdg q[2];
// END unlifted_x
// BEGIN lifted_x
h q[2];
t q[2];
cx q[5], q[2];
x q[2];
inv @ t q[2];
cx q[3], q[2];
t q[2];
cx q[5], q[2];
x q[2];
inv @ t q[2];
h q[2];
// END lifted_x
// BEGIN dup
s q[4];
h q[4];
cx q[1], q[4];
x q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
cx q[1], q[4];
x q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
h q[4];
sdg q[4];
// END dup
// BEGIN dup
s q[6];
h q[6];
cx q[0], q[6];
x q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[0], q[6];
x q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
h q[6];
sdg q[6];
// END dup
p(0.0) q[6];
cp(0.0) q[7], q[6];
// BEGIN undup
s q[6];
h q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[0], q[6];
x q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[0], q[6];
x q[6];
h q[6];
sdg q[6];
// END undup
// BEGIN undup
s q[4];
h q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
cx q[1], q[4];
x q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
cx q[1], q[4];
x q[4];
h q[4];
sdg q[4];
// END undup
// BEGIN unlifted_x
h q[2];
t q[2];
cx q[5], q[2];
x q[2];
inv @ t q[2];
cx q[3], q[2];
t q[2];
cx q[5], q[2];
x q[2];
inv @ t q[2];
h q[2];
// END unlifted_x
// BEGIN lifted_x
h q[2];
t q[2];
cx q[5], q[2];
x q[2];
inv @ t q[2];
cx q[3], q[2];
t q[2];
cx q[5], q[2];
x q[2];
inv @ t q[2];
h q[2];
// END lifted_x
// BEGIN dup
s q[4];
h q[4];
cx q[1], q[4];
x q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
cx q[1], q[4];
x q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
h q[4];
sdg q[4];
// END dup
// BEGIN dup
h q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[0], q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
h q[6];
// END dup
p(0.0) q[6];
cp(0.0) q[7], q[6];
// BEGIN undup
h q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[0], q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
h q[6];
// END undup
// BEGIN undup
s q[4];
h q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
cx q[1], q[4];
x q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
cx q[1], q[4];
x q[4];
h q[4];
sdg q[4];
// END undup
// BEGIN unlifted_x
h q[2];
t q[2];
cx q[5], q[2];
x q[2];
inv @ t q[2];
cx q[3], q[2];
t q[2];
cx q[5], q[2];
x q[2];
inv @ t q[2];
h q[2];
// END unlifted_x
// BEGIN lifted_x
h q[2];
t q[2];
cx q[5], q[2];
x q[2];
inv @ t q[2];
cx q[3], q[2];
t q[2];
cx q[5], q[2];
x q[2];
inv @ t q[2];
h q[2];
// END lifted_x
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
// BEGIN dup
s q[6];
h q[6];
cx q[0], q[6];
x q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[0], q[6];
x q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
h q[6];
sdg q[6];
// END dup
p(0.0) q[6];
cp(0.0) q[7], q[6];
// BEGIN undup
s q[6];
h q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[0], q[6];
x q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[0], q[6];
x q[6];
h q[6];
sdg q[6];
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
// BEGIN unlifted_x
h q[2];
t q[2];
cx q[5], q[2];
x q[2];
inv @ t q[2];
cx q[3], q[2];
t q[2];
cx q[5], q[2];
x q[2];
inv @ t q[2];
h q[2];
// END unlifted_x
// BEGIN lifted_x
h q[2];
t q[2];
cx q[5], q[2];
x q[2];
inv @ t q[2];
cx q[3], q[2];
t q[2];
cx q[5], q[2];
x q[2];
inv @ t q[2];
h q[2];
// END lifted_x
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
// BEGIN dup
h q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[0], q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
h q[6];
// END dup
p(0.0) q[6];
cp(0.0) q[6], q[7];
// BEGIN undup
h q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[0], q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
h q[6];
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
// BEGIN unlifted_x
h q[2];
t q[2];
cx q[5], q[2];
x q[2];
inv @ t q[2];
cx q[3], q[2];
t q[2];
cx q[5], q[2];
x q[2];
inv @ t q[2];
h q[2];
// END unlifted_x
// BEGIN dup
s q[2];
h q[2];
cx q[3], q[2];
x q[2];
t q[2];
cx q[5], q[2];
inv @ t q[2];
cx q[3], q[2];
x q[2];
t q[2];
cx q[5], q[2];
inv @ t q[2];
h q[2];
sdg q[2];
// END dup
// BEGIN dup
s q[4];
h q[4];
cx q[1], q[4];
x q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
cx q[1], q[4];
x q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
h q[4];
sdg q[4];
// END dup
// BEGIN dup
s q[6];
h q[6];
cx q[0], q[6];
x q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[0], q[6];
x q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
h q[6];
sdg q[6];
// END dup
p(0.0) q[6];
cp(0.0) q[7], q[6];
// BEGIN undup
s q[6];
h q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[0], q[6];
x q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[0], q[6];
x q[6];
h q[6];
sdg q[6];
// END undup
// BEGIN undup
s q[4];
h q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
cx q[1], q[4];
x q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
cx q[1], q[4];
x q[4];
h q[4];
sdg q[4];
// END undup
// BEGIN undup
s q[2];
h q[2];
t q[2];
cx q[5], q[2];
inv @ t q[2];
cx q[3], q[2];
x q[2];
t q[2];
cx q[5], q[2];
inv @ t q[2];
cx q[3], q[2];
x q[2];
h q[2];
sdg q[2];
// END undup
// BEGIN dup
s q[2];
h q[2];
cx q[3], q[2];
x q[2];
t q[2];
cx q[5], q[2];
inv @ t q[2];
cx q[3], q[2];
x q[2];
t q[2];
cx q[5], q[2];
inv @ t q[2];
h q[2];
sdg q[2];
// END dup
// BEGIN dup
s q[4];
h q[4];
cx q[1], q[4];
x q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
cx q[1], q[4];
x q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
h q[4];
sdg q[4];
// END dup
// BEGIN dup
h q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[0], q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
h q[6];
// END dup
p(0.0) q[6];
cp(0.0) q[7], q[6];
// BEGIN undup
h q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[0], q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
h q[6];
// END undup
// BEGIN undup
s q[4];
h q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
cx q[1], q[4];
x q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
cx q[1], q[4];
x q[4];
h q[4];
sdg q[4];
// END undup
// BEGIN undup
s q[2];
h q[2];
t q[2];
cx q[5], q[2];
inv @ t q[2];
cx q[3], q[2];
x q[2];
t q[2];
cx q[5], q[2];
inv @ t q[2];
cx q[3], q[2];
x q[2];
h q[2];
sdg q[2];
// END undup
// BEGIN dup
s q[2];
h q[2];
cx q[3], q[2];
x q[2];
t q[2];
cx q[5], q[2];
inv @ t q[2];
cx q[3], q[2];
x q[2];
t q[2];
cx q[5], q[2];
inv @ t q[2];
h q[2];
sdg q[2];
// END dup
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
// BEGIN dup
s q[6];
h q[6];
cx q[0], q[6];
x q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[0], q[6];
x q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
h q[6];
sdg q[6];
// END dup
p(0.0) q[6];
cp(0.0) q[7], q[6];
// BEGIN undup
s q[6];
h q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[0], q[6];
x q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[0], q[6];
x q[6];
h q[6];
sdg q[6];
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
// BEGIN undup
s q[2];
h q[2];
t q[2];
cx q[5], q[2];
inv @ t q[2];
cx q[3], q[2];
x q[2];
t q[2];
cx q[5], q[2];
inv @ t q[2];
cx q[3], q[2];
x q[2];
h q[2];
sdg q[2];
// END undup
// BEGIN dup
s q[2];
h q[2];
cx q[3], q[2];
x q[2];
t q[2];
cx q[5], q[2];
inv @ t q[2];
cx q[3], q[2];
x q[2];
t q[2];
cx q[5], q[2];
inv @ t q[2];
h q[2];
sdg q[2];
// END dup
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
// BEGIN dup
h q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[0], q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
h q[6];
// END dup
p(0.0) q[6];
cp(0.0) q[6], q[7];
// BEGIN undup
h q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[0], q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
h q[6];
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
// BEGIN undup
s q[2];
h q[2];
t q[2];
cx q[5], q[2];
inv @ t q[2];
cx q[3], q[2];
x q[2];
t q[2];
cx q[5], q[2];
inv @ t q[2];
cx q[3], q[2];
x q[2];
h q[2];
sdg q[2];
// END undup
// BEGIN dup
h q[2];
t q[2];
cx q[5], q[2];
inv @ t q[2];
cx q[3], q[2];
t q[2];
cx q[5], q[2];
inv @ t q[2];
h q[2];
// END dup
// BEGIN dup
s q[4];
h q[4];
cx q[1], q[4];
x q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
cx q[1], q[4];
x q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
h q[4];
sdg q[4];
// END dup
// BEGIN dup
s q[6];
h q[6];
cx q[0], q[6];
x q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[0], q[6];
x q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
h q[6];
sdg q[6];
// END dup
p(0.0) q[6];
cp(0.0) q[7], q[6];
// BEGIN undup
s q[6];
h q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[0], q[6];
x q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[0], q[6];
x q[6];
h q[6];
sdg q[6];
// END undup
// BEGIN undup
s q[4];
h q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
cx q[1], q[4];
x q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
cx q[1], q[4];
x q[4];
h q[4];
sdg q[4];
// END undup
// BEGIN undup
h q[2];
t q[2];
cx q[5], q[2];
inv @ t q[2];
cx q[3], q[2];
t q[2];
cx q[5], q[2];
inv @ t q[2];
h q[2];
// END undup
// BEGIN dup
h q[2];
t q[2];
cx q[5], q[2];
inv @ t q[2];
cx q[3], q[2];
t q[2];
cx q[5], q[2];
inv @ t q[2];
h q[2];
// END dup
// BEGIN dup
s q[4];
h q[4];
cx q[1], q[4];
x q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
cx q[1], q[4];
x q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
h q[4];
sdg q[4];
// END dup
// BEGIN dup
h q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[0], q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
h q[6];
// END dup
p(0.0) q[6];
cp(0.0) q[7], q[6];
// BEGIN undup
h q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[0], q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
h q[6];
// END undup
// BEGIN undup
s q[4];
h q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
cx q[1], q[4];
x q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
cx q[1], q[4];
x q[4];
h q[4];
sdg q[4];
// END undup
// BEGIN undup
h q[2];
t q[2];
cx q[5], q[2];
inv @ t q[2];
cx q[3], q[2];
t q[2];
cx q[5], q[2];
inv @ t q[2];
h q[2];
// END undup
// BEGIN dup
h q[2];
t q[2];
cx q[5], q[2];
inv @ t q[2];
cx q[3], q[2];
t q[2];
cx q[5], q[2];
inv @ t q[2];
h q[2];
// END dup
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
// BEGIN dup
s q[6];
h q[6];
cx q[0], q[6];
x q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[0], q[6];
x q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
h q[6];
sdg q[6];
// END dup
p(0.0) q[6];
cp(0.0) q[7], q[6];
// BEGIN undup
s q[6];
h q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[0], q[6];
x q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[0], q[6];
x q[6];
h q[6];
sdg q[6];
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
// BEGIN undup
h q[2];
t q[2];
cx q[5], q[2];
inv @ t q[2];
cx q[3], q[2];
t q[2];
cx q[5], q[2];
inv @ t q[2];
h q[2];
// END undup
// BEGIN dup
h q[2];
t q[2];
cx q[5], q[2];
inv @ t q[2];
cx q[3], q[2];
t q[2];
cx q[5], q[2];
inv @ t q[2];
h q[2];
// END dup
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
// BEGIN dup
h q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[0], q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
h q[6];
// END dup
p(0.3926990816987238) q[6];
cp(-0.7853981633974476) q[6], q[7];
// BEGIN undup
h q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[0], q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
h q[6];
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
// BEGIN undup
h q[2];
t q[2];
cx q[5], q[2];
inv @ t q[2];
cx q[3], q[2];
t q[2];
cx q[5], q[2];
inv @ t q[2];
h q[2];
// END undup
// BEGIN lifted_x
s q[2];
h q[2];
cx q[5], q[2];
x q[2];
t q[2];
cx q[7], q[2];
x q[2];
inv @ t q[2];
cx q[5], q[2];
x q[2];
t q[2];
cx q[7], q[2];
x q[2];
inv @ t q[2];
h q[2];
sdg q[2];
// END lifted_x
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
// BEGIN dup
s q[6];
h q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
h q[6];
sdg q[6];
// END dup
// BEGIN dup
s q[8];
h q[8];
cx q[0], q[8];
x q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
cx q[0], q[8];
x q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
h q[8];
sdg q[8];
// END dup
p(6.245004513516506e-17) q[8];
cp(-1.249000902703301e-16) q[8], q[9];
// BEGIN undup
s q[8];
h q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
cx q[0], q[8];
x q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
cx q[0], q[8];
x q[8];
h q[8];
sdg q[8];
// END undup
// BEGIN undup
s q[6];
h q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
h q[6];
sdg q[6];
// END undup
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
// BEGIN unlifted_x
s q[2];
h q[2];
t q[2];
cx q[7], q[2];
x q[2];
inv @ t q[2];
cx q[5], q[2];
x q[2];
t q[2];
cx q[7], q[2];
x q[2];
inv @ t q[2];
cx q[5], q[2];
x q[2];
h q[2];
sdg q[2];
// END unlifted_x
// BEGIN lifted_x
s q[2];
h q[2];
cx q[5], q[2];
x q[2];
t q[2];
cx q[7], q[2];
x q[2];
inv @ t q[2];
cx q[5], q[2];
x q[2];
t q[2];
cx q[7], q[2];
x q[2];
inv @ t q[2];
h q[2];
sdg q[2];
// END lifted_x
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
// BEGIN dup
s q[6];
h q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
h q[6];
sdg q[6];
// END dup
// BEGIN dup
h q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
cx q[0], q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
h q[8];
// END dup
p(0.0) q[8];
cp(0.0) q[8], q[9];
// BEGIN undup
h q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
cx q[0], q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
h q[8];
// END undup
// BEGIN undup
s q[6];
h q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
h q[6];
sdg q[6];
// END undup
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
// BEGIN unlifted_x
s q[2];
h q[2];
t q[2];
cx q[7], q[2];
x q[2];
inv @ t q[2];
cx q[5], q[2];
x q[2];
t q[2];
cx q[7], q[2];
x q[2];
inv @ t q[2];
cx q[5], q[2];
x q[2];
h q[2];
sdg q[2];
// END unlifted_x
// BEGIN lifted_x
s q[2];
h q[2];
cx q[5], q[2];
x q[2];
t q[2];
cx q[7], q[2];
x q[2];
inv @ t q[2];
cx q[5], q[2];
x q[2];
t q[2];
cx q[7], q[2];
x q[2];
inv @ t q[2];
h q[2];
sdg q[2];
// END lifted_x
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
// BEGIN dup
h q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[1], q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
h q[6];
// END dup
// BEGIN dup
s q[8];
h q[8];
cx q[0], q[8];
x q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
cx q[0], q[8];
x q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
h q[8];
sdg q[8];
// END dup
p(0.0) q[8];
cp(0.0) q[8], q[9];
// BEGIN undup
s q[8];
h q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
cx q[0], q[8];
x q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
cx q[0], q[8];
x q[8];
h q[8];
sdg q[8];
// END undup
// BEGIN undup
h q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[1], q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
h q[6];
// END undup
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
// BEGIN unlifted_x
s q[2];
h q[2];
t q[2];
cx q[7], q[2];
x q[2];
inv @ t q[2];
cx q[5], q[2];
x q[2];
t q[2];
cx q[7], q[2];
x q[2];
inv @ t q[2];
cx q[5], q[2];
x q[2];
h q[2];
sdg q[2];
// END unlifted_x
// BEGIN lifted_x
s q[2];
h q[2];
cx q[5], q[2];
x q[2];
t q[2];
cx q[7], q[2];
x q[2];
inv @ t q[2];
cx q[5], q[2];
x q[2];
t q[2];
cx q[7], q[2];
x q[2];
inv @ t q[2];
h q[2];
sdg q[2];
// END lifted_x
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
// BEGIN dup
h q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[1], q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
h q[6];
// END dup
// BEGIN dup
h q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
cx q[0], q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
h q[8];
// END dup
p(0.0) q[8];
cp(0.0) q[9], q[8];
// BEGIN undup
h q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
cx q[0], q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
h q[8];
// END undup
// BEGIN undup
h q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[1], q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
h q[6];
// END undup
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
// BEGIN unlifted_x
s q[2];
h q[2];
t q[2];
cx q[7], q[2];
x q[2];
inv @ t q[2];
cx q[5], q[2];
x q[2];
t q[2];
cx q[7], q[2];
x q[2];
inv @ t q[2];
cx q[5], q[2];
x q[2];
h q[2];
sdg q[2];
// END unlifted_x
// BEGIN lifted_x
s q[2];
h q[2];
cx q[5], q[2];
x q[2];
t q[2];
cx q[7], q[2];
x q[2];
inv @ t q[2];
cx q[5], q[2];
x q[2];
t q[2];
cx q[7], q[2];
x q[2];
inv @ t q[2];
h q[2];
sdg q[2];
// END lifted_x
// BEGIN dup
h q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
cx q[3], q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
h q[4];
// END dup
// BEGIN dup
s q[6];
h q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
h q[6];
sdg q[6];
// END dup
// BEGIN dup
s q[8];
h q[8];
cx q[0], q[8];
x q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
cx q[0], q[8];
x q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
h q[8];
sdg q[8];
// END dup
p(0.0) q[8];
cp(0.0) q[8], q[9];
// BEGIN undup
s q[8];
h q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
cx q[0], q[8];
x q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
cx q[0], q[8];
x q[8];
h q[8];
sdg q[8];
// END undup
// BEGIN undup
s q[6];
h q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
h q[6];
sdg q[6];
// END undup
// BEGIN undup
h q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
cx q[3], q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
h q[4];
// END undup
// BEGIN unlifted_x
s q[2];
h q[2];
t q[2];
cx q[7], q[2];
x q[2];
inv @ t q[2];
cx q[5], q[2];
x q[2];
t q[2];
cx q[7], q[2];
x q[2];
inv @ t q[2];
cx q[5], q[2];
x q[2];
h q[2];
sdg q[2];
// END unlifted_x
// BEGIN lifted_x
s q[2];
h q[2];
cx q[5], q[2];
x q[2];
t q[2];
cx q[7], q[2];
x q[2];
inv @ t q[2];
cx q[5], q[2];
x q[2];
t q[2];
cx q[7], q[2];
x q[2];
inv @ t q[2];
h q[2];
sdg q[2];
// END lifted_x
// BEGIN dup
h q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
cx q[3], q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
h q[4];
// END dup
// BEGIN dup
s q[6];
h q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
h q[6];
sdg q[6];
// END dup
// BEGIN dup
h q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
cx q[0], q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
h q[8];
// END dup
p(0.0) q[8];
cp(0.0) q[8], q[9];
// BEGIN undup
h q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
cx q[0], q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
h q[8];
// END undup
// BEGIN undup
s q[6];
h q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
h q[6];
sdg q[6];
// END undup
// BEGIN undup
h q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
cx q[3], q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
h q[4];
// END undup
// BEGIN unlifted_x
s q[2];
h q[2];
t q[2];
cx q[7], q[2];
x q[2];
inv @ t q[2];
cx q[5], q[2];
x q[2];
t q[2];
cx q[7], q[2];
x q[2];
inv @ t q[2];
cx q[5], q[2];
x q[2];
h q[2];
sdg q[2];
// END unlifted_x
// BEGIN lifted_x
s q[2];
h q[2];
cx q[5], q[2];
x q[2];
t q[2];
cx q[7], q[2];
x q[2];
inv @ t q[2];
cx q[5], q[2];
x q[2];
t q[2];
cx q[7], q[2];
x q[2];
inv @ t q[2];
h q[2];
sdg q[2];
// END lifted_x
// BEGIN dup
h q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
cx q[3], q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
h q[4];
// END dup
// BEGIN dup
h q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[1], q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
h q[6];
// END dup
// BEGIN dup
s q[8];
h q[8];
cx q[0], q[8];
x q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
cx q[0], q[8];
x q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
h q[8];
sdg q[8];
// END dup
p(0.0) q[8];
cp(0.0) q[8], q[9];
// BEGIN undup
s q[8];
h q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
cx q[0], q[8];
x q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
cx q[0], q[8];
x q[8];
h q[8];
sdg q[8];
// END undup
// BEGIN undup
h q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[1], q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
h q[6];
// END undup
// BEGIN undup
h q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
cx q[3], q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
h q[4];
// END undup
// BEGIN unlifted_x
s q[2];
h q[2];
t q[2];
cx q[7], q[2];
x q[2];
inv @ t q[2];
cx q[5], q[2];
x q[2];
t q[2];
cx q[7], q[2];
x q[2];
inv @ t q[2];
cx q[5], q[2];
x q[2];
h q[2];
sdg q[2];
// END unlifted_x
// BEGIN lifted_x
s q[2];
h q[2];
cx q[5], q[2];
x q[2];
t q[2];
cx q[7], q[2];
x q[2];
inv @ t q[2];
cx q[5], q[2];
x q[2];
t q[2];
cx q[7], q[2];
x q[2];
inv @ t q[2];
h q[2];
sdg q[2];
// END lifted_x
// BEGIN dup
h q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
cx q[3], q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
h q[4];
// END dup
// BEGIN dup
h q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[1], q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
h q[6];
// END dup
// BEGIN dup
h q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
cx q[0], q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
h q[8];
// END dup
p(0.0) q[8];
cp(0.0) q[8], q[9];
// BEGIN undup
h q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
cx q[0], q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
h q[8];
// END undup
// BEGIN undup
h q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[1], q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
h q[6];
// END undup
// BEGIN undup
h q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
cx q[3], q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
h q[4];
// END undup
// BEGIN unlifted_x
s q[2];
h q[2];
t q[2];
cx q[7], q[2];
x q[2];
inv @ t q[2];
cx q[5], q[2];
x q[2];
t q[2];
cx q[7], q[2];
x q[2];
inv @ t q[2];
cx q[5], q[2];
x q[2];
h q[2];
sdg q[2];
// END unlifted_x
// BEGIN lifted_x
h q[2];
t q[2];
cx q[7], q[2];
x q[2];
inv @ t q[2];
cx q[5], q[2];
t q[2];
cx q[7], q[2];
x q[2];
inv @ t q[2];
h q[2];
// END lifted_x
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
// BEGIN dup
s q[6];
h q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
h q[6];
sdg q[6];
// END dup
// BEGIN dup
s q[8];
h q[8];
cx q[0], q[8];
x q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
cx q[0], q[8];
x q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
h q[8];
sdg q[8];
// END dup
p(0.0) q[8];
cp(0.0) q[8], q[9];
// BEGIN undup
s q[8];
h q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
cx q[0], q[8];
x q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
cx q[0], q[8];
x q[8];
h q[8];
sdg q[8];
// END undup
// BEGIN undup
s q[6];
h q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
h q[6];
sdg q[6];
// END undup
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
// BEGIN unlifted_x
h q[2];
t q[2];
cx q[7], q[2];
x q[2];
inv @ t q[2];
cx q[5], q[2];
t q[2];
cx q[7], q[2];
x q[2];
inv @ t q[2];
h q[2];
// END unlifted_x
// BEGIN lifted_x
h q[2];
t q[2];
cx q[7], q[2];
x q[2];
inv @ t q[2];
cx q[5], q[2];
t q[2];
cx q[7], q[2];
x q[2];
inv @ t q[2];
h q[2];
// END lifted_x
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
// BEGIN dup
s q[6];
h q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
h q[6];
sdg q[6];
// END dup
// BEGIN dup
h q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
cx q[0], q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
h q[8];
// END dup
p(0.0) q[8];
cp(0.0) q[8], q[9];
// BEGIN undup
h q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
cx q[0], q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
h q[8];
// END undup
// BEGIN undup
s q[6];
h q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
h q[6];
sdg q[6];
// END undup
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
// BEGIN unlifted_x
h q[2];
t q[2];
cx q[7], q[2];
x q[2];
inv @ t q[2];
cx q[5], q[2];
t q[2];
cx q[7], q[2];
x q[2];
inv @ t q[2];
h q[2];
// END unlifted_x
// BEGIN lifted_x
h q[2];
t q[2];
cx q[7], q[2];
x q[2];
inv @ t q[2];
cx q[5], q[2];
t q[2];
cx q[7], q[2];
x q[2];
inv @ t q[2];
h q[2];
// END lifted_x
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
// BEGIN dup
h q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[1], q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
h q[6];
// END dup
// BEGIN dup
s q[8];
h q[8];
cx q[0], q[8];
x q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
cx q[0], q[8];
x q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
h q[8];
sdg q[8];
// END dup
p(0.0) q[8];
cp(0.0) q[8], q[9];
// BEGIN undup
s q[8];
h q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
cx q[0], q[8];
x q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
cx q[0], q[8];
x q[8];
h q[8];
sdg q[8];
// END undup
// BEGIN undup
h q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[1], q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
h q[6];
// END undup
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
// BEGIN unlifted_x
h q[2];
t q[2];
cx q[7], q[2];
x q[2];
inv @ t q[2];
cx q[5], q[2];
t q[2];
cx q[7], q[2];
x q[2];
inv @ t q[2];
h q[2];
// END unlifted_x
// BEGIN lifted_x
h q[2];
t q[2];
cx q[7], q[2];
x q[2];
inv @ t q[2];
cx q[5], q[2];
t q[2];
cx q[7], q[2];
x q[2];
inv @ t q[2];
h q[2];
// END lifted_x
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
// BEGIN dup
h q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[1], q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
h q[6];
// END dup
// BEGIN dup
h q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
cx q[0], q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
h q[8];
// END dup
p(0.0) q[8];
cp(0.0) q[8], q[9];
// BEGIN undup
h q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
cx q[0], q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
h q[8];
// END undup
// BEGIN undup
h q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[1], q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
h q[6];
// END undup
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
// BEGIN unlifted_x
h q[2];
t q[2];
cx q[7], q[2];
x q[2];
inv @ t q[2];
cx q[5], q[2];
t q[2];
cx q[7], q[2];
x q[2];
inv @ t q[2];
h q[2];
// END unlifted_x
// BEGIN lifted_x
h q[2];
t q[2];
cx q[7], q[2];
x q[2];
inv @ t q[2];
cx q[5], q[2];
t q[2];
cx q[7], q[2];
x q[2];
inv @ t q[2];
h q[2];
// END lifted_x
// BEGIN dup
h q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
cx q[3], q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
h q[4];
// END dup
// BEGIN dup
s q[6];
h q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
h q[6];
sdg q[6];
// END dup
// BEGIN dup
s q[8];
h q[8];
cx q[0], q[8];
x q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
cx q[0], q[8];
x q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
h q[8];
sdg q[8];
// END dup
p(0.0) q[8];
cp(0.0) q[8], q[9];
// BEGIN undup
s q[8];
h q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
cx q[0], q[8];
x q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
cx q[0], q[8];
x q[8];
h q[8];
sdg q[8];
// END undup
// BEGIN undup
s q[6];
h q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
h q[6];
sdg q[6];
// END undup
// BEGIN undup
h q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
cx q[3], q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
h q[4];
// END undup
// BEGIN unlifted_x
h q[2];
t q[2];
cx q[7], q[2];
x q[2];
inv @ t q[2];
cx q[5], q[2];
t q[2];
cx q[7], q[2];
x q[2];
inv @ t q[2];
h q[2];
// END unlifted_x
// BEGIN lifted_x
h q[2];
t q[2];
cx q[7], q[2];
x q[2];
inv @ t q[2];
cx q[5], q[2];
t q[2];
cx q[7], q[2];
x q[2];
inv @ t q[2];
h q[2];
// END lifted_x
// BEGIN dup
h q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
cx q[3], q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
h q[4];
// END dup
// BEGIN dup
s q[6];
h q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
h q[6];
sdg q[6];
// END dup
// BEGIN dup
h q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
cx q[0], q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
h q[8];
// END dup
p(0.0) q[8];
cp(0.0) q[9], q[8];
// BEGIN undup
h q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
cx q[0], q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
h q[8];
// END undup
// BEGIN undup
s q[6];
h q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
h q[6];
sdg q[6];
// END undup
// BEGIN undup
h q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
cx q[3], q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
h q[4];
// END undup
// BEGIN unlifted_x
h q[2];
t q[2];
cx q[7], q[2];
x q[2];
inv @ t q[2];
cx q[5], q[2];
t q[2];
cx q[7], q[2];
x q[2];
inv @ t q[2];
h q[2];
// END unlifted_x
// BEGIN lifted_x
h q[2];
t q[2];
cx q[7], q[2];
x q[2];
inv @ t q[2];
cx q[5], q[2];
t q[2];
cx q[7], q[2];
x q[2];
inv @ t q[2];
h q[2];
// END lifted_x
// BEGIN dup
h q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
cx q[3], q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
h q[4];
// END dup
// BEGIN dup
h q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[1], q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
h q[6];
// END dup
// BEGIN dup
s q[8];
h q[8];
cx q[0], q[8];
x q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
cx q[0], q[8];
x q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
h q[8];
sdg q[8];
// END dup
p(0.0) q[8];
cp(0.0) q[8], q[9];
// BEGIN undup
s q[8];
h q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
cx q[0], q[8];
x q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
cx q[0], q[8];
x q[8];
h q[8];
sdg q[8];
// END undup
// BEGIN undup
h q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[1], q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
h q[6];
// END undup
// BEGIN undup
h q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
cx q[3], q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
h q[4];
// END undup
// BEGIN unlifted_x
h q[2];
t q[2];
cx q[7], q[2];
x q[2];
inv @ t q[2];
cx q[5], q[2];
t q[2];
cx q[7], q[2];
x q[2];
inv @ t q[2];
h q[2];
// END unlifted_x
// BEGIN lifted_x
h q[2];
t q[2];
cx q[7], q[2];
x q[2];
inv @ t q[2];
cx q[5], q[2];
t q[2];
cx q[7], q[2];
x q[2];
inv @ t q[2];
h q[2];
// END lifted_x
// BEGIN dup
h q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
cx q[3], q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
h q[4];
// END dup
// BEGIN dup
h q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[1], q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
h q[6];
// END dup
// BEGIN dup
h q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
cx q[0], q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
h q[8];
// END dup
p(0.0) q[8];
cp(0.0) q[8], q[9];
// BEGIN undup
h q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
cx q[0], q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
h q[8];
// END undup
// BEGIN undup
h q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[1], q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
h q[6];
// END undup
// BEGIN undup
h q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
cx q[3], q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
h q[4];
// END undup
// BEGIN unlifted_x
h q[2];
t q[2];
cx q[7], q[2];
x q[2];
inv @ t q[2];
cx q[5], q[2];
t q[2];
cx q[7], q[2];
x q[2];
inv @ t q[2];
h q[2];
// END unlifted_x
// BEGIN dup
s q[2];
h q[2];
cx q[5], q[2];
x q[2];
t q[2];
cx q[7], q[2];
inv @ t q[2];
cx q[5], q[2];
x q[2];
t q[2];
cx q[7], q[2];
inv @ t q[2];
h q[2];
sdg q[2];
// END dup
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
// BEGIN dup
s q[6];
h q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
h q[6];
sdg q[6];
// END dup
// BEGIN dup
s q[8];
h q[8];
cx q[0], q[8];
x q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
cx q[0], q[8];
x q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
h q[8];
sdg q[8];
// END dup
p(0.7853981633974482) q[8];
cp(-1.5707963267948963) q[9], q[8];
// BEGIN undup
s q[8];
h q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
cx q[0], q[8];
x q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
cx q[0], q[8];
x q[8];
h q[8];
sdg q[8];
// END undup
// BEGIN undup
s q[6];
h q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
h q[6];
sdg q[6];
// END undup
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
// BEGIN undup
s q[2];
h q[2];
t q[2];
cx q[7], q[2];
inv @ t q[2];
cx q[5], q[2];
x q[2];
t q[2];
cx q[7], q[2];
inv @ t q[2];
cx q[5], q[2];
x q[2];
h q[2];
sdg q[2];
// END undup
// BEGIN dup
s q[2];
h q[2];
cx q[5], q[2];
x q[2];
t q[2];
cx q[7], q[2];
inv @ t q[2];
cx q[5], q[2];
x q[2];
t q[2];
cx q[7], q[2];
inv @ t q[2];
h q[2];
sdg q[2];
// END dup
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
// BEGIN dup
s q[6];
h q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
h q[6];
sdg q[6];
// END dup
// BEGIN dup
h q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
cx q[0], q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
h q[8];
// END dup
p(0.0) q[8];
cp(0.0) q[8], q[9];
// BEGIN undup
h q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
cx q[0], q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
h q[8];
// END undup
// BEGIN undup
s q[6];
h q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
h q[6];
sdg q[6];
// END undup
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
// BEGIN undup
s q[2];
h q[2];
t q[2];
cx q[7], q[2];
inv @ t q[2];
cx q[5], q[2];
x q[2];
t q[2];
cx q[7], q[2];
inv @ t q[2];
cx q[5], q[2];
x q[2];
h q[2];
sdg q[2];
// END undup
// BEGIN dup
s q[2];
h q[2];
cx q[5], q[2];
x q[2];
t q[2];
cx q[7], q[2];
inv @ t q[2];
cx q[5], q[2];
x q[2];
t q[2];
cx q[7], q[2];
inv @ t q[2];
h q[2];
sdg q[2];
// END dup
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
// BEGIN dup
h q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[1], q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
h q[6];
// END dup
// BEGIN dup
s q[8];
h q[8];
cx q[0], q[8];
x q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
cx q[0], q[8];
x q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
h q[8];
sdg q[8];
// END dup
p(0.0) q[8];
cp(0.0) q[8], q[9];
// BEGIN undup
s q[8];
h q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
cx q[0], q[8];
x q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
cx q[0], q[8];
x q[8];
h q[8];
sdg q[8];
// END undup
// BEGIN undup
h q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[1], q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
h q[6];
// END undup
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
// BEGIN undup
s q[2];
h q[2];
t q[2];
cx q[7], q[2];
inv @ t q[2];
cx q[5], q[2];
x q[2];
t q[2];
cx q[7], q[2];
inv @ t q[2];
cx q[5], q[2];
x q[2];
h q[2];
sdg q[2];
// END undup
// BEGIN dup
s q[2];
h q[2];
cx q[5], q[2];
x q[2];
t q[2];
cx q[7], q[2];
inv @ t q[2];
cx q[5], q[2];
x q[2];
t q[2];
cx q[7], q[2];
inv @ t q[2];
h q[2];
sdg q[2];
// END dup
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
// BEGIN dup
h q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[1], q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
h q[6];
// END dup
// BEGIN dup
h q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
cx q[0], q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
h q[8];
// END dup
p(0.0) q[8];
cp(0.0) q[8], q[9];
// BEGIN undup
h q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
cx q[0], q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
h q[8];
// END undup
// BEGIN undup
h q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[1], q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
h q[6];
// END undup
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
// BEGIN undup
s q[2];
h q[2];
t q[2];
cx q[7], q[2];
inv @ t q[2];
cx q[5], q[2];
x q[2];
t q[2];
cx q[7], q[2];
inv @ t q[2];
cx q[5], q[2];
x q[2];
h q[2];
sdg q[2];
// END undup
// BEGIN dup
s q[2];
h q[2];
cx q[5], q[2];
x q[2];
t q[2];
cx q[7], q[2];
inv @ t q[2];
cx q[5], q[2];
x q[2];
t q[2];
cx q[7], q[2];
inv @ t q[2];
h q[2];
sdg q[2];
// END dup
// BEGIN dup
h q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
cx q[3], q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
h q[4];
// END dup
// BEGIN dup
s q[6];
h q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
h q[6];
sdg q[6];
// END dup
// BEGIN dup
s q[8];
h q[8];
cx q[0], q[8];
x q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
cx q[0], q[8];
x q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
h q[8];
sdg q[8];
// END dup
p(0.0) q[8];
cp(0.0) q[8], q[9];
// BEGIN undup
s q[8];
h q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
cx q[0], q[8];
x q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
cx q[0], q[8];
x q[8];
h q[8];
sdg q[8];
// END undup
// BEGIN undup
s q[6];
h q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
h q[6];
sdg q[6];
// END undup
// BEGIN undup
h q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
cx q[3], q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
h q[4];
// END undup
// BEGIN undup
s q[2];
h q[2];
t q[2];
cx q[7], q[2];
inv @ t q[2];
cx q[5], q[2];
x q[2];
t q[2];
cx q[7], q[2];
inv @ t q[2];
cx q[5], q[2];
x q[2];
h q[2];
sdg q[2];
// END undup
// BEGIN dup
s q[2];
h q[2];
cx q[5], q[2];
x q[2];
t q[2];
cx q[7], q[2];
inv @ t q[2];
cx q[5], q[2];
x q[2];
t q[2];
cx q[7], q[2];
inv @ t q[2];
h q[2];
sdg q[2];
// END dup
// BEGIN dup
h q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
cx q[3], q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
h q[4];
// END dup
// BEGIN dup
s q[6];
h q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
h q[6];
sdg q[6];
// END dup
// BEGIN dup
h q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
cx q[0], q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
h q[8];
// END dup
p(0.0) q[8];
cp(0.0) q[9], q[8];
// BEGIN undup
h q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
cx q[0], q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
h q[8];
// END undup
// BEGIN undup
s q[6];
h q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
h q[6];
sdg q[6];
// END undup
// BEGIN undup
h q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
cx q[3], q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
h q[4];
// END undup
// BEGIN undup
s q[2];
h q[2];
t q[2];
cx q[7], q[2];
inv @ t q[2];
cx q[5], q[2];
x q[2];
t q[2];
cx q[7], q[2];
inv @ t q[2];
cx q[5], q[2];
x q[2];
h q[2];
sdg q[2];
// END undup
// BEGIN dup
s q[2];
h q[2];
cx q[5], q[2];
x q[2];
t q[2];
cx q[7], q[2];
inv @ t q[2];
cx q[5], q[2];
x q[2];
t q[2];
cx q[7], q[2];
inv @ t q[2];
h q[2];
sdg q[2];
// END dup
// BEGIN dup
h q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
cx q[3], q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
h q[4];
// END dup
// BEGIN dup
h q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[1], q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
h q[6];
// END dup
// BEGIN dup
s q[8];
h q[8];
cx q[0], q[8];
x q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
cx q[0], q[8];
x q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
h q[8];
sdg q[8];
// END dup
p(0.0) q[8];
cp(0.0) q[8], q[9];
// BEGIN undup
s q[8];
h q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
cx q[0], q[8];
x q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
cx q[0], q[8];
x q[8];
h q[8];
sdg q[8];
// END undup
// BEGIN undup
h q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[1], q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
h q[6];
// END undup
// BEGIN undup
h q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
cx q[3], q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
h q[4];
// END undup
// BEGIN undup
s q[2];
h q[2];
t q[2];
cx q[7], q[2];
inv @ t q[2];
cx q[5], q[2];
x q[2];
t q[2];
cx q[7], q[2];
inv @ t q[2];
cx q[5], q[2];
x q[2];
h q[2];
sdg q[2];
// END undup
// BEGIN dup
s q[2];
h q[2];
cx q[5], q[2];
x q[2];
t q[2];
cx q[7], q[2];
inv @ t q[2];
cx q[5], q[2];
x q[2];
t q[2];
cx q[7], q[2];
inv @ t q[2];
h q[2];
sdg q[2];
// END dup
// BEGIN dup
h q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
cx q[3], q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
h q[4];
// END dup
// BEGIN dup
h q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[1], q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
h q[6];
// END dup
// BEGIN dup
h q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
cx q[0], q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
h q[8];
// END dup
p(0.0) q[8];
cp(0.0) q[8], q[9];
// BEGIN undup
h q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
cx q[0], q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
h q[8];
// END undup
// BEGIN undup
h q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[1], q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
h q[6];
// END undup
// BEGIN undup
h q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
cx q[3], q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
h q[4];
// END undup
// BEGIN undup
s q[2];
h q[2];
t q[2];
cx q[7], q[2];
inv @ t q[2];
cx q[5], q[2];
x q[2];
t q[2];
cx q[7], q[2];
inv @ t q[2];
cx q[5], q[2];
x q[2];
h q[2];
sdg q[2];
// END undup
// BEGIN dup
h q[2];
t q[2];
cx q[7], q[2];
inv @ t q[2];
cx q[5], q[2];
t q[2];
cx q[7], q[2];
inv @ t q[2];
h q[2];
// END dup
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
// BEGIN dup
s q[6];
h q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
h q[6];
sdg q[6];
// END dup
// BEGIN dup
s q[8];
h q[8];
cx q[0], q[8];
x q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
cx q[0], q[8];
x q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
h q[8];
sdg q[8];
// END dup
p(0.0) q[8];
cp(0.0) q[9], q[8];
// BEGIN undup
s q[8];
h q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
cx q[0], q[8];
x q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
cx q[0], q[8];
x q[8];
h q[8];
sdg q[8];
// END undup
// BEGIN undup
s q[6];
h q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
h q[6];
sdg q[6];
// END undup
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
// BEGIN undup
h q[2];
t q[2];
cx q[7], q[2];
inv @ t q[2];
cx q[5], q[2];
t q[2];
cx q[7], q[2];
inv @ t q[2];
h q[2];
// END undup
// BEGIN dup
h q[2];
t q[2];
cx q[7], q[2];
inv @ t q[2];
cx q[5], q[2];
t q[2];
cx q[7], q[2];
inv @ t q[2];
h q[2];
// END dup
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
// BEGIN dup
s q[6];
h q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
h q[6];
sdg q[6];
// END dup
// BEGIN dup
h q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
cx q[0], q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
h q[8];
// END dup
p(0.0) q[8];
cp(0.0) q[8], q[9];
// BEGIN undup
h q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
cx q[0], q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
h q[8];
// END undup
// BEGIN undup
s q[6];
h q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
h q[6];
sdg q[6];
// END undup
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
// BEGIN undup
h q[2];
t q[2];
cx q[7], q[2];
inv @ t q[2];
cx q[5], q[2];
t q[2];
cx q[7], q[2];
inv @ t q[2];
h q[2];
// END undup
// BEGIN dup
h q[2];
t q[2];
cx q[7], q[2];
inv @ t q[2];
cx q[5], q[2];
t q[2];
cx q[7], q[2];
inv @ t q[2];
h q[2];
// END dup
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
// BEGIN dup
h q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[1], q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
h q[6];
// END dup
// BEGIN dup
s q[8];
h q[8];
cx q[0], q[8];
x q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
cx q[0], q[8];
x q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
h q[8];
sdg q[8];
// END dup
p(0.0) q[8];
cp(0.0) q[9], q[8];
// BEGIN undup
s q[8];
h q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
cx q[0], q[8];
x q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
cx q[0], q[8];
x q[8];
h q[8];
sdg q[8];
// END undup
// BEGIN undup
h q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[1], q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
h q[6];
// END undup
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
// BEGIN undup
h q[2];
t q[2];
cx q[7], q[2];
inv @ t q[2];
cx q[5], q[2];
t q[2];
cx q[7], q[2];
inv @ t q[2];
h q[2];
// END undup
// BEGIN dup
h q[2];
t q[2];
cx q[7], q[2];
inv @ t q[2];
cx q[5], q[2];
t q[2];
cx q[7], q[2];
inv @ t q[2];
h q[2];
// END dup
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
// BEGIN dup
h q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[1], q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
h q[6];
// END dup
// BEGIN dup
h q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
cx q[0], q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
h q[8];
// END dup
p(0.0) q[8];
cp(0.0) q[9], q[8];
// BEGIN undup
h q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
cx q[0], q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
h q[8];
// END undup
// BEGIN undup
h q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[1], q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
h q[6];
// END undup
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
// BEGIN undup
h q[2];
t q[2];
cx q[7], q[2];
inv @ t q[2];
cx q[5], q[2];
t q[2];
cx q[7], q[2];
inv @ t q[2];
h q[2];
// END undup
// BEGIN dup
h q[2];
t q[2];
cx q[7], q[2];
inv @ t q[2];
cx q[5], q[2];
t q[2];
cx q[7], q[2];
inv @ t q[2];
h q[2];
// END dup
// BEGIN dup
h q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
cx q[3], q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
h q[4];
// END dup
// BEGIN dup
s q[6];
h q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
h q[6];
sdg q[6];
// END dup
// BEGIN dup
s q[8];
h q[8];
cx q[0], q[8];
x q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
cx q[0], q[8];
x q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
h q[8];
sdg q[8];
// END dup
p(0.0) q[8];
cp(0.0) q[8], q[9];
// BEGIN undup
s q[8];
h q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
cx q[0], q[8];
x q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
cx q[0], q[8];
x q[8];
h q[8];
sdg q[8];
// END undup
// BEGIN undup
s q[6];
h q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
h q[6];
sdg q[6];
// END undup
// BEGIN undup
h q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
cx q[3], q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
h q[4];
// END undup
// BEGIN undup
h q[2];
t q[2];
cx q[7], q[2];
inv @ t q[2];
cx q[5], q[2];
t q[2];
cx q[7], q[2];
inv @ t q[2];
h q[2];
// END undup
// BEGIN dup
h q[2];
t q[2];
cx q[7], q[2];
inv @ t q[2];
cx q[5], q[2];
t q[2];
cx q[7], q[2];
inv @ t q[2];
h q[2];
// END dup
// BEGIN dup
h q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
cx q[3], q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
h q[4];
// END dup
// BEGIN dup
s q[6];
h q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
h q[6];
sdg q[6];
// END dup
// BEGIN dup
h q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
cx q[0], q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
h q[8];
// END dup
p(0.0) q[8];
cp(0.0) q[9], q[8];
// BEGIN undup
h q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
cx q[0], q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
h q[8];
// END undup
// BEGIN undup
s q[6];
h q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
h q[6];
sdg q[6];
// END undup
// BEGIN undup
h q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
cx q[3], q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
h q[4];
// END undup
// BEGIN undup
h q[2];
t q[2];
cx q[7], q[2];
inv @ t q[2];
cx q[5], q[2];
t q[2];
cx q[7], q[2];
inv @ t q[2];
h q[2];
// END undup
// BEGIN dup
h q[2];
t q[2];
cx q[7], q[2];
inv @ t q[2];
cx q[5], q[2];
t q[2];
cx q[7], q[2];
inv @ t q[2];
h q[2];
// END dup
// BEGIN dup
h q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
cx q[3], q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
h q[4];
// END dup
// BEGIN dup
h q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[1], q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
h q[6];
// END dup
// BEGIN dup
s q[8];
h q[8];
cx q[0], q[8];
x q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
cx q[0], q[8];
x q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
h q[8];
sdg q[8];
// END dup
p(0.0) q[8];
cp(0.0) q[8], q[9];
// BEGIN undup
s q[8];
h q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
cx q[0], q[8];
x q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
cx q[0], q[8];
x q[8];
h q[8];
sdg q[8];
// END undup
// BEGIN undup
h q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[1], q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
h q[6];
// END undup
// BEGIN undup
h q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
cx q[3], q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
h q[4];
// END undup
// BEGIN undup
h q[2];
t q[2];
cx q[7], q[2];
inv @ t q[2];
cx q[5], q[2];
t q[2];
cx q[7], q[2];
inv @ t q[2];
h q[2];
// END undup
// BEGIN dup
h q[2];
t q[2];
cx q[7], q[2];
inv @ t q[2];
cx q[5], q[2];
t q[2];
cx q[7], q[2];
inv @ t q[2];
h q[2];
// END dup
// BEGIN dup
h q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
cx q[3], q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
h q[4];
// END dup
// BEGIN dup
h q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[1], q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
h q[6];
// END dup
// BEGIN dup
h q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
cx q[0], q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
h q[8];
// END dup
p(-0.7853981633974483) q[8];
cp(1.5707963267948966) q[8], q[9];
// BEGIN undup
h q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
cx q[0], q[8];
t q[8];
cx q[6], q[8];
inv @ t q[8];
h q[8];
// END undup
// BEGIN undup
h q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[1], q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
h q[6];
// END undup
// BEGIN undup
h q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
cx q[3], q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
h q[4];
// END undup
// BEGIN undup
h q[2];
t q[2];
cx q[7], q[2];
inv @ t q[2];
cx q[5], q[2];
t q[2];
cx q[7], q[2];
inv @ t q[2];
h q[2];
// END undup
h q[0]; // inplace_h
// BEGIN dup
h q[2];
t q[2];
cx q[1], q[2];
inv @ t q[2];
cx q[0], q[2];
t q[2];
cx q[1], q[2];
inv @ t q[2];
h q[2];
// END dup
p(1.5707963267948966) q[2];
// BEGIN dup
s q[4];
h q[4];
cx q[0], q[4];
t q[4];
cx q[1], q[4];
inv @ t q[4];
cx q[0], q[4];
t q[4];
cx q[1], q[4];
inv @ t q[4];
h q[4];
sdg q[4];
// END dup
// BEGIN undup
s q[4];
h q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
cx q[0], q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
cx q[0], q[4];
h q[4];
sdg q[4];
// END undup
// BEGIN undup
h q[2];
t q[2];
cx q[1], q[2];
inv @ t q[2];
cx q[0], q[2];
t q[2];
cx q[1], q[2];
inv @ t q[2];
h q[2];
// END undup
// BEGIN dup
h q[2];
t q[2];
cx q[3], q[2];
inv @ t q[2];
cx q[0], q[2];
t q[2];
cx q[3], q[2];
inv @ t q[2];
h q[2];
// END dup
p(0.7853981633974483) q[2];
// BEGIN dup
s q[4];
h q[4];
cx q[0], q[4];
t q[4];
cx q[3], q[4];
inv @ t q[4];
cx q[0], q[4];
t q[4];
cx q[3], q[4];
inv @ t q[4];
h q[4];
sdg q[4];
// END dup
// BEGIN undup
s q[4];
h q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
cx q[0], q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
cx q[0], q[4];
h q[4];
sdg q[4];
// END undup
// BEGIN undup
h q[2];
t q[2];
cx q[3], q[2];
inv @ t q[2];
cx q[0], q[2];
t q[2];
cx q[3], q[2];
inv @ t q[2];
h q[2];
// END undup
// BEGIN dup
h q[2];
t q[2];
cx q[5], q[2];
inv @ t q[2];
cx q[0], q[2];
t q[2];
cx q[5], q[2];
inv @ t q[2];
h q[2];
// END dup
p(0.39269908169872414) q[2];
// BEGIN dup
s q[4];
h q[4];
cx q[0], q[4];
t q[4];
cx q[5], q[4];
inv @ t q[4];
cx q[0], q[4];
t q[4];
cx q[5], q[4];
inv @ t q[4];
h q[4];
sdg q[4];
// END dup
// BEGIN undup
s q[4];
h q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
cx q[0], q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
cx q[0], q[4];
h q[4];
sdg q[4];
// END undup
// BEGIN undup
h q[2];
t q[2];
cx q[5], q[2];
inv @ t q[2];
cx q[0], q[2];
t q[2];
cx q[5], q[2];
inv @ t q[2];
h q[2];
// END undup
// BEGIN dup
h q[2];
t q[2];
cx q[7], q[2];
inv @ t q[2];
cx q[0], q[2];
t q[2];
cx q[7], q[2];
inv @ t q[2];
h q[2];
// END dup
p(0.19634954084936207) q[2];
// BEGIN dup
s q[4];
h q[4];
cx q[0], q[4];
t q[4];
cx q[7], q[4];
inv @ t q[4];
cx q[0], q[4];
t q[4];
cx q[7], q[4];
inv @ t q[4];
h q[4];
sdg q[4];
// END dup
// BEGIN undup
s q[4];
h q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
cx q[0], q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
cx q[0], q[4];
h q[4];
sdg q[4];
// END undup
// BEGIN undup
h q[2];
t q[2];
cx q[7], q[2];
inv @ t q[2];
cx q[0], q[2];
t q[2];
cx q[7], q[2];
inv @ t q[2];
h q[2];
// END undup
// BEGIN dup
h q[2];
t q[2];
cx q[9], q[2];
inv @ t q[2];
cx q[0], q[2];
t q[2];
cx q[9], q[2];
inv @ t q[2];
h q[2];
// END dup
p(0.09817477042468103) q[2];
// BEGIN dup
s q[4];
h q[4];
cx q[0], q[4];
t q[4];
cx q[9], q[4];
inv @ t q[4];
cx q[0], q[4];
t q[4];
cx q[9], q[4];
inv @ t q[4];
h q[4];
sdg q[4];
// END dup
// BEGIN undup
s q[4];
h q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
cx q[0], q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
cx q[0], q[4];
h q[4];
sdg q[4];
// END undup
// BEGIN undup
h q[2];
t q[2];
cx q[9], q[2];
inv @ t q[2];
cx q[0], q[2];
t q[2];
cx q[9], q[2];
inv @ t q[2];
h q[2];
// END undup
h q[1]; // inplace_h
// BEGIN dup
h q[2];
t q[2];
cx q[3], q[2];
inv @ t q[2];
cx q[1], q[2];
t q[2];
cx q[3], q[2];
inv @ t q[2];
h q[2];
// END dup
p(1.5707963267948966) q[2];
// BEGIN dup
s q[4];
h q[4];
cx q[1], q[4];
t q[4];
cx q[3], q[4];
inv @ t q[4];
cx q[1], q[4];
t q[4];
cx q[3], q[4];
inv @ t q[4];
h q[4];
sdg q[4];
// END dup
// BEGIN undup
s q[4];
h q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
cx q[1], q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
cx q[1], q[4];
h q[4];
sdg q[4];
// END undup
// BEGIN undup
h q[2];
t q[2];
cx q[3], q[2];
inv @ t q[2];
cx q[1], q[2];
t q[2];
cx q[3], q[2];
inv @ t q[2];
h q[2];
// END undup
// BEGIN dup
h q[2];
t q[2];
cx q[5], q[2];
inv @ t q[2];
cx q[1], q[2];
t q[2];
cx q[5], q[2];
inv @ t q[2];
h q[2];
// END dup
p(0.7853981633974483) q[2];
// BEGIN dup
s q[4];
h q[4];
cx q[1], q[4];
t q[4];
cx q[5], q[4];
inv @ t q[4];
cx q[1], q[4];
t q[4];
cx q[5], q[4];
inv @ t q[4];
h q[4];
sdg q[4];
// END dup
// BEGIN undup
s q[4];
h q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
cx q[1], q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
cx q[1], q[4];
h q[4];
sdg q[4];
// END undup
// BEGIN undup
h q[2];
t q[2];
cx q[5], q[2];
inv @ t q[2];
cx q[1], q[2];
t q[2];
cx q[5], q[2];
inv @ t q[2];
h q[2];
// END undup
// BEGIN dup
h q[2];
t q[2];
cx q[7], q[2];
inv @ t q[2];
cx q[1], q[2];
t q[2];
cx q[7], q[2];
inv @ t q[2];
h q[2];
// END dup
p(0.39269908169872414) q[2];
// BEGIN dup
s q[4];
h q[4];
cx q[1], q[4];
t q[4];
cx q[7], q[4];
inv @ t q[4];
cx q[1], q[4];
t q[4];
cx q[7], q[4];
inv @ t q[4];
h q[4];
sdg q[4];
// END dup
// BEGIN undup
s q[4];
h q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
cx q[1], q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
cx q[1], q[4];
h q[4];
sdg q[4];
// END undup
// BEGIN undup
h q[2];
t q[2];
cx q[7], q[2];
inv @ t q[2];
cx q[1], q[2];
t q[2];
cx q[7], q[2];
inv @ t q[2];
h q[2];
// END undup
// BEGIN dup
h q[2];
t q[2];
cx q[9], q[2];
inv @ t q[2];
cx q[1], q[2];
t q[2];
cx q[9], q[2];
inv @ t q[2];
h q[2];
// END dup
p(0.19634954084936207) q[2];
// BEGIN dup
s q[4];
h q[4];
cx q[1], q[4];
t q[4];
cx q[9], q[4];
inv @ t q[4];
cx q[1], q[4];
t q[4];
cx q[9], q[4];
inv @ t q[4];
h q[4];
sdg q[4];
// END dup
// BEGIN undup
s q[4];
h q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
cx q[1], q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
cx q[1], q[4];
h q[4];
sdg q[4];
// END undup
// BEGIN undup
h q[2];
t q[2];
cx q[9], q[2];
inv @ t q[2];
cx q[1], q[2];
t q[2];
cx q[9], q[2];
inv @ t q[2];
h q[2];
// END undup
h q[3]; // inplace_h
// BEGIN dup
h q[2];
t q[2];
cx q[5], q[2];
inv @ t q[2];
cx q[3], q[2];
t q[2];
cx q[5], q[2];
inv @ t q[2];
h q[2];
// END dup
p(1.5707963267948966) q[2];
// BEGIN dup
s q[4];
h q[4];
cx q[3], q[4];
t q[4];
cx q[5], q[4];
inv @ t q[4];
cx q[3], q[4];
t q[4];
cx q[5], q[4];
inv @ t q[4];
h q[4];
sdg q[4];
// END dup
// BEGIN undup
s q[4];
h q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
cx q[3], q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
cx q[3], q[4];
h q[4];
sdg q[4];
// END undup
// BEGIN undup
h q[2];
t q[2];
cx q[5], q[2];
inv @ t q[2];
cx q[3], q[2];
t q[2];
cx q[5], q[2];
inv @ t q[2];
h q[2];
// END undup
// BEGIN dup
h q[2];
t q[2];
cx q[7], q[2];
inv @ t q[2];
cx q[3], q[2];
t q[2];
cx q[7], q[2];
inv @ t q[2];
h q[2];
// END dup
p(0.7853981633974483) q[2];
// BEGIN dup
s q[4];
h q[4];
cx q[3], q[4];
t q[4];
cx q[7], q[4];
inv @ t q[4];
cx q[3], q[4];
t q[4];
cx q[7], q[4];
inv @ t q[4];
h q[4];
sdg q[4];
// END dup
// BEGIN undup
s q[4];
h q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
cx q[3], q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
cx q[3], q[4];
h q[4];
sdg q[4];
// END undup
// BEGIN undup
h q[2];
t q[2];
cx q[7], q[2];
inv @ t q[2];
cx q[3], q[2];
t q[2];
cx q[7], q[2];
inv @ t q[2];
h q[2];
// END undup
// BEGIN dup
h q[2];
t q[2];
cx q[9], q[2];
inv @ t q[2];
cx q[3], q[2];
t q[2];
cx q[9], q[2];
inv @ t q[2];
h q[2];
// END dup
p(0.39269908169872414) q[2];
// BEGIN dup
s q[4];
h q[4];
cx q[3], q[4];
t q[4];
cx q[9], q[4];
inv @ t q[4];
cx q[3], q[4];
t q[4];
cx q[9], q[4];
inv @ t q[4];
h q[4];
sdg q[4];
// END dup
// BEGIN undup
s q[4];
h q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
cx q[3], q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
cx q[3], q[4];
h q[4];
sdg q[4];
// END undup
// BEGIN undup
h q[2];
t q[2];
cx q[9], q[2];
inv @ t q[2];
cx q[3], q[2];
t q[2];
cx q[9], q[2];
inv @ t q[2];
h q[2];
// END undup
h q[5]; // inplace_h
// BEGIN dup
h q[2];
t q[2];
cx q[7], q[2];
inv @ t q[2];
cx q[5], q[2];
t q[2];
cx q[7], q[2];
inv @ t q[2];
h q[2];
// END dup
p(1.5707963267948966) q[2];
// BEGIN dup
s q[4];
h q[4];
cx q[5], q[4];
t q[4];
cx q[7], q[4];
inv @ t q[4];
cx q[5], q[4];
t q[4];
cx q[7], q[4];
inv @ t q[4];
h q[4];
sdg q[4];
// END dup
// BEGIN undup
s q[4];
h q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
cx q[5], q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
cx q[5], q[4];
h q[4];
sdg q[4];
// END undup
// BEGIN undup
h q[2];
t q[2];
cx q[7], q[2];
inv @ t q[2];
cx q[5], q[2];
t q[2];
cx q[7], q[2];
inv @ t q[2];
h q[2];
// END undup
// BEGIN dup
h q[2];
t q[2];
cx q[9], q[2];
inv @ t q[2];
cx q[5], q[2];
t q[2];
cx q[9], q[2];
inv @ t q[2];
h q[2];
// END dup
p(0.7853981633974483) q[2];
// BEGIN dup
s q[4];
h q[4];
cx q[5], q[4];
t q[4];
cx q[9], q[4];
inv @ t q[4];
cx q[5], q[4];
t q[4];
cx q[9], q[4];
inv @ t q[4];
h q[4];
sdg q[4];
// END dup
// BEGIN undup
s q[4];
h q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
cx q[5], q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
cx q[5], q[4];
h q[4];
sdg q[4];
// END undup
// BEGIN undup
h q[2];
t q[2];
cx q[9], q[2];
inv @ t q[2];
cx q[5], q[2];
t q[2];
cx q[9], q[2];
inv @ t q[2];
h q[2];
// END undup
h q[7]; // inplace_h
// BEGIN dup
h q[2];
t q[2];
cx q[9], q[2];
inv @ t q[2];
cx q[7], q[2];
t q[2];
cx q[9], q[2];
inv @ t q[2];
h q[2];
// END dup
p(1.5707963267948966) q[2];
// BEGIN dup
s q[4];
h q[4];
cx q[7], q[4];
t q[4];
cx q[9], q[4];
inv @ t q[4];
cx q[7], q[4];
t q[4];
cx q[9], q[4];
inv @ t q[4];
h q[4];
sdg q[4];
// END dup
// BEGIN undup
s q[4];
h q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
cx q[7], q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
cx q[7], q[4];
h q[4];
sdg q[4];
// END undup
// BEGIN undup
h q[2];
t q[2];
cx q[9], q[2];
inv @ t q[2];
cx q[7], q[2];
t q[2];
cx q[9], q[2];
inv @ t q[2];
h q[2];
// END undup
h q[9]; // inplace_h
swap q[2], q[3];
swap q[3], q[5];
swap q[4], q[7];
swap q[5], q[9];

