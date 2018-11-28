module register_tb;

    // Inputs
    reg [4:0] read1_address;
    reg [4:0] read2_address;
    reg write_enable;
    reg [4:0] write_address;
    reg [31:0] data_in;

    // Outputs
    wire [31:0] data1_out;
    wire [31:0] data2_out;

    // Test vector outputs
	reg signed [31:0] data1_out_test;
    reg signed [31:0] data2_out_test;

	// Test values
	integer errors;
	integer vector_file;
	integer status;

    // Instantiate the Unit Under Test (UUT)
	register uut(
		.data1_out(data1_out),
		.data2_out(data2_out),
		.read1_address(read1_address),
		.read2_address(read2_address),
        .write_enable(write_enable),
		.write_address(write_address),
        .data_in(data_in)
	);

	initial begin
		$dumpfile("register.vcd");
		$dumpvars;

		// Initialize Inputs
		read1_address = 0;
        read2_address = 0;


		// Initialize test values
		vector_file = $fopen("../tv/register_tv.txt", "r");
		errors = 0;
		status = 0;

		// Check test vector file
		if (!vector_file) begin
			$display("Error: could not open test vector file");
			$finish;
		end

		// Wait 5 ns for global reset to finish
		#5;
		
		while (!status) begin
			// Read inputs
			status = $fscanf(vector_file, "%4x %4x %d %8x %8x : %8x %8x\n",
                             read1_address, read2_address,
                             write_enable, write_address, data_in,
                             data1_out_test, data2_out_test);
            status = $feof(vector_file);

            #5;

			if (data1_out != data1_out_test || data1_out != data1_out_test) begin
				errors = errors + 1;

				$display("Error:");
				$display("Inputs:           %4x %4x %d %8x %8x",
                         read1_address, read2_address, write_enable, write_address, data_in);
				$display("Outputs:          %8x %8x", data1_out, data2_out);
				$display("Expected Outputs: %8x %8x", data1_out_test, data2_out_test);
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
