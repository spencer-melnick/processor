`timescale 1ns / 1ps

module adder_32_tb;

	// Inputs
	reg [31:0] a;
	reg [31:0] b;
	reg c_in;

	// Outputs
	wire [31:0] s;
	wire c_out;
	
	// Temporaries
	reg [3:0] i;
	reg [63:0] errors;

	// Test vectors
	reg [103:0] test [7:0];

	// Instantiate the Unit Under Test (UUT)
	adder_32 uut (
		.a(a), 
		.b(b), 
		.c_in(c_in), 
		.s(s), 
		.c_out(c_out)
	);

	initial begin
		$dumpfile("adder_32.vcd");
		$dumpvars;

		// Initialize Inputs
		a = 0;
		b = 0;
		c_in = 0;

		// Load test values
		$readmemh("../tv/adder_32_tv.tv", test);
		i = 0;
		errors = 0;

		// Wait 10 ns for global reset to finish
		#10;
        
		while (test[i] !== 104'bx) begin
			// Apply inputs
			a = test[i][103:72];
			b = test[i][71:40];
			c_in = test[i][36];
			
			#5;

			if (s != test[i][35:4] || c_out != test[i][0]) begin
				errors = errors + 1;
				$display("Error on input %d", i);
				$display("          Input values: %d %d %d", a, b, c_in);
				$display("         Output values: %d %d", s, c_out);
				$display("Expected output values: %d %d", test[i][35:4], test[i][0]);
			end

			i = i + 1;
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

