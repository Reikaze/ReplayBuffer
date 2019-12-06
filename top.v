module top(input clk,rst,TLP);

wire [128:0] din;
wire  we, oe;
wire  ack, nak;
wire full, empty;
wire [2:0] w_addr, r_addr;
wire [128:0] dout; 


lfsr #(16) lfsr1 (.clk(clk), .rst(rst), .we(we), .data(), .q(lfsr_o), .rdy(rdy));

crc crc1(.rdy(rdy||rdy_in),.lfsr_in(lfsr_o),.tlp_in(tlp_in_t),.data_o(data_o),.crc_out(crc_out_t));

replayBuffer rp1(.clk(clk), .reset(rst), .we(we), .oe(oe), .full(full), .empty(empty), .w_addr(w_addr), .r_addr(r_addr), .din(din), .dout(dout), .ack(ack), .nak(nak));//fifo + replay buffer logic

end module