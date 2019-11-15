module lfsr #(parameter NBITS = 16)	// parameter not really needed...
	     (input clk,
	      input rst,
	      input we,
	      input [NBITS-1:0] data,
	      output [NBITS-1:0] q);

reg [NBITS:1] d = 0;
reg xorin;

always@(posedge clk, negedge rst)
begin
	if(rst)
	begin
		d <= 4'hFF;
	end
	else if(we) 
		d <= data;
	else
		d <= {d[NBITS-1:1], xorin};
end

always@(*)begin
	xorin = (d[16] ^ d[15] ^ d[13] ^ d[4]); // X16 + X14 + X13 + X11 + 1
end

assign q = d[NBITS-1:1];

endmodule
