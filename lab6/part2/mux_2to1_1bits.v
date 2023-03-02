/*
 *
 *	Gate level modeling for 2 to 1 MUX
 *
 */
`timescale 1ns/100ps

module mux_2to1_1bits(RESULT, INPUT1, INPUT2, SELECT);
	
	input INPUT1, INPUT2;			// 1-bit inputs 
	input SELECT;				// selection pin
	output RESULT;				// 1-bit output
	
	wire input1, input2, NOTSELECT;		// intermediate wires
	

	not n1(NOTSELECT,SELECT);
	and a1(input1,INPUT1,NOTSELECT);
	and a2(input2, INPUT2,SELECT);
	
	or o1(RESULT,input1,input2);
	
endmodule	
