/*
 *
 *	Part 3 
 *
 *	This is a MUX which has two inputs and one selection.
 *
 *
 */

module mux_2to1_8bits(RESULT, INPUT1, INPUT2, SELECT);

	input [7:0] INPUT1, INPUT2;		// 8-bits inputs 
	input SELECT;				// selection pin
	output reg [7:0] RESULT;		// 8-bits output

	always @(*) 
	begin		
		
		if( SELECT == 1'b1 )		// SELECT == 8'd1
			
			RESULT = INPUT2 ;

		else				// SELECT = 'b0

			RESULT = INPUT1 ;

	
	end	

endmodule

