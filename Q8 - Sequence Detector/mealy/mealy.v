// detecting the sequence 1011 with overlap
module sequence_mealy(
    input clk,
    input rst,
    input serial_in,
    output reg detected
);
    localparam S0 = 2'b00;
    localparam S1 = 2'b01;
    localparam S2 = 2'b10;
    localparam S3 = 2'b11;
    

    reg [1:0] state, nextstate;

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
                    detected = 0;
                end
                else begin
                    nextstate = S0;
                    detected = 0;
                end
            end
            S1 : begin
                if(serial_in) begin
                    nextstate = S1;
                    detected = 0;
                end
                else begin
                    nextstate = S2;
                    detected = 0;
                end
            end
            S2 : begin
                if(serial_in) begin
                    nextstate = S3;
                    detected = 0;
                end
                else begin
                    nextstate = S0;
                    detected = 0;
                end
            end
            S3 : begin
                if(serial_in) begin
                    nextstate = S0;
                    detected = 1;
                end
                else begin
                    nextstate = S2;
                    detected = 0;
                end
            end
            
            default: begin
                nextstate = S0;
                detected = 0;
            end


        endcase
    end

endmodule



// testbench
module mealytb;
    reg clk;
    reg rst;
    reg serial_in;
    wire detected;

    sequence_mealy uut(.clk(clk), .rst(rst), .serial_in(serial_in), .detected(detected));

    always begin
        #5;
        clk = ~clk;
    end

    initial begin
        $dumpfile("sequence_sim.vcd");
        $dumpvars(0, mealytb);
        

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
