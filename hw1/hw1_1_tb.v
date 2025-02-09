`timescale 1ns / 1ps

module hw1_1_tb();
reg A,B,C,D,E,F,G;
wire O;
hw1_1 test(A,B,C,D,E,F,G,O);
integer i=0;
initial
begin
    A=1'b0;B=1'b0;C=1'b0;D=1'b0;E=1'b0;F=1'b0;G=1'b0;#10;
    if (O!==1'b1) begin $display("Test 1 failed");i=i+1;end
    
    A=1'b0;B=1'b0;C=1'b0;D=1'b0;E=1'b0;F=1'b0;G=1'b1;#10;
    if (O!==1'b0) begin $display("Test 2 failed");i=i+1;end

    A=1'b0;B=1'b0;C=1'b0;D=1'b0;E=1'b0;F=1'b0;G=1'b0;#10;
    if (O!==1'b1) begin $display("Test 3 failed");i=i+1;end

    A=1'b0;B=1'b0;C=1'b0;D=1'b0;E=1'b1;F=1'b1;G=1'b0;#10;
    if (O!==1'b0) begin $display("Test 4 failed");i=i+1;end

    A=1'b1;B=1'b1;C=1'b0;D=1'b0;E=1'b0;F=1'b0;G=1'b1;#10;
    if (O!==1'b1) begin $display("Test 5 failed");i=i+1;end
    if (i==0)
            $display("All tests passed");
   
$finish;
end


endmodule
