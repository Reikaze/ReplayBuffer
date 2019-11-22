module lfsr #(parameter NBITS)	// parameter not really needed...
	     (input clk,
	      input rst,
	      input we,
	      input [127:0] data,
	      output [NBITS-1:0] q,
	      output d_fin);

reg [NBITS:1] d = 0;
reg xorin;

always@(posedge clk, negedge rst)
begin
	if(rst)
	begin
		d <= 16'b0;
	end
	if(we) 
		d <= data;
	else
		d <= {d[NBITS-1:1], xorin};
end

always@(*)begin
	xorin = (d[12] ^ d[3] ^ d[1]); 
end


assign q = d[NBITS-1:1];
assign d_fin = (d[NBITS:1] == data) ? 1'b1 : 1'b0;

endmodule
