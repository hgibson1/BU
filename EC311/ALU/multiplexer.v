`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:47:38 03/17/2015 
// Design Name: 
// Module Name:    multiplexer 
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
module multiplexer(Y,S0,S1,A0,A1,A2,A3);
input S0, S1;
input [7:0] A0, A1, A2, A3;
output [7:0] Y;

assign Y = (!S0 && !S1)? A0 : 
				(S0 && !S1)? A1 : 
				(!S0 && S1)? A2: 
				A3;
	
endmodule
