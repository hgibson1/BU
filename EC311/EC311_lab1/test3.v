// Verilog test fixture created from schematic X:\LabA_1\stupidpieceofshit.sch - Sat Feb 21 10:21:18 2015

`timescale 1ns / 1ps

module stupidpieceofshit_stupidpieceofshit_sch_tb();

// Inputs
   reg A;
   reg B;

// Output
   wire F;

// Bidirs

// Instantiate the UUT
   stupidpieceofshit UUT (
		.A(A), 
		.B(B), 
		.F(F)
   );
// Initialize Inputs
 
      initial begin
		A = 0;
		B = 0;
		#10
		A = 1;
		#10
		B = 1;
		#10
		A = 0;
end
endmodule
