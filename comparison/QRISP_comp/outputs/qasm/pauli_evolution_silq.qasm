include "stdgates.inc";
qubit[5] q;

h q[0]; // inplace_h
h q[1]; // inplace_h
ry(1.0471975511965976) q[2]; // inplace_rot
cx q[1], q[3]; // dup
cx q[0], q[2]; // inplace_x
rx(0.6283185307179586) q[3]; // inplace_rot
cx q[0], q[4]; // dup
h q[4]; // inplace_h
p(-1.5707963267948966) q[0];
h q[0]; // inplace_h
h q[3]; // inplace_h
cx q[4], q[3]; // inplace_x
cx q[0], q[3]; // inplace_x
cx q[1], q[3]; // inplace_x
gphase(-0.5235987755982988);
p(1.0471975511965976) q[3];
cx q[1], q[3]; // inplace_x
cx q[0], q[3]; // inplace_x
cx q[4], q[3]; // inplace_x
h q[4]; // inplace_h
h q[0]; // inplace_h
p(1.5707963267948966) q[0];
h q[3]; // inplace_h
p(-1.5707963267948966) q[0];
h q[0]; // inplace_h
h q[1]; // inplace_h
h q[2]; // inplace_h
cx q[4], q[2]; // inplace_x
cx q[0], q[2]; // inplace_x
cx q[1], q[2]; // inplace_x
gphase(0.6283185307179586);
p(-1.2566370614359172) q[2];
cx q[1], q[2]; // inplace_x
cx q[0], q[2]; // inplace_x
cx q[4], q[2]; // inplace_x
h q[0]; // inplace_h
p(1.5707963267948966) q[0];
h q[1]; // inplace_h
h q[2]; // inplace_h
swap q[0], q[4];
swap q[1], q[4];
swap q[2], q[4];

