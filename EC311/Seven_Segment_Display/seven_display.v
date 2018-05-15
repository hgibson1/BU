`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:04:04 04/21/2015 
// Design Name: 
// Module Name:    seven_display 
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
module seven_display(
output [3:0] AN,
output [6:0] seven,
input button, MHzclk, switch_control, reset
);
wire clean, trigger, KHzclk, Hzclk;
wire [15:0] count;
wire [3:0] driver_out;
wire [1:0] muxIn;

debouncer Debouncer(clean, MHzclk, button);
clock_div64 clock_div1(KHzclk, MHzclk, reset);
clock_div108 clock_div2(Hzclk, MHzclk, reset);
assign muxIn[1] = Hzclk;
assign muxIn[0] = clean;

mux2x1 mux(trigger, switch_control, muxIn);
counter counter64(count, MHzclk, reset, trigger);

seven_segment_driver driver(driver_out, AN, KHzclk, reset, count);
binary_segment toseven(seven, driver_out);
endmodule
