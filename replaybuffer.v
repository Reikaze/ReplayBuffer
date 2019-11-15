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
output [63:0] dout; //data out
output reg [64:0] Buffer [1024:0];
output ready; 

integer i;
integer j;
integer k;
integer l;

//load input
always @(posedge clk or negedge reset) begin
    if (!reset) begin
        for (i = 0; i < 5; i= i + 1)
        begin
            Buffer[i]<= din;
        end
    end
end
endmodule

//reset
always @(posedge clk or negedge reset)
begin
if (reset)
	for(j = 0; j <= 1023; j =j + 1) 
	begin
		Buffer[j] <= 0;
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
		//get the value for the sequence number at bottom of the buffer
			l = [63:51]Buffer[0];
			for(l=; l<=seq;l = l + 1 )
			begin
				for(k = 0; k <= 1022; k = k + 1) 
				begin
					Buffer[i] = Buffer[i+1];
				end
				Buffer[1023] = 0;
			end
		2'b10://NAK - resend to seq
			//get the value for the sequence number at bottom of the buffer
			l = [63:51]Buffer[0];
			for(l=; l<=seq;l = l + 1 )
			begin
				dout <= Buffer[l];
			end
	end
end

//output ACK
always @(posedge clk) begin
	dout <= Buffer[0];
end

endmodule