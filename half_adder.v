`timescale 1ns / 1ps

module half_adder(
    input a,
    input b,
    output s,
    output c
    );

	and(c, a, b);
	xor(s, a, b);

endmodule
