`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:31:20 02/24/2015 
// Design Name: 
// Module Name:    AdderSubtractor 
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
module AdderSubtractor(S, C, V, A, B, M);
	output [3:0] S; 
	output C, V;
	input M;
	input [3:0] A, B;
	wire C0, C1, C2, XB0out, XB1out, XB2out, XB3out;
	//determines bit sign
	xor XB0(XB0out, B[0], M);
	xor XB1(XB1out, B[1], M);
	xor XB2(XB2out, B[2], M);
	xor XB3(XB3out, B[3], M);
	//Order of adder inputs are (Sum, Cout, A, B, Cin)
	Adder bit0(S[0], C0, A[0], XB0out, M);
	Adder bit1(S[1], C1, A[1], XB1out, C0);
	Adder bit2(S[2], C2, A[2], XB2out, C1);
	Adder bit3(S[3], C, A[3], XB3out, C2);
	//determines carry out value
	xor carry(V, C, C2);
endmodule
