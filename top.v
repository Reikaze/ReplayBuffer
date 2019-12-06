//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/27/2019 10:18:29 AM
// Design Name: 
// Module Name: combination
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module top(clk, reset, we, oe, full, empty, w_addr, r_addr, din, dout, ack, nak);
    
input  [128:0] din;
input  clk, reset;
input  we, oe;
input  ack, nak;
output full, empty;
output [2:0] w_addr, r_addr;
output [128:0] dout; 

integer i;

reg [2:0]  w_addr, r_addr;
reg [128:0] ram_reg;
reg [128:0] memory [512:0];   

always@(posedge clk)
begin
   if(!ack && !nak)
   begin
       if(reset) 
       begin
           w_addr <=0;
           r_addr <=0;
       end
       else
         if( we && !full)
            if( w_addr >= 4)
                w_addr <= 0;
            else
                w_addr <= w_addr + 1;
              
         if( oe && !empty)
            if( r_addr >= 4)
                r_addr <= 0;
            else
                r_addr <= r_addr + 1;
      
      if (we) 
          memory[w_addr] <= din;
          
      ram_reg <= memory[r_addr]; 
    end
    if(ack && !nak)
     begin
        for(i=0; i<=r_addr; i=i+1)
        begin
                memory[i] <= memory[r_addr+i];
                memory[r_addr+i] <= 0;
                w_addr=0;
                r_addr=0;  
        end
     end   
     if(!ack && nak)
     begin
        for(i=0; i<=r_addr; i=i+1)
        begin
                ram_reg <= memory[i];
                #10;
        end
     end
end
  
  //always @(posedge clk) begin    
  //    ram_reg <= memory[r_addr];          
  //end
             
assign dout = ((!we && oe) || nak) ? ram_reg:8'hzz;

assign full = ((r_addr[2]!=w_addr[2]) && (r_addr[1:0]==w_addr[1:0]))?1'b1:1'b0;

assign empty= (r_addr == w_addr) ? 1'b1 : 1'b0;
endmodule
