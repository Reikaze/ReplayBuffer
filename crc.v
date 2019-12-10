module crc #(parameter NBITS=16)	// parameter not really needed...
	     (input clk,
	      input rst,
	      input we,
	      input [95:0] data,
	      output reg [NBITS-1:0] q,
	      output reg [127:0] dataOut,
	      output reg rdy);

reg [NBITS:1] d;
reg xorin;
integer count = 0;
reg [11:0] seq;


always@(posedge clk, negedge rst)
begin
	if(!rst)
	begin
		d <= 16'b1;
		seq <= 0;
	end
	else begin
		if(we)begin
			d <= data;
			if(rdy)begin
			rdy <= 0;
			end
		end
		else begin	
			if(count < 15)begin
			d <= {d[NBITS-1:1], xorin};
			rdy <= 0;
			count <= count + 1;
			end
			else begin
			rdy <= 1;
			seq <= seq + 1;
			end
		end
	end
end

always@(*)begin
	xorin = (d[12] ^ d[3] ^ d[1]);
	if(rdy)begin
	q = d[NBITS:1];
	dataOut[15:0] = q;
	dataOut[95:16] = data[95:16];
	dataOut[127:96] = seq;
	end
end

endmodule