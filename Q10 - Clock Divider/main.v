`timescale 1ns / 1ps
// assuming that the master clk is 1MHz for simplicity

module clockdivider(
    input rst,
    input clk,
    output reg newclk
);
    reg [19:0] count; // since the master clk has freq 10^6 Hz. log_2(10^6) ~ 20 bits
    
    always @(posedge clk) begin    
        if(rst) begin
            count <= 20'd0;
            newclk <= 1'b0;
        end
        else begin
            if(count < 20'd9) begin
                count <= count + 1'b1;
            end
            else begin
                count <= 20'd0;
                newclk <= ~newclk;
            end
        end     
    end          
endmodule


module clockdivider_tb;
    reg rst;
    reg clk;
    wire newclk;
    
    clockdivider uut(.rst(rst), .clk(clk), .newclk(newclk));
    
    always begin
        #5;
        clk = ~clk;
    end 
    
    initial begin
        clk = 0;
        rst = 1;
        #20;
        rst = 0;
        $monitor("Time = %0t | newclk = %b", $time, newclk);
        
        #1000;
        $finish;
    
    end

endmodule
