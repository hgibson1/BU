`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   11:36:34 03/24/2015
// Design Name:   AdderSubtractor
// Module Name:   X:/ALU/BinaryAddertest.v
// Project Name:  ALU
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: AdderSubtractor
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module BinaryAddertest;

	// Inputs
	reg [3:0] A;
	reg [3:0] B;
	reg M;

	// Outputs
	wire [3:0] S;
	wire C;
	wire V;

	// Instantiate the Unit Under Test (UUT)
	AdderSubtractor uut (
		.S(S), 
		.C(C), 
		.V(V), 
		.A(A), 
		.B(B), 
		.M(M)
	);

	initial begin
		// Initialize Inputs
		A = 0;
		B = 0;
		M = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
      
endmodule

