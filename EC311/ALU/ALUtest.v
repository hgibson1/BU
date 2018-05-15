`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   10:57:54 03/31/2015
// Design Name:   ALU
// Module Name:   X:/ALU/ALUtest.v
// Project Name:  ALU
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: ALU
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module ALUtest;

	// Inputs
	reg [3:0] A;
	reg [3:0] B;
	reg [1:0] S;

	// Outputs
	wire [7:0] Y;

	// Instantiate the Unit Under Test (UUT)
	ALU uut (
		.Y(Y), 
		.A(A), 
		.B(B), 
		.S(S)
	);

	initial begin
		// Initialize Inputs
		A = 0;
		B = 0;
		S = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
      
endmodule

