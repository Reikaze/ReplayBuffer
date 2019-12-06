`include "lfsr.v"
module lfsrtb;

	//parameter NUMB = 16;

	reg clk;
	reg rst;
	reg we;
	reg [127:0] data;
	wire [15:0] q;
	wire d_rdy;


initial
        $vcdpluson;

lfsr #(16) rr1
	(.clk(clk),
	.rst(rst),
	.we(we),
	.data(data),
	.q(q),
	.rdy(rdy));

initial
       $monitor($time, " we = %b rst = %b finish = %b\n\t\t\t data = %h\n\t\t\t d = %b\n\t\t\t q = %b\n", rst, we, rdy, data, lfsr.d, q);


initial
begin
        rst = 1'b0; we = 1;
#10	rst = 1'b1; we = 0;
	data = 128'h11112222333344445555666677771111;
/*
#10	data = 128'h11112222333344445555666688880000;
 	
#200	data = 128'h1111222233334444ffff666677770000;
#200	data = 128'h1111eeee333344445555666677770000;
*/

#3000 $finish;
end


initial
begin
       clk = 1'b0;
       forever #10 clk = ~clk;
end

endmodule
