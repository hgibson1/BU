`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   11:26:06 04/21/2015
// Design Name:   seven_display
// Module Name:   X:/SevenSegmentDisplay/test_display.v
// Project Name:  SevenSegmentDisplay
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: seven_display
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module test_display;

	// Inputs
	reg button;
	reg MHzclk;
	reg switch_control;
	reg reset;

	// Outputs
	wire [3:0] AN;
	wire [6:0] seven;

	// Instantiate the Unit Under Test (UUT)
	seven_display uut (
		.AN(AN), 
		.seven(seven), 
		.button(button), 
		.MHzclk(MHzclk), 
		.switch_control(switch_control), 
		.reset(reset)
	);
	
	always #10 MHzclk = ~MHzclk;
	initial begin
		// Initialize Inputs
		button = 0;
		MHzclk = 0;
		switch_control = 0;
		reset = 0;

		// Wait 100 ns for global reset to finish
		#100;
       reset = 1;
		 #100;
		 reset = 0;
		 button = 1;
		 #500
		 switch_control = 1;
	end
      
endmodule

