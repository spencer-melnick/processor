module sign_extend_tb;

    // Inputs
    reg signed [15:0] data_in;

	// Outputs
	wire signed [31:0] data_out;

	// Test values
	integer errors;
	integer vector_file;
	integer status;

	// Instantiate the Unit Under Test (UUT)
	sign_extend uut(
		.data_out(data_out),
		.data_in(data_in)
	);

	initial begin
		$dumpfile("sign_extend.vcd");
		$dumpvars;

		// Initialize Inputs
		data_in = 0;

		// Initialize test values
		vector_file = $fopen("../tv/sign_extend_tv.txt", "r");
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
			status = $fscanf(vector_file, "%d\n", data_in);
            status = $feof(vector_file);

            #5;

			if (data_out != data_in) begin
				errors = errors + 1;

				$display("Error:");
				$display("Inputs:           %d", data_in);
				$display("Outputs:          %d", data_out);
				$display("Expected Outputs: %d", data_in);
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
