module lfsr #(parameter NBITS)	// parameter not really needed...
	     (input clk,
	      input rst,
	      input we,
	      input [127:0] data,
	      output [NBITS-1:0] q);

reg [NBITS:1] d;
reg xorin;
reg setq;
reg count = 0;

always@(posedge clk, negedge rst)
begin
	if(rst)begin
		d <= 16'b0;
	end
	if(we) begin
		d <= data;
	end
		d <= {d[NBITS-1:1], xorin};
end


always@(*)begin
	xorin = (d[12] ^ d[3] ^ d[1]); 
end

assign q = d[NBITS-1:1];


endmodule
