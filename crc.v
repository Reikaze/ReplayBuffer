module crc #(parameter NBITS=16)	// parameter not really needed...
	     (input clk,
	      input rst,
	      input we,
	      input [127:0] data,
	      output [NBITS-1:0] q,
	      output [127:0] dataOut,
	      output reg rdy);

reg [NBITS:1] d;
reg xorin;
integer count = 0;

always@(posedge clk, negedge rst)
begin
	if(!rst)
	begin
		d <= 16'b1;
	end
	else begin
		if(we)begin
			d <= data ;
		end
		else begin	
			if(count < 15)begin
			d <= {d[NBITS-1:1], xorin};
			rdy <= 0;
			count <= count + 1;
			end
			else begin
			rdy <= 1;
			end
		end
	end
end

always@(*)begin
	xorin = (d[12] ^ d[3] ^ d[1]); 
end
assign q = d[NBITS:1];
assign dataOut[15:0] = q;
assign dataOut[127:16] = data[127:16];
endmodule