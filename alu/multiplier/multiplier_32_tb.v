`timescale 1ns / 1ps

module multiplier_32_tb;

	// Inputs
	reg signed [31:0] a;
	reg signed [31:0] b;
	reg clk;
	reg rst;
	reg ena;

	// Outputs
	wire signed [63:0] p;
	wire dne;
	
	// Test vector outputs
	reg signed [63:0] p_test;

	// Test values
	integer errors;
	integer vector_file;
	integer status;

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
		$dumpfile("multiplier_32.vcd");
		$dumpvars;

		// Initialize Inputs
		a = 0;
		b = 0;
		clk = 0;
		rst = 0;
		ena = 0;

		// Initialize test values
		vector_file = $fopen("../tv/multiplier_32_tv.txt", "r");
		errors = 0;
		status = 0;

		// Check test vector file
		if (!vector_file) begin
			$display("Error: could not open test vector file");
			$finish;
		end

		// Wait 10 ns for global reset to finish
		#10;

		// Enable chip
		ena = 1;
		
		while (!status) begin
			// Read inputs
			status = $fscanf(vector_file, "%d %d : %d\n", a, b, p_test);
			status = $feof(vector_file);

			// Start operation
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

			if (p != p_test) begin
				errors = errors + 1;

				$display("Error:");
				$display("Inputs:           %-11d %-11d", a, b);
				$display("Outputs:          %-20d", p);
				$display("Expected Outputs: %-20d", p_test);
			end
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

