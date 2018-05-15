`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:26:15 05/01/2015 
// Design Name: 
// Module Name:    clock_div108 
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
module clock_div108(
output out_clk,
input in_clk, reset
);
reg [26:0] count;

always@(posedge in_clk)
begin
	if (reset)
		count <= 27'b0;
	else
		count <= count + 27'b1;
end
assign out_clk = (count == 27'h2FAF080);
endmodule


