// Verilog test fixture created from schematic X:\LabA_1\stupidpieceofshit.sch - Fri Feb 20 18:11:14 2015

`timescale 1ns / 1ps

module stupidpieceofshit_stupidpieceofshit_sch_tb();

// Inputs
   reg A;
   reg B;

// Output
   wire port1;
   wire port2;
   wire port3;

// Bidirs

// Instantiate the UUT
   stupidpieceofshit UUT (
		.A(A), 
		.B(B), 
		.port1(port1), 
		.port2(port2), 
		.port3(port3)
   );
// Initialize Inputs
       initial begin
		A = 0;
		B = 0;
		#1000
		B = 1;
		#1000
		A = 1;
		#1000
		B = 0;
   end
endmodule
