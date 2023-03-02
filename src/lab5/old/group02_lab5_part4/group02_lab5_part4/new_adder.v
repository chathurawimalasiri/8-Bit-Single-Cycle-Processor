/*
 *
 *	Part 3
 *	New Adder with 2 units delay
 * 
 *
 */


module newAdder(RESULT, INPUT1, INPUT2);
	
	// port declaration
	input [31:0] INPUT1, INPUT2;
	output [31:0] RESULT;
	
	assign #2 RESULT = INPUT1 + INPUT2;

endmodule

