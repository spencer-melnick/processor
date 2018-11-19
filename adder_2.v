`timescale 1ns / 1ps

module adder_2(
	output [1:0] s,
	output c_out,
	input [1:0] a,
	input [1:0] b,
	input c_in
);
	 
	wire c_ripple;
	
	full_adder add1(
		.s(s[0]),
		.c_out(c_ripple),
		.a(a[0]),
		.b(b[0]),
		.c_in(c_in)
	);
						  
	full_adder add2(
		.s(s[1]),
		.c_out(c_out),
		.a(a[1]),
		.b(b[1]),
		.c_in(c_ripple)
	);

endmodule
