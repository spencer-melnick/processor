`timescale 1ns / 1ps

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
