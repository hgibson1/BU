`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   14:53:43 04/21/2015
// Design Name:   mux2x1
// Module Name:   X:/SevenSegmentDisplay/test_mux.v
// Project Name:  SevenSegmentDisplay
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: mux2x1
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module test_mux;

	// Inputs
	reg switch;
	reg [1:0] I;

	// Outputs
	wire out;

	// Instantiate the Unit Under Test (UUT)
	mux2x1 uut (
		.out(out), 
		.switch(switch), 
		.I(I)
	);

	initial begin
		// Initialize Inputs
		switch = 0;
		I = 2'b10;

		// Wait 100 ns for global reset to finish
		#100;
      switch = 1;
		// Add stimulus here

	end
      
endmodule

