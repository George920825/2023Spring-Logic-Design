module hw1_4
( // set input and output of hw1_4
input [3:0] bcd, // four-digit input of 8421-BCD
output [6:0] seg // seven-digit output of seven-segment display
);
 // judge the seven different segment signals one by one  
a instance0(bcd[3], bcd[2], bcd[1], bcd[0], seg[0]);
b instance1(bcd[3], bcd[2], bcd[1], bcd[0], seg[1]);
c instance2(bcd[3], bcd[2], bcd[1], bcd[0], seg[2]);
d instance3(bcd[3], bcd[2], bcd[1], bcd[0], seg[3]);
e instance4(bcd[3], bcd[2], bcd[1], bcd[0], seg[4]);
f instance5(bcd[3], bcd[2], bcd[1], bcd[0], seg[5]);
g instance6(bcd[3], bcd[2], bcd[1], bcd[0], seg[6]);
endmodule

module a
( // set input and output of module of a segment
input D, C, B, A,
output sega 
);
wire w1, w2, w3, w4, w5, w6;

not gate1(w1, D); // w1 = ~D
not gate2(w2, C); // w2 = ~C
not gate3(w3, B); // w3 = ~B
and gate4(w4, w1, w2, w3, A); // w4 = w1 and w2 and w3 and A
not gate5(w5, A); // w5 = ~A
and gate6(w6, C, w5); // w6 = C and w5
or gate7(sega, w4, w6); // sega = w4 or w6
endmodule

module b
( // set input and output of module of b segment
input D, C, B, A,
output segb 
);
wire w1, w2, w3, w4;

not gate1(w1, A); // w1 = ~A
and gate2(w2, C, B, w1); // w2 = C and B and w1
not gate3(w3, B); // w3 = ~B
and gate4(w4, C, w3, A); // w4 = C and w3 and A
or gate5(segb, w2, w4); // segb = w2 or w4
endmodule

module c
( // set input and output of module of c segment
input D, C, B, A,
output segc
);
wire w1, w2;

not gate1(w1, C); // w1 = ~C
not gate2(w2, A); // w2 = ~A
and gate3(segc, w1, B, w2); // segc = w1 and B and w2
endmodule

module d
( // set input and output of module of d segment
input D, C, B, A,
output segd
);
wire w1, w2, w3, w4, w5;
 // segd = C(B'A'+BA)+C'B'A
xnor gate1(w1, A, B);
and gate2(w2, C, w1);
not gate3(w3, C);
not gate4(w4, B);
and gate5(w5, w3, w4, A);
or gate6(segd, w2, w5);
endmodule

module e
( // set input and output of module of e segment
input D, C, B, A,
output sege 
);
wire w1, w2;
 // sege = A+CB'
not gate1(w1, B);
and gate2(w2, C, w1);
or gate3(sege, A, w2);
endmodule

module f
( // set input and output of module of f segment
input D, C, B, A,
output segf
);
wire w1, w2, w3, w4, w5;
 // segf = BA+D'C'(A+B)
and gate1(w1, B, A);
not gate2(w2, D);
not gate3(w3, C);
or gate4(w4, A, B);
and gate5(w5, w2, w3, w4);
or gate6(segf, w1, w5);
endmodule

module g(D,C,B,A,segg);
//(
//input D, C, B, A,
//output segg
//);
 // set input and output of module of a segment
input D,C,B,A;
output segg;
wire w1, w2, w3, w4;
 // segg = D'C'B'+CBA
not gate1(w1, D);
not gate2(w2, C);
not gate3(w3, B);
and gate4(w4, w1, w2, w3);
and gate5(w5, C, B, A);
or gate6(segg, w4, w5);
endmodule
