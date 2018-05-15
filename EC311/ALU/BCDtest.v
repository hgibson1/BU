`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   10:11:17 03/31/2015
// Design Name:   BCDAdder
// Module Name:   X:/ALU/BCDtest.v
// Project Name:  ALU
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

module BCDtest;

	// Inputs
	reg [3:0] A;
	reg [3:0] B;
	reg Cin;

	// Outputs
	wire [3:0] S;
	wire Cout;

	// Instantiate the Unit Under Test (UUT)
	BCDAdder uut (
		.S(S), 
		.Cout(Cout), 
		.A(A), 
		.B(B), 
		.Cin(Cin)
	);

	initial begin
		// Initialize Inputs
		A = 0;
		B = 0;
		Cin = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
      
endmodule

