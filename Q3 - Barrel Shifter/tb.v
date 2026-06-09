module tb;
  reg [7:0] in;
  reg [2:0] shamt;
  reg dir;
  wire [7:0] out;
  barrel_shifter uut (.in(in), .shamt(shamt), .dir(dir), .out(out));
  
  
  initial begin
    #10;
    
    in = 8'b11011100; shamt = 3'b001; dir = 0;
    #10; 
    $display("Output = %b (expected 10111000)", out);

    
    in = 8'b11011100; shamt = 3'b100; dir = 0;
    #10; 
    $display("Output = %b (expected 11000000)", out);

    
    in = 8'b11011100; shamt = 3'b001; dir = 1;
    #10; 
    $display("Output = %b (expected 01101110)", out);

    
    in = 8'b11011100; shamt = 3'b100; dir = 1;
    #10; $display("Output = %b (expected 00001101)", out);

    
    in = 8'b11011100; shamt = 3'b101; dir = 0;
    #10; $display("Output = %b (expected 10000000)", out);
    $finish;
  end
endmodule