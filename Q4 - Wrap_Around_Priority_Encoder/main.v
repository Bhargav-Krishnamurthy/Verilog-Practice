module wraparound(
  input [3:0] in,
  input [1:0] start_idx,
  output reg [1:0] final_idx,
  output valid
);
  wire [7:0] double = {in, in}; // if the in = 4'b1101, then double = 8'b11011101
  wire [3:0] part = double[start_idx +: 4]; // extracting only the 4 bits
  assign valid = |in;
  reg [1:0] localidx;
  always @(*) begin
    if(part[0]) localidx = 2'b0;
    else if(part[1]) localidx = 2'd1;
    else if(part[2]) localidx = 2'd2;
    else localidx = 2'd3;
  end
  
  assign final_idx = localidx + start_idx;
  
endmodule
