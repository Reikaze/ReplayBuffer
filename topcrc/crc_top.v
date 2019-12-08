`include "../crc2/crc.v"
`include "../lfsr/lfsr.v"
`include "../seq/seq.v"

module crc_top(input clk,
		input rst,
		input we,
		input [95:0] tlp_in,
		output [127:0] crc_o);

wire rdy;
wire [127:0] data_o;
wire [15:0] lfsr_o;

seq appseq(.tlp_in(tlp_in), .data_o(data_o));
lfsr #(16) rr1 (.clk(clk), .rst(rst), .we(we), .data(data_o), .q(lfsr_o), .rdy(rdy));
crc UUT(.rdy(rdy),.data_in(data_o),.lfsr_in(lfsr_o),.crc_out(crc_o));

endmodule