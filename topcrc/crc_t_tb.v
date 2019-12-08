`include "crc_top.v"

module crc_t_tb;


reg clk, rst, we;
reg [95:0] tlp_in;

wire [127:0] crc_o;

crc_top top(.clk(clk), .rst(rst), .we(we), .tlp_in(tlp_in), .crc_o(crc_o));
initial
        $vcdpluson;
always  
       #5  clk =  ! clk; 



initial
        $monitor($time, " clk[%b] rst[%b] rdy[%b]\n\t\t\t tlp_in[%b]\n\t\t\t SEQ+TLP[%b]\n\t\t\t LFSR[%b]\n\t\t\t Final TLP = %b",clk,rst,we,seq.tlp_in,seq.data_o,lfsr.q,crc.crc_out);

initial begin
	rst = 1;
#10 	rst = 0;
	tlp_in = 96'h123456789abcdefffff12345;

#200 $finish;
end


endmodule