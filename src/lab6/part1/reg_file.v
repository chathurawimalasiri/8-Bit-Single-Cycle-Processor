/*
 *
 *	Part 2 - Register File
 *	Group 2
 *	E/18/402   E/18/397
 *
 *
 */

module reg_file(IN, OUT1, OUT2, INADDRESS, OUT1ADDRESS, OUT2ADDRESS, WRITE, CLK, RESET);

	input WRITE, CLK, RESET;				// 1-bit inputs
	input [2:0] INADDRESS, OUT1ADDRESS, OUT2ADDRESS;	// 3-bits inputs
	input [7:0] IN;						// 8-bits input

	output [7:0] OUT1, OUT2;				// 8-bits outputs


	reg [7:0] registers[7:0];		// this represents the 8-bits(1 byte)  8 registers ( 8x8 register file)


	integer regNum ,i;			// represet the register number for the RESET task

	// assign given addresses values to OUT1 and OUT2 respectively. this is asynchronous with delay 2 units
	assign #2 OUT1 = registers[OUT1ADDRESS];	
	assign #2 OUT2 = registers[OUT2ADDRESS];


	// write to given address register at positive edge of the clock
	always @(posedge CLK) 
	begin 
		

		// writting happens when WRITE is high.
                // if statement includes only one row so don't use begin end keywords
                if (  RESET == 'b0 && WRITE == 'b1  )

                        // this is synchronous delay 1 unit.
                        // write in to given register
                        #1 registers[INADDRESS] = IN ;
						
				
		// reset all the registers synchronously at the positive edge of the clock
		// reset all the registers when RESET is high with delay 1 units
		if ( RESET ) #1
		begin
			
			for(regNum = 0; regNum < 8 ; regNum = regNum + 1)begin
			
				registers[regNum] = 'b00000000;

			end
			
		end
				
				
	
	end


	initial
	begin
    $dumpfile("cpu_wavedata.vcd");
    for(i=0;i<8;i++)
        $dumpvars(1,registers[i]);
	end

endmodule	


