`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:06:17 10/31/2018 
// Design Name: 
// Module Name:    multiplier_32 
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
module multiplier_32(
	output reg [63:0] p,
	output reg dne,
   input [31:0] a,
   input [31:0] b,
   input clk,
	input ena,
   input rst
   );
	
	reg [31:0] multiplier;
	reg [31:0] multiplicand;
	
	initial begin
		p = 0;
		dne = 0;
	end
	
	always @(posedge clk) begin
		if (ena) begin
			if (rst) begin
				multiplier <= a;
				multiplicand <= b;
				
				p <= 0;
				dne <= 0;
			end else if (!dne) begin
				if (!multiplier || !multiplicand) begin
					dne <= 1;
				end else if (multiplier[0]) begin
					p <= p + multiplicand;
				end
				
				multiplier <= multiplier >> 1;
				multiplicand <= multiplicand << 1;
			end
		end
	end
		

endmodule
