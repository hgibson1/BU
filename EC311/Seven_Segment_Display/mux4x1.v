`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:58:52 04/21/2015 
// Design Name: 
// Module Name:    mux4x1 
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
module mux4x1(
output out,
input [1:0] S,
input [3:0] I
);
always @(S, I)
begin
	case(S)
		2'b00: assign out = I[0];
		2'b01: assign out = I[1];
		2'b10: assign out = I[2];
		2'b11: assign out = I[3];
	endcase
end
endmodule
