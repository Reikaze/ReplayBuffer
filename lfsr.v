module lfsr #(parameter NBITS)	// parameter not really needed...
	     (input clk,
	      input rst,
	      input [127:0] data,
	      output [NBITS-1:0] q);

reg [NBITS:1] d = 1;
reg xorin;
reg [6:0] count;

always@(posedge clk, negedge rst)
begin
	if(!rst)
		d <= 'b1;
	if(count < 127) begin
		d <= data;
		count = count + 1;
	end
	else
	begin
		d <= {d[NBITS-1:1], xorin};
		count = 0;
	end
		
end

always@(*)begin
	xorin = (d[12] ^ d[3] ^ d[1]); 
end

assign q = d[NBITS:1];

endmodule
