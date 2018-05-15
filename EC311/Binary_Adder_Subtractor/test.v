`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   10:52:37 02/24/2015
// Design Name:   AdderSubtractor
// Module Name:   X:/binaryaddersubtractor/test.v
// Project Name:  binaryaddersubtractor
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

module test;

	// Inputs
	reg M;
	reg A0;
	reg B0;
	reg A1;
	reg B1;
	reg A2;
	reg B2;
	reg A3;
	reg B3;

	// Outputs
	wire S0;
	wire S1;
	wire S2;
	wire S3;
	wire C;
	wire V;

	// Instantiate the Unit Under Test (UUT)
	AdderSubtractor uut (
		.M(M), 
		.A0(A0), 
		.B0(B0), 
		.A1(A1), 
		.B1(B1), 
		.A2(A2), 
		.B2(B2), 
		.A3(A3), 
		.B3(B3), 
		.S0(S0), 
		.S1(S1), 
		.S2(S2), 
		.S3(S3), 
		.C(C), 
		.V(V)
	);

	initial begin
		// Initialize Inputs
		M = 0;
		A0 = 0;
		B0 = 0;
		A1 = 0;
		B1 = 0;
		A2 = 0;
		B2 = 0;
		A3 = 0;
		B3 = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		#(100) A0 = 1;
		#(100) B0 = 1;
		#(100) A1 = 1;
		#(100) B1 = 1;
		#(100) A2 = 1; 
		#(100) B2 = 1;
		#(100) A3 = 1;
		#(100) B3 = 1;
		#(100) M = 1;
		#(100) A0 = 0;
		#(100) B0 = 0;
		#(100) A1 = 0;
		#(100) B1 = 0;
		#(100) A2 = 0;
		#(100) B2 = 0;
		#(100) A3 = 0;
		#(100) B3 = 0;
	end      
endmodule

