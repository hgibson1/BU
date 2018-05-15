`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:14:34 04/21/2015 
// Design Name: 
// Module Name:    Display_encoder 
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
module binary_segment(
output [6:0] seven,
input [3:0] bin
);
reg [6:0] seven_state;
always@(bin)
begin
	case(bin)
		4'b0000: seven_state <= 7'b1000000;
		4'b0001: seven_state <= 7'b1111001;
		4'b0010: seven_state <= 7'b0100100;
		4'b0011: seven_state <= 7'b0110000;
		4'b0100: seven_state <= 7'b0011001;
		4'b0101: seven_state <= 7'b0010010;
		4'b0110: seven_state <= 7'b0000010;
		4'b0111: seven_state <= 7'b1111000;
		4'b1000: seven_state <= 7'b0000000;
		4'b1001: seven_state <= 7'b0010000;
		4'b1010: seven_state <= 7'b0001000;
		4'b1011: seven_state <= 7'b0000011;
		4'b1100: seven_state <= 7'b1000110;
		4'b1101: seven_state <= 7'b0100001;
		4'b1110: seven_state <= 7'b0000110;
		4'b1111: seven_state <= 7'b0001110;
		default: seven_state <= 7'b1111111;
	endcase
end
assign seven = seven_state;
endmodule
