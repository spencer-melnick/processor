`timescale 1ns / 1ps

module adder_16(
    input [15:0] a,
    input [15:0] b,
    input c_in,
    output [15:0] s,
    output c_out
);

	wire c_ripple;
	 
	adder_8 add1(
		.a(a[7:0]),
		.b(b[7:0]),
		.c_in(c_in),
		.s(s[7:0]),
		.c_out(c_ripple)
	);
						  
	adder_8 add2(
		.a(a[15:8]),
		.b(b[15:8]),
		.c_in(c_ripple),
		.s(s[15:8]),
		.c_out(c_out)
	);


endmodule
