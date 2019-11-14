module fifo(clk, reset, wr, rd, full, empty, w_addr, r_addr);
input                clk, reset;
input                wr,  rd;
output             full, empty;
output  [3:0]   w_addr, r_addr;
reg        [3:0]   w_addr, r_addr;

always@(posedge clk)
begin
   if(reset) 
   begin
       w_addr <=0;
       r_addr <=0;
   end
   else
     if( wr && !full)
        w_addr <= w_addr + 1;
     if( rd && !empty)
        r_addr <= r_addr + 1;
end

assign full = ((r_addr[2]!=w_addr[2]) && (r_addr[1:0]==w_addr[1:0]))?1'b1:1'b0;

assign empty= (r_addr == w_addr) ? 1'b1 : 1'b0;

endmodule
