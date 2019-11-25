`include "lfsr.v"
module lfsrtb;

	parameter NUMB = 16;

	reg clk;
	reg we, rst;
	reg [127:0] data;
	wire [NUMB-1:0] q;
	reg [6:0] count;

	reg [127:0] din [0:3];
	reg [2:0] n = 0;

initial begin
din[0] = 128'h11112222333344445555666677778888;
din[1] = 128'h9999aaaabbbbccccddddeeeeffff0000;
din[2] = 128'h0000aaaabbbbccccddddeeeeffff0000;
din[3] = 128'h1111aaaabbbb1111ddddeeeeffff1111;
end

initial
        $vcdpluson;

lfsr #(.NBITS(NUMB)) rr1
	(.clk(clk),
	.rst(rst),
	.we(we),
	.data(data),
	.q(q));

always@(posedge clk, negedge rst)begin
	if(count < 127) begin
		#10 we <= 0;
		count = count + 1;
	end
	else begin
		#10 count = 0;
		we <= 1;
		rst <= 0;
		n <= n + 1; 
		data <= din[n];
	end
end


/*
initial
begin
        rst = 1'b1;
//	we = 1'b0;
	data = 128'h11112222333344445555666677778888;
	#20 rst = 1'b0;
//	#10 we = 1'b1;
//	#10 we = 1'b0;
	#300 data = 128'h9999aaaabbbbccccddddeeeeffff0000;
//	#10 we = 1'b1;
//	#10 we = 1'b0;

end
*/

initial
begin
       clk = 1'b0;
       forever #10 clk = ~clk;
end

initial
begin
       #10000 $finish;
end


endmodule
