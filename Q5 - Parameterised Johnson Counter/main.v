`timescale 1ns/1ns

// synchronous reset
module johnsoncounter (
  input wire clk,
  input wire rst,
  output reg [3:0] out
);
  
  always @(posedge clk) begin
    if(rst) out <= 4'b0000;
    else begin
      out <= {~out[0], out[3:1]};
    end
  end
  
endmodule



// Testbench
module johnsoncountertb;
  reg clk=0;
  reg rst;
  wire [3:0] out;
  
  johnsoncounter uut(.clk(clk), .rst(rst), .out(out));
  
  always begin
    #5;
    clk = ~clk;
  end

  
  initial begin
    rst = 1'b1;
    $monitor("Time=%0t | rst=%b | out=%b", $time, rst, out);
    #11;
    rst = 1'b0;
    #105;
    $finish;

  end
endmodule
