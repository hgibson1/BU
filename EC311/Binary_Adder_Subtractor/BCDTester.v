`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   11:22:01 03/03/2015
// Design Name:   BCDAdder
// Module Name:   X:/binaryaddersubtractor/BCDTester.v
// Project Name:  binaryaddersubtractor
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: BCDAdder
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module BCDTester;

	// Inputs
	reg A0;
	reg A1;
	reg A2;
	reg A3;
	reg B0;
	reg B1;
	reg B2;
	reg B3;
	reg Cin;

	// Outputs
	wire S1;
	wire S2;
	wire S4;
	wire S8;
	wire w3;
	wire w4;
	wire w5;
	wire Cout;

	// Instantiate the Unit Under Test (UUT)
	BCDAdder uut (
		.S1(S1), 
		.S2(S2), 
		.S4(S4), 
		.S8(S8), 
		.w3(w3), 
		.w4(w4), 
		.w5(w5), 
		.Cout(Cout), 
		.A0(A0), 
		.A1(A1), 
		.A2(A2), 
		.A3(A3), 
		.B0(B0), 
		.B1(B1), 
		.B2(B2), 
		.B3(B3), 
		.Cin(Cin)
	);

	initial begin
		// Initialize Inputs
		A0 = 0;
		A1 = 0;
		A2 = 0;
		A3 = 0;
		B0 = 0;
		B1 = 0;
		B2 = 0;
		B3 = 0;
		Cin = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
      
endmodule

