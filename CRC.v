module CRC(input clock, input start, input data, output done, output reg [15:0] r);
parameter IDLE = 0
parameter CRC_CALC = 1;

wire x16 = data;
reg state = 0; 
reg [5:0] counter = 0;

always @ (posedge clock) begin
	case (state)
		IDLE: begin
			state <= (start) ? CRC_CALC : IDLE;
			r <= 16'hFFFF;
			counter <=47;
		end

		CRC_CALC: begin
			r[15] <= r[14] + r[15] + x16;
			r[14:3] <= r[13:2];
			r[2] <= r[1];
			r[1] <= r[0];
			r[0] <= r[15] + x16;
			counter <= counter - 1;
			state <= (counter == 1) ? IDLE:CRC_CALC;
		end
	endcase
	end 

	assign done = (counter == 0);
endmodule
