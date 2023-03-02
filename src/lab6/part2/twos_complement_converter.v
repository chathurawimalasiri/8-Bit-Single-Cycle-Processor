/*
 *
 *	Part 3
 *	2s complement converter
 *
 *
 */ 
`timescale 1ns/100ps
module twos_complement_converter(RESULT, INPUT);
	
	// port declaration
	input [7:0] INPUT;
	output [7:0] RESULT;

	assign #1 RESULT = ~INPUT + 8'b1; 	// convert to 2s complement


endmodule

