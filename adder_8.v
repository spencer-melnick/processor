`timescale 1ns / 1ps

module adder_8(
    input [7:0] a,
    input [7:0] b,
    input c_in,
    output [7:0] s,
    output c_out
);

	wire c_ripple;
	 
	adder_4 add1(
		.a(a[3:0]),
		.b(b[3:0]),
		.c_in(c_in),
		.s(s[3:0]),
		.c_out(c_ripple)
	);
						  
	adder_4 add2(
		.a(a[7:4]),
		.b(b[7:4]),
		.c_in(c_ripple),
		.s(s[7:4]),
		.c_out(c_out)
	);

endmodule
