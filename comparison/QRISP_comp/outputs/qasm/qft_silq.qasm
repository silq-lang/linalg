include "stdgates.inc";
qubit[7] q;

ry(0.28559933214452665) q[0]; // inplace_rot
gphase(-0.1208304866765305);
p(0.241660973353061) q[0];
ry(0.5711986642890533) q[1]; // inplace_rot
gphase(-0.241660973353061);
p(0.483321946706122) q[1];
ry(0.8567979964335799) q[2]; // inplace_rot
gphase(-0.36249146002959154);
p(0.7249829200591831) q[2];
ry(1.1423973285781066) q[3]; // inplace_rot
gphase(-0.483321946706122);
p(0.966643893412244) q[3];
ry(1.4279966607226333) q[4]; // inplace_rot
gphase(-0.6041524333826526);
p(1.2083048667653051) q[4];
h q[4]; // inplace_h
// BEGIN dup
h q[5];
t q[5];
cx q[3], q[5];
inv @ t q[5];
cx q[4], q[5];
t q[5];
cx q[3], q[5];
inv @ t q[5];
h q[5];
// END dup
p(1.5707963267948966) q[5];
// BEGIN dup
s q[6];
h q[6];
cx q[4], q[6];
t q[6];
cx q[3], q[6];
inv @ t q[6];
cx q[4], q[6];
t q[6];
cx q[3], q[6];
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
cx q[4], q[6];
t q[6];
cx q[5], q[6];
inv @ t q[6];
cx q[4], q[6];
h q[6];
sdg q[6];
// END undup
// BEGIN undup
h q[5];
t q[5];
cx q[3], q[5];
inv @ t q[5];
cx q[4], q[5];
t q[5];
cx q[3], q[5];
inv @ t q[5];
h q[5];
// END undup
// BEGIN dup
h q[5];
t q[5];
cx q[2], q[5];
inv @ t q[5];
cx q[4], q[5];
t q[5];
cx q[2], q[5];
inv @ t q[5];
h q[5];
// END dup
p(0.7853981633974483) q[5];
// BEGIN dup
s q[6];
h q[6];
cx q[4], q[6];
t q[6];
cx q[2], q[6];
inv @ t q[6];
cx q[4], q[6];
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
cx q[4], q[6];
t q[6];
cx q[5], q[6];
inv @ t q[6];
cx q[4], q[6];
h q[6];
sdg q[6];
// END undup
// BEGIN undup
h q[5];
t q[5];
cx q[2], q[5];
inv @ t q[5];
cx q[4], q[5];
t q[5];
cx q[2], q[5];
inv @ t q[5];
h q[5];
// END undup
// BEGIN dup
h q[5];
t q[5];
cx q[1], q[5];
inv @ t q[5];
cx q[4], q[5];
t q[5];
cx q[1], q[5];
inv @ t q[5];
h q[5];
// END dup
p(0.39269908169872414) q[5];
// BEGIN dup
s q[6];
h q[6];
cx q[4], q[6];
t q[6];
cx q[1], q[6];
inv @ t q[6];
cx q[4], q[6];
t q[6];
cx q[1], q[6];
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
cx q[4], q[6];
t q[6];
cx q[5], q[6];
inv @ t q[6];
cx q[4], q[6];
h q[6];
sdg q[6];
// END undup
// BEGIN undup
h q[5];
t q[5];
cx q[1], q[5];
inv @ t q[5];
cx q[4], q[5];
t q[5];
cx q[1], q[5];
inv @ t q[5];
h q[5];
// END undup
// BEGIN dup
h q[5];
t q[5];
cx q[0], q[5];
inv @ t q[5];
cx q[4], q[5];
t q[5];
cx q[0], q[5];
inv @ t q[5];
h q[5];
// END dup
p(0.19634954084936207) q[5];
// BEGIN dup
s q[6];
h q[6];
cx q[4], q[6];
t q[6];
cx q[0], q[6];
inv @ t q[6];
cx q[4], q[6];
t q[6];
cx q[0], q[6];
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
cx q[4], q[6];
t q[6];
cx q[5], q[6];
inv @ t q[6];
cx q[4], q[6];
h q[6];
sdg q[6];
// END undup
// BEGIN undup
h q[5];
t q[5];
cx q[0], q[5];
inv @ t q[5];
cx q[4], q[5];
t q[5];
cx q[0], q[5];
inv @ t q[5];
h q[5];
// END undup
h q[3]; // inplace_h
// BEGIN dup
h q[5];
t q[5];
cx q[2], q[5];
inv @ t q[5];
cx q[3], q[5];
t q[5];
cx q[2], q[5];
inv @ t q[5];
h q[5];
// END dup
p(1.5707963267948966) q[5];
// BEGIN dup
s q[6];
h q[6];
cx q[3], q[6];
t q[6];
cx q[2], q[6];
inv @ t q[6];
cx q[3], q[6];
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
cx q[3], q[6];
t q[6];
cx q[5], q[6];
inv @ t q[6];
cx q[3], q[6];
h q[6];
sdg q[6];
// END undup
// BEGIN undup
h q[5];
t q[5];
cx q[2], q[5];
inv @ t q[5];
cx q[3], q[5];
t q[5];
cx q[2], q[5];
inv @ t q[5];
h q[5];
// END undup
// BEGIN dup
h q[5];
t q[5];
cx q[1], q[5];
inv @ t q[5];
cx q[3], q[5];
t q[5];
cx q[1], q[5];
inv @ t q[5];
h q[5];
// END dup
p(0.7853981633974483) q[5];
// BEGIN dup
s q[6];
h q[6];
cx q[3], q[6];
t q[6];
cx q[1], q[6];
inv @ t q[6];
cx q[3], q[6];
t q[6];
cx q[1], q[6];
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
cx q[3], q[6];
t q[6];
cx q[5], q[6];
inv @ t q[6];
cx q[3], q[6];
h q[6];
sdg q[6];
// END undup
// BEGIN undup
h q[5];
t q[5];
cx q[1], q[5];
inv @ t q[5];
cx q[3], q[5];
t q[5];
cx q[1], q[5];
inv @ t q[5];
h q[5];
// END undup
// BEGIN dup
h q[5];
t q[5];
cx q[0], q[5];
inv @ t q[5];
cx q[3], q[5];
t q[5];
cx q[0], q[5];
inv @ t q[5];
h q[5];
// END dup
p(0.39269908169872414) q[5];
// BEGIN dup
s q[6];
h q[6];
cx q[3], q[6];
t q[6];
cx q[0], q[6];
inv @ t q[6];
cx q[3], q[6];
t q[6];
cx q[0], q[6];
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
cx q[3], q[6];
t q[6];
cx q[5], q[6];
inv @ t q[6];
cx q[3], q[6];
h q[6];
sdg q[6];
// END undup
// BEGIN undup
h q[5];
t q[5];
cx q[0], q[5];
inv @ t q[5];
cx q[3], q[5];
t q[5];
cx q[0], q[5];
inv @ t q[5];
h q[5];
// END undup
h q[2]; // inplace_h
// BEGIN dup
h q[5];
t q[5];
cx q[1], q[5];
inv @ t q[5];
cx q[2], q[5];
t q[5];
cx q[1], q[5];
inv @ t q[5];
h q[5];
// END dup
p(1.5707963267948966) q[5];
// BEGIN dup
s q[6];
h q[6];
cx q[2], q[6];
t q[6];
cx q[1], q[6];
inv @ t q[6];
cx q[2], q[6];
t q[6];
cx q[1], q[6];
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
cx q[2], q[6];
t q[6];
cx q[5], q[6];
inv @ t q[6];
cx q[2], q[6];
h q[6];
sdg q[6];
// END undup
// BEGIN undup
h q[5];
t q[5];
cx q[1], q[5];
inv @ t q[5];
cx q[2], q[5];
t q[5];
cx q[1], q[5];
inv @ t q[5];
h q[5];
// END undup
// BEGIN dup
h q[5];
t q[5];
cx q[0], q[5];
inv @ t q[5];
cx q[2], q[5];
t q[5];
cx q[0], q[5];
inv @ t q[5];
h q[5];
// END dup
p(0.7853981633974483) q[5];
// BEGIN dup
s q[6];
h q[6];
cx q[2], q[6];
t q[6];
cx q[0], q[6];
inv @ t q[6];
cx q[2], q[6];
t q[6];
cx q[0], q[6];
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
cx q[2], q[6];
t q[6];
cx q[5], q[6];
inv @ t q[6];
cx q[2], q[6];
h q[6];
sdg q[6];
// END undup
// BEGIN undup
h q[5];
t q[5];
cx q[0], q[5];
inv @ t q[5];
cx q[2], q[5];
t q[5];
cx q[0], q[5];
inv @ t q[5];
h q[5];
// END undup
h q[1]; // inplace_h
// BEGIN dup
h q[5];
t q[5];
cx q[0], q[5];
inv @ t q[5];
cx q[1], q[5];
t q[5];
cx q[0], q[5];
inv @ t q[5];
h q[5];
// END dup
p(1.5707963267948966) q[5];
// BEGIN dup
s q[6];
h q[6];
cx q[1], q[6];
t q[6];
cx q[0], q[6];
inv @ t q[6];
cx q[1], q[6];
t q[6];
cx q[0], q[6];
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
cx q[1], q[6];
t q[6];
cx q[5], q[6];
inv @ t q[6];
cx q[1], q[6];
h q[6];
sdg q[6];
// END undup
// BEGIN undup
h q[5];
t q[5];
cx q[0], q[5];
inv @ t q[5];
cx q[1], q[5];
t q[5];
cx q[0], q[5];
inv @ t q[5];
h q[5];
// END undup
h q[0]; // inplace_h
swap q[0], q[4];
swap q[1], q[3];

