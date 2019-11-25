`include "crc.v"

module crc_tb;

reg clk_t;
reg rst_t;
reg we_t;
reg [95:0] tlp_in_t;

wire [127:0] crc_out_t;
wire lfsr_o;

initial
        $vcdpluson;

crc UUT(.clk(clk_t),.rst(rst_t),.tlp_in(tlp_in_t),.crc_out(crc_out_t));

initial
begin
       clk_t = 1'b0;
       forever #10 clk_t = ~clk_t;
end

initial
begin
rst_t = 1;
//we_t = 0;
#50 rst_t = 0; //we_t = 1;
tlp_in_t = 96'h123456789abcdefffff12345;
#100;
tlp_in_t = 96'h123456789fffff123456ffff;
#100;
tlp_in_t = 96'h987654321abcdefffff12345;
#100;
tlp_in_t = 96'h987654321fffffffff123456;
#100;
tlp_in_t = 96'h12345678912345ffffff1234;
#100;
#20 $finish;
end

endmodule
