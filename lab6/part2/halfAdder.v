`timescale 1ns/100ps
// half addder module
module half_adder(SUM,CARRY,INPUT1,INPUT2);

	// port decaration
	input INPUT1,INPUT2;
	output SUM,CARRY;
	
	// gate level modeling of the half adder
	xor x1(SUM,INPUT1,INPUT2);
	and a1(CARRY,INPUT1,INPUT2);


endmodule