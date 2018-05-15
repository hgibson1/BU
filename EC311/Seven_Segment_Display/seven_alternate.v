`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:38:15 04/21/2015 
// Design Name: 
// Module Name:    seven_alternate 
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
module seven_segment_driver(
output [3:0] outbin, AN,
input clk, reset,
input [15:0] inbin
);
reg [3:0] outbin_state, AN_state;
reg [1:0] count;
always @(posedge clk or posedge reset)
begin
	if(reset)
		begin
			AN_state <= 4'b0;
			outbin_state <= 4'b0;
			count <= 2'b0;
		end
	else
		begin
			count <= count + 1'b1;
			case(count)
				2'b00: begin AN_state <= 4'b1110; outbin_state <= inbin[3:0]; end
				2'b01: begin AN_state <= 4'b1101; outbin_state <= inbin[7:4]; end
				2'b10: begin AN_state <= 4'b1011; outbin_state <= inbin[11:8]; end
				2'b11: begin AN_state <= 4'b0111; outbin_state <= inbin[15:12]; end
			endcase
		end
end
assign AN = AN_state;
assign outbin = outbin_state;
endmodule
