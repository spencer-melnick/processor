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
	reg [63:0] errors;

	// Instantiate the Unit Under Test (UUT)
	adder_32 uut (
		.a(a), 
		.b(b), 
		.c_in(c_in), 
		.s(s), 
		.c_out(c_out)
	);

	initial begin
		// Initialize Inputs
		a = 0;
		b = 0;
		c_in = 0;
		errors = 0;

		// Wait 10 ns for global reset to finish
		#10;
        
		// Add stimulus here
		a = 32'h7fffffff;
		b = 32'h7fffffff;
		c_in = 1;
					
		#5;
					
		if ((s !== 32'hffffffff) || (c_out !== 0)) begin
			$display("Error: inputs = %d %d %b", a[31:0], b[31:0], c_in);
			$display("		 outputs = %d %b", s, c_out);
			$display("		expected = %d %b", 32'hffffffff, 0);
						
			errors = errors + 1;
		end
		
		
		a = 0;
		b = 16;
		c_in = 0;
					
		#5;
					
		if ((s !== 16) || (c_out !== 0)) begin
			$display("Error: inputs = %d %d %b", a[31:0], b[31:0], c_in);
			$display("		 outputs = %d %b", s, c_out);
			$display("		expected = %d %b", 16, 0);
						
			errors = errors + 1;
		end
		
		
		a = 32'hffffffff;
		b = 32'hffffffff;
		c_in = 1;
					
		#5;
					
		if ((s !== 32'hffffffff) || (c_out !== 1)) begin
			$display("Error: inputs = %d %d %b", a[31:0], b[31:0], c_in);
			$display("		 outputs = %d %b", s, c_out);
			$display("		expected = %d %b", 32'hffffffff, 0);
						
			errors = errors + 1;
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

