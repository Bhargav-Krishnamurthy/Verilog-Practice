`timescale 1ns/1ps
module synchroniser #(parameter N=4) (
    input clk,
    input rst,
    input [N-1:0] in,
    output reg [N-1:0] out
);
    reg [N-1:0] d1;

    always @(posedge clk) begin 
        if(rst) begin
            d1 <= {N{1'b0}};
            out <= d1;
        end
        else begin
            d1 <= in;
            out <= d1;
        end
    end
endmodule


// testbench module

module synctb;
    localparam N = 4;
    reg clk=0;
    reg rst;
    reg [N-1:0] in;
    wire [N-1:0] out;

    synchroniser #(N) uut(.clk(clk), .rst(rst), .in(in), .out(out));

    always begin
        #5;
        clk = ~clk;
    end

    initial begin
        $dumpfile("waveform.vcd");
        $dumpvars(0, synctb);
        rst = 1'b1;
        in = {N{1'b0}};
        $monitor("Time=%0t | rst=%b | in=%b | out=%b", $time, rst, in, out);
        #11;
        rst = 1'b0;
        #10;
        in = {N{1'b1}};
        #10;
        in = {N{1'b0}};
        #10;
        in = {N{1'b1}};
        #10;
        in = {N{1'b0}};
        #10;
        $finish;
    end
endmodule