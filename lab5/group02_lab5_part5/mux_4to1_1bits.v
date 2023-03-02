/*
 *	gate level model for 4 to 1 MUX
 *
 *
 */

module mux_4to1_1bits(RESULT, INPUT1, INPUT2, INPUT3, INPUT4, SELECT);

	input INPUT1, INPUT2, INPUT3, INPUT4;			// 1 bits inputs
	input [1:0] SELECT;					// 2-bits selection
	output RESULT;						// 1 bit output
	
	// temporary wires 
	wire NOT_SELECT1,NOT_SELECT2;
	wire temInput1,temInput2,temInput3,temInput4;


	not n1(NOT_SELECT1,SELECT[0]);
	not n2(NOT_SELECT2,SELECT[1]);
	
	and a1(temInput1,INPUT1,NOT_SELECT1,NOT_SELECT2);	
	and a2(temInput2,INPUT2,SELECT[0],NOT_SELECT2);		
	and a3(temInput3,INPUT3,SELECT[1],NOT_SELECT1);		
	and a4(temInput4,INPUT4,SELECT[0],SELECT[1]);		
	
	or o1(RESULT,temInput1,temInput2,temInput3,temInput4);
	
endmodule
