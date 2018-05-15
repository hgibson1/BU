`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   10:20:58 04/10/2015
// Design Name:   counter
// Module Name:   X:/Counter/testc.v
// Project Name:  Counter
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

module testc;

	// Inputs
	reg clock;
	reg reset;
	reg trigger;

	// Outputs
	wire [7:0] count;

	// Instantiate the Unit Under Test (UUT)
	counter uut (
		.count(count), 
		.clock(clock), 
		.reset(reset), 
		.trigger(trigger)
	);
	
	always #5 clock = ~clock;

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

