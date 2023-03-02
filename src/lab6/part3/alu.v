/*
 *	
 *	Task 1 - ALU
 *	
 */

// There are four modules for operations which are OR, AND, ADD and FORWARD.
// input and output are 8-bits

`include "mymul.v"

// module MULT(mult_Out,DATA1,DATA2);
	
// 	//port declaration
// 	input [7:0] DATA1,DATA2;
// 	output [7:0] mult_Out;

// 	multi my_multiplier(mult_Out, DATA1, DATA2);
	

// endmodule


// bitwise or operation
module OR(or_Out,DATA1,DATA2);

        //port declaration
        input [7:0] DATA1,DATA2;
        output [7:0] or_Out;

        assign #1 or_Out = DATA1 | DATA2;	// 1 unit delay in the continuous assignment

endmodule

// bitwise and operation
module AND(and_Out,DATA1,DATA2);
	
	//port declaration
        input [7:0] DATA1,DATA2;
        output [7:0] and_Out;
	
        assign #1 and_Out = DATA1 & DATA2;	// 1 unit delay in the continuous assignment

endmodule



// add operation
module ADD(add_Out,DATA1,DATA2);
	
	//port declaration
        input [7:0] DATA1,DATA2;
        output [7:0] add_Out;
	
	assign #2 add_Out = DATA1 + DATA2;	// 2 unit delay in the continuous assignment

endmodule

// foward operation
module FORWARD(fwd_Out, DATA2);
	
	//port declaration
	input [7:0] DATA2;
	output [7:0] fwd_Out;
		
	assign #1 fwd_Out = DATA2;		// 1 unit delay in the continuous assignment
	
endmodule

// ALU module 
// input data and output are 8-bits and select port is 3-bits
module alu(RESULT,ZERO,DATA1,DATA2,SELECT);

	//port declaration
	input [7:0] DATA1,DATA2;				// input data
	input [2:0] SELECT;					// select is which operation must do.
	output reg[7:0] RESULT;					// final ALU output
	output ZERO; 						// ZERO output
	wire[7:0] fwd_Out, add_Out, and_Out, or_Out, mul_Out ;	// to get the output of operation modules
	
	// use above operation modules. 
	// DATA1, DATA2 are inputs. fwd_Out, add_Out, and_Out and or_Out are output.
	FORWARD fOp(fwd_Out, DATA2);
	ADD addOp(add_Out,DATA1,DATA2);
	AND andOp(and_Out,DATA1,DATA2);
	OR orOp(or_Out,DATA1,DATA2);
	multi multOp(mul_Out,DATA1,DATA2);
	
	

	// take one bit and bit that connect to the OR gates. Finally take inverting signal
	assign ZERO = ~(RESULT[0]|RESULT[1]|RESULT[2]|RESULT[3]|RESULT[4]|RESULT[5]|RESULT[6]|RESULT[7]);


	always @(*) begin				// build the sensitivity list 
	
	case(SELECT) 					// switch case and all cases are in binary form

	'b000: 
		RESULT =  fwd_Out ;			// this is for forward operation
		
	
	'b001:
		RESULT = add_Out ;			// this is for add operation

	'b010:
		
		RESULT =  and_Out ;			// this is for bitwise and operation
	
	'b011:
		
		RESULT = or_Out ;			// this is for bitwise or operation
		
	'b100:
		
		RESULT = mul_Out;			// multiplication operation
		

	default:

		RESULT = 'b00000000;			// defualt result = 0 
		
	endcase
	end
	
endmodule		


