`timescale 1ns/1ns

module hw2_2_tb();
reg clk;
reg reset;
reg[7:0] data_in;
reg[8:0] c;
wire[7:0] data_out;

hw2_2 test(.clk(clk),.reset(reset),.data_in(data_in),.c(c),.data_out(data_out));

 initial
 begin
   clk= 1;	           // Time = 0
 end
 always 
 begin
	#25  clk= ~clk;
 end

 initial
 begin
   reset= 1'b0;	              // Time = 0
   c= 9'h1f8;	              // nop
   data_in= 8'h00;
   #125;		              // Time = 125
   reset= 1'b1;
   #28;		              // Time = 153
   c= 9'h018;	              // mov r0, data_in
   data_in= 8'h03;
   #50;		              // Time = 203
   c= 9'h098;                       // mov r1, data_in
   data_in= 8'h05;
   #50;           	              // Time = 253
   c= 9'h121;	              // add r2, r0, r1
   #50;		              // Time = 303
   c= 9'h042;	              // sub r0, r0, r2
   #50;		              // Time = 353
   c= 9'h093;                       // and r1, r2, r0
   #50;     	              // Time = 403
   c= 9'h124;	              // or  r2, r0, r1
   #50;		          // Time = 453
   c= 9'h035;	          // xor r0, r2, r1
   #50;		          // Time = 503
   c= 9'h180;	          // mov data_out, r0
   #50;	                          // Time = 553
   c= 9'h188;	          // mov data_out, r1
   #50;		          // Time = 603
   c= 9'h190;	          // mov data_out, r2
 end

 endmodule