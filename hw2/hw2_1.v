//module hw2_1(
//    input [2:0] R, 
//    input L,
//    input clk,
//    output [2:0] Qout
//);
//wire w0;
//DM i0(clk, Qout[2], R[0], L, Qout[0]);
//DM i1(clk, Qout[0], R[1], L, Qout[1]);
//xor gate0(w0, Qout[1], Qout[2]);
//DM i2(clk, w0, R[2], L, Qout[2]);
//endmodule

//module DM(
//    input clk, I0, I1, L,
//    output reg Q = 0
//);
//reg w0;
//always@(*)
//    if(L == 1'b1)
//        w0 = I1;
//    else
//        w0 = I0;
//always@(posedge clk)
//    Q <= w0;
//endmodule



// module hw2_1(
//     input [2:0] R, 
//     input L,
//     input clk,
//     output [2:0] Qout
// );
// wire w0;
// DM i0(clk, Qout[2], R[0], L, Qout[0]);
// DM i1(clk, Qout[0], R[1], L, Qout[1]);
// xor gate0(w0, Qout[1], Qout[2]);
// DM i2(clk, w0, R[2], L, Qout[2]);
// endmodule

// module DM(
//     input clk, I0, I1, L,
//     output Q
// );
// wire w0;
// MUX i0(I0, I1, L, w0);
// DFF i1(clk, w0, Q);
// endmodule

// module MUX(
//     input I0, I1, A,
//     output reg F
// );
// always@(*)
//     if(A)
//         F <= I1;
//     else
//         F <= I0;
// endmodule

// module DFF(
//     input clk, D,
//     output Q
// );
// reg tQ = 1'b0;
// always@(posedge clk)begin
//     tQ <= D;
// end
// assign Q = tQ;
// endmodule



module hw2_1(
    input [2:0] R, 
    input L,
    input clk,
    output [2:0] Qout
);
wire w0;
DM i0(clk, Qout[2], R[0], L, Qout[0]);
DM i1(clk, Qout[0], R[1], L, Qout[1]);
xor gate0(w0, Qout[1], Qout[2]);
DM i2(clk, w0, R[2], L, Qout[2]);
endmodule
// module putting multiplexer and D-flip-flop together
module DM(
    input clk, A, B, L,
    output C
);
wire w1;
MUX i0(A, B, L, w1);
DFF i1(clk, w1, C);
endmodule
// module of multiplexer
module MUX(
    input A, B, C,
    output O
);
//in behavior level
//always @(*) begin
//    if (C) O = B;
//    else O = A;
//end
//or write in dataflow level
assign O = C ? B : A; //if C is 1, assign O = B, else assign O = A (C = 0)
endmodule
//module of D flip-flop
module DFF(
    input clk, D,
    output reg Q = 0 //set as reg for assign value in always block
);
always @(posedge clk) begin// monitor the positive edge of clk signal
    Q <= D;// assign D to Q
end
endmodule