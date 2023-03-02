
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:27:30 08/01/2021 
// Design Name: 
// Module Name:    Full_Adder 
// Project Name: 
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
module Full_Adder(
    input A_FL,
    input B_FL,
    input Carry_in,
    output Sum_FA,
    output Carry_out_FA
    );
	 
	 assign Sum_FA= A_FL ^ B_FL ^ Carry_in;
	 assign Carry_out_FA=(A_FL & B_FL)| (A_FL &Carry_in) |( B_FL & Carry_in);


endmodule
