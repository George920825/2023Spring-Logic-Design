module hw1_3
( //set input and output of hw1_3
input D0, D1, S, // inputs
output Y // outputs
);
wire w1, w2, w3; // wire

not gate1(w1, S); // w1 = ~S
and gate2(w2, w1, D0); // w2 = w1 and D0
and gate3(w3, S, D1); // w3 = S and D1
or gate4(Y, w2, w3); // Y = w2 or w3
endmodule