//do not modify this module
module shooting(
    input clk,rst,
    input right0,
    input left0,
    input right1,
    input left1,
    input att,
    output [15:0]ar,
    output [6:0]num
    );
    wire clk_div, clk_div0 , clk_div1;
    
    control_and_bullet s1(
    .clk    (clk_div0),
    .clk0   (clk_div),
    .clk1   (clk_div1),
	.left0    (left0),
	.left1    (left1),
	.right0	(right0),
	.right1	(right1),
	.att    (att),
    .out    (ar),
    .num    (num)
    );
    
    clk_div clk_div_1(
    .clk    (clk),
    .rst    (rst),
    .clk_div    (clk_div)
    );
    
    clk_div0 clk_div_0(
    .clk    (clk),
    .rst    (rst),
    .clk_div0    (clk_div0)
    );
    
    clk_div1 clk_div_2(
    .clk    (clk),
    .rst    (rst),
    .clk_div1    (clk_div1)
    );
    
endmodule

module clk_div(
	input clk,
	input rst,
	output clk_div
);
	reg clk_div;
	reg [25:0] cnt;

	always@(posedge clk or posedge rst)
	begin
		if (rst)
			cnt <= 26'd0;
		else if (cnt == 40-1)
			cnt <= 26'd0;
		else
			cnt <= cnt + 1;
	end

	always@(posedge clk or posedge rst)
	begin
		if (rst)
			clk_div <= 1'b0;
		else if (cnt == 0)
			clk_div <= ~clk_div;
	    else if (cnt == 20-1)
			clk_div <= ~clk_div;
	end

endmodule

module clk_div0(
	input clk,
	input rst,
	output clk_div0
);
	reg clk_div0;
	reg [25:0] cnt0;

	always@(posedge clk or posedge rst)
	begin
		if (rst)
			cnt0 <= 26'd0;
		else if (cnt0 == 4-1)
			cnt0 <= 26'd0;
		else
			cnt0 <= cnt0 + 1;
    end
	always@(posedge clk or posedge rst)
	begin
		if (rst)
			clk_div0 <= 1'b0;
		else if (cnt0 == 2-1)
			clk_div0 <= ~clk_div0;
	end

endmodule

module clk_div1(
	input clk,
	input rst,
	output clk_div1
);
	reg clk_div1;
	reg [25:0] cnt;

	always@(posedge clk or posedge rst)
	begin
		if (rst)
			cnt <= 26'd0;
		else if (cnt == 80-1)
			cnt <= 26'd0;
		else
			cnt <= cnt + 1;
	end

	always@(posedge clk or posedge rst)
	begin
		if (rst)
			clk_div1 <= 1'b0;
		else if (cnt == 0)
			clk_div1 <= ~clk_div1;
	    else if (cnt == 40-1)
			clk_div1 <= ~clk_div1;
	end

endmodule

module control_and_bullet(
    input clk,
    input clk0,
    input clk1,
    input left0,
    input left1,
    input right0,
    input right1,
    input att,
    output reg [15:0]out, 
    output reg [6:0]num
);
    reg [3:0] point;
    reg [2:0] state;
    reg [2:0] udstate;
    reg [2:0] udstate0;
    reg [7:0] R [0:7];
//    reg [2:0] udstate;
    initial begin
        out[15:8] = 8'b00001000; 
        out[7:0] = 8'b11111110;  
        num[6:0] = 7'b1111111;
        R[0] = 8'b11000111;
        R[1] = 8'b11101111;//
        R[2] = 8'b11111111;
        R[3] = 8'b11111111;
        R[4] = 8'b11111111;
        R[5] = 8'b11111111;
        R[6] = 8'b11111111;
        R[7] = 8'b11101111;//
        point <= 4'b0000;
        state <= 3'b000;
        udstate <= 3'b000;
        udstate0 <= 3'b000;
//        udstate <= 3'b000;
    end
    
    always @(posedge clk0) begin
        if(right0) begin
            if(R[0] == 8'b11111000) begin
                R[0] <= R[0];
                R[1] <= R[1];
            end
            else begin
                R[0] <= {1'b1, R[0][7:1]};
                R[1] <= {1'b1, R[1][7:1]};
            end
        end
        else if(left0) begin
            if(R[0] == 8'b00011111) begin
                R[0] <= R[0];
                R[1] <= R[1];
            end
            else begin
                R[0] <= {R[0][6:0], 1'b1};
                R[1] <= {R[1][6:0], 1'b1};
            end
        end

        if(right1) begin
            if(R[7] == 8'b11111110) begin
                R[7] <= R[7];
            end
            else begin
                R[7] <= {1'b1, R[7][7:1]};
            end
        end
        else if(left1) begin
            if(R[7] == 8'b01111111) begin
                R[7] <= R[7];
            end
            else begin
                R[7] <= {R[7][6:0], 1'b1};
            end
        end
        if(att) begin
            R[2] <= R[1];
        end
        else begin
            R[2] <= 8'b11111111;
        end

    end
    
    always @(posedge clk1) begin
        R[6] <= R[5];
        R[5] <= R[4];
        R[4] <= R[3];
        R[3] <= R[2];
        
        if(R[7] == R[6]) begin
            if (point == 4'b1001) begin
                point <= 4'b0000;
            end
            else begin
                point <= point +1;
            end
        end
        
    end
    
    always @(posedge clk) begin
        case(state)
            3'b000:begin//right
                out[15:8] = 8'b10000000; 
                out[7:0] = R[0]; 
                state <= 3'b001; 
            end
            
            3'b001:begin//right
                out[15:8] = 8'b01000000; 
                out[7:0] = R[1]; 
                state <= 3'b010; 
            end
      
            3'b010:begin//right
                out[15:8] = 8'b00100000; 
                out[7:0] = R[2]; 
                state <= 3'b011; 
            end
            
            3'b011:begin//right
                out[15:8] = 8'b00010000; 
                out[7:0] = R[3]; 
                state <= 3'b100; 
            end
            
            3'b100:begin//right
                out[15:8] = 8'b00001000; 
                out[7:0] = R[4]; 
                state <= 3'b101; 
            end
            
            3'b101:begin//right
                out[15:8] = 8'b00000100; 
                out[7:0] = R[5]; 
                state <= 3'b110; 
            end
            
            3'b110:begin//right
                out[15:8] = 8'b00000010; 
                out[7:0] = R[6]; 
                state <= 3'b111; 
            end
            3'b111:begin//right
                out[15:8] = 8'b00000001; 
                out[7:0] = R[7]; 
                state <= 3'b000; 
            end            
            
            
            default: state <= 3'b000;
        endcase       
        case(point)
            4'b0000:begin
                num[6:0] <= 7'b1111110;
            end
            4'b0001:begin
                num[6:0] <= 7'b0110000;
            end
            4'b0010:begin
                num[6:0] <= 7'b1101101;
            end
            4'b0011:begin
                num[6:0] <= 7'b1111001;
            end
            4'b0100:begin
                num[6:0] <= 7'b0110011;
            end
            4'b0101:begin
                num[6:0] <= 7'b1011011;
            end
            4'b0110:begin
                num[6:0] <= 7'b1011111;
            end
            4'b0111:begin
                num[6:0] <= 7'b1110010;
            end
            4'b1000:begin
                num[6:0] <= 7'b1111111;
            end
            4'b1001:begin
                num[6:0] <= 7'b1111011;
            end
            default num[6:0] <= 7'b1111110;
        endcase
    end


endmodule