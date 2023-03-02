/*
 *	
 *	Task 1
 *	ALU 
 *
 */

// or operation
module OR(or_Out,DATA1,DATA2);

        //port declaration
        input [7:0] DATA1,DATA2;
        output [7:0] or_Out;
//	initial begin
        assign or_Out = DATA1 | DATA2;
//	end
endmodule

// and operation
module AND(and_Out,DATA1,DATA2);
	
	//port declaration
        input [7:0] DATA1,DATA2;
        output [7:0] and_Out;
	//initial begin	
        assign and_Out = DATA1 & DATA2;
	//end
endmodule



// add operation
module ADD(add_Out,DATA1,DATA2);
	
	//port declaration
        input [7:0] DATA1,DATA2;
        output [7:0] add_Out;
//	initial begin	
	assign add_Out = DATA1 + DATA2;
//	end
endmodule

// foward operation
module FORWARD(fwd_Out, DATA2);
	
	//port declaration
	input [7:0] DATA2;
	output [7:0] fwd_Out;
	
//	initial begin
	assign fwd_Out = DATA2;
//	end
endmodule


module alu(RESULT,DATA1,DATA2,SELECT);

	//port declaration
	input [7:0] DATA1,DATA2;
	input [2:0] SELECT;
	output reg[7:0] RESULT;
	wire[7:0] fwd_Out, add_Out, and_Out, or_Out ;

	FORWARD fOp(fwd_Out, DATA2);
	ADD addOp(add_Out,DATA1,DATA2);
	AND andOp(and_Out,DATA1,DATA2);
	OR orOp(or_Out,DATA1,DATA2);

	always @ (*) begin
	
	case(SELECT) 

	'b000: 
		#1 RESULT <=  fwd_Out ;

	
	'b001:
		#2 RESULT <= add_Out ;		

	'b010:
		
		#1 RESULT <=  and_Out ;
	
	'b011:
		
		#1 RESULT <= or_Out ;

	default:

		RESULT = 'b00000000;	
		
	endcase
	end
	
endmodule		


