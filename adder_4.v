`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    01:54:16 10/24/2018 
// Design Name: 
// Module Name:    adder_4 
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
module adder_4(
    input [3:0] a,
    input [3:0] b,
    input c_in,
    output [3:0] s,
    output c_out
    );

	 wire c_ripple;
	 
	 adder_2 add1(.a(a[1:0]),
					  .b(b[1:0]),
					  .c_in(c_in),
					  .s(s[1:0]),
					  .c_out(c_ripple));
						  
	 adder_2 add2(.a(a[3:2]),
					  .b(b[3:2]),
					  .c_in(c_ripple),
					  .s(s[3:2]),
					  .c_out(c_out));

endmodule