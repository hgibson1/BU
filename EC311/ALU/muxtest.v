`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   10:33:33 03/31/2015
// Design Name:   multiplexer
// Module Name:   X:/ALU/muxtest.v
// Project Name:  ALU
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: multiplexer
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module muxtest;

	// Inputs
	reg S0;
	reg S1;
	reg [7:0] A0;
	reg [7:0] A1;
	reg [7:0] A2;
	reg [7:0] A3;

	// Outputs
	wire [7:0] Y;

	// Instantiate the Unit Under Test (UUT)
	multiplexer uut (
		.Y(Y), 
		.S0(S0), 
		.S1(S1), 
		.A0(A0), 
		.A1(A1), 
		.A2(A2), 
		.A3(A3)
	);

	initial begin
		// Initialize Inputs
		S0 = 0;
		S1 = 0;
		A0 = 0;
		A1 = 0;
		A2 = 0;
		A3 = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
      
endmodule

