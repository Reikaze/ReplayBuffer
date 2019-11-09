module sram (clk, w_addr, din, we, oe, r_addr, dout);
input clk;
input [2:0] w_addr;
input [15:0] din;
input we, oe;
input [2:0] r_addr;
output [15:0] dout;
reg [15:0] ram_reg;
reg [15:0] memory [7:0];
integer    i;

initial begin
  memory [0] <= 10;
  memory [1] <= 20;
  memory [2] <= 30;
  memory [3] <= 50;
  #1;
  for (i = 0; i <= 3; i = i + 1) begin
       $display(" Address = %d,  Memory Data = %h",i,memory [i]);
  end
end

always @(posedge clk)
begin

if (we)
memory[w_addr] <= din;
end

always @(posedge clk) begin
ram_reg <= memory[r_addr];
end

assign dout = (~we && oe) ? ram_reg : 8'hzz;

endmodule
