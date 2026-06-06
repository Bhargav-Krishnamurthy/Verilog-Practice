module fulladder(input a, input b, input cin, output sum, output cout);
  assign sum = a^b^cin;
  assign cout = a&b | b&cin | a&cin;
endmodule


module n_bit_ripple_adder #(parameter N = 8)(
  input [N-1:0] a,
  input [N-1:0] b,
  input cin,
  output reg [N-1:0] sum,
  output cout
);
  /*
   the below generate block can be replaced by the following line
   assign {cout, sum} = a + b + cin;
  */
  
  wire [N:0] carry; 
  assign carry[0] = cin;
  genvar i;
  generate
    for(i = 0; i < N; i=i+1) begin
      fulladder fa (.a(a[i]), .b(b[i]), .cin(carry[i]), .sum(sum[i]), .cout(carry[i+1]));
    end
  endgenerate
  
  assign cout = carry[N];
endmodule
