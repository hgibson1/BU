`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   17:30:11 04/10/2015
// Design Name:   debounced_counter
// Module Name:   X:/Counter/testdc.v
// Project Name:  Counter
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: debounced_counter
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module testdc;

	// Inputs
	reg clock;
	reg button;
	reg reset;

	// Outputs
	wire [7:0] count;

	// Instantiate the Unit Under Test (UUT)
	debounced_counter uut (
		.count(count), 
		.clock(clock), 
		.button(button), 
		.reset(reset)
	);
	always #5 clock = ~clock;
	initial begin
		// Initialize Inputs
		clock = 0;
		button = 0;
		reset = 0;

		// Wait 100 ns for global reset to finish
		#200;
      reset = 1;
		#200;
		reset = 0;
		button = 1;
		// Add stimulus here

	end
      
endmodule

