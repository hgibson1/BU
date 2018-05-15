`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   11:51:36 04/21/2015
// Design Name:   clock_div16
// Module Name:   X:/SevenSegmentDisplay/test_clkdiv.v
// Project Name:  SevenSegmentDisplay
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: clock_div16
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module test_clkdiv;

	// Inputs
	reg in_clk;
	reg reset;
	// Outputs
	wire out_clk;

	// Instantiate the Unit Under Test (UUT)
	clock_div16 uut (
		.out_clk(out_clk), 
		.in_clk(in_clk),
		.reset(reset)
	);
	always #10 in_clk = ~in_clk;
	initial begin
		// Initialize Inputs
		in_clk = 0;
		reset = 0;
		// Wait 100 ns for global reset to finish
		#100;
      reset = 1;
		#100;
		reset = 0;
		// Add stimulus here

	end
      
endmodule

