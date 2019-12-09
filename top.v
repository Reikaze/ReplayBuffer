module top(input clk,rst);
//For LFSR
wire  we;
wire  rdy;
wire [127:0] TLP_in;
//For CRC
wire [127:0] din;
//for Replay Buffer
wire oe, full, empty;
wire [2:0] w_addr, r_addr;
wire [127:0] dout; 
wire  ack, nak;
TLP_in = ;//insertdata

lfsr #(16) lfsr1 (.clk(clk), .rst(rst), .we(we), .data(TLP_in), .q(lfsr_o), .rdy(rdy));

crc crc1(.rdy(rdy),.lfsr_in(lfsr_o),.tlp_in(TLP_in[95:0]]),.data_o(data_o),.crc_out(din));

replayBuffer rp1(.clk(clk), .reset(rst), .we(we), .oe(oe), .full(full), .empty(empty), .w_addr(w_addr), .r_addr(r_addr), .din(din), .dout(dout), .ack(ack), .nak(nak));//fifo + replay buffer logic

end module