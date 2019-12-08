module seq(input [95:0] tlp_in,
	output [127:0] data_o);

reg [11:0] seq_num = 12'b0;
reg [15:0] seq_out;

always@(*)begin
	seq_num = seq_num + 1;
	seq_out = {4'b0,seq_num};
end

assign data_o = {seq_out,tlp_in,16'b0};

endmodule