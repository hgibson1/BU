`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:07:09 03/24/2015 
// Design Name: 
// Module Name:    ALU 
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
module ALU(Y, A, B, S);
output [7:0] Y;
input [3:0] A, B;
input [1:0] S;
wire [7:0] bA, bcdA, mult, buff;

assign bA[6] = 1'b0;
assign bA[7] = 1'b0;
assign bcdA[5] = 1'b0;
assign bcdA[6] = 1'b0;
assign bcdA[7] = 1'b0;

AdderSubtractor binaryAdder(bA[3:0], bA[4], bA[5], A, B, 0);
BCDAdder bcdAdder(bcdA[3:0], bcdA[4], A, B, 0);
Multiplier multiplier(mult, A, B);
Buffer buffer(buff, A, B);

multiplexer multiplexer(Y, S[0], S[1], buff, bA, bcdA, mult);

endmodule
