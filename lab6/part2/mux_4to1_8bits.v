/*
 *	gate level model for 8bits 4 to 1 MUX
 *	
 *
 */
 `timescale 1ns/100ps
 module mux_4to1_8bits(RESULT, INPUT1, INPUT2, INPUT3, INPUT4, SELECT);
 
	input [7:0]INPUT1, INPUT2, INPUT3, INPUT4;	// 8-bits inputs
	input [1:0] SELECT;				// 2-bits selection
	output [7:0]RESULT;				// 8-bits output

	// temporary wires
	wire NOT_SELECT1,NOT_SELECT2;
	wire [7:0] temInput1,temInput2,temInput3,temInput4;
	
	not n1(NOT_SELECT1,SELECT[0]);
	not n2(NOT_SELECT2,SELECT[1]);
	
	// 1st layer
	and a1(temInput1[0],INPUT1[0],NOT_SELECT1,NOT_SELECT2);	
	and a2(temInput2[0],INPUT2[0],SELECT[0],NOT_SELECT2);		
	and a3(temInput3[0],INPUT3[0],SELECT[1],NOT_SELECT1);		
	and a4(temInput4[0],INPUT4[0],SELECT[0],SELECT[1]);		
	
	or o1(RESULT[0],temInput1[0],temInput2[0],temInput3[0],temInput4[0]);
	
	// 2nd layer
	and a1(temInput1[1],INPUT1[1],NOT_SELECT1,NOT_SELECT2);	
	and a2(temInput2[1],INPUT2[1],SELECT[0],NOT_SELECT2);		
	and a3(temInput3[1],INPUT3[1],SELECT[1],NOT_SELECT1);		
	and a4(temInput4[1],INPUT4[1],SELECT[0],SELECT[1]);		
	
	or o1(RESULT[1],temInput1[1],temInput2[1],temInput3[1],temInput4[1]);
	
	// 3rd layer
	and a1(temInput1[2],INPUT1[2],NOT_SELECT1,NOT_SELECT2);	
	and a2(temInput2[2],INPUT2[2],SELECT[0],NOT_SELECT2);		
	and a3(temInput3[2],INPUT3[2],SELECT[1],NOT_SELECT1);		
	and a4(temInput4[2],INPUT4[2],SELECT[0],SELECT[1]);		
	
	or o1(RESULT[2],temInput1[2],temInput2[2],temInput3[2],temInput4[2]);
	
	// 4th layer
	and a1(temInput1[3],INPUT1[3],NOT_SELECT1,NOT_SELECT2);	
	and a2(temInput2[3],INPUT2[3],SELECT[0],NOT_SELECT2);		
	and a3(temInput3[3],INPUT3[3],SELECT[1],NOT_SELECT1);		
	and a4(temInput4[3],INPUT4[3],SELECT[0],SELECT[1]);		
	
	or o1(RESULT[3],temInput1[3],temInput2[3],temInput3[3],temInput4[3]);
	
	// 5th layer
	and a1(temInput1[4],INPUT1[4],NOT_SELECT1,NOT_SELECT2);	
	and a2(temInput2[4],INPUT2[4],SELECT[0],NOT_SELECT2);		
	and a3(temInput3[4],INPUT3[4],SELECT[1],NOT_SELECT1);		
	and a4(temInput4[4],INPUT4[4],SELECT[0],SELECT[1]);		
	
	or o1(RESULT[4],temInput1[4],temInput2[4],temInput3[4],temInput4[4]);
	
	// 6th layer
	and a1(temInput1[5],INPUT1[5],NOT_SELECT1,NOT_SELECT2);	
	and a2(temInput2[5],INPUT2[5],SELECT[0],NOT_SELECT2);		
	and a3(temInput3[5],INPUT3[5],SELECT[1],NOT_SELECT1);		
	and a4(temInput4[5],INPUT4[5],SELECT[0],SELECT[1]);		
	
	or o1(RESULT[5],temInput1[5],temInput2[5],temInput3[5],temInput4[5]);
	
	// 7th layer
	and a1(temInput1[6],INPUT1[6],NOT_SELECT1,NOT_SELECT2);	
	and a2(temInput2[6],INPUT2[6],SELECT[0],NOT_SELECT2);		
	and a3(temInput3[6],INPUT3[6],SELECT[1],NOT_SELECT1);		
	and a4(temInput4[6],INPUT4[6],SELECT[0],SELECT[1]);		
	
	or o1(RESULT[6],temInput1[6],temInput2[6],temInput3[6],temInput4[6]);
	
	// 8th layer
	and a1(temInput1[7],INPUT1[7],NOT_SELECT1,NOT_SELECT2);	
	and a2(temInput2[7],INPUT2[7],SELECT[0],NOT_SELECT2);		
	and a3(temInput3[7],INPUT3[7],SELECT[1],NOT_SELECT1);		
	and a4(temInput4[7],INPUT4[7],SELECT[0],SELECT[1]);		
	
	or o1(RESULT[7],temInput1[7],temInput2[7],temInput3[7],temInput4[7]);
	
 
 
 endmodule
