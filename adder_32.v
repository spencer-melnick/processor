`timescale 1ns / 1ps

module adder_32(
    input [31:0] a,
    input [31:0] b,
    input c_in,
    output [31:0] s,
    output c_out
);

	wire c_ripple;
	 
	adder_16 add1(
		.a(a[15:0]),
		.b(b[15:0]),
		.c_in(c_in),
		.s(s[15:0]),
		.c_out(c_ripple)
	);
						  
	 adder_16 add2(
		.a(a[31:16]),
		.b(b[31:16]),
		.c_in(c_ripple),
		.s(s[31:16]),
		.c_out(c_out)
	);

endmodule
