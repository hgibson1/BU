`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    08:59:38 03/24/2015 
// Design Name: 
// Module Name:    Buffer 
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
module Buffer(out, in0, in1);
output [7:0] out;
input [3:0] in0, in1;

assign out[0] = in0[0];
assign out[1] = in0[1];
assign out[2] = in0[2];
assign out[3] = in0[3];
assign out[4] = in1[0];
assign out[5] = in1[1];
assign out[6] = in1[2];
assign out[7] = in1[3];

endmodule
