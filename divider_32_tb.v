`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   20:23:54 11/13/2018
// Design Name:   divider_32
// Module Name:   /home/spencer/School/Advanced Processors/ISE/processor/divider_32_tb.v
// Project Name:  processor
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: divider_32
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module divider_32_tb;

	// Inputs
	reg [31:0] a;
	reg [31:0] b;
	reg clk;
	reg rst;
	reg ena;

	// Outputs
	wire [31:0] q;
	wire [31:0] r;
	wire dne;

	// Instantiate the Unit Under Test (UUT)
	divider_32 uut (
		.q(q), 
		.r(r), 
		.dne(dne), 
		.a(a), 
		.b(b), 
		.clk(clk), 
		.rst(rst), 
		.ena(ena)
	);

	initial begin
		// Initialize Inputs
		a = 0;
		b = 0;
		clk = 0;
		rst = 0;
		ena = 0;

		// Wait 10 ns for global reset to finish
		#10;
        
		// Enable chip
		ena = 1;
        
		// Set operands
		a = 155;
		b = 25;
		
		// Reset computation
		rst = 1;
		clk = 1;
		#5;
		rst = 0;
		clk = 0;
		#5;
		
		// Run until done
		while (!dne) begin
			clk = 1;
			#5;
			clk = 0;
			#5;
		end

	end
      
endmodule

