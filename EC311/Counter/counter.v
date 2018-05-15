`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:14:27 03/31/2015 
// Design Name: 
// Module Name:    counter 
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
module counter(
output [15:0] count,
input clock, reset, trigger
);
reg [15:0] counter;
always @(posedge clock or posedge reset)
begin
	if (reset)	
		counter <= 16'b0;	
	else
		if (trigger)
			counter <= counter + 16'b1;
		else
			counter <= counter;
end
assign count = counter;
endmodule
