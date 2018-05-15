// Verilog test fixture created from schematic X:\LabB\storyboard.sch - Sat Feb 21 10:57:57 2015

`timescale 1ns / 1ps

module storyboard_storyboard_sch_tb();

// Inputs
   reg A;
   reg C;

// Output
   wire R;
   wire G;

// Bidirs

// Instantiate the UUT
   storyboard UUT (
		.A(A), 
		.C(C), 
		.R(R), 
		.G(G)
   );
// Initialize Inputs
   
       initial begin
		A = 0;
		C = 0;
		#(1000)
		C = 1;
		#(1000)
		A = 1;
		#(1000)
		A = 0;
  end
endmodule
