`timescale 1ns/100ps
`include "halfAdder.v"

// full adder module
module full_adder(SUM,CARRY,INPUT1,INPUT2,INPUT3);
	// port declaration
	input INPUT1,INPUT2,INPUT3;
	output SUM,CARRY;

	// gate level modeling of full adder
	half_adder h1(SUMOUT,CARRYOUT,INPUT1,INPUT2);
	or o1(CARRY,CARRYOUT,CARRYOUT2);
	half_adder h2(SUM,CARRYOUT2,INPUT3,SUMOUT);

endmodule