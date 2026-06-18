// to make this simple i will assume that the led sequence is fixed 
module main(
    input clk,
    input rst,
    input [7:0] inputsequence,
    output reg [2:0] score,


);
    localparam RED = 2'b00;
    localparam GREEN = 2'b01;
    localparam BLUE = 2'b10;
    localparam YELLOW = 2'b11;
    localparam IDLE = 3'b000;
    localparam COLOUR1 = 3'b001;
    localparam COLOUR2 = 3'b010;
    localparam COLOUR3 = 3'b011;
    localparam COLOUR4 = 3'b100;
    localparam START = 3'b101;
    localparam RESET = 3'b110;
    localparam WIN = 3'b111;
    

    always @(posedge clk){

    }

    always @(*) begin
        case (STATE) begin
            START : begin
                if(inputsequence[])



        endcase

    end
endmodule