`include "crc.v"
`include "../lfsr/lfsr.v"
module crc_tb;

reg clk_t;
reg rst_t;
reg we;
reg rdy_in;

reg [95:0] tlp_in_t;

wire [15:0] lfsr_o;
wire [127:0] crc_out_t;
wire [127:0] data_o;
wire rdy;

initial
        $vcdpluson;


crc UUT(.rdy(rdy||rdy_in),.lfsr_in(lfsr_o),.tlp_in(tlp_in_t),.data_o(data_o),.crc_out(crc_out_t));

lfsr #(16) rr1 (.clk(clk_t), .rst(rst_t), .we(we), .data(data_o), .q(lfsr_o), .rdy(rdy));



initial
begin
       clk_t = 1'b0;
       forever #5 clk_t = ~clk_t;
end

initial
        $monitor($time, " rst = %b ready = %b tlp_in = %h\n\t\t\t TLP w/ Sequence# = %b\n\t\t\t lfsr = %b \n\t\t\t crc_out = %h \n",  rst_t, rdy, tlp_in_t,data_o, lfsr_o, crc_out_t);
	
initial
begin
rst_t = 0; we = 1;

#50 rst_t = 1; we = 0; rdy_in = 1;
tlp_in_t = 96'h123456789abcdefffff12345;

/*
tlp_in_t = 96'h123456789fffff123456ffff;

tlp_in_t = 96'h987654321abcdefffff12345;

tlp_in_t = 96'h987654321fffffffff123456;

tlp_in_t = 96'h12345678912345ffffff1234;

*/
end

initial begin
#500 $finish;
end

endmodule
