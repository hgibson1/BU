`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:45:32 03/03/2015 
// Design Name: 
// Module Name:    BCDAdder 
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
module BCDAdder(S, Cout, A, B, Cin);
output [3:0] S;
output Cout;
input [3:0] A, B;
input Cin;
wire [3:0] Z, In;
wire K, w1, w2, wCout, sCout;

Adder4bit adder1(Z, K, A, B, Cin);

and g1(w1, Z[3], Z[2]);
and g2(w2, Z[3], Z[1]);
or g3(wCout, w1, w2, K);

assign In[0] = 1'b0;
assign In[1] = wCout;
assign In[2] = wCout;
assign In[3] = 1'b0;

Adder4bit adder2(S, sCout, In, Z, 1'b0);

assign Cout = wCout;
endmodule
