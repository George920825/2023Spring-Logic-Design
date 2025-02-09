`timescale 1ns / 1ps

module hw1_2_tb;

    reg [3:0] A, B;
    reg Cin;
    wire [3:0] S;
    wire Cout;
    
    hw1_2 test(
        .A(A),
        .B(B),
        .Cin(Cin),
        .S(S),
        .Cout(Cout)
    );
    
    integer i=0;
    initial begin
        
        A = 4'd3; B = 4'd5; Cin = 1'b0;#10;
        if (S !== 4'd8 || Cout !== 1'b0) begin $display("Test 1 failed");i=i+1;end
        
        A = 4'd9; B = 4'd2; Cin = 1'b1;#10;
        if (S !== 4'd12 || Cout !== 1'b0) begin $display("Test 2 failed");i=i+1;end
        
        A = 4'd15; B = 4'd15; Cin = 1'b1;#10;
        if (S !== 4'd15 || Cout !== 1'b1) begin $display("Test 3 failed");i=i+1;end
        
        A = 4'd0; B = 4'd0; Cin = 1'b0;#10;
        if (S !== 4'd0 || Cout !== 1'b0) begin $display("Test 4 failed");i=i+1;end
        
        A = 4'd7; B = 4'd1; Cin = 1'b1;#10;
        if (S !== 4'd9 || Cout !== 1'b0) begin $display("Test 5 failed");i=i+1;end
        
        if (i==0)
            $display("All tests passed");

        $finish;
    end
    
endmodule