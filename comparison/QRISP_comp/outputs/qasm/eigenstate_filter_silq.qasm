include "stdgates.inc";
qubit[9] q;

gphase(-1.2730683938935374e-16);
ry(3.0944233469791818) q[0]; // inplace_rot
p(-2.5461367877870747e-16) q[0];
gphase(1.2730683938935374e-16);
x q[0]; // want_negated=True
ctrl(1) @ ry(1.8754889808102941) q[0], q[2]; // inplace_rot
x q[2]; // want_negated=True
ctrl(2) @ ry(1.5707963267948968) q[2], q[0], q[1]; // inplace_rot
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[2], q[1], q[0];
x q[1]; // want_negated=False
ctrl(3) @ gphase(0.0) q[2], q[1], q[0];
x q[2]; // want_negated=False
ctrl(2) @ ry(1.5707963267948966) q[2], q[0], q[1]; // inplace_rot
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[1], q[2], q[0];
x q[1]; // want_negated=False
ctrl(3) @ gphase(0.0) q[1], q[2], q[0];
// BEGIN lifted_x
h q[3];
t q[3];
cx q[2], q[3];
x q[3];
inv @ t q[3];
h q[3];
t q[3];
cx q[0], q[3];
inv @ t q[3];
cx q[1], q[3];
t q[3];
cx q[0], q[3];
inv @ t q[3];
cx q[1], q[3];
h q[3];
t q[3];
cx q[2], q[3];
x q[3];
inv @ t q[3];
h q[3];
// END lifted_x
// BEGIN dup
s q[4];
h q[4];
h q[4];
cx q[1], q[4];
x q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
x q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
h q[4];
t q[4];
cx q[3], q[4];
inv @ t q[4];
h q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
x q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
x q[4];
h q[4];
t q[4];
cx q[3], q[4];
inv @ t q[4];
h q[4];
sdg q[4];
// END dup
// BEGIN dup
s q[5];
h q[5];
h q[5];
cx q[1], q[5];
t q[5];
cx q[0], q[5];
inv @ t q[5];
cx q[1], q[5];
t q[5];
cx q[0], q[5];
inv @ t q[5];
h q[5];
t q[5];
cx q[3], q[5];
inv @ t q[5];
h q[5];
t q[5];
cx q[0], q[5];
inv @ t q[5];
cx q[1], q[5];
t q[5];
cx q[0], q[5];
inv @ t q[5];
cx q[1], q[5];
h q[5];
t q[5];
cx q[3], q[5];
inv @ t q[5];
h q[5];
sdg q[5];
// END dup
// BEGIN unlifted_x
h q[5];
t q[5];
cx q[2], q[5];
x q[5];
inv @ t q[5];
h q[5];
cx q[1], q[5];
t q[5];
cx q[0], q[5];
inv @ t q[5];
cx q[1], q[5];
t q[5];
cx q[0], q[5];
inv @ t q[5];
h q[5];
t q[5];
cx q[2], q[5];
x q[5];
inv @ t q[5];
h q[5];
// END unlifted_x
// BEGIN dup
h q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
h q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
h q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
h q[4];
// END dup
cp(3.141592653589793) q[4], q[0];
// BEGIN undup
h q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
h q[4];
cx q[1], q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
h q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
h q[4];
// END undup
ctrl(3) @ gphase(0.0) q[2], q[1], q[0];
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[1], q[2], q[0];
x q[1]; // want_negated=False
ctrl(2) @ ry(-1.5707963267948966) q[2], q[0], q[1]; // inplace_rot
x q[2]; // want_negated=True
ctrl(3) @ gphase(0.0) q[2], q[1], q[0];
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[2], q[1], q[0];
x q[1]; // want_negated=False
ctrl(2) @ ry(-1.5707963267948968) q[2], q[0], q[1]; // inplace_rot
x q[2]; // want_negated=False
ctrl(1) @ ry(-1.8754889808102941) q[0], q[2]; // inplace_rot
// BEGIN alloc
s q[4];
h q[4];
cx q[1], q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
h q[4];
sdg q[4];
// END alloc
// BEGIN dup
h q[5];
t q[5];
cx q[2], q[5];
inv @ t q[5];
h q[5];
t q[5];
cx q[0], q[5];
inv @ t q[5];
cx q[1], q[5];
x q[5];
t q[5];
cx q[0], q[5];
inv @ t q[5];
cx q[1], q[5];
x q[5];
h q[5];
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
h q[6];
t q[6];
cx q[0], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[0], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
h q[6];
t q[6];
cx q[2], q[6];
inv @ t q[6];
h q[6];
// END dup
// BEGIN dup
s q[7];
h q[7];
h q[7];
cx q[1], q[7];
x q[7];
t q[7];
cx q[0], q[7];
inv @ t q[7];
cx q[1], q[7];
x q[7];
t q[7];
cx q[0], q[7];
inv @ t q[7];
h q[7];
t q[7];
cx q[5], q[7];
inv @ t q[7];
h q[7];
t q[7];
cx q[0], q[7];
inv @ t q[7];
cx q[1], q[7];
x q[7];
t q[7];
cx q[0], q[7];
inv @ t q[7];
cx q[1], q[7];
x q[7];
h q[7];
t q[7];
cx q[5], q[7];
inv @ t q[7];
h q[7];
sdg q[7];
// END dup
// BEGIN alloc
s q[7];
h q[7];
cx q[1], q[7];
t q[7];
cx q[0], q[7];
inv @ t q[7];
cx q[1], q[7];
t q[7];
cx q[0], q[7];
inv @ t q[7];
h q[7];
sdg q[7];
// END alloc
// BEGIN dup
s q[4];
h q[4];
h q[4];
cx q[1], q[4];
x q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
x q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
h q[4];
t q[4];
cx q[6], q[4];
inv @ t q[4];
h q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
x q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
x q[4];
h q[4];
t q[4];
cx q[6], q[4];
inv @ t q[4];
h q[4];
sdg q[4];
// END dup
// BEGIN dup
s q[8];
h q[8];
h q[8];
cx q[7], q[8];
t q[8];
cx q[0], q[8];
inv @ t q[8];
cx q[7], q[8];
t q[8];
cx q[0], q[8];
inv @ t q[8];
h q[8];
t q[8];
cx q[4], q[8];
inv @ t q[8];
h q[8];
t q[8];
cx q[0], q[8];
inv @ t q[8];
cx q[7], q[8];
t q[8];
cx q[0], q[8];
inv @ t q[8];
cx q[7], q[8];
h q[8];
t q[8];
cx q[4], q[8];
inv @ t q[8];
h q[8];
sdg q[8];
// END dup
cp(3.141592653589793) q[8], q[0];
// BEGIN undup
s q[8];
h q[8];
t q[8];
cx q[4], q[8];
inv @ t q[8];
h q[8];
cx q[7], q[8];
t q[8];
cx q[0], q[8];
inv @ t q[8];
cx q[7], q[8];
t q[8];
cx q[0], q[8];
inv @ t q[8];
h q[8];
t q[8];
cx q[4], q[8];
inv @ t q[8];
h q[8];
t q[8];
cx q[0], q[8];
inv @ t q[8];
cx q[7], q[8];
t q[8];
cx q[0], q[8];
inv @ t q[8];
cx q[7], q[8];
h q[8];
h q[8];
sdg q[8];
// END undup
// BEGIN undup
s q[4];
h q[4];
t q[4];
cx q[6], q[4];
inv @ t q[4];
h q[4];
cx q[1], q[4];
x q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
x q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
h q[4];
t q[4];
cx q[6], q[4];
inv @ t q[4];
h q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
x q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
x q[4];
h q[4];
h q[4];
sdg q[4];
// END undup
// BEGIN undup
s q[7];
h q[7];
t q[7];
cx q[5], q[7];
inv @ t q[7];
h q[7];
cx q[1], q[7];
x q[7];
t q[7];
cx q[0], q[7];
inv @ t q[7];
cx q[1], q[7];
x q[7];
t q[7];
cx q[0], q[7];
inv @ t q[7];
h q[7];
t q[7];
cx q[5], q[7];
inv @ t q[7];
h q[7];
t q[7];
cx q[0], q[7];
inv @ t q[7];
cx q[1], q[7];
x q[7];
t q[7];
cx q[0], q[7];
inv @ t q[7];
cx q[1], q[7];
x q[7];
h q[7];
h q[7];
sdg q[7];
// END undup
// BEGIN dealloc
s q[7];
h q[7];
t q[7];
cx q[0], q[7];
inv @ t q[7];
cx q[1], q[7];
t q[7];
cx q[0], q[7];
inv @ t q[7];
cx q[1], q[7];
h q[7];
sdg q[7];
// END dealloc
// BEGIN undup
h q[6];
t q[6];
cx q[2], q[6];
inv @ t q[6];
h q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[0], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[0], q[6];
inv @ t q[6];
h q[6];
t q[6];
cx q[2], q[6];
inv @ t q[6];
h q[6];
// END undup
// BEGIN dup
s q[6];
h q[6];
h q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[0], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[0], q[6];
inv @ t q[6];
h q[6];
t q[6];
cx q[2], q[6];
inv @ t q[6];
h q[6];
t q[6];
cx q[0], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[0], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
h q[6];
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
h q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[0], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[0], q[6];
inv @ t q[6];
h q[6];
t q[6];
cx q[5], q[6];
inv @ t q[6];
h q[6];
t q[6];
cx q[0], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[0], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
h q[6];
h q[6];
sdg q[6];
// END undup
// BEGIN undup
h q[5];
t q[5];
cx q[2], q[5];
inv @ t q[5];
h q[5];
cx q[1], q[5];
x q[5];
t q[5];
cx q[0], q[5];
inv @ t q[5];
cx q[1], q[5];
x q[5];
t q[5];
cx q[0], q[5];
inv @ t q[5];
h q[5];
t q[5];
cx q[2], q[5];
inv @ t q[5];
h q[5];
// END undup
// BEGIN dealloc
s q[4];
h q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
h q[4];
sdg q[4];
// END dealloc
gphase(0.0);
x q[0]; // want_negated=False
p(0.0) q[0];
ry(0.0) q[0]; // inplace_rot
p(0.0) q[0];
gphase(0.0);
x q[0]; // want_negated=True
ctrl(1) @ ry(1.8754889808102941) q[0], q[2]; // inplace_rot
x q[2]; // want_negated=True
ctrl(2) @ ry(1.5707963267948968) q[2], q[0], q[1]; // inplace_rot
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[2], q[0], q[1];
x q[1]; // want_negated=False
ctrl(3) @ gphase(0.0) q[2], q[1], q[0];
x q[2]; // want_negated=False
ctrl(2) @ ry(1.5707963267948966) q[2], q[0], q[1]; // inplace_rot
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[2], q[0], q[1];
x q[1]; // want_negated=False
ctrl(3) @ gphase(0.0) q[2], q[1], q[0];
// BEGIN lifted_x
h q[4];
t q[4];
cx q[2], q[4];
x q[4];
inv @ t q[4];
h q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
h q[4];
t q[4];
cx q[2], q[4];
x q[4];
inv @ t q[4];
h q[4];
// END lifted_x
ccx q[4], q[0], q[3]; // inplace_x
// BEGIN unlifted_x
h q[4];
t q[4];
cx q[2], q[4];
x q[4];
inv @ t q[4];
h q[4];
cx q[1], q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
h q[4];
t q[4];
cx q[2], q[4];
x q[4];
inv @ t q[4];
h q[4];
// END unlifted_x
// BEGIN dup
h q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
h q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
h q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
h q[4];
// END dup
cp(3.141592653589793) q[4], q[0];
// BEGIN undup
h q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
h q[4];
cx q[1], q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
h q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
h q[4];
// END undup
ctrl(3) @ gphase(0.0) q[2], q[0], q[1];
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[2], q[1], q[0];
x q[1]; // want_negated=False
ctrl(2) @ ry(-1.5707963267948966) q[2], q[0], q[1]; // inplace_rot
x q[2]; // want_negated=True
ctrl(3) @ gphase(0.0) q[2], q[1], q[0];
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[2], q[1], q[0];
x q[1]; // want_negated=False
ctrl(2) @ ry(-1.5707963267948968) q[2], q[0], q[1]; // inplace_rot
x q[2]; // want_negated=False
ctrl(1) @ ry(-1.8754889808102941) q[0], q[2]; // inplace_rot
// BEGIN alloc
s q[4];
h q[4];
cx q[1], q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
h q[4];
sdg q[4];
// END alloc
// BEGIN dup
h q[5];
t q[5];
cx q[2], q[5];
inv @ t q[5];
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
cx q[0], q[5];
h q[5];
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
h q[6];
t q[6];
cx q[1], q[6];
x q[6];
inv @ t q[6];
cx q[0], q[6];
t q[6];
cx q[1], q[6];
x q[6];
inv @ t q[6];
cx q[0], q[6];
h q[6];
t q[6];
cx q[2], q[6];
inv @ t q[6];
h q[6];
// END dup
// BEGIN dup
s q[7];
h q[7];
h q[7];
cx q[0], q[7];
t q[7];
cx q[1], q[7];
x q[7];
inv @ t q[7];
cx q[0], q[7];
t q[7];
cx q[1], q[7];
x q[7];
inv @ t q[7];
h q[7];
t q[7];
cx q[5], q[7];
inv @ t q[7];
h q[7];
t q[7];
cx q[1], q[7];
x q[7];
inv @ t q[7];
cx q[0], q[7];
t q[7];
cx q[1], q[7];
x q[7];
inv @ t q[7];
cx q[0], q[7];
h q[7];
t q[7];
cx q[5], q[7];
inv @ t q[7];
h q[7];
sdg q[7];
// END dup
// BEGIN alloc
s q[7];
h q[7];
cx q[1], q[7];
t q[7];
cx q[0], q[7];
inv @ t q[7];
cx q[1], q[7];
t q[7];
cx q[0], q[7];
inv @ t q[7];
h q[7];
sdg q[7];
// END alloc
// BEGIN dup
s q[4];
h q[4];
h q[4];
cx q[0], q[4];
t q[4];
cx q[1], q[4];
x q[4];
inv @ t q[4];
cx q[0], q[4];
t q[4];
cx q[1], q[4];
x q[4];
inv @ t q[4];
h q[4];
t q[4];
cx q[6], q[4];
inv @ t q[4];
h q[4];
t q[4];
cx q[1], q[4];
x q[4];
inv @ t q[4];
cx q[0], q[4];
t q[4];
cx q[1], q[4];
x q[4];
inv @ t q[4];
cx q[0], q[4];
h q[4];
t q[4];
cx q[6], q[4];
inv @ t q[4];
h q[4];
sdg q[4];
// END dup
// BEGIN dup
s q[8];
h q[8];
h q[8];
cx q[7], q[8];
t q[8];
cx q[0], q[8];
inv @ t q[8];
cx q[7], q[8];
t q[8];
cx q[0], q[8];
inv @ t q[8];
h q[8];
t q[8];
cx q[4], q[8];
inv @ t q[8];
h q[8];
t q[8];
cx q[0], q[8];
inv @ t q[8];
cx q[7], q[8];
t q[8];
cx q[0], q[8];
inv @ t q[8];
cx q[7], q[8];
h q[8];
t q[8];
cx q[4], q[8];
inv @ t q[8];
h q[8];
sdg q[8];
// END dup
cp(3.141592653589793) q[8], q[0];
// BEGIN undup
s q[8];
h q[8];
t q[8];
cx q[4], q[8];
inv @ t q[8];
h q[8];
cx q[7], q[8];
t q[8];
cx q[0], q[8];
inv @ t q[8];
cx q[7], q[8];
t q[8];
cx q[0], q[8];
inv @ t q[8];
h q[8];
t q[8];
cx q[4], q[8];
inv @ t q[8];
h q[8];
t q[8];
cx q[0], q[8];
inv @ t q[8];
cx q[7], q[8];
t q[8];
cx q[0], q[8];
inv @ t q[8];
cx q[7], q[8];
h q[8];
h q[8];
sdg q[8];
// END undup
// BEGIN undup
s q[4];
h q[4];
t q[4];
cx q[6], q[4];
inv @ t q[4];
h q[4];
cx q[0], q[4];
t q[4];
cx q[1], q[4];
x q[4];
inv @ t q[4];
cx q[0], q[4];
t q[4];
cx q[1], q[4];
x q[4];
inv @ t q[4];
h q[4];
t q[4];
cx q[6], q[4];
inv @ t q[4];
h q[4];
t q[4];
cx q[1], q[4];
x q[4];
inv @ t q[4];
cx q[0], q[4];
t q[4];
cx q[1], q[4];
x q[4];
inv @ t q[4];
cx q[0], q[4];
h q[4];
h q[4];
sdg q[4];
// END undup
// BEGIN undup
s q[7];
h q[7];
t q[7];
cx q[5], q[7];
inv @ t q[7];
h q[7];
cx q[0], q[7];
t q[7];
cx q[1], q[7];
x q[7];
inv @ t q[7];
cx q[0], q[7];
t q[7];
cx q[1], q[7];
x q[7];
inv @ t q[7];
h q[7];
t q[7];
cx q[5], q[7];
inv @ t q[7];
h q[7];
t q[7];
cx q[1], q[7];
x q[7];
inv @ t q[7];
cx q[0], q[7];
t q[7];
cx q[1], q[7];
x q[7];
inv @ t q[7];
cx q[0], q[7];
h q[7];
h q[7];
sdg q[7];
// END undup
// BEGIN dealloc
s q[7];
h q[7];
t q[7];
cx q[0], q[7];
inv @ t q[7];
cx q[1], q[7];
t q[7];
cx q[0], q[7];
inv @ t q[7];
cx q[1], q[7];
h q[7];
sdg q[7];
// END dealloc
// BEGIN undup
h q[6];
t q[6];
cx q[2], q[6];
inv @ t q[6];
h q[6];
cx q[0], q[6];
t q[6];
cx q[1], q[6];
x q[6];
inv @ t q[6];
cx q[0], q[6];
t q[6];
cx q[1], q[6];
x q[6];
inv @ t q[6];
h q[6];
t q[6];
cx q[2], q[6];
inv @ t q[6];
h q[6];
// END undup
// BEGIN dup
s q[6];
h q[6];
h q[6];
cx q[0], q[6];
t q[6];
cx q[1], q[6];
x q[6];
inv @ t q[6];
cx q[0], q[6];
t q[6];
cx q[1], q[6];
x q[6];
inv @ t q[6];
h q[6];
t q[6];
cx q[2], q[6];
inv @ t q[6];
h q[6];
t q[6];
cx q[1], q[6];
x q[6];
inv @ t q[6];
cx q[0], q[6];
t q[6];
cx q[1], q[6];
x q[6];
inv @ t q[6];
cx q[0], q[6];
h q[6];
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
h q[6];
cx q[0], q[6];
t q[6];
cx q[1], q[6];
x q[6];
inv @ t q[6];
cx q[0], q[6];
t q[6];
cx q[1], q[6];
x q[6];
inv @ t q[6];
h q[6];
t q[6];
cx q[5], q[6];
inv @ t q[6];
h q[6];
t q[6];
cx q[1], q[6];
x q[6];
inv @ t q[6];
cx q[0], q[6];
t q[6];
cx q[1], q[6];
x q[6];
inv @ t q[6];
cx q[0], q[6];
h q[6];
h q[6];
sdg q[6];
// END undup
// BEGIN undup
h q[5];
t q[5];
cx q[2], q[5];
inv @ t q[5];
h q[5];
cx q[0], q[5];
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
t q[5];
cx q[2], q[5];
inv @ t q[5];
h q[5];
// END undup
// BEGIN dealloc
s q[4];
h q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
h q[4];
sdg q[4];
// END dealloc
gphase(7.13360745513744e-17);
x q[0]; // want_negated=False
p(-1.426721491027488e-16) q[0];
ry(0.048271028391483256) q[0]; // inplace_rot
p(1.426721491027488e-16) q[0];
gphase(-7.13360745513744e-17);
x q[0]; // want_negated=True
ctrl(1) @ ry(1.8754889808102941) q[0], q[2]; // inplace_rot
x q[2]; // want_negated=True
ctrl(2) @ ry(1.5707963267948968) q[0], q[2], q[1]; // inplace_rot
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[0], q[2], q[1];
x q[1]; // want_negated=False
ctrl(3) @ gphase(0.0) q[1], q[0], q[2];
x q[2]; // want_negated=False
ctrl(2) @ ry(1.5707963267948966) q[0], q[2], q[1]; // inplace_rot
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[0], q[2], q[1];
x q[1]; // want_negated=False
ctrl(3) @ gphase(0.0) q[0], q[2], q[1];
// BEGIN lifted_x
h q[4];
t q[4];
cx q[2], q[4];
x q[4];
inv @ t q[4];
h q[4];
t q[4];
cx q[1], q[4];
inv @ t q[4];
cx q[0], q[4];
t q[4];
cx q[1], q[4];
inv @ t q[4];
cx q[0], q[4];
h q[4];
t q[4];
cx q[2], q[4];
x q[4];
inv @ t q[4];
h q[4];
// END lifted_x
ccx q[0], q[4], q[3]; // inplace_x
// BEGIN unlifted_x
h q[4];
t q[4];
cx q[2], q[4];
x q[4];
inv @ t q[4];
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
t q[4];
cx q[2], q[4];
x q[4];
inv @ t q[4];
h q[4];
// END unlifted_x
// BEGIN dup
h q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
h q[4];
t q[4];
cx q[1], q[4];
inv @ t q[4];
cx q[0], q[4];
t q[4];
cx q[1], q[4];
inv @ t q[4];
cx q[0], q[4];
h q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
h q[4];
// END dup
cp(3.141592653589793) q[0], q[4];
// BEGIN undup
h q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
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
t q[4];
cx q[2], q[4];
inv @ t q[4];
h q[4];
// END undup
ctrl(3) @ gphase(0.0) q[1], q[0], q[2];
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[1], q[0], q[2];
x q[1]; // want_negated=False
ctrl(2) @ ry(-1.5707963267948966) q[0], q[2], q[1]; // inplace_rot
x q[2]; // want_negated=True
ctrl(3) @ gphase(0.0) q[0], q[2], q[1];
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[0], q[2], q[1];
x q[1]; // want_negated=False
ctrl(2) @ ry(-1.5707963267948968) q[0], q[2], q[1]; // inplace_rot
x q[2]; // want_negated=False
ctrl(1) @ ry(-1.8754889808102941) q[0], q[2]; // inplace_rot
// BEGIN alloc
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
// END alloc
// BEGIN dup
h q[5];
t q[5];
cx q[2], q[5];
inv @ t q[5];
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
cx q[0], q[5];
h q[5];
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
h q[6];
t q[6];
cx q[1], q[6];
x q[6];
inv @ t q[6];
cx q[0], q[6];
t q[6];
cx q[1], q[6];
x q[6];
inv @ t q[6];
cx q[0], q[6];
h q[6];
t q[6];
cx q[2], q[6];
inv @ t q[6];
h q[6];
// END dup
// BEGIN dup
s q[7];
h q[7];
h q[7];
cx q[0], q[7];
t q[7];
cx q[1], q[7];
x q[7];
inv @ t q[7];
cx q[0], q[7];
t q[7];
cx q[1], q[7];
x q[7];
inv @ t q[7];
h q[7];
t q[7];
cx q[5], q[7];
inv @ t q[7];
h q[7];
t q[7];
cx q[1], q[7];
x q[7];
inv @ t q[7];
cx q[0], q[7];
t q[7];
cx q[1], q[7];
x q[7];
inv @ t q[7];
cx q[0], q[7];
h q[7];
t q[7];
cx q[5], q[7];
inv @ t q[7];
h q[7];
sdg q[7];
// END dup
// BEGIN alloc
s q[7];
h q[7];
cx q[0], q[7];
t q[7];
cx q[1], q[7];
inv @ t q[7];
cx q[0], q[7];
t q[7];
cx q[1], q[7];
inv @ t q[7];
h q[7];
sdg q[7];
// END alloc
// BEGIN dup
s q[4];
h q[4];
h q[4];
cx q[0], q[4];
t q[4];
cx q[1], q[4];
x q[4];
inv @ t q[4];
cx q[0], q[4];
t q[4];
cx q[1], q[4];
x q[4];
inv @ t q[4];
h q[4];
t q[4];
cx q[6], q[4];
inv @ t q[4];
h q[4];
t q[4];
cx q[1], q[4];
x q[4];
inv @ t q[4];
cx q[0], q[4];
t q[4];
cx q[1], q[4];
x q[4];
inv @ t q[4];
cx q[0], q[4];
h q[4];
t q[4];
cx q[6], q[4];
inv @ t q[4];
h q[4];
sdg q[4];
// END dup
// BEGIN dup
s q[8];
h q[8];
h q[8];
cx q[0], q[8];
t q[8];
cx q[7], q[8];
inv @ t q[8];
cx q[0], q[8];
t q[8];
cx q[7], q[8];
inv @ t q[8];
h q[8];
t q[8];
cx q[4], q[8];
inv @ t q[8];
h q[8];
t q[8];
cx q[7], q[8];
inv @ t q[8];
cx q[0], q[8];
t q[8];
cx q[7], q[8];
inv @ t q[8];
cx q[0], q[8];
h q[8];
t q[8];
cx q[4], q[8];
inv @ t q[8];
h q[8];
sdg q[8];
// END dup
cp(3.141592653589793) q[0], q[8];
// BEGIN undup
s q[8];
h q[8];
t q[8];
cx q[4], q[8];
inv @ t q[8];
h q[8];
cx q[0], q[8];
t q[8];
cx q[7], q[8];
inv @ t q[8];
cx q[0], q[8];
t q[8];
cx q[7], q[8];
inv @ t q[8];
h q[8];
t q[8];
cx q[4], q[8];
inv @ t q[8];
h q[8];
t q[8];
cx q[7], q[8];
inv @ t q[8];
cx q[0], q[8];
t q[8];
cx q[7], q[8];
inv @ t q[8];
cx q[0], q[8];
h q[8];
h q[8];
sdg q[8];
// END undup
// BEGIN undup
s q[4];
h q[4];
t q[4];
cx q[6], q[4];
inv @ t q[4];
h q[4];
cx q[0], q[4];
t q[4];
cx q[1], q[4];
x q[4];
inv @ t q[4];
cx q[0], q[4];
t q[4];
cx q[1], q[4];
x q[4];
inv @ t q[4];
h q[4];
t q[4];
cx q[6], q[4];
inv @ t q[4];
h q[4];
t q[4];
cx q[1], q[4];
x q[4];
inv @ t q[4];
cx q[0], q[4];
t q[4];
cx q[1], q[4];
x q[4];
inv @ t q[4];
cx q[0], q[4];
h q[4];
h q[4];
sdg q[4];
// END undup
// BEGIN undup
s q[7];
h q[7];
t q[7];
cx q[5], q[7];
inv @ t q[7];
h q[7];
cx q[0], q[7];
t q[7];
cx q[1], q[7];
x q[7];
inv @ t q[7];
cx q[0], q[7];
t q[7];
cx q[1], q[7];
x q[7];
inv @ t q[7];
h q[7];
t q[7];
cx q[5], q[7];
inv @ t q[7];
h q[7];
t q[7];
cx q[1], q[7];
x q[7];
inv @ t q[7];
cx q[0], q[7];
t q[7];
cx q[1], q[7];
x q[7];
inv @ t q[7];
cx q[0], q[7];
h q[7];
h q[7];
sdg q[7];
// END undup
// BEGIN dealloc
s q[7];
h q[7];
t q[7];
cx q[1], q[7];
inv @ t q[7];
cx q[0], q[7];
t q[7];
cx q[1], q[7];
inv @ t q[7];
cx q[0], q[7];
h q[7];
sdg q[7];
// END dealloc
// BEGIN undup
h q[6];
t q[6];
cx q[2], q[6];
inv @ t q[6];
h q[6];
cx q[0], q[6];
t q[6];
cx q[1], q[6];
x q[6];
inv @ t q[6];
cx q[0], q[6];
t q[6];
cx q[1], q[6];
x q[6];
inv @ t q[6];
h q[6];
t q[6];
cx q[2], q[6];
inv @ t q[6];
h q[6];
// END undup
// BEGIN dup
s q[6];
h q[6];
h q[6];
cx q[0], q[6];
t q[6];
cx q[1], q[6];
x q[6];
inv @ t q[6];
cx q[0], q[6];
t q[6];
cx q[1], q[6];
x q[6];
inv @ t q[6];
h q[6];
t q[6];
cx q[2], q[6];
inv @ t q[6];
h q[6];
t q[6];
cx q[1], q[6];
x q[6];
inv @ t q[6];
cx q[0], q[6];
t q[6];
cx q[1], q[6];
x q[6];
inv @ t q[6];
cx q[0], q[6];
h q[6];
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
h q[6];
cx q[0], q[6];
t q[6];
cx q[1], q[6];
x q[6];
inv @ t q[6];
cx q[0], q[6];
t q[6];
cx q[1], q[6];
x q[6];
inv @ t q[6];
h q[6];
t q[6];
cx q[5], q[6];
inv @ t q[6];
h q[6];
t q[6];
cx q[1], q[6];
x q[6];
inv @ t q[6];
cx q[0], q[6];
t q[6];
cx q[1], q[6];
x q[6];
inv @ t q[6];
cx q[0], q[6];
h q[6];
h q[6];
sdg q[6];
// END undup
// BEGIN undup
h q[5];
t q[5];
cx q[2], q[5];
inv @ t q[5];
h q[5];
cx q[0], q[5];
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
t q[5];
cx q[2], q[5];
inv @ t q[5];
h q[5];
// END undup
// BEGIN dealloc
s q[4];
h q[4];
t q[4];
cx q[1], q[4];
inv @ t q[4];
cx q[0], q[4];
t q[4];
cx q[1], q[4];
inv @ t q[4];
cx q[0], q[4];
h q[4];
sdg q[4];
// END dealloc
gphase(0.0);
x q[0]; // want_negated=False
p(0.0) q[0];
ry(0.0) q[0]; // inplace_rot
p(0.0) q[0];
gphase(0.0);
x q[0]; // want_negated=True
ctrl(1) @ ry(1.8754889808102941) q[0], q[2]; // inplace_rot
x q[2]; // want_negated=True
ctrl(2) @ ry(1.5707963267948968) q[2], q[0], q[1]; // inplace_rot
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[2], q[1], q[0];
x q[1]; // want_negated=False
ctrl(3) @ gphase(0.0) q[0], q[2], q[1];
x q[2]; // want_negated=False
ctrl(2) @ ry(1.5707963267948966) q[2], q[0], q[1]; // inplace_rot
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[2], q[1], q[0];
x q[1]; // want_negated=False
ctrl(3) @ gphase(0.0) q[1], q[2], q[0];
// BEGIN lifted_x
h q[4];
t q[4];
cx q[2], q[4];
x q[4];
inv @ t q[4];
h q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
h q[4];
t q[4];
cx q[2], q[4];
x q[4];
inv @ t q[4];
h q[4];
// END lifted_x
ccx q[4], q[0], q[3]; // inplace_x
// BEGIN unlifted_x
h q[4];
t q[4];
cx q[2], q[4];
x q[4];
inv @ t q[4];
h q[4];
cx q[1], q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
h q[4];
t q[4];
cx q[2], q[4];
x q[4];
inv @ t q[4];
h q[4];
// END unlifted_x
// BEGIN dup
h q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
h q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
h q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
h q[4];
// END dup
cp(3.141592653589793) q[4], q[0];
// BEGIN undup
h q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
h q[4];
cx q[1], q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
h q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
h q[4];
// END undup
ctrl(3) @ gphase(0.0) q[2], q[0], q[1];
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[2], q[1], q[0];
x q[1]; // want_negated=False
ctrl(2) @ ry(-1.5707963267948966) q[2], q[0], q[1]; // inplace_rot
x q[2]; // want_negated=True
ctrl(3) @ gphase(0.0) q[0], q[2], q[1];
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[2], q[1], q[0];
x q[1]; // want_negated=False
ctrl(2) @ ry(-1.5707963267948968) q[2], q[0], q[1]; // inplace_rot
x q[2]; // want_negated=False
ctrl(1) @ ry(-1.8754889808102941) q[0], q[2]; // inplace_rot
// BEGIN alloc
s q[4];
h q[4];
cx q[1], q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
h q[4];
sdg q[4];
// END alloc
// BEGIN dup
h q[5];
t q[5];
cx q[2], q[5];
inv @ t q[5];
h q[5];
t q[5];
cx q[0], q[5];
inv @ t q[5];
cx q[1], q[5];
x q[5];
t q[5];
cx q[0], q[5];
inv @ t q[5];
cx q[1], q[5];
x q[5];
h q[5];
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
h q[6];
t q[6];
cx q[0], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[0], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
h q[6];
t q[6];
cx q[2], q[6];
inv @ t q[6];
h q[6];
// END dup
// BEGIN dup
s q[7];
h q[7];
h q[7];
cx q[1], q[7];
x q[7];
t q[7];
cx q[0], q[7];
inv @ t q[7];
cx q[1], q[7];
x q[7];
t q[7];
cx q[0], q[7];
inv @ t q[7];
h q[7];
t q[7];
cx q[5], q[7];
inv @ t q[7];
h q[7];
t q[7];
cx q[0], q[7];
inv @ t q[7];
cx q[1], q[7];
x q[7];
t q[7];
cx q[0], q[7];
inv @ t q[7];
cx q[1], q[7];
x q[7];
h q[7];
t q[7];
cx q[5], q[7];
inv @ t q[7];
h q[7];
sdg q[7];
// END dup
// BEGIN alloc
s q[7];
h q[7];
cx q[1], q[7];
t q[7];
cx q[0], q[7];
inv @ t q[7];
cx q[1], q[7];
t q[7];
cx q[0], q[7];
inv @ t q[7];
h q[7];
sdg q[7];
// END alloc
// BEGIN dup
s q[4];
h q[4];
h q[4];
cx q[1], q[4];
x q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
x q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
h q[4];
t q[4];
cx q[6], q[4];
inv @ t q[4];
h q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
x q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
x q[4];
h q[4];
t q[4];
cx q[6], q[4];
inv @ t q[4];
h q[4];
sdg q[4];
// END dup
// BEGIN dup
s q[8];
h q[8];
h q[8];
cx q[7], q[8];
t q[8];
cx q[0], q[8];
inv @ t q[8];
cx q[7], q[8];
t q[8];
cx q[0], q[8];
inv @ t q[8];
h q[8];
t q[8];
cx q[4], q[8];
inv @ t q[8];
h q[8];
t q[8];
cx q[0], q[8];
inv @ t q[8];
cx q[7], q[8];
t q[8];
cx q[0], q[8];
inv @ t q[8];
cx q[7], q[8];
h q[8];
t q[8];
cx q[4], q[8];
inv @ t q[8];
h q[8];
sdg q[8];
// END dup
cp(3.141592653589793) q[8], q[0];
// BEGIN undup
s q[8];
h q[8];
t q[8];
cx q[4], q[8];
inv @ t q[8];
h q[8];
cx q[7], q[8];
t q[8];
cx q[0], q[8];
inv @ t q[8];
cx q[7], q[8];
t q[8];
cx q[0], q[8];
inv @ t q[8];
h q[8];
t q[8];
cx q[4], q[8];
inv @ t q[8];
h q[8];
t q[8];
cx q[0], q[8];
inv @ t q[8];
cx q[7], q[8];
t q[8];
cx q[0], q[8];
inv @ t q[8];
cx q[7], q[8];
h q[8];
h q[8];
sdg q[8];
// END undup
// BEGIN undup
s q[4];
h q[4];
t q[4];
cx q[6], q[4];
inv @ t q[4];
h q[4];
cx q[1], q[4];
x q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
x q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
h q[4];
t q[4];
cx q[6], q[4];
inv @ t q[4];
h q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
x q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
x q[4];
h q[4];
h q[4];
sdg q[4];
// END undup
// BEGIN undup
s q[7];
h q[7];
t q[7];
cx q[5], q[7];
inv @ t q[7];
h q[7];
cx q[1], q[7];
x q[7];
t q[7];
cx q[0], q[7];
inv @ t q[7];
cx q[1], q[7];
x q[7];
t q[7];
cx q[0], q[7];
inv @ t q[7];
h q[7];
t q[7];
cx q[5], q[7];
inv @ t q[7];
h q[7];
t q[7];
cx q[0], q[7];
inv @ t q[7];
cx q[1], q[7];
x q[7];
t q[7];
cx q[0], q[7];
inv @ t q[7];
cx q[1], q[7];
x q[7];
h q[7];
h q[7];
sdg q[7];
// END undup
// BEGIN dealloc
s q[7];
h q[7];
t q[7];
cx q[0], q[7];
inv @ t q[7];
cx q[1], q[7];
t q[7];
cx q[0], q[7];
inv @ t q[7];
cx q[1], q[7];
h q[7];
sdg q[7];
// END dealloc
// BEGIN undup
h q[6];
t q[6];
cx q[2], q[6];
inv @ t q[6];
h q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[0], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[0], q[6];
inv @ t q[6];
h q[6];
t q[6];
cx q[2], q[6];
inv @ t q[6];
h q[6];
// END undup
// BEGIN dup
s q[6];
h q[6];
h q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[0], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[0], q[6];
inv @ t q[6];
h q[6];
t q[6];
cx q[2], q[6];
inv @ t q[6];
h q[6];
t q[6];
cx q[0], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[0], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
h q[6];
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
h q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[0], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[0], q[6];
inv @ t q[6];
h q[6];
t q[6];
cx q[5], q[6];
inv @ t q[6];
h q[6];
t q[6];
cx q[0], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[0], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
h q[6];
h q[6];
sdg q[6];
// END undup
// BEGIN undup
h q[5];
t q[5];
cx q[2], q[5];
inv @ t q[5];
h q[5];
cx q[1], q[5];
x q[5];
t q[5];
cx q[0], q[5];
inv @ t q[5];
cx q[1], q[5];
x q[5];
t q[5];
cx q[0], q[5];
inv @ t q[5];
h q[5];
t q[5];
cx q[2], q[5];
inv @ t q[5];
h q[5];
// END undup
// BEGIN dealloc
s q[4];
h q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
h q[4];
sdg q[4];
// END dealloc
gphase(1.5707963267948966);
x q[0]; // want_negated=False
p(-3.141592653589793) q[0];
ry(0.07061931250846093) q[0]; // inplace_rot
p(3.141592653589793) q[0];
gphase(-1.5707963267948966);
x q[0]; // want_negated=True
ctrl(1) @ ry(1.8754889808102941) q[0], q[2]; // inplace_rot
x q[2]; // want_negated=True
ctrl(2) @ ry(1.5707963267948968) q[2], q[0], q[1]; // inplace_rot
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[1], q[2], q[0];
x q[1]; // want_negated=False
ctrl(3) @ gphase(0.0) q[2], q[0], q[1];
x q[2]; // want_negated=False
ctrl(2) @ ry(1.5707963267948966) q[0], q[2], q[1]; // inplace_rot
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[0], q[2], q[1];
x q[1]; // want_negated=False
ctrl(3) @ gphase(0.0) q[1], q[0], q[2];
// BEGIN lifted_x
h q[4];
t q[4];
cx q[2], q[4];
x q[4];
inv @ t q[4];
h q[4];
t q[4];
cx q[1], q[4];
inv @ t q[4];
cx q[0], q[4];
t q[4];
cx q[1], q[4];
inv @ t q[4];
cx q[0], q[4];
h q[4];
t q[4];
cx q[2], q[4];
x q[4];
inv @ t q[4];
h q[4];
// END lifted_x
ccx q[0], q[4], q[3]; // inplace_x
// BEGIN unlifted_x
h q[4];
t q[4];
cx q[2], q[4];
x q[4];
inv @ t q[4];
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
t q[4];
cx q[2], q[4];
x q[4];
inv @ t q[4];
h q[4];
// END unlifted_x
// BEGIN dup
h q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
h q[4];
t q[4];
cx q[1], q[4];
inv @ t q[4];
cx q[0], q[4];
t q[4];
cx q[1], q[4];
inv @ t q[4];
cx q[0], q[4];
h q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
h q[4];
// END dup
cp(3.141592653589793) q[0], q[4];
// BEGIN undup
h q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
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
t q[4];
cx q[2], q[4];
inv @ t q[4];
h q[4];
// END undup
ctrl(3) @ gphase(0.0) q[1], q[0], q[2];
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[1], q[0], q[2];
x q[1]; // want_negated=False
ctrl(2) @ ry(-1.5707963267948966) q[0], q[2], q[1]; // inplace_rot
x q[2]; // want_negated=True
ctrl(3) @ gphase(0.0) q[2], q[0], q[1];
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[1], q[2], q[0];
x q[1]; // want_negated=False
ctrl(2) @ ry(-1.5707963267948968) q[2], q[0], q[1]; // inplace_rot
x q[2]; // want_negated=False
ctrl(1) @ ry(-1.8754889808102941) q[0], q[2]; // inplace_rot
// BEGIN alloc
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
// END alloc
// BEGIN dup
h q[5];
t q[5];
cx q[2], q[5];
inv @ t q[5];
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
cx q[0], q[5];
h q[5];
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
h q[6];
t q[6];
cx q[1], q[6];
x q[6];
inv @ t q[6];
cx q[0], q[6];
t q[6];
cx q[1], q[6];
x q[6];
inv @ t q[6];
cx q[0], q[6];
h q[6];
t q[6];
cx q[2], q[6];
inv @ t q[6];
h q[6];
// END dup
// BEGIN dup
s q[7];
h q[7];
h q[7];
cx q[0], q[7];
t q[7];
cx q[1], q[7];
x q[7];
inv @ t q[7];
cx q[0], q[7];
t q[7];
cx q[1], q[7];
x q[7];
inv @ t q[7];
h q[7];
t q[7];
cx q[5], q[7];
inv @ t q[7];
h q[7];
t q[7];
cx q[1], q[7];
x q[7];
inv @ t q[7];
cx q[0], q[7];
t q[7];
cx q[1], q[7];
x q[7];
inv @ t q[7];
cx q[0], q[7];
h q[7];
t q[7];
cx q[5], q[7];
inv @ t q[7];
h q[7];
sdg q[7];
// END dup
// BEGIN alloc
s q[7];
h q[7];
cx q[0], q[7];
t q[7];
cx q[1], q[7];
inv @ t q[7];
cx q[0], q[7];
t q[7];
cx q[1], q[7];
inv @ t q[7];
h q[7];
sdg q[7];
// END alloc
// BEGIN dup
s q[4];
h q[4];
h q[4];
cx q[0], q[4];
t q[4];
cx q[1], q[4];
x q[4];
inv @ t q[4];
cx q[0], q[4];
t q[4];
cx q[1], q[4];
x q[4];
inv @ t q[4];
h q[4];
t q[4];
cx q[6], q[4];
inv @ t q[4];
h q[4];
t q[4];
cx q[1], q[4];
x q[4];
inv @ t q[4];
cx q[0], q[4];
t q[4];
cx q[1], q[4];
x q[4];
inv @ t q[4];
cx q[0], q[4];
h q[4];
t q[4];
cx q[6], q[4];
inv @ t q[4];
h q[4];
sdg q[4];
// END dup
// BEGIN dup
s q[8];
h q[8];
h q[8];
cx q[7], q[8];
t q[8];
cx q[0], q[8];
inv @ t q[8];
cx q[7], q[8];
t q[8];
cx q[0], q[8];
inv @ t q[8];
h q[8];
t q[8];
cx q[4], q[8];
inv @ t q[8];
h q[8];
t q[8];
cx q[0], q[8];
inv @ t q[8];
cx q[7], q[8];
t q[8];
cx q[0], q[8];
inv @ t q[8];
cx q[7], q[8];
h q[8];
t q[8];
cx q[4], q[8];
inv @ t q[8];
h q[8];
sdg q[8];
// END dup
cp(3.141592653589793) q[0], q[8];
// BEGIN undup
s q[8];
h q[8];
t q[8];
cx q[4], q[8];
inv @ t q[8];
h q[8];
cx q[7], q[8];
t q[8];
cx q[0], q[8];
inv @ t q[8];
cx q[7], q[8];
t q[8];
cx q[0], q[8];
inv @ t q[8];
h q[8];
t q[8];
cx q[4], q[8];
inv @ t q[8];
h q[8];
t q[8];
cx q[0], q[8];
inv @ t q[8];
cx q[7], q[8];
t q[8];
cx q[0], q[8];
inv @ t q[8];
cx q[7], q[8];
h q[8];
h q[8];
sdg q[8];
// END undup
// BEGIN undup
s q[4];
h q[4];
t q[4];
cx q[6], q[4];
inv @ t q[4];
h q[4];
cx q[0], q[4];
t q[4];
cx q[1], q[4];
x q[4];
inv @ t q[4];
cx q[0], q[4];
t q[4];
cx q[1], q[4];
x q[4];
inv @ t q[4];
h q[4];
t q[4];
cx q[6], q[4];
inv @ t q[4];
h q[4];
t q[4];
cx q[1], q[4];
x q[4];
inv @ t q[4];
cx q[0], q[4];
t q[4];
cx q[1], q[4];
x q[4];
inv @ t q[4];
cx q[0], q[4];
h q[4];
h q[4];
sdg q[4];
// END undup
// BEGIN undup
s q[7];
h q[7];
t q[7];
cx q[5], q[7];
inv @ t q[7];
h q[7];
cx q[0], q[7];
t q[7];
cx q[1], q[7];
x q[7];
inv @ t q[7];
cx q[0], q[7];
t q[7];
cx q[1], q[7];
x q[7];
inv @ t q[7];
h q[7];
t q[7];
cx q[5], q[7];
inv @ t q[7];
h q[7];
t q[7];
cx q[1], q[7];
x q[7];
inv @ t q[7];
cx q[0], q[7];
t q[7];
cx q[1], q[7];
x q[7];
inv @ t q[7];
cx q[0], q[7];
h q[7];
h q[7];
sdg q[7];
// END undup
// BEGIN dealloc
s q[7];
h q[7];
t q[7];
cx q[1], q[7];
inv @ t q[7];
cx q[0], q[7];
t q[7];
cx q[1], q[7];
inv @ t q[7];
cx q[0], q[7];
h q[7];
sdg q[7];
// END dealloc
// BEGIN undup
h q[6];
t q[6];
cx q[2], q[6];
inv @ t q[6];
h q[6];
cx q[0], q[6];
t q[6];
cx q[1], q[6];
x q[6];
inv @ t q[6];
cx q[0], q[6];
t q[6];
cx q[1], q[6];
x q[6];
inv @ t q[6];
h q[6];
t q[6];
cx q[2], q[6];
inv @ t q[6];
h q[6];
// END undup
// BEGIN dup
s q[6];
h q[6];
h q[6];
cx q[0], q[6];
t q[6];
cx q[1], q[6];
x q[6];
inv @ t q[6];
cx q[0], q[6];
t q[6];
cx q[1], q[6];
x q[6];
inv @ t q[6];
h q[6];
t q[6];
cx q[2], q[6];
inv @ t q[6];
h q[6];
t q[6];
cx q[1], q[6];
x q[6];
inv @ t q[6];
cx q[0], q[6];
t q[6];
cx q[1], q[6];
x q[6];
inv @ t q[6];
cx q[0], q[6];
h q[6];
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
h q[6];
cx q[0], q[6];
t q[6];
cx q[1], q[6];
x q[6];
inv @ t q[6];
cx q[0], q[6];
t q[6];
cx q[1], q[6];
x q[6];
inv @ t q[6];
h q[6];
t q[6];
cx q[5], q[6];
inv @ t q[6];
h q[6];
t q[6];
cx q[1], q[6];
x q[6];
inv @ t q[6];
cx q[0], q[6];
t q[6];
cx q[1], q[6];
x q[6];
inv @ t q[6];
cx q[0], q[6];
h q[6];
h q[6];
sdg q[6];
// END undup
// BEGIN undup
h q[5];
t q[5];
cx q[2], q[5];
inv @ t q[5];
h q[5];
cx q[0], q[5];
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
t q[5];
cx q[2], q[5];
inv @ t q[5];
h q[5];
// END undup
// BEGIN dealloc
s q[4];
h q[4];
t q[4];
cx q[1], q[4];
inv @ t q[4];
cx q[0], q[4];
t q[4];
cx q[1], q[4];
inv @ t q[4];
cx q[0], q[4];
h q[4];
sdg q[4];
// END dealloc
gphase(0.0);
x q[0]; // want_negated=False
p(0.0) q[0];
ry(0.0) q[0]; // inplace_rot
p(0.0) q[0];
gphase(0.0);
x q[0]; // want_negated=True
ctrl(1) @ ry(1.8754889808102941) q[0], q[2]; // inplace_rot
x q[2]; // want_negated=True
ctrl(2) @ ry(1.5707963267948968) q[2], q[0], q[1]; // inplace_rot
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[2], q[1], q[0];
x q[1]; // want_negated=False
ctrl(3) @ gphase(0.0) q[1], q[2], q[0];
x q[2]; // want_negated=False
ctrl(2) @ ry(1.5707963267948966) q[2], q[0], q[1]; // inplace_rot
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[1], q[2], q[0];
x q[1]; // want_negated=False
ctrl(3) @ gphase(0.0) q[1], q[2], q[0];
// BEGIN lifted_x
h q[4];
t q[4];
cx q[2], q[4];
x q[4];
inv @ t q[4];
h q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
h q[4];
t q[4];
cx q[2], q[4];
x q[4];
inv @ t q[4];
h q[4];
// END lifted_x
ccx q[4], q[0], q[3]; // inplace_x
// BEGIN unlifted_x
h q[4];
t q[4];
cx q[2], q[4];
x q[4];
inv @ t q[4];
h q[4];
cx q[1], q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
h q[4];
t q[4];
cx q[2], q[4];
x q[4];
inv @ t q[4];
h q[4];
// END unlifted_x
// BEGIN dup
h q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
h q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
h q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
h q[4];
// END dup
cp(3.141592653589793) q[4], q[0];
// BEGIN undup
h q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
h q[4];
cx q[1], q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
h q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
h q[4];
// END undup
ctrl(3) @ gphase(0.0) q[0], q[2], q[1];
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[1], q[2], q[0];
x q[1]; // want_negated=False
ctrl(2) @ ry(-1.5707963267948966) q[2], q[0], q[1]; // inplace_rot
x q[2]; // want_negated=True
ctrl(3) @ gphase(0.0) q[1], q[2], q[0];
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[2], q[0], q[1];
x q[1]; // want_negated=False
ctrl(2) @ ry(-1.5707963267948968) q[2], q[0], q[1]; // inplace_rot
x q[2]; // want_negated=False
ctrl(1) @ ry(-1.8754889808102941) q[0], q[2]; // inplace_rot
// BEGIN alloc
s q[4];
h q[4];
cx q[1], q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
h q[4];
sdg q[4];
// END alloc
// BEGIN dup
h q[5];
t q[5];
cx q[2], q[5];
inv @ t q[5];
h q[5];
t q[5];
cx q[0], q[5];
inv @ t q[5];
cx q[1], q[5];
x q[5];
t q[5];
cx q[0], q[5];
inv @ t q[5];
cx q[1], q[5];
x q[5];
h q[5];
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
h q[6];
t q[6];
cx q[0], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[0], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
h q[6];
t q[6];
cx q[2], q[6];
inv @ t q[6];
h q[6];
// END dup
// BEGIN dup
s q[7];
h q[7];
h q[7];
cx q[1], q[7];
x q[7];
t q[7];
cx q[0], q[7];
inv @ t q[7];
cx q[1], q[7];
x q[7];
t q[7];
cx q[0], q[7];
inv @ t q[7];
h q[7];
t q[7];
cx q[5], q[7];
inv @ t q[7];
h q[7];
t q[7];
cx q[0], q[7];
inv @ t q[7];
cx q[1], q[7];
x q[7];
t q[7];
cx q[0], q[7];
inv @ t q[7];
cx q[1], q[7];
x q[7];
h q[7];
t q[7];
cx q[5], q[7];
inv @ t q[7];
h q[7];
sdg q[7];
// END dup
// BEGIN alloc
s q[7];
h q[7];
cx q[1], q[7];
t q[7];
cx q[0], q[7];
inv @ t q[7];
cx q[1], q[7];
t q[7];
cx q[0], q[7];
inv @ t q[7];
h q[7];
sdg q[7];
// END alloc
// BEGIN dup
s q[4];
h q[4];
h q[4];
cx q[1], q[4];
x q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
x q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
h q[4];
t q[4];
cx q[6], q[4];
inv @ t q[4];
h q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
x q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
x q[4];
h q[4];
t q[4];
cx q[6], q[4];
inv @ t q[4];
h q[4];
sdg q[4];
// END dup
// BEGIN dup
s q[8];
h q[8];
h q[8];
cx q[7], q[8];
t q[8];
cx q[0], q[8];
inv @ t q[8];
cx q[7], q[8];
t q[8];
cx q[0], q[8];
inv @ t q[8];
h q[8];
t q[8];
cx q[4], q[8];
inv @ t q[8];
h q[8];
t q[8];
cx q[0], q[8];
inv @ t q[8];
cx q[7], q[8];
t q[8];
cx q[0], q[8];
inv @ t q[8];
cx q[7], q[8];
h q[8];
t q[8];
cx q[4], q[8];
inv @ t q[8];
h q[8];
sdg q[8];
// END dup
cp(3.141592653589793) q[8], q[0];
// BEGIN undup
s q[8];
h q[8];
t q[8];
cx q[4], q[8];
inv @ t q[8];
h q[8];
cx q[7], q[8];
t q[8];
cx q[0], q[8];
inv @ t q[8];
cx q[7], q[8];
t q[8];
cx q[0], q[8];
inv @ t q[8];
h q[8];
t q[8];
cx q[4], q[8];
inv @ t q[8];
h q[8];
t q[8];
cx q[0], q[8];
inv @ t q[8];
cx q[7], q[8];
t q[8];
cx q[0], q[8];
inv @ t q[8];
cx q[7], q[8];
h q[8];
h q[8];
sdg q[8];
// END undup
// BEGIN undup
s q[4];
h q[4];
t q[4];
cx q[6], q[4];
inv @ t q[4];
h q[4];
cx q[1], q[4];
x q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
x q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
h q[4];
t q[4];
cx q[6], q[4];
inv @ t q[4];
h q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
x q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
x q[4];
h q[4];
h q[4];
sdg q[4];
// END undup
// BEGIN undup
s q[7];
h q[7];
t q[7];
cx q[5], q[7];
inv @ t q[7];
h q[7];
cx q[1], q[7];
x q[7];
t q[7];
cx q[0], q[7];
inv @ t q[7];
cx q[1], q[7];
x q[7];
t q[7];
cx q[0], q[7];
inv @ t q[7];
h q[7];
t q[7];
cx q[5], q[7];
inv @ t q[7];
h q[7];
t q[7];
cx q[0], q[7];
inv @ t q[7];
cx q[1], q[7];
x q[7];
t q[7];
cx q[0], q[7];
inv @ t q[7];
cx q[1], q[7];
x q[7];
h q[7];
h q[7];
sdg q[7];
// END undup
// BEGIN dealloc
s q[7];
h q[7];
t q[7];
cx q[0], q[7];
inv @ t q[7];
cx q[1], q[7];
t q[7];
cx q[0], q[7];
inv @ t q[7];
cx q[1], q[7];
h q[7];
sdg q[7];
// END dealloc
// BEGIN undup
h q[6];
t q[6];
cx q[2], q[6];
inv @ t q[6];
h q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[0], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[0], q[6];
inv @ t q[6];
h q[6];
t q[6];
cx q[2], q[6];
inv @ t q[6];
h q[6];
// END undup
// BEGIN dup
s q[6];
h q[6];
h q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[0], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[0], q[6];
inv @ t q[6];
h q[6];
t q[6];
cx q[2], q[6];
inv @ t q[6];
h q[6];
t q[6];
cx q[0], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[0], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
h q[6];
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
h q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[0], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[0], q[6];
inv @ t q[6];
h q[6];
t q[6];
cx q[5], q[6];
inv @ t q[6];
h q[6];
t q[6];
cx q[0], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[0], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
h q[6];
h q[6];
sdg q[6];
// END undup
// BEGIN undup
h q[5];
t q[5];
cx q[2], q[5];
inv @ t q[5];
h q[5];
cx q[1], q[5];
x q[5];
t q[5];
cx q[0], q[5];
inv @ t q[5];
cx q[1], q[5];
x q[5];
t q[5];
cx q[0], q[5];
inv @ t q[5];
h q[5];
t q[5];
cx q[2], q[5];
inv @ t q[5];
h q[5];
// END undup
// BEGIN dealloc
s q[4];
h q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
h q[4];
sdg q[4];
// END dealloc
gphase(4.1082855084235976e-17);
x q[0]; // want_negated=False
p(-8.216571016847195e-17) q[0];
ry(0.09768826570208763) q[0]; // inplace_rot
p(8.216571016847195e-17) q[0];
gphase(-4.1082855084235976e-17);
x q[0]; // want_negated=True
ctrl(1) @ ry(1.8754889808102941) q[0], q[2]; // inplace_rot
x q[2]; // want_negated=True
ctrl(2) @ ry(1.5707963267948968) q[2], q[0], q[1]; // inplace_rot
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[2], q[0], q[1];
x q[1]; // want_negated=False
ctrl(3) @ gphase(0.0) q[2], q[0], q[1];
x q[2]; // want_negated=False
ctrl(2) @ ry(1.5707963267948966) q[2], q[0], q[1]; // inplace_rot
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[2], q[0], q[1];
x q[1]; // want_negated=False
ctrl(3) @ gphase(0.0) q[2], q[0], q[1];
// BEGIN lifted_x
h q[4];
t q[4];
cx q[2], q[4];
x q[4];
inv @ t q[4];
h q[4];
t q[4];
cx q[1], q[4];
inv @ t q[4];
cx q[0], q[4];
t q[4];
cx q[1], q[4];
inv @ t q[4];
cx q[0], q[4];
h q[4];
t q[4];
cx q[2], q[4];
x q[4];
inv @ t q[4];
h q[4];
// END lifted_x
ccx q[0], q[4], q[3]; // inplace_x
// BEGIN unlifted_x
h q[4];
t q[4];
cx q[2], q[4];
x q[4];
inv @ t q[4];
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
t q[4];
cx q[2], q[4];
x q[4];
inv @ t q[4];
h q[4];
// END unlifted_x
// BEGIN dup
h q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
h q[4];
t q[4];
cx q[1], q[4];
inv @ t q[4];
cx q[0], q[4];
t q[4];
cx q[1], q[4];
inv @ t q[4];
cx q[0], q[4];
h q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
h q[4];
// END dup
cp(3.141592653589793) q[4], q[0];
// BEGIN undup
h q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
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
t q[4];
cx q[2], q[4];
inv @ t q[4];
h q[4];
// END undup
ctrl(3) @ gphase(0.0) q[2], q[0], q[1];
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[2], q[0], q[1];
x q[1]; // want_negated=False
ctrl(2) @ ry(-1.5707963267948966) q[2], q[0], q[1]; // inplace_rot
x q[2]; // want_negated=True
ctrl(3) @ gphase(0.0) q[2], q[0], q[1];
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[2], q[0], q[1];
x q[1]; // want_negated=False
ctrl(2) @ ry(-1.5707963267948968) q[2], q[0], q[1]; // inplace_rot
x q[2]; // want_negated=False
ctrl(1) @ ry(-1.8754889808102941) q[0], q[2]; // inplace_rot
// BEGIN alloc
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
// END alloc
// BEGIN dup
h q[5];
t q[5];
cx q[2], q[5];
inv @ t q[5];
h q[5];
t q[5];
cx q[0], q[5];
inv @ t q[5];
cx q[1], q[5];
x q[5];
t q[5];
cx q[0], q[5];
inv @ t q[5];
cx q[1], q[5];
x q[5];
h q[5];
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
h q[6];
t q[6];
cx q[0], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[0], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
h q[6];
t q[6];
cx q[2], q[6];
inv @ t q[6];
h q[6];
// END dup
// BEGIN dup
s q[7];
h q[7];
h q[7];
cx q[1], q[7];
x q[7];
t q[7];
cx q[0], q[7];
inv @ t q[7];
cx q[1], q[7];
x q[7];
t q[7];
cx q[0], q[7];
inv @ t q[7];
h q[7];
t q[7];
cx q[5], q[7];
inv @ t q[7];
h q[7];
t q[7];
cx q[0], q[7];
inv @ t q[7];
cx q[1], q[7];
x q[7];
t q[7];
cx q[0], q[7];
inv @ t q[7];
cx q[1], q[7];
x q[7];
h q[7];
t q[7];
cx q[5], q[7];
inv @ t q[7];
h q[7];
sdg q[7];
// END dup
// BEGIN alloc
s q[7];
h q[7];
cx q[0], q[7];
t q[7];
cx q[1], q[7];
inv @ t q[7];
cx q[0], q[7];
t q[7];
cx q[1], q[7];
inv @ t q[7];
h q[7];
sdg q[7];
// END alloc
// BEGIN dup
s q[4];
h q[4];
h q[4];
cx q[1], q[4];
x q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
x q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
h q[4];
t q[4];
cx q[6], q[4];
inv @ t q[4];
h q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
x q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
x q[4];
h q[4];
t q[4];
cx q[6], q[4];
inv @ t q[4];
h q[4];
sdg q[4];
// END dup
// BEGIN dup
s q[8];
h q[8];
h q[8];
cx q[0], q[8];
t q[8];
cx q[7], q[8];
inv @ t q[8];
cx q[0], q[8];
t q[8];
cx q[7], q[8];
inv @ t q[8];
h q[8];
t q[8];
cx q[4], q[8];
inv @ t q[8];
h q[8];
t q[8];
cx q[7], q[8];
inv @ t q[8];
cx q[0], q[8];
t q[8];
cx q[7], q[8];
inv @ t q[8];
cx q[0], q[8];
h q[8];
t q[8];
cx q[4], q[8];
inv @ t q[8];
h q[8];
sdg q[8];
// END dup
cp(3.141592653589793) q[0], q[8];
// BEGIN undup
s q[8];
h q[8];
t q[8];
cx q[4], q[8];
inv @ t q[8];
h q[8];
cx q[0], q[8];
t q[8];
cx q[7], q[8];
inv @ t q[8];
cx q[0], q[8];
t q[8];
cx q[7], q[8];
inv @ t q[8];
h q[8];
t q[8];
cx q[4], q[8];
inv @ t q[8];
h q[8];
t q[8];
cx q[7], q[8];
inv @ t q[8];
cx q[0], q[8];
t q[8];
cx q[7], q[8];
inv @ t q[8];
cx q[0], q[8];
h q[8];
h q[8];
sdg q[8];
// END undup
// BEGIN undup
s q[4];
h q[4];
t q[4];
cx q[6], q[4];
inv @ t q[4];
h q[4];
cx q[1], q[4];
x q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
x q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
h q[4];
t q[4];
cx q[6], q[4];
inv @ t q[4];
h q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
x q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
x q[4];
h q[4];
h q[4];
sdg q[4];
// END undup
// BEGIN undup
s q[7];
h q[7];
t q[7];
cx q[5], q[7];
inv @ t q[7];
h q[7];
cx q[1], q[7];
x q[7];
t q[7];
cx q[0], q[7];
inv @ t q[7];
cx q[1], q[7];
x q[7];
t q[7];
cx q[0], q[7];
inv @ t q[7];
h q[7];
t q[7];
cx q[5], q[7];
inv @ t q[7];
h q[7];
t q[7];
cx q[0], q[7];
inv @ t q[7];
cx q[1], q[7];
x q[7];
t q[7];
cx q[0], q[7];
inv @ t q[7];
cx q[1], q[7];
x q[7];
h q[7];
h q[7];
sdg q[7];
// END undup
// BEGIN dealloc
s q[7];
h q[7];
t q[7];
cx q[1], q[7];
inv @ t q[7];
cx q[0], q[7];
t q[7];
cx q[1], q[7];
inv @ t q[7];
cx q[0], q[7];
h q[7];
sdg q[7];
// END dealloc
// BEGIN undup
h q[6];
t q[6];
cx q[2], q[6];
inv @ t q[6];
h q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[0], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[0], q[6];
inv @ t q[6];
h q[6];
t q[6];
cx q[2], q[6];
inv @ t q[6];
h q[6];
// END undup
// BEGIN dup
s q[6];
h q[6];
h q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[0], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[0], q[6];
inv @ t q[6];
h q[6];
t q[6];
cx q[2], q[6];
inv @ t q[6];
h q[6];
t q[6];
cx q[0], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[0], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
h q[6];
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
h q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[0], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[0], q[6];
inv @ t q[6];
h q[6];
t q[6];
cx q[5], q[6];
inv @ t q[6];
h q[6];
t q[6];
cx q[0], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[0], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
h q[6];
h q[6];
sdg q[6];
// END undup
// BEGIN undup
h q[5];
t q[5];
cx q[2], q[5];
inv @ t q[5];
h q[5];
cx q[1], q[5];
x q[5];
t q[5];
cx q[0], q[5];
inv @ t q[5];
cx q[1], q[5];
x q[5];
t q[5];
cx q[0], q[5];
inv @ t q[5];
h q[5];
t q[5];
cx q[2], q[5];
inv @ t q[5];
h q[5];
// END undup
// BEGIN dealloc
s q[4];
h q[4];
t q[4];
cx q[1], q[4];
inv @ t q[4];
cx q[0], q[4];
t q[4];
cx q[1], q[4];
inv @ t q[4];
cx q[0], q[4];
h q[4];
sdg q[4];
// END dealloc
gphase(0.0);
x q[0]; // want_negated=False
p(0.0) q[0];
ry(0.0) q[0]; // inplace_rot
p(0.0) q[0];
gphase(0.0);
x q[0]; // want_negated=True
ctrl(1) @ ry(1.8754889808102941) q[0], q[2]; // inplace_rot
x q[2]; // want_negated=True
ctrl(2) @ ry(1.5707963267948968) q[2], q[0], q[1]; // inplace_rot
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[2], q[0], q[1];
x q[1]; // want_negated=False
ctrl(3) @ gphase(0.0) q[2], q[0], q[1];
x q[2]; // want_negated=False
ctrl(2) @ ry(1.5707963267948966) q[0], q[2], q[1]; // inplace_rot
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[0], q[1], q[2];
x q[1]; // want_negated=False
ctrl(3) @ gphase(0.0) q[0], q[2], q[1];
// BEGIN lifted_x
h q[4];
t q[4];
cx q[2], q[4];
x q[4];
inv @ t q[4];
h q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
h q[4];
t q[4];
cx q[2], q[4];
x q[4];
inv @ t q[4];
h q[4];
// END lifted_x
ccx q[4], q[0], q[3]; // inplace_x
// BEGIN unlifted_x
h q[4];
t q[4];
cx q[2], q[4];
x q[4];
inv @ t q[4];
h q[4];
cx q[1], q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
h q[4];
t q[4];
cx q[2], q[4];
x q[4];
inv @ t q[4];
h q[4];
// END unlifted_x
// BEGIN dup
h q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
h q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
h q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
h q[4];
// END dup
cp(3.141592653589793) q[0], q[4];
// BEGIN undup
h q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
h q[4];
cx q[1], q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
h q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
h q[4];
// END undup
ctrl(3) @ gphase(0.0) q[0], q[1], q[2];
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[1], q[0], q[2];
x q[1]; // want_negated=False
ctrl(2) @ ry(-1.5707963267948966) q[0], q[2], q[1]; // inplace_rot
x q[2]; // want_negated=True
ctrl(3) @ gphase(0.0) q[2], q[0], q[1];
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[2], q[0], q[1];
x q[1]; // want_negated=False
ctrl(2) @ ry(-1.5707963267948968) q[2], q[0], q[1]; // inplace_rot
x q[2]; // want_negated=False
ctrl(1) @ ry(-1.8754889808102941) q[0], q[2]; // inplace_rot
// BEGIN alloc
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
// END alloc
// BEGIN dup
h q[5];
t q[5];
cx q[2], q[5];
inv @ t q[5];
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
cx q[0], q[5];
h q[5];
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
h q[6];
t q[6];
cx q[1], q[6];
x q[6];
inv @ t q[6];
cx q[0], q[6];
t q[6];
cx q[1], q[6];
x q[6];
inv @ t q[6];
cx q[0], q[6];
h q[6];
t q[6];
cx q[2], q[6];
inv @ t q[6];
h q[6];
// END dup
// BEGIN dup
s q[7];
h q[7];
h q[7];
cx q[0], q[7];
t q[7];
cx q[1], q[7];
x q[7];
inv @ t q[7];
cx q[0], q[7];
t q[7];
cx q[1], q[7];
x q[7];
inv @ t q[7];
h q[7];
t q[7];
cx q[5], q[7];
inv @ t q[7];
h q[7];
t q[7];
cx q[1], q[7];
x q[7];
inv @ t q[7];
cx q[0], q[7];
t q[7];
cx q[1], q[7];
x q[7];
inv @ t q[7];
cx q[0], q[7];
h q[7];
t q[7];
cx q[5], q[7];
inv @ t q[7];
h q[7];
sdg q[7];
// END dup
// BEGIN alloc
s q[7];
h q[7];
cx q[0], q[7];
t q[7];
cx q[1], q[7];
inv @ t q[7];
cx q[0], q[7];
t q[7];
cx q[1], q[7];
inv @ t q[7];
h q[7];
sdg q[7];
// END alloc
// BEGIN dup
s q[4];
h q[4];
h q[4];
cx q[0], q[4];
t q[4];
cx q[1], q[4];
x q[4];
inv @ t q[4];
cx q[0], q[4];
t q[4];
cx q[1], q[4];
x q[4];
inv @ t q[4];
h q[4];
t q[4];
cx q[6], q[4];
inv @ t q[4];
h q[4];
t q[4];
cx q[1], q[4];
x q[4];
inv @ t q[4];
cx q[0], q[4];
t q[4];
cx q[1], q[4];
x q[4];
inv @ t q[4];
cx q[0], q[4];
h q[4];
t q[4];
cx q[6], q[4];
inv @ t q[4];
h q[4];
sdg q[4];
// END dup
// BEGIN dup
s q[8];
h q[8];
h q[8];
cx q[0], q[8];
t q[8];
cx q[7], q[8];
inv @ t q[8];
cx q[0], q[8];
t q[8];
cx q[7], q[8];
inv @ t q[8];
h q[8];
t q[8];
cx q[4], q[8];
inv @ t q[8];
h q[8];
t q[8];
cx q[7], q[8];
inv @ t q[8];
cx q[0], q[8];
t q[8];
cx q[7], q[8];
inv @ t q[8];
cx q[0], q[8];
h q[8];
t q[8];
cx q[4], q[8];
inv @ t q[8];
h q[8];
sdg q[8];
// END dup
cp(3.141592653589793) q[8], q[0];
// BEGIN undup
s q[8];
h q[8];
t q[8];
cx q[4], q[8];
inv @ t q[8];
h q[8];
cx q[0], q[8];
t q[8];
cx q[7], q[8];
inv @ t q[8];
cx q[0], q[8];
t q[8];
cx q[7], q[8];
inv @ t q[8];
h q[8];
t q[8];
cx q[4], q[8];
inv @ t q[8];
h q[8];
t q[8];
cx q[7], q[8];
inv @ t q[8];
cx q[0], q[8];
t q[8];
cx q[7], q[8];
inv @ t q[8];
cx q[0], q[8];
h q[8];
h q[8];
sdg q[8];
// END undup
// BEGIN undup
s q[4];
h q[4];
t q[4];
cx q[6], q[4];
inv @ t q[4];
h q[4];
cx q[0], q[4];
t q[4];
cx q[1], q[4];
x q[4];
inv @ t q[4];
cx q[0], q[4];
t q[4];
cx q[1], q[4];
x q[4];
inv @ t q[4];
h q[4];
t q[4];
cx q[6], q[4];
inv @ t q[4];
h q[4];
t q[4];
cx q[1], q[4];
x q[4];
inv @ t q[4];
cx q[0], q[4];
t q[4];
cx q[1], q[4];
x q[4];
inv @ t q[4];
cx q[0], q[4];
h q[4];
h q[4];
sdg q[4];
// END undup
// BEGIN undup
s q[7];
h q[7];
t q[7];
cx q[5], q[7];
inv @ t q[7];
h q[7];
cx q[0], q[7];
t q[7];
cx q[1], q[7];
x q[7];
inv @ t q[7];
cx q[0], q[7];
t q[7];
cx q[1], q[7];
x q[7];
inv @ t q[7];
h q[7];
t q[7];
cx q[5], q[7];
inv @ t q[7];
h q[7];
t q[7];
cx q[1], q[7];
x q[7];
inv @ t q[7];
cx q[0], q[7];
t q[7];
cx q[1], q[7];
x q[7];
inv @ t q[7];
cx q[0], q[7];
h q[7];
h q[7];
sdg q[7];
// END undup
// BEGIN dealloc
s q[7];
h q[7];
t q[7];
cx q[1], q[7];
inv @ t q[7];
cx q[0], q[7];
t q[7];
cx q[1], q[7];
inv @ t q[7];
cx q[0], q[7];
h q[7];
sdg q[7];
// END dealloc
// BEGIN undup
h q[6];
t q[6];
cx q[2], q[6];
inv @ t q[6];
h q[6];
cx q[0], q[6];
t q[6];
cx q[1], q[6];
x q[6];
inv @ t q[6];
cx q[0], q[6];
t q[6];
cx q[1], q[6];
x q[6];
inv @ t q[6];
h q[6];
t q[6];
cx q[2], q[6];
inv @ t q[6];
h q[6];
// END undup
// BEGIN dup
s q[6];
h q[6];
h q[6];
cx q[0], q[6];
t q[6];
cx q[1], q[6];
x q[6];
inv @ t q[6];
cx q[0], q[6];
t q[6];
cx q[1], q[6];
x q[6];
inv @ t q[6];
h q[6];
t q[6];
cx q[2], q[6];
inv @ t q[6];
h q[6];
t q[6];
cx q[1], q[6];
x q[6];
inv @ t q[6];
cx q[0], q[6];
t q[6];
cx q[1], q[6];
x q[6];
inv @ t q[6];
cx q[0], q[6];
h q[6];
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
h q[6];
cx q[0], q[6];
t q[6];
cx q[1], q[6];
x q[6];
inv @ t q[6];
cx q[0], q[6];
t q[6];
cx q[1], q[6];
x q[6];
inv @ t q[6];
h q[6];
t q[6];
cx q[5], q[6];
inv @ t q[6];
h q[6];
t q[6];
cx q[1], q[6];
x q[6];
inv @ t q[6];
cx q[0], q[6];
t q[6];
cx q[1], q[6];
x q[6];
inv @ t q[6];
cx q[0], q[6];
h q[6];
h q[6];
sdg q[6];
// END undup
// BEGIN undup
h q[5];
t q[5];
cx q[2], q[5];
inv @ t q[5];
h q[5];
cx q[0], q[5];
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
t q[5];
cx q[2], q[5];
inv @ t q[5];
h q[5];
// END undup
// BEGIN dealloc
s q[4];
h q[4];
t q[4];
cx q[1], q[4];
inv @ t q[4];
cx q[0], q[4];
t q[4];
cx q[1], q[4];
inv @ t q[4];
cx q[0], q[4];
h q[4];
sdg q[4];
// END dealloc
gphase(1.5707963267948966);
x q[0]; // want_negated=False
p(-3.141592653589793) q[0];
ry(0.12917087085113513) q[0]; // inplace_rot
p(3.141592653589793) q[0];
gphase(-1.5707963267948966);
x q[0]; // want_negated=True
ctrl(1) @ ry(1.8754889808102941) q[0], q[2]; // inplace_rot
x q[2]; // want_negated=True
ctrl(2) @ ry(1.5707963267948968) q[0], q[2], q[1]; // inplace_rot
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[0], q[1], q[2];
x q[1]; // want_negated=False
ctrl(3) @ gphase(0.0) q[1], q[0], q[2];
x q[2]; // want_negated=False
ctrl(2) @ ry(1.5707963267948966) q[2], q[0], q[1]; // inplace_rot
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[1], q[2], q[0];
x q[1]; // want_negated=False
ctrl(3) @ gphase(0.0) q[1], q[2], q[0];
// BEGIN lifted_x
h q[4];
t q[4];
cx q[2], q[4];
x q[4];
inv @ t q[4];
h q[4];
t q[4];
cx q[1], q[4];
inv @ t q[4];
cx q[0], q[4];
t q[4];
cx q[1], q[4];
inv @ t q[4];
cx q[0], q[4];
h q[4];
t q[4];
cx q[2], q[4];
x q[4];
inv @ t q[4];
h q[4];
// END lifted_x
ccx q[4], q[0], q[3]; // inplace_x
// BEGIN unlifted_x
h q[4];
t q[4];
cx q[2], q[4];
x q[4];
inv @ t q[4];
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
t q[4];
cx q[2], q[4];
x q[4];
inv @ t q[4];
h q[4];
// END unlifted_x
// BEGIN dup
h q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
h q[4];
t q[4];
cx q[1], q[4];
inv @ t q[4];
cx q[0], q[4];
t q[4];
cx q[1], q[4];
inv @ t q[4];
cx q[0], q[4];
h q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
h q[4];
// END dup
cp(3.141592653589793) q[0], q[4];
// BEGIN undup
h q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
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
t q[4];
cx q[2], q[4];
inv @ t q[4];
h q[4];
// END undup
ctrl(3) @ gphase(0.0) q[2], q[0], q[1];
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[2], q[0], q[1];
x q[1]; // want_negated=False
ctrl(2) @ ry(-1.5707963267948966) q[2], q[0], q[1]; // inplace_rot
x q[2]; // want_negated=True
ctrl(3) @ gphase(0.0) q[0], q[1], q[2];
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[2], q[0], q[1];
x q[1]; // want_negated=False
ctrl(2) @ ry(-1.5707963267948968) q[0], q[2], q[1]; // inplace_rot
x q[2]; // want_negated=False
ctrl(1) @ ry(-1.8754889808102941) q[0], q[2]; // inplace_rot
// BEGIN alloc
s q[4];
h q[4];
cx q[1], q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
h q[4];
sdg q[4];
// END alloc
// BEGIN dup
h q[5];
t q[5];
cx q[2], q[5];
inv @ t q[5];
h q[5];
t q[5];
cx q[0], q[5];
inv @ t q[5];
cx q[1], q[5];
x q[5];
t q[5];
cx q[0], q[5];
inv @ t q[5];
cx q[1], q[5];
x q[5];
h q[5];
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
h q[6];
t q[6];
cx q[0], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[0], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
h q[6];
t q[6];
cx q[2], q[6];
inv @ t q[6];
h q[6];
// END dup
// BEGIN dup
s q[7];
h q[7];
h q[7];
cx q[1], q[7];
x q[7];
t q[7];
cx q[0], q[7];
inv @ t q[7];
cx q[1], q[7];
x q[7];
t q[7];
cx q[0], q[7];
inv @ t q[7];
h q[7];
t q[7];
cx q[5], q[7];
inv @ t q[7];
h q[7];
t q[7];
cx q[0], q[7];
inv @ t q[7];
cx q[1], q[7];
x q[7];
t q[7];
cx q[0], q[7];
inv @ t q[7];
cx q[1], q[7];
x q[7];
h q[7];
t q[7];
cx q[5], q[7];
inv @ t q[7];
h q[7];
sdg q[7];
// END dup
// BEGIN alloc
s q[7];
h q[7];
cx q[1], q[7];
t q[7];
cx q[0], q[7];
inv @ t q[7];
cx q[1], q[7];
t q[7];
cx q[0], q[7];
inv @ t q[7];
h q[7];
sdg q[7];
// END alloc
// BEGIN dup
s q[4];
h q[4];
h q[4];
cx q[1], q[4];
x q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
x q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
h q[4];
t q[4];
cx q[6], q[4];
inv @ t q[4];
h q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
x q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
x q[4];
h q[4];
t q[4];
cx q[6], q[4];
inv @ t q[4];
h q[4];
sdg q[4];
// END dup
// BEGIN dup
s q[8];
h q[8];
h q[8];
cx q[7], q[8];
t q[8];
cx q[0], q[8];
inv @ t q[8];
cx q[7], q[8];
t q[8];
cx q[0], q[8];
inv @ t q[8];
h q[8];
t q[8];
cx q[4], q[8];
inv @ t q[8];
h q[8];
t q[8];
cx q[0], q[8];
inv @ t q[8];
cx q[7], q[8];
t q[8];
cx q[0], q[8];
inv @ t q[8];
cx q[7], q[8];
h q[8];
t q[8];
cx q[4], q[8];
inv @ t q[8];
h q[8];
sdg q[8];
// END dup
cp(3.141592653589793) q[8], q[0];
// BEGIN undup
s q[8];
h q[8];
t q[8];
cx q[4], q[8];
inv @ t q[8];
h q[8];
cx q[7], q[8];
t q[8];
cx q[0], q[8];
inv @ t q[8];
cx q[7], q[8];
t q[8];
cx q[0], q[8];
inv @ t q[8];
h q[8];
t q[8];
cx q[4], q[8];
inv @ t q[8];
h q[8];
t q[8];
cx q[0], q[8];
inv @ t q[8];
cx q[7], q[8];
t q[8];
cx q[0], q[8];
inv @ t q[8];
cx q[7], q[8];
h q[8];
h q[8];
sdg q[8];
// END undup
// BEGIN undup
s q[4];
h q[4];
t q[4];
cx q[6], q[4];
inv @ t q[4];
h q[4];
cx q[1], q[4];
x q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
x q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
h q[4];
t q[4];
cx q[6], q[4];
inv @ t q[4];
h q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
x q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
x q[4];
h q[4];
h q[4];
sdg q[4];
// END undup
// BEGIN undup
s q[7];
h q[7];
t q[7];
cx q[5], q[7];
inv @ t q[7];
h q[7];
cx q[1], q[7];
x q[7];
t q[7];
cx q[0], q[7];
inv @ t q[7];
cx q[1], q[7];
x q[7];
t q[7];
cx q[0], q[7];
inv @ t q[7];
h q[7];
t q[7];
cx q[5], q[7];
inv @ t q[7];
h q[7];
t q[7];
cx q[0], q[7];
inv @ t q[7];
cx q[1], q[7];
x q[7];
t q[7];
cx q[0], q[7];
inv @ t q[7];
cx q[1], q[7];
x q[7];
h q[7];
h q[7];
sdg q[7];
// END undup
// BEGIN dealloc
s q[7];
h q[7];
t q[7];
cx q[0], q[7];
inv @ t q[7];
cx q[1], q[7];
t q[7];
cx q[0], q[7];
inv @ t q[7];
cx q[1], q[7];
h q[7];
sdg q[7];
// END dealloc
// BEGIN undup
h q[6];
t q[6];
cx q[2], q[6];
inv @ t q[6];
h q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[0], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[0], q[6];
inv @ t q[6];
h q[6];
t q[6];
cx q[2], q[6];
inv @ t q[6];
h q[6];
// END undup
// BEGIN dup
s q[6];
h q[6];
h q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[0], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[0], q[6];
inv @ t q[6];
h q[6];
t q[6];
cx q[2], q[6];
inv @ t q[6];
h q[6];
t q[6];
cx q[0], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[0], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
h q[6];
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
h q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[0], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[0], q[6];
inv @ t q[6];
h q[6];
t q[6];
cx q[5], q[6];
inv @ t q[6];
h q[6];
t q[6];
cx q[0], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[0], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
h q[6];
h q[6];
sdg q[6];
// END undup
// BEGIN undup
h q[5];
t q[5];
cx q[2], q[5];
inv @ t q[5];
h q[5];
cx q[1], q[5];
x q[5];
t q[5];
cx q[0], q[5];
inv @ t q[5];
cx q[1], q[5];
x q[5];
t q[5];
cx q[0], q[5];
inv @ t q[5];
h q[5];
t q[5];
cx q[2], q[5];
inv @ t q[5];
h q[5];
// END undup
// BEGIN dealloc
s q[4];
h q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
h q[4];
sdg q[4];
// END dealloc
gphase(0.0);
x q[0]; // want_negated=False
p(0.0) q[0];
ry(0.0) q[0]; // inplace_rot
p(0.0) q[0];
gphase(0.0);
x q[0]; // want_negated=True
ctrl(1) @ ry(1.8754889808102941) q[0], q[2]; // inplace_rot
x q[2]; // want_negated=True
ctrl(2) @ ry(1.5707963267948968) q[2], q[0], q[1]; // inplace_rot
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[1], q[2], q[0];
x q[1]; // want_negated=False
ctrl(3) @ gphase(0.0) q[2], q[0], q[1];
x q[2]; // want_negated=False
ctrl(2) @ ry(1.5707963267948966) q[2], q[0], q[1]; // inplace_rot
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[2], q[1], q[0];
x q[1]; // want_negated=False
ctrl(3) @ gphase(0.0) q[2], q[1], q[0];
// BEGIN lifted_x
h q[4];
t q[4];
cx q[2], q[4];
x q[4];
inv @ t q[4];
h q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
h q[4];
t q[4];
cx q[2], q[4];
x q[4];
inv @ t q[4];
h q[4];
// END lifted_x
ccx q[0], q[4], q[3]; // inplace_x
// BEGIN unlifted_x
h q[4];
t q[4];
cx q[2], q[4];
x q[4];
inv @ t q[4];
h q[4];
cx q[1], q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
h q[4];
t q[4];
cx q[2], q[4];
x q[4];
inv @ t q[4];
h q[4];
// END unlifted_x
// BEGIN dup
h q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
h q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
h q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
h q[4];
// END dup
cp(3.141592653589793) q[4], q[0];
// BEGIN undup
h q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
h q[4];
cx q[1], q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
h q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
h q[4];
// END undup
ctrl(3) @ gphase(0.0) q[2], q[1], q[0];
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[2], q[1], q[0];
x q[1]; // want_negated=False
ctrl(2) @ ry(-1.5707963267948966) q[2], q[0], q[1]; // inplace_rot
x q[2]; // want_negated=True
ctrl(3) @ gphase(0.0) q[0], q[2], q[1];
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[1], q[2], q[0];
x q[1]; // want_negated=False
ctrl(2) @ ry(-1.5707963267948968) q[2], q[0], q[1]; // inplace_rot
x q[2]; // want_negated=False
ctrl(1) @ ry(-1.8754889808102941) q[0], q[2]; // inplace_rot
// BEGIN alloc
s q[4];
h q[4];
cx q[1], q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
h q[4];
sdg q[4];
// END alloc
// BEGIN dup
h q[5];
t q[5];
cx q[2], q[5];
inv @ t q[5];
h q[5];
t q[5];
cx q[0], q[5];
inv @ t q[5];
cx q[1], q[5];
x q[5];
t q[5];
cx q[0], q[5];
inv @ t q[5];
cx q[1], q[5];
x q[5];
h q[5];
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
h q[6];
t q[6];
cx q[0], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[0], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
h q[6];
t q[6];
cx q[2], q[6];
inv @ t q[6];
h q[6];
// END dup
// BEGIN dup
s q[7];
h q[7];
h q[7];
cx q[1], q[7];
x q[7];
t q[7];
cx q[0], q[7];
inv @ t q[7];
cx q[1], q[7];
x q[7];
t q[7];
cx q[0], q[7];
inv @ t q[7];
h q[7];
t q[7];
cx q[5], q[7];
inv @ t q[7];
h q[7];
t q[7];
cx q[0], q[7];
inv @ t q[7];
cx q[1], q[7];
x q[7];
t q[7];
cx q[0], q[7];
inv @ t q[7];
cx q[1], q[7];
x q[7];
h q[7];
t q[7];
cx q[5], q[7];
inv @ t q[7];
h q[7];
sdg q[7];
// END dup
// BEGIN alloc
s q[7];
h q[7];
cx q[1], q[7];
t q[7];
cx q[0], q[7];
inv @ t q[7];
cx q[1], q[7];
t q[7];
cx q[0], q[7];
inv @ t q[7];
h q[7];
sdg q[7];
// END alloc
// BEGIN dup
s q[4];
h q[4];
h q[4];
cx q[1], q[4];
x q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
x q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
h q[4];
t q[4];
cx q[6], q[4];
inv @ t q[4];
h q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
x q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
x q[4];
h q[4];
t q[4];
cx q[6], q[4];
inv @ t q[4];
h q[4];
sdg q[4];
// END dup
// BEGIN dup
s q[8];
h q[8];
h q[8];
cx q[0], q[8];
t q[8];
cx q[7], q[8];
inv @ t q[8];
cx q[0], q[8];
t q[8];
cx q[7], q[8];
inv @ t q[8];
h q[8];
t q[8];
cx q[4], q[8];
inv @ t q[8];
h q[8];
t q[8];
cx q[7], q[8];
inv @ t q[8];
cx q[0], q[8];
t q[8];
cx q[7], q[8];
inv @ t q[8];
cx q[0], q[8];
h q[8];
t q[8];
cx q[4], q[8];
inv @ t q[8];
h q[8];
sdg q[8];
// END dup
cp(3.141592653589793) q[0], q[8];
// BEGIN undup
s q[8];
h q[8];
t q[8];
cx q[4], q[8];
inv @ t q[8];
h q[8];
cx q[0], q[8];
t q[8];
cx q[7], q[8];
inv @ t q[8];
cx q[0], q[8];
t q[8];
cx q[7], q[8];
inv @ t q[8];
h q[8];
t q[8];
cx q[4], q[8];
inv @ t q[8];
h q[8];
t q[8];
cx q[7], q[8];
inv @ t q[8];
cx q[0], q[8];
t q[8];
cx q[7], q[8];
inv @ t q[8];
cx q[0], q[8];
h q[8];
h q[8];
sdg q[8];
// END undup
// BEGIN undup
s q[4];
h q[4];
t q[4];
cx q[6], q[4];
inv @ t q[4];
h q[4];
cx q[1], q[4];
x q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
x q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
h q[4];
t q[4];
cx q[6], q[4];
inv @ t q[4];
h q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
x q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
x q[4];
h q[4];
h q[4];
sdg q[4];
// END undup
// BEGIN undup
s q[7];
h q[7];
t q[7];
cx q[5], q[7];
inv @ t q[7];
h q[7];
cx q[1], q[7];
x q[7];
t q[7];
cx q[0], q[7];
inv @ t q[7];
cx q[1], q[7];
x q[7];
t q[7];
cx q[0], q[7];
inv @ t q[7];
h q[7];
t q[7];
cx q[5], q[7];
inv @ t q[7];
h q[7];
t q[7];
cx q[0], q[7];
inv @ t q[7];
cx q[1], q[7];
x q[7];
t q[7];
cx q[0], q[7];
inv @ t q[7];
cx q[1], q[7];
x q[7];
h q[7];
h q[7];
sdg q[7];
// END undup
// BEGIN dealloc
s q[7];
h q[7];
t q[7];
cx q[0], q[7];
inv @ t q[7];
cx q[1], q[7];
t q[7];
cx q[0], q[7];
inv @ t q[7];
cx q[1], q[7];
h q[7];
sdg q[7];
// END dealloc
// BEGIN undup
h q[6];
t q[6];
cx q[2], q[6];
inv @ t q[6];
h q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[0], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[0], q[6];
inv @ t q[6];
h q[6];
t q[6];
cx q[2], q[6];
inv @ t q[6];
h q[6];
// END undup
// BEGIN dup
s q[6];
h q[6];
h q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[0], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[0], q[6];
inv @ t q[6];
h q[6];
t q[6];
cx q[2], q[6];
inv @ t q[6];
h q[6];
t q[6];
cx q[0], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[0], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
h q[6];
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
h q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[0], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[0], q[6];
inv @ t q[6];
h q[6];
t q[6];
cx q[5], q[6];
inv @ t q[6];
h q[6];
t q[6];
cx q[0], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[0], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
h q[6];
h q[6];
sdg q[6];
// END undup
// BEGIN undup
h q[5];
t q[5];
cx q[2], q[5];
inv @ t q[5];
h q[5];
cx q[1], q[5];
x q[5];
t q[5];
cx q[0], q[5];
inv @ t q[5];
cx q[1], q[5];
x q[5];
t q[5];
cx q[0], q[5];
inv @ t q[5];
h q[5];
t q[5];
cx q[2], q[5];
inv @ t q[5];
h q[5];
// END undup
// BEGIN dealloc
s q[4];
h q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
h q[4];
sdg q[4];
// END dealloc
gphase(2.994908974131322e-17);
x q[0]; // want_negated=False
p(-5.989817948262644e-17) q[0];
ry(0.1642121736684469) q[0]; // inplace_rot
p(5.989817948262644e-17) q[0];
gphase(-2.994908974131322e-17);
x q[0]; // want_negated=True
ctrl(1) @ ry(1.8754889808102941) q[0], q[2]; // inplace_rot
x q[2]; // want_negated=True
ctrl(2) @ ry(1.5707963267948968) q[0], q[2], q[1]; // inplace_rot
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[0], q[1], q[2];
x q[1]; // want_negated=False
ctrl(3) @ gphase(0.0) q[0], q[1], q[2];
x q[2]; // want_negated=False
ctrl(2) @ ry(1.5707963267948966) q[2], q[0], q[1]; // inplace_rot
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[2], q[0], q[1];
x q[1]; // want_negated=False
ctrl(3) @ gphase(0.0) q[2], q[0], q[1];
// BEGIN lifted_x
h q[4];
t q[4];
cx q[2], q[4];
x q[4];
inv @ t q[4];
h q[4];
t q[4];
cx q[1], q[4];
inv @ t q[4];
cx q[0], q[4];
t q[4];
cx q[1], q[4];
inv @ t q[4];
cx q[0], q[4];
h q[4];
t q[4];
cx q[2], q[4];
x q[4];
inv @ t q[4];
h q[4];
// END lifted_x
ccx q[4], q[0], q[3]; // inplace_x
// BEGIN unlifted_x
h q[4];
t q[4];
cx q[2], q[4];
x q[4];
inv @ t q[4];
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
t q[4];
cx q[2], q[4];
x q[4];
inv @ t q[4];
h q[4];
// END unlifted_x
// BEGIN dup
h q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
h q[4];
t q[4];
cx q[1], q[4];
inv @ t q[4];
cx q[0], q[4];
t q[4];
cx q[1], q[4];
inv @ t q[4];
cx q[0], q[4];
h q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
h q[4];
// END dup
cp(3.141592653589793) q[0], q[4];
// BEGIN undup
h q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
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
t q[4];
cx q[2], q[4];
inv @ t q[4];
h q[4];
// END undup
ctrl(3) @ gphase(0.0) q[2], q[0], q[1];
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[2], q[0], q[1];
x q[1]; // want_negated=False
ctrl(2) @ ry(-1.5707963267948966) q[2], q[0], q[1]; // inplace_rot
x q[2]; // want_negated=True
ctrl(3) @ gphase(0.0) q[1], q[0], q[2];
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[0], q[1], q[2];
x q[1]; // want_negated=False
ctrl(2) @ ry(-1.5707963267948968) q[0], q[2], q[1]; // inplace_rot
x q[2]; // want_negated=False
ctrl(1) @ ry(-1.8754889808102941) q[0], q[2]; // inplace_rot
// BEGIN alloc
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
// END alloc
// BEGIN dup
h q[5];
t q[5];
cx q[2], q[5];
inv @ t q[5];
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
cx q[0], q[5];
h q[5];
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
h q[6];
t q[6];
cx q[1], q[6];
x q[6];
inv @ t q[6];
cx q[0], q[6];
t q[6];
cx q[1], q[6];
x q[6];
inv @ t q[6];
cx q[0], q[6];
h q[6];
t q[6];
cx q[2], q[6];
inv @ t q[6];
h q[6];
// END dup
// BEGIN dup
s q[7];
h q[7];
h q[7];
cx q[0], q[7];
t q[7];
cx q[1], q[7];
x q[7];
inv @ t q[7];
cx q[0], q[7];
t q[7];
cx q[1], q[7];
x q[7];
inv @ t q[7];
h q[7];
t q[7];
cx q[5], q[7];
inv @ t q[7];
h q[7];
t q[7];
cx q[1], q[7];
x q[7];
inv @ t q[7];
cx q[0], q[7];
t q[7];
cx q[1], q[7];
x q[7];
inv @ t q[7];
cx q[0], q[7];
h q[7];
t q[7];
cx q[5], q[7];
inv @ t q[7];
h q[7];
sdg q[7];
// END dup
// BEGIN alloc
s q[7];
h q[7];
cx q[0], q[7];
t q[7];
cx q[1], q[7];
inv @ t q[7];
cx q[0], q[7];
t q[7];
cx q[1], q[7];
inv @ t q[7];
h q[7];
sdg q[7];
// END alloc
// BEGIN dup
s q[4];
h q[4];
h q[4];
cx q[0], q[4];
t q[4];
cx q[1], q[4];
x q[4];
inv @ t q[4];
cx q[0], q[4];
t q[4];
cx q[1], q[4];
x q[4];
inv @ t q[4];
h q[4];
t q[4];
cx q[6], q[4];
inv @ t q[4];
h q[4];
t q[4];
cx q[1], q[4];
x q[4];
inv @ t q[4];
cx q[0], q[4];
t q[4];
cx q[1], q[4];
x q[4];
inv @ t q[4];
cx q[0], q[4];
h q[4];
t q[4];
cx q[6], q[4];
inv @ t q[4];
h q[4];
sdg q[4];
// END dup
// BEGIN dup
s q[8];
h q[8];
h q[8];
cx q[7], q[8];
t q[8];
cx q[0], q[8];
inv @ t q[8];
cx q[7], q[8];
t q[8];
cx q[0], q[8];
inv @ t q[8];
h q[8];
t q[8];
cx q[4], q[8];
inv @ t q[8];
h q[8];
t q[8];
cx q[0], q[8];
inv @ t q[8];
cx q[7], q[8];
t q[8];
cx q[0], q[8];
inv @ t q[8];
cx q[7], q[8];
h q[8];
t q[8];
cx q[4], q[8];
inv @ t q[8];
h q[8];
sdg q[8];
// END dup
cp(3.141592653589793) q[0], q[8];
// BEGIN undup
s q[8];
h q[8];
t q[8];
cx q[4], q[8];
inv @ t q[8];
h q[8];
cx q[7], q[8];
t q[8];
cx q[0], q[8];
inv @ t q[8];
cx q[7], q[8];
t q[8];
cx q[0], q[8];
inv @ t q[8];
h q[8];
t q[8];
cx q[4], q[8];
inv @ t q[8];
h q[8];
t q[8];
cx q[0], q[8];
inv @ t q[8];
cx q[7], q[8];
t q[8];
cx q[0], q[8];
inv @ t q[8];
cx q[7], q[8];
h q[8];
h q[8];
sdg q[8];
// END undup
// BEGIN undup
s q[4];
h q[4];
t q[4];
cx q[6], q[4];
inv @ t q[4];
h q[4];
cx q[0], q[4];
t q[4];
cx q[1], q[4];
x q[4];
inv @ t q[4];
cx q[0], q[4];
t q[4];
cx q[1], q[4];
x q[4];
inv @ t q[4];
h q[4];
t q[4];
cx q[6], q[4];
inv @ t q[4];
h q[4];
t q[4];
cx q[1], q[4];
x q[4];
inv @ t q[4];
cx q[0], q[4];
t q[4];
cx q[1], q[4];
x q[4];
inv @ t q[4];
cx q[0], q[4];
h q[4];
h q[4];
sdg q[4];
// END undup
// BEGIN undup
s q[7];
h q[7];
t q[7];
cx q[5], q[7];
inv @ t q[7];
h q[7];
cx q[0], q[7];
t q[7];
cx q[1], q[7];
x q[7];
inv @ t q[7];
cx q[0], q[7];
t q[7];
cx q[1], q[7];
x q[7];
inv @ t q[7];
h q[7];
t q[7];
cx q[5], q[7];
inv @ t q[7];
h q[7];
t q[7];
cx q[1], q[7];
x q[7];
inv @ t q[7];
cx q[0], q[7];
t q[7];
cx q[1], q[7];
x q[7];
inv @ t q[7];
cx q[0], q[7];
h q[7];
h q[7];
sdg q[7];
// END undup
// BEGIN dealloc
s q[7];
h q[7];
t q[7];
cx q[1], q[7];
inv @ t q[7];
cx q[0], q[7];
t q[7];
cx q[1], q[7];
inv @ t q[7];
cx q[0], q[7];
h q[7];
sdg q[7];
// END dealloc
// BEGIN undup
h q[6];
t q[6];
cx q[2], q[6];
inv @ t q[6];
h q[6];
cx q[0], q[6];
t q[6];
cx q[1], q[6];
x q[6];
inv @ t q[6];
cx q[0], q[6];
t q[6];
cx q[1], q[6];
x q[6];
inv @ t q[6];
h q[6];
t q[6];
cx q[2], q[6];
inv @ t q[6];
h q[6];
// END undup
// BEGIN dup
s q[6];
h q[6];
h q[6];
cx q[0], q[6];
t q[6];
cx q[1], q[6];
x q[6];
inv @ t q[6];
cx q[0], q[6];
t q[6];
cx q[1], q[6];
x q[6];
inv @ t q[6];
h q[6];
t q[6];
cx q[2], q[6];
inv @ t q[6];
h q[6];
t q[6];
cx q[1], q[6];
x q[6];
inv @ t q[6];
cx q[0], q[6];
t q[6];
cx q[1], q[6];
x q[6];
inv @ t q[6];
cx q[0], q[6];
h q[6];
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
h q[6];
cx q[0], q[6];
t q[6];
cx q[1], q[6];
x q[6];
inv @ t q[6];
cx q[0], q[6];
t q[6];
cx q[1], q[6];
x q[6];
inv @ t q[6];
h q[6];
t q[6];
cx q[5], q[6];
inv @ t q[6];
h q[6];
t q[6];
cx q[1], q[6];
x q[6];
inv @ t q[6];
cx q[0], q[6];
t q[6];
cx q[1], q[6];
x q[6];
inv @ t q[6];
cx q[0], q[6];
h q[6];
h q[6];
sdg q[6];
// END undup
// BEGIN undup
h q[5];
t q[5];
cx q[2], q[5];
inv @ t q[5];
h q[5];
cx q[0], q[5];
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
t q[5];
cx q[2], q[5];
inv @ t q[5];
h q[5];
// END undup
// BEGIN dealloc
s q[4];
h q[4];
t q[4];
cx q[1], q[4];
inv @ t q[4];
cx q[0], q[4];
t q[4];
cx q[1], q[4];
inv @ t q[4];
cx q[0], q[4];
h q[4];
sdg q[4];
// END dealloc
gphase(0.0);
x q[0]; // want_negated=False
p(0.0) q[0];
ry(0.0) q[0]; // inplace_rot
p(0.0) q[0];
gphase(0.0);
x q[0]; // want_negated=True
ctrl(1) @ ry(1.8754889808102941) q[0], q[2]; // inplace_rot
x q[2]; // want_negated=True
ctrl(2) @ ry(1.5707963267948968) q[2], q[0], q[1]; // inplace_rot
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[2], q[1], q[0];
x q[1]; // want_negated=False
ctrl(3) @ gphase(0.0) q[2], q[1], q[0];
x q[2]; // want_negated=False
ctrl(2) @ ry(1.5707963267948966) q[2], q[0], q[1]; // inplace_rot
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[0], q[1], q[2];
x q[1]; // want_negated=False
ctrl(3) @ gphase(0.0) q[2], q[1], q[0];
// BEGIN lifted_x
h q[4];
t q[4];
cx q[2], q[4];
x q[4];
inv @ t q[4];
h q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
h q[4];
t q[4];
cx q[2], q[4];
x q[4];
inv @ t q[4];
h q[4];
// END lifted_x
ccx q[4], q[0], q[3]; // inplace_x
// BEGIN unlifted_x
h q[4];
t q[4];
cx q[2], q[4];
x q[4];
inv @ t q[4];
h q[4];
cx q[1], q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
h q[4];
t q[4];
cx q[2], q[4];
x q[4];
inv @ t q[4];
h q[4];
// END unlifted_x
// BEGIN dup
h q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
h q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
h q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
h q[4];
// END dup
cp(3.141592653589793) q[4], q[0];
// BEGIN undup
h q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
h q[4];
cx q[1], q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
h q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
h q[4];
// END undup
ctrl(3) @ gphase(0.0) q[1], q[2], q[0];
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[1], q[2], q[0];
x q[1]; // want_negated=False
ctrl(2) @ ry(-1.5707963267948966) q[2], q[0], q[1]; // inplace_rot
x q[2]; // want_negated=True
ctrl(3) @ gphase(0.0) q[2], q[1], q[0];
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[1], q[2], q[0];
x q[1]; // want_negated=False
ctrl(2) @ ry(-1.5707963267948968) q[2], q[0], q[1]; // inplace_rot
x q[2]; // want_negated=False
ctrl(1) @ ry(-1.8754889808102941) q[0], q[2]; // inplace_rot
// BEGIN alloc
s q[4];
h q[4];
cx q[1], q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
h q[4];
sdg q[4];
// END alloc
// BEGIN dup
h q[5];
t q[5];
cx q[2], q[5];
inv @ t q[5];
h q[5];
t q[5];
cx q[0], q[5];
inv @ t q[5];
cx q[1], q[5];
x q[5];
t q[5];
cx q[0], q[5];
inv @ t q[5];
cx q[1], q[5];
x q[5];
h q[5];
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
h q[6];
t q[6];
cx q[0], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[0], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
h q[6];
t q[6];
cx q[2], q[6];
inv @ t q[6];
h q[6];
// END dup
// BEGIN dup
s q[7];
h q[7];
h q[7];
cx q[1], q[7];
x q[7];
t q[7];
cx q[0], q[7];
inv @ t q[7];
cx q[1], q[7];
x q[7];
t q[7];
cx q[0], q[7];
inv @ t q[7];
h q[7];
t q[7];
cx q[5], q[7];
inv @ t q[7];
h q[7];
t q[7];
cx q[0], q[7];
inv @ t q[7];
cx q[1], q[7];
x q[7];
t q[7];
cx q[0], q[7];
inv @ t q[7];
cx q[1], q[7];
x q[7];
h q[7];
t q[7];
cx q[5], q[7];
inv @ t q[7];
h q[7];
sdg q[7];
// END dup
// BEGIN alloc
s q[7];
h q[7];
cx q[1], q[7];
t q[7];
cx q[0], q[7];
inv @ t q[7];
cx q[1], q[7];
t q[7];
cx q[0], q[7];
inv @ t q[7];
h q[7];
sdg q[7];
// END alloc
// BEGIN dup
s q[4];
h q[4];
h q[4];
cx q[1], q[4];
x q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
x q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
h q[4];
t q[4];
cx q[6], q[4];
inv @ t q[4];
h q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
x q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
x q[4];
h q[4];
t q[4];
cx q[6], q[4];
inv @ t q[4];
h q[4];
sdg q[4];
// END dup
// BEGIN dup
s q[8];
h q[8];
h q[8];
cx q[7], q[8];
t q[8];
cx q[0], q[8];
inv @ t q[8];
cx q[7], q[8];
t q[8];
cx q[0], q[8];
inv @ t q[8];
h q[8];
t q[8];
cx q[4], q[8];
inv @ t q[8];
h q[8];
t q[8];
cx q[0], q[8];
inv @ t q[8];
cx q[7], q[8];
t q[8];
cx q[0], q[8];
inv @ t q[8];
cx q[7], q[8];
h q[8];
t q[8];
cx q[4], q[8];
inv @ t q[8];
h q[8];
sdg q[8];
// END dup
cp(3.141592653589793) q[8], q[0];
// BEGIN undup
s q[8];
h q[8];
t q[8];
cx q[4], q[8];
inv @ t q[8];
h q[8];
cx q[7], q[8];
t q[8];
cx q[0], q[8];
inv @ t q[8];
cx q[7], q[8];
t q[8];
cx q[0], q[8];
inv @ t q[8];
h q[8];
t q[8];
cx q[4], q[8];
inv @ t q[8];
h q[8];
t q[8];
cx q[0], q[8];
inv @ t q[8];
cx q[7], q[8];
t q[8];
cx q[0], q[8];
inv @ t q[8];
cx q[7], q[8];
h q[8];
h q[8];
sdg q[8];
// END undup
// BEGIN undup
s q[4];
h q[4];
t q[4];
cx q[6], q[4];
inv @ t q[4];
h q[4];
cx q[1], q[4];
x q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
x q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
h q[4];
t q[4];
cx q[6], q[4];
inv @ t q[4];
h q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
x q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
x q[4];
h q[4];
h q[4];
sdg q[4];
// END undup
// BEGIN undup
s q[7];
h q[7];
t q[7];
cx q[5], q[7];
inv @ t q[7];
h q[7];
cx q[1], q[7];
x q[7];
t q[7];
cx q[0], q[7];
inv @ t q[7];
cx q[1], q[7];
x q[7];
t q[7];
cx q[0], q[7];
inv @ t q[7];
h q[7];
t q[7];
cx q[5], q[7];
inv @ t q[7];
h q[7];
t q[7];
cx q[0], q[7];
inv @ t q[7];
cx q[1], q[7];
x q[7];
t q[7];
cx q[0], q[7];
inv @ t q[7];
cx q[1], q[7];
x q[7];
h q[7];
h q[7];
sdg q[7];
// END undup
// BEGIN dealloc
s q[7];
h q[7];
t q[7];
cx q[0], q[7];
inv @ t q[7];
cx q[1], q[7];
t q[7];
cx q[0], q[7];
inv @ t q[7];
cx q[1], q[7];
h q[7];
sdg q[7];
// END dealloc
// BEGIN undup
h q[6];
t q[6];
cx q[2], q[6];
inv @ t q[6];
h q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[0], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[0], q[6];
inv @ t q[6];
h q[6];
t q[6];
cx q[2], q[6];
inv @ t q[6];
h q[6];
// END undup
// BEGIN dup
s q[6];
h q[6];
h q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[0], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[0], q[6];
inv @ t q[6];
h q[6];
t q[6];
cx q[2], q[6];
inv @ t q[6];
h q[6];
t q[6];
cx q[0], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[0], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
h q[6];
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
h q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[0], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[0], q[6];
inv @ t q[6];
h q[6];
t q[6];
cx q[5], q[6];
inv @ t q[6];
h q[6];
t q[6];
cx q[0], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[0], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
h q[6];
h q[6];
sdg q[6];
// END undup
// BEGIN undup
h q[5];
t q[5];
cx q[2], q[5];
inv @ t q[5];
h q[5];
cx q[1], q[5];
x q[5];
t q[5];
cx q[0], q[5];
inv @ t q[5];
cx q[1], q[5];
x q[5];
t q[5];
cx q[0], q[5];
inv @ t q[5];
h q[5];
t q[5];
cx q[2], q[5];
inv @ t q[5];
h q[5];
// END undup
// BEGIN dealloc
s q[4];
h q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
h q[4];
sdg q[4];
// END dealloc
gphase(-1.5707963267948966);
x q[0]; // want_negated=False
p(3.141592653589793) q[0];
ry(0.201210554075707) q[0]; // inplace_rot
p(-3.141592653589793) q[0];
gphase(1.5707963267948966);
x q[0]; // want_negated=True
ctrl(1) @ ry(1.8754889808102941) q[0], q[2]; // inplace_rot
x q[2]; // want_negated=True
ctrl(2) @ ry(1.5707963267948968) q[0], q[2], q[1]; // inplace_rot
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[1], q[0], q[2];
x q[1]; // want_negated=False
ctrl(3) @ gphase(0.0) q[0], q[2], q[1];
x q[2]; // want_negated=False
ctrl(2) @ ry(1.5707963267948966) q[2], q[0], q[1]; // inplace_rot
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[2], q[0], q[1];
x q[1]; // want_negated=False
ctrl(3) @ gphase(0.0) q[2], q[1], q[0];
// BEGIN lifted_x
h q[4];
t q[4];
cx q[2], q[4];
x q[4];
inv @ t q[4];
h q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
h q[4];
t q[4];
cx q[2], q[4];
x q[4];
inv @ t q[4];
h q[4];
// END lifted_x
ccx q[0], q[4], q[3]; // inplace_x
// BEGIN unlifted_x
h q[4];
t q[4];
cx q[2], q[4];
x q[4];
inv @ t q[4];
h q[4];
cx q[1], q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
h q[4];
t q[4];
cx q[2], q[4];
x q[4];
inv @ t q[4];
h q[4];
// END unlifted_x
// BEGIN dup
h q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
h q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
h q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
h q[4];
// END dup
cp(3.141592653589793) q[0], q[4];
// BEGIN undup
h q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
h q[4];
cx q[1], q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
h q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
h q[4];
// END undup
ctrl(3) @ gphase(0.0) q[2], q[0], q[1];
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[2], q[0], q[1];
x q[1]; // want_negated=False
ctrl(2) @ ry(-1.5707963267948966) q[2], q[0], q[1]; // inplace_rot
x q[2]; // want_negated=True
ctrl(3) @ gphase(0.0) q[0], q[1], q[2];
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[1], q[0], q[2];
x q[1]; // want_negated=False
ctrl(2) @ ry(-1.5707963267948968) q[0], q[2], q[1]; // inplace_rot
x q[2]; // want_negated=False
ctrl(1) @ ry(-1.8754889808102941) q[0], q[2]; // inplace_rot
// BEGIN alloc
s q[4];
h q[4];
cx q[1], q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
h q[4];
sdg q[4];
// END alloc
// BEGIN dup
h q[5];
t q[5];
cx q[2], q[5];
inv @ t q[5];
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
cx q[0], q[5];
h q[5];
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
h q[6];
t q[6];
cx q[1], q[6];
x q[6];
inv @ t q[6];
cx q[0], q[6];
t q[6];
cx q[1], q[6];
x q[6];
inv @ t q[6];
cx q[0], q[6];
h q[6];
t q[6];
cx q[2], q[6];
inv @ t q[6];
h q[6];
// END dup
// BEGIN dup
s q[7];
h q[7];
h q[7];
cx q[0], q[7];
t q[7];
cx q[1], q[7];
x q[7];
inv @ t q[7];
cx q[0], q[7];
t q[7];
cx q[1], q[7];
x q[7];
inv @ t q[7];
h q[7];
t q[7];
cx q[5], q[7];
inv @ t q[7];
h q[7];
t q[7];
cx q[1], q[7];
x q[7];
inv @ t q[7];
cx q[0], q[7];
t q[7];
cx q[1], q[7];
x q[7];
inv @ t q[7];
cx q[0], q[7];
h q[7];
t q[7];
cx q[5], q[7];
inv @ t q[7];
h q[7];
sdg q[7];
// END dup
// BEGIN alloc
s q[7];
h q[7];
cx q[1], q[7];
t q[7];
cx q[0], q[7];
inv @ t q[7];
cx q[1], q[7];
t q[7];
cx q[0], q[7];
inv @ t q[7];
h q[7];
sdg q[7];
// END alloc
// BEGIN dup
s q[4];
h q[4];
h q[4];
cx q[0], q[4];
t q[4];
cx q[1], q[4];
x q[4];
inv @ t q[4];
cx q[0], q[4];
t q[4];
cx q[1], q[4];
x q[4];
inv @ t q[4];
h q[4];
t q[4];
cx q[6], q[4];
inv @ t q[4];
h q[4];
t q[4];
cx q[1], q[4];
x q[4];
inv @ t q[4];
cx q[0], q[4];
t q[4];
cx q[1], q[4];
x q[4];
inv @ t q[4];
cx q[0], q[4];
h q[4];
t q[4];
cx q[6], q[4];
inv @ t q[4];
h q[4];
sdg q[4];
// END dup
// BEGIN dup
s q[8];
h q[8];
h q[8];
cx q[0], q[8];
t q[8];
cx q[7], q[8];
inv @ t q[8];
cx q[0], q[8];
t q[8];
cx q[7], q[8];
inv @ t q[8];
h q[8];
t q[8];
cx q[4], q[8];
inv @ t q[8];
h q[8];
t q[8];
cx q[7], q[8];
inv @ t q[8];
cx q[0], q[8];
t q[8];
cx q[7], q[8];
inv @ t q[8];
cx q[0], q[8];
h q[8];
t q[8];
cx q[4], q[8];
inv @ t q[8];
h q[8];
sdg q[8];
// END dup
cp(3.141592653589793) q[8], q[0];
// BEGIN undup
s q[8];
h q[8];
t q[8];
cx q[4], q[8];
inv @ t q[8];
h q[8];
cx q[0], q[8];
t q[8];
cx q[7], q[8];
inv @ t q[8];
cx q[0], q[8];
t q[8];
cx q[7], q[8];
inv @ t q[8];
h q[8];
t q[8];
cx q[4], q[8];
inv @ t q[8];
h q[8];
t q[8];
cx q[7], q[8];
inv @ t q[8];
cx q[0], q[8];
t q[8];
cx q[7], q[8];
inv @ t q[8];
cx q[0], q[8];
h q[8];
h q[8];
sdg q[8];
// END undup
// BEGIN undup
s q[4];
h q[4];
t q[4];
cx q[6], q[4];
inv @ t q[4];
h q[4];
cx q[0], q[4];
t q[4];
cx q[1], q[4];
x q[4];
inv @ t q[4];
cx q[0], q[4];
t q[4];
cx q[1], q[4];
x q[4];
inv @ t q[4];
h q[4];
t q[4];
cx q[6], q[4];
inv @ t q[4];
h q[4];
t q[4];
cx q[1], q[4];
x q[4];
inv @ t q[4];
cx q[0], q[4];
t q[4];
cx q[1], q[4];
x q[4];
inv @ t q[4];
cx q[0], q[4];
h q[4];
h q[4];
sdg q[4];
// END undup
// BEGIN undup
s q[7];
h q[7];
t q[7];
cx q[5], q[7];
inv @ t q[7];
h q[7];
cx q[0], q[7];
t q[7];
cx q[1], q[7];
x q[7];
inv @ t q[7];
cx q[0], q[7];
t q[7];
cx q[1], q[7];
x q[7];
inv @ t q[7];
h q[7];
t q[7];
cx q[5], q[7];
inv @ t q[7];
h q[7];
t q[7];
cx q[1], q[7];
x q[7];
inv @ t q[7];
cx q[0], q[7];
t q[7];
cx q[1], q[7];
x q[7];
inv @ t q[7];
cx q[0], q[7];
h q[7];
h q[7];
sdg q[7];
// END undup
// BEGIN dealloc
s q[7];
h q[7];
t q[7];
cx q[0], q[7];
inv @ t q[7];
cx q[1], q[7];
t q[7];
cx q[0], q[7];
inv @ t q[7];
cx q[1], q[7];
h q[7];
sdg q[7];
// END dealloc
// BEGIN undup
h q[6];
t q[6];
cx q[2], q[6];
inv @ t q[6];
h q[6];
cx q[0], q[6];
t q[6];
cx q[1], q[6];
x q[6];
inv @ t q[6];
cx q[0], q[6];
t q[6];
cx q[1], q[6];
x q[6];
inv @ t q[6];
h q[6];
t q[6];
cx q[2], q[6];
inv @ t q[6];
h q[6];
// END undup
// BEGIN dup
s q[6];
h q[6];
h q[6];
cx q[0], q[6];
t q[6];
cx q[1], q[6];
x q[6];
inv @ t q[6];
cx q[0], q[6];
t q[6];
cx q[1], q[6];
x q[6];
inv @ t q[6];
h q[6];
t q[6];
cx q[2], q[6];
inv @ t q[6];
h q[6];
t q[6];
cx q[1], q[6];
x q[6];
inv @ t q[6];
cx q[0], q[6];
t q[6];
cx q[1], q[6];
x q[6];
inv @ t q[6];
cx q[0], q[6];
h q[6];
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
h q[6];
cx q[0], q[6];
t q[6];
cx q[1], q[6];
x q[6];
inv @ t q[6];
cx q[0], q[6];
t q[6];
cx q[1], q[6];
x q[6];
inv @ t q[6];
h q[6];
t q[6];
cx q[5], q[6];
inv @ t q[6];
h q[6];
t q[6];
cx q[1], q[6];
x q[6];
inv @ t q[6];
cx q[0], q[6];
t q[6];
cx q[1], q[6];
x q[6];
inv @ t q[6];
cx q[0], q[6];
h q[6];
h q[6];
sdg q[6];
// END undup
// BEGIN undup
h q[5];
t q[5];
cx q[2], q[5];
inv @ t q[5];
h q[5];
cx q[0], q[5];
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
t q[5];
cx q[2], q[5];
inv @ t q[5];
h q[5];
// END undup
// BEGIN dealloc
s q[4];
h q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
h q[4];
sdg q[4];
// END dealloc
gphase(0.0);
x q[0]; // want_negated=False
p(0.0) q[0];
ry(0.0) q[0]; // inplace_rot
p(0.0) q[0];
gphase(0.0);
x q[0]; // want_negated=True
ctrl(1) @ ry(1.8754889808102941) q[0], q[2]; // inplace_rot
x q[2]; // want_negated=True
ctrl(2) @ ry(1.5707963267948968) q[0], q[2], q[1]; // inplace_rot
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[0], q[2], q[1];
x q[1]; // want_negated=False
ctrl(3) @ gphase(0.0) q[0], q[2], q[1];
x q[2]; // want_negated=False
ctrl(2) @ ry(1.5707963267948966) q[0], q[2], q[1]; // inplace_rot
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[0], q[1], q[2];
x q[1]; // want_negated=False
ctrl(3) @ gphase(0.0) q[0], q[2], q[1];
// BEGIN lifted_x
h q[4];
t q[4];
cx q[2], q[4];
x q[4];
inv @ t q[4];
h q[4];
t q[4];
cx q[1], q[4];
inv @ t q[4];
cx q[0], q[4];
t q[4];
cx q[1], q[4];
inv @ t q[4];
cx q[0], q[4];
h q[4];
t q[4];
cx q[2], q[4];
x q[4];
inv @ t q[4];
h q[4];
// END lifted_x
ccx q[0], q[4], q[3]; // inplace_x
// BEGIN unlifted_x
h q[4];
t q[4];
cx q[2], q[4];
x q[4];
inv @ t q[4];
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
t q[4];
cx q[2], q[4];
x q[4];
inv @ t q[4];
h q[4];
// END unlifted_x
// BEGIN dup
h q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
h q[4];
t q[4];
cx q[1], q[4];
inv @ t q[4];
cx q[0], q[4];
t q[4];
cx q[1], q[4];
inv @ t q[4];
cx q[0], q[4];
h q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
h q[4];
// END dup
cp(3.141592653589793) q[0], q[4];
// BEGIN undup
h q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
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
t q[4];
cx q[2], q[4];
inv @ t q[4];
h q[4];
// END undup
ctrl(3) @ gphase(0.0) q[0], q[1], q[2];
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[0], q[2], q[1];
x q[1]; // want_negated=False
ctrl(2) @ ry(-1.5707963267948966) q[0], q[2], q[1]; // inplace_rot
x q[2]; // want_negated=True
ctrl(3) @ gphase(0.0) q[0], q[2], q[1];
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[0], q[2], q[1];
x q[1]; // want_negated=False
ctrl(2) @ ry(-1.5707963267948968) q[0], q[2], q[1]; // inplace_rot
x q[2]; // want_negated=False
ctrl(1) @ ry(-1.8754889808102941) q[0], q[2]; // inplace_rot
// BEGIN alloc
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
// END alloc
// BEGIN dup
h q[5];
t q[5];
cx q[2], q[5];
inv @ t q[5];
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
cx q[0], q[5];
h q[5];
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
h q[6];
t q[6];
cx q[1], q[6];
x q[6];
inv @ t q[6];
cx q[0], q[6];
t q[6];
cx q[1], q[6];
x q[6];
inv @ t q[6];
cx q[0], q[6];
h q[6];
t q[6];
cx q[2], q[6];
inv @ t q[6];
h q[6];
// END dup
// BEGIN dup
s q[7];
h q[7];
h q[7];
cx q[0], q[7];
t q[7];
cx q[1], q[7];
x q[7];
inv @ t q[7];
cx q[0], q[7];
t q[7];
cx q[1], q[7];
x q[7];
inv @ t q[7];
h q[7];
t q[7];
cx q[5], q[7];
inv @ t q[7];
h q[7];
t q[7];
cx q[1], q[7];
x q[7];
inv @ t q[7];
cx q[0], q[7];
t q[7];
cx q[1], q[7];
x q[7];
inv @ t q[7];
cx q[0], q[7];
h q[7];
t q[7];
cx q[5], q[7];
inv @ t q[7];
h q[7];
sdg q[7];
// END dup
// BEGIN alloc
s q[7];
h q[7];
cx q[0], q[7];
t q[7];
cx q[1], q[7];
inv @ t q[7];
cx q[0], q[7];
t q[7];
cx q[1], q[7];
inv @ t q[7];
h q[7];
sdg q[7];
// END alloc
// BEGIN dup
s q[4];
h q[4];
h q[4];
cx q[0], q[4];
t q[4];
cx q[1], q[4];
x q[4];
inv @ t q[4];
cx q[0], q[4];
t q[4];
cx q[1], q[4];
x q[4];
inv @ t q[4];
h q[4];
t q[4];
cx q[6], q[4];
inv @ t q[4];
h q[4];
t q[4];
cx q[1], q[4];
x q[4];
inv @ t q[4];
cx q[0], q[4];
t q[4];
cx q[1], q[4];
x q[4];
inv @ t q[4];
cx q[0], q[4];
h q[4];
t q[4];
cx q[6], q[4];
inv @ t q[4];
h q[4];
sdg q[4];
// END dup
// BEGIN dup
s q[8];
h q[8];
h q[8];
cx q[0], q[8];
t q[8];
cx q[7], q[8];
inv @ t q[8];
cx q[0], q[8];
t q[8];
cx q[7], q[8];
inv @ t q[8];
h q[8];
t q[8];
cx q[4], q[8];
inv @ t q[8];
h q[8];
t q[8];
cx q[7], q[8];
inv @ t q[8];
cx q[0], q[8];
t q[8];
cx q[7], q[8];
inv @ t q[8];
cx q[0], q[8];
h q[8];
t q[8];
cx q[4], q[8];
inv @ t q[8];
h q[8];
sdg q[8];
// END dup
cp(3.141592653589793) q[0], q[8];
// BEGIN undup
s q[8];
h q[8];
t q[8];
cx q[4], q[8];
inv @ t q[8];
h q[8];
cx q[0], q[8];
t q[8];
cx q[7], q[8];
inv @ t q[8];
cx q[0], q[8];
t q[8];
cx q[7], q[8];
inv @ t q[8];
h q[8];
t q[8];
cx q[4], q[8];
inv @ t q[8];
h q[8];
t q[8];
cx q[7], q[8];
inv @ t q[8];
cx q[0], q[8];
t q[8];
cx q[7], q[8];
inv @ t q[8];
cx q[0], q[8];
h q[8];
h q[8];
sdg q[8];
// END undup
// BEGIN undup
s q[4];
h q[4];
t q[4];
cx q[6], q[4];
inv @ t q[4];
h q[4];
cx q[0], q[4];
t q[4];
cx q[1], q[4];
x q[4];
inv @ t q[4];
cx q[0], q[4];
t q[4];
cx q[1], q[4];
x q[4];
inv @ t q[4];
h q[4];
t q[4];
cx q[6], q[4];
inv @ t q[4];
h q[4];
t q[4];
cx q[1], q[4];
x q[4];
inv @ t q[4];
cx q[0], q[4];
t q[4];
cx q[1], q[4];
x q[4];
inv @ t q[4];
cx q[0], q[4];
h q[4];
h q[4];
sdg q[4];
// END undup
// BEGIN undup
s q[7];
h q[7];
t q[7];
cx q[5], q[7];
inv @ t q[7];
h q[7];
cx q[0], q[7];
t q[7];
cx q[1], q[7];
x q[7];
inv @ t q[7];
cx q[0], q[7];
t q[7];
cx q[1], q[7];
x q[7];
inv @ t q[7];
h q[7];
t q[7];
cx q[5], q[7];
inv @ t q[7];
h q[7];
t q[7];
cx q[1], q[7];
x q[7];
inv @ t q[7];
cx q[0], q[7];
t q[7];
cx q[1], q[7];
x q[7];
inv @ t q[7];
cx q[0], q[7];
h q[7];
h q[7];
sdg q[7];
// END undup
// BEGIN dealloc
s q[7];
h q[7];
t q[7];
cx q[1], q[7];
inv @ t q[7];
cx q[0], q[7];
t q[7];
cx q[1], q[7];
inv @ t q[7];
cx q[0], q[7];
h q[7];
sdg q[7];
// END dealloc
// BEGIN undup
h q[6];
t q[6];
cx q[2], q[6];
inv @ t q[6];
h q[6];
cx q[0], q[6];
t q[6];
cx q[1], q[6];
x q[6];
inv @ t q[6];
cx q[0], q[6];
t q[6];
cx q[1], q[6];
x q[6];
inv @ t q[6];
h q[6];
t q[6];
cx q[2], q[6];
inv @ t q[6];
h q[6];
// END undup
// BEGIN dup
s q[6];
h q[6];
h q[6];
cx q[0], q[6];
t q[6];
cx q[1], q[6];
x q[6];
inv @ t q[6];
cx q[0], q[6];
t q[6];
cx q[1], q[6];
x q[6];
inv @ t q[6];
h q[6];
t q[6];
cx q[2], q[6];
inv @ t q[6];
h q[6];
t q[6];
cx q[1], q[6];
x q[6];
inv @ t q[6];
cx q[0], q[6];
t q[6];
cx q[1], q[6];
x q[6];
inv @ t q[6];
cx q[0], q[6];
h q[6];
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
h q[6];
cx q[0], q[6];
t q[6];
cx q[1], q[6];
x q[6];
inv @ t q[6];
cx q[0], q[6];
t q[6];
cx q[1], q[6];
x q[6];
inv @ t q[6];
h q[6];
t q[6];
cx q[5], q[6];
inv @ t q[6];
h q[6];
t q[6];
cx q[1], q[6];
x q[6];
inv @ t q[6];
cx q[0], q[6];
t q[6];
cx q[1], q[6];
x q[6];
inv @ t q[6];
cx q[0], q[6];
h q[6];
h q[6];
sdg q[6];
// END undup
// BEGIN undup
h q[5];
t q[5];
cx q[2], q[5];
inv @ t q[5];
h q[5];
cx q[0], q[5];
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
t q[5];
cx q[2], q[5];
inv @ t q[5];
h q[5];
// END undup
// BEGIN dealloc
s q[4];
h q[4];
t q[4];
cx q[1], q[4];
inv @ t q[4];
cx q[0], q[4];
t q[4];
cx q[1], q[4];
inv @ t q[4];
cx q[0], q[4];
h q[4];
sdg q[4];
// END dealloc
gphase(3.1160320347342564e-17);
x q[0]; // want_negated=False
p(-6.232064069468513e-17) q[0];
ry(0.23766073701641863) q[0]; // inplace_rot
p(6.232064069468513e-17) q[0];
gphase(-3.1160320347342564e-17);
x q[0]; // want_negated=True
ctrl(1) @ ry(1.8754889808102941) q[0], q[2]; // inplace_rot
x q[2]; // want_negated=True
ctrl(2) @ ry(1.5707963267948968) q[0], q[2], q[1]; // inplace_rot
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[1], q[0], q[2];
x q[1]; // want_negated=False
ctrl(3) @ gphase(0.0) q[0], q[1], q[2];
x q[2]; // want_negated=False
ctrl(2) @ ry(1.5707963267948966) q[2], q[0], q[1]; // inplace_rot
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[2], q[0], q[1];
x q[1]; // want_negated=False
ctrl(3) @ gphase(0.0) q[2], q[0], q[1];
// BEGIN lifted_x
h q[4];
t q[4];
cx q[2], q[4];
x q[4];
inv @ t q[4];
h q[4];
t q[4];
cx q[1], q[4];
inv @ t q[4];
cx q[0], q[4];
t q[4];
cx q[1], q[4];
inv @ t q[4];
cx q[0], q[4];
h q[4];
t q[4];
cx q[2], q[4];
x q[4];
inv @ t q[4];
h q[4];
// END lifted_x
ccx q[0], q[4], q[3]; // inplace_x
// BEGIN unlifted_x
h q[4];
t q[4];
cx q[2], q[4];
x q[4];
inv @ t q[4];
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
t q[4];
cx q[2], q[4];
x q[4];
inv @ t q[4];
h q[4];
// END unlifted_x
// BEGIN dup
h q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
h q[4];
t q[4];
cx q[1], q[4];
inv @ t q[4];
cx q[0], q[4];
t q[4];
cx q[1], q[4];
inv @ t q[4];
cx q[0], q[4];
h q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
h q[4];
// END dup
cp(3.141592653589793) q[0], q[4];
// BEGIN undup
h q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
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
t q[4];
cx q[2], q[4];
inv @ t q[4];
h q[4];
// END undup
ctrl(3) @ gphase(0.0) q[2], q[0], q[1];
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[2], q[0], q[1];
x q[1]; // want_negated=False
ctrl(2) @ ry(-1.5707963267948966) q[2], q[0], q[1]; // inplace_rot
x q[2]; // want_negated=True
ctrl(3) @ gphase(0.0) q[0], q[1], q[2];
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[0], q[1], q[2];
x q[1]; // want_negated=False
ctrl(2) @ ry(-1.5707963267948968) q[0], q[2], q[1]; // inplace_rot
x q[2]; // want_negated=False
ctrl(1) @ ry(-1.8754889808102941) q[0], q[2]; // inplace_rot
// BEGIN alloc
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
// END alloc
// BEGIN dup
h q[5];
t q[5];
cx q[2], q[5];
inv @ t q[5];
h q[5];
t q[5];
cx q[0], q[5];
inv @ t q[5];
cx q[1], q[5];
x q[5];
t q[5];
cx q[0], q[5];
inv @ t q[5];
cx q[1], q[5];
x q[5];
h q[5];
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
h q[6];
t q[6];
cx q[0], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[0], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
h q[6];
t q[6];
cx q[2], q[6];
inv @ t q[6];
h q[6];
// END dup
// BEGIN dup
s q[7];
h q[7];
h q[7];
cx q[1], q[7];
x q[7];
t q[7];
cx q[0], q[7];
inv @ t q[7];
cx q[1], q[7];
x q[7];
t q[7];
cx q[0], q[7];
inv @ t q[7];
h q[7];
t q[7];
cx q[5], q[7];
inv @ t q[7];
h q[7];
t q[7];
cx q[0], q[7];
inv @ t q[7];
cx q[1], q[7];
x q[7];
t q[7];
cx q[0], q[7];
inv @ t q[7];
cx q[1], q[7];
x q[7];
h q[7];
t q[7];
cx q[5], q[7];
inv @ t q[7];
h q[7];
sdg q[7];
// END dup
// BEGIN alloc
s q[7];
h q[7];
cx q[0], q[7];
t q[7];
cx q[1], q[7];
inv @ t q[7];
cx q[0], q[7];
t q[7];
cx q[1], q[7];
inv @ t q[7];
h q[7];
sdg q[7];
// END alloc
// BEGIN dup
s q[4];
h q[4];
h q[4];
cx q[1], q[4];
x q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
x q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
h q[4];
t q[4];
cx q[6], q[4];
inv @ t q[4];
h q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
x q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
x q[4];
h q[4];
t q[4];
cx q[6], q[4];
inv @ t q[4];
h q[4];
sdg q[4];
// END dup
// BEGIN dup
s q[8];
h q[8];
h q[8];
cx q[7], q[8];
t q[8];
cx q[0], q[8];
inv @ t q[8];
cx q[7], q[8];
t q[8];
cx q[0], q[8];
inv @ t q[8];
h q[8];
t q[8];
cx q[4], q[8];
inv @ t q[8];
h q[8];
t q[8];
cx q[0], q[8];
inv @ t q[8];
cx q[7], q[8];
t q[8];
cx q[0], q[8];
inv @ t q[8];
cx q[7], q[8];
h q[8];
t q[8];
cx q[4], q[8];
inv @ t q[8];
h q[8];
sdg q[8];
// END dup
cp(3.141592653589793) q[0], q[8];
// BEGIN undup
s q[8];
h q[8];
t q[8];
cx q[4], q[8];
inv @ t q[8];
h q[8];
cx q[7], q[8];
t q[8];
cx q[0], q[8];
inv @ t q[8];
cx q[7], q[8];
t q[8];
cx q[0], q[8];
inv @ t q[8];
h q[8];
t q[8];
cx q[4], q[8];
inv @ t q[8];
h q[8];
t q[8];
cx q[0], q[8];
inv @ t q[8];
cx q[7], q[8];
t q[8];
cx q[0], q[8];
inv @ t q[8];
cx q[7], q[8];
h q[8];
h q[8];
sdg q[8];
// END undup
// BEGIN undup
s q[4];
h q[4];
t q[4];
cx q[6], q[4];
inv @ t q[4];
h q[4];
cx q[1], q[4];
x q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
x q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
h q[4];
t q[4];
cx q[6], q[4];
inv @ t q[4];
h q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
x q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
x q[4];
h q[4];
h q[4];
sdg q[4];
// END undup
// BEGIN undup
s q[7];
h q[7];
t q[7];
cx q[5], q[7];
inv @ t q[7];
h q[7];
cx q[1], q[7];
x q[7];
t q[7];
cx q[0], q[7];
inv @ t q[7];
cx q[1], q[7];
x q[7];
t q[7];
cx q[0], q[7];
inv @ t q[7];
h q[7];
t q[7];
cx q[5], q[7];
inv @ t q[7];
h q[7];
t q[7];
cx q[0], q[7];
inv @ t q[7];
cx q[1], q[7];
x q[7];
t q[7];
cx q[0], q[7];
inv @ t q[7];
cx q[1], q[7];
x q[7];
h q[7];
h q[7];
sdg q[7];
// END undup
// BEGIN dealloc
s q[7];
h q[7];
t q[7];
cx q[1], q[7];
inv @ t q[7];
cx q[0], q[7];
t q[7];
cx q[1], q[7];
inv @ t q[7];
cx q[0], q[7];
h q[7];
sdg q[7];
// END dealloc
// BEGIN undup
h q[6];
t q[6];
cx q[2], q[6];
inv @ t q[6];
h q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[0], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[0], q[6];
inv @ t q[6];
h q[6];
t q[6];
cx q[2], q[6];
inv @ t q[6];
h q[6];
// END undup
// BEGIN dup
s q[6];
h q[6];
h q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[0], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[0], q[6];
inv @ t q[6];
h q[6];
t q[6];
cx q[2], q[6];
inv @ t q[6];
h q[6];
t q[6];
cx q[0], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[0], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
h q[6];
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
h q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[0], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[0], q[6];
inv @ t q[6];
h q[6];
t q[6];
cx q[5], q[6];
inv @ t q[6];
h q[6];
t q[6];
cx q[0], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[0], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
h q[6];
h q[6];
sdg q[6];
// END undup
// BEGIN undup
h q[5];
t q[5];
cx q[2], q[5];
inv @ t q[5];
h q[5];
cx q[1], q[5];
x q[5];
t q[5];
cx q[0], q[5];
inv @ t q[5];
cx q[1], q[5];
x q[5];
t q[5];
cx q[0], q[5];
inv @ t q[5];
h q[5];
t q[5];
cx q[2], q[5];
inv @ t q[5];
h q[5];
// END undup
// BEGIN dealloc
s q[4];
h q[4];
t q[4];
cx q[1], q[4];
inv @ t q[4];
cx q[0], q[4];
t q[4];
cx q[1], q[4];
inv @ t q[4];
cx q[0], q[4];
h q[4];
sdg q[4];
// END dealloc
gphase(0.0);
x q[0]; // want_negated=False
p(0.0) q[0];
ry(0.0) q[0]; // inplace_rot
p(0.0) q[0];
gphase(0.0);
x q[0]; // want_negated=True
ctrl(1) @ ry(1.8754889808102941) q[0], q[2]; // inplace_rot
x q[2]; // want_negated=True
ctrl(2) @ ry(1.5707963267948968) q[2], q[0], q[1]; // inplace_rot
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[1], q[2], q[0];
x q[1]; // want_negated=False
ctrl(3) @ gphase(0.0) q[1], q[2], q[0];
x q[2]; // want_negated=False
ctrl(2) @ ry(1.5707963267948966) q[2], q[0], q[1]; // inplace_rot
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[2], q[1], q[0];
x q[1]; // want_negated=False
ctrl(3) @ gphase(0.0) q[2], q[0], q[1];
// BEGIN lifted_x
h q[4];
t q[4];
cx q[2], q[4];
x q[4];
inv @ t q[4];
h q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
h q[4];
t q[4];
cx q[2], q[4];
x q[4];
inv @ t q[4];
h q[4];
// END lifted_x
ccx q[4], q[0], q[3]; // inplace_x
// BEGIN unlifted_x
h q[4];
t q[4];
cx q[2], q[4];
x q[4];
inv @ t q[4];
h q[4];
cx q[1], q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
h q[4];
t q[4];
cx q[2], q[4];
x q[4];
inv @ t q[4];
h q[4];
// END unlifted_x
// BEGIN dup
h q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
h q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
h q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
h q[4];
// END dup
cp(3.141592653589793) q[0], q[4];
// BEGIN undup
h q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
h q[4];
cx q[1], q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
h q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
h q[4];
// END undup
ctrl(3) @ gphase(0.0) q[2], q[1], q[0];
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[2], q[1], q[0];
x q[1]; // want_negated=False
ctrl(2) @ ry(-1.5707963267948966) q[2], q[0], q[1]; // inplace_rot
x q[2]; // want_negated=True
ctrl(3) @ gphase(0.0) q[1], q[2], q[0];
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[2], q[1], q[0];
x q[1]; // want_negated=False
ctrl(2) @ ry(-1.5707963267948968) q[2], q[0], q[1]; // inplace_rot
x q[2]; // want_negated=False
ctrl(1) @ ry(-1.8754889808102941) q[0], q[2]; // inplace_rot
// BEGIN alloc
s q[4];
h q[4];
cx q[1], q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
h q[4];
sdg q[4];
// END alloc
// BEGIN dup
h q[5];
t q[5];
cx q[2], q[5];
inv @ t q[5];
h q[5];
t q[5];
cx q[0], q[5];
inv @ t q[5];
cx q[1], q[5];
x q[5];
t q[5];
cx q[0], q[5];
inv @ t q[5];
cx q[1], q[5];
x q[5];
h q[5];
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
h q[6];
t q[6];
cx q[0], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[0], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
h q[6];
t q[6];
cx q[2], q[6];
inv @ t q[6];
h q[6];
// END dup
// BEGIN dup
s q[7];
h q[7];
h q[7];
cx q[1], q[7];
x q[7];
t q[7];
cx q[0], q[7];
inv @ t q[7];
cx q[1], q[7];
x q[7];
t q[7];
cx q[0], q[7];
inv @ t q[7];
h q[7];
t q[7];
cx q[5], q[7];
inv @ t q[7];
h q[7];
t q[7];
cx q[0], q[7];
inv @ t q[7];
cx q[1], q[7];
x q[7];
t q[7];
cx q[0], q[7];
inv @ t q[7];
cx q[1], q[7];
x q[7];
h q[7];
t q[7];
cx q[5], q[7];
inv @ t q[7];
h q[7];
sdg q[7];
// END dup
// BEGIN alloc
s q[7];
h q[7];
cx q[1], q[7];
t q[7];
cx q[0], q[7];
inv @ t q[7];
cx q[1], q[7];
t q[7];
cx q[0], q[7];
inv @ t q[7];
h q[7];
sdg q[7];
// END alloc
// BEGIN dup
s q[4];
h q[4];
h q[4];
cx q[1], q[4];
x q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
x q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
h q[4];
t q[4];
cx q[6], q[4];
inv @ t q[4];
h q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
x q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
x q[4];
h q[4];
t q[4];
cx q[6], q[4];
inv @ t q[4];
h q[4];
sdg q[4];
// END dup
// BEGIN dup
s q[8];
h q[8];
h q[8];
cx q[7], q[8];
t q[8];
cx q[0], q[8];
inv @ t q[8];
cx q[7], q[8];
t q[8];
cx q[0], q[8];
inv @ t q[8];
h q[8];
t q[8];
cx q[4], q[8];
inv @ t q[8];
h q[8];
t q[8];
cx q[0], q[8];
inv @ t q[8];
cx q[7], q[8];
t q[8];
cx q[0], q[8];
inv @ t q[8];
cx q[7], q[8];
h q[8];
t q[8];
cx q[4], q[8];
inv @ t q[8];
h q[8];
sdg q[8];
// END dup
cp(3.141592653589793) q[8], q[0];
// BEGIN undup
s q[8];
h q[8];
t q[8];
cx q[4], q[8];
inv @ t q[8];
h q[8];
cx q[7], q[8];
t q[8];
cx q[0], q[8];
inv @ t q[8];
cx q[7], q[8];
t q[8];
cx q[0], q[8];
inv @ t q[8];
h q[8];
t q[8];
cx q[4], q[8];
inv @ t q[8];
h q[8];
t q[8];
cx q[0], q[8];
inv @ t q[8];
cx q[7], q[8];
t q[8];
cx q[0], q[8];
inv @ t q[8];
cx q[7], q[8];
h q[8];
h q[8];
sdg q[8];
// END undup
// BEGIN undup
s q[4];
h q[4];
t q[4];
cx q[6], q[4];
inv @ t q[4];
h q[4];
cx q[1], q[4];
x q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
x q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
h q[4];
t q[4];
cx q[6], q[4];
inv @ t q[4];
h q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
x q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
x q[4];
h q[4];
h q[4];
sdg q[4];
// END undup
// BEGIN undup
s q[7];
h q[7];
t q[7];
cx q[5], q[7];
inv @ t q[7];
h q[7];
cx q[1], q[7];
x q[7];
t q[7];
cx q[0], q[7];
inv @ t q[7];
cx q[1], q[7];
x q[7];
t q[7];
cx q[0], q[7];
inv @ t q[7];
h q[7];
t q[7];
cx q[5], q[7];
inv @ t q[7];
h q[7];
t q[7];
cx q[0], q[7];
inv @ t q[7];
cx q[1], q[7];
x q[7];
t q[7];
cx q[0], q[7];
inv @ t q[7];
cx q[1], q[7];
x q[7];
h q[7];
h q[7];
sdg q[7];
// END undup
// BEGIN dealloc
s q[7];
h q[7];
t q[7];
cx q[0], q[7];
inv @ t q[7];
cx q[1], q[7];
t q[7];
cx q[0], q[7];
inv @ t q[7];
cx q[1], q[7];
h q[7];
sdg q[7];
// END dealloc
// BEGIN undup
h q[6];
t q[6];
cx q[2], q[6];
inv @ t q[6];
h q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[0], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[0], q[6];
inv @ t q[6];
h q[6];
t q[6];
cx q[2], q[6];
inv @ t q[6];
h q[6];
// END undup
// BEGIN dup
s q[6];
h q[6];
h q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[0], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[0], q[6];
inv @ t q[6];
h q[6];
t q[6];
cx q[2], q[6];
inv @ t q[6];
h q[6];
t q[6];
cx q[0], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[0], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
h q[6];
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
h q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[0], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[0], q[6];
inv @ t q[6];
h q[6];
t q[6];
cx q[5], q[6];
inv @ t q[6];
h q[6];
t q[6];
cx q[0], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[0], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
h q[6];
h q[6];
sdg q[6];
// END undup
// BEGIN undup
h q[5];
t q[5];
cx q[2], q[5];
inv @ t q[5];
h q[5];
cx q[1], q[5];
x q[5];
t q[5];
cx q[0], q[5];
inv @ t q[5];
cx q[1], q[5];
x q[5];
t q[5];
cx q[0], q[5];
inv @ t q[5];
h q[5];
t q[5];
cx q[2], q[5];
inv @ t q[5];
h q[5];
// END undup
// BEGIN dealloc
s q[4];
h q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
h q[4];
sdg q[4];
// END dealloc
gphase(-1.5707963267948966);
x q[0]; // want_negated=False
p(3.141592653589793) q[0];
ry(0.2701763729251538) q[0]; // inplace_rot
p(-3.141592653589793) q[0];
gphase(1.5707963267948966);
x q[0]; // want_negated=True
ctrl(1) @ ry(1.8754889808102941) q[0], q[2]; // inplace_rot
x q[2]; // want_negated=True
ctrl(2) @ ry(1.5707963267948968) q[0], q[2], q[1]; // inplace_rot
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[0], q[1], q[2];
x q[1]; // want_negated=False
ctrl(3) @ gphase(0.0) q[0], q[1], q[2];
x q[2]; // want_negated=False
ctrl(2) @ ry(1.5707963267948966) q[0], q[2], q[1]; // inplace_rot
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[0], q[2], q[1];
x q[1]; // want_negated=False
ctrl(3) @ gphase(0.0) q[0], q[2], q[1];
// BEGIN lifted_x
h q[4];
t q[4];
cx q[2], q[4];
x q[4];
inv @ t q[4];
h q[4];
t q[4];
cx q[1], q[4];
inv @ t q[4];
cx q[0], q[4];
t q[4];
cx q[1], q[4];
inv @ t q[4];
cx q[0], q[4];
h q[4];
t q[4];
cx q[2], q[4];
x q[4];
inv @ t q[4];
h q[4];
// END lifted_x
ccx q[0], q[4], q[3]; // inplace_x
// BEGIN unlifted_x
h q[4];
t q[4];
cx q[2], q[4];
x q[4];
inv @ t q[4];
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
t q[4];
cx q[2], q[4];
x q[4];
inv @ t q[4];
h q[4];
// END unlifted_x
// BEGIN dup
h q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
h q[4];
t q[4];
cx q[1], q[4];
inv @ t q[4];
cx q[0], q[4];
t q[4];
cx q[1], q[4];
inv @ t q[4];
cx q[0], q[4];
h q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
h q[4];
// END dup
cp(3.141592653589793) q[0], q[4];
// BEGIN undup
h q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
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
t q[4];
cx q[2], q[4];
inv @ t q[4];
h q[4];
// END undup
ctrl(3) @ gphase(0.0) q[0], q[2], q[1];
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[0], q[2], q[1];
x q[1]; // want_negated=False
ctrl(2) @ ry(-1.5707963267948966) q[0], q[2], q[1]; // inplace_rot
x q[2]; // want_negated=True
ctrl(3) @ gphase(0.0) q[0], q[1], q[2];
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[0], q[2], q[1];
x q[1]; // want_negated=False
ctrl(2) @ ry(-1.5707963267948968) q[0], q[2], q[1]; // inplace_rot
x q[2]; // want_negated=False
ctrl(1) @ ry(-1.8754889808102941) q[0], q[2]; // inplace_rot
// BEGIN alloc
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
// END alloc
// BEGIN dup
h q[5];
t q[5];
cx q[2], q[5];
inv @ t q[5];
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
cx q[0], q[5];
h q[5];
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
h q[6];
t q[6];
cx q[1], q[6];
x q[6];
inv @ t q[6];
cx q[0], q[6];
t q[6];
cx q[1], q[6];
x q[6];
inv @ t q[6];
cx q[0], q[6];
h q[6];
t q[6];
cx q[2], q[6];
inv @ t q[6];
h q[6];
// END dup
// BEGIN dup
s q[7];
h q[7];
h q[7];
cx q[0], q[7];
t q[7];
cx q[1], q[7];
x q[7];
inv @ t q[7];
cx q[0], q[7];
t q[7];
cx q[1], q[7];
x q[7];
inv @ t q[7];
h q[7];
t q[7];
cx q[5], q[7];
inv @ t q[7];
h q[7];
t q[7];
cx q[1], q[7];
x q[7];
inv @ t q[7];
cx q[0], q[7];
t q[7];
cx q[1], q[7];
x q[7];
inv @ t q[7];
cx q[0], q[7];
h q[7];
t q[7];
cx q[5], q[7];
inv @ t q[7];
h q[7];
sdg q[7];
// END dup
// BEGIN alloc
s q[7];
h q[7];
cx q[0], q[7];
t q[7];
cx q[1], q[7];
inv @ t q[7];
cx q[0], q[7];
t q[7];
cx q[1], q[7];
inv @ t q[7];
h q[7];
sdg q[7];
// END alloc
// BEGIN dup
s q[4];
h q[4];
h q[4];
cx q[0], q[4];
t q[4];
cx q[1], q[4];
x q[4];
inv @ t q[4];
cx q[0], q[4];
t q[4];
cx q[1], q[4];
x q[4];
inv @ t q[4];
h q[4];
t q[4];
cx q[6], q[4];
inv @ t q[4];
h q[4];
t q[4];
cx q[1], q[4];
x q[4];
inv @ t q[4];
cx q[0], q[4];
t q[4];
cx q[1], q[4];
x q[4];
inv @ t q[4];
cx q[0], q[4];
h q[4];
t q[4];
cx q[6], q[4];
inv @ t q[4];
h q[4];
sdg q[4];
// END dup
// BEGIN dup
s q[8];
h q[8];
h q[8];
cx q[0], q[8];
t q[8];
cx q[7], q[8];
inv @ t q[8];
cx q[0], q[8];
t q[8];
cx q[7], q[8];
inv @ t q[8];
h q[8];
t q[8];
cx q[4], q[8];
inv @ t q[8];
h q[8];
t q[8];
cx q[7], q[8];
inv @ t q[8];
cx q[0], q[8];
t q[8];
cx q[7], q[8];
inv @ t q[8];
cx q[0], q[8];
h q[8];
t q[8];
cx q[4], q[8];
inv @ t q[8];
h q[8];
sdg q[8];
// END dup
cp(3.141592653589793) q[0], q[8];
// BEGIN undup
s q[8];
h q[8];
t q[8];
cx q[4], q[8];
inv @ t q[8];
h q[8];
cx q[0], q[8];
t q[8];
cx q[7], q[8];
inv @ t q[8];
cx q[0], q[8];
t q[8];
cx q[7], q[8];
inv @ t q[8];
h q[8];
t q[8];
cx q[4], q[8];
inv @ t q[8];
h q[8];
t q[8];
cx q[7], q[8];
inv @ t q[8];
cx q[0], q[8];
t q[8];
cx q[7], q[8];
inv @ t q[8];
cx q[0], q[8];
h q[8];
h q[8];
sdg q[8];
// END undup
// BEGIN undup
s q[4];
h q[4];
t q[4];
cx q[6], q[4];
inv @ t q[4];
h q[4];
cx q[0], q[4];
t q[4];
cx q[1], q[4];
x q[4];
inv @ t q[4];
cx q[0], q[4];
t q[4];
cx q[1], q[4];
x q[4];
inv @ t q[4];
h q[4];
t q[4];
cx q[6], q[4];
inv @ t q[4];
h q[4];
t q[4];
cx q[1], q[4];
x q[4];
inv @ t q[4];
cx q[0], q[4];
t q[4];
cx q[1], q[4];
x q[4];
inv @ t q[4];
cx q[0], q[4];
h q[4];
h q[4];
sdg q[4];
// END undup
// BEGIN undup
s q[7];
h q[7];
t q[7];
cx q[5], q[7];
inv @ t q[7];
h q[7];
cx q[0], q[7];
t q[7];
cx q[1], q[7];
x q[7];
inv @ t q[7];
cx q[0], q[7];
t q[7];
cx q[1], q[7];
x q[7];
inv @ t q[7];
h q[7];
t q[7];
cx q[5], q[7];
inv @ t q[7];
h q[7];
t q[7];
cx q[1], q[7];
x q[7];
inv @ t q[7];
cx q[0], q[7];
t q[7];
cx q[1], q[7];
x q[7];
inv @ t q[7];
cx q[0], q[7];
h q[7];
h q[7];
sdg q[7];
// END undup
// BEGIN dealloc
s q[7];
h q[7];
t q[7];
cx q[1], q[7];
inv @ t q[7];
cx q[0], q[7];
t q[7];
cx q[1], q[7];
inv @ t q[7];
cx q[0], q[7];
h q[7];
sdg q[7];
// END dealloc
// BEGIN undup
h q[6];
t q[6];
cx q[2], q[6];
inv @ t q[6];
h q[6];
cx q[0], q[6];
t q[6];
cx q[1], q[6];
x q[6];
inv @ t q[6];
cx q[0], q[6];
t q[6];
cx q[1], q[6];
x q[6];
inv @ t q[6];
h q[6];
t q[6];
cx q[2], q[6];
inv @ t q[6];
h q[6];
// END undup
// BEGIN dup
s q[6];
h q[6];
h q[6];
cx q[0], q[6];
t q[6];
cx q[1], q[6];
x q[6];
inv @ t q[6];
cx q[0], q[6];
t q[6];
cx q[1], q[6];
x q[6];
inv @ t q[6];
h q[6];
t q[6];
cx q[2], q[6];
inv @ t q[6];
h q[6];
t q[6];
cx q[1], q[6];
x q[6];
inv @ t q[6];
cx q[0], q[6];
t q[6];
cx q[1], q[6];
x q[6];
inv @ t q[6];
cx q[0], q[6];
h q[6];
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
h q[6];
cx q[0], q[6];
t q[6];
cx q[1], q[6];
x q[6];
inv @ t q[6];
cx q[0], q[6];
t q[6];
cx q[1], q[6];
x q[6];
inv @ t q[6];
h q[6];
t q[6];
cx q[5], q[6];
inv @ t q[6];
h q[6];
t q[6];
cx q[1], q[6];
x q[6];
inv @ t q[6];
cx q[0], q[6];
t q[6];
cx q[1], q[6];
x q[6];
inv @ t q[6];
cx q[0], q[6];
h q[6];
h q[6];
sdg q[6];
// END undup
// BEGIN undup
h q[5];
t q[5];
cx q[2], q[5];
inv @ t q[5];
h q[5];
cx q[0], q[5];
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
t q[5];
cx q[2], q[5];
inv @ t q[5];
h q[5];
// END undup
// BEGIN dealloc
s q[4];
h q[4];
t q[4];
cx q[1], q[4];
inv @ t q[4];
cx q[0], q[4];
t q[4];
cx q[1], q[4];
inv @ t q[4];
cx q[0], q[4];
h q[4];
sdg q[4];
// END dealloc
gphase(0.0);
x q[0]; // want_negated=False
p(0.0) q[0];
ry(0.0) q[0]; // inplace_rot
p(0.0) q[0];
gphase(0.0);
x q[0]; // want_negated=True
ctrl(1) @ ry(1.8754889808102941) q[0], q[2]; // inplace_rot
x q[2]; // want_negated=True
ctrl(2) @ ry(1.5707963267948968) q[0], q[2], q[1]; // inplace_rot
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[0], q[1], q[2];
x q[1]; // want_negated=False
ctrl(3) @ gphase(0.0) q[2], q[1], q[0];
x q[2]; // want_negated=False
ctrl(2) @ ry(1.5707963267948966) q[0], q[2], q[1]; // inplace_rot
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[0], q[2], q[1];
x q[1]; // want_negated=False
ctrl(3) @ gphase(0.0) q[0], q[1], q[2];
// BEGIN lifted_x
h q[4];
t q[4];
cx q[2], q[4];
x q[4];
inv @ t q[4];
h q[4];
t q[4];
cx q[1], q[4];
inv @ t q[4];
cx q[0], q[4];
t q[4];
cx q[1], q[4];
inv @ t q[4];
cx q[0], q[4];
h q[4];
t q[4];
cx q[2], q[4];
x q[4];
inv @ t q[4];
h q[4];
// END lifted_x
ccx q[0], q[4], q[3]; // inplace_x
// BEGIN unlifted_x
h q[4];
t q[4];
cx q[2], q[4];
x q[4];
inv @ t q[4];
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
t q[4];
cx q[2], q[4];
x q[4];
inv @ t q[4];
h q[4];
// END unlifted_x
// BEGIN dup
h q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
h q[4];
t q[4];
cx q[1], q[4];
inv @ t q[4];
cx q[0], q[4];
t q[4];
cx q[1], q[4];
inv @ t q[4];
cx q[0], q[4];
h q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
h q[4];
// END dup
cp(3.141592653589793) q[0], q[4];
// BEGIN undup
h q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
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
t q[4];
cx q[2], q[4];
inv @ t q[4];
h q[4];
// END undup
ctrl(3) @ gphase(0.0) q[1], q[2], q[0];
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[0], q[1], q[2];
x q[1]; // want_negated=False
ctrl(2) @ ry(-1.5707963267948966) q[0], q[2], q[1]; // inplace_rot
x q[2]; // want_negated=True
ctrl(3) @ gphase(0.0) q[0], q[1], q[2];
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[1], q[0], q[2];
x q[1]; // want_negated=False
ctrl(2) @ ry(-1.5707963267948968) q[0], q[2], q[1]; // inplace_rot
x q[2]; // want_negated=False
ctrl(1) @ ry(-1.8754889808102941) q[0], q[2]; // inplace_rot
// BEGIN alloc
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
// END alloc
// BEGIN dup
h q[5];
t q[5];
cx q[2], q[5];
inv @ t q[5];
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
cx q[0], q[5];
h q[5];
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
h q[6];
t q[6];
cx q[1], q[6];
x q[6];
inv @ t q[6];
cx q[0], q[6];
t q[6];
cx q[1], q[6];
x q[6];
inv @ t q[6];
cx q[0], q[6];
h q[6];
t q[6];
cx q[2], q[6];
inv @ t q[6];
h q[6];
// END dup
// BEGIN dup
s q[7];
h q[7];
h q[7];
cx q[0], q[7];
t q[7];
cx q[1], q[7];
x q[7];
inv @ t q[7];
cx q[0], q[7];
t q[7];
cx q[1], q[7];
x q[7];
inv @ t q[7];
h q[7];
t q[7];
cx q[5], q[7];
inv @ t q[7];
h q[7];
t q[7];
cx q[1], q[7];
x q[7];
inv @ t q[7];
cx q[0], q[7];
t q[7];
cx q[1], q[7];
x q[7];
inv @ t q[7];
cx q[0], q[7];
h q[7];
t q[7];
cx q[5], q[7];
inv @ t q[7];
h q[7];
sdg q[7];
// END dup
// BEGIN alloc
s q[7];
h q[7];
cx q[0], q[7];
t q[7];
cx q[1], q[7];
inv @ t q[7];
cx q[0], q[7];
t q[7];
cx q[1], q[7];
inv @ t q[7];
h q[7];
sdg q[7];
// END alloc
// BEGIN dup
s q[4];
h q[4];
h q[4];
cx q[0], q[4];
t q[4];
cx q[1], q[4];
x q[4];
inv @ t q[4];
cx q[0], q[4];
t q[4];
cx q[1], q[4];
x q[4];
inv @ t q[4];
h q[4];
t q[4];
cx q[6], q[4];
inv @ t q[4];
h q[4];
t q[4];
cx q[1], q[4];
x q[4];
inv @ t q[4];
cx q[0], q[4];
t q[4];
cx q[1], q[4];
x q[4];
inv @ t q[4];
cx q[0], q[4];
h q[4];
t q[4];
cx q[6], q[4];
inv @ t q[4];
h q[4];
sdg q[4];
// END dup
// BEGIN dup
s q[8];
h q[8];
h q[8];
cx q[0], q[8];
t q[8];
cx q[7], q[8];
inv @ t q[8];
cx q[0], q[8];
t q[8];
cx q[7], q[8];
inv @ t q[8];
h q[8];
t q[8];
cx q[4], q[8];
inv @ t q[8];
h q[8];
t q[8];
cx q[7], q[8];
inv @ t q[8];
cx q[0], q[8];
t q[8];
cx q[7], q[8];
inv @ t q[8];
cx q[0], q[8];
h q[8];
t q[8];
cx q[4], q[8];
inv @ t q[8];
h q[8];
sdg q[8];
// END dup
cp(3.141592653589793) q[0], q[8];
// BEGIN undup
s q[8];
h q[8];
t q[8];
cx q[4], q[8];
inv @ t q[8];
h q[8];
cx q[0], q[8];
t q[8];
cx q[7], q[8];
inv @ t q[8];
cx q[0], q[8];
t q[8];
cx q[7], q[8];
inv @ t q[8];
h q[8];
t q[8];
cx q[4], q[8];
inv @ t q[8];
h q[8];
t q[8];
cx q[7], q[8];
inv @ t q[8];
cx q[0], q[8];
t q[8];
cx q[7], q[8];
inv @ t q[8];
cx q[0], q[8];
h q[8];
h q[8];
sdg q[8];
// END undup
// BEGIN undup
s q[4];
h q[4];
t q[4];
cx q[6], q[4];
inv @ t q[4];
h q[4];
cx q[0], q[4];
t q[4];
cx q[1], q[4];
x q[4];
inv @ t q[4];
cx q[0], q[4];
t q[4];
cx q[1], q[4];
x q[4];
inv @ t q[4];
h q[4];
t q[4];
cx q[6], q[4];
inv @ t q[4];
h q[4];
t q[4];
cx q[1], q[4];
x q[4];
inv @ t q[4];
cx q[0], q[4];
t q[4];
cx q[1], q[4];
x q[4];
inv @ t q[4];
cx q[0], q[4];
h q[4];
h q[4];
sdg q[4];
// END undup
// BEGIN undup
s q[7];
h q[7];
t q[7];
cx q[5], q[7];
inv @ t q[7];
h q[7];
cx q[0], q[7];
t q[7];
cx q[1], q[7];
x q[7];
inv @ t q[7];
cx q[0], q[7];
t q[7];
cx q[1], q[7];
x q[7];
inv @ t q[7];
h q[7];
t q[7];
cx q[5], q[7];
inv @ t q[7];
h q[7];
t q[7];
cx q[1], q[7];
x q[7];
inv @ t q[7];
cx q[0], q[7];
t q[7];
cx q[1], q[7];
x q[7];
inv @ t q[7];
cx q[0], q[7];
h q[7];
h q[7];
sdg q[7];
// END undup
// BEGIN dealloc
s q[7];
h q[7];
t q[7];
cx q[1], q[7];
inv @ t q[7];
cx q[0], q[7];
t q[7];
cx q[1], q[7];
inv @ t q[7];
cx q[0], q[7];
h q[7];
sdg q[7];
// END dealloc
// BEGIN undup
h q[6];
t q[6];
cx q[2], q[6];
inv @ t q[6];
h q[6];
cx q[0], q[6];
t q[6];
cx q[1], q[6];
x q[6];
inv @ t q[6];
cx q[0], q[6];
t q[6];
cx q[1], q[6];
x q[6];
inv @ t q[6];
h q[6];
t q[6];
cx q[2], q[6];
inv @ t q[6];
h q[6];
// END undup
// BEGIN dup
s q[6];
h q[6];
h q[6];
cx q[0], q[6];
t q[6];
cx q[1], q[6];
x q[6];
inv @ t q[6];
cx q[0], q[6];
t q[6];
cx q[1], q[6];
x q[6];
inv @ t q[6];
h q[6];
t q[6];
cx q[2], q[6];
inv @ t q[6];
h q[6];
t q[6];
cx q[1], q[6];
x q[6];
inv @ t q[6];
cx q[0], q[6];
t q[6];
cx q[1], q[6];
x q[6];
inv @ t q[6];
cx q[0], q[6];
h q[6];
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
h q[6];
cx q[0], q[6];
t q[6];
cx q[1], q[6];
x q[6];
inv @ t q[6];
cx q[0], q[6];
t q[6];
cx q[1], q[6];
x q[6];
inv @ t q[6];
h q[6];
t q[6];
cx q[5], q[6];
inv @ t q[6];
h q[6];
t q[6];
cx q[1], q[6];
x q[6];
inv @ t q[6];
cx q[0], q[6];
t q[6];
cx q[1], q[6];
x q[6];
inv @ t q[6];
cx q[0], q[6];
h q[6];
h q[6];
sdg q[6];
// END undup
// BEGIN undup
h q[5];
t q[5];
cx q[2], q[5];
inv @ t q[5];
h q[5];
cx q[0], q[5];
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
t q[5];
cx q[2], q[5];
inv @ t q[5];
h q[5];
// END undup
// BEGIN dealloc
s q[4];
h q[4];
t q[4];
cx q[1], q[4];
inv @ t q[4];
cx q[0], q[4];
t q[4];
cx q[1], q[4];
inv @ t q[4];
cx q[0], q[4];
h q[4];
sdg q[4];
// END dealloc
gphase(2.4724582099618003e-17);
x q[0]; // want_negated=False
p(-4.944916419923601e-17) q[0];
ry(0.29485997891881893) q[0]; // inplace_rot
p(4.944916419923601e-17) q[0];
gphase(-2.4724582099618003e-17);
x q[0]; // want_negated=True
ctrl(1) @ ry(1.8754889808102941) q[0], q[2]; // inplace_rot
x q[2]; // want_negated=True
ctrl(2) @ ry(1.5707963267948968) q[0], q[2], q[1]; // inplace_rot
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[0], q[2], q[1];
x q[1]; // want_negated=False
ctrl(3) @ gphase(0.0) q[0], q[1], q[2];
x q[2]; // want_negated=False
ctrl(2) @ ry(1.5707963267948966) q[0], q[2], q[1]; // inplace_rot
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[0], q[2], q[1];
x q[1]; // want_negated=False
ctrl(3) @ gphase(0.0) q[0], q[2], q[1];
// BEGIN lifted_x
h q[4];
t q[4];
cx q[2], q[4];
x q[4];
inv @ t q[4];
h q[4];
t q[4];
cx q[1], q[4];
inv @ t q[4];
cx q[0], q[4];
t q[4];
cx q[1], q[4];
inv @ t q[4];
cx q[0], q[4];
h q[4];
t q[4];
cx q[2], q[4];
x q[4];
inv @ t q[4];
h q[4];
// END lifted_x
ccx q[0], q[4], q[3]; // inplace_x
// BEGIN unlifted_x
h q[4];
t q[4];
cx q[2], q[4];
x q[4];
inv @ t q[4];
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
t q[4];
cx q[2], q[4];
x q[4];
inv @ t q[4];
h q[4];
// END unlifted_x
// BEGIN dup
h q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
h q[4];
t q[4];
cx q[1], q[4];
inv @ t q[4];
cx q[0], q[4];
t q[4];
cx q[1], q[4];
inv @ t q[4];
cx q[0], q[4];
h q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
h q[4];
// END dup
cp(3.141592653589793) q[0], q[4];
// BEGIN undup
h q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
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
t q[4];
cx q[2], q[4];
inv @ t q[4];
h q[4];
// END undup
ctrl(3) @ gphase(0.0) q[0], q[2], q[1];
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[0], q[2], q[1];
x q[1]; // want_negated=False
ctrl(2) @ ry(-1.5707963267948966) q[0], q[2], q[1]; // inplace_rot
x q[2]; // want_negated=True
ctrl(3) @ gphase(0.0) q[0], q[1], q[2];
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[0], q[2], q[1];
x q[1]; // want_negated=False
ctrl(2) @ ry(-1.5707963267948968) q[0], q[2], q[1]; // inplace_rot
x q[2]; // want_negated=False
ctrl(1) @ ry(-1.8754889808102941) q[0], q[2]; // inplace_rot
// BEGIN alloc
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
// END alloc
// BEGIN dup
h q[5];
t q[5];
cx q[2], q[5];
inv @ t q[5];
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
cx q[0], q[5];
h q[5];
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
h q[6];
t q[6];
cx q[1], q[6];
x q[6];
inv @ t q[6];
cx q[0], q[6];
t q[6];
cx q[1], q[6];
x q[6];
inv @ t q[6];
cx q[0], q[6];
h q[6];
t q[6];
cx q[2], q[6];
inv @ t q[6];
h q[6];
// END dup
// BEGIN dup
s q[7];
h q[7];
h q[7];
cx q[0], q[7];
t q[7];
cx q[1], q[7];
x q[7];
inv @ t q[7];
cx q[0], q[7];
t q[7];
cx q[1], q[7];
x q[7];
inv @ t q[7];
h q[7];
t q[7];
cx q[5], q[7];
inv @ t q[7];
h q[7];
t q[7];
cx q[1], q[7];
x q[7];
inv @ t q[7];
cx q[0], q[7];
t q[7];
cx q[1], q[7];
x q[7];
inv @ t q[7];
cx q[0], q[7];
h q[7];
t q[7];
cx q[5], q[7];
inv @ t q[7];
h q[7];
sdg q[7];
// END dup
// BEGIN alloc
s q[7];
h q[7];
cx q[0], q[7];
t q[7];
cx q[1], q[7];
inv @ t q[7];
cx q[0], q[7];
t q[7];
cx q[1], q[7];
inv @ t q[7];
h q[7];
sdg q[7];
// END alloc
// BEGIN dup
s q[4];
h q[4];
h q[4];
cx q[0], q[4];
t q[4];
cx q[1], q[4];
x q[4];
inv @ t q[4];
cx q[0], q[4];
t q[4];
cx q[1], q[4];
x q[4];
inv @ t q[4];
h q[4];
t q[4];
cx q[6], q[4];
inv @ t q[4];
h q[4];
t q[4];
cx q[1], q[4];
x q[4];
inv @ t q[4];
cx q[0], q[4];
t q[4];
cx q[1], q[4];
x q[4];
inv @ t q[4];
cx q[0], q[4];
h q[4];
t q[4];
cx q[6], q[4];
inv @ t q[4];
h q[4];
sdg q[4];
// END dup
// BEGIN dup
s q[8];
h q[8];
h q[8];
cx q[0], q[8];
t q[8];
cx q[7], q[8];
inv @ t q[8];
cx q[0], q[8];
t q[8];
cx q[7], q[8];
inv @ t q[8];
h q[8];
t q[8];
cx q[4], q[8];
inv @ t q[8];
h q[8];
t q[8];
cx q[7], q[8];
inv @ t q[8];
cx q[0], q[8];
t q[8];
cx q[7], q[8];
inv @ t q[8];
cx q[0], q[8];
h q[8];
t q[8];
cx q[4], q[8];
inv @ t q[8];
h q[8];
sdg q[8];
// END dup
cp(3.141592653589793) q[0], q[8];
// BEGIN undup
s q[8];
h q[8];
t q[8];
cx q[4], q[8];
inv @ t q[8];
h q[8];
cx q[0], q[8];
t q[8];
cx q[7], q[8];
inv @ t q[8];
cx q[0], q[8];
t q[8];
cx q[7], q[8];
inv @ t q[8];
h q[8];
t q[8];
cx q[4], q[8];
inv @ t q[8];
h q[8];
t q[8];
cx q[7], q[8];
inv @ t q[8];
cx q[0], q[8];
t q[8];
cx q[7], q[8];
inv @ t q[8];
cx q[0], q[8];
h q[8];
h q[8];
sdg q[8];
// END undup
// BEGIN undup
s q[4];
h q[4];
t q[4];
cx q[6], q[4];
inv @ t q[4];
h q[4];
cx q[0], q[4];
t q[4];
cx q[1], q[4];
x q[4];
inv @ t q[4];
cx q[0], q[4];
t q[4];
cx q[1], q[4];
x q[4];
inv @ t q[4];
h q[4];
t q[4];
cx q[6], q[4];
inv @ t q[4];
h q[4];
t q[4];
cx q[1], q[4];
x q[4];
inv @ t q[4];
cx q[0], q[4];
t q[4];
cx q[1], q[4];
x q[4];
inv @ t q[4];
cx q[0], q[4];
h q[4];
h q[4];
sdg q[4];
// END undup
// BEGIN undup
s q[7];
h q[7];
t q[7];
cx q[5], q[7];
inv @ t q[7];
h q[7];
cx q[0], q[7];
t q[7];
cx q[1], q[7];
x q[7];
inv @ t q[7];
cx q[0], q[7];
t q[7];
cx q[1], q[7];
x q[7];
inv @ t q[7];
h q[7];
t q[7];
cx q[5], q[7];
inv @ t q[7];
h q[7];
t q[7];
cx q[1], q[7];
x q[7];
inv @ t q[7];
cx q[0], q[7];
t q[7];
cx q[1], q[7];
x q[7];
inv @ t q[7];
cx q[0], q[7];
h q[7];
h q[7];
sdg q[7];
// END undup
// BEGIN dealloc
s q[7];
h q[7];
t q[7];
cx q[1], q[7];
inv @ t q[7];
cx q[0], q[7];
t q[7];
cx q[1], q[7];
inv @ t q[7];
cx q[0], q[7];
h q[7];
sdg q[7];
// END dealloc
// BEGIN undup
h q[6];
t q[6];
cx q[2], q[6];
inv @ t q[6];
h q[6];
cx q[0], q[6];
t q[6];
cx q[1], q[6];
x q[6];
inv @ t q[6];
cx q[0], q[6];
t q[6];
cx q[1], q[6];
x q[6];
inv @ t q[6];
h q[6];
t q[6];
cx q[2], q[6];
inv @ t q[6];
h q[6];
// END undup
// BEGIN dup
s q[6];
h q[6];
h q[6];
cx q[0], q[6];
t q[6];
cx q[1], q[6];
x q[6];
inv @ t q[6];
cx q[0], q[6];
t q[6];
cx q[1], q[6];
x q[6];
inv @ t q[6];
h q[6];
t q[6];
cx q[2], q[6];
inv @ t q[6];
h q[6];
t q[6];
cx q[1], q[6];
x q[6];
inv @ t q[6];
cx q[0], q[6];
t q[6];
cx q[1], q[6];
x q[6];
inv @ t q[6];
cx q[0], q[6];
h q[6];
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
h q[6];
cx q[0], q[6];
t q[6];
cx q[1], q[6];
x q[6];
inv @ t q[6];
cx q[0], q[6];
t q[6];
cx q[1], q[6];
x q[6];
inv @ t q[6];
h q[6];
t q[6];
cx q[5], q[6];
inv @ t q[6];
h q[6];
t q[6];
cx q[1], q[6];
x q[6];
inv @ t q[6];
cx q[0], q[6];
t q[6];
cx q[1], q[6];
x q[6];
inv @ t q[6];
cx q[0], q[6];
h q[6];
h q[6];
sdg q[6];
// END undup
// BEGIN undup
h q[5];
t q[5];
cx q[2], q[5];
inv @ t q[5];
h q[5];
cx q[0], q[5];
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
t q[5];
cx q[2], q[5];
inv @ t q[5];
h q[5];
// END undup
// BEGIN dealloc
s q[4];
h q[4];
t q[4];
cx q[1], q[4];
inv @ t q[4];
cx q[0], q[4];
t q[4];
cx q[1], q[4];
inv @ t q[4];
cx q[0], q[4];
h q[4];
sdg q[4];
// END dealloc
gphase(0.0);
x q[0]; // want_negated=False
p(0.0) q[0];
ry(0.0) q[0]; // inplace_rot
p(0.0) q[0];
gphase(0.0);
x q[0]; // want_negated=True
ctrl(1) @ ry(1.8754889808102941) q[0], q[2]; // inplace_rot
x q[2]; // want_negated=True
ctrl(2) @ ry(1.5707963267948968) q[2], q[0], q[1]; // inplace_rot
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[2], q[1], q[0];
x q[1]; // want_negated=False
ctrl(3) @ gphase(0.0) q[2], q[1], q[0];
x q[2]; // want_negated=False
ctrl(2) @ ry(1.5707963267948966) q[2], q[0], q[1]; // inplace_rot
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[2], q[1], q[0];
x q[1]; // want_negated=False
ctrl(3) @ gphase(0.0) q[1], q[2], q[0];
// BEGIN lifted_x
h q[4];
t q[4];
cx q[2], q[4];
x q[4];
inv @ t q[4];
h q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
h q[4];
t q[4];
cx q[2], q[4];
x q[4];
inv @ t q[4];
h q[4];
// END lifted_x
ccx q[4], q[0], q[3]; // inplace_x
// BEGIN unlifted_x
h q[4];
t q[4];
cx q[2], q[4];
x q[4];
inv @ t q[4];
h q[4];
cx q[1], q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
h q[4];
t q[4];
cx q[2], q[4];
x q[4];
inv @ t q[4];
h q[4];
// END unlifted_x
// BEGIN dup
h q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
h q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
h q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
h q[4];
// END dup
cp(3.141592653589793) q[4], q[0];
// BEGIN undup
h q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
h q[4];
cx q[1], q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
h q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
h q[4];
// END undup
ctrl(3) @ gphase(0.0) q[2], q[0], q[1];
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[2], q[1], q[0];
x q[1]; // want_negated=False
ctrl(2) @ ry(-1.5707963267948966) q[2], q[0], q[1]; // inplace_rot
x q[2]; // want_negated=True
ctrl(3) @ gphase(0.0) q[2], q[1], q[0];
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[2], q[1], q[0];
x q[1]; // want_negated=False
ctrl(2) @ ry(-1.5707963267948968) q[2], q[0], q[1]; // inplace_rot
x q[2]; // want_negated=False
ctrl(1) @ ry(-1.8754889808102941) q[0], q[2]; // inplace_rot
// BEGIN alloc
s q[4];
h q[4];
cx q[1], q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
h q[4];
sdg q[4];
// END alloc
// BEGIN dup
h q[5];
t q[5];
cx q[2], q[5];
inv @ t q[5];
h q[5];
t q[5];
cx q[0], q[5];
inv @ t q[5];
cx q[1], q[5];
x q[5];
t q[5];
cx q[0], q[5];
inv @ t q[5];
cx q[1], q[5];
x q[5];
h q[5];
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
h q[6];
t q[6];
cx q[0], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[0], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
h q[6];
t q[6];
cx q[2], q[6];
inv @ t q[6];
h q[6];
// END dup
// BEGIN dup
s q[7];
h q[7];
h q[7];
cx q[1], q[7];
x q[7];
t q[7];
cx q[0], q[7];
inv @ t q[7];
cx q[1], q[7];
x q[7];
t q[7];
cx q[0], q[7];
inv @ t q[7];
h q[7];
t q[7];
cx q[5], q[7];
inv @ t q[7];
h q[7];
t q[7];
cx q[0], q[7];
inv @ t q[7];
cx q[1], q[7];
x q[7];
t q[7];
cx q[0], q[7];
inv @ t q[7];
cx q[1], q[7];
x q[7];
h q[7];
t q[7];
cx q[5], q[7];
inv @ t q[7];
h q[7];
sdg q[7];
// END dup
// BEGIN alloc
s q[7];
h q[7];
cx q[1], q[7];
t q[7];
cx q[0], q[7];
inv @ t q[7];
cx q[1], q[7];
t q[7];
cx q[0], q[7];
inv @ t q[7];
h q[7];
sdg q[7];
// END alloc
// BEGIN dup
s q[4];
h q[4];
h q[4];
cx q[1], q[4];
x q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
x q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
h q[4];
t q[4];
cx q[6], q[4];
inv @ t q[4];
h q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
x q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
x q[4];
h q[4];
t q[4];
cx q[6], q[4];
inv @ t q[4];
h q[4];
sdg q[4];
// END dup
// BEGIN dup
s q[8];
h q[8];
h q[8];
cx q[7], q[8];
t q[8];
cx q[0], q[8];
inv @ t q[8];
cx q[7], q[8];
t q[8];
cx q[0], q[8];
inv @ t q[8];
h q[8];
t q[8];
cx q[4], q[8];
inv @ t q[8];
h q[8];
t q[8];
cx q[0], q[8];
inv @ t q[8];
cx q[7], q[8];
t q[8];
cx q[0], q[8];
inv @ t q[8];
cx q[7], q[8];
h q[8];
t q[8];
cx q[4], q[8];
inv @ t q[8];
h q[8];
sdg q[8];
// END dup
cp(3.141592653589793) q[8], q[0];
// BEGIN undup
s q[8];
h q[8];
t q[8];
cx q[4], q[8];
inv @ t q[8];
h q[8];
cx q[7], q[8];
t q[8];
cx q[0], q[8];
inv @ t q[8];
cx q[7], q[8];
t q[8];
cx q[0], q[8];
inv @ t q[8];
h q[8];
t q[8];
cx q[4], q[8];
inv @ t q[8];
h q[8];
t q[8];
cx q[0], q[8];
inv @ t q[8];
cx q[7], q[8];
t q[8];
cx q[0], q[8];
inv @ t q[8];
cx q[7], q[8];
h q[8];
h q[8];
sdg q[8];
// END undup
// BEGIN undup
s q[4];
h q[4];
t q[4];
cx q[6], q[4];
inv @ t q[4];
h q[4];
cx q[1], q[4];
x q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
x q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
h q[4];
t q[4];
cx q[6], q[4];
inv @ t q[4];
h q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
x q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
x q[4];
h q[4];
h q[4];
sdg q[4];
// END undup
// BEGIN undup
s q[7];
h q[7];
t q[7];
cx q[5], q[7];
inv @ t q[7];
h q[7];
cx q[1], q[7];
x q[7];
t q[7];
cx q[0], q[7];
inv @ t q[7];
cx q[1], q[7];
x q[7];
t q[7];
cx q[0], q[7];
inv @ t q[7];
h q[7];
t q[7];
cx q[5], q[7];
inv @ t q[7];
h q[7];
t q[7];
cx q[0], q[7];
inv @ t q[7];
cx q[1], q[7];
x q[7];
t q[7];
cx q[0], q[7];
inv @ t q[7];
cx q[1], q[7];
x q[7];
h q[7];
h q[7];
sdg q[7];
// END undup
// BEGIN dealloc
s q[7];
h q[7];
t q[7];
cx q[0], q[7];
inv @ t q[7];
cx q[1], q[7];
t q[7];
cx q[0], q[7];
inv @ t q[7];
cx q[1], q[7];
h q[7];
sdg q[7];
// END dealloc
// BEGIN undup
h q[6];
t q[6];
cx q[2], q[6];
inv @ t q[6];
h q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[0], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[0], q[6];
inv @ t q[6];
h q[6];
t q[6];
cx q[2], q[6];
inv @ t q[6];
h q[6];
// END undup
// BEGIN dup
s q[6];
h q[6];
h q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[0], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[0], q[6];
inv @ t q[6];
h q[6];
t q[6];
cx q[2], q[6];
inv @ t q[6];
h q[6];
t q[6];
cx q[0], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[0], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
h q[6];
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
h q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[0], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[0], q[6];
inv @ t q[6];
h q[6];
t q[6];
cx q[5], q[6];
inv @ t q[6];
h q[6];
t q[6];
cx q[0], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[0], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
h q[6];
h q[6];
sdg q[6];
// END undup
// BEGIN undup
h q[5];
t q[5];
cx q[2], q[5];
inv @ t q[5];
h q[5];
cx q[1], q[5];
x q[5];
t q[5];
cx q[0], q[5];
inv @ t q[5];
cx q[1], q[5];
x q[5];
t q[5];
cx q[0], q[5];
inv @ t q[5];
h q[5];
t q[5];
cx q[2], q[5];
inv @ t q[5];
h q[5];
// END undup
// BEGIN dealloc
s q[4];
h q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
h q[4];
sdg q[4];
// END dealloc
gphase(-1.5707963267948966);
x q[0]; // want_negated=False
p(3.141592653589793) q[0];
ry(0.3080869698435683) q[0]; // inplace_rot
p(-3.141592653589793) q[0];
gphase(1.5707963267948966);
x q[0]; // want_negated=True
ctrl(1) @ ry(1.8754889808102941) q[0], q[2]; // inplace_rot
x q[2]; // want_negated=True
ctrl(2) @ ry(1.5707963267948968) q[2], q[0], q[1]; // inplace_rot
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[2], q[1], q[0];
x q[1]; // want_negated=False
ctrl(3) @ gphase(0.0) q[2], q[1], q[0];
x q[2]; // want_negated=False
ctrl(2) @ ry(1.5707963267948966) q[2], q[0], q[1]; // inplace_rot
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[1], q[2], q[0];
x q[1]; // want_negated=False
ctrl(3) @ gphase(0.0) q[2], q[0], q[1];
// BEGIN lifted_x
h q[4];
t q[4];
cx q[2], q[4];
x q[4];
inv @ t q[4];
h q[4];
t q[4];
cx q[1], q[4];
inv @ t q[4];
cx q[0], q[4];
t q[4];
cx q[1], q[4];
inv @ t q[4];
cx q[0], q[4];
h q[4];
t q[4];
cx q[2], q[4];
x q[4];
inv @ t q[4];
h q[4];
// END lifted_x
ccx q[0], q[4], q[3]; // inplace_x
// BEGIN unlifted_x
h q[4];
t q[4];
cx q[2], q[4];
x q[4];
inv @ t q[4];
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
t q[4];
cx q[2], q[4];
x q[4];
inv @ t q[4];
h q[4];
// END unlifted_x
// BEGIN dup
h q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
h q[4];
t q[4];
cx q[1], q[4];
inv @ t q[4];
cx q[0], q[4];
t q[4];
cx q[1], q[4];
inv @ t q[4];
cx q[0], q[4];
h q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
h q[4];
// END dup
cp(3.141592653589793) q[4], q[0];
// BEGIN undup
h q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
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
t q[4];
cx q[2], q[4];
inv @ t q[4];
h q[4];
// END undup
ctrl(3) @ gphase(0.0) q[2], q[0], q[1];
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[2], q[0], q[1];
x q[1]; // want_negated=False
ctrl(2) @ ry(-1.5707963267948966) q[2], q[0], q[1]; // inplace_rot
x q[2]; // want_negated=True
ctrl(3) @ gphase(0.0) q[2], q[1], q[0];
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[2], q[1], q[0];
x q[1]; // want_negated=False
ctrl(2) @ ry(-1.5707963267948968) q[2], q[0], q[1]; // inplace_rot
x q[2]; // want_negated=False
ctrl(1) @ ry(-1.8754889808102941) q[0], q[2]; // inplace_rot
// BEGIN alloc
s q[4];
h q[4];
cx q[1], q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
h q[4];
sdg q[4];
// END alloc
// BEGIN dup
h q[5];
t q[5];
cx q[2], q[5];
inv @ t q[5];
h q[5];
t q[5];
cx q[0], q[5];
inv @ t q[5];
cx q[1], q[5];
x q[5];
t q[5];
cx q[0], q[5];
inv @ t q[5];
cx q[1], q[5];
x q[5];
h q[5];
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
h q[6];
t q[6];
cx q[0], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[0], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
h q[6];
t q[6];
cx q[2], q[6];
inv @ t q[6];
h q[6];
// END dup
// BEGIN dup
s q[7];
h q[7];
h q[7];
cx q[1], q[7];
x q[7];
t q[7];
cx q[0], q[7];
inv @ t q[7];
cx q[1], q[7];
x q[7];
t q[7];
cx q[0], q[7];
inv @ t q[7];
h q[7];
t q[7];
cx q[5], q[7];
inv @ t q[7];
h q[7];
t q[7];
cx q[0], q[7];
inv @ t q[7];
cx q[1], q[7];
x q[7];
t q[7];
cx q[0], q[7];
inv @ t q[7];
cx q[1], q[7];
x q[7];
h q[7];
t q[7];
cx q[5], q[7];
inv @ t q[7];
h q[7];
sdg q[7];
// END dup
// BEGIN alloc
s q[7];
h q[7];
cx q[1], q[7];
t q[7];
cx q[0], q[7];
inv @ t q[7];
cx q[1], q[7];
t q[7];
cx q[0], q[7];
inv @ t q[7];
h q[7];
sdg q[7];
// END alloc
// BEGIN dup
s q[4];
h q[4];
h q[4];
cx q[1], q[4];
x q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
x q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
h q[4];
t q[4];
cx q[6], q[4];
inv @ t q[4];
h q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
x q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
x q[4];
h q[4];
t q[4];
cx q[6], q[4];
inv @ t q[4];
h q[4];
sdg q[4];
// END dup
// BEGIN dup
s q[8];
h q[8];
h q[8];
cx q[0], q[8];
t q[8];
cx q[7], q[8];
inv @ t q[8];
cx q[0], q[8];
t q[8];
cx q[7], q[8];
inv @ t q[8];
h q[8];
t q[8];
cx q[4], q[8];
inv @ t q[8];
h q[8];
t q[8];
cx q[7], q[8];
inv @ t q[8];
cx q[0], q[8];
t q[8];
cx q[7], q[8];
inv @ t q[8];
cx q[0], q[8];
h q[8];
t q[8];
cx q[4], q[8];
inv @ t q[8];
h q[8];
sdg q[8];
// END dup
cp(3.141592653589793) q[8], q[0];
// BEGIN undup
s q[8];
h q[8];
t q[8];
cx q[4], q[8];
inv @ t q[8];
h q[8];
cx q[0], q[8];
t q[8];
cx q[7], q[8];
inv @ t q[8];
cx q[0], q[8];
t q[8];
cx q[7], q[8];
inv @ t q[8];
h q[8];
t q[8];
cx q[4], q[8];
inv @ t q[8];
h q[8];
t q[8];
cx q[7], q[8];
inv @ t q[8];
cx q[0], q[8];
t q[8];
cx q[7], q[8];
inv @ t q[8];
cx q[0], q[8];
h q[8];
h q[8];
sdg q[8];
// END undup
// BEGIN undup
s q[4];
h q[4];
t q[4];
cx q[6], q[4];
inv @ t q[4];
h q[4];
cx q[1], q[4];
x q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
x q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
h q[4];
t q[4];
cx q[6], q[4];
inv @ t q[4];
h q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
x q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
x q[4];
h q[4];
h q[4];
sdg q[4];
// END undup
// BEGIN undup
s q[7];
h q[7];
t q[7];
cx q[5], q[7];
inv @ t q[7];
h q[7];
cx q[1], q[7];
x q[7];
t q[7];
cx q[0], q[7];
inv @ t q[7];
cx q[1], q[7];
x q[7];
t q[7];
cx q[0], q[7];
inv @ t q[7];
h q[7];
t q[7];
cx q[5], q[7];
inv @ t q[7];
h q[7];
t q[7];
cx q[0], q[7];
inv @ t q[7];
cx q[1], q[7];
x q[7];
t q[7];
cx q[0], q[7];
inv @ t q[7];
cx q[1], q[7];
x q[7];
h q[7];
h q[7];
sdg q[7];
// END undup
// BEGIN dealloc
s q[7];
h q[7];
t q[7];
cx q[0], q[7];
inv @ t q[7];
cx q[1], q[7];
t q[7];
cx q[0], q[7];
inv @ t q[7];
cx q[1], q[7];
h q[7];
sdg q[7];
// END dealloc
// BEGIN undup
h q[6];
t q[6];
cx q[2], q[6];
inv @ t q[6];
h q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[0], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[0], q[6];
inv @ t q[6];
h q[6];
t q[6];
cx q[2], q[6];
inv @ t q[6];
h q[6];
// END undup
// BEGIN dup
s q[6];
h q[6];
h q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[0], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[0], q[6];
inv @ t q[6];
h q[6];
t q[6];
cx q[2], q[6];
inv @ t q[6];
h q[6];
t q[6];
cx q[0], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[0], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
h q[6];
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
h q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[0], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[0], q[6];
inv @ t q[6];
h q[6];
t q[6];
cx q[5], q[6];
inv @ t q[6];
h q[6];
t q[6];
cx q[0], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[0], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
h q[6];
h q[6];
sdg q[6];
// END undup
// BEGIN undup
h q[5];
t q[5];
cx q[2], q[5];
inv @ t q[5];
h q[5];
cx q[1], q[5];
x q[5];
t q[5];
cx q[0], q[5];
inv @ t q[5];
cx q[1], q[5];
x q[5];
t q[5];
cx q[0], q[5];
inv @ t q[5];
h q[5];
t q[5];
cx q[2], q[5];
inv @ t q[5];
h q[5];
// END undup
// BEGIN dealloc
s q[4];
h q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
h q[4];
sdg q[4];
// END dealloc
gphase(0.0);
x q[0]; // want_negated=False
p(0.0) q[0];
ry(0.0) q[0]; // inplace_rot
p(0.0) q[0];
gphase(0.0);
x q[0]; // want_negated=True
ctrl(1) @ ry(1.8754889808102941) q[0], q[2]; // inplace_rot
x q[2]; // want_negated=True
ctrl(2) @ ry(1.5707963267948968) q[0], q[2], q[1]; // inplace_rot
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[1], q[0], q[2];
x q[1]; // want_negated=False
ctrl(3) @ gphase(0.0) q[1], q[0], q[2];
x q[2]; // want_negated=False
ctrl(2) @ ry(1.5707963267948966) q[2], q[0], q[1]; // inplace_rot
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[2], q[0], q[1];
x q[1]; // want_negated=False
ctrl(3) @ gphase(0.0) q[1], q[2], q[0];
// BEGIN lifted_x
h q[4];
t q[4];
cx q[2], q[4];
x q[4];
inv @ t q[4];
h q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
h q[4];
t q[4];
cx q[2], q[4];
x q[4];
inv @ t q[4];
h q[4];
// END lifted_x
ccx q[4], q[0], q[3]; // inplace_x
// BEGIN unlifted_x
h q[4];
t q[4];
cx q[2], q[4];
x q[4];
inv @ t q[4];
h q[4];
cx q[1], q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
h q[4];
t q[4];
cx q[2], q[4];
x q[4];
inv @ t q[4];
h q[4];
// END unlifted_x
// BEGIN dup
h q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
h q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
h q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
h q[4];
// END dup
cp(3.141592653589793) q[4], q[0];
// BEGIN undup
h q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
h q[4];
cx q[1], q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
h q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
h q[4];
// END undup
ctrl(3) @ gphase(0.0) q[1], q[2], q[0];
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[1], q[2], q[0];
x q[1]; // want_negated=False
ctrl(2) @ ry(-1.5707963267948966) q[2], q[0], q[1]; // inplace_rot
x q[2]; // want_negated=True
ctrl(3) @ gphase(0.0) q[0], q[2], q[1];
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[1], q[0], q[2];
x q[1]; // want_negated=False
ctrl(2) @ ry(-1.5707963267948968) q[0], q[2], q[1]; // inplace_rot
x q[2]; // want_negated=False
ctrl(1) @ ry(-1.8754889808102941) q[0], q[2]; // inplace_rot
// BEGIN alloc
s q[4];
h q[4];
cx q[1], q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
h q[4];
sdg q[4];
// END alloc
// BEGIN dup
h q[5];
t q[5];
cx q[2], q[5];
inv @ t q[5];
h q[5];
t q[5];
cx q[0], q[5];
inv @ t q[5];
cx q[1], q[5];
x q[5];
t q[5];
cx q[0], q[5];
inv @ t q[5];
cx q[1], q[5];
x q[5];
h q[5];
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
h q[6];
t q[6];
cx q[0], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[0], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
h q[6];
t q[6];
cx q[2], q[6];
inv @ t q[6];
h q[6];
// END dup
// BEGIN dup
s q[7];
h q[7];
h q[7];
cx q[1], q[7];
x q[7];
t q[7];
cx q[0], q[7];
inv @ t q[7];
cx q[1], q[7];
x q[7];
t q[7];
cx q[0], q[7];
inv @ t q[7];
h q[7];
t q[7];
cx q[5], q[7];
inv @ t q[7];
h q[7];
t q[7];
cx q[0], q[7];
inv @ t q[7];
cx q[1], q[7];
x q[7];
t q[7];
cx q[0], q[7];
inv @ t q[7];
cx q[1], q[7];
x q[7];
h q[7];
t q[7];
cx q[5], q[7];
inv @ t q[7];
h q[7];
sdg q[7];
// END dup
// BEGIN alloc
s q[7];
h q[7];
cx q[1], q[7];
t q[7];
cx q[0], q[7];
inv @ t q[7];
cx q[1], q[7];
t q[7];
cx q[0], q[7];
inv @ t q[7];
h q[7];
sdg q[7];
// END alloc
// BEGIN dup
s q[4];
h q[4];
h q[4];
cx q[1], q[4];
x q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
x q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
h q[4];
t q[4];
cx q[6], q[4];
inv @ t q[4];
h q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
x q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
x q[4];
h q[4];
t q[4];
cx q[6], q[4];
inv @ t q[4];
h q[4];
sdg q[4];
// END dup
// BEGIN dup
s q[8];
h q[8];
h q[8];
cx q[7], q[8];
t q[8];
cx q[0], q[8];
inv @ t q[8];
cx q[7], q[8];
t q[8];
cx q[0], q[8];
inv @ t q[8];
h q[8];
t q[8];
cx q[4], q[8];
inv @ t q[8];
h q[8];
t q[8];
cx q[0], q[8];
inv @ t q[8];
cx q[7], q[8];
t q[8];
cx q[0], q[8];
inv @ t q[8];
cx q[7], q[8];
h q[8];
t q[8];
cx q[4], q[8];
inv @ t q[8];
h q[8];
sdg q[8];
// END dup
cp(3.141592653589793) q[8], q[0];
// BEGIN undup
s q[8];
h q[8];
t q[8];
cx q[4], q[8];
inv @ t q[8];
h q[8];
cx q[7], q[8];
t q[8];
cx q[0], q[8];
inv @ t q[8];
cx q[7], q[8];
t q[8];
cx q[0], q[8];
inv @ t q[8];
h q[8];
t q[8];
cx q[4], q[8];
inv @ t q[8];
h q[8];
t q[8];
cx q[0], q[8];
inv @ t q[8];
cx q[7], q[8];
t q[8];
cx q[0], q[8];
inv @ t q[8];
cx q[7], q[8];
h q[8];
h q[8];
sdg q[8];
// END undup
// BEGIN undup
s q[4];
h q[4];
t q[4];
cx q[6], q[4];
inv @ t q[4];
h q[4];
cx q[1], q[4];
x q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
x q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
h q[4];
t q[4];
cx q[6], q[4];
inv @ t q[4];
h q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
x q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
x q[4];
h q[4];
h q[4];
sdg q[4];
// END undup
// BEGIN undup
s q[7];
h q[7];
t q[7];
cx q[5], q[7];
inv @ t q[7];
h q[7];
cx q[1], q[7];
x q[7];
t q[7];
cx q[0], q[7];
inv @ t q[7];
cx q[1], q[7];
x q[7];
t q[7];
cx q[0], q[7];
inv @ t q[7];
h q[7];
t q[7];
cx q[5], q[7];
inv @ t q[7];
h q[7];
t q[7];
cx q[0], q[7];
inv @ t q[7];
cx q[1], q[7];
x q[7];
t q[7];
cx q[0], q[7];
inv @ t q[7];
cx q[1], q[7];
x q[7];
h q[7];
h q[7];
sdg q[7];
// END undup
// BEGIN dealloc
s q[7];
h q[7];
t q[7];
cx q[0], q[7];
inv @ t q[7];
cx q[1], q[7];
t q[7];
cx q[0], q[7];
inv @ t q[7];
cx q[1], q[7];
h q[7];
sdg q[7];
// END dealloc
// BEGIN undup
h q[6];
t q[6];
cx q[2], q[6];
inv @ t q[6];
h q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[0], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[0], q[6];
inv @ t q[6];
h q[6];
t q[6];
cx q[2], q[6];
inv @ t q[6];
h q[6];
// END undup
// BEGIN dup
s q[6];
h q[6];
h q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[0], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[0], q[6];
inv @ t q[6];
h q[6];
t q[6];
cx q[2], q[6];
inv @ t q[6];
h q[6];
t q[6];
cx q[0], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[0], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
h q[6];
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
h q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[0], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[0], q[6];
inv @ t q[6];
h q[6];
t q[6];
cx q[5], q[6];
inv @ t q[6];
h q[6];
t q[6];
cx q[0], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[0], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
h q[6];
h q[6];
sdg q[6];
// END undup
// BEGIN undup
h q[5];
t q[5];
cx q[2], q[5];
inv @ t q[5];
h q[5];
cx q[1], q[5];
x q[5];
t q[5];
cx q[0], q[5];
inv @ t q[5];
cx q[1], q[5];
x q[5];
t q[5];
cx q[0], q[5];
inv @ t q[5];
h q[5];
t q[5];
cx q[2], q[5];
inv @ t q[5];
h q[5];
// END undup
// BEGIN dealloc
s q[4];
h q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
h q[4];
sdg q[4];
// END dealloc
gphase(2.1369319598010493e-17);
x q[0]; // want_negated=False
p(-4.2738639196020986e-17) q[0];
ry(0.3075064574390496) q[0]; // inplace_rot
p(4.2738639196020986e-17) q[0];
gphase(-2.1369319598010493e-17);
x q[0]; // want_negated=True
ctrl(1) @ ry(1.8754889808102941) q[0], q[2]; // inplace_rot
x q[2]; // want_negated=True
ctrl(2) @ ry(1.5707963267948968) q[2], q[0], q[1]; // inplace_rot
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[1], q[2], q[0];
x q[1]; // want_negated=False
ctrl(3) @ gphase(0.0) q[1], q[2], q[0];
x q[2]; // want_negated=False
ctrl(2) @ ry(1.5707963267948966) q[2], q[0], q[1]; // inplace_rot
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[1], q[2], q[0];
x q[1]; // want_negated=False
ctrl(3) @ gphase(0.0) q[1], q[2], q[0];
// BEGIN lifted_x
h q[4];
t q[4];
cx q[2], q[4];
x q[4];
inv @ t q[4];
h q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
h q[4];
t q[4];
cx q[2], q[4];
x q[4];
inv @ t q[4];
h q[4];
// END lifted_x
ccx q[4], q[0], q[3]; // inplace_x
// BEGIN unlifted_x
h q[4];
t q[4];
cx q[2], q[4];
x q[4];
inv @ t q[4];
h q[4];
cx q[1], q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
h q[4];
t q[4];
cx q[2], q[4];
x q[4];
inv @ t q[4];
h q[4];
// END unlifted_x
// BEGIN dup
h q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
h q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
h q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
h q[4];
// END dup
cp(3.141592653589793) q[4], q[0];
// BEGIN undup
h q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
h q[4];
cx q[1], q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
h q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
h q[4];
// END undup
ctrl(3) @ gphase(0.0) q[2], q[1], q[0];
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[2], q[1], q[0];
x q[1]; // want_negated=False
ctrl(2) @ ry(-1.5707963267948966) q[2], q[0], q[1]; // inplace_rot
x q[2]; // want_negated=True
ctrl(3) @ gphase(0.0) q[1], q[2], q[0];
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[0], q[2], q[1];
x q[1]; // want_negated=False
ctrl(2) @ ry(-1.5707963267948968) q[2], q[0], q[1]; // inplace_rot
x q[2]; // want_negated=False
ctrl(1) @ ry(-1.8754889808102941) q[0], q[2]; // inplace_rot
// BEGIN alloc
s q[4];
h q[4];
cx q[1], q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
h q[4];
sdg q[4];
// END alloc
// BEGIN dup
h q[5];
t q[5];
cx q[2], q[5];
inv @ t q[5];
h q[5];
t q[5];
cx q[0], q[5];
inv @ t q[5];
cx q[1], q[5];
x q[5];
t q[5];
cx q[0], q[5];
inv @ t q[5];
cx q[1], q[5];
x q[5];
h q[5];
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
h q[6];
t q[6];
cx q[0], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[0], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
h q[6];
t q[6];
cx q[2], q[6];
inv @ t q[6];
h q[6];
// END dup
// BEGIN dup
s q[7];
h q[7];
h q[7];
cx q[1], q[7];
x q[7];
t q[7];
cx q[0], q[7];
inv @ t q[7];
cx q[1], q[7];
x q[7];
t q[7];
cx q[0], q[7];
inv @ t q[7];
h q[7];
t q[7];
cx q[5], q[7];
inv @ t q[7];
h q[7];
t q[7];
cx q[0], q[7];
inv @ t q[7];
cx q[1], q[7];
x q[7];
t q[7];
cx q[0], q[7];
inv @ t q[7];
cx q[1], q[7];
x q[7];
h q[7];
t q[7];
cx q[5], q[7];
inv @ t q[7];
h q[7];
sdg q[7];
// END dup
// BEGIN alloc
s q[7];
h q[7];
cx q[1], q[7];
t q[7];
cx q[0], q[7];
inv @ t q[7];
cx q[1], q[7];
t q[7];
cx q[0], q[7];
inv @ t q[7];
h q[7];
sdg q[7];
// END alloc
// BEGIN dup
s q[4];
h q[4];
h q[4];
cx q[1], q[4];
x q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
x q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
h q[4];
t q[4];
cx q[6], q[4];
inv @ t q[4];
h q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
x q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
x q[4];
h q[4];
t q[4];
cx q[6], q[4];
inv @ t q[4];
h q[4];
sdg q[4];
// END dup
// BEGIN dup
s q[8];
h q[8];
h q[8];
cx q[7], q[8];
t q[8];
cx q[0], q[8];
inv @ t q[8];
cx q[7], q[8];
t q[8];
cx q[0], q[8];
inv @ t q[8];
h q[8];
t q[8];
cx q[4], q[8];
inv @ t q[8];
h q[8];
t q[8];
cx q[0], q[8];
inv @ t q[8];
cx q[7], q[8];
t q[8];
cx q[0], q[8];
inv @ t q[8];
cx q[7], q[8];
h q[8];
t q[8];
cx q[4], q[8];
inv @ t q[8];
h q[8];
sdg q[8];
// END dup
cp(3.141592653589793) q[8], q[0];
// BEGIN undup
s q[8];
h q[8];
t q[8];
cx q[4], q[8];
inv @ t q[8];
h q[8];
cx q[7], q[8];
t q[8];
cx q[0], q[8];
inv @ t q[8];
cx q[7], q[8];
t q[8];
cx q[0], q[8];
inv @ t q[8];
h q[8];
t q[8];
cx q[4], q[8];
inv @ t q[8];
h q[8];
t q[8];
cx q[0], q[8];
inv @ t q[8];
cx q[7], q[8];
t q[8];
cx q[0], q[8];
inv @ t q[8];
cx q[7], q[8];
h q[8];
h q[8];
sdg q[8];
// END undup
// BEGIN undup
s q[4];
h q[4];
t q[4];
cx q[6], q[4];
inv @ t q[4];
h q[4];
cx q[1], q[4];
x q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
x q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
h q[4];
t q[4];
cx q[6], q[4];
inv @ t q[4];
h q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
x q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
x q[4];
h q[4];
h q[4];
sdg q[4];
// END undup
// BEGIN undup
s q[7];
h q[7];
t q[7];
cx q[5], q[7];
inv @ t q[7];
h q[7];
cx q[1], q[7];
x q[7];
t q[7];
cx q[0], q[7];
inv @ t q[7];
cx q[1], q[7];
x q[7];
t q[7];
cx q[0], q[7];
inv @ t q[7];
h q[7];
t q[7];
cx q[5], q[7];
inv @ t q[7];
h q[7];
t q[7];
cx q[0], q[7];
inv @ t q[7];
cx q[1], q[7];
x q[7];
t q[7];
cx q[0], q[7];
inv @ t q[7];
cx q[1], q[7];
x q[7];
h q[7];
h q[7];
sdg q[7];
// END undup
// BEGIN dealloc
s q[7];
h q[7];
t q[7];
cx q[0], q[7];
inv @ t q[7];
cx q[1], q[7];
t q[7];
cx q[0], q[7];
inv @ t q[7];
cx q[1], q[7];
h q[7];
sdg q[7];
// END dealloc
// BEGIN undup
h q[6];
t q[6];
cx q[2], q[6];
inv @ t q[6];
h q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[0], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[0], q[6];
inv @ t q[6];
h q[6];
t q[6];
cx q[2], q[6];
inv @ t q[6];
h q[6];
// END undup
// BEGIN dup
s q[6];
h q[6];
h q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[0], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[0], q[6];
inv @ t q[6];
h q[6];
t q[6];
cx q[2], q[6];
inv @ t q[6];
h q[6];
t q[6];
cx q[0], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[0], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
h q[6];
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
h q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[0], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[0], q[6];
inv @ t q[6];
h q[6];
t q[6];
cx q[5], q[6];
inv @ t q[6];
h q[6];
t q[6];
cx q[0], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[0], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
h q[6];
h q[6];
sdg q[6];
// END undup
// BEGIN undup
h q[5];
t q[5];
cx q[2], q[5];
inv @ t q[5];
h q[5];
cx q[1], q[5];
x q[5];
t q[5];
cx q[0], q[5];
inv @ t q[5];
cx q[1], q[5];
x q[5];
t q[5];
cx q[0], q[5];
inv @ t q[5];
h q[5];
t q[5];
cx q[2], q[5];
inv @ t q[5];
h q[5];
// END undup
// BEGIN dealloc
s q[4];
h q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
h q[4];
sdg q[4];
// END dealloc
gphase(0.0);
x q[0]; // want_negated=False
p(0.0) q[0];
ry(0.0) q[0]; // inplace_rot
p(0.0) q[0];
gphase(0.0);
x q[0]; // want_negated=True
ctrl(1) @ ry(1.8754889808102941) q[0], q[2]; // inplace_rot
x q[2]; // want_negated=True
ctrl(2) @ ry(1.5707963267948968) q[0], q[2], q[1]; // inplace_rot
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[0], q[2], q[1];
x q[1]; // want_negated=False
ctrl(3) @ gphase(0.0) q[1], q[0], q[2];
x q[2]; // want_negated=False
ctrl(2) @ ry(1.5707963267948966) q[0], q[2], q[1]; // inplace_rot
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[0], q[2], q[1];
x q[1]; // want_negated=False
ctrl(3) @ gphase(0.0) q[0], q[1], q[2];
// BEGIN lifted_x
h q[4];
t q[4];
cx q[2], q[4];
x q[4];
inv @ t q[4];
h q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
h q[4];
t q[4];
cx q[2], q[4];
x q[4];
inv @ t q[4];
h q[4];
// END lifted_x
ccx q[0], q[4], q[3]; // inplace_x
// BEGIN unlifted_x
h q[4];
t q[4];
cx q[2], q[4];
x q[4];
inv @ t q[4];
h q[4];
cx q[1], q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
h q[4];
t q[4];
cx q[2], q[4];
x q[4];
inv @ t q[4];
h q[4];
// END unlifted_x
// BEGIN dup
h q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
h q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
h q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
h q[4];
// END dup
cp(3.141592653589793) q[0], q[4];
// BEGIN undup
h q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
h q[4];
cx q[1], q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
h q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
h q[4];
// END undup
ctrl(3) @ gphase(0.0) q[0], q[1], q[2];
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[0], q[2], q[1];
x q[1]; // want_negated=False
ctrl(2) @ ry(-1.5707963267948966) q[0], q[2], q[1]; // inplace_rot
x q[2]; // want_negated=True
ctrl(3) @ gphase(0.0) q[0], q[2], q[1];
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[0], q[2], q[1];
x q[1]; // want_negated=False
ctrl(2) @ ry(-1.5707963267948968) q[0], q[2], q[1]; // inplace_rot
x q[2]; // want_negated=False
ctrl(1) @ ry(-1.8754889808102941) q[0], q[2]; // inplace_rot
// BEGIN alloc
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
// END alloc
// BEGIN dup
h q[5];
t q[5];
cx q[2], q[5];
inv @ t q[5];
h q[5];
t q[5];
cx q[0], q[5];
inv @ t q[5];
cx q[1], q[5];
x q[5];
t q[5];
cx q[0], q[5];
inv @ t q[5];
cx q[1], q[5];
x q[5];
h q[5];
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
h q[6];
t q[6];
cx q[0], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[0], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
h q[6];
t q[6];
cx q[2], q[6];
inv @ t q[6];
h q[6];
// END dup
// BEGIN dup
s q[7];
h q[7];
h q[7];
cx q[1], q[7];
x q[7];
t q[7];
cx q[0], q[7];
inv @ t q[7];
cx q[1], q[7];
x q[7];
t q[7];
cx q[0], q[7];
inv @ t q[7];
h q[7];
t q[7];
cx q[5], q[7];
inv @ t q[7];
h q[7];
t q[7];
cx q[0], q[7];
inv @ t q[7];
cx q[1], q[7];
x q[7];
t q[7];
cx q[0], q[7];
inv @ t q[7];
cx q[1], q[7];
x q[7];
h q[7];
t q[7];
cx q[5], q[7];
inv @ t q[7];
h q[7];
sdg q[7];
// END dup
// BEGIN alloc
s q[7];
h q[7];
cx q[0], q[7];
t q[7];
cx q[1], q[7];
inv @ t q[7];
cx q[0], q[7];
t q[7];
cx q[1], q[7];
inv @ t q[7];
h q[7];
sdg q[7];
// END alloc
// BEGIN dup
s q[4];
h q[4];
h q[4];
cx q[1], q[4];
x q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
x q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
h q[4];
t q[4];
cx q[6], q[4];
inv @ t q[4];
h q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
x q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
x q[4];
h q[4];
t q[4];
cx q[6], q[4];
inv @ t q[4];
h q[4];
sdg q[4];
// END dup
// BEGIN dup
s q[8];
h q[8];
h q[8];
cx q[0], q[8];
t q[8];
cx q[7], q[8];
inv @ t q[8];
cx q[0], q[8];
t q[8];
cx q[7], q[8];
inv @ t q[8];
h q[8];
t q[8];
cx q[4], q[8];
inv @ t q[8];
h q[8];
t q[8];
cx q[7], q[8];
inv @ t q[8];
cx q[0], q[8];
t q[8];
cx q[7], q[8];
inv @ t q[8];
cx q[0], q[8];
h q[8];
t q[8];
cx q[4], q[8];
inv @ t q[8];
h q[8];
sdg q[8];
// END dup
cp(3.141592653589793) q[0], q[8];
// BEGIN undup
s q[8];
h q[8];
t q[8];
cx q[4], q[8];
inv @ t q[8];
h q[8];
cx q[0], q[8];
t q[8];
cx q[7], q[8];
inv @ t q[8];
cx q[0], q[8];
t q[8];
cx q[7], q[8];
inv @ t q[8];
h q[8];
t q[8];
cx q[4], q[8];
inv @ t q[8];
h q[8];
t q[8];
cx q[7], q[8];
inv @ t q[8];
cx q[0], q[8];
t q[8];
cx q[7], q[8];
inv @ t q[8];
cx q[0], q[8];
h q[8];
h q[8];
sdg q[8];
// END undup
// BEGIN undup
s q[4];
h q[4];
t q[4];
cx q[6], q[4];
inv @ t q[4];
h q[4];
cx q[1], q[4];
x q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
x q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
h q[4];
t q[4];
cx q[6], q[4];
inv @ t q[4];
h q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
x q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
x q[4];
h q[4];
h q[4];
sdg q[4];
// END undup
// BEGIN undup
s q[7];
h q[7];
t q[7];
cx q[5], q[7];
inv @ t q[7];
h q[7];
cx q[1], q[7];
x q[7];
t q[7];
cx q[0], q[7];
inv @ t q[7];
cx q[1], q[7];
x q[7];
t q[7];
cx q[0], q[7];
inv @ t q[7];
h q[7];
t q[7];
cx q[5], q[7];
inv @ t q[7];
h q[7];
t q[7];
cx q[0], q[7];
inv @ t q[7];
cx q[1], q[7];
x q[7];
t q[7];
cx q[0], q[7];
inv @ t q[7];
cx q[1], q[7];
x q[7];
h q[7];
h q[7];
sdg q[7];
// END undup
// BEGIN dealloc
s q[7];
h q[7];
t q[7];
cx q[1], q[7];
inv @ t q[7];
cx q[0], q[7];
t q[7];
cx q[1], q[7];
inv @ t q[7];
cx q[0], q[7];
h q[7];
sdg q[7];
// END dealloc
// BEGIN undup
h q[6];
t q[6];
cx q[2], q[6];
inv @ t q[6];
h q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[0], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[0], q[6];
inv @ t q[6];
h q[6];
t q[6];
cx q[2], q[6];
inv @ t q[6];
h q[6];
// END undup
// BEGIN dup
s q[6];
h q[6];
h q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[0], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[0], q[6];
inv @ t q[6];
h q[6];
t q[6];
cx q[2], q[6];
inv @ t q[6];
h q[6];
t q[6];
cx q[0], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[0], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
h q[6];
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
h q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[0], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[0], q[6];
inv @ t q[6];
h q[6];
t q[6];
cx q[5], q[6];
inv @ t q[6];
h q[6];
t q[6];
cx q[0], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[0], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
h q[6];
h q[6];
sdg q[6];
// END undup
// BEGIN undup
h q[5];
t q[5];
cx q[2], q[5];
inv @ t q[5];
h q[5];
cx q[1], q[5];
x q[5];
t q[5];
cx q[0], q[5];
inv @ t q[5];
cx q[1], q[5];
x q[5];
t q[5];
cx q[0], q[5];
inv @ t q[5];
h q[5];
t q[5];
cx q[2], q[5];
inv @ t q[5];
h q[5];
// END undup
// BEGIN dealloc
s q[4];
h q[4];
t q[4];
cx q[1], q[4];
inv @ t q[4];
cx q[0], q[4];
t q[4];
cx q[1], q[4];
inv @ t q[4];
cx q[0], q[4];
h q[4];
sdg q[4];
// END dealloc
gphase(1.5707963267948966);
x q[0]; // want_negated=False
p(-3.141592653589793) q[0];
ry(0.29279771369189794) q[0]; // inplace_rot
p(3.141592653589793) q[0];
gphase(-1.5707963267948966);
x q[0]; // want_negated=True
ctrl(1) @ ry(1.8754889808102941) q[0], q[2]; // inplace_rot
x q[2]; // want_negated=True
ctrl(2) @ ry(1.5707963267948968) q[0], q[2], q[1]; // inplace_rot
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[0], q[1], q[2];
x q[1]; // want_negated=False
ctrl(3) @ gphase(0.0) q[0], q[1], q[2];
x q[2]; // want_negated=False
ctrl(2) @ ry(1.5707963267948966) q[0], q[2], q[1]; // inplace_rot
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[0], q[1], q[2];
x q[1]; // want_negated=False
ctrl(3) @ gphase(0.0) q[0], q[2], q[1];
// BEGIN lifted_x
h q[4];
t q[4];
cx q[2], q[4];
x q[4];
inv @ t q[4];
h q[4];
t q[4];
cx q[1], q[4];
inv @ t q[4];
cx q[0], q[4];
t q[4];
cx q[1], q[4];
inv @ t q[4];
cx q[0], q[4];
h q[4];
t q[4];
cx q[2], q[4];
x q[4];
inv @ t q[4];
h q[4];
// END lifted_x
ccx q[0], q[4], q[3]; // inplace_x
// BEGIN unlifted_x
h q[4];
t q[4];
cx q[2], q[4];
x q[4];
inv @ t q[4];
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
t q[4];
cx q[2], q[4];
x q[4];
inv @ t q[4];
h q[4];
// END unlifted_x
// BEGIN dup
h q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
h q[4];
t q[4];
cx q[1], q[4];
inv @ t q[4];
cx q[0], q[4];
t q[4];
cx q[1], q[4];
inv @ t q[4];
cx q[0], q[4];
h q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
h q[4];
// END dup
cp(3.141592653589793) q[0], q[4];
// BEGIN undup
h q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
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
t q[4];
cx q[2], q[4];
inv @ t q[4];
h q[4];
// END undup
ctrl(3) @ gphase(0.0) q[0], q[1], q[2];
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[0], q[1], q[2];
x q[1]; // want_negated=False
ctrl(2) @ ry(-1.5707963267948966) q[0], q[2], q[1]; // inplace_rot
x q[2]; // want_negated=True
ctrl(3) @ gphase(0.0) q[0], q[2], q[1];
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[0], q[1], q[2];
x q[1]; // want_negated=False
ctrl(2) @ ry(-1.5707963267948968) q[0], q[2], q[1]; // inplace_rot
x q[2]; // want_negated=False
ctrl(1) @ ry(-1.8754889808102941) q[0], q[2]; // inplace_rot
// BEGIN alloc
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
// END alloc
// BEGIN dup
h q[5];
t q[5];
cx q[2], q[5];
inv @ t q[5];
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
cx q[0], q[5];
h q[5];
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
h q[6];
t q[6];
cx q[1], q[6];
x q[6];
inv @ t q[6];
cx q[0], q[6];
t q[6];
cx q[1], q[6];
x q[6];
inv @ t q[6];
cx q[0], q[6];
h q[6];
t q[6];
cx q[2], q[6];
inv @ t q[6];
h q[6];
// END dup
// BEGIN dup
s q[7];
h q[7];
h q[7];
cx q[0], q[7];
t q[7];
cx q[1], q[7];
x q[7];
inv @ t q[7];
cx q[0], q[7];
t q[7];
cx q[1], q[7];
x q[7];
inv @ t q[7];
h q[7];
t q[7];
cx q[5], q[7];
inv @ t q[7];
h q[7];
t q[7];
cx q[1], q[7];
x q[7];
inv @ t q[7];
cx q[0], q[7];
t q[7];
cx q[1], q[7];
x q[7];
inv @ t q[7];
cx q[0], q[7];
h q[7];
t q[7];
cx q[5], q[7];
inv @ t q[7];
h q[7];
sdg q[7];
// END dup
// BEGIN alloc
s q[7];
h q[7];
cx q[0], q[7];
t q[7];
cx q[1], q[7];
inv @ t q[7];
cx q[0], q[7];
t q[7];
cx q[1], q[7];
inv @ t q[7];
h q[7];
sdg q[7];
// END alloc
// BEGIN dup
s q[4];
h q[4];
h q[4];
cx q[0], q[4];
t q[4];
cx q[1], q[4];
x q[4];
inv @ t q[4];
cx q[0], q[4];
t q[4];
cx q[1], q[4];
x q[4];
inv @ t q[4];
h q[4];
t q[4];
cx q[6], q[4];
inv @ t q[4];
h q[4];
t q[4];
cx q[1], q[4];
x q[4];
inv @ t q[4];
cx q[0], q[4];
t q[4];
cx q[1], q[4];
x q[4];
inv @ t q[4];
cx q[0], q[4];
h q[4];
t q[4];
cx q[6], q[4];
inv @ t q[4];
h q[4];
sdg q[4];
// END dup
// BEGIN dup
s q[8];
h q[8];
h q[8];
cx q[0], q[8];
t q[8];
cx q[7], q[8];
inv @ t q[8];
cx q[0], q[8];
t q[8];
cx q[7], q[8];
inv @ t q[8];
h q[8];
t q[8];
cx q[4], q[8];
inv @ t q[8];
h q[8];
t q[8];
cx q[7], q[8];
inv @ t q[8];
cx q[0], q[8];
t q[8];
cx q[7], q[8];
inv @ t q[8];
cx q[0], q[8];
h q[8];
t q[8];
cx q[4], q[8];
inv @ t q[8];
h q[8];
sdg q[8];
// END dup
cp(3.141592653589793) q[0], q[8];
// BEGIN undup
s q[8];
h q[8];
t q[8];
cx q[4], q[8];
inv @ t q[8];
h q[8];
cx q[0], q[8];
t q[8];
cx q[7], q[8];
inv @ t q[8];
cx q[0], q[8];
t q[8];
cx q[7], q[8];
inv @ t q[8];
h q[8];
t q[8];
cx q[4], q[8];
inv @ t q[8];
h q[8];
t q[8];
cx q[7], q[8];
inv @ t q[8];
cx q[0], q[8];
t q[8];
cx q[7], q[8];
inv @ t q[8];
cx q[0], q[8];
h q[8];
h q[8];
sdg q[8];
// END undup
// BEGIN undup
s q[4];
h q[4];
t q[4];
cx q[6], q[4];
inv @ t q[4];
h q[4];
cx q[0], q[4];
t q[4];
cx q[1], q[4];
x q[4];
inv @ t q[4];
cx q[0], q[4];
t q[4];
cx q[1], q[4];
x q[4];
inv @ t q[4];
h q[4];
t q[4];
cx q[6], q[4];
inv @ t q[4];
h q[4];
t q[4];
cx q[1], q[4];
x q[4];
inv @ t q[4];
cx q[0], q[4];
t q[4];
cx q[1], q[4];
x q[4];
inv @ t q[4];
cx q[0], q[4];
h q[4];
h q[4];
sdg q[4];
// END undup
// BEGIN undup
s q[7];
h q[7];
t q[7];
cx q[5], q[7];
inv @ t q[7];
h q[7];
cx q[0], q[7];
t q[7];
cx q[1], q[7];
x q[7];
inv @ t q[7];
cx q[0], q[7];
t q[7];
cx q[1], q[7];
x q[7];
inv @ t q[7];
h q[7];
t q[7];
cx q[5], q[7];
inv @ t q[7];
h q[7];
t q[7];
cx q[1], q[7];
x q[7];
inv @ t q[7];
cx q[0], q[7];
t q[7];
cx q[1], q[7];
x q[7];
inv @ t q[7];
cx q[0], q[7];
h q[7];
h q[7];
sdg q[7];
// END undup
// BEGIN dealloc
s q[7];
h q[7];
t q[7];
cx q[1], q[7];
inv @ t q[7];
cx q[0], q[7];
t q[7];
cx q[1], q[7];
inv @ t q[7];
cx q[0], q[7];
h q[7];
sdg q[7];
// END dealloc
// BEGIN undup
h q[6];
t q[6];
cx q[2], q[6];
inv @ t q[6];
h q[6];
cx q[0], q[6];
t q[6];
cx q[1], q[6];
x q[6];
inv @ t q[6];
cx q[0], q[6];
t q[6];
cx q[1], q[6];
x q[6];
inv @ t q[6];
h q[6];
t q[6];
cx q[2], q[6];
inv @ t q[6];
h q[6];
// END undup
// BEGIN dup
s q[6];
h q[6];
h q[6];
cx q[0], q[6];
t q[6];
cx q[1], q[6];
x q[6];
inv @ t q[6];
cx q[0], q[6];
t q[6];
cx q[1], q[6];
x q[6];
inv @ t q[6];
h q[6];
t q[6];
cx q[2], q[6];
inv @ t q[6];
h q[6];
t q[6];
cx q[1], q[6];
x q[6];
inv @ t q[6];
cx q[0], q[6];
t q[6];
cx q[1], q[6];
x q[6];
inv @ t q[6];
cx q[0], q[6];
h q[6];
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
h q[6];
cx q[0], q[6];
t q[6];
cx q[1], q[6];
x q[6];
inv @ t q[6];
cx q[0], q[6];
t q[6];
cx q[1], q[6];
x q[6];
inv @ t q[6];
h q[6];
t q[6];
cx q[5], q[6];
inv @ t q[6];
h q[6];
t q[6];
cx q[1], q[6];
x q[6];
inv @ t q[6];
cx q[0], q[6];
t q[6];
cx q[1], q[6];
x q[6];
inv @ t q[6];
cx q[0], q[6];
h q[6];
h q[6];
sdg q[6];
// END undup
// BEGIN undup
h q[5];
t q[5];
cx q[2], q[5];
inv @ t q[5];
h q[5];
cx q[0], q[5];
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
t q[5];
cx q[2], q[5];
inv @ t q[5];
h q[5];
// END undup
// BEGIN dealloc
s q[4];
h q[4];
t q[4];
cx q[1], q[4];
inv @ t q[4];
cx q[0], q[4];
t q[4];
cx q[1], q[4];
inv @ t q[4];
cx q[0], q[4];
h q[4];
sdg q[4];
// END dealloc
gphase(0.0);
x q[0]; // want_negated=False
p(0.0) q[0];
ry(0.0) q[0]; // inplace_rot
p(0.0) q[0];
gphase(0.0);
x q[0]; // want_negated=True
ctrl(1) @ ry(1.8754889808102941) q[0], q[2]; // inplace_rot
x q[2]; // want_negated=True
ctrl(2) @ ry(1.5707963267948968) q[2], q[0], q[1]; // inplace_rot
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[1], q[0], q[2];
x q[1]; // want_negated=False
ctrl(3) @ gphase(0.0) q[1], q[2], q[0];
x q[2]; // want_negated=False
ctrl(2) @ ry(1.5707963267948966) q[2], q[0], q[1]; // inplace_rot
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[2], q[0], q[1];
x q[1]; // want_negated=False
ctrl(3) @ gphase(0.0) q[2], q[1], q[0];
// BEGIN lifted_x
h q[4];
t q[4];
cx q[2], q[4];
x q[4];
inv @ t q[4];
h q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
h q[4];
t q[4];
cx q[2], q[4];
x q[4];
inv @ t q[4];
h q[4];
// END lifted_x
ccx q[0], q[4], q[3]; // inplace_x
// BEGIN unlifted_x
h q[4];
t q[4];
cx q[2], q[4];
x q[4];
inv @ t q[4];
h q[4];
cx q[1], q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
h q[4];
t q[4];
cx q[2], q[4];
x q[4];
inv @ t q[4];
h q[4];
// END unlifted_x
// BEGIN dup
h q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
h q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
h q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
h q[4];
// END dup
cp(3.141592653589793) q[4], q[0];
// BEGIN undup
h q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
h q[4];
cx q[1], q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
h q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
h q[4];
// END undup
ctrl(3) @ gphase(0.0) q[2], q[0], q[1];
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[2], q[1], q[0];
x q[1]; // want_negated=False
ctrl(2) @ ry(-1.5707963267948966) q[2], q[0], q[1]; // inplace_rot
x q[2]; // want_negated=True
ctrl(3) @ gphase(0.0) q[1], q[2], q[0];
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[2], q[0], q[1];
x q[1]; // want_negated=False
ctrl(2) @ ry(-1.5707963267948968) q[2], q[0], q[1]; // inplace_rot
x q[2]; // want_negated=False
ctrl(1) @ ry(-1.8754889808102941) q[0], q[2]; // inplace_rot
// BEGIN alloc
s q[4];
h q[4];
cx q[1], q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
h q[4];
sdg q[4];
// END alloc
// BEGIN dup
h q[5];
t q[5];
cx q[2], q[5];
inv @ t q[5];
h q[5];
t q[5];
cx q[0], q[5];
inv @ t q[5];
cx q[1], q[5];
x q[5];
t q[5];
cx q[0], q[5];
inv @ t q[5];
cx q[1], q[5];
x q[5];
h q[5];
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
h q[6];
t q[6];
cx q[0], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[0], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
h q[6];
t q[6];
cx q[2], q[6];
inv @ t q[6];
h q[6];
// END dup
// BEGIN dup
s q[7];
h q[7];
h q[7];
cx q[1], q[7];
x q[7];
t q[7];
cx q[0], q[7];
inv @ t q[7];
cx q[1], q[7];
x q[7];
t q[7];
cx q[0], q[7];
inv @ t q[7];
h q[7];
t q[7];
cx q[5], q[7];
inv @ t q[7];
h q[7];
t q[7];
cx q[0], q[7];
inv @ t q[7];
cx q[1], q[7];
x q[7];
t q[7];
cx q[0], q[7];
inv @ t q[7];
cx q[1], q[7];
x q[7];
h q[7];
t q[7];
cx q[5], q[7];
inv @ t q[7];
h q[7];
sdg q[7];
// END dup
// BEGIN alloc
s q[7];
h q[7];
cx q[1], q[7];
t q[7];
cx q[0], q[7];
inv @ t q[7];
cx q[1], q[7];
t q[7];
cx q[0], q[7];
inv @ t q[7];
h q[7];
sdg q[7];
// END alloc
// BEGIN dup
s q[4];
h q[4];
h q[4];
cx q[1], q[4];
x q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
x q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
h q[4];
t q[4];
cx q[6], q[4];
inv @ t q[4];
h q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
x q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
x q[4];
h q[4];
t q[4];
cx q[6], q[4];
inv @ t q[4];
h q[4];
sdg q[4];
// END dup
// BEGIN dup
s q[8];
h q[8];
h q[8];
cx q[0], q[8];
t q[8];
cx q[7], q[8];
inv @ t q[8];
cx q[0], q[8];
t q[8];
cx q[7], q[8];
inv @ t q[8];
h q[8];
t q[8];
cx q[4], q[8];
inv @ t q[8];
h q[8];
t q[8];
cx q[7], q[8];
inv @ t q[8];
cx q[0], q[8];
t q[8];
cx q[7], q[8];
inv @ t q[8];
cx q[0], q[8];
h q[8];
t q[8];
cx q[4], q[8];
inv @ t q[8];
h q[8];
sdg q[8];
// END dup
cp(3.141592653589793) q[0], q[8];
// BEGIN undup
s q[8];
h q[8];
t q[8];
cx q[4], q[8];
inv @ t q[8];
h q[8];
cx q[0], q[8];
t q[8];
cx q[7], q[8];
inv @ t q[8];
cx q[0], q[8];
t q[8];
cx q[7], q[8];
inv @ t q[8];
h q[8];
t q[8];
cx q[4], q[8];
inv @ t q[8];
h q[8];
t q[8];
cx q[7], q[8];
inv @ t q[8];
cx q[0], q[8];
t q[8];
cx q[7], q[8];
inv @ t q[8];
cx q[0], q[8];
h q[8];
h q[8];
sdg q[8];
// END undup
// BEGIN undup
s q[4];
h q[4];
t q[4];
cx q[6], q[4];
inv @ t q[4];
h q[4];
cx q[1], q[4];
x q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
x q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
h q[4];
t q[4];
cx q[6], q[4];
inv @ t q[4];
h q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
x q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
x q[4];
h q[4];
h q[4];
sdg q[4];
// END undup
// BEGIN undup
s q[7];
h q[7];
t q[7];
cx q[5], q[7];
inv @ t q[7];
h q[7];
cx q[1], q[7];
x q[7];
t q[7];
cx q[0], q[7];
inv @ t q[7];
cx q[1], q[7];
x q[7];
t q[7];
cx q[0], q[7];
inv @ t q[7];
h q[7];
t q[7];
cx q[5], q[7];
inv @ t q[7];
h q[7];
t q[7];
cx q[0], q[7];
inv @ t q[7];
cx q[1], q[7];
x q[7];
t q[7];
cx q[0], q[7];
inv @ t q[7];
cx q[1], q[7];
x q[7];
h q[7];
h q[7];
sdg q[7];
// END undup
// BEGIN dealloc
s q[7];
h q[7];
t q[7];
cx q[0], q[7];
inv @ t q[7];
cx q[1], q[7];
t q[7];
cx q[0], q[7];
inv @ t q[7];
cx q[1], q[7];
h q[7];
sdg q[7];
// END dealloc
// BEGIN undup
h q[6];
t q[6];
cx q[2], q[6];
inv @ t q[6];
h q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[0], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[0], q[6];
inv @ t q[6];
h q[6];
t q[6];
cx q[2], q[6];
inv @ t q[6];
h q[6];
// END undup
// BEGIN dup
s q[6];
h q[6];
h q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[0], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[0], q[6];
inv @ t q[6];
h q[6];
t q[6];
cx q[2], q[6];
inv @ t q[6];
h q[6];
t q[6];
cx q[0], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[0], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
h q[6];
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
h q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[0], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[0], q[6];
inv @ t q[6];
h q[6];
t q[6];
cx q[5], q[6];
inv @ t q[6];
h q[6];
t q[6];
cx q[0], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[0], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
h q[6];
h q[6];
sdg q[6];
// END undup
// BEGIN undup
h q[5];
t q[5];
cx q[2], q[5];
inv @ t q[5];
h q[5];
cx q[1], q[5];
x q[5];
t q[5];
cx q[0], q[5];
inv @ t q[5];
cx q[1], q[5];
x q[5];
t q[5];
cx q[0], q[5];
inv @ t q[5];
h q[5];
t q[5];
cx q[2], q[5];
inv @ t q[5];
h q[5];
// END undup
// BEGIN dealloc
s q[4];
h q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
h q[4];
sdg q[4];
// END dealloc
gphase(2.0715534141030967e-18);
x q[0]; // want_negated=False
p(-4.1431068282061934e-18) q[0];
ry(0.2657489531527303) q[0]; // inplace_rot
p(4.1431068282061934e-18) q[0];
gphase(-2.0715534141030967e-18);
x q[0]; // want_negated=True
ctrl(1) @ ry(1.8754889808102941) q[0], q[2]; // inplace_rot
x q[2]; // want_negated=True
ctrl(2) @ ry(1.5707963267948968) q[0], q[2], q[1]; // inplace_rot
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[0], q[1], q[2];
x q[1]; // want_negated=False
ctrl(3) @ gphase(0.0) q[0], q[2], q[1];
x q[2]; // want_negated=False
ctrl(2) @ ry(1.5707963267948966) q[0], q[2], q[1]; // inplace_rot
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[0], q[1], q[2];
x q[1]; // want_negated=False
ctrl(3) @ gphase(0.0) q[0], q[2], q[1];
// BEGIN lifted_x
h q[4];
t q[4];
cx q[2], q[4];
x q[4];
inv @ t q[4];
h q[4];
t q[4];
cx q[1], q[4];
inv @ t q[4];
cx q[0], q[4];
t q[4];
cx q[1], q[4];
inv @ t q[4];
cx q[0], q[4];
h q[4];
t q[4];
cx q[2], q[4];
x q[4];
inv @ t q[4];
h q[4];
// END lifted_x
ccx q[0], q[4], q[3]; // inplace_x
// BEGIN unlifted_x
h q[4];
t q[4];
cx q[2], q[4];
x q[4];
inv @ t q[4];
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
t q[4];
cx q[2], q[4];
x q[4];
inv @ t q[4];
h q[4];
// END unlifted_x
// BEGIN dup
h q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
h q[4];
t q[4];
cx q[1], q[4];
inv @ t q[4];
cx q[0], q[4];
t q[4];
cx q[1], q[4];
inv @ t q[4];
cx q[0], q[4];
h q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
h q[4];
// END dup
cp(3.141592653589793) q[0], q[4];
// BEGIN undup
h q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
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
t q[4];
cx q[2], q[4];
inv @ t q[4];
h q[4];
// END undup
ctrl(3) @ gphase(0.0) q[1], q[0], q[2];
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[0], q[1], q[2];
x q[1]; // want_negated=False
ctrl(2) @ ry(-1.5707963267948966) q[0], q[2], q[1]; // inplace_rot
x q[2]; // want_negated=True
ctrl(3) @ gphase(0.0) q[0], q[1], q[2];
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[1], q[2], q[0];
x q[1]; // want_negated=False
ctrl(2) @ ry(-1.5707963267948968) q[0], q[2], q[1]; // inplace_rot
x q[2]; // want_negated=False
ctrl(1) @ ry(-1.8754889808102941) q[0], q[2]; // inplace_rot
// BEGIN alloc
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
// END alloc
// BEGIN dup
h q[5];
t q[5];
cx q[2], q[5];
inv @ t q[5];
h q[5];
t q[5];
cx q[0], q[5];
inv @ t q[5];
cx q[1], q[5];
x q[5];
t q[5];
cx q[0], q[5];
inv @ t q[5];
cx q[1], q[5];
x q[5];
h q[5];
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
h q[6];
t q[6];
cx q[0], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[0], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
h q[6];
t q[6];
cx q[2], q[6];
inv @ t q[6];
h q[6];
// END dup
// BEGIN dup
s q[7];
h q[7];
h q[7];
cx q[1], q[7];
x q[7];
t q[7];
cx q[0], q[7];
inv @ t q[7];
cx q[1], q[7];
x q[7];
t q[7];
cx q[0], q[7];
inv @ t q[7];
h q[7];
t q[7];
cx q[5], q[7];
inv @ t q[7];
h q[7];
t q[7];
cx q[0], q[7];
inv @ t q[7];
cx q[1], q[7];
x q[7];
t q[7];
cx q[0], q[7];
inv @ t q[7];
cx q[1], q[7];
x q[7];
h q[7];
t q[7];
cx q[5], q[7];
inv @ t q[7];
h q[7];
sdg q[7];
// END dup
// BEGIN alloc
s q[7];
h q[7];
cx q[0], q[7];
t q[7];
cx q[1], q[7];
inv @ t q[7];
cx q[0], q[7];
t q[7];
cx q[1], q[7];
inv @ t q[7];
h q[7];
sdg q[7];
// END alloc
// BEGIN dup
s q[4];
h q[4];
h q[4];
cx q[1], q[4];
x q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
x q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
h q[4];
t q[4];
cx q[6], q[4];
inv @ t q[4];
h q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
x q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
x q[4];
h q[4];
t q[4];
cx q[6], q[4];
inv @ t q[4];
h q[4];
sdg q[4];
// END dup
// BEGIN dup
s q[8];
h q[8];
h q[8];
cx q[0], q[8];
t q[8];
cx q[7], q[8];
inv @ t q[8];
cx q[0], q[8];
t q[8];
cx q[7], q[8];
inv @ t q[8];
h q[8];
t q[8];
cx q[4], q[8];
inv @ t q[8];
h q[8];
t q[8];
cx q[7], q[8];
inv @ t q[8];
cx q[0], q[8];
t q[8];
cx q[7], q[8];
inv @ t q[8];
cx q[0], q[8];
h q[8];
t q[8];
cx q[4], q[8];
inv @ t q[8];
h q[8];
sdg q[8];
// END dup
cp(3.141592653589793) q[0], q[8];
// BEGIN undup
s q[8];
h q[8];
t q[8];
cx q[4], q[8];
inv @ t q[8];
h q[8];
cx q[0], q[8];
t q[8];
cx q[7], q[8];
inv @ t q[8];
cx q[0], q[8];
t q[8];
cx q[7], q[8];
inv @ t q[8];
h q[8];
t q[8];
cx q[4], q[8];
inv @ t q[8];
h q[8];
t q[8];
cx q[7], q[8];
inv @ t q[8];
cx q[0], q[8];
t q[8];
cx q[7], q[8];
inv @ t q[8];
cx q[0], q[8];
h q[8];
h q[8];
sdg q[8];
// END undup
// BEGIN undup
s q[4];
h q[4];
t q[4];
cx q[6], q[4];
inv @ t q[4];
h q[4];
cx q[1], q[4];
x q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
x q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
h q[4];
t q[4];
cx q[6], q[4];
inv @ t q[4];
h q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
x q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
x q[4];
h q[4];
h q[4];
sdg q[4];
// END undup
// BEGIN undup
s q[7];
h q[7];
t q[7];
cx q[5], q[7];
inv @ t q[7];
h q[7];
cx q[1], q[7];
x q[7];
t q[7];
cx q[0], q[7];
inv @ t q[7];
cx q[1], q[7];
x q[7];
t q[7];
cx q[0], q[7];
inv @ t q[7];
h q[7];
t q[7];
cx q[5], q[7];
inv @ t q[7];
h q[7];
t q[7];
cx q[0], q[7];
inv @ t q[7];
cx q[1], q[7];
x q[7];
t q[7];
cx q[0], q[7];
inv @ t q[7];
cx q[1], q[7];
x q[7];
h q[7];
h q[7];
sdg q[7];
// END undup
// BEGIN dealloc
s q[7];
h q[7];
t q[7];
cx q[1], q[7];
inv @ t q[7];
cx q[0], q[7];
t q[7];
cx q[1], q[7];
inv @ t q[7];
cx q[0], q[7];
h q[7];
sdg q[7];
// END dealloc
// BEGIN undup
h q[6];
t q[6];
cx q[2], q[6];
inv @ t q[6];
h q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[0], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[0], q[6];
inv @ t q[6];
h q[6];
t q[6];
cx q[2], q[6];
inv @ t q[6];
h q[6];
// END undup
// BEGIN dup
s q[6];
h q[6];
h q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[0], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[0], q[6];
inv @ t q[6];
h q[6];
t q[6];
cx q[2], q[6];
inv @ t q[6];
h q[6];
t q[6];
cx q[0], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[0], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
h q[6];
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
h q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[0], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[0], q[6];
inv @ t q[6];
h q[6];
t q[6];
cx q[5], q[6];
inv @ t q[6];
h q[6];
t q[6];
cx q[0], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
t q[6];
cx q[0], q[6];
inv @ t q[6];
cx q[1], q[6];
x q[6];
h q[6];
h q[6];
sdg q[6];
// END undup
// BEGIN undup
h q[5];
t q[5];
cx q[2], q[5];
inv @ t q[5];
h q[5];
cx q[1], q[5];
x q[5];
t q[5];
cx q[0], q[5];
inv @ t q[5];
cx q[1], q[5];
x q[5];
t q[5];
cx q[0], q[5];
inv @ t q[5];
h q[5];
t q[5];
cx q[2], q[5];
inv @ t q[5];
h q[5];
// END undup
// BEGIN dealloc
s q[4];
h q[4];
t q[4];
cx q[1], q[4];
inv @ t q[4];
cx q[0], q[4];
t q[4];
cx q[1], q[4];
inv @ t q[4];
cx q[0], q[4];
h q[4];
sdg q[4];
// END dealloc
gphase(0.0);
x q[0]; // want_negated=False
p(0.0) q[0];
ry(0.0) q[0]; // inplace_rot
p(0.0) q[0];
gphase(0.0);
x q[0]; // want_negated=True
ctrl(1) @ ry(1.8754889808102941) q[0], q[2]; // inplace_rot
x q[2]; // want_negated=True
ctrl(2) @ ry(1.5707963267948968) q[0], q[2], q[1]; // inplace_rot
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[1], q[0], q[2];
x q[1]; // want_negated=False
ctrl(3) @ gphase(0.0) q[1], q[0], q[2];
x q[2]; // want_negated=False
ctrl(2) @ ry(1.5707963267948966) q[0], q[2], q[1]; // inplace_rot
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[0], q[2], q[1];
x q[1]; // want_negated=False
ctrl(3) @ gphase(0.0) q[1], q[0], q[2];
// BEGIN lifted_x
h q[4];
t q[4];
cx q[2], q[4];
x q[4];
inv @ t q[4];
h q[4];
t q[4];
cx q[1], q[4];
inv @ t q[4];
cx q[0], q[4];
t q[4];
cx q[1], q[4];
inv @ t q[4];
cx q[0], q[4];
h q[4];
t q[4];
cx q[2], q[4];
x q[4];
inv @ t q[4];
h q[4];
// END lifted_x
ccx q[0], q[4], q[3]; // inplace_x
// BEGIN unlifted_x
h q[4];
t q[4];
cx q[2], q[4];
x q[4];
inv @ t q[4];
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
t q[4];
cx q[2], q[4];
x q[4];
inv @ t q[4];
h q[4];
// END unlifted_x
// BEGIN dup
h q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
h q[4];
t q[4];
cx q[1], q[4];
inv @ t q[4];
cx q[0], q[4];
t q[4];
cx q[1], q[4];
inv @ t q[4];
cx q[0], q[4];
h q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
h q[4];
// END dup
cp(3.141592653589793) q[0], q[4];
// BEGIN undup
h q[4];
t q[4];
cx q[2], q[4];
inv @ t q[4];
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
t q[4];
cx q[2], q[4];
inv @ t q[4];
h q[4];
// END undup
ctrl(3) @ gphase(0.0) q[0], q[2], q[1];
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[0], q[2], q[1];
x q[1]; // want_negated=False
ctrl(2) @ ry(-1.5707963267948966) q[0], q[2], q[1]; // inplace_rot
x q[2]; // want_negated=True
ctrl(3) @ gphase(0.0) q[0], q[2], q[1];
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[0], q[1], q[2];
x q[1]; // want_negated=False
ctrl(2) @ ry(-1.5707963267948968) q[0], q[2], q[1]; // inplace_rot
x q[2]; // want_negated=False
ctrl(1) @ ry(-1.8754889808102941) q[0], q[2]; // inplace_rot
// BEGIN alloc
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
// END alloc
// BEGIN dup
h q[5];
t q[5];
cx q[2], q[5];
inv @ t q[5];
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
cx q[0], q[5];
h q[5];
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
h q[6];
t q[6];
cx q[1], q[6];
x q[6];
inv @ t q[6];
cx q[0], q[6];
t q[6];
cx q[1], q[6];
x q[6];
inv @ t q[6];
cx q[0], q[6];
h q[6];
t q[6];
cx q[2], q[6];
inv @ t q[6];
h q[6];
// END dup
// BEGIN dup
s q[7];
h q[7];
h q[7];
cx q[0], q[7];
t q[7];
cx q[1], q[7];
x q[7];
inv @ t q[7];
cx q[0], q[7];
t q[7];
cx q[1], q[7];
x q[7];
inv @ t q[7];
h q[7];
t q[7];
cx q[5], q[7];
inv @ t q[7];
h q[7];
t q[7];
cx q[1], q[7];
x q[7];
inv @ t q[7];
cx q[0], q[7];
t q[7];
cx q[1], q[7];
x q[7];
inv @ t q[7];
cx q[0], q[7];
h q[7];
t q[7];
cx q[5], q[7];
inv @ t q[7];
h q[7];
sdg q[7];
// END dup
// BEGIN alloc
s q[7];
h q[7];
cx q[0], q[7];
t q[7];
cx q[1], q[7];
inv @ t q[7];
cx q[0], q[7];
t q[7];
cx q[1], q[7];
inv @ t q[7];
h q[7];
sdg q[7];
// END alloc
// BEGIN dup
s q[4];
h q[4];
h q[4];
cx q[0], q[4];
t q[4];
cx q[1], q[4];
x q[4];
inv @ t q[4];
cx q[0], q[4];
t q[4];
cx q[1], q[4];
x q[4];
inv @ t q[4];
h q[4];
t q[4];
cx q[6], q[4];
inv @ t q[4];
h q[4];
t q[4];
cx q[1], q[4];
x q[4];
inv @ t q[4];
cx q[0], q[4];
t q[4];
cx q[1], q[4];
x q[4];
inv @ t q[4];
cx q[0], q[4];
h q[4];
t q[4];
cx q[6], q[4];
inv @ t q[4];
h q[4];
sdg q[4];
// END dup
// BEGIN dup
s q[8];
h q[8];
h q[8];
cx q[7], q[8];
t q[8];
cx q[0], q[8];
inv @ t q[8];
cx q[7], q[8];
t q[8];
cx q[0], q[8];
inv @ t q[8];
h q[8];
t q[8];
cx q[4], q[8];
inv @ t q[8];
h q[8];
t q[8];
cx q[0], q[8];
inv @ t q[8];
cx q[7], q[8];
t q[8];
cx q[0], q[8];
inv @ t q[8];
cx q[7], q[8];
h q[8];
t q[8];
cx q[4], q[8];
inv @ t q[8];
h q[8];
sdg q[8];
// END dup
cp(3.141592653589793) q[8], q[0];
// BEGIN undup
s q[8];
h q[8];
t q[8];
cx q[4], q[8];
inv @ t q[8];
h q[8];
cx q[7], q[8];
t q[8];
cx q[0], q[8];
inv @ t q[8];
cx q[7], q[8];
t q[8];
cx q[0], q[8];
inv @ t q[8];
h q[8];
t q[8];
cx q[4], q[8];
inv @ t q[8];
h q[8];
t q[8];
cx q[0], q[8];
inv @ t q[8];
cx q[7], q[8];
t q[8];
cx q[0], q[8];
inv @ t q[8];
cx q[7], q[8];
h q[8];
h q[8];
sdg q[8];
// END undup
// BEGIN undup
s q[4];
h q[4];
t q[4];
cx q[6], q[4];
inv @ t q[4];
h q[4];
cx q[0], q[4];
t q[4];
cx q[1], q[4];
x q[4];
inv @ t q[4];
cx q[0], q[4];
t q[4];
cx q[1], q[4];
x q[4];
inv @ t q[4];
h q[4];
t q[4];
cx q[6], q[4];
inv @ t q[4];
h q[4];
t q[4];
cx q[1], q[4];
x q[4];
inv @ t q[4];
cx q[0], q[4];
t q[4];
cx q[1], q[4];
x q[4];
inv @ t q[4];
cx q[0], q[4];
h q[4];
h q[4];
sdg q[4];
// END undup
// BEGIN undup
s q[7];
h q[7];
t q[7];
cx q[5], q[7];
inv @ t q[7];
h q[7];
cx q[0], q[7];
t q[7];
cx q[1], q[7];
x q[7];
inv @ t q[7];
cx q[0], q[7];
t q[7];
cx q[1], q[7];
x q[7];
inv @ t q[7];
h q[7];
t q[7];
cx q[5], q[7];
inv @ t q[7];
h q[7];
t q[7];
cx q[1], q[7];
x q[7];
inv @ t q[7];
cx q[0], q[7];
t q[7];
cx q[1], q[7];
x q[7];
inv @ t q[7];
cx q[0], q[7];
h q[7];
h q[7];
sdg q[7];
// END undup
// BEGIN dealloc
s q[7];
h q[7];
t q[7];
cx q[1], q[7];
inv @ t q[7];
cx q[0], q[7];
t q[7];
cx q[1], q[7];
inv @ t q[7];
cx q[0], q[7];
h q[7];
sdg q[7];
// END dealloc
// BEGIN undup
h q[6];
t q[6];
cx q[2], q[6];
inv @ t q[6];
h q[6];
cx q[0], q[6];
t q[6];
cx q[1], q[6];
x q[6];
inv @ t q[6];
cx q[0], q[6];
t q[6];
cx q[1], q[6];
x q[6];
inv @ t q[6];
h q[6];
t q[6];
cx q[2], q[6];
inv @ t q[6];
h q[6];
// END undup
// BEGIN dup
s q[6];
h q[6];
h q[6];
cx q[0], q[6];
t q[6];
cx q[1], q[6];
x q[6];
inv @ t q[6];
cx q[0], q[6];
t q[6];
cx q[1], q[6];
x q[6];
inv @ t q[6];
h q[6];
t q[6];
cx q[2], q[6];
inv @ t q[6];
h q[6];
t q[6];
cx q[1], q[6];
x q[6];
inv @ t q[6];
cx q[0], q[6];
t q[6];
cx q[1], q[6];
x q[6];
inv @ t q[6];
cx q[0], q[6];
h q[6];
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
h q[6];
cx q[0], q[6];
t q[6];
cx q[1], q[6];
x q[6];
inv @ t q[6];
cx q[0], q[6];
t q[6];
cx q[1], q[6];
x q[6];
inv @ t q[6];
h q[6];
t q[6];
cx q[5], q[6];
inv @ t q[6];
h q[6];
t q[6];
cx q[1], q[6];
x q[6];
inv @ t q[6];
cx q[0], q[6];
t q[6];
cx q[1], q[6];
x q[6];
inv @ t q[6];
cx q[0], q[6];
h q[6];
h q[6];
sdg q[6];
// END undup
// BEGIN undup
h q[5];
t q[5];
cx q[2], q[5];
inv @ t q[5];
h q[5];
cx q[0], q[5];
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
t q[5];
cx q[2], q[5];
inv @ t q[5];
h q[5];
// END undup
// BEGIN dealloc
s q[4];
h q[4];
t q[4];
cx q[1], q[4];
inv @ t q[4];
cx q[0], q[4];
t q[4];
cx q[1], q[4];
inv @ t q[4];
cx q[0], q[4];
h q[4];
sdg q[4];
// END dealloc
gphase(1.5707963267948966);
x q[0]; // want_negated=False
p(-3.141592653589793) q[0];
ry(0.1247421781758962) q[0]; // inplace_rot
p(3.141592653589793) q[0];
gphase(-1.5707963267948966);
gphase(2.544963457069891e-16);

