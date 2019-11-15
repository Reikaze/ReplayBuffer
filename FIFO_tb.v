`timescale 1ns/100ps
module FIFO_TB;
    reg clk, reset, wr, rd;
    wire full, empty;
    wire [2:0] w_addr, r_addr;
    
    fifo UUT(clk, reset, wr, rd, full, empty, w_addr, r_addr);
    
    initial begin
    clk=0;
    reset=0;
    wr=0;
    rd=0;
    end
     
    always
    #5 clk=~clk;
     
    initial begin
        reset = 1;
        #10;
        reset = 0;
        wr=1;rd=0; 
        #40;
        wr=1;rd=0;
        #10;
        wr=0;rd=1;
        #20
        wr=1;rd=0;
    end
    
endmodule
