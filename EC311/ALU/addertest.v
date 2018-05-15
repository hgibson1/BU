`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   09:41:43 03/31/2015
// Design Name:   Adder4bit
// Module Name:   X:/ALU/addertest.v
// Project Name:  ALU
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Adder4bit
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module addertest;

	// Inputs
	reg [3:0] A;
	reg [3:0] B;
	reg M;

	// Outputs
	wire [3:0] S;
	wire Cout;

	// Instantiate the Unit Under Test (UUT)
	Adder4bit uut (
		.S(S), 
		.Cout(Cout), 
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

