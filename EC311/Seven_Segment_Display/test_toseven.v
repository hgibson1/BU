`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   11:42:25 04/21/2015
// Design Name:   binary_segment
// Module Name:   X:/SevenSegmentDisplay/test_toseven.v
// Project Name:  SevenSegmentDisplay
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: binary_segment
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module test_toseven;

	// Inputs
	reg [3:0] bin;

	// Outputs
	wire [6:0] seven;

	// Instantiate the Unit Under Test (UUT)
	binary_segment uut (
		.seven(seven), 
		.bin(bin)
	);

	initial begin
		// Initialize Inputs
		bin = 0;

		// Wait 100 ns for global reset to finish
		#100;
		bin = 4'b0001;
		#100
		bin = 4'b0010;
		#100
		bin = 4'b0100;
		// Add stimulus here

	end
      
endmodule

