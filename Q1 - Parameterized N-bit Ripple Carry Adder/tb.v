module rippleadder_tb;
  reg [7:0] a,b;
  reg cin;
  wire [7:0] sum;
  wire cout;
  
  n_bit_ripple_adder #(8) uut(.a(a), .b(b), .cin(cin), .sum(sum), .cout(cout));
  
  initial begin
    	a = 8'd15;  b = 8'd10;  cin = 0;
        #10; $display("15+10 = %0d, cout=%b", sum, cout); // expect 25

        // Overflow test
        a = 8'hFF;  b = 8'h01;  cin = 0;
        #10; $display("FF+01 = %0d, cout=%b", sum, cout); // sum=0, cout=1

        // With carry-in
        a = 8'd100; b = 8'd100; cin = 1;
        #10; $display("100+100+1 = %0d, cout=%b", sum, cout); // expect 201

        $finish;
    
    
  end
  
endmodule
