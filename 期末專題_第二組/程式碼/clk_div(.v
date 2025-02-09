module clk_div(
	input clk,    // input clk signal from board
	input rst,    
	output clk_div 
);
	reg clk_div;       
	reg [25:0] cnt;    

	always@(posedge clk or posedge rst)
	begin
		if (rst)
			cnt <= 26'd0;                  
		else if (cnt == 31250000-1)//31250000 means clk change about every half second
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
	    else if (cnt == 15625000-1)//half time of the clk change from 1 to 0
			clk_div <= ~clk_div;
	end

endmodule

