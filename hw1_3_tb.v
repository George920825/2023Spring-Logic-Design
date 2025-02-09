`timescale 1ns / 1ps

module hw1_3_tb();
    reg D0, D1, S;
    wire Y;

    hw1_3 test(
        .D0(D0),
        .D1(D1),
        .S(S),
        .Y(Y)
    );
    integer i=0;
    initial begin
        D0 = 1'b0; D1 = 1'b1; S = 1'b0;#10;
        if (Y !== 1'b0)  begin $display("Test 1 failed");i=i+1;end

        D0 = 1'b1; D1 = 1'b0; S = 1'b0;#10;
        if (Y !== 1'b1)  begin $display("Test 2 failed");i=i+1;end

        D0 = 1'b0; D1 = 1'b0; S = 1'b1;#10;
        if (Y !== 1'b0)  begin $display("Test 3 failed");i=i+1;end

        D0 = 1'b1; D1 = 1'b1; S = 1'b1;#10;
        if (Y !== 1'b1)  begin $display("Test 4 failed");i=i+1;end

        if (i==0)
            $display("All tests passed");
        $finish;
    end
endmodule
