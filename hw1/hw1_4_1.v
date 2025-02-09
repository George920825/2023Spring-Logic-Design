module hw1_4_1
(
input [3:0] bcd,
output [6:0] seg
);

a instance0(bcd[3], bcd[2], bcd[1], bcd[0], seg[0]);
b instance1(bcd[3], bcd[2], bcd[1], bcd[0], seg[1]);
c instance2(bcd[3], bcd[2], bcd[1], bcd[0], seg[2]);
d instance3(bcd[3], bcd[2], bcd[1], bcd[0], seg[3]);
e instance4(bcd[3], bcd[2], bcd[1], bcd[0], seg[4]);
f instance5(bcd[3], bcd[2], bcd[1], bcd[0], seg[5]);
g instance6(bcd[3], bcd[2], bcd[1], bcd[0], seg[6]);
endmodule

module a
(
input D, C, B, A,
output seg
);
wire w1, w2, w3;

d_1 instance0(D, C, B, A, w1);
d_4 instance1(D, C, B, A, w2);
d_6 instance2(D, C, B, A, w3);
or gate0(seg, w1, w2, w3);
endmodule

module b
(
input D, C, B, A,
output seg
);
wire w1, w2;

d_5 instance0(D, C, B, A, w1);
d_6 instance1(D, C, B, A, w2);
or gate0(seg, w1, w2);
endmodule

module c
(
input D, C, B, A,
output seg
);
d_2 instance0(D, C, B, A, seg);
endmodule

module d
(
input D, C, B, A,
output seg
);
wire w1, w2, w3, w4;

d_1 instance0(D, C, B, A, w1);
d_4 instance1(D, C, B, A, w2);
d_7 instance2(D, C, B, A, w3);
d_9 instance3(D, C, B, A, w4);
or gate0(seg, w1, w2, w3, w4);
endmodule

module e
(
input D, C, B, A,
output seg
);
wire w1, w2, w3, w4, w5, w6;

d_1 instance0(D, C, B, A, w1);
d_3 instance1(D, C, B, A, w2);
d_4 instance2(D, C, B, A, w3);
d_5 instance3(D, C, B, A, w4);
d_7 instance4(D, C, B, A, w5);
d_9 instance5(D, C, B, A, w6);
or gate0(seg, w1, w2, w3, w4, w5, w6);
endmodule

module f
(
input D, C, B, A,
output seg
);
wire w1, w2, w3, w4;

d_1 instance0(D, C, B, A, w1);
d_2 instance1(D, C, B, A, w2);
d_3 instance2(D, C, B, A, w3);
d_7 instance3(D, C, B, A, w4);
or gate0(seg, w1, w2, w3, w4);
endmodule

module g
(
input D, C, B, A,
output seg
);
wire w1, w2, w3;

d_0 instance0(D, C, B, A, w1);
d_1 instance1(D, C, B, A, w2);
d_7 instance2(D, C, B, A, w3);
or gate0(seg, w1, w2, w3);
endmodule

module d_0
(
input D, C, B, A,
output d0
);
nor gate1(d0, A, B, C, D);
endmodule

module d_1
(
input D, C, B, A,
output d1
);
wire w1;
not gate1(w1, A);
nor gate2(d1, w1, B, C, D);
endmodule

module d_2
(
input D, C, B, A,
output d2
);
wire w1;
not gate1(w1, B);
nor gate2(d2, A, w1, C, D);
endmodule

module d_3
(
input D, C, B, A,
output d3
);
wire w1, w2;
not gate1(w1, A);
not gate2(w2, B);
nor gate3(d3, w1, w2, C, D);
endmodule

module d_4
(
input D, C, B, A,
output d4
);
wire w1;
not gate1(w1, C);
nor gate3(d4, A, B, w1, D);
endmodule

module d_5
(
input D, C, B, A,
output d5
);
wire w1, w2;
not gate1(w1, B);
not gate2(w2, D);
and gate3(d5, A, w1, C, w2);
endmodule

module d_6
(
input D, C, B, A,
output d6
);
wire w1, w2;
not gate1(w1, A);
not gate2(w2, D);
and gate3(d6, w1, B, C, w2);
endmodule

module d_7
(
input D, C, B, A,
output d7
);
wire w1;
not gate1(w1, D);
and gate2(d7, A, B, C, w1);
endmodule

module d_8
(
input D, C, B, A,
output d8
);
wire w1;
not gate1(w1, D);
nor gate2(d8, A, B, C, w1);
endmodule

module d_9
(
input D, C, B, A,
output d9
);
wire w1, w2;
not gate1(w1, B);
not gate2(w2, C);
and gate3(d9, A, w1, w2, D);
endmodule