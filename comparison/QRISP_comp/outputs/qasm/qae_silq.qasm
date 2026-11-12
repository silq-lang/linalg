include "stdgates.inc";
qubit[8] q;

h q[0]; // inplace_h
h q[1]; // inplace_h
h q[2]; // inplace_h
h q[3]; // inplace_h
h q[4]; // inplace_h
ry(1.0471975511965976) q[5]; // inplace_rot
x q[5]; // want_negated=True
cp(3.141592653589793) q[5], q[0];
x q[5]; // want_negated=False
ctrl(1) @ ry(-1.0471975511965976) q[0], q[5]; // inplace_rot
x q[5]; // want_negated=True
cp(3.141592653589793) q[0], q[5];
x q[5]; // want_negated=False
ctrl(1) @ ry(1.0471975511965976) q[0], q[5]; // inplace_rot
x q[5]; // want_negated=True
cp(3.141592653589793) q[1], q[5];
x q[5]; // want_negated=False
ctrl(1) @ ry(-1.0471975511965976) q[1], q[5]; // inplace_rot
x q[5]; // want_negated=True
cp(3.141592653589793) q[1], q[5];
x q[5]; // want_negated=False
ctrl(1) @ ry(1.0471975511965976) q[1], q[5]; // inplace_rot
x q[5]; // want_negated=True
cp(3.141592653589793) q[1], q[5];
x q[5]; // want_negated=False
ctrl(1) @ ry(-1.0471975511965976) q[1], q[5]; // inplace_rot
x q[5]; // want_negated=True
cp(3.141592653589793) q[1], q[5];
x q[5]; // want_negated=False
ctrl(1) @ ry(1.0471975511965976) q[1], q[5]; // inplace_rot
x q[5]; // want_negated=True
cp(3.141592653589793) q[2], q[5];
x q[5]; // want_negated=False
ctrl(1) @ ry(-1.0471975511965976) q[2], q[5]; // inplace_rot
x q[5]; // want_negated=True
cp(3.141592653589793) q[5], q[2];
x q[5]; // want_negated=False
ctrl(1) @ ry(1.0471975511965976) q[2], q[5]; // inplace_rot
x q[5]; // want_negated=True
cp(3.141592653589793) q[2], q[5];
x q[5]; // want_negated=False
ctrl(1) @ ry(-1.0471975511965976) q[2], q[5]; // inplace_rot
x q[5]; // want_negated=True
cp(3.141592653589793) q[2], q[5];
x q[5]; // want_negated=False
ctrl(1) @ ry(1.0471975511965976) q[2], q[5]; // inplace_rot
x q[5]; // want_negated=True
cp(3.141592653589793) q[2], q[5];
x q[5]; // want_negated=False
ctrl(1) @ ry(-1.0471975511965976) q[2], q[5]; // inplace_rot
x q[5]; // want_negated=True
cp(3.141592653589793) q[2], q[5];
x q[5]; // want_negated=False
ctrl(1) @ ry(1.0471975511965976) q[2], q[5]; // inplace_rot
x q[5]; // want_negated=True
cp(3.141592653589793) q[2], q[5];
x q[5]; // want_negated=False
ctrl(1) @ ry(-1.0471975511965976) q[2], q[5]; // inplace_rot
x q[5]; // want_negated=True
cp(3.141592653589793) q[2], q[5];
x q[5]; // want_negated=False
ctrl(1) @ ry(1.0471975511965976) q[2], q[5]; // inplace_rot
x q[5]; // want_negated=True
cp(3.141592653589793) q[3], q[5];
x q[5]; // want_negated=False
ctrl(1) @ ry(-1.0471975511965976) q[3], q[5]; // inplace_rot
x q[5]; // want_negated=True
cp(3.141592653589793) q[3], q[5];
x q[5]; // want_negated=False
ctrl(1) @ ry(1.0471975511965976) q[3], q[5]; // inplace_rot
x q[5]; // want_negated=True
cp(3.141592653589793) q[5], q[3];
x q[5]; // want_negated=False
ctrl(1) @ ry(-1.0471975511965976) q[3], q[5]; // inplace_rot
x q[5]; // want_negated=True
cp(3.141592653589793) q[5], q[3];
x q[5]; // want_negated=False
ctrl(1) @ ry(1.0471975511965976) q[3], q[5]; // inplace_rot
x q[5]; // want_negated=True
cp(3.141592653589793) q[3], q[5];
x q[5]; // want_negated=False
ctrl(1) @ ry(-1.0471975511965976) q[3], q[5]; // inplace_rot
x q[5]; // want_negated=True
cp(3.141592653589793) q[3], q[5];
x q[5]; // want_negated=False
ctrl(1) @ ry(1.0471975511965976) q[3], q[5]; // inplace_rot
x q[5]; // want_negated=True
cp(3.141592653589793) q[3], q[5];
x q[5]; // want_negated=False
ctrl(1) @ ry(-1.0471975511965976) q[3], q[5]; // inplace_rot
x q[5]; // want_negated=True
cp(3.141592653589793) q[5], q[3];
x q[5]; // want_negated=False
ctrl(1) @ ry(1.0471975511965976) q[3], q[5]; // inplace_rot
x q[5]; // want_negated=True
cp(3.141592653589793) q[3], q[5];
x q[5]; // want_negated=False
ctrl(1) @ ry(-1.0471975511965976) q[3], q[5]; // inplace_rot
x q[5]; // want_negated=True
cp(3.141592653589793) q[3], q[5];
x q[5]; // want_negated=False
ctrl(1) @ ry(1.0471975511965976) q[3], q[5]; // inplace_rot
x q[5]; // want_negated=True
cp(3.141592653589793) q[3], q[5];
x q[5]; // want_negated=False
ctrl(1) @ ry(-1.0471975511965976) q[3], q[5]; // inplace_rot
x q[5]; // want_negated=True
cp(3.141592653589793) q[3], q[5];
x q[5]; // want_negated=False
ctrl(1) @ ry(1.0471975511965976) q[3], q[5]; // inplace_rot
x q[5]; // want_negated=True
cp(3.141592653589793) q[3], q[5];
x q[5]; // want_negated=False
ctrl(1) @ ry(-1.0471975511965976) q[3], q[5]; // inplace_rot
x q[5]; // want_negated=True
cp(3.141592653589793) q[5], q[3];
x q[5]; // want_negated=False
ctrl(1) @ ry(1.0471975511965976) q[3], q[5]; // inplace_rot
x q[5]; // want_negated=True
cp(3.141592653589793) q[3], q[5];
x q[5]; // want_negated=False
ctrl(1) @ ry(-1.0471975511965976) q[3], q[5]; // inplace_rot
x q[5]; // want_negated=True
cp(3.141592653589793) q[3], q[5];
x q[5]; // want_negated=False
ctrl(1) @ ry(1.0471975511965976) q[3], q[5]; // inplace_rot
x q[5]; // want_negated=True
cp(3.141592653589793) q[5], q[4];
x q[5]; // want_negated=False
ctrl(1) @ ry(-1.0471975511965976) q[4], q[5]; // inplace_rot
x q[5]; // want_negated=True
cp(3.141592653589793) q[5], q[4];
x q[5]; // want_negated=False
ctrl(1) @ ry(1.0471975511965976) q[4], q[5]; // inplace_rot
x q[5]; // want_negated=True
cp(3.141592653589793) q[4], q[5];
x q[5]; // want_negated=False
ctrl(1) @ ry(-1.0471975511965976) q[4], q[5]; // inplace_rot
x q[5]; // want_negated=True
cp(3.141592653589793) q[4], q[5];
x q[5]; // want_negated=False
ctrl(1) @ ry(1.0471975511965976) q[4], q[5]; // inplace_rot
x q[5]; // want_negated=True
cp(3.141592653589793) q[5], q[4];
x q[5]; // want_negated=False
ctrl(1) @ ry(-1.0471975511965976) q[4], q[5]; // inplace_rot
x q[5]; // want_negated=True
cp(3.141592653589793) q[4], q[5];
x q[5]; // want_negated=False
ctrl(1) @ ry(1.0471975511965976) q[4], q[5]; // inplace_rot
x q[5]; // want_negated=True
cp(3.141592653589793) q[4], q[5];
x q[5]; // want_negated=False
ctrl(1) @ ry(-1.0471975511965976) q[4], q[5]; // inplace_rot
x q[5]; // want_negated=True
cp(3.141592653589793) q[4], q[5];
x q[5]; // want_negated=False
ctrl(1) @ ry(1.0471975511965976) q[4], q[5]; // inplace_rot
x q[5]; // want_negated=True
cp(3.141592653589793) q[5], q[4];
x q[5]; // want_negated=False
ctrl(1) @ ry(-1.0471975511965976) q[4], q[5]; // inplace_rot
x q[5]; // want_negated=True
cp(3.141592653589793) q[4], q[5];
x q[5]; // want_negated=False
ctrl(1) @ ry(1.0471975511965976) q[4], q[5]; // inplace_rot
x q[5]; // want_negated=True
cp(3.141592653589793) q[4], q[5];
x q[5]; // want_negated=False
ctrl(1) @ ry(-1.0471975511965976) q[4], q[5]; // inplace_rot
x q[5]; // want_negated=True
cp(3.141592653589793) q[5], q[4];
x q[5]; // want_negated=False
ctrl(1) @ ry(1.0471975511965976) q[4], q[5]; // inplace_rot
x q[5]; // want_negated=True
cp(3.141592653589793) q[4], q[5];
x q[5]; // want_negated=False
ctrl(1) @ ry(-1.0471975511965976) q[4], q[5]; // inplace_rot
x q[5]; // want_negated=True
cp(3.141592653589793) q[5], q[4];
x q[5]; // want_negated=False
ctrl(1) @ ry(1.0471975511965976) q[4], q[5]; // inplace_rot
x q[5]; // want_negated=True
cp(3.141592653589793) q[4], q[5];
x q[5]; // want_negated=False
ctrl(1) @ ry(-1.0471975511965976) q[4], q[5]; // inplace_rot
x q[5]; // want_negated=True
cp(3.141592653589793) q[5], q[4];
x q[5]; // want_negated=False
ctrl(1) @ ry(1.0471975511965976) q[4], q[5]; // inplace_rot
x q[5]; // want_negated=True
cp(3.141592653589793) q[5], q[4];
x q[5]; // want_negated=False
ctrl(1) @ ry(-1.0471975511965976) q[4], q[5]; // inplace_rot
x q[5]; // want_negated=True
cp(3.141592653589793) q[5], q[4];
x q[5]; // want_negated=False
ctrl(1) @ ry(1.0471975511965976) q[4], q[5]; // inplace_rot
x q[5]; // want_negated=True
cp(3.141592653589793) q[4], q[5];
x q[5]; // want_negated=False
ctrl(1) @ ry(-1.0471975511965976) q[4], q[5]; // inplace_rot
x q[5]; // want_negated=True
cp(3.141592653589793) q[4], q[5];
x q[5]; // want_negated=False
ctrl(1) @ ry(1.0471975511965976) q[4], q[5]; // inplace_rot
x q[5]; // want_negated=True
cp(3.141592653589793) q[4], q[5];
x q[5]; // want_negated=False
ctrl(1) @ ry(-1.0471975511965976) q[4], q[5]; // inplace_rot
x q[5]; // want_negated=True
cp(3.141592653589793) q[5], q[4];
x q[5]; // want_negated=False
ctrl(1) @ ry(1.0471975511965976) q[4], q[5]; // inplace_rot
x q[5]; // want_negated=True
cp(3.141592653589793) q[4], q[5];
x q[5]; // want_negated=False
ctrl(1) @ ry(-1.0471975511965976) q[4], q[5]; // inplace_rot
x q[5]; // want_negated=True
cp(3.141592653589793) q[5], q[4];
x q[5]; // want_negated=False
ctrl(1) @ ry(1.0471975511965976) q[4], q[5]; // inplace_rot
x q[5]; // want_negated=True
cp(3.141592653589793) q[5], q[4];
x q[5]; // want_negated=False
ctrl(1) @ ry(-1.0471975511965976) q[4], q[5]; // inplace_rot
x q[5]; // want_negated=True
cp(3.141592653589793) q[5], q[4];
x q[5]; // want_negated=False
ctrl(1) @ ry(1.0471975511965976) q[4], q[5]; // inplace_rot
x q[5]; // want_negated=True
cp(3.141592653589793) q[5], q[4];
x q[5]; // want_negated=False
ctrl(1) @ ry(-1.0471975511965976) q[4], q[5]; // inplace_rot
x q[5]; // want_negated=True
cp(3.141592653589793) q[4], q[5];
x q[5]; // want_negated=False
ctrl(1) @ ry(1.0471975511965976) q[4], q[5]; // inplace_rot
x q[5]; // want_negated=True
cp(3.141592653589793) q[4], q[5];
x q[5]; // want_negated=False
ctrl(1) @ ry(-1.0471975511965976) q[4], q[5]; // inplace_rot
x q[5]; // want_negated=True
cp(3.141592653589793) q[5], q[4];
x q[5]; // want_negated=False
ctrl(1) @ ry(1.0471975511965976) q[4], q[5]; // inplace_rot
x q[5]; // want_negated=True
cp(3.141592653589793) q[4], q[5];
x q[5]; // want_negated=False
ctrl(1) @ ry(-1.0471975511965976) q[4], q[5]; // inplace_rot
x q[5]; // want_negated=True
cp(3.141592653589793) q[4], q[5];
x q[5]; // want_negated=False
ctrl(1) @ ry(1.0471975511965976) q[4], q[5]; // inplace_rot
h q[4]; // inplace_h
// BEGIN dup
h q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[3], q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
h q[6];
// END dup
p(-1.5707963267948966) q[6];
// BEGIN dup
s q[7];
h q[7];
cx q[3], q[7];
t q[7];
cx q[4], q[7];
inv @ t q[7];
cx q[3], q[7];
t q[7];
cx q[4], q[7];
inv @ t q[7];
h q[7];
sdg q[7];
// END dup
// BEGIN undup
s q[7];
h q[7];
t q[7];
cx q[6], q[7];
inv @ t q[7];
cx q[3], q[7];
t q[7];
cx q[6], q[7];
inv @ t q[7];
cx q[3], q[7];
h q[7];
sdg q[7];
// END undup
// BEGIN undup
h q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[3], q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
h q[6];
// END undup
h q[3]; // inplace_h
// BEGIN dup
h q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[2], q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
h q[6];
// END dup
p(-0.7853981633974483) q[6];
// BEGIN dup
s q[7];
h q[7];
cx q[2], q[7];
t q[7];
cx q[4], q[7];
inv @ t q[7];
cx q[2], q[7];
t q[7];
cx q[4], q[7];
inv @ t q[7];
h q[7];
sdg q[7];
// END dup
// BEGIN undup
s q[7];
h q[7];
t q[7];
cx q[6], q[7];
inv @ t q[7];
cx q[2], q[7];
t q[7];
cx q[6], q[7];
inv @ t q[7];
cx q[2], q[7];
h q[7];
sdg q[7];
// END undup
// BEGIN undup
h q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
cx q[2], q[6];
t q[6];
cx q[4], q[6];
inv @ t q[6];
h q[6];
// END undup
// BEGIN dup
h q[6];
t q[6];
cx q[3], q[6];
inv @ t q[6];
cx q[2], q[6];
t q[6];
cx q[3], q[6];
inv @ t q[6];
h q[6];
// END dup
p(-1.5707963267948966) q[6];
// BEGIN dup
s q[7];
h q[7];
cx q[2], q[7];
t q[7];
cx q[3], q[7];
inv @ t q[7];
cx q[2], q[7];
t q[7];
cx q[3], q[7];
inv @ t q[7];
h q[7];
sdg q[7];
// END dup
// BEGIN undup
s q[7];
h q[7];
t q[7];
cx q[6], q[7];
inv @ t q[7];
cx q[2], q[7];
t q[7];
cx q[6], q[7];
inv @ t q[7];
cx q[2], q[7];
h q[7];
sdg q[7];
// END undup
// BEGIN undup
h q[6];
t q[6];
cx q[3], q[6];
inv @ t q[6];
cx q[2], q[6];
t q[6];
cx q[3], q[6];
inv @ t q[6];
h q[6];
// END undup
h q[2]; // inplace_h
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
p(-0.39269908169872414) q[6];
// BEGIN dup
s q[7];
h q[7];
cx q[1], q[7];
t q[7];
cx q[4], q[7];
inv @ t q[7];
cx q[1], q[7];
t q[7];
cx q[4], q[7];
inv @ t q[7];
h q[7];
sdg q[7];
// END dup
// BEGIN undup
s q[7];
h q[7];
t q[7];
cx q[6], q[7];
inv @ t q[7];
cx q[1], q[7];
t q[7];
cx q[6], q[7];
inv @ t q[7];
cx q[1], q[7];
h q[7];
sdg q[7];
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
// BEGIN dup
h q[6];
t q[6];
cx q[3], q[6];
inv @ t q[6];
cx q[1], q[6];
t q[6];
cx q[3], q[6];
inv @ t q[6];
h q[6];
// END dup
p(-0.7853981633974483) q[6];
// BEGIN dup
s q[7];
h q[7];
cx q[1], q[7];
t q[7];
cx q[3], q[7];
inv @ t q[7];
cx q[1], q[7];
t q[7];
cx q[3], q[7];
inv @ t q[7];
h q[7];
sdg q[7];
// END dup
// BEGIN undup
s q[7];
h q[7];
t q[7];
cx q[6], q[7];
inv @ t q[7];
cx q[1], q[7];
t q[7];
cx q[6], q[7];
inv @ t q[7];
cx q[1], q[7];
h q[7];
sdg q[7];
// END undup
// BEGIN undup
h q[6];
t q[6];
cx q[3], q[6];
inv @ t q[6];
cx q[1], q[6];
t q[6];
cx q[3], q[6];
inv @ t q[6];
h q[6];
// END undup
// BEGIN dup
h q[6];
t q[6];
cx q[2], q[6];
inv @ t q[6];
cx q[1], q[6];
t q[6];
cx q[2], q[6];
inv @ t q[6];
h q[6];
// END dup
p(-1.5707963267948966) q[6];
// BEGIN dup
s q[7];
h q[7];
cx q[1], q[7];
t q[7];
cx q[2], q[7];
inv @ t q[7];
cx q[1], q[7];
t q[7];
cx q[2], q[7];
inv @ t q[7];
h q[7];
sdg q[7];
// END dup
// BEGIN undup
s q[7];
h q[7];
t q[7];
cx q[6], q[7];
inv @ t q[7];
cx q[1], q[7];
t q[7];
cx q[6], q[7];
inv @ t q[7];
cx q[1], q[7];
h q[7];
sdg q[7];
// END undup
// BEGIN undup
h q[6];
t q[6];
cx q[2], q[6];
inv @ t q[6];
cx q[1], q[6];
t q[6];
cx q[2], q[6];
inv @ t q[6];
h q[6];
// END undup
h q[1]; // inplace_h
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
p(-0.19634954084936207) q[6];
// BEGIN dup
s q[7];
h q[7];
cx q[0], q[7];
t q[7];
cx q[4], q[7];
inv @ t q[7];
cx q[0], q[7];
t q[7];
cx q[4], q[7];
inv @ t q[7];
h q[7];
sdg q[7];
// END dup
// BEGIN undup
s q[7];
h q[7];
t q[7];
cx q[6], q[7];
inv @ t q[7];
cx q[0], q[7];
t q[7];
cx q[6], q[7];
inv @ t q[7];
cx q[0], q[7];
h q[7];
sdg q[7];
// END undup
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
// BEGIN dup
h q[6];
t q[6];
cx q[3], q[6];
inv @ t q[6];
cx q[0], q[6];
t q[6];
cx q[3], q[6];
inv @ t q[6];
h q[6];
// END dup
p(-0.39269908169872414) q[6];
// BEGIN dup
s q[7];
h q[7];
cx q[0], q[7];
t q[7];
cx q[3], q[7];
inv @ t q[7];
cx q[0], q[7];
t q[7];
cx q[3], q[7];
inv @ t q[7];
h q[7];
sdg q[7];
// END dup
// BEGIN undup
s q[7];
h q[7];
t q[7];
cx q[6], q[7];
inv @ t q[7];
cx q[0], q[7];
t q[7];
cx q[6], q[7];
inv @ t q[7];
cx q[0], q[7];
h q[7];
sdg q[7];
// END undup
// BEGIN undup
h q[6];
t q[6];
cx q[3], q[6];
inv @ t q[6];
cx q[0], q[6];
t q[6];
cx q[3], q[6];
inv @ t q[6];
h q[6];
// END undup
// BEGIN dup
h q[6];
t q[6];
cx q[2], q[6];
inv @ t q[6];
cx q[0], q[6];
t q[6];
cx q[2], q[6];
inv @ t q[6];
h q[6];
// END dup
p(-0.7853981633974483) q[6];
// BEGIN dup
s q[7];
h q[7];
cx q[0], q[7];
t q[7];
cx q[2], q[7];
inv @ t q[7];
cx q[0], q[7];
t q[7];
cx q[2], q[7];
inv @ t q[7];
h q[7];
sdg q[7];
// END dup
// BEGIN undup
s q[7];
h q[7];
t q[7];
cx q[6], q[7];
inv @ t q[7];
cx q[0], q[7];
t q[7];
cx q[6], q[7];
inv @ t q[7];
cx q[0], q[7];
h q[7];
sdg q[7];
// END undup
// BEGIN undup
h q[6];
t q[6];
cx q[2], q[6];
inv @ t q[6];
cx q[0], q[6];
t q[6];
cx q[2], q[6];
inv @ t q[6];
h q[6];
// END undup
// BEGIN dup
h q[6];
t q[6];
cx q[1], q[6];
inv @ t q[6];
cx q[0], q[6];
t q[6];
cx q[1], q[6];
inv @ t q[6];
h q[6];
// END dup
p(-1.5707963267948966) q[6];
// BEGIN dup
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
// END dup
// BEGIN undup
s q[7];
h q[7];
t q[7];
cx q[6], q[7];
inv @ t q[7];
cx q[0], q[7];
t q[7];
cx q[6], q[7];
inv @ t q[7];
cx q[0], q[7];
h q[7];
sdg q[7];
// END undup
// BEGIN undup
h q[6];
t q[6];
cx q[1], q[6];
inv @ t q[6];
cx q[0], q[6];
t q[6];
cx q[1], q[6];
inv @ t q[6];
h q[6];
// END undup
h q[0]; // inplace_h
swap q[0], q[4];
swap q[1], q[3];

