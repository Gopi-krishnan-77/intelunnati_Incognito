module slow(clk,rst,start,X,Y,valid,quot,rem);

input clk;
input rst;
input start;
input [3:0]X,Y;
output [3:0]quot,rem;
output valid;

reg [7:0] Z,next_Z,Z_temp,Z_temp1;
reg next_state, pres_state;
reg [1:0] count,next_count;
reg valid, next_valid;

parameter IDLE = 1'b0;
parameter START = 1'b1;

assign rem = Z[7:4];
assign quot = Z[3:0];

always @ (posedge clk or negedge rst)
begin
if(!rst)
begin
  Z          <= 8'd0;
  valid      <= 1'b0;
  pres_state <= 1'b0;
  count      <= 2'd0;
end
else
begin
  Z          <= next_Z;
  valid      <= next_valid;
  pres_state <= next_state;
  count      <= next_count;
end
end

always @ (*)
begin 
case(pres_state)
IDLE:
begin
next_count = 2'b0;
next_valid = 1'b0;
if(start)
begin
    next_state = START;
    next_Z     = {4'd0,X};
end
else
begin
    next_state = pres_state;
    next_Z     = 8'd0;
end
end

START:
begin
next_count = count + 1'b1;
Z_temp     = Z << 1;
Z_temp1    = {Z_temp[7:4]-Y,Z_temp[3:0]};
next_Z     = Z_temp1[7] ? {Z_temp[7:4],Z_temp[3:1],1'b0} : 
                          {Z_temp1[7:4],Z_temp[3:1],1'b1};
next_valid = (&count) ? 1'b1 : 1'b0; 
next_state = (&count) ? IDLE : pres_state;	
end
endcase
end
endmodule
