`timescale 1ns / 1ns

module shooting_tb;

reg clk,rst,right0,left0,right1,left1,att;
wire [15:0]ar;
wire [6:0]num;

shooting m1(
    .clk(clk),
    .rst(rst),
    .right0(right0), 
    .left0(left0),
    .right1(right1), 
    .left1(left1),
    .att(att),
    .ar(ar),
    .num(num)
    );
    
    always begin 
        #1 clk=~clk;
    end

    initial begin
        clk=1;
        rst=0;
        right0=0;
        left0=0;
        right1=0;
        left1=0;
        att=0;
        #1
        rst=1;
        #1
        rst=0;
        #640
        right0=1;
        #320
        left1=1;
        #320
        right0=0;
        left1=0;
        #80
        left0=1;
        right1=1;
        #240
        left0=0;
        right1=0;
        att=1;
        #80
        att=0;
        #240
        att=1;
        #80
        right0=1;
        #640
        right0=0;       
        #80
        right1=1;
        #320
        right1=0;
        left0=1;
        #480
        left1=1;
        #400
        left1=0;
        #1000000000 $finish;  

    end
endmodule