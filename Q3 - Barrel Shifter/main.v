module barrel_shifter(
  input [7:0] in,
  input [2:0] shamt,
  input dir,
  output reg [7:0] out
);
  always @(*) begin
    // left shift
    if(dir == 0) begin
      // shifting by 4 to left
      if(shamt[2]) begin
        out[7:4] = in[3:0];
        out[3:0] = 4'b0000;
      end
      else begin
        out = in;
      end
      
      // shifting by 2 to the left
      if(shamt[1]) begin
        out[7:6] = out[5:4];
        out[5:4] = out[3:2];
        out[3:2] = out[1:0];
        out[1:0] = 2'b00;
      end
      else begin
        out = out;
      end
      
      // shifting by 1 to the left
      if(shamt[0]) begin
        out[7] = out[6];
        out[6] = out[5];
        out[5] = out[4];
        out[4] = out[3];
        out[3] = out[2];
        out[2] = out[1];
        out[1] = out[0];
        out[0] = 1'b0;
      end
      else begin
        out = out;
      end
    end
    
    // shift right

	else begin
      // shift by 4
      if(shamt[2]) begin
          out[3:0] = in[7:4];
          out[7:4] = 4'b0000;
      end
      else begin
          out = in;
      end

      // shift by 2
      if(shamt[1]) begin
          out[3:2] = out[5:4];
          out[1:0] = out[3:2]; 
      end
      
      // shift by 1
      if(shamt[0]) begin
          out[0] = out[1];
          out[1] = out[2];
          out[2] = out[3];
          out[3] = out[4];
          out[4] = out[5];
          out[5] = out[6];
          out[6] = out[7];
          out[7] = 1'b0;
      end
	end
    
    
  end
  
endmodule