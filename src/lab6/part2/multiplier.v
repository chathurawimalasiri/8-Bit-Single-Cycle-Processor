`timescale 1ns/100ps
`include "fullAdder.v"


module multiplier(RESULT,INPUT1,INPUT2);
	
	// port declarartion
	input [7:0] INPUT1,INPUT2;
	output [7:0] RESULT;

	// wires for the internal implementations
	wire temp0,temp1,temp2,temp3,temp4,temp5,temp6,temp7;
	
	// 1st row
	and c0r0_a1(temp0,INPUT1[0],INPUT2[0]);
	
	and c1r1_a1(h0,INPUT2[0],INPUT1[1]);
	and c1r1_a2(h1,INPUT2[1],INPUT1[0]);
	half_adder c1r1_h(temp1,carry_h1,h0,h1);
	
	and c2r1_a1(h2,INPUT2[0],INPUT1[2]);
	and c2r1_a2(h3,INPUT2[1],INPUT1[1]);
	full_adder c2r1_f(sum_f1,carry_f1,h2,h3,carry_h1);
	
	and c3r1_a1(h4,INPUT2[0],INPUT1[3]);
	and c3r1_a2(h5,INPUT2[1],INPUT1[2]);
	full_adder c3r1_f(sum_f2,carry_f2,h4,h5,carry_f1);
	
	and c4r1_a1(h6,INPUT2[0],INPUT1[4]);
	and c4r1_a2(h7,INPUT2[1],INPUT1[3]);
	full_adder c4r1_f(sum_f3,carry_f3,h6,h7,carry_f2);
	
	and c5r1_a1(h8,INPUT2[0],INPUT1[5]);
	and c5r1_a2(h9,INPUT2[1],INPUT1[4]);
	full_adder c5r1_f(sum_f4,carry_f4,h8,h9,carry_f3);
	
	and c6r1_a1(h10,INPUT2[0],INPUT1[6]);
	and c6r1_a2(h11,INPUT2[1],INPUT1[5]);
	full_adder c6r1_f(sum_f5,carry_f5,h10,h11,carry_f4);
	
	and c7r1_a1(h12,INPUT2[0],INPUT1[7]);
	and c7r1_a2(h13,INPUT2[1],INPUT1[6]);
	full_adder c7r1_f(sum_f6,carry_f6,h12,h13,carry_f5);
	
	
	
	// 2 row
	and c2r2_a1(h14,INPUT2[2],INPUT1[0]);
	half_adder c2r2_h(temp2,carry_h2,h14,sum_f1);
	
	and c3r2_a1(h15, INPUT2[2],INPUT1[1]);
	full_adder c3r2_f(sum_f7,carry_f7,h15,sum_f2,carry_h2);
	
	and c4r2_a1(h16, INPUT2[2],INPUT1[2]);
	full_adder c4r2_f(sum_f8,carry_f8,h16,sum_f3,carry_f7);
	
	and c5r2_a1(h17, INPUT2[2],INPUT1[3]);
	full_adder c5r2_f(sum_f9,carry_f9,h17,sum_f4,carry_f8);
	
	and c6r2_a1(h18, INPUT2[2],INPUT1[4]);
	full_adder c6r2_f(sum_f10,carry_f10,h18,sum_f5,carry_f9);
	
	and c7r2_a1(h18, INPUT2[2],INPUT1[5]);
	full_adder c7r2_f(sum_f11,carry_f11,h18,sum_f6,carry_f10);
	
	// 3 row
	and c3r3_a1(h19,INPUT2[3],INPUT1[0]);
	half_adder c3r3_h(temp3,carry_h3,h19,sum_f7);
	
	and c4r3_a1(h20,INPUT2[3],INPUT1[1]);
	full_adder c4r3_f(sum_f12,carry_f12,h20,sum_f8,carry_h3);
	
	and c5r3_a1(h21,INPUT2[3],INPUT1[2]);
	full_adder c5r3_f(sum_f13,carry_f13,h21,sum_f9,carry_f12);
	
	and c6r3_a1(h22,INPUT2[3],INPUT1[3]);
	full_adder c6r3_f(sum_f14,carry_f14,h22,sum_f10,carry_f13);
	
	and c7r3_a1(h23,INPUT2[3],INPUT1[4]);
	full_adder c7r3_f(sum_f15,carry_f15,h23,sum_f11,carry_f14);
	
	// 4 row
	and c4r4_a1(h24,INPUT2[4],INPUT1[0]);
	half_adder c4r4_h(temp4,carry_h4,h24,sum_f12);
	
	and c5r4_a1(h25,INPUT2[4],INPUT1[1]);
	full_adder c5r4_f(sum_f16,carry_f16,h25,sum_f13,carry_h4);
	
	and c6r4_a1(h26,INPUT2[4],INPUT1[2]);
	full_adder c6r4_f(sum_f17,carry_f17,h25,sum_f14,carry_f16);
	
	and c7r4_a1(h27,INPUT2[4],INPUT1[3]);
	full_adder c7r4_f(sum_f18,carry_f18,h27,sum_f15,carry_f17);
	
	
	// 5 row
	and c5r5_a1(h28,INPUT2[5],INPUT1[0]);
	half_adder c5r5_h(temp5,carry_h5,h28,sum_f16);
	
	and c6r5_a1(h29,INPUT2[5],INPUT1[1]);
	full_adder c6r5_f(sum_f19,carry_f19,h29,sum_f17,carry_h5);
	
	and c7r5_a1(h30,INPUT2[5],INPUT1[2]);
	full_adder c7r5_f(sum_f20,carry_f20,h30,sum_f18,carry_f19);
	
	// 6 row
	and c6r6_a1(h31,INPUT2[6],INPUT1[0]);
	half_adder c6r6_h(temp6,carry_h6,h31,sum_f19);
	
	and c7r6_a1(h32,INPUT2[6],INPUT1[1]);
	full_adder c7r6_f(sum_f21,carry_f20,h32,sum_f20,carry_h6);
	
	// 7 row
	and c7r7_a1(h33,INPUT2[7],INPUT1[0]);
	half_adder c7r7_h(temp7,carry_h7,h33,sum_f21);
	
	// final result 
	assign RESULT = {temp7,temp6,temp5,temp4,temp3,temp2,temp1,temp0};
	
endmodule