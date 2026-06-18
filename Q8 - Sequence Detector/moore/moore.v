`timescale 1ns/1ns
// detecting the sequence overlapping 1011


// MOORE MACHINE
module sequence_moore(
    input clk,
    input rst,
    input serial_in,
    output reg detected
);

    localparam S0 = 3'b000;
    localparam S1 = 3'b001;
    localparam S2 = 3'b010;
    localparam S3 = 3'b011;
    localparam S4 = 3'b100;
    
    reg [2:0] state, nextstate;

    always @(posedge clk) begin
        if(rst) begin
            state <= S0;
        end
        else begin
            state <= nextstate;
        end
    end



    always @(*) begin
        case (state) 
            S0 : begin
                if(serial_in) begin
                    nextstate = S1;
                end
                else begin
                    nextstate = S0;
                end
            end

            S1 : begin
                if(serial_in) begin
                    nextstate = S1;
                end
                else begin
                    nextstate = S2;
                end
            end

            S2: begin
                if(serial_in) begin
                    nextstate = S3;
                end
                else begin
                    nextstate = S0;
                end
            end
            S3: begin
                if(serial_in) begin
                    nextstate = S4;
                end
                else begin
                    nextstate = S2;
                end
            end
            S4 : begin
                if(serial_in) begin
                    nextstate = S1;
                end
                else begin
                    nextstate = S2;
                end
            end
            default: begin
                nextstate = S0;
            end
    
        endcase
    end
    
    // Moore Logic
    always @(*) begin
        if(state == S4) begin
            detected = 1;
        end
        else begin 
            detected = 0;
        end
    end

endmodule



// testbench
module mooretb;
    reg clk;
    reg rst;
    reg serial_in;
    wire detected;

    sequence_moore uut(.clk(clk), .rst(rst), .serial_in(serial_in), .detected(detected));

    always begin
        #5;
        clk = ~clk;
    end

    initial begin
        $dumpfile("sequence_sim.vcd");
        $dumpvars(0, mooretb);
        

        clk = 0;
        rst = 1;
        serial_in = 0;

        #5;
        rst = 0;
        serial_in = 1;
        $display("Time : %0t | Serial_Inp : %b | Detected = %b", $time, serial_in, detected);
        #10;
        serial_in = 1;
        $display("Time : %0t | Serial_Inp : %b | Detected = %b", $time, serial_in, detected);
        #10;
        serial_in = 0;
        $display("Time : %0t | Serial_Inp : %b | Detected = %b", $time, serial_in, detected);
        #10;
        serial_in = 1;
        $display("Time : %0t | Serial_Inp : %b | Detected = %b", $time, serial_in, detected);
        #10;
        serial_in = 1;
        $display("Time : %0t | Serial_Inp : %b | Detected = %b", $time, serial_in, detected);
        #10;
        serial_in = 1;
        $display("Time : %0t | Serial_Inp : %b | Detected = %b", $time, serial_in, detected);
        #10;
        serial_in = 0;
        $display("Time : %0t | Serial_Inp : %b | Detected = %b", $time, serial_in, detected);
        #10;
        serial_in = 1;
        $display("Time : %0t | Serial_Inp : %b | Detected = %b", $time, serial_in, detected);
        #10;
        serial_in = 1;
        $display("Time : %0t | Serial_Inp : %b | Detected = %b", $time, serial_in, detected);
        #10;
        serial_in =0;
        $display("Time : %0t | Serial_Inp : %b | Detected = %b", $time, serial_in, detected);
        #10;
        serial_in = 1;
        $display("Time : %0t | Serial_Inp : %b | Detected = %b", $time, serial_in, detected);
        #10;
        serial_in = 1;
        $display("Time : %0t | Serial_Inp : %b | Detected = %b", $time, serial_in, detected);
        #10;
        serial_in = 0;
        $display("Time : %0t | Serial_Inp : %b | Detected = %b", $time, serial_in, detected);
        #10;
        serial_in = 1;
        $display("Time : %0t | Serial_Inp : %b | Detected = %b", $time, serial_in, detected);
        $finish;
    end

endmodule