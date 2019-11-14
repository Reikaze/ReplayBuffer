module lfsr #(parameter NBITS)	// parameter not really needed...
	     (input clk,
	      input rst,
	      input we,
	      input [NBITS-1:0] data;
	      output [NBITS-1:0] q);

reg [NBITS-1:0] d = 0;
reg xor = d[16] ^ d[15] ^ d[13] ^ d[4]; // X16 + X14 + X13 + X11 + 1


always@(posedge clk, negedge rst) begin
	if(!rst) begin
		d <= 16'b0;
	else if (we) begin
		d <= data;
	else
		d <= {d[NBITS-1:1], xor};
	end
end

assign q = d[NBITS-1:1];

endmodule
