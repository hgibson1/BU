`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   11:36:51 03/24/2015
// Design Name:   Multiplier
// Module Name:   X:/ALU/Multipliertest.v
// Project Name:  ALU
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Multiplier
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module Multipliertest;

	// Inputs
	reg [3:0] A;
	reg [3:0] B;

	// Outputs
	wire [7:0] out;

	// Instantiate the Unit Under Test (UUT)
	Multiplier uut (
		.out(out), 
		.A(A), 
		.B(B)
	);

	initial begin
		// Initialize Inputs
		A = 0;
		B = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
      
endmodule

