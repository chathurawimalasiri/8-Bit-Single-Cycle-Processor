
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:16:20 08/01/2021 
// Design Name: 	 Asmaa Sameh
// Module Name:    Half_Adder 
// Project Name: 	 DADDA multiplier
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module Half_Adder(A_HA,B_HA,Sum,Carry);
    input A_HA,B_HA;    
    output Sum,Carry;
    
	 assign Sum=A_HA^B_HA;
	 assign Carry = A_HA&B_HA;  


endmodule
