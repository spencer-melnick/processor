`timescale 1ns / 1ps

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

	// Test vector outputs
	reg signed [31:0] q_test;
	reg signed [31:0] r_test;

	// Test values
	integer errors;
	integer vector_file;
	integer status;

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
		$dumpfile("divider_32.vcd");
		$dumpvars;

		// Initialize Inputs
		a = 0;
		b = 0;
		clk = 0;
		rst = 0;
		ena = 0;

		// Initialize test values
		vector_file = $fopen("../../processor/tv/divider_32_tv.txt", "r");
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
			status = $fscanf(vector_file, "%d %d : %d %d\n", a, b, q_test, r_test);
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

			if (q != q_test || r != r_test) begin
				errors = errors + 1;

				$display("Error:");
				$display("Inputs:           %-11d %-11d", a, b);
				$display("Outputs:          %-11d %-11d", q, r);
				$display("Expected Outputs: %-11d %-11d", q_test, r_test);
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

