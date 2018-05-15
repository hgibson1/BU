`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   11:37:06 03/24/2015
// Design Name:   Buffer
// Module Name:   X:/ALU/Buffertest.v
// Project Name:  ALU
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Buffer
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module Buffertest;

	// Inputs
	reg [3:0] in0;
	reg [3:0] in1;

	// Outputs
	wire [7:0] out;

	// Instantiate the Unit Under Test (UUT)
	Buffer uut (
		.out(out), 
		.in0(in0), 
		.in1(in1)
	);

	initial begin
		// Initialize Inputs
		in0 = 0;
		in1 = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
      
endmodule

