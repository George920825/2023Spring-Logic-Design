module control_and_bullet(
    input clk,  //super fast clk for 8x8 led matrix
    input clk0, //fast clk for control button
    input clk1, //slow clk for bullet and score
    input left0,
    input left1,
    input right0,
    input right1,
    input att,
    output reg [15:0]out, 
    output reg [6:0]num
);
    reg [3:0] point; //state for showing the score on 7-segment monitor
    reg [2:0] state; // state for showing shooter&bullet&catcher on the 8x8 led matrix
    reg [7:0] R [0:7]; // state for edit the matrix picture
    initial begin
        out[15:8] = 8'b00001000; 
        out[7:0] = 8'b11111110;  
        num[6:0] = 7'b1111111;
        //start initial the matrix picture        
        R[0] = 8'b11000111;
        R[1] = 8'b11101111;
        R[2] = 8'b11111111;
        R[3] = 8'b11111111;
        R[4] = 8'b11111111;
        R[5] = 8'b11111111;
        R[6] = 8'b11111111;
        R[7] = 8'b11101111;
        //end initial the matrix picture        
        point <= 4'b0000;
        state <= 3'b000;
    end
    //the control of shooter and catcher
    always @(posedge clk0) begin
        //control of shooter
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
        //control of catcher
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
        //set how to shoot with the button att 
        if(att) begin
            R[2] <= R[1];
        end
        else begin
            R[2] <= 8'b11111111;
        end
    end
    //refresh the bullet position and point every 1.5 sec
    always @(posedge clk1) begin
        //the bullet position
        R[6] <= R[5];
        R[5] <= R[4];
        R[4] <= R[3];
        R[3] <= R[2];
        //point
        if(R[7] == R[6]) begin
            if (point == 4'b1001) begin
                point <= 4'b0000;
            end
            else begin
                point <= point +1;
            end
        end
 
    end
    //refresh the 8x8 led matrix and 7-segment monitor super fast
    always @(posedge clk) begin
        //8x8 led matrix
        case(state)
            3'b000:begin // define row0
                out[15:8] = 8'b10000000; 
                out[7:0] = R[0]; 
                state <= 3'b001; 
            end
            3'b001:begin// define row1
                out[15:8] = 8'b01000000; 
                out[7:0] = R[1]; 
                state <= 3'b010; 
            end
            3'b010:begin//define row2
                out[15:8] = 8'b00100000; 
                out[7:0] = R[2]; 
                state <= 3'b011; 
            end
            
            3'b011:begin// define row3
                out[15:8] = 8'b00010000; 
                out[7:0] = R[3]; 
                state <= 3'b100; 
            end
            
            3'b100:begin// define row4
                out[15:8] = 8'b00001000; 
                out[7:0] = R[4]; 
                state <= 3'b101; 
            end
            
            3'b101:begin//define row5
                out[15:8] = 8'b00000100; 
                out[7:0] = R[5]; 
                state <= 3'b110; 
            end
            
            3'b110:begin//define row6
                out[15:8] = 8'b00000010; 
                out[7:0] = R[6]; 
                state <= 3'b111; 
            end
            3'b111:begin//define row7
                out[15:8] = 8'b00000001; 
                out[7:0] = R[7]; 
                state <= 3'b000; 
            end            
            default: state <= 3'b000;
        endcase  
        // 7-segment monitor
        case(point)
            4'b0000:begin //define score 0 
                num[6:0] <= 7'b1111110;
            end
            4'b0001:begin //define score 1
                num[6:0] <= 7'b0110000;
            end
            4'b0010:begin //define score 2
                num[6:0] <= 7'b1101101;
            end
            4'b0011:begin //define score 3
                num[6:0] <= 7'b1111001;
            end
            4'b0100:begin //define score 4
                num[6:0] <= 7'b0110011;
            end
            4'b0101:begin //define score 5
                num[6:0] <= 7'b1011011;
            end
            4'b0110:begin //define score 6
                num[6:0] <= 7'b1011111;
            end
            4'b0111:begin //define score 7
                num[6:0] <= 7'b1110010;
            end
            4'b1000:begin //define score 8
                num[6:0] <= 7'b1111111;
            end
            4'b1001:begin //define score 9
                num[6:0] <= 7'b1111011;
            end
            default num[6:0] <= 7'b1111110;
        endcase
    end


endmodule
