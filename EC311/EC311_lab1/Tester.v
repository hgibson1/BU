// Verilog test fixture created from schematic X:\EC311Lab1\Lab1.sch - Fri Feb 20 17:14:01 2015

`timescale 1ns / 1ps

module Lab1_Lab1_sch_tb();

// Inputs
   reg XLXN_1;
   reg XLXN_2;

// Output
   wire XLXN_3;

// Bidirs

// Instantiate the UUT
   Lab1 UUT (
		.XLXN_1(XLXN_1), 
		.XLXN_2(XLXN_2), 
		.XLXN_3(XLXN_3)
   );
// Initialize Inputs
       initial begin
		XLXN_1 = 0;
		XLXN_2 = 0;
	end
endmodule
