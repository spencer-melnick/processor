`timescale 1ns / 1ps

module multiplier_32_tb;

	// Inputs
	reg [31:0] a;
	reg [31:0] b;
	reg clk;
	reg rst;
	reg ena;

	// Outputs
	wire [63:0] p;
	wire dne;
	
	// Temporaries
	reg [31:0] i;
	reg [31:0] errors;

	// Instantiate the Unit Under Test (UUT)
	multiplier_32 uut (
		.p(p),
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
		
		// Initialize temporaries
		errors = 0;

		// Wait 10 ns for global reset to finish
		#10;
		
		// Enable chip
		ena = 1;
        
		// Set operands
		a = 5;
		b = 6;
		
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
		
		if (errors == 0) begin
			$display("Simulation completed with no errors");
		end
		else begin
			$display("Simulation completed with %d errors", errors);
		end
		
		$finish;
    end
      
endmodule

