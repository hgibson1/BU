`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:56:46 04/21/2015 
// Design Name: 
// Module Name:    mux2x1 
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
module mux2x1(
output out,
input switch,
input [1:0] I
);
reg out_state;

always @(I, switch)
begin
	case(switch)
		1'b0: out_state <= I[0];
		1'b1: out_state <= I[1];
	endcase
end
assign out = out_state;
endmodule
