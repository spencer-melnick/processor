module left_shift_tb;

    // Inputs
    reg [31:0] data_in;

	// Outputs
	wire [31:0] data_out;

	// Test vector outputs
	reg signed [31:0] data_out_test;

	// Test values
	integer errors;
	integer vector_file;
	integer status;

	// Instantiate the Unit Under Test (UUT)
	left_shift uut(
		.data_out(data_out),
		.data_in(data_in)
	);

	initial begin
		$dumpfile("left_shift.vcd");
		$dumpvars;

		// Initialize Inputs
		data_in = 0;

		// Initialize test values
		vector_file = $fopen("../tv/left_shift_tv.txt", "r");
		errors = 0;
		status = 0;

		// Check test vector file
		if (!vector_file) begin
			$display("Error: could not open test vector file");
			$finish;
		end

		// Wait 10 ns for global reset to finish
		#10;
		
		while (!status) begin
			// Read inputs
			status = $fscanf(vector_file, "%32b : %32b\n", data_in, data_out_test);
            status = $feof(vector_file);

            #5;

			if (data_out != data_out_test) begin
				errors = errors + 1;

				$display("Error:");
				$display("Inputs:           %-32b", data_in);
				$display("Outputs:          %-32b", data_out);
				$display("Expected Outputs: %-32b", data_out_test);
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
