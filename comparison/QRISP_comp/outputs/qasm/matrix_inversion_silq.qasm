include "stdgates.inc";
qubit[4] q;

gphase(-2.840471098838494e-13);
ry(3.1415274679146443) q[0]; // inplace_rot
p(-5.680942197676988e-13) q[0];
gphase(2.840471098838494e-13);
cx q[0], q[2]; // alloc
x q[0]; // want_negated=True
ctrl(1) @ ry(1.0471975511965976) q[0], q[1]; // inplace_rot
x q[1]; // want_negated=True
cp(0.0) q[0], q[1];
x q[1]; // want_negated=False
cp(0.0) q[0], q[1];
cp(-3.141592653589793) q[0], q[1];
x q[1]; // want_negated=True
cp(0.0) q[0], q[1];
// BEGIN lifted_x
s q[2];
h q[2];
cx q[0], q[2];
t q[2];
cx q[1], q[2];
inv @ t q[2];
cx q[0], q[2];
t q[2];
cx q[1], q[2];
inv @ t q[2];
h q[2];
sdg q[2];
// END lifted_x
x q[1]; // want_negated=False
cp(0.0) q[0], q[1];
x q[1]; // want_negated=True
cp(0.0) q[0], q[1];
x q[1]; // want_negated=False
ctrl(1) @ ry(-1.0471975511965976) q[0], q[1]; // inplace_rot
cp(3.141592653589793) q[0], q[1];
cx q[0], q[3]; // lifted_x
gphase(-1.5707963267948966);
x q[0]; // want_negated=False
p(3.141592653589793) q[0];
ry(0.0) q[0]; // inplace_rot
p(-3.141592653589793) q[0];
gphase(1.5707963267948966);
x q[0]; // want_negated=True
cx q[0], q[3]; // inplace_x
ctrl(1) @ ry(1.0471975511965976) q[0], q[1]; // inplace_rot
x q[1]; // want_negated=True
x q[3]; // want_negated=True
ctrl(3) @ gphase(0.0) q[0], q[1], q[3];
x q[1]; // want_negated=False
ctrl(3) @ gphase(0.0) q[1], q[0], q[3];
ctrl(3) @ x q[1], q[0], q[3], q[2]; // inplace_x
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[0], q[1], q[3];
x q[1]; // want_negated=False
ctrl(3) @ gphase(3.141592653589793) q[1], q[0], q[3];
ctrl(3) @ gphase(0.0) q[1], q[0], q[3];
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[0], q[1], q[3];
x q[1]; // want_negated=False
ctrl(2) @ ry(-1.0471975511965976) q[0], q[3], q[1]; // inplace_rot
ctrl(3) @ gphase(3.141592653589793) q[0], q[1], q[3];
x q[1]; // want_negated=True
x q[3]; // want_negated=False
ctrl(3) @ gphase(0.0) q[0], q[1], q[3];
x q[1]; // want_negated=False
ctrl(3) @ gphase(0.0) q[0], q[1], q[3];
ctrl(3) @ gphase(-3.141592653589793) q[0], q[1], q[3];
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[0], q[1], q[3];
x q[1]; // want_negated=False
ctrl(3) @ x q[0], q[1], q[3], q[2]; // inplace_x
ctrl(3) @ gphase(0.0) q[0], q[1], q[3];
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[0], q[1], q[3];
x q[1]; // want_negated=False
ctrl(2) @ ry(-1.0471975511965976) q[0], q[3], q[1]; // inplace_rot
ctrl(3) @ gphase(3.141592653589793) q[0], q[1], q[3];
gphase(1.4385510279246279e-05);
x q[0]; // want_negated=False
p(-2.8771020558492557e-05) q[0];
ry(9.776463271359676e-05) q[0]; // inplace_rot
p(2.8771020558492557e-05) q[0];
gphase(-1.4385510279246279e-05);
x q[0]; // want_negated=True
cx q[0], q[3]; // inplace_x
ctrl(1) @ ry(1.0471975511965976) q[0], q[1]; // inplace_rot
x q[3]; // want_negated=True
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[3], q[0], q[1];
x q[1]; // want_negated=False
ctrl(3) @ gphase(0.0) q[3], q[1], q[0];
ctrl(3) @ x q[3], q[1], q[0], q[2]; // inplace_x
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[3], q[0], q[1];
x q[1]; // want_negated=False
ctrl(3) @ gphase(3.141592653589793) q[3], q[1], q[0];
ctrl(3) @ gphase(0.0) q[3], q[1], q[0];
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[3], q[0], q[1];
x q[1]; // want_negated=False
ctrl(2) @ ry(-1.0471975511965976) q[3], q[0], q[1]; // inplace_rot
ctrl(3) @ gphase(3.141592653589793) q[3], q[1], q[0];
x q[1]; // want_negated=True
x q[3]; // want_negated=False
ctrl(3) @ gphase(0.0) q[1], q[0], q[3];
x q[1]; // want_negated=False
ctrl(3) @ gphase(0.0) q[1], q[0], q[3];
ctrl(3) @ gphase(-3.141592653589793) q[1], q[0], q[3];
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[1], q[0], q[3];
x q[1]; // want_negated=False
ctrl(3) @ x q[1], q[0], q[3], q[2]; // inplace_x
ctrl(3) @ gphase(0.0) q[1], q[0], q[3];
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[1], q[0], q[3];
x q[1]; // want_negated=False
ctrl(2) @ ry(-1.0471975511965976) q[0], q[3], q[1]; // inplace_rot
ctrl(3) @ gphase(3.141592653589793) q[1], q[0], q[3];
gphase(-1.5707963267948966);
x q[0]; // want_negated=False
p(3.141592653589793) q[0];
ry(0.0) q[0]; // inplace_rot
p(-3.141592653589793) q[0];
gphase(1.5707963267948966);
x q[0]; // want_negated=True
cx q[0], q[3]; // inplace_x
ctrl(1) @ ry(1.0471975511965976) q[0], q[1]; // inplace_rot
x q[1]; // want_negated=True
x q[3]; // want_negated=True
ctrl(3) @ gphase(0.0) q[0], q[1], q[3];
x q[1]; // want_negated=False
ctrl(3) @ gphase(0.0) q[1], q[0], q[3];
ctrl(3) @ x q[1], q[0], q[3], q[2]; // inplace_x
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[0], q[1], q[3];
x q[1]; // want_negated=False
ctrl(3) @ gphase(3.141592653589793) q[1], q[0], q[3];
ctrl(3) @ gphase(0.0) q[1], q[0], q[3];
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[0], q[1], q[3];
x q[1]; // want_negated=False
ctrl(2) @ ry(-1.0471975511965976) q[0], q[3], q[1]; // inplace_rot
ctrl(3) @ gphase(3.141592653589793) q[0], q[3], q[1];
x q[3]; // want_negated=False
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[0], q[3], q[1];
x q[1]; // want_negated=False
ctrl(3) @ gphase(0.0) q[1], q[0], q[3];
ctrl(3) @ gphase(-3.141592653589793) q[1], q[0], q[3];
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[0], q[3], q[1];
x q[1]; // want_negated=False
ctrl(3) @ x q[1], q[0], q[3], q[2]; // inplace_x
ctrl(3) @ gphase(0.0) q[1], q[0], q[3];
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[0], q[3], q[1];
x q[1]; // want_negated=False
ctrl(2) @ ry(-1.0471975511965976) q[0], q[3], q[1]; // inplace_rot
ctrl(3) @ gphase(3.141592653589793) q[0], q[3], q[1];
gphase(1.570796228491404);
x q[0]; // want_negated=False
p(-3.141592456982808) q[0];
ry(0.0003800334067763974) q[0]; // inplace_rot
p(3.141592456982808) q[0];
gphase(-1.570796228491404);
x q[0]; // want_negated=True
cx q[0], q[3]; // inplace_x
ctrl(1) @ ry(1.0471975511965976) q[0], q[1]; // inplace_rot
x q[1]; // want_negated=True
x q[3]; // want_negated=True
ctrl(3) @ gphase(0.0) q[0], q[1], q[3];
x q[1]; // want_negated=False
ctrl(3) @ gphase(0.0) q[0], q[1], q[3];
ctrl(3) @ x q[0], q[1], q[3], q[2]; // inplace_x
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[0], q[1], q[3];
x q[1]; // want_negated=False
ctrl(3) @ gphase(3.141592653589793) q[0], q[1], q[3];
ctrl(3) @ gphase(0.0) q[0], q[1], q[3];
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[0], q[1], q[3];
x q[1]; // want_negated=False
ctrl(2) @ ry(-1.0471975511965976) q[0], q[3], q[1]; // inplace_rot
ctrl(3) @ gphase(3.141592653589793) q[0], q[1], q[3];
x q[3]; // want_negated=False
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[0], q[3], q[1];
x q[1]; // want_negated=False
ctrl(3) @ gphase(0.0) q[0], q[3], q[1];
ctrl(3) @ gphase(-3.141592653589793) q[0], q[3], q[1];
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[0], q[3], q[1];
x q[1]; // want_negated=False
ctrl(3) @ x q[0], q[3], q[1], q[2]; // inplace_x
ctrl(3) @ gphase(0.0) q[0], q[3], q[1];
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[0], q[3], q[1];
x q[1]; // want_negated=False
ctrl(2) @ ry(-1.0471975511965976) q[0], q[3], q[1]; // inplace_rot
ctrl(3) @ gphase(3.141592653589793) q[0], q[1], q[3];
gphase(-1.5707963267948966);
x q[0]; // want_negated=False
p(3.141592653589793) q[0];
ry(0.0) q[0]; // inplace_rot
p(-3.141592653589793) q[0];
gphase(1.5707963267948966);
x q[0]; // want_negated=True
cx q[0], q[3]; // inplace_x
ctrl(1) @ ry(1.0471975511965976) q[0], q[1]; // inplace_rot
x q[1]; // want_negated=True
x q[3]; // want_negated=True
ctrl(3) @ gphase(0.0) q[1], q[3], q[0];
x q[1]; // want_negated=False
ctrl(3) @ gphase(0.0) q[3], q[0], q[1];
ctrl(3) @ x q[3], q[0], q[1], q[2]; // inplace_x
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[1], q[3], q[0];
x q[1]; // want_negated=False
ctrl(3) @ gphase(3.141592653589793) q[3], q[0], q[1];
ctrl(3) @ gphase(0.0) q[3], q[0], q[1];
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[1], q[3], q[0];
x q[1]; // want_negated=False
ctrl(2) @ ry(-1.0471975511965976) q[3], q[0], q[1]; // inplace_rot
ctrl(3) @ gphase(3.141592653589793) q[3], q[0], q[1];
x q[1]; // want_negated=True
x q[3]; // want_negated=False
ctrl(3) @ gphase(0.0) q[0], q[1], q[3];
x q[1]; // want_negated=False
ctrl(3) @ gphase(0.0) q[0], q[3], q[1];
ctrl(3) @ gphase(-3.141592653589793) q[0], q[3], q[1];
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[0], q[1], q[3];
x q[1]; // want_negated=False
ctrl(3) @ x q[0], q[3], q[1], q[2]; // inplace_x
ctrl(3) @ gphase(0.0) q[0], q[3], q[1];
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[0], q[1], q[3];
x q[1]; // want_negated=False
ctrl(2) @ ry(-1.0471975511965976) q[0], q[3], q[1]; // inplace_rot
ctrl(3) @ gphase(3.141592653589793) q[1], q[0], q[3];
gphase(-1.3113644056944288e-07);
x q[0]; // want_negated=False
p(2.6227288113888577e-07) q[0];
ry(0.001427718229960974) q[0]; // inplace_rot
p(-2.6227288113888577e-07) q[0];
gphase(1.3113644056944288e-07);
x q[0]; // want_negated=True
cx q[0], q[3]; // inplace_x
ctrl(1) @ ry(1.0471975511965976) q[0], q[1]; // inplace_rot
x q[1]; // want_negated=True
x q[3]; // want_negated=True
ctrl(3) @ gphase(0.0) q[1], q[0], q[3];
x q[1]; // want_negated=False
ctrl(3) @ gphase(0.0) q[0], q[3], q[1];
ctrl(3) @ x q[0], q[3], q[1], q[2]; // inplace_x
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[1], q[0], q[3];
x q[1]; // want_negated=False
ctrl(3) @ gphase(3.141592653589793) q[0], q[3], q[1];
ctrl(3) @ gphase(0.0) q[0], q[3], q[1];
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[1], q[0], q[3];
x q[1]; // want_negated=False
ctrl(2) @ ry(-1.0471975511965976) q[0], q[3], q[1]; // inplace_rot
ctrl(3) @ gphase(3.141592653589793) q[1], q[0], q[3];
x q[1]; // want_negated=True
x q[3]; // want_negated=False
ctrl(3) @ gphase(0.0) q[1], q[0], q[3];
x q[1]; // want_negated=False
ctrl(3) @ gphase(0.0) q[1], q[0], q[3];
ctrl(3) @ gphase(-3.141592653589793) q[1], q[0], q[3];
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[1], q[0], q[3];
x q[1]; // want_negated=False
ctrl(3) @ x q[1], q[0], q[3], q[2]; // inplace_x
ctrl(3) @ gphase(0.0) q[1], q[0], q[3];
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[1], q[0], q[3];
x q[1]; // want_negated=False
ctrl(2) @ ry(-1.0471975511965976) q[0], q[3], q[1]; // inplace_rot
ctrl(3) @ gphase(3.141592653589793) q[1], q[0], q[3];
gphase(-1.5707963267948966);
x q[0]; // want_negated=False
p(3.141592653589793) q[0];
ry(0.0) q[0]; // inplace_rot
p(-3.141592653589793) q[0];
gphase(1.5707963267948966);
x q[0]; // want_negated=True
cx q[0], q[3]; // inplace_x
ctrl(1) @ ry(1.0471975511965976) q[0], q[1]; // inplace_rot
x q[1]; // want_negated=True
x q[3]; // want_negated=True
ctrl(3) @ gphase(0.0) q[1], q[0], q[3];
x q[1]; // want_negated=False
ctrl(3) @ gphase(0.0) q[3], q[0], q[1];
ctrl(3) @ x q[3], q[0], q[1], q[2]; // inplace_x
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[1], q[0], q[3];
x q[1]; // want_negated=False
ctrl(3) @ gphase(3.141592653589793) q[3], q[0], q[1];
ctrl(3) @ gphase(0.0) q[3], q[0], q[1];
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[1], q[0], q[3];
x q[1]; // want_negated=False
ctrl(2) @ ry(-1.0471975511965976) q[3], q[0], q[1]; // inplace_rot
ctrl(3) @ gphase(3.141592653589793) q[3], q[0], q[1];
x q[3]; // want_negated=False
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[0], q[3], q[1];
x q[1]; // want_negated=False
ctrl(3) @ gphase(0.0) q[0], q[3], q[1];
ctrl(3) @ gphase(-3.141592653589793) q[0], q[3], q[1];
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[0], q[3], q[1];
x q[1]; // want_negated=False
ctrl(3) @ x q[0], q[3], q[1], q[2]; // inplace_x
ctrl(3) @ gphase(0.0) q[0], q[3], q[1];
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[0], q[3], q[1];
x q[1]; // want_negated=False
ctrl(2) @ ry(-1.0471975511965976) q[0], q[3], q[1]; // inplace_rot
ctrl(3) @ gphase(3.141592653589793) q[0], q[3], q[1];
gphase(1.5707963085199779);
x q[0]; // want_negated=False
p(-3.1415926170399557) q[0];
ry(0.004774609203485056) q[0]; // inplace_rot
p(3.1415926170399557) q[0];
gphase(-1.5707963085199779);
x q[0]; // want_negated=True
cx q[0], q[3]; // inplace_x
ctrl(1) @ ry(1.0471975511965976) q[0], q[1]; // inplace_rot
x q[3]; // want_negated=True
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[3], q[0], q[1];
x q[1]; // want_negated=False
ctrl(3) @ gphase(0.0) q[3], q[0], q[1];
ctrl(3) @ x q[3], q[0], q[1], q[2]; // inplace_x
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[3], q[0], q[1];
x q[1]; // want_negated=False
ctrl(3) @ gphase(3.141592653589793) q[3], q[0], q[1];
ctrl(3) @ gphase(0.0) q[3], q[0], q[1];
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[3], q[0], q[1];
x q[1]; // want_negated=False
ctrl(2) @ ry(-1.0471975511965976) q[3], q[0], q[1]; // inplace_rot
ctrl(3) @ gphase(3.141592653589793) q[3], q[0], q[1];
x q[1]; // want_negated=True
x q[3]; // want_negated=False
ctrl(3) @ gphase(0.0) q[1], q[0], q[3];
x q[1]; // want_negated=False
ctrl(3) @ gphase(0.0) q[0], q[1], q[3];
ctrl(3) @ gphase(-3.141592653589793) q[0], q[1], q[3];
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[1], q[0], q[3];
x q[1]; // want_negated=False
ctrl(3) @ x q[0], q[1], q[3], q[2]; // inplace_x
ctrl(3) @ gphase(0.0) q[0], q[1], q[3];
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[1], q[0], q[3];
x q[1]; // want_negated=False
ctrl(2) @ ry(-1.0471975511965976) q[0], q[3], q[1]; // inplace_rot
ctrl(3) @ gphase(3.141592653589793) q[3], q[0], q[1];
gphase(-1.5707963267948966);
x q[0]; // want_negated=False
p(3.141592653589793) q[0];
ry(0.0) q[0]; // inplace_rot
p(-3.141592653589793) q[0];
gphase(1.5707963267948966);
x q[0]; // want_negated=True
cx q[0], q[3]; // inplace_x
ctrl(1) @ ry(1.0471975511965976) q[0], q[1]; // inplace_rot
x q[1]; // want_negated=True
x q[3]; // want_negated=True
ctrl(3) @ gphase(0.0) q[1], q[0], q[3];
x q[1]; // want_negated=False
ctrl(3) @ gphase(0.0) q[1], q[0], q[3];
ctrl(3) @ x q[1], q[0], q[3], q[2]; // inplace_x
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[1], q[0], q[3];
x q[1]; // want_negated=False
ctrl(3) @ gphase(3.141592653589793) q[1], q[0], q[3];
ctrl(3) @ gphase(0.0) q[1], q[0], q[3];
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[1], q[0], q[3];
x q[1]; // want_negated=False
ctrl(2) @ ry(-1.0471975511965976) q[0], q[3], q[1]; // inplace_rot
ctrl(3) @ gphase(3.141592653589793) q[1], q[0], q[3];
x q[3]; // want_negated=False
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[3], q[1], q[0];
x q[1]; // want_negated=False
ctrl(3) @ gphase(0.0) q[3], q[1], q[0];
ctrl(3) @ gphase(-3.141592653589793) q[3], q[1], q[0];
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[3], q[1], q[0];
x q[1]; // want_negated=False
ctrl(3) @ x q[3], q[1], q[0], q[2]; // inplace_x
ctrl(3) @ gphase(0.0) q[3], q[1], q[0];
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[3], q[1], q[0];
x q[1]; // want_negated=False
ctrl(2) @ ry(-1.0471975511965976) q[3], q[0], q[1]; // inplace_rot
ctrl(3) @ gphase(3.141592653589793) q[3], q[1], q[0];
gphase(-1.5723490475589896e-09);
x q[0]; // want_negated=False
p(3.144698095117979e-09) q[0];
ry(0.014086389389628211) q[0]; // inplace_rot
p(-3.144698095117979e-09) q[0];
gphase(1.5723490475589896e-09);
x q[0]; // want_negated=True
cx q[0], q[3]; // inplace_x
ctrl(1) @ ry(1.0471975511965976) q[0], q[1]; // inplace_rot
x q[3]; // want_negated=True
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[3], q[1], q[0];
x q[1]; // want_negated=False
ctrl(3) @ gphase(0.0) q[3], q[1], q[0];
ctrl(3) @ x q[3], q[1], q[0], q[2]; // inplace_x
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[3], q[1], q[0];
x q[1]; // want_negated=False
ctrl(3) @ gphase(3.141592653589793) q[3], q[1], q[0];
ctrl(3) @ gphase(0.0) q[3], q[1], q[0];
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[3], q[1], q[0];
x q[1]; // want_negated=False
ctrl(2) @ ry(-1.0471975511965976) q[3], q[0], q[1]; // inplace_rot
ctrl(3) @ gphase(3.141592653589793) q[3], q[0], q[1];
x q[1]; // want_negated=True
x q[3]; // want_negated=False
ctrl(3) @ gphase(0.0) q[1], q[3], q[0];
x q[1]; // want_negated=False
ctrl(3) @ gphase(0.0) q[1], q[3], q[0];
ctrl(3) @ gphase(-3.141592653589793) q[1], q[3], q[0];
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[1], q[3], q[0];
x q[1]; // want_negated=False
ctrl(3) @ x q[1], q[3], q[0], q[2]; // inplace_x
ctrl(3) @ gphase(0.0) q[1], q[3], q[0];
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[1], q[3], q[0];
x q[1]; // want_negated=False
ctrl(2) @ ry(-1.0471975511965976) q[3], q[0], q[1]; // inplace_rot
ctrl(3) @ gphase(3.141592653589793) q[0], q[3], q[1];
gphase(-1.5707963267948966);
x q[0]; // want_negated=False
p(3.141592653589793) q[0];
ry(0.0) q[0]; // inplace_rot
p(-3.141592653589793) q[0];
gphase(1.5707963267948966);
x q[0]; // want_negated=True
cx q[0], q[3]; // inplace_x
ctrl(1) @ ry(1.0471975511965976) q[0], q[1]; // inplace_rot
x q[1]; // want_negated=True
x q[3]; // want_negated=True
ctrl(3) @ gphase(0.0) q[1], q[3], q[0];
x q[1]; // want_negated=False
ctrl(3) @ gphase(0.0) q[3], q[0], q[1];
ctrl(3) @ x q[3], q[0], q[1], q[2]; // inplace_x
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[1], q[3], q[0];
x q[1]; // want_negated=False
ctrl(3) @ gphase(3.141592653589793) q[3], q[0], q[1];
ctrl(3) @ gphase(0.0) q[3], q[0], q[1];
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[1], q[3], q[0];
x q[1]; // want_negated=False
ctrl(2) @ ry(-1.0471975511965976) q[3], q[0], q[1]; // inplace_rot
ctrl(3) @ gphase(3.141592653589793) q[1], q[3], q[0];
x q[1]; // want_negated=True
x q[3]; // want_negated=False
ctrl(3) @ gphase(0.0) q[1], q[3], q[0];
x q[1]; // want_negated=False
ctrl(3) @ gphase(0.0) q[3], q[0], q[1];
ctrl(3) @ gphase(-3.141592653589793) q[3], q[0], q[1];
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[1], q[3], q[0];
x q[1]; // want_negated=False
ctrl(3) @ x q[3], q[0], q[1], q[2]; // inplace_x
ctrl(3) @ gphase(0.0) q[3], q[0], q[1];
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[1], q[3], q[0];
x q[1]; // want_negated=False
ctrl(2) @ ry(-1.0471975511965976) q[3], q[0], q[1]; // inplace_rot
ctrl(3) @ gphase(3.141592653589793) q[0], q[3], q[1];
gphase(1.5707963267614249);
x q[0]; // want_negated=False
p(-3.1415926535228498) q[0];
ry(0.0368683182207828) q[0]; // inplace_rot
p(3.1415926535228498) q[0];
gphase(-1.5707963267614249);
x q[0]; // want_negated=True
cx q[0], q[3]; // inplace_x
ctrl(1) @ ry(1.0471975511965976) q[0], q[1]; // inplace_rot
x q[3]; // want_negated=True
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[0], q[3], q[1];
x q[1]; // want_negated=False
ctrl(3) @ gphase(0.0) q[1], q[0], q[3];
ctrl(3) @ x q[1], q[0], q[3], q[2]; // inplace_x
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[0], q[3], q[1];
x q[1]; // want_negated=False
ctrl(3) @ gphase(3.141592653589793) q[1], q[0], q[3];
ctrl(3) @ gphase(0.0) q[1], q[0], q[3];
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[0], q[3], q[1];
x q[1]; // want_negated=False
ctrl(2) @ ry(-1.0471975511965976) q[0], q[3], q[1]; // inplace_rot
ctrl(3) @ gphase(3.141592653589793) q[0], q[3], q[1];
x q[1]; // want_negated=True
x q[3]; // want_negated=False
ctrl(3) @ gphase(0.0) q[0], q[1], q[3];
x q[1]; // want_negated=False
ctrl(3) @ gphase(0.0) q[0], q[1], q[3];
ctrl(3) @ gphase(-3.141592653589793) q[0], q[1], q[3];
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[0], q[1], q[3];
x q[1]; // want_negated=False
ctrl(3) @ x q[0], q[1], q[3], q[2]; // inplace_x
ctrl(3) @ gphase(0.0) q[0], q[1], q[3];
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[0], q[1], q[3];
x q[1]; // want_negated=False
ctrl(2) @ ry(-1.0471975511965976) q[0], q[3], q[1]; // inplace_rot
ctrl(3) @ gphase(3.141592653589793) q[0], q[1], q[3];
gphase(-1.5707963267948966);
x q[0]; // want_negated=False
p(3.141592653589793) q[0];
ry(0.0) q[0]; // inplace_rot
p(-3.141592653589793) q[0];
gphase(1.5707963267948966);
x q[0]; // want_negated=True
cx q[0], q[3]; // inplace_x
ctrl(1) @ ry(1.0471975511965976) q[0], q[1]; // inplace_rot
x q[3]; // want_negated=True
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[0], q[3], q[1];
x q[1]; // want_negated=False
ctrl(3) @ gphase(0.0) q[0], q[3], q[1];
ctrl(3) @ x q[0], q[3], q[1], q[2]; // inplace_x
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[0], q[3], q[1];
x q[1]; // want_negated=False
ctrl(3) @ gphase(3.141592653589793) q[0], q[3], q[1];
ctrl(3) @ gphase(0.0) q[0], q[3], q[1];
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[0], q[3], q[1];
x q[1]; // want_negated=False
ctrl(2) @ ry(-1.0471975511965976) q[0], q[3], q[1]; // inplace_rot
ctrl(3) @ gphase(3.141592653589793) q[0], q[1], q[3];
x q[3]; // want_negated=False
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[0], q[3], q[1];
x q[1]; // want_negated=False
ctrl(3) @ gphase(0.0) q[0], q[3], q[1];
ctrl(3) @ gphase(-3.141592653589793) q[0], q[3], q[1];
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[0], q[3], q[1];
x q[1]; // want_negated=False
ctrl(3) @ x q[0], q[3], q[1], q[2]; // inplace_x
ctrl(3) @ gphase(0.0) q[0], q[3], q[1];
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[0], q[3], q[1];
x q[1]; // want_negated=False
ctrl(2) @ ry(-1.0471975511965976) q[0], q[3], q[1]; // inplace_rot
ctrl(3) @ gphase(3.141592653589793) q[0], q[1], q[3];
gphase(2.3272632913941472e-11);
x q[0]; // want_negated=False
p(-4.6545265827882944e-11) q[0];
ry(0.08622753116186589) q[0]; // inplace_rot
p(4.6545265827882944e-11) q[0];
gphase(-2.3272632913941472e-11);
x q[0]; // want_negated=True
cx q[0], q[3]; // inplace_x
ctrl(1) @ ry(1.0471975511965976) q[0], q[1]; // inplace_rot
x q[3]; // want_negated=True
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[3], q[0], q[1];
x q[1]; // want_negated=False
ctrl(3) @ gphase(0.0) q[3], q[0], q[1];
ctrl(3) @ x q[3], q[0], q[1], q[2]; // inplace_x
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[3], q[0], q[1];
x q[1]; // want_negated=False
ctrl(3) @ gphase(3.141592653589793) q[3], q[0], q[1];
ctrl(3) @ gphase(0.0) q[3], q[0], q[1];
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[3], q[0], q[1];
x q[1]; // want_negated=False
ctrl(2) @ ry(-1.0471975511965976) q[3], q[0], q[1]; // inplace_rot
ctrl(3) @ gphase(3.141592653589793) q[3], q[0], q[1];
x q[1]; // want_negated=True
x q[3]; // want_negated=False
ctrl(3) @ gphase(0.0) q[0], q[1], q[3];
x q[1]; // want_negated=False
ctrl(3) @ gphase(0.0) q[0], q[3], q[1];
ctrl(3) @ gphase(-3.141592653589793) q[0], q[3], q[1];
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[0], q[1], q[3];
x q[1]; // want_negated=False
ctrl(3) @ x q[0], q[3], q[1], q[2]; // inplace_x
ctrl(3) @ gphase(0.0) q[0], q[3], q[1];
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[0], q[1], q[3];
x q[1]; // want_negated=False
ctrl(2) @ ry(-1.0471975511965976) q[0], q[3], q[1]; // inplace_rot
ctrl(3) @ gphase(3.141592653589793) q[1], q[0], q[3];
gphase(-1.5707963267948966);
x q[0]; // want_negated=False
p(3.141592653589793) q[0];
ry(0.0) q[0]; // inplace_rot
p(-3.141592653589793) q[0];
gphase(1.5707963267948966);
x q[0]; // want_negated=True
cx q[0], q[3]; // inplace_x
ctrl(1) @ ry(1.0471975511965976) q[0], q[1]; // inplace_rot
x q[3]; // want_negated=True
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[0], q[3], q[1];
x q[1]; // want_negated=False
ctrl(3) @ gphase(0.0) q[0], q[3], q[1];
ctrl(3) @ x q[0], q[3], q[1], q[2]; // inplace_x
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[0], q[3], q[1];
x q[1]; // want_negated=False
ctrl(3) @ gphase(3.141592653589793) q[0], q[3], q[1];
ctrl(3) @ gphase(0.0) q[0], q[3], q[1];
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[0], q[3], q[1];
x q[1]; // want_negated=False
ctrl(2) @ ry(-1.0471975511965976) q[0], q[3], q[1]; // inplace_rot
ctrl(3) @ gphase(3.141592653589793) q[0], q[3], q[1];
x q[1]; // want_negated=True
x q[3]; // want_negated=False
ctrl(3) @ gphase(0.0) q[0], q[1], q[3];
x q[1]; // want_negated=False
ctrl(3) @ gphase(0.0) q[0], q[1], q[3];
ctrl(3) @ gphase(-3.141592653589793) q[0], q[1], q[3];
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[0], q[1], q[3];
x q[1]; // want_negated=False
ctrl(3) @ x q[0], q[1], q[3], q[2]; // inplace_x
ctrl(3) @ gphase(0.0) q[0], q[1], q[3];
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[0], q[1], q[3];
x q[1]; // want_negated=False
ctrl(2) @ ry(-1.0471975511965976) q[0], q[3], q[1]; // inplace_rot
ctrl(3) @ gphase(3.141592653589793) q[0], q[3], q[1];
gphase(-1.570796326789849);
x q[0]; // want_negated=False
p(3.141592653579698) q[0];
ry(0.18111158638146607) q[0]; // inplace_rot
p(-3.141592653579698) q[0];
gphase(1.570796326789849);
x q[0]; // want_negated=True
cx q[0], q[3]; // inplace_x
ctrl(1) @ ry(1.0471975511965976) q[0], q[1]; // inplace_rot
x q[3]; // want_negated=True
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[0], q[3], q[1];
x q[1]; // want_negated=False
ctrl(3) @ gphase(0.0) q[3], q[0], q[1];
ctrl(3) @ x q[3], q[0], q[1], q[2]; // inplace_x
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[0], q[3], q[1];
x q[1]; // want_negated=False
ctrl(3) @ gphase(3.141592653589793) q[3], q[0], q[1];
ctrl(3) @ gphase(0.0) q[3], q[0], q[1];
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[0], q[3], q[1];
x q[1]; // want_negated=False
ctrl(2) @ ry(-1.0471975511965976) q[3], q[0], q[1]; // inplace_rot
ctrl(3) @ gphase(3.141592653589793) q[1], q[3], q[0];
x q[3]; // want_negated=False
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[3], q[1], q[0];
x q[1]; // want_negated=False
ctrl(3) @ gphase(0.0) q[3], q[0], q[1];
ctrl(3) @ gphase(-3.141592653589793) q[3], q[0], q[1];
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[3], q[1], q[0];
x q[1]; // want_negated=False
ctrl(3) @ x q[3], q[0], q[1], q[2]; // inplace_x
ctrl(3) @ gphase(0.0) q[3], q[0], q[1];
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[3], q[1], q[0];
x q[1]; // want_negated=False
ctrl(2) @ ry(-1.0471975511965976) q[3], q[0], q[1]; // inplace_rot
ctrl(3) @ gphase(3.141592653589793) q[3], q[0], q[1];
gphase(-1.5707963267948966);
x q[0]; // want_negated=False
p(3.141592653589793) q[0];
ry(0.0) q[0]; // inplace_rot
p(-3.141592653589793) q[0];
gphase(1.5707963267948966);
x q[0]; // want_negated=True
cx q[0], q[3]; // inplace_x
ctrl(1) @ ry(1.0471975511965976) q[0], q[1]; // inplace_rot
x q[1]; // want_negated=True
x q[3]; // want_negated=True
ctrl(3) @ gphase(0.0) q[1], q[3], q[0];
x q[1]; // want_negated=False
ctrl(3) @ gphase(0.0) q[3], q[0], q[1];
ctrl(3) @ x q[3], q[0], q[1], q[2]; // inplace_x
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[1], q[3], q[0];
x q[1]; // want_negated=False
ctrl(3) @ gphase(3.141592653589793) q[3], q[0], q[1];
ctrl(3) @ gphase(0.0) q[3], q[0], q[1];
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[1], q[3], q[0];
x q[1]; // want_negated=False
ctrl(2) @ ry(-1.0471975511965976) q[3], q[0], q[1]; // inplace_rot
ctrl(3) @ gphase(3.141592653589793) q[3], q[1], q[0];
x q[3]; // want_negated=False
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[3], q[1], q[0];
x q[1]; // want_negated=False
ctrl(3) @ gphase(0.0) q[3], q[0], q[1];
ctrl(3) @ gphase(-3.141592653589793) q[3], q[0], q[1];
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[3], q[1], q[0];
x q[1]; // want_negated=False
ctrl(3) @ x q[3], q[0], q[1], q[2]; // inplace_x
ctrl(3) @ gphase(0.0) q[3], q[0], q[1];
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[3], q[1], q[0];
x q[1]; // want_negated=False
ctrl(2) @ ry(-1.0471975511965976) q[3], q[0], q[1]; // inplace_rot
ctrl(3) @ gphase(3.141592653589793) q[3], q[0], q[1];
gphase(1.5789455639050084e-12);
x q[0]; // want_negated=False
p(-3.1578911278100168e-12) q[0];
ry(0.34078995119489974) q[0]; // inplace_rot
p(3.1578911278100168e-12) q[0];
gphase(-1.5789455639050084e-12);
x q[0]; // want_negated=True
cx q[0], q[3]; // inplace_x
ctrl(1) @ ry(1.0471975511965976) q[0], q[1]; // inplace_rot
x q[3]; // want_negated=True
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[0], q[3], q[1];
x q[1]; // want_negated=False
ctrl(3) @ gphase(0.0) q[0], q[3], q[1];
ctrl(3) @ x q[0], q[3], q[1], q[2]; // inplace_x
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[0], q[3], q[1];
x q[1]; // want_negated=False
ctrl(3) @ gphase(3.141592653589793) q[0], q[3], q[1];
ctrl(3) @ gphase(0.0) q[0], q[3], q[1];
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[0], q[3], q[1];
x q[1]; // want_negated=False
ctrl(2) @ ry(-1.0471975511965976) q[0], q[3], q[1]; // inplace_rot
ctrl(3) @ gphase(3.141592653589793) q[0], q[1], q[3];
x q[1]; // want_negated=True
x q[3]; // want_negated=False
ctrl(3) @ gphase(0.0) q[1], q[0], q[3];
x q[1]; // want_negated=False
ctrl(3) @ gphase(0.0) q[0], q[3], q[1];
ctrl(3) @ gphase(-3.141592653589793) q[0], q[3], q[1];
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[1], q[0], q[3];
x q[1]; // want_negated=False
ctrl(3) @ x q[0], q[3], q[1], q[2]; // inplace_x
ctrl(3) @ gphase(0.0) q[0], q[3], q[1];
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[1], q[0], q[3];
x q[1]; // want_negated=False
ctrl(2) @ ry(-1.0471975511965976) q[0], q[3], q[1]; // inplace_rot
ctrl(3) @ gphase(3.141592653589793) q[0], q[1], q[3];
gphase(-1.5707963267948966);
x q[0]; // want_negated=False
p(3.141592653589793) q[0];
ry(0.0) q[0]; // inplace_rot
p(-3.141592653589793) q[0];
gphase(1.5707963267948966);
x q[0]; // want_negated=True
cx q[0], q[3]; // inplace_x
ctrl(1) @ ry(1.0471975511965976) q[0], q[1]; // inplace_rot
x q[1]; // want_negated=True
x q[3]; // want_negated=True
ctrl(3) @ gphase(0.0) q[1], q[3], q[0];
x q[1]; // want_negated=False
ctrl(3) @ gphase(0.0) q[1], q[3], q[0];
ctrl(3) @ x q[1], q[3], q[0], q[2]; // inplace_x
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[1], q[3], q[0];
x q[1]; // want_negated=False
ctrl(3) @ gphase(3.141592653589793) q[1], q[3], q[0];
ctrl(3) @ gphase(0.0) q[1], q[3], q[0];
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[1], q[3], q[0];
x q[1]; // want_negated=False
ctrl(2) @ ry(-1.0471975511965976) q[3], q[0], q[1]; // inplace_rot
ctrl(3) @ gphase(3.141592653589793) q[3], q[0], q[1];
x q[1]; // want_negated=True
x q[3]; // want_negated=False
ctrl(3) @ gphase(0.0) q[1], q[3], q[0];
x q[1]; // want_negated=False
ctrl(3) @ gphase(0.0) q[1], q[3], q[0];
ctrl(3) @ gphase(-3.141592653589793) q[1], q[3], q[0];
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[1], q[3], q[0];
x q[1]; // want_negated=False
ctrl(3) @ x q[1], q[3], q[0], q[2]; // inplace_x
ctrl(3) @ gphase(0.0) q[1], q[3], q[0];
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[1], q[3], q[0];
x q[1]; // want_negated=False
ctrl(2) @ ry(-1.0471975511965976) q[3], q[0], q[1]; // inplace_rot
ctrl(3) @ gphase(3.141592653589793) q[3], q[0], q[1];
gphase(-1.5707963267941267);
x q[0]; // want_negated=False
p(3.1415926535882535) q[0];
ry(0.5630561253896087) q[0]; // inplace_rot
p(-3.1415926535882535) q[0];
gphase(1.5707963267941267);
x q[0]; // want_negated=True
cx q[0], q[3]; // inplace_x
ctrl(1) @ ry(1.0471975511965976) q[0], q[1]; // inplace_rot
x q[1]; // want_negated=True
x q[3]; // want_negated=True
ctrl(3) @ gphase(0.0) q[1], q[3], q[0];
x q[1]; // want_negated=False
ctrl(3) @ gphase(0.0) q[1], q[3], q[0];
ctrl(3) @ x q[1], q[3], q[0], q[2]; // inplace_x
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[1], q[3], q[0];
x q[1]; // want_negated=False
ctrl(3) @ gphase(3.141592653589793) q[1], q[3], q[0];
ctrl(3) @ gphase(0.0) q[1], q[3], q[0];
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[1], q[3], q[0];
x q[1]; // want_negated=False
ctrl(2) @ ry(-1.0471975511965976) q[3], q[0], q[1]; // inplace_rot
ctrl(3) @ gphase(3.141592653589793) q[3], q[1], q[0];
x q[3]; // want_negated=False
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[3], q[1], q[0];
x q[1]; // want_negated=False
ctrl(3) @ gphase(0.0) q[3], q[1], q[0];
ctrl(3) @ gphase(-3.141592653589793) q[3], q[1], q[0];
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[3], q[1], q[0];
x q[1]; // want_negated=False
ctrl(3) @ x q[3], q[1], q[0], q[2]; // inplace_x
ctrl(3) @ gphase(0.0) q[3], q[1], q[0];
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[3], q[1], q[0];
x q[1]; // want_negated=False
ctrl(2) @ ry(-1.0471975511965976) q[3], q[0], q[1]; // inplace_rot
ctrl(3) @ gphase(3.141592653589793) q[3], q[1], q[0];
gphase(-1.5707963267948966);
x q[0]; // want_negated=False
p(3.141592653589793) q[0];
ry(0.0) q[0]; // inplace_rot
p(-3.141592653589793) q[0];
gphase(1.5707963267948966);
x q[0]; // want_negated=True
cx q[0], q[3]; // inplace_x
ctrl(1) @ ry(1.0471975511965976) q[0], q[1]; // inplace_rot
x q[1]; // want_negated=True
x q[3]; // want_negated=True
ctrl(3) @ gphase(0.0) q[1], q[3], q[0];
x q[1]; // want_negated=False
ctrl(3) @ gphase(0.0) q[1], q[3], q[0];
ctrl(3) @ x q[1], q[3], q[0], q[2]; // inplace_x
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[1], q[3], q[0];
x q[1]; // want_negated=False
ctrl(3) @ gphase(3.141592653589793) q[1], q[3], q[0];
ctrl(3) @ gphase(0.0) q[1], q[3], q[0];
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[1], q[3], q[0];
x q[1]; // want_negated=False
ctrl(2) @ ry(-1.0471975511965976) q[3], q[0], q[1]; // inplace_rot
ctrl(3) @ gphase(3.141592653589793) q[1], q[3], q[0];
x q[1]; // want_negated=True
x q[3]; // want_negated=False
ctrl(3) @ gphase(0.0) q[1], q[3], q[0];
x q[1]; // want_negated=False
ctrl(3) @ gphase(0.0) q[3], q[1], q[0];
ctrl(3) @ gphase(-3.141592653589793) q[3], q[1], q[0];
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[1], q[3], q[0];
x q[1]; // want_negated=False
ctrl(3) @ x q[3], q[1], q[0], q[2]; // inplace_x
ctrl(3) @ gphase(0.0) q[3], q[1], q[0];
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[1], q[3], q[0];
x q[1]; // want_negated=False
ctrl(2) @ ry(-1.0471975511965976) q[3], q[0], q[1]; // inplace_rot
ctrl(3) @ gphase(3.141592653589793) q[1], q[3], q[0];
gphase(-5.967981529353309e-13);
x q[0]; // want_negated=False
p(1.1935963058706617e-12) q[0];
ry(0.7801361606707458) q[0]; // inplace_rot
p(-1.1935963058706617e-12) q[0];
gphase(5.967981529353309e-13);
x q[0]; // want_negated=True
cx q[0], q[3]; // inplace_x
ctrl(1) @ ry(1.0471975511965976) q[0], q[1]; // inplace_rot
x q[1]; // want_negated=True
x q[3]; // want_negated=True
ctrl(3) @ gphase(0.0) q[0], q[1], q[3];
x q[1]; // want_negated=False
ctrl(3) @ gphase(0.0) q[0], q[3], q[1];
ctrl(3) @ x q[0], q[3], q[1], q[2]; // inplace_x
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[0], q[1], q[3];
x q[1]; // want_negated=False
ctrl(3) @ gphase(3.141592653589793) q[0], q[3], q[1];
ctrl(3) @ gphase(0.0) q[0], q[3], q[1];
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[0], q[1], q[3];
x q[1]; // want_negated=False
ctrl(2) @ ry(-1.0471975511965976) q[0], q[3], q[1]; // inplace_rot
ctrl(3) @ gphase(3.141592653589793) q[0], q[3], q[1];
x q[3]; // want_negated=False
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[0], q[3], q[1];
x q[1]; // want_negated=False
ctrl(3) @ gphase(0.0) q[0], q[3], q[1];
ctrl(3) @ gphase(-3.141592653589793) q[0], q[3], q[1];
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[0], q[3], q[1];
x q[1]; // want_negated=False
ctrl(3) @ x q[0], q[3], q[1], q[2]; // inplace_x
ctrl(3) @ gphase(0.0) q[0], q[3], q[1];
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[0], q[3], q[1];
x q[1]; // want_negated=False
ctrl(2) @ ry(-1.0471975511965976) q[0], q[3], q[1]; // inplace_rot
ctrl(3) @ gphase(3.141592653589793) q[0], q[1], q[3];
gphase(-1.5707963267948966);
x q[0]; // want_negated=False
p(3.141592653589793) q[0];
ry(0.0) q[0]; // inplace_rot
p(-3.141592653589793) q[0];
gphase(1.5707963267948966);
x q[0]; // want_negated=True
cx q[0], q[3]; // inplace_x
ctrl(1) @ ry(1.0471975511965976) q[0], q[1]; // inplace_rot
x q[1]; // want_negated=True
x q[3]; // want_negated=True
ctrl(3) @ gphase(0.0) q[1], q[3], q[0];
x q[1]; // want_negated=False
ctrl(3) @ gphase(0.0) q[3], q[0], q[1];
ctrl(3) @ x q[3], q[0], q[1], q[2]; // inplace_x
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[1], q[3], q[0];
x q[1]; // want_negated=False
ctrl(3) @ gphase(3.141592653589793) q[3], q[0], q[1];
ctrl(3) @ gphase(0.0) q[3], q[0], q[1];
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[1], q[3], q[0];
x q[1]; // want_negated=False
ctrl(2) @ ry(-1.0471975511965976) q[3], q[0], q[1]; // inplace_rot
ctrl(3) @ gphase(3.141592653589793) q[1], q[3], q[0];
x q[3]; // want_negated=False
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[0], q[3], q[1];
x q[1]; // want_negated=False
ctrl(3) @ gphase(0.0) q[1], q[0], q[3];
ctrl(3) @ gphase(-3.141592653589793) q[1], q[0], q[3];
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[0], q[3], q[1];
x q[1]; // want_negated=False
ctrl(3) @ x q[1], q[0], q[3], q[2]; // inplace_x
ctrl(3) @ gphase(0.0) q[1], q[0], q[3];
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[0], q[3], q[1];
x q[1]; // want_negated=False
ctrl(2) @ ry(-1.0471975511965976) q[0], q[3], q[1]; // inplace_rot
ctrl(3) @ gphase(3.141592653589793) q[0], q[1], q[3];
gphase(-1.5707963267947913);
x q[0]; // want_negated=False
p(3.1415926535895826) q[0];
ry(0.8562941190021919) q[0]; // inplace_rot
p(-3.1415926535895826) q[0];
gphase(1.5707963267947913);
x q[0]; // want_negated=True
cx q[0], q[3]; // inplace_x
ctrl(1) @ ry(1.0471975511965976) q[0], q[1]; // inplace_rot
x q[3]; // want_negated=True
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[0], q[3], q[1];
x q[1]; // want_negated=False
ctrl(3) @ gphase(0.0) q[1], q[0], q[3];
ctrl(3) @ x q[1], q[0], q[3], q[2]; // inplace_x
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[0], q[3], q[1];
x q[1]; // want_negated=False
ctrl(3) @ gphase(3.141592653589793) q[1], q[0], q[3];
ctrl(3) @ gphase(0.0) q[1], q[0], q[3];
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[0], q[3], q[1];
x q[1]; // want_negated=False
ctrl(2) @ ry(-1.0471975511965976) q[0], q[3], q[1]; // inplace_rot
ctrl(3) @ gphase(3.141592653589793) q[1], q[0], q[3];
x q[3]; // want_negated=False
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[0], q[3], q[1];
x q[1]; // want_negated=False
ctrl(3) @ gphase(0.0) q[0], q[3], q[1];
ctrl(3) @ gphase(-3.141592653589793) q[0], q[3], q[1];
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[0], q[3], q[1];
x q[1]; // want_negated=False
ctrl(3) @ x q[0], q[3], q[1], q[2]; // inplace_x
ctrl(3) @ gphase(0.0) q[0], q[3], q[1];
x q[1]; // want_negated=True
ctrl(3) @ gphase(0.0) q[0], q[3], q[1];
x q[1]; // want_negated=False
ctrl(2) @ ry(-1.0471975511965976) q[0], q[3], q[1]; // inplace_rot
ctrl(3) @ gphase(3.141592653589793) q[0], q[3], q[1];
gphase(-1.5707963267948966);
x q[0]; // want_negated=False
p(3.141592653589793) q[0];
ry(0.0) q[0]; // inplace_rot
p(-3.141592653589793) q[0];
gphase(1.5707963267948966);
gphase(0.0);
x q[3];
swap q[1], q[3];
swap q[2], q[3];

