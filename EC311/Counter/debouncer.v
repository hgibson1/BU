`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:17:09 03/31/2015 
// Design Name: 
// Module Name:    debouncer 
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
module debouncer(
output clean, 
input clock, button
);

reg [24:0] hold;

always @(posedge clock)
begin
		if(!button)
			hold <= 25'b0;
		else if (button)
			hold <= hold + 25'b1;
end

assign clean = (hold == 25'h1FFFFFF);

endmodule
