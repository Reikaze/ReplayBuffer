`timescale 1ns/100ps

module replayBuffer_tb;
    
    reg  [128:0] din;
    reg  clk, reset;
    reg  we, oe, ack, nak;
    reg tim_out;
    wire full, empty;
    wire [2:0] w_addr, r_addr;
    wire [128:0] dout; 
    
    replayBuffer uut(clk, reset, we, oe, tim_out, full, empty, w_addr, r_addr, din, dout, ack, nak);
    
    initial begin
    din=16'h0000;
    clk=0;
    reset=0;
    we=0;
    oe=0;
    ack=0;
    nak=0;
    end
    
    always
    #5 clk=~clk;
     
    initial begin
        reset = 1;
        #10;
        reset = 0;
        we=1;oe=0; 
        din=16'h0001;
        #10;
        we=1;oe=0;
        din=16'h1111;
        #10;
        we=0;oe=1;
        #20
        we=0;oe=0;
        ack = 1;
        #10
        we=1;oe=0;
        ack=0;
        din=16'h1101;
        #10
        we=0;oe=1;
        #10
        we=0;oe=0;
        #10
        nak=1;
        #10
        nak=0; 
        tim_out = 1;
        #10;
    end

endmodule
