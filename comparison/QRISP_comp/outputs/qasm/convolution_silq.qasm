include "stdgates.inc";
qubit[4] q;

h q[0]; // inplace_h
gphase(3.1705939107329713e-17);
ry(2.6215888351554266) q[1]; // inplace_rot
p(6.341187821465943e-17) q[1];
gphase(-3.1705939107329713e-17);
// BEGIN lifted_x
s q[3];
h q[3];
cx q[1], q[3];
x q[3];
t q[3];
cx q[0], q[3];
x q[3];
inv @ t q[3];
cx q[1], q[3];
x q[3];
t q[3];
cx q[0], q[3];
x q[3];
inv @ t q[3];
h q[3];
sdg q[3];
// END lifted_x
h q[3]; // move-fast/pre
cx q[3], q[0]; // move-fast/pre
sdg q[0]; // move-fast/pre
h q[0]; // move-fast/pre
tdg q[0]; // move-fast/pre
sdg q[3]; // move-fast/pre
h q[3]; // move-fast/pre
tdg q[3]; // move-fast/pre
cx q[1], q[0]; // move-fast/toggle
cx q[1], q[3]; // move-fast/toggle
t q[3]; // move-fast/post
h q[3]; // move-fast/pre
s q[3]; // move-fast/post
t q[0]; // move-fast/post
h q[0]; // move-fast/pre
s q[0]; // move-fast/post
cx q[3], q[0]; // move-fast/post
h q[3]; // move-fast/post
h q[0]; // move-fast/pre
cx q[0], q[2]; // move-fast/pre
sdg q[2]; // move-fast/pre
h q[2]; // move-fast/pre
tdg q[2]; // move-fast/pre
sdg q[0]; // move-fast/pre
h q[0]; // move-fast/pre
tdg q[0]; // move-fast/pre
cx q[1], q[2]; // move-fast/toggle
cx q[1], q[0]; // move-fast/toggle
t q[0]; // move-fast/post
h q[0]; // move-fast/pre
s q[0]; // move-fast/post
t q[2]; // move-fast/post
h q[2]; // move-fast/pre
s q[2]; // move-fast/post
cx q[0], q[2]; // move-fast/post
h q[0]; // move-fast/post
gphase(-1.5707963267948966);
p(3.141592653589793) q[1];
ry(1.0091806415151765) q[1]; // inplace_rot
p(-3.141592653589793) q[1];
gphase(1.5707963267948966);
x q[1]; // want_negated=True
ccx q[1], q[3], q[0]; // inplace_x
cx q[1], q[3]; // inplace_x
gphase(-1.5707963267948966);
x q[1]; // want_negated=False
p(3.141592653589793) q[1];
ry(0.9355959614914396) q[1]; // inplace_rot
p(-3.141592653589793) q[1];
gphase(1.5707963267948966);
x q[1]; // want_negated=True
ccx q[3], q[1], q[0]; // inplace_x
cx q[1], q[3]; // inplace_x
gphase(1.5707963267948966);
x q[1]; // want_negated=False
p(-3.141592653589793) q[1];
ry(0.18568117996558187) q[1]; // inplace_rot
p(3.141592653589793) q[1];
gphase(-1.5707963267948966);
gphase(-6.425217334221735e-17);
swap q[0], q[1];
swap q[1], q[3];
swap q[2], q[3];

