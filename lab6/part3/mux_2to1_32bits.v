
module mux_2to1_32bits(RESULT, INPUT1, INPUT2, SELECT);

	// port declarartion
	input [31:0] INPUT1, INPUT2;
	input SELECT;
	output reg [31:0]RESULT;

	always @(*) begin
	
		if( SELECT == 1'b1 )
			
			RESULT = INPUT2;

		else

			RESULT = INPUT1;
	

	end	

endmodule

