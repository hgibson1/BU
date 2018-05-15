`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:24:26 03/03/2015 
// Design Name: 
// Module Name:    Adder4bit 
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
module Adder4bit(S,Cout,A,B,M);
output Cout;
output [3:0] S;
input M;
input [3:0] A, B;
wire C0, C1, C2;
//Order of adder inputs are (Sum, Cout, A, B, M)
Adder bit0(S[0], C0, A[0], B[0], M);
Adder bit1(S[1], C1, A[1], B[1], C0);
Adder bit2(S[2], C2, A[2], B[2], C1);
Adder bit3(S[3], Cout, A[3], B[3], C2);

endmodule
