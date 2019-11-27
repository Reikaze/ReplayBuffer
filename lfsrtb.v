`include "lfsr.v"
module lfsrtb;

	parameter NUMB = 16;

	reg clk;
	reg rst;
	reg [127:0] data;
	wire [NUMB-1:0] q;
	


initial
        $vcdpluson;

lfsr #(.NBITS(NUMB)) rr1
	(.clk(clk),
	.rst(rst),
	.data(data),
	.q(q));

initial
       $monitor($time, " rst = %b, data = %h, q = %h\n",  rst,data,q);


initial
begin
        rst = 1'b0;
#10	data = 128'h11112222333344445555666677771212;
 	rst = 1'b1;
#10 	data = 128'h9999aaaabbbbccccddddeeeeffff5555;
#100	data = 128'h22223333444455556666777788881161;
#100	data = 128'h11113333555577779999bbbbddddfffDf;
#100;

end
