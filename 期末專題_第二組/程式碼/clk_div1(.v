module clk_div1(
	input clk,    // input clk signal from board
	input rst,    
	output clk_div1 
);
	reg clk_div1;       
	reg [25:0] cnt;   

	always@(posedge clk or posedge rst)
	begin
		if (rst)
			cnt <= 26'd0;                 
		else if (cnt == 93750000-1)//93750000 means clk change about every one and a half second
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
	    else if (cnt == 46875000-1)//half time of the clk change from 1 to 0
			clk_div1 <= ~clk_div1;
	end

endmodule

