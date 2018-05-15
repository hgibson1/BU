`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:24:37 02/24/2015 
// Design Name: 
// Module Name:    Adder 
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
module Adder(S, Cout, A, B, Cin);
   input A, B, Cin;
   output S, Cout;
	wire w1, w2, w3;
	
	xor XorAB(w1, A, B);
	xor XorSum(S, w1, Cin);
	and Carry1(w2, w1, Cin);
	and Carry2(w3, A, B);
	or CarryOut(Cout, w2, w3);

endmodule
