include "stdgates.inc";
qubit[7] q;

h q[0]; // inplace_h
h q[1]; // inplace_h
h q[2]; // inplace_h
x q[0]; // want_negated=True
cx q[0], q[3]; // alloc
x q[0]; // want_negated=False
cx q[0], q[3]; // alloc
p(1.1780972450961724) q[0];
ctrl(1) @ h q[0], q[3]; // inplace_h
p(-0.39269908169872414) q[0];
cp(0.7853981633974483) q[0], q[3];
ctrl(1) @ h q[0], q[3]; // inplace_h
p(1.1780972450961724) q[1];
ctrl(1) @ h q[1], q[3]; // inplace_h
p(-0.39269908169872414) q[1];
cp(0.7853981633974483) q[3], q[1];
p(1.1780972450961724) q[1];
p(-0.39269908169872414) q[1];
cp(0.7853981633974483) q[3], q[1];
ctrl(1) @ h q[1], q[3]; // inplace_h
p(1.1780972450961724) q[2];
ctrl(1) @ h q[2], q[3]; // inplace_h
p(-0.39269908169872414) q[2];
cp(0.7853981633974483) q[2], q[3];
p(1.1780972450961724) q[2];
p(-0.39269908169872414) q[2];
cp(0.7853981633974483) q[2], q[3];
p(1.1780972450961724) q[2];
p(-0.39269908169872414) q[2];
cp(0.7853981633974483) q[2], q[3];
p(1.1780972450961724) q[2];
p(-0.39269908169872414) q[2];
cp(0.7853981633974483) q[2], q[3];
ctrl(1) @ h q[2], q[3]; // inplace_h
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
// BEGIN lifted_x
s q[4];
h q[4];
cx q[1], q[4];
x q[4];
t q[4];
cx q[0], q[4];
x q[4];
inv @ t q[4];
cx q[1], q[4];
x q[4];
t q[4];
cx q[0], q[4];
x q[4];
inv @ t q[4];
h q[4];
sdg q[4];
// END lifted_x
// BEGIN dup
s q[5];
h q[5];
cx q[2], q[5];
x q[5];
t q[5];
cx q[4], q[5];
inv @ t q[5];
cx q[2], q[5];
x q[5];
t q[5];
cx q[4], q[5];
inv @ t q[5];
h q[5];
sdg q[5];
// END dup
ctrl(1) @ ry(3.141592653589793) q[5], q[6]; // inplace_rot
// BEGIN undup
s q[5];
h q[5];
t q[5];
cx q[4], q[5];
inv @ t q[5];
cx q[2], q[5];
x q[5];
t q[5];
cx q[4], q[5];
inv @ t q[5];
cx q[2], q[5];
x q[5];
h q[5];
sdg q[5];
// END undup
// BEGIN unlifted_x
s q[4];
h q[4];
t q[4];
cx q[0], q[4];
x q[4];
inv @ t q[4];
cx q[1], q[4];
x q[4];
t q[4];
cx q[0], q[4];
x q[4];
inv @ t q[4];
cx q[1], q[4];
x q[4];
h q[4];
sdg q[4];
// END unlifted_x
// BEGIN lifted_x
s q[4];
h q[4];
cx q[1], q[4];
x q[4];
t q[4];
cx q[0], q[4];
x q[4];
inv @ t q[4];
cx q[1], q[4];
x q[4];
t q[4];
cx q[0], q[4];
x q[4];
inv @ t q[4];
h q[4];
sdg q[4];
// END lifted_x
// BEGIN dup
h q[5];
t q[5];
cx q[4], q[5];
inv @ t q[5];
cx q[2], q[5];
t q[5];
cx q[4], q[5];
inv @ t q[5];
h q[5];
// END dup
ctrl(1) @ ry(0.0) q[5], q[6]; // inplace_rot
// BEGIN undup
h q[5];
t q[5];
cx q[4], q[5];
inv @ t q[5];
cx q[2], q[5];
t q[5];
cx q[4], q[5];
inv @ t q[5];
h q[5];
// END undup
// BEGIN unlifted_x
s q[4];
h q[4];
t q[4];
cx q[0], q[4];
x q[4];
inv @ t q[4];
cx q[1], q[4];
x q[4];
t q[4];
cx q[0], q[4];
x q[4];
inv @ t q[4];
cx q[1], q[4];
x q[4];
h q[4];
sdg q[4];
// END unlifted_x
// BEGIN lifted_x
h q[4];
t q[4];
cx q[0], q[4];
x q[4];
inv @ t q[4];
cx q[1], q[4];
t q[4];
cx q[0], q[4];
x q[4];
inv @ t q[4];
h q[4];
// END lifted_x
// BEGIN dup
s q[5];
h q[5];
cx q[2], q[5];
x q[5];
t q[5];
cx q[4], q[5];
inv @ t q[5];
cx q[2], q[5];
x q[5];
t q[5];
cx q[4], q[5];
inv @ t q[5];
h q[5];
sdg q[5];
// END dup
ctrl(1) @ ry(2.0943951023931953) q[5], q[6]; // inplace_rot
// BEGIN undup
s q[5];
h q[5];
t q[5];
cx q[4], q[5];
inv @ t q[5];
cx q[2], q[5];
x q[5];
t q[5];
cx q[4], q[5];
inv @ t q[5];
cx q[2], q[5];
x q[5];
h q[5];
sdg q[5];
// END undup
// BEGIN unlifted_x
h q[4];
t q[4];
cx q[0], q[4];
x q[4];
inv @ t q[4];
cx q[1], q[4];
t q[4];
cx q[0], q[4];
x q[4];
inv @ t q[4];
h q[4];
// END unlifted_x
// BEGIN lifted_x
h q[4];
t q[4];
cx q[0], q[4];
x q[4];
inv @ t q[4];
cx q[1], q[4];
t q[4];
cx q[0], q[4];
x q[4];
inv @ t q[4];
h q[4];
// END lifted_x
// BEGIN dup
h q[5];
t q[5];
cx q[4], q[5];
inv @ t q[5];
cx q[2], q[5];
t q[5];
cx q[4], q[5];
inv @ t q[5];
h q[5];
// END dup
ctrl(1) @ ry(2.4619188346815495) q[5], q[6]; // inplace_rot
// BEGIN undup
h q[5];
t q[5];
cx q[4], q[5];
inv @ t q[5];
cx q[2], q[5];
t q[5];
cx q[4], q[5];
inv @ t q[5];
h q[5];
// END undup
// BEGIN unlifted_x
h q[4];
t q[4];
cx q[0], q[4];
x q[4];
inv @ t q[4];
cx q[1], q[4];
t q[4];
cx q[0], q[4];
x q[4];
inv @ t q[4];
h q[4];
// END unlifted_x
// BEGIN dup
s q[4];
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
sdg q[4];
// END dup
// BEGIN dup
s q[5];
h q[5];
cx q[2], q[5];
x q[5];
t q[5];
cx q[4], q[5];
inv @ t q[5];
cx q[2], q[5];
x q[5];
t q[5];
cx q[4], q[5];
inv @ t q[5];
h q[5];
sdg q[5];
// END dup
ctrl(1) @ ry(3.141592653589793) q[5], q[6]; // inplace_rot
// BEGIN undup
s q[5];
h q[5];
t q[5];
cx q[4], q[5];
inv @ t q[5];
cx q[2], q[5];
x q[5];
t q[5];
cx q[4], q[5];
inv @ t q[5];
cx q[2], q[5];
x q[5];
h q[5];
sdg q[5];
// END undup
// BEGIN undup
s q[4];
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
sdg q[4];
// END undup
// BEGIN dup
s q[4];
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
sdg q[4];
// END dup
// BEGIN dup
h q[5];
t q[5];
cx q[4], q[5];
inv @ t q[5];
cx q[2], q[5];
t q[5];
cx q[4], q[5];
inv @ t q[5];
h q[5];
// END dup
ctrl(1) @ ry(3.8212664724980367) q[5], q[6]; // inplace_rot
// BEGIN undup
h q[5];
t q[5];
cx q[4], q[5];
inv @ t q[5];
cx q[2], q[5];
t q[5];
cx q[4], q[5];
inv @ t q[5];
h q[5];
// END undup
// BEGIN undup
s q[4];
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
sdg q[4];
// END undup
// BEGIN dup
h q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
h q[4];
// END dup
// BEGIN dup
s q[5];
h q[5];
cx q[2], q[5];
x q[5];
t q[5];
cx q[4], q[5];
inv @ t q[5];
cx q[2], q[5];
x q[5];
t q[5];
cx q[4], q[5];
inv @ t q[5];
h q[5];
sdg q[5];
// END dup
ctrl(1) @ ry(4.188790204786391) q[5], q[6]; // inplace_rot
// BEGIN undup
s q[5];
h q[5];
t q[5];
cx q[4], q[5];
inv @ t q[5];
cx q[2], q[5];
x q[5];
t q[5];
cx q[4], q[5];
inv @ t q[5];
cx q[2], q[5];
x q[5];
h q[5];
sdg q[5];
// END undup
// BEGIN undup
h q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
h q[4];
// END undup
// BEGIN dup
h q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
h q[4];
// END dup
// BEGIN dup
h q[5];
t q[5];
cx q[4], q[5];
inv @ t q[5];
cx q[2], q[5];
t q[5];
cx q[4], q[5];
inv @ t q[5];
h q[5];
// END dup
ctrl(1) @ ry(6.283185307179586) q[5], q[6]; // inplace_rot
// BEGIN undup
h q[5];
t q[5];
cx q[4], q[5];
inv @ t q[5];
cx q[2], q[5];
t q[5];
cx q[4], q[5];
inv @ t q[5];
h q[5];
// END undup
// BEGIN undup
h q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
cx q[1], q[4];
t q[4];
cx q[0], q[4];
inv @ t q[4];
h q[4];
// END undup
h q[0]; // inplace_h
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
p(1.5707963267948966) q[4];
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
p(0.7853981633974483) q[4];
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
h q[1]; // inplace_h
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
p(1.5707963267948966) q[4];
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
h q[2]; // inplace_h
ctrl(1) @ h q[2], q[3]; // inplace_h
cp(-0.7853981633974483) q[2], q[3];
p(0.39269908169872414) q[2];
p(-1.1780972450961724) q[2];
cp(-0.7853981633974483) q[2], q[3];
p(0.39269908169872414) q[2];
p(-1.1780972450961724) q[2];
cp(-0.7853981633974483) q[2], q[3];
p(0.39269908169872414) q[2];
p(-1.1780972450961724) q[2];
cp(-0.7853981633974483) q[2], q[3];
p(0.39269908169872414) q[2];
ctrl(1) @ h q[2], q[3]; // inplace_h
p(-1.1780972450961724) q[2];
ctrl(1) @ h q[1], q[3]; // inplace_h
cp(-0.7853981633974483) q[1], q[3];
p(0.39269908169872414) q[1];
p(-1.1780972450961724) q[1];
cp(-0.7853981633974483) q[1], q[3];
p(0.39269908169872414) q[1];
ctrl(1) @ h q[1], q[3]; // inplace_h
p(-1.1780972450961724) q[1];
ctrl(1) @ h q[0], q[3]; // inplace_h
cp(-0.7853981633974483) q[3], q[0];
p(0.39269908169872414) q[0];
ctrl(1) @ h q[0], q[3]; // inplace_h
p(-1.1780972450961724) q[0];
h q[0]; // inplace_h
h q[1]; // inplace_h
h q[2]; // inplace_h
swap q[0], q[6];
swap q[1], q[6];
swap q[2], q[6];
swap q[3], q[6];
swap q[4], q[6];

