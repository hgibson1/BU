`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   11:42:49 04/21/2015
// Design Name:   seven_segment_driver
// Module Name:   X:/SevenSegmentDisplay/test_driver.v
// Project Name:  SevenSegmentDisplay
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: seven_segment_driver
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module test_driver;

	// Inputs
	reg clk;
	reg reset;
	reg [15:0] inbin;

	// Outputs
	wire [3:0] outbin;
	wire [3:0] AN;

	// Instantiate the Unit Under Test (UUT)
	seven_segment_driver uut (
		.outbin(outbin), 
		.AN(AN), 
		.clk(clk), 
		.reset(reset), 
		.inbin(inbin)
	);

	always #1000 clk = ~clk;
	initial begin
		// Initialize Inputs
		clk = 0;
		reset = 0;
		inbin = 0;

		// Wait 100 ns for global reset to finish
		#100;
		reset = 1;
		#100;
		reset = 0;  
		// Add stimulus here

	end
      
endmodule

