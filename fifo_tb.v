`timescale 1ns / 1ps



module fifo_tb;

parameter Data_width = 16;

reg clk, reset;
reg write_en, read_en;
reg [Data_width-1:0] data_in;
wire full, empty;
wire [Data_width-1:0] data_out;

fifo UUT(.clk(clk),
         .reset(reset),
         .write_en(write_en),
         .read_en(read_en),
         .data_in(data_in),
         .data_out(data_out),
         .full(full),
         .empty(empty)); 
         
always #5 clk = ~clk;

integer j;
initial begin
    clk = 1'b 0;
    reset = 1'b 1;
    data_in = 16'b 0;
    write_en = 1'b 0;
    read_en = 1'b 0;
    #13;
    reset = 1'b 0;
    write_en = 1'b 1;
    #2;
    for (j = 0; j<8; j=j+1)begin
        data_in = j;
        #10;
        end
        
    #22;
    read_en = 1'b 1;
    write_en = 1'b 0;
    #193;
    $finish;
    end
    
    endmodule
    
