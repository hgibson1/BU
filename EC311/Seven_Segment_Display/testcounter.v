`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   08:54:07 04/28/2015
// Design Name:   counter
// Module Name:   X:/SevenSegmentDisplay/testcounter.v
// Project Name:  SevenSegmentDisplay
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: counter
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module testcounter;

	// Inputs
	reg clock;
	reg reset;
	reg trigger;

	// Outputs
	wire [15:0] count;

	// Instantiate the Unit Under Test (UUT)
	counter uut (
		.count(count), 
		.clock(clock), 
		.reset(reset), 
		.trigger(trigger)
	);
	always #10 clock = ~clock;
	initial begin
		// Initialize Inputs
		clock = 0;
		reset = 0;
		trigger = 0;

		// Wait 100 ns for global reset to finish
		#100;
		reset = 1;
		#100;
		reset = 0;
		trigger = 1;
        
		// Add stimulus here

	end
      
endmodule

