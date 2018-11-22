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
	
	reg [63:0] multiplier;
	reg [63:0] multiplicand;
	reg sign;
	
	initial begin
		p = 0;
		dne = 0;
	end
	
	always @(posedge clk) begin
		if (ena) begin
			if (rst) begin
				// Convert operands to positive values
				if (a[31] == 1'b0) begin
					multiplier <= a;
				end else begin
					multiplier <= {32'b0, ~a} + 1;
				end

				if (b[31] == 1'b0) begin
					multiplicand <= b;
				end else begin
					multiplicand <= {32'b0, ~b} + 1;
				end

				// Store resultant sign bit
				sign <= a[31] ^ b[31];
				
				p <= 0;
				dne <= 0;
			end else if (!dne) begin
				if (!multiplier || !multiplicand) begin
					if (sign) begin
						p <= ~p + 1;
					end
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
