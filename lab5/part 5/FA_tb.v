`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   10:17:55 08/03/2021
// Design Name:   Full_Adder
// Module Name:   E:/GRADUATION PROJECT/Projects/DADDA/FA_tb.v
// Project Name:  DADDA
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Full_Adder
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module FA_tb;

	// Inputs
	reg A_FL;
	reg B_FL;
	reg Carry_in;

	// Outputs
	wire Sum_FA;
	wire Carry_out_FA;

	// Instantiate the Unit Under Test (UUT)
	Full_Adder uut (
		.A_FL(A_FL), 
		.B_FL(B_FL), 
		.Carry_in(Carry_in), 
		.Sum_FA(Sum_FA), 
		.Carry_out_FA(Carry_out_FA)
	);

	initial begin
		// Initialize Inputs
		$display ("*** TEST CASE 1 ***");
    
		A_FL = 0;
		B_FL = 0;
		Carry_in=0;
		

		#10
			 
			if (Sum_FA == 0 && Carry_out_FA==0)
				 $display (" PASSED") ;
			else
				begin
				 $display (" FAILED") ;
				end
 
		$display ("*** TEST CASE 2 ***");
    
		A_FL = 0;
		B_FL = 0;
		Carry_in=1;
		

		#10
			 
			if (Sum_FA == 1 && Carry_out_FA==0)
				 $display (" PASSED") ;
			else
				begin
				 $display (" FAILED") ;
				end

		$display ("*** TEST CASE 3 ***");
    
		A_FL = 0;
		B_FL = 1;
		Carry_in=0;
		

		#10
			 
			if (Sum_FA == 1 && Carry_out_FA==0)
				 $display (" PASSED") ;
			else
				begin
				 $display (" FAILED") ;
				end

		$display ("*** TEST CASE 4 ***");
    
		A_FL = 0;
		B_FL = 1;
		Carry_in=1;
		

		#10
			 
			if (Sum_FA == 0 && Carry_out_FA==1)
				 $display (" PASSED") ;
			else
				begin
				 $display (" FAILED") ;
				end

		$display ("*** TEST CASE 5 ***");
    
		A_FL = 1;
		B_FL = 0;
		Carry_in=0;
		

		#10
			 
			if (Sum_FA == 1 && Carry_out_FA==0)
				 $display (" PASSED") ;
			else
				begin
				 $display (" FAILED") ;
				end

		$display ("*** TEST CASE 6 ***");
    
		A_FL = 1;
		B_FL = 0;
		Carry_in=1;
		

		#10
			 
			if (Sum_FA == 0 && Carry_out_FA==1)
				 $display (" PASSED") ;
			else
				begin
				 $display (" FAILED") ;
				end

		$display ("*** TEST CASE 7 ***");
    
		A_FL = 1;
		B_FL = 1;
		Carry_in=0;
		

		#10
			 
			if (Sum_FA == 0 && Carry_out_FA==1)
				 $display (" PASSED") ;
			else
				begin
				 $display (" FAILED") ;
				end
				
		$display ("*** TEST CASE 8 ***");
    
		A_FL = 1;
		B_FL = 1;
		Carry_in=1;
		

		#10
			 
			if (Sum_FA == 1 && Carry_out_FA==1)
				 $display (" PASSED") ;
			else
				begin
				 $display (" FAILED") ;
				end



		// Wait 100 ns for global reset to finish
		#100;
		$finish;
        
		// Add stimulus here

	end
      
endmodule

