`timescale 1ns / 1ps

module adder_32(
	output [31:0] s,
    output c_out,
    input [31:0] a,
    input [31:0] b,
    input c_in
);

	wire c_ripple;
	 
	adder_16 add1(
		.s(s[15:0]),
		.c_out(c_ripple),
		.a(a[15:0]),
		.b(b[15:0]),
		.c_in(c_in)
	);
						  
	 adder_16 add2(
		.s(s[31:16]),
		.c_out(c_out),
		.a(a[31:16]),
		.b(b[31:16]),
		.c_in(c_ripple)
	);

endmodule
