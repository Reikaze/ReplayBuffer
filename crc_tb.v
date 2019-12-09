`include "crc.v"
module crc_tb;

	//parameter NUMB = 16;

	reg clk;
	reg rst;
	reg we;
	reg [95:0] data;
	wire [15:0] q;
	wire rdy;
    wire [127:0] dataOut;

crc #(16) rr1(.clk(clk),.rst(rst),.we(we),.data(data),.q(q),.dataOut(dataOut),.rdy(rdy));

initial
       $monitor($time, " we = %b rst = %b finish = %b\n\t\t\t data = %h\n\t\t\t d = %b\n\t\t\t dataOut = %h\n", rst, we, rdy, data, crc.d, dataOut);


initial
begin
        rst = 1'b0; we = 1;
#10	rst = 1'b1; we = 0;
	data = 96'h111122223333444455556666;
/*
#340	rst = 1'b0; 
#10	rst = 1'b1; we = 1;
#10	we = 0;
	data = 96'h11112222000044445555AAAA;
	
#200	data = 128'h1111222233334444ffff666677770000;
#200	data = 128'h1111eeee333344445555666677770000;
*/

#300 $finish;
end


initial
begin
       clk = 1'b0;
       forever #10 clk = ~clk;
end

endmodule
