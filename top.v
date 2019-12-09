module top(input clk,rst, input [127:0] TLP_in);
//For LFSR
wire  we;
wire  rdy;
wire [15:0] lfsr_o;
//For CRC

//for Replay Buffer
wire [127:0] din;
wire oe, full, empty;
wire [2:0] w_addr, r_addr;
wire [127:0] dout; 
wire  ack, nak;



//generate CRC, output data 
crc #(16) crc1(.clk(clk),.rst(rst),.we(we),.data(data),.q(lfsr_o),.dataOut(din),.rdy(rdy));

//replaybuffer
replayBuffer rp1(.clk(clk), .reset(rst), .we(we), .oe(oe), .full(full), .empty(empty), .w_addr(w_addr), .r_addr(r_addr), .din(din), .dout(dout), .ack(ack), .nak(nak));//fifo + replay buffer logic

endmodule