module top(input clk,rst, input [127:0] TLP_in);
//For LFSR
wire  we;
wire  rdy;
wire [15:0] lfsr_o;
//For CRC
wire [127:0] din;
//for Replay Buffer
wire oe, full, empty;
wire [2:0] w_addr, r_addr;
wire [127:0] dout; 
wire  ack, nak;

//Generate LFSR
//output lfsr, rdy
lfsr #(16) lfsr1 (.clk(clk), .rst(rst), .we(we), .data(TLP_in), .q(lfsr_o), .rdy(rdy));
//generate CRC, output data 
crc crc1(.rdy(rdy),.data_in(TLP_in),.lfsr_in(lfsr_o),.crc_out(din));
//input fifo, handle acknak, output buffer
replayBuffer rp1(.clk(clk), .reset(rst), .we(we), .oe(oe), .full(full), .empty(empty), .w_addr(w_addr), .r_addr(r_addr), .din(din), .dout(dout), .ack(ack), .nak(nak));//fifo + replay buffer logic

endmodule