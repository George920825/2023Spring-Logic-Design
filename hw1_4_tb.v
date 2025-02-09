`timescale 1ns / 1ns

module hw1_4_tb();

    reg [3:0] bcd;
    wire [6:0] seg; // seg[6] is g, seg[0] is a, etc.

    hw1_4 test(
        .bcd(bcd),
        .seg(seg)
    );
    integer i=0;
    initial begin
        bcd = 4'b0000; #10;
        if (seg!==7'd64) begin $display("Test 1 failed");i=i+1;end
        
        bcd = 4'b0010; #10;
        if (seg!==7'd36) begin $display("Test 2 failed");i=i+1;end

        bcd = 4'b0100; #10;
        if (seg!==7'd25) begin $display("Test 3 failed");i=i+1;end
        
        bcd = 4'b0110; #10;
        if (seg!==7'd3) begin $display("Test 4 failed");i=i+1;end
        
        bcd = 4'b1000; #10;
        if (seg!==7'd0) begin $display("Test 5 failed");i=i+1;end
        
        if (i==0)
            $display("All tests passed");
        $finish;
    end

endmodule
