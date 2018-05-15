`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:26:04 04/28/2015 
// Design Name: 
// Module Name:    clock_div64 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module clock_div64(
output out_clk,
input in_clk, reset
);
reg [15:0] count;

always@(posedge in_clk)
begin
	if (reset)
		count <= 16'b0;
	else
		count <= count + 16'b1;
end
assign out_clk = !(count < 16'h8000);
endmodule



