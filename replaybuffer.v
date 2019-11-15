module replaybuffer (clk, w_addr, din, we, oe, r_addr, dout);
//control inputs
input clk; //clock
input reset; //reset the buffer
input we; //Write enable
input tim_out// replay buffer time out
input [1:0] ack_nak; //ACK or NAK

//Data inputs 
input [11:0] seq; //seq
input [15:0] din; //data in

//output
output [15:0] dout; //data out
output [1024:0] reg TLP [64:0];
output ready; 

integer i;
integer j;
integer k;

//load input
initial begin
for (i = 0; i < 5; i= i + 1)
begin
	TLP[i] = din;
	//display initial TLP
	#1;
	for (i = 0; i <= 3; i = i + 1) begin
	   $display(" Address = %d,  TLP Data = %h",i,TLP [i]);
	end
end

//reset
always @(posedge clk, negedge reset)
begin
if (reset)
	for(j = 0; i <= 1023; j =j + 1) 
	begin
		TLP[i] <= 0;
	end
end

//Replay buffer ACK NAK logic
//need to impliment FIFO
always @(posedge clk, negedge reset)
begin
if (we)
	begin
		case (ack_nak)
		2'b00://not recieved - do nothing, assert ready
			ready = 1;
		2'b01://ACK - clear up to the ACK
			for(k = 0; k <= 1022; k = k + 1) 
			begin
				TLP[i] = TLP[i+1];
			end
			TLP[1023] = 0;
		2'b10://NAK - resend the first packet 
			dout <= TLP[0];
	end
end

//output ACK
always @(posedge clk) begin
	dout <= TLP[0];
end

endmodule