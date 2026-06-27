`timescale 1ns / 1ps


module graycodecounter(
    input clk,
    input rst,
    output reg q2,
    output reg q1,
    output reg q0
);
    
    reg d2=0,d1=0,d0=0;
    
    always @(*) begin
        if(rst) begin
            d2 = 0;
            d1 = 0;
            d0 = 0;
        end
        else begin
            d2 = q2&q0 | q1&(~q0);
            d1 = (~q2)&q0 | q1&(~q0);
            d0 = ~(q2^q1);
        end
    
    
    end
    
    always @(posedge clk) begin
        if(rst) begin
            q2<=0;
            q1<=0;
            q0<=0;
        end
        else begin
            q2 <= d2;
            q1 <= d1;
            q0 <= d0;
        end
    end
    
    
endmodule


module graycodecountertb;
    reg clk;
    reg rst;
    wire q2;
    wire q1;
    wire q0;
    
    
    graycodecounter uut (.clk(clk), .rst(rst), .q2(q2), .q1(q1), .q0(q0));
    
    always begin
        #5;
        clk = ~clk;
    end
    
    initial begin
        rst = 1;
        clk = 0;
        
        #13;
        rst = 0;
        $monitor("Time = %0t | q2 = %b | q1 = %b | q0 = %b", $time, q2, q1, q0);
        #500;
        $finish;
    
    end    
    
    
endmodule
