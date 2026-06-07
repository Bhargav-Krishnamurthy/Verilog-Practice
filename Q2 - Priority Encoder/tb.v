module prioenctb;
  reg [7:0] in;
  wire [2:0] out;
  wire valid;
  
  priorityencoder uut(.in(in), .out(out), .valid(valid));
  integer i;
  initial begin
    
    in = 8'b00000000;
    #10;
    $display("INPUT = %b || OUTPUT = %d || valid = %b", in, out, valid);
    
    
    for(i=0; i<8; i=i+1) begin
      in[i] = ~in[i];
      #10;
      $display("INPUT = %b || OUTPUT = %d || valid = %b", in, out, valid);
    end
    
    
    $finish;
  end
  
endmodule
