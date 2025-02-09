module hw2_3(
    input clk,
    input areset, 
    input turn_left,
    input turn_right,
    input ground,
    output reg walk_left,
    output reg walk_right,
    output reg aaah);
// state define
parameter S0 = 2'b00;
parameter S1 = 2'b01;
parameter S2 = 2'b10;
reg [1:0]state,next;
// wire [2:0]in;
reg [2:0]out = 3'b100;
reg past = 0;// save the past state, 0: left, 1: right
// simplfy the output of state
// assign in = {turn_left, turn_right, ground};
// state reg
always @(posedge clk or posedge areset) begin
    if (areset) state <= S0;
    else state <= next;
end
// output logic
always @(*) begin
    case (state)
        S0: out = 3'b100;
        S1: out = 3'b010;
        S2: out = 3'b001;
    endcase
end
// next state logic
always @(*) begin
    case (state)
        S0: if(ground == 0) begin next = S2; past = 0; end
            else if(turn_right == 1) next = S1;
            else next = S0;
        S1: if(ground == 0) begin next = S2; past = 1; end
            else if(turn_left == 1) next = S0;
            else next = S1;
        S2: if(ground == 0) next = S2;
            else if(past == 0) next = S0;
            else next = S1;
    endcase
end
// output assign
always @(*) begin
    walk_left = out[2];
    walk_right = out[1];
    aaah = out[0];
end
endmodule

//module hw2_3(
//    input clk,
//    input areset, 
//    input turn_left,
//    input turn_right,
//    input ground,
//    output reg walk_left,
//    output reg walk_right,
//    output reg aaah);
//parameter S0 = 2'b00;
//parameter S1 = 2'b01;
//parameter S2 = 2'b10;
//reg [1:0]state,next;
//wire [2:0]in;
//reg [2:0]out = 3'b100;
//reg past = 0;
//reg return = 1;
//assign in = {turn_left, turn_right, ground};
//always @(posedge clk or posedge areset) begin
//    if (areset) state <= S0;
//    else state <= next;
//end
//always @(*) begin
//    case (state)
//        S0: out = 3'b100;
//        S1: out = 3'b010;
//        S2: out = 3'b001;
//    endcase
//end
//always @(*) begin
//    case (state)
//        S0: if(ground == 0) begin next = S2; past = 0; end
//            else if(turn_right == 1 & turn_left == 1 & return == 0) next = S0;
//            else if(turn_right == 1 & turn_left == 1) begin next = S1; return = 0; end
//            else if(turn_right == 1) begin next = S1; return = 1; end
//            else begin next = S0; return = 1; end
//        S1: if(ground == 0) begin next = S2; past = 1; end
//            else if(turn_right == 1 & turn_left == 1 & return == 0) next = S1;
//            else if(turn_right == 1 & turn_left == 1) begin next = S0; return = 0; end
//            else if(turn_left == 1) begin next = S0; return = 1; end
//            else begin next = S1; return = 1; end
//        S2: if(ground == 0) next = S2;
//            else if(past == 0) next = S0;
//            else next = S1;
//    endcase
//end
//always @(*) begin
//    walk_left = out[2];
//    walk_right = out[1];
//    aaah = out[0];
//end
//endmodule