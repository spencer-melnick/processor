`timescale 1ns / 1ps

module full_adder(
    input a,
    input b,
    input c_in,
    output s,
    output c_out
    );
	 
	 wire c_half1, c_half2, s_half;
	 
	 half_adder h_add1(.a(a),
							 .b(b),
							 .s(s_half),
							 .c(c_half1));
							
	 half_adder h_add2(.a(c_in),
							 .b(s_half),
							 .s(s),
							 .c(c_half2));
							 
	 or(c_out, c_half1, c_half2);

endmodule
