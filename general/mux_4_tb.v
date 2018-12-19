module mux_4_tb;

    // Inputs
    reg [31:0] data_0;
	reg [31:0] data_1;
	reg [31:0] data_2;
	reg [31:0] data_3;
    reg [1:0] select;

	// Outputs
	wire [31:0] data_out;

	// Test vector outputs
	reg signed [31:0] data_test;

	// Test values
	integer errors;
	integer vector_file;
	integer status;

	// Instantiate the Unit Under Test (UUT)
	mux_4 #(.width(32)) mp(
		.data_out(data_out),
		.data_0(data_0),
		.data_1(data_1),
		.data_2(data_2),
		.data_3(data_3),
		.select(select)
	);

	initial begin
		$dumpfile("mux.vcd");
		$dumpvars;

		// Initialize Inputs
		data_0 = 0;
        data_1 = 0;
        data_2 = 0;
		data_3 = 0;
        select = 0;

		// Initialize test values
		vector_file = $fopen("../../processor/tv/mux_tv.txt", "r");
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
			status = $fscanf(vector_file, "%d %d %d %d %d : %d\n",
                             data_0, data_1, data_2, data_3, select, data_test);
            status = $feof(vector_file);

            #5;

			if (data_out != data_test) begin
				errors = errors + 1;

				$display("Error:");
				$display("Inputs:           %-11d %-11d %-11d %-11d %-2d",
                         data_0, data_1, data_2, data_3, select);
				$display("Outputs:          %-11d", data_out);
				$display("Expected Outputs: %-11d", data_test);
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
