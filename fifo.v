`timescale 1ns / 1ps


module fifo #(parameter Depth = 8, Data_width = 16)(
    input clk, reset,
    input write_en, read_en,
    input [Data_width-1:0] data_in,
    output reg [Data_width-1:0] data_out,
    output full, empty
    );
    
//  reg [2:0] write_ptr, read_ptr;
    reg [3:0] write_ptr, read_ptr;
//  reg [2:0] data_count;
    
    wire wrap_around;
    
    reg [Data_width-1:0] fifo_mem [0:Depth-1];
    
    integer i;
       
    always @(posedge clk) begin
        if (reset) begin
            data_out <= 16'b 0;
            write_ptr <= 3'b 0;
            read_ptr <= 3'b 0;
            // data_count<= 3'b 000;
            for (i = 0; i<Data_width; i = i+1) 
                fifo_mem[i] <= 16'b 0;
        end
    end
    
    always @(posedge clk) begin
        if (write_en & !full) begin
            fifo_mem[write_ptr] <= data_in;
            write_ptr <= write_ptr + 1;
            // data_count < data_count + 1;
            end
    end        
            
    always @(posedge clk) begin
        if (read_en & !empty) begin
            data_out <= fifo_mem[read_ptr];
            read_ptr <= read_ptr + 1;
            // data_count <= data_count -1;
            end
    end
    
    
//   assign wrap_around = write_ptr[3] ^ read_ptr[3];
//   assign full = wrap_around & (write_ptr[2:0] == read_ptr[2:0]);
//   assign empty = ~wrap_around & (write_ptr[2:0] == read_ptr[2:0]);

   assign full = ((write_ptr + 1) == read_ptr);
   assign empty = (write_ptr == read_ptr);

//    assign full = (data_count == 3'b 111);
//    assign empty = (data_count == 3'b 000);
    
endmodule
