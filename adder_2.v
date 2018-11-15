`timescale 1ns / 1ps

module adder_2(
    input [1:0] a,
    input [1:0] b,
    input c_in,
    output [1:0] s,
    output c_out
    );
	 
	wire c_ripple;
	
	full_adder add1(
		.a(a[0]),
		.b(b[0]),
		.c_in(c_in),
		.s(s[0]),
		.c_out(c_ripple)
	);
						  
	 full_adder add2(
		.a(a[1]),
		.b(b[1]),
		.c_in(c_ripple),
		.s(s[1]),
		.c_out(c_out)
	);

endmodule
