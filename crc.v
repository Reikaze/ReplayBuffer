/*
	Cyclic Redundancy Check(for TLP)
	This code takes a squence number that is appended to 
	the TLP at the MSB that is received. Then the CRC that
	is generated will be appended to the LSB of the TLP.

	Waits for LFSR to finish generating 16bit CRC then 
	appends CRC to TLP and allows output

*/

module crc(rdy, tlp_in, lfsr_in, crc_out);
input rdy;
input [95:0] tlp_in;
input [15:0] lfsr_in;
output reg [127:0] crc_out;

reg [11:0] seq_num = 12'b0;	
reg [15:0] seq_out;						// everytime we read the next byte assign seq num												// seq_num (4bit + 12bit) + tlp_in (96 bit) + 16 bit 0s = 96 bits
reg [127:0] data;						// increment sequence number
reg [127:0] crc_out;						// append sequence number to beginning of tlp and 16 bit 0 to end
								// lfsr will take the appended data and output 16 bit crc
wire [15:0] lfsr_o;						


always@(*)begin				
	if(rdy) begin		
	seq_num = seq_num + 1;	
	seq_out = {4'b0,seq_num};						
	data = {seq_out,tlp_in,16'b0};					
	crc_out = {data[127:16],lfsr_in};
	end
end										
										
endmodule
