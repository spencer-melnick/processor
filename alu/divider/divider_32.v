`timescale 1ns / 1ps

module divider_32(
   	output reg [31:0] q,
	output reg [31:0] r,
   	output reg dne,
   	input [31:0] a,
   	input [31:0] b,
   	input clk,
   	input rst,
   	input ena
);
	 
	reg [31:0] dividend;
	reg [63:0] divisor;
	reg [6:0] iteration;
	
	always @(posedge clk) begin
		if (ena) begin
			if (rst) begin
				dividend <= a;
				divisor[63:32] <= b;
				divisor[31:0] <= 0;
				iteration <= 0;
				
				dne <= 0;
				q <= 0;
				r <= 0;
			end else begin if (!dne)
				// Main operation branch
			
				// Shift quotient left one and increment iteration
				q = q << 1;
				
				// If dividend is greater than divisor, subtract
				// and add 1 to the quotient
				if (dividend >= divisor) begin
					dividend = dividend - divisor;
					q[0] <= 1;
				end
				
				// Shift divisor right
				divisor = divisor >> 1;

				iteration = iteration + 1;
				
				// After 32 iterations, we're done
				if (iteration == 33) begin
					dne <= 1;
					r <= dividend;
				end
			end
		end
	end


endmodule
