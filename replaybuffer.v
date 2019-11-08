module replaybuffer (clk, w_addr, din, we, oe, r_addr, dout);
input clk; //clock
input we, oe; //Write enable, out enable
input reset; //reset the buffer
input address; //placement in buffer
input tim_out// replay buffer time out
input [1:0] ack_nak; //ACK or NAK
input [11:0] seq;
input ready;
input [15:0] din; //data in
output [15:0] dout; //data out
reg [15:0] ram_reg;
reg [15:0] memory [7:0];
integer    i;

initial begin
#1;
  for (i = 0; i <= 3; i = i + 1) begin
       $display(" Address = %d,  Memory Data = %h",i,memory [i]);
  end
end
//reset
always @(posedge clk, negedge reset)
begin
if (reset)
	for(j = 0; j <= 7; j++) 
	begin
		memory[j] <= 0;
end

always @(posedge clk, negedge reset)
begin
case (ack_nak)
2'b00://not recieved
2'b01://ACK
2'b10://NAK

i = 0;

	else if (we)
		memory[addr] <= din;
		i++;
	end
end

always @(posedge clk) begin
	ram_reg <= memory[r_addr];
end

assign dout = (~we && oe) ? ram_reg : 8'hzz;

endmodule