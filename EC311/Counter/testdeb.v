`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   15:44:13 04/14/2015
// Design Name:   debouncer
// Module Name:   X:/Counter/testdeb.v
// Project Name:  Counter
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: debouncer
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module testdeb;

	// Inputs
	reg clock;
	reg button;

	// Outputs
	wire clean;

	// Instantiate the Unit Under Test (UUT)
	debouncer uut (
		.clean(clean), 
		.clock(clock), 
		.button(button)
	);
	always #5 clock = ~clock;
	initial begin
		// Initialize Inputs
		clock = 0;
		button = 0;

		// Wait 100 ns for global reset to finish
		#200;
       button = 1; 
		// Add stimulus here

	end
      
endmodule

