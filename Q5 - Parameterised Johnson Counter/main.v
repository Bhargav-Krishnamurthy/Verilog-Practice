`timescale 1ns/1ns

// synchronous reset
module johnsoncounter #(parameter N = 4) (
  input wire clk,
  input wire rst,
  output reg [N-1:0] out
);
  
  always @(posedge clk) begin
    if(rst) out <= {N{1'b0}};
    else begin
      out <= {~out[0], out[N-1:1]};
    end
  end
  
endmodule



// Testbench
module johnsoncountertb;
  localparam N = 4;
  reg clk=0;
  reg rst;
  wire [N-1:0] out;
  
  johnsoncounter #(N) uut(.clk(clk), .rst(rst), .out(out));
  
  always begin
    #5;
    clk = ~clk;
  end

  
  initial begin
    $dumpfile("waveform.vcd");
    $dumpvars(0, johnsoncountertb);
    rst = 1'b1;
    $monitor("Time=%0t | rst=%b | out=%b", $time, rst, out);
    #11;
    rst = 1'b0;
    #105;
    $finish;

  end
endmodule
