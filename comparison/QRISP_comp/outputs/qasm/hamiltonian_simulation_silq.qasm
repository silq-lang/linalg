include "stdgates.inc";
qubit[2] q;

ry(0.4487989505128276) q[0]; // inplace_rot
ry(0.3490658503988659) q[1]; // inplace_rot
cx q[0], q[1]; // inplace_x
gphase(0.014024967203525862);
p(-0.028049934407051724) q[1];
cx q[0], q[1]; // inplace_x
h q[0]; // inplace_h
gphase(-0.028049934407051724);
p(0.05609986881410345) q[0];
h q[0]; // inplace_h
h q[1]; // inplace_h
gphase(-0.028049934407051724);
p(0.05609986881410345) q[1];
h q[1]; // inplace_h
cx q[0], q[1]; // inplace_x
gphase(0.014024967203525862);
p(-0.028049934407051724) q[1];
cx q[0], q[1]; // inplace_x
h q[0]; // inplace_h
gphase(-0.028049934407051724);
p(0.05609986881410345) q[0];
h q[0]; // inplace_h
h q[1]; // inplace_h
gphase(-0.028049934407051724);
p(0.05609986881410345) q[1];
h q[1]; // inplace_h
cx q[0], q[1]; // inplace_x
gphase(0.014024967203525862);
p(-0.028049934407051724) q[1];
cx q[0], q[1]; // inplace_x
h q[0]; // inplace_h
gphase(-0.028049934407051724);
p(0.05609986881410345) q[0];
h q[0]; // inplace_h
h q[1]; // inplace_h
gphase(-0.028049934407051724);
p(0.05609986881410345) q[1];
h q[1]; // inplace_h
cx q[0], q[1]; // inplace_x
gphase(0.014024967203525862);
p(-0.028049934407051724) q[1];
cx q[0], q[1]; // inplace_x
h q[0]; // inplace_h
gphase(-0.028049934407051724);
p(0.05609986881410345) q[0];
h q[0]; // inplace_h
h q[1]; // inplace_h
gphase(-0.028049934407051724);
p(0.05609986881410345) q[1];
h q[1]; // inplace_h
cx q[0], q[1]; // inplace_x
gphase(0.014024967203525862);
p(-0.028049934407051724) q[1];
cx q[0], q[1]; // inplace_x
h q[0]; // inplace_h
gphase(-0.028049934407051724);
p(0.05609986881410345) q[0];
h q[0]; // inplace_h
h q[1]; // inplace_h
gphase(-0.028049934407051724);
p(0.05609986881410345) q[1];
h q[1]; // inplace_h
cx q[0], q[1]; // inplace_x
gphase(0.014024967203525862);
p(-0.028049934407051724) q[1];
cx q[0], q[1]; // inplace_x
h q[0]; // inplace_h
gphase(-0.028049934407051724);
p(0.05609986881410345) q[0];
h q[0]; // inplace_h
h q[1]; // inplace_h
gphase(-0.028049934407051724);
p(0.05609986881410345) q[1];
h q[1]; // inplace_h
cx q[0], q[1]; // inplace_x
gphase(0.014024967203525862);
p(-0.028049934407051724) q[1];
cx q[0], q[1]; // inplace_x
h q[0]; // inplace_h
gphase(-0.028049934407051724);
p(0.05609986881410345) q[0];
h q[0]; // inplace_h
h q[1]; // inplace_h
gphase(-0.028049934407051724);
p(0.05609986881410345) q[1];
h q[1]; // inplace_h
cx q[0], q[1]; // inplace_x
gphase(0.014024967203525862);
p(-0.028049934407051724) q[1];
cx q[0], q[1]; // inplace_x
h q[0]; // inplace_h
gphase(-0.028049934407051724);
p(0.05609986881410345) q[0];
h q[0]; // inplace_h
h q[1]; // inplace_h
gphase(-0.028049934407051724);
p(0.05609986881410345) q[1];
h q[1]; // inplace_h
cx q[0], q[1]; // inplace_x
gphase(0.014024967203525862);
p(-0.028049934407051724) q[1];
cx q[0], q[1]; // inplace_x
h q[0]; // inplace_h
gphase(-0.028049934407051724);
p(0.05609986881410345) q[0];
h q[0]; // inplace_h
h q[1]; // inplace_h
gphase(-0.028049934407051724);
p(0.05609986881410345) q[1];
h q[1]; // inplace_h
cx q[0], q[1]; // inplace_x
gphase(0.014024967203525862);
p(-0.028049934407051724) q[1];
cx q[0], q[1]; // inplace_x
h q[0]; // inplace_h
gphase(-0.028049934407051724);
p(0.05609986881410345) q[0];
h q[0]; // inplace_h
h q[1]; // inplace_h
gphase(-0.028049934407051724);
p(0.05609986881410345) q[1];
h q[1]; // inplace_h
cx q[0], q[1]; // inplace_x
gphase(0.014024967203525862);
p(-0.028049934407051724) q[1];
cx q[0], q[1]; // inplace_x
h q[0]; // inplace_h
gphase(-0.028049934407051724);
p(0.05609986881410345) q[0];
h q[0]; // inplace_h
h q[1]; // inplace_h
gphase(-0.028049934407051724);
p(0.05609986881410345) q[1];
h q[1]; // inplace_h
cx q[0], q[1]; // inplace_x
gphase(0.014024967203525862);
p(-0.028049934407051724) q[1];
cx q[0], q[1]; // inplace_x
h q[0]; // inplace_h
gphase(-0.028049934407051724);
p(0.05609986881410345) q[0];
h q[0]; // inplace_h
h q[1]; // inplace_h
gphase(-0.028049934407051724);
p(0.05609986881410345) q[1];
h q[1]; // inplace_h
cx q[0], q[1]; // inplace_x
gphase(0.014024967203525862);
p(-0.028049934407051724) q[1];
cx q[0], q[1]; // inplace_x
h q[0]; // inplace_h
gphase(-0.028049934407051724);
p(0.05609986881410345) q[0];
h q[0]; // inplace_h
h q[1]; // inplace_h
gphase(-0.028049934407051724);
p(0.05609986881410345) q[1];
h q[1]; // inplace_h
cx q[0], q[1]; // inplace_x
gphase(0.014024967203525862);
p(-0.028049934407051724) q[1];
cx q[0], q[1]; // inplace_x
h q[0]; // inplace_h
gphase(-0.028049934407051724);
p(0.05609986881410345) q[0];
h q[0]; // inplace_h
h q[1]; // inplace_h
gphase(-0.028049934407051724);
p(0.05609986881410345) q[1];
h q[1]; // inplace_h

