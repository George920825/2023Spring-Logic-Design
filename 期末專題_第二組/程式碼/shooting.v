module shooting(
    input   clk   ,//clk from board
    input   right0   ,//shooter right button
    input   left0   ,//shooter left button
    input   right1   ,//catcher right button
    input   left1   ,//catcher left button
    input   att,//shooter attack button
    output  [15:0] ar,//8x8 led matrix output
    output  [6:0]num//7-segment display output
    );
    
    wire    clk_div, clk_div0 , clk_div1;
    
    control_and_bullet s1(
    .clk    (clk_div0),// super fast clk for 8x8 led matrix
    .clk0   (clk_div),//fast clk for control button
    .clk1   (clk_div1),//slow clk for bullet and score
	.left0    (left0),
	.left1    (left1),
	.right0	(right0),
	.right1	(right1),
	.att    (att),
    .out    (ar),
    .num    (num)
    );
    
    clk_div clk_div_1( //slow clk for bullet and score
    .clk    (clk),
    .rst    (rst),
    .clk_div    (clk_div)
    );
    
    clk_div0 clk_div_0(  // super fast clk for 8x8 led matrix
    .clk    (clk),
    .rst    (rst),
    .clk_div0    (clk_div0)
    );
    
    clk_div1 clk_div_2( //fast clk for control button
    .clk    (clk),
    .rst    (rst),
    .clk_div1    (clk_div1)
    );
    
endmodule
