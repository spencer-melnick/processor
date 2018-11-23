module alu_32_tb;

    // Inputs
    reg [31:0] op1;
    reg [31:0] op2;
    reg [1:0] control;
    reg enable;
    reg reset;
    reg clock;

	// Outputs
    wire [31:0] result;
    wire [31:0] extra;
    wire done;

	// Test vector outputs
	reg signed [31:0] result_test;
    reg signed [31:0] extra_test;

	// Test values
	integer errors;
	integer vector_file;
	integer status;

	// Instantiate the Unit Under Test (UUT)
	alu_32 uut(
        .result(result),
        .extra(extra),
        .done(done),
        .op1(op1),
        .op2(op2),
        .control(control),
        .enable(enable),
        .reset(reset),
        .clock(clock)
    );

	initial begin
		$dumpfile("alu_32.vcd");
		$dumpvars;

		// Initialize Inputs
        op1 = 0;
        op2 = 0;
        control = 0;
        enable = 0;
        reset = 0;
        clock = 0;

		// Initialize test values
		vector_file = $fopen("../tv/alu_32_tv.txt", "r");
		errors = 0;
		status = 0;

		// Check test vector file
		if (!vector_file) begin
			$display("Error: could not open test vector file");
			$finish;
		end

		// Wait 10 ns for global reset to finish
		#10;

        enable = 1;
		
		while (!status) begin
			// Read inputs
			status = $fscanf(vector_file, "%d %d %d : %d %d\n",
                             op1, op2, control, result_test, extra_test);
            status = $feof(vector_file);

            reset = 1;
            clock = 1;
            #5;
            reset = 0;
            clock = 0;
            #5;

            while (!done) begin
                clock = 1;
                #5;
                clock = 0;
                #5;
            end

			if (result != result_test || extra != extra_test) begin
				errors = errors + 1;

				$display("Error:");
				$display("Inputs:           %-11d %-11d %-2d", op1, op2, control);
				$display("Outputs:          %-11d %-11d", result, extra);
				$display("Expected Outputs: %-11d %-11d", result_test, extra_test);
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
