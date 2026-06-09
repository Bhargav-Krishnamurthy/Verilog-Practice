module wraparound_tb;
  reg [3:0] in;
  reg [1:0] start_idx;
  wire [1:0] final_idx;
  wire valid;
  
  wraparound uut(.in(in), .start_idx(start_idx), .final_idx(final_idx), .valid(valid));
  
  initial begin
    #5;
    in = 4'b1101;
    start_idx = 2'b10;
    #5;
    $display("Output = %d", final_idx);
    in = 4'b1001;
    start_idx = 2'b10;
    #5;
    $display("Output = %d", final_idx);
    in = 4'b0111;
    start_idx = 2'b11;
    #5;
    $display("Output = %d", final_idx);
  end
  
endmodule
