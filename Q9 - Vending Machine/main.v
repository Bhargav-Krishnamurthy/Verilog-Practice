module vending_machine(
    input clk,
    input ten,
    input twenty,
    output reg dispense,
    output reg change
);
    localparam S0 = 2'b00;
    localparam S1 = 2'b01;
    localparam S2 = 2'b10;
    localparam S3 = 2'b11;
    

    reg [1:0] state, nextstate;
    
    
    always @(posedge clk) begin
        state <= nextstate;
    end

    always @(*) begin
        case (state)
            S0 : begin
                dispense = 0;
                change = 0;
                if(ten == 0 && twenty == 0) begin
                    nextstate = S0;
                end
                else if(ten == 1 && twenty == 0) begin
                    nextstate = S1;
                end
                else if(ten == 0 && twenty == 1) begin
                    nextstate = S2;
                end
                else begin
                    nextstate = S0;
                end
            end

            S1 : begin
                change = 0;
                if(ten == 0 && twenty == 0) begin
                    nextstate = S1;
                    dispense = 0;
                end
                else if (ten == 1 && twenty == 0) begin
                    nextstate = S2;
                    dispense = 0;
                end
                else if(ten == 0 && twenty == 1) begin
                    nextstate = S0;
                    dispense = 1;
                end
                else begin
                    nextstate = S0;
                    dispense = 0;
                end
            end

            S2 : begin
                if(ten == 0 && twenty == 0) begin
                    nextstate = S2;
                    dispense=0;
                    change = 0;
                end
                
                else if(ten == 1 && twenty == 0) begin
                    nextstate = S0;
                    dispense = 1;
                    change = 0;
                end
                else if(ten == 0 && twenty == 1) begin
                    nextstate = S0;
                    dispense = 1;
                    change = 1;
                end
                else begin
                    nextstate = S0;
                    dispense = 0;
                    change = 0;
                end
            end
            default: begin
                nextstate = S0;
                dispense = 0;
                change = 0;
            end
        endcase
    end

endmodule



module vendingmachinetb;
    reg clk;
    reg ten;
    reg twenty;
    wire dispense;
    wire change;

    vending_machine uut (.clk(clk), .ten(ten), .twenty(twenty), .dispense(dispense), .change(change));

    always begin
        #5;
        clk = ~clk;
    end

    initial begin
        clk = 0;
        ten = 0;
        twenty = 0;
        #5;
        ten = 1;
        twenty = 0;
        #1;
        $display("Time : %0t ns | Ten : %b | Twenty : %b | Dispense : %b | Change : %b", $time, ten, twenty, dispense, change);

        #10;
        ten = 1;
        twenty = 0;
        #1;
        $display("Time : %0t ns | Ten : %b | Twenty : %b | Dispense : %b | Change : %b", $time, ten, twenty, dispense, change);

        #10;
        ten = 1;
        twenty = 0;
        #1;
        $display("Time : %0t ns | Ten : %b | Twenty : %b | Dispense : %b | Change : %b", $time, ten, twenty, dispense, change);

        
        #10;
        ten = 1;
        twenty = 0;
        #1;
        $display("Time : %0t ns | Ten : %b | Twenty : %b | Dispense : %b | Change : %b", $time, ten, twenty, dispense, change);

        #10;
        ten = 1;
        twenty = 0;
        #1;
        $display("Time : %0t ns | Ten : %b | Twenty : %b | Dispense : %b | Change : %b", $time, ten, twenty, dispense, change);

        #10;
        ten = 0;
        twenty = 1;
        #1;
        $display("Time : %0t ns | Ten : %b | Twenty : %b | Dispense : %b | Change : %b", $time, ten, twenty, dispense, change);

        #10;
        ten = 1;
        twenty = 0;
        #1;
        $display("Time : %0t ns | Ten : %b | Twenty : %b | Dispense : %b | Change : %b", $time, ten, twenty, dispense, change);
        $finish;
    end
endmodule