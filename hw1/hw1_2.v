module hw1_2
( //set input and output of hw1_2
input [3:0] A, B, // input of four bits A, B
input Cin,
output [3:0] S, // output of four bits S
output Cout
);
wire [2:0] C;

full_adder stage0(A[0], B[0], Cin, S[0], C[0]);
full_adder stage1(A[1], B[1], C[0], S[1], C[1]);
full_adder stage2(A[2], B[2], C[1], S[2], C[2]);
full_adder stage3(A[3], B[3], C[2], S[3], Cout);
endmodule

module full_adder
( //set input and output of full_adder
input A, B, Cin,
output S, Cout
);
wire w1, w2, w3;

xor gate1(S, A, B, Cin); // S = A xor B xor Cin
or gate2(w1, B, Cin); // w1 = B or Cin
and gate3(w2, B, Cin); // w2 = B and Cin
and gate4(w3, w1, A); // w3 = w1 and A
or gate5(Cout, w2, w3); // Cout = w2 or w3
endmodule