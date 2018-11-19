`timescale 1ns / 1ps

module adder_8(
    output [7:0] s,
    output c_out,
    input [7:0] a,
    input [7:0] b,
    input c_in
);

	wire c_ripple;
	 
	adder_4 add1(
		.s(s[3:0]),
		.c_out(c_ripple),
		.a(a[3:0]),
		.b(b[3:0]),
		.c_in(c_in)
	);
						  
	adder_4 add2(
		.s(s[7:4]),
		.c_out(c_out),
		.a(a[7:4]),
		.b(b[7:4]),
		.c_in(c_ripple)
	);

endmodule
