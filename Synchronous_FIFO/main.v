module synchronous_fifo(
  input clk,
  input reset,
  input wr_en,
  input rd_en,
  input [3:0] data_in,
  output reg full,
  output reg empty,
  output reg [3:0] data_out
);
  
  reg [3:0] memory [0:7];
  reg [2:0] rd_ptr;
  reg [2:0] wr_ptr;
  reg [3:0] datacount;
  
  // if the datacount becomes 8, then FIFO if full
  // if the datacount becomes 0, then the FIFO is empty
  
  always @(posedge clk) begin
    if(reset) begin
      wr_ptr   <= 3'b000;
      rd_ptr   <= 3'b000;
      datacount <= 4'b0000;
    end
    
    else begin
      // write operation
      if(wr_en && !full) begin
        memory[wr_ptr] <= data_in;
        wr_ptr <= wr_ptr + 1'b1;
      end

      if(rd_en && !empty) begin
        data_out <= memory[rd_ptr];
        rd_ptr <= rd_ptr + 1'b1;
      end
      
      if((wr_en && !full) && !(rd_en && !empty))begin
        datacount <= datacount + 1'b1;
      end
      else if((rd_en && !empty) && !(wr_en && !full)) begin
        datacount <= datacount - 1'b1;
      end
    end
    
  end
  
  
  always @(*) begin
    if(datacount == 4'b1000) begin
      full = 1;
      empty = 0;
    end
    else if(datacount == 4'b0000) begin
      empty = 1;
      full = 0;
    end
    else begin
      empty = 0;
      full = 0;
    end
  end
  
endmodule
