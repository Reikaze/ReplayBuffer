module lfsr #(parameter NBITS)	// parameter not really needed...
	     (input clk,
	      input rst,
	      input we,
	      input [NBITS-1:0] data;
	      output reg [NBITS-1:0] q);

reg [NBITS-1:0] d = 0;
reg xor = q[16] ^ q[15] ^ q[13] ^ q[4];


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