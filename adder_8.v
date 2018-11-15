`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    02:02:34 10/24/2018 
// Design Name: 
// Module Name:    adder_8 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module adder_8(
    input [7:0] a,
    input [7:0] b,
    input c_in,
    output [7:0] s,
    output c_out
    );

	 wire c_ripple;
	 
	 adder_4 add1(.a(a[3:0]),
					  .b(b[3:0]),
					  .c_in(c_in),
					  .s(s[3:0]),
					  .c_out(c_ripple));
						  
	 adder_4 add2(.a(a[7:4]),
					  .b(b[7:4]),
					  .c_in(c_ripple),
					  .s(s[7:4]),
					  .c_out(c_out));

endmodule
