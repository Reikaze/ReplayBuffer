`include "lfsr.v"
module lfsrtb;

	parameter NUMB = 16;

	reg clk;
	reg we, rst;
	reg [NUMB-1:0] data;
	wire [NUMB-1:0] d, q;

initial
        $vcdpluson;

lfsr #(.NBITS(NUMB)) rr1
	(.clk(clk),
	.rst(rst),
	.we(we),
	.data(data),
	.q(d));
initial
begin
        rst = 1'b1;
	we = 1'b0;
	data = 16'b0000000000001001;
	#20 rst = 1'b0;
	#50 we = 1'b1;
	#100 we = 1'b0;
end


initial
begin
       clk = 1'b0;
       forever #10 clk = ~clk;
end

initial
begin
       #1000 $finish;
end


endmodule