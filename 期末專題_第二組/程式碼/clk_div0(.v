module clk_div0(
	input clk,    // input clk signal from board
	input rst,    
	output clk_div0 
);
	reg clk_div0;       
	reg [25:0] cnt0;    

	always@(posedge clk or posedge rst)
	begin
		if (rst)
			cnt0 <= 26'd0;                  
		else if (cnt0 == 10000-1)//10000 means clk change super fast that eyes can't see 
			cnt0 <= 26'd0;                  
		else
			cnt0 <= cnt0 + 1;              
	end

	always@(posedge clk or posedge rst)
	begin
		if (rst)
			clk_div0 <= 1'b0;                
		else if (cnt0 == 5000-1)//half time of the clk change from 1 to 0
			clk_div0 <= ~clk_div0;            
	end

endmodule

