/*
	Cyclic Redundancy Check(for TLP)
	This code takes a squence number that is appended to 
	the TLP at the MSB that is received. Then the CRC that
	is generated will be appended to the LSB of the TLP.
*/
`include "../lfsr/lfsr.v"


module crc(clk, rst, tlp_in, crc_out);
input clk;
input rst;

input [95:0] tlp_in;
output [127:0] crc_out;

reg we;
reg [11:0] seq_num = 0;	
reg [15:0] seq_out;						// everytime we read the next byte assign seq num
reg count;							// seq_num (4bit + 12bit) + tlp_in (96 bit) + 16 bit 0s = 96 bits
reg [127:0] data;						// increment sequence number
reg [127:0] crc_out;						// append sequence number to beginning of tlp and 16 bit 0 to end

								// lfsr will take the appended data and output 16 bit crc

wire [15:0] lfsr_o;						
wire lfsr_fin;

always@(tlp_in)begin								
	seq_num <= seq_num + 1;	
	seq_out <= {4'b0,seq_num};						
	data <= {seq_out,tlp_in,16'b0};						
end										
										
lfsr #(.NBITS(16)) rr1(.clk(clk),.rst(rst),.we(we),.data(data),.q(lfsr_o), .d_fin(lfsr_fin));	
								// .data = inputs     .q = output
/*
always@(data) begin					// this block might be better than the next... need testing
	if(lfsr_fin == 1)begin					// review lfsr.v for better sense
		we = 0;
		crc_out <= {data[127:16],lfsr_o};			// the 16 bits from the lfsr appended to tlp
	end
	else 
		we = 1;
	
end
*/
always@(data)begin						
	count = 0;						// every time clock is 1 and there is new "data" 

	if(count < 128)begin					// counter counts up the 64 bits and write enable = 1
		count <= count + 1;				// once we hit 64 data stops write and count is initialized for the next byte
		we = 1;						// of data
		crc_out <= {data[127:16],lfsr_o};		// the 16 bits from the lfsr appended to tlp
	end	
	else begin
		we = 0;
		
	end
end
endmodule