`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:46:10 04/10/2015 
// Design Name: 
// Module Name:    debounced_counter 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module debounced_counter(
output[7:0] count,
input clock, button, reset
);
wire clean;

debouncer Debouncer(clean, clock, button);
counter Counter(count, clock, reset, clean);

endmodule
