`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:20:50 03/17/2015 
// Design Name: 
// Module Name:    multiplier 
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
module Multiplier(out, A, B);
output [7:0] out;
input [3:0] A, B;
wire [3:0] r0, r1, r2, r3, s1, s2, s3;
wire w0, w1, w2, w3;

assign w0 = A[0] & B[0];

Adder4bit mult1(s1, w1, r1, r0, 1'b0);
Adder4bit mult2(s2, w2, r2, s1, 1'b0);
Adder4bit mult3(s3, w3, r3, s2, 1'b0);


assign r0[0] = A[0] & B[1];
assign r0[1] = A[0] & B[2];
assign r0[2] = A[0] & B[3];
assign r0[3] = 0;
assign r1[0] = A[1] & B[0];
assign r1[1] = A[1] & B[1];
assign r1[2] = A[1] & B[2];
assign r1[3] = A[1] & B[3];
assign r2[0] = A[2] & B[0];
assign r2[1] = A[2] & B[1];
assign r2[2] = A[2] & B[2];
assign r2[3] = A[2] & B[3];
assign r3[0] = A[3] & B[0];
assign r3[1] = A[3] & B[1];
assign r3[2] = A[3] & B[2];
assign r3[3] = A[3] & B[3];

assign out[0] = w0;
assign out[1] = w1;
assign out[2] = w2;
assign out[3] = w3;
assign out[4] = s3[0];
assign out[5] = s3[1];
assign out[6] = s3[2];
assign out[7] = s3[3];

endmodule
