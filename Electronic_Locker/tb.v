`timescale 1ns/1ps

module electronicsafe_tb;
    reg clk;
    reg reset;
    reg [1:0] button;
    wire alarm;       
    wire unlocked;
    electronic_locker uut(.clk(clk), .reset(reset), .alarm(alarm), .button(button), .unlocked(unlocked));
    
    always begin
        #5; 
        clk = ~clk;
    end
  
    initial begin
      $dumpfile("dump.vcd");
      $dumpvars(0, electroniclocker_tb);
        
      
        clk = 0;
        reset = 1;
        button = 2'b00; // not pressing anything
        #10;
        
        $display("unlocked: %b", unlocked);
        $display("alarm: %b", alarm);
        reset = 0;
        button = 2'b01; // pressing button A
        #10;
        
        $display("unlocked: %b", unlocked);
        $display("alarm: %b", alarm);
        reset = 0;
        button = 2'b00; // not pressing anything
        #10;
        
        $display("unlocked: %b", unlocked);
        $display("alarm: %b", alarm);
        reset = 0;
        button = 2'b10; // pressing button B
        #10;
        
        $display("unlocked: %b", unlocked);
        $display("alarm: %b", alarm);
        reset = 0;
        button = 2'b01; // pressing button A
        #10;
        
        $display("unlocked: %b", unlocked);
        $display("alarm: %b", alarm);
        reset = 1;
        
        $display("unlocked: %b", unlocked);
        $display("alarm: %b", alarm);
        #10;
        
        $finish;
    end
endmodule
