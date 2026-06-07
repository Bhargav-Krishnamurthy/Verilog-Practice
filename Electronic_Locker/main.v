// Electronic Locker


// Password is A -> B -> A




// 00 is not pressing anything
// 01 is pressing button A
// 10 is pressing button B

module electronic_locker(
    input clk,
    input reset,
    input [1:0] button,
    output reg alarm,
    output reg unlocked
);
    localparam S0 = 3'b000;
    localparam S1 = 3'b001;
    localparam S2 = 3'b010;
    localparam S3 = 3'b011;
    localparam ALARM = 3'b100;
    reg [2:0] state, nextstate;
    
    
    always @(posedge clk) begin
        if(reset) begin
            state <= S0;
        end
        else begin
            state <= nextstate;
        end
    end

    
    always @(*) begin
        nextstate = state;
        unlocked = 0;
        if(state == ALARM && reset == 0) begin
            alarm = 1;
        end
        else begin
            alarm = 0;
        end
      
        case (state) 
            S0: begin
                case (button)
                    2'b00:   nextstate = S0;
                    2'b01:   nextstate = S1;
                    2'b10:   begin
                        nextstate = ALARM;
                        alarm = 1;
                    end
                    default: nextstate = S0;
                endcase
            end
            S1: begin
                case(button)
                    2'b00:   nextstate = S1;
                    2'b01:   nextstate = S1;
                    2'b10:   nextstate = S2;
                    default: nextstate = S0;
                endcase
            end
            S2: begin
                case(button)
                    2'b00:   nextstate = S2;
                    2'b01:   nextstate = S3;
                    2'b10:   begin
                        nextstate = ALARM;

                    end
                    default: nextstate = S0;
                endcase
            end
            S3: begin
                unlocked = 1;
                nextstate = S3;
            end
            ALARM: begin
                if(reset) begin
                    nextstate = S0;
                end
                else begin
                    nextstate = ALARM;
                end
            end
            default: begin
                nextstate = S0;
            end
        endcase
    end
endmodule
