`timescale 1 ns/1 ns

// module hw2_2(clk, reset, data_in, c, data_out);
// input clk, reset;
// input[7:0] data_in;
// input[8:0] c;
// output[7:0] data_out;
// wire [7:0] w0, w1, w2, w3, w4, w5, w6;
// reg [7:0] r0, r1, r2, r_out = 8'h00;

// MUX i0(r0, r1, r2, data_in, c[4:3], w0);
// MUX i1(r0, r1, r2, data_in, c[6:5], w1);
// ALU i2(w0, w1, c[2:0], w2);
// DEMUX i3(w2, c[8:7], w3, w4, w5, w6);
// // DEMUX i3(w2, c[8:7], clk, r0, r1, r2, r_out);
// // always @(negedge reset) begin
// //     {r0, r1, r2, r_out} <= {32'h00};
// // end
// always @(posedge clk or negedge reset) begin
//    if(~reset)
//        {r0, r1, r2, r_out} <= {32'h00};
//    else if(c[8:7]==2'b00)
//        r0 <= w3;
//    else if(c[8:7]==2'b01)
//        r1 <= w4;
//    else if(c[8:7]==2'b10)
//        r2 <= w5;
//    else if(c[8:7]==2'b11)
//        r_out <= w6;
// //    else
// //        r0 <= w3;
// //        r1 <= w4;
// //        r2 <= w5;
// //        r_out <= w6;
// end
// assign data_out = r_out;
// endmodule


// create module for hw2_2
module hw2_2(clk, reset, data_in, c, data_out);
input clk, reset;
input[7:0] data_in;
input[8:0] c;
output[7:0] data_out;
wire [7:0] w0, w1, w2, w3, w4, w5, w6;// set wire
reg [7:0] r0, r1, r2, r_out; //= 8'h00;// set reg
// submodules
MUX i0(r0, r1, r2, data_in, c[4:3], w0);
MUX i1(r0, r1, r2, data_in, c[6:5], w1);
ALU i2(w0, w1, c[2:0], w2);
// DEMUX i3(w2, c[8:7], w3, w4, w5, w6);// can't use
// demux is here for fixing the bug and well done!
// solving the problem of reg can't be put into output of a submodule
// putting the reset and register changing by demux together to simplfy the code
always @(posedge clk or negedge reset) begin
   if(~reset)// reset reg to 8'h00
       {r0, r1, r2, r_out} <= {32'h00};
   // demux
   else if(c[8:7]==2'b00)
       r0 <= w2;
   else if(c[8:7]==2'b01)
       r1 <= w2;
   else if(c[8:7]==2'b10)
       r2 <= w2;
   else if(c[8:7]==2'b11)
       r_out <= w2;
end
assign data_out = r_out;// assign r_out to data_out
endmodule
// module of multiplexer
module MUX(I0, I1, I2, I3, C, O);
input [7:0] I0, I1, I2, I3;
input [1:0] C;
output reg [7:0] O;// set register for assign in always
always@(I0 or I1 or I2 or I3 or C) begin
// case for choosing the output of multiplexer
    case (C)
        2'h0: O = I0;
        2'h1: O = I1;
        2'h2: O = I2;
        2'h3: O = I3;
    endcase
end
endmodule
// module of ALU
module ALU(A, B, C, O);
input [7:0] A, B;
input [2:0] C;
output reg [7:0] O;
// case for choosing the operator between two input
always@(A or B or C) begin
    case (C)
        3'h0: O = A;
        3'h1: O = A+B;
        3'h2: O = A-B;
        3'h3: O = A&B;
        3'h4: O = A|B;
        3'h5: O = A^B;
    endcase
end
endmodule

// module DEMUX(I, C, clk, O0, O1, O2, O3);
// input [7:0] I;
// input [1:0] C;
// input clk;
// output reg [7:0] O0, O1, O2, O3;
// always@(posedge clk) begin
//     case (C)
//         2'h0: O0 = I;
//         2'h1: O1 = I;
//         2'h2: O2 = I;
//         2'h3: O3 = I;
//     endcase
// end
// endmodule
//module DEMUX(I, C, O0, O1, O2, O3);
//input [7:0] I;
//input [1:0] C;
//output reg [7:0] O0, O1, O2, O3;
//always@(I or C) begin
//   case (C)
//       2'h0: O0 = I;
//       2'h1: O1 = I;
//       2'h2: O2 = I;
//       2'h3: O3 = I;
//   endcase
//end
//endmodule