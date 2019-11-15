/*
	Cyclic Redundancy Check(for TLP)
	This code takes a squence number that is appended to 
	the TLP at the MSB that is received. Then the CRC that
	is generated will be appended to the LSB of the TLP.
*/
`include "lfsr.v"


module crc(clk, rst, tlp_in, crc_out);
input clk;
input rst;
input [27:0] tlp_in;
output [63:0] crc_out;

reg [11:0] seq_num = 0;						// everytime we read the next byte assign seq num
reg count;							// seq_num 12bit + tlp_in 28 bit + 16 bit 0s = 64 bits
reg [63:0] data;						// increment sequence number
reg [63:0] crc_out;						// append sequence number to beginning of tlp and 16 bit 0 to end
								// lfsr will take the appended data and output 16 bit crc
wire [15:0] lfsr_o;						
wire lfsr_fin;

always@(tlp_in)begin								
	seq_num = seq_num + 1;							
	data <= {seq_num,tlp_in,16'b0};						
end										
										
lfsr #(.NBITS(16)) rr1(.clk(clk),.rst(rst),.we(we),.data(data),.q(lfsr_o), .d_fin(lfsr_fin));	
								// .data = inputs     .q = output
/*
always@(posedge clk) begin					 this block might be better than the next... need testing
	if(lfsr_fin == 1)begin					 might have to modify lfsr.v for this to work properly
		we = 0;
	else
		we = 1;
	end
end
*/
	
always@(posedge clk or data)begin						
	count = 0;						// every time clock is 1 and there is new "data" 
	if(count <= 64)begin					// counter counts up the 64 bits and write enable = 1
		count <= count + 1;				// once we hit 64 data stops write and count is initialized for the next byte
		we <= 1b'1;					// of data
	else
		we <= 1b'0;
	end
end

assign crc_out = {seq_num,tlp_in,lfsr_o};			// the 16 bits from the lfsr appended to tlp

endmodule
