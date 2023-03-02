`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   10:12:50 08/03/2021
// Design Name:   Half_Adder
// Module Name:   E:/GRADUATION PROJECT/Projects/DADDA/HA_tb.v
// Project Name:  DADDA
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Half_Adder
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module HA_tb;

	// Inputs
	reg A_HA;
	reg B_HA;

	// Outputs
	wire Sum;
	wire Carry;

	// Instantiate the Unit Under Test (UUT)
	Half_Adder uut (
		.A_HA(A_HA), 
		.B_HA(B_HA), 
		.Sum(Sum), 
		.Carry(Carry)
	);

	initial begin
		// Initialize Inputs
		$display ("*** TEST CASE 1 ***");
    
		A_HA = 0;
		B_HA = 0;
		

		#10
			 
			if (Sum == 0 && Carry==0)
				 $display (" PASSED") ;
			else
				begin
				 $display (" FAILED") ;
				end
 
		$display ("*** TEST CASE 2 ***");
    
		A_HA = 1;
		B_HA = 0;
		

		#10
			 
			if (Sum == 1 && Carry==0)
				 $display (" PASSED") ;
			else
				begin
				 $display (" FAILED") ;
				end
 
		$display ("*** TEST CASE 3 ***");
    
		A_HA = 0;
		B_HA = 1;
		

		#10
			 
			if (Sum == 1 && Carry==0)
				 $display (" PASSED") ;
			else
				begin
				 $display (" FAILED") ;
				end
 
 		$display ("*** TEST CASE 4 ***");
    
		A_HA = 1;
		B_HA = 1;
		

		#10
			 
			if (Sum == 0 && Carry==1)
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

