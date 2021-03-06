`timescale 1ns / 1ps

module full_adder_tb;

	// Inputs
	reg a;
	reg b;
	reg c_in;

	// Outputs
	wire s;
	wire c_out;

	// Test vector outputs
	reg s_test;
	reg c_out_test;

	// Test values
	integer errors;
	integer vector_file;
	integer status;

	// Instantiate the Unit Under Test (UUT)
	full_adder uut (
		.s(s), 
		.c_out(c_out),
		.a(a), 
		.b(b), 
		.c_in(c_in)
	);

	initial begin
		$dumpfile("full_adder.vcd");
		$dumpvars;

		// Initialize inputs
		a = 0;
		b = 0;
		c_in = 0;

		// Initialize test values
		vector_file = $fopen("../../processor/tv/full_adder_tv.txt", "r");
		errors = 0;
		status = 0;

		// Check test vector file
		if (!vector_file) begin
			$display("Error: could not open test vector file");
			$finish;
		end

		// Wait for global reset
		#5;

		while (!status) begin
			status = $fscanf(vector_file, "%d %d %d : %d %d\n", a, b, c_in, s_test, c_out_test);
			status = $feof(vector_file);

			#5;

			if (s != s_test || c_out != c_out_test) begin
				$display("Error:");
				$display("Inputs:               %-1d %-1d %-1d", a, b, c_in);
				$display("Outputs:              %-1d %-1d", s, c_out);
				$display("Expected outputs:     %-1d %-1d", s_test, c_out_test);
				errors = errors + 1;
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

