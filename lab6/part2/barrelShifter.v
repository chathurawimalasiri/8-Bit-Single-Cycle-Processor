`timescale 1ns/100ps
`include "mux_2to1_1bits.v"
`include "mux_2to1_8bits.v"
`include "mux_4to1_1bits.v"
`include "mux_4to1_8bits.v"

module barrelShifter(OUTPUT,INPUT,SHIFT_VAL,SHIFT_TYPE);
	
	// input-output port declarartion
	input [7:0] INPUT,SHIFT_VAL;
	input [1:0] SHIFT_TYPE;
	output [7:0] OUTPUT;
	
	// other ports
	wire TEMP1,TEMP2,TEMP3,TEMP4,TEMP5,TEMP6,TEMP7;							// temporary 1-bit wires
	wire SHIFT_DIRECTION;										// direction of the shift
	wire [7:0] LAYER4_SECOND_IN;  									//second option of the layer 
	wire [7:0] INLINE0, INLINE1, INLINE2, INLINE3, OUTLINE; 					// 8-bits intermediate lines
	
	
	
	// MUX for select sll, srl, sra, ror 
    	mux_4to1_1bits modeMux1(TEMP1,1'b0, INPUT[7], INLINE0[7], 1'b0, SHIFT_TYPE);    
    	mux_4to1_1bits modeMux2(TEMP2,1'b0, INPUT[7], INLINE1[6], 1'b0,  SHIFT_TYPE);
    	mux_4to1_1bits modeMux3(TEMP3,1'b0, INPUT[7], INLINE1[7], 1'b0,  SHIFT_TYPE);
    	mux_4to1_1bits modeMux4(TEMP4,1'b0, INPUT[7], INLINE2[4], 1'b0,  SHIFT_TYPE);
    	mux_4to1_1bits modeMux5(TEMP5,1'b0, INPUT[7], INLINE2[5], 1'b0,  SHIFT_TYPE);
    	mux_4to1_1bits modeMux6(TEMP6,1'b0, INPUT[7], INLINE2[6], 1'b0,  SHIFT_TYPE);
    	mux_4to1_1bits modeMux7(TEMP7,1'b0, INPUT[7], INLINE2[7], 1'b0,  SHIFT_TYPE);
	
	mux_2to1_8bits muxIn(INLINE0, INPUT, {INPUT[0],INPUT[1],INPUT[2],INPUT[3],INPUT[4],INPUT[5],INPUT[6],INPUT[7]}, SHIFT_DIRECTION);
    	mux_2to1_8bits #(2) muxOut(OUTPUT,OUTLINE, {OUTLINE[0],OUTLINE[1],OUTLINE[2],OUTLINE[3],OUTLINE[4],OUTLINE[5],OUTLINE[6],OUTLINE[7]},  SHIFT_DIRECTION);
	
	// layers of the barrel shifter
	// 1st layer
	mux_2to1_1bits col1Mux1(INLINE1[0], INLINE0[0], TEMP1, SHIFT_VAL[0]);  
    	mux_2to1_1bits col1Mux2(INLINE1[1],INLINE0[1], INLINE0[0],  SHIFT_VAL[0]); 
    	mux_2to1_1bits col1Mux3(INLINE1[2],INLINE0[2], INLINE0[1],  SHIFT_VAL[0]); 
    	mux_2to1_1bits col1Mux4(INLINE1[3],INLINE0[3], INLINE0[2],  SHIFT_VAL[0]); 
    	mux_2to1_1bits col1Mux5(INLINE1[4],INLINE0[4], INLINE0[3],  SHIFT_VAL[0]); 
    	mux_2to1_1bits col1Mux6(INLINE1[5],INLINE0[5], INLINE0[4],  SHIFT_VAL[0]); 
    	mux_2to1_1bits col1Mux7(INLINE1[6],INLINE0[6], INLINE0[5],  SHIFT_VAL[0]); 
    	mux_2to1_1bits col1Mux8(INLINE1[7],INLINE0[7], INLINE0[6],  SHIFT_VAL[0]);
	

	// 2nd layer
	mux_2to1_1bits col2Mux1(INLINE2[0],INLINE1[0], TEMP2,  SHIFT_VAL[1]);
    	mux_2to1_1bits col2Mux2(INLINE2[1],INLINE1[1], TEMP3,  SHIFT_VAL[1]); 
    	mux_2to1_1bits col2Mux3(INLINE2[2],INLINE1[2], INLINE1[0],  SHIFT_VAL[1]); 
    	mux_2to1_1bits col2Mux4(INLINE2[3],INLINE1[3], INLINE1[1],  SHIFT_VAL[1]); 
    	mux_2to1_1bits col2Mux5(INLINE2[4],INLINE1[4], INLINE1[2],  SHIFT_VAL[1]); 
    	mux_2to1_1bits col2Mux6(INLINE2[5],INLINE1[5], INLINE1[3],  SHIFT_VAL[1]); 
    	mux_2to1_1bits col2Mux7(INLINE2[6],INLINE1[6], INLINE1[4],  SHIFT_VAL[1]); 
    	mux_2to1_1bits col2Mux8(INLINE2[7],INLINE1[7], INLINE1[5],  SHIFT_VAL[1]);
	
	
	// 3rd layer
	mux_2to1_1bits col3Mux1(INLINE3[0],INLINE2[0], TEMP4,  SHIFT_VAL[2]); 
    	mux_2to1_1bits col3Mux2(INLINE3[1],INLINE2[1], TEMP5,  SHIFT_VAL[2]); 
    	mux_2to1_1bits col3Mux3(INLINE3[2],INLINE2[2], TEMP6,  SHIFT_VAL[2]); 
    	mux_2to1_1bits col3Mux4(INLINE3[3],INLINE2[3], TEMP7,  SHIFT_VAL[2]); 
    	mux_2to1_1bits col3Mux5(INLINE3[4],INLINE2[4], INLINE2[0],  SHIFT_VAL[2]); 
    	mux_2to1_1bits col3Mux6(INLINE3[5],INLINE2[5], INLINE2[1],  SHIFT_VAL[2]); 
    	mux_2to1_1bits col3Mux7(INLINE3[6],INLINE2[6], INLINE2[2],  SHIFT_VAL[2]); 
    	mux_2to1_1bits col3Mux8(INLINE3[7],INLINE2[7], INLINE2[3],  SHIFT_VAL[2]);
	
	
	// 4th layer
    	mux_2to1_8bits col4Mux1(OUTLINE,INLINE3, LAYER4_SECOND_IN,  (SHIFT_VAL[3]|SHIFT_VAL[4]|SHIFT_VAL[5]|SHIFT_VAL[6]|SHIFT_VAL[7]));

	
	mux_4to1_1bits col5Mux1(SHIFT_DIRECTION, 1'b1, 1'b1, 1'b1, 1'b0, SHIFT_TYPE);
	mux_4to1_8bits col5Mux2(LAYER4_SECOND_IN, 8'b00000000, {8{INPUT[7]}}, INLINE3, 8'b00000000, SHIFT_TYPE);
	
	
	
endmodule	
	
	
	
	
	
	
	
	
	
