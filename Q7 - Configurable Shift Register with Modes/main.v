`timescale 1ns/1ns

module shiftregister_config(
    input clk,
    input rst,
    input [1:0] mode,
    input sin_l,
    input sin_r,
    input [7:0] d,
    output reg [7:0] q
);



    always @(posedge clk) begin
        if(rst) begin 
            q <= 8'd0; 
        end
        else begin
            case (mode) 
                2'b00 : q <= d;
                2'b01 : q <= {d[6:0], sin_l}; 
                2'b10 : q <= {sin_r, d[7:1]};
                2'b11 : q <= d;
                default : q <= d;

            endcase
        end
    end

endmodule


// testbench
module shiftregtb;
    reg clk;
    reg rst;
    reg [1:0] mode;
    reg sin_l;
    reg sin_r;
    reg [7:0] d;
    wire [7:0] q;


    shiftregister_config uut(.clk(clk), .rst(rst), .mode(mode), .sin_l(sin_l), .sin_r(sin_r), .d(d), .q(q));

    always begin
        #5;
        clk = ~clk;
    end

    initial begin
        $dumpfile("shiftreg_sim.vcd");
        $dumpvars(0, shiftregtb);
        $monitor("TIME : %0t ns | INPUT : %b | MODE : %b | OUTPUT : %b",$realtime, d, mode, q);
        clk = 0;
        rst = 1;
        d = 8'd0;
        mode = 2'b00;
        sin_r = 0;
        sin_l = 0;

        #10;
        rst = 0;
        d = 8'b11010010;
        mode = 2'b01;
        sin_l = 1;
        sin_r = 0;
        
        #15;
        mode = 2'b10;

        #10;
        rst = 1;

        #10;
        rst = 0;
        d = 8'b00001111;
        mode = 2'b11;
        sin_l = 1;
        sin_r = 1;

        #10;
        mode = 2'b01;
        #40; 
        $finish;
    end

endmodule