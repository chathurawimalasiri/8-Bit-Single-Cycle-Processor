
`include "Full_Adder.v"
`include "Half_Adder.v"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:48:32 08/01/2021 
// Design Name: 
// Module Name:    DADDA_Multiplier 
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
module DADDA_Multiplier(A,B,Y);
    input [7:0] A;
    input [7:0] B;
    output [15:0] Y;
    wire Points [0:7][7:0]; //generated points 
	 
	 // we have 5 stages at d=2,3,4,6 
	 wire [0:5] sum1,carry1;
	 wire [0:13] sum2,carry2;
	 wire [0:9] sum3,carry3;
	 wire [0:11] sum4,carry4;
	 wire [0:13] sum5,carry5;
	 
	 
	 // genarating partial product 
	 
	 genvar i;
	 genvar j;
	 
	 	 
		 for(i = 0; i<8; i=i+1)
		 begin
			for(j = 0; j<8;j = j+1)
			begin
				assign Points[i][j] = A[j]*B[i];
			end
		 end
	 
	 
	 // Stage one  d=6
	 Half_Adder HA11(.A_HA(Points[6][0]),.B_HA(Points[5][1]),.Sum(sum1[0]),.Carry(carry1[0]));
	 Half_Adder HA12(.A_HA(Points[4][3]),.B_HA(Points[3][4]),.Sum(sum1[2]),.Carry(carry1[2]));
	 Half_Adder HA13(.A_HA(Points[4][4]),.B_HA(Points[3][5]),.Sum(sum1[4]),.Carry(carry1[4]));
	 
	 Full_Adder FA11(.A_FL(Points[7][0]),.B_FL(Points[6][1]),.Carry_in(Points[5][2]),.Sum_FA(sum1[1]),.Carry_out_FA(carry1[1]));
	 Full_Adder FA12(.A_FL(Points[7][1]),.B_FL(Points[6][2]),.Carry_in(Points[5][3]),.Sum_FA(sum1[3]),.Carry_out_FA(carry1[3]));
	 Full_Adder FA13(.A_FL(Points[7][2]),.B_FL(Points[6][3]),.Carry_in(Points[5][4]),.Sum_FA(sum1[5]),.Carry_out_FA(carry1[5]));
	 


	 // Stage 2  d=4
	 Half_Adder HA21(.A_HA(Points[4][0]),.B_HA(Points[3][1]),.Sum(sum2[0]),.Carry(carry2[0]));
	 Half_Adder HA22(.A_HA(Points[2][3]),.B_HA(Points[1][4]),.Sum(sum2[2]),.Carry(carry2[2]));
	 
	 
	 Full_Adder FA21(.A_FL(Points[5][0]),.B_FL(Points[4][1]),.Carry_in(Points[3][2]),.Sum_FA(sum2[1]),.Carry_out_FA(carry2[1]));
	 Full_Adder FA22(.A_FL(sum1[0]),.B_FL(Points[4][2]),.Carry_in(Points[3][3]),.Sum_FA(sum2[3]),.Carry_out_FA(carry2[3]));
	 Full_Adder FA23(.A_FL(Points[2][4]),.B_FL(Points[1][5]),.Carry_in(Points[0][6]),.Sum_FA(sum2[4]),.Carry_out_FA(carry2[4]));
	 Full_Adder FA24(.A_FL(sum1[1]),.B_FL(sum1[2]),.Carry_in(Points[2][5]),.Sum_FA(sum2[5]),.Carry_out_FA(carry2[5]));
	 Full_Adder FA25(.A_FL(Points[1][6]),.B_FL(Points[0][7]),.Carry_in(carry1[0]),.Sum_FA(sum2[6]),.Carry_out_FA(carry2[6]));
	 Full_Adder FA26(.A_FL(sum1[3]),.B_FL(sum1[4]),.Carry_in(Points[2][6]),.Sum_FA(sum2[7]),.Carry_out_FA(carry2[7]));
	 Full_Adder FA27(.A_FL(Points[1][7]),.B_FL(carry1[1]),.Carry_in(carry1[2]),.Sum_FA(sum2[8]),.Carry_out_FA(carry2[8]));
	 Full_Adder FA28(.A_FL(sum1[5]),.B_FL(Points[4][5]),.Carry_in(Points[3][6]),.Sum_FA(sum2[9]),.Carry_out_FA(carry2[9]));
	 Full_Adder FA29(.A_FL(Points[2][7]),.B_FL(carry1[3]),.Carry_in(carry1[4]),.Sum_FA(sum2[10]),.Carry_out_FA(carry2[10]));
	 Full_Adder FA210(.A_FL(Points[7][3]),.B_FL(Points[6][4]),.Carry_in(Points[5][5]),.Sum_FA(sum2[11]),.Carry_out_FA(carry2[11]));
	 Full_Adder FA211(.A_FL(Points[4][6]),.B_FL(Points[3][7]),.Carry_in(carry1[5]),.Sum_FA(sum2[12]),.Carry_out_FA(carry2[12]));
	 Full_Adder FA212(.A_FL(Points[7][4]),.B_FL(Points[6][5]),.Carry_in(Points[5][6]),.Sum_FA(sum2[13]),.Carry_out_FA(carry2[13]));
	 
	 
	 // Stage 3 d=3
	 Half_Adder HA31(.A_HA(Points[3][0]),.B_HA(Points[2][1]),.Sum(sum3[0]),.Carry(carry3[0]));
	 
	 Full_Adder FA31(.A_FL(sum2[0]),.B_FL(Points[2][2]),.Carry_in(Points[1][3]),.Sum_FA(sum3[1]),.Carry_out_FA(carry3[1]));
	 Full_Adder FA32(.A_FL(sum2[1]),.B_FL(sum2[2]),.Carry_in(Points[0][5]),.Sum_FA(sum3[2]),.Carry_out_FA(carry3[2]));
	 Full_Adder FA33(.A_FL(sum2[3]),.B_FL(sum2[4]),.Carry_in(carry2[1]),.Sum_FA(sum3[3]),.Carry_out_FA(carry3[3]));
	 Full_Adder FA34(.A_FL(sum2[5]),.B_FL(sum2[6]),.Carry_in(carry2[3]),.Sum_FA(sum3[4]),.Carry_out_FA(carry3[4]));
	 Full_Adder FA35(.A_FL(sum2[7]),.B_FL(sum2[8]),.Carry_in(carry2[5]),.Sum_FA(sum3[5]),.Carry_out_FA(carry3[5]));
	 Full_Adder FA36(.A_FL(sum2[9]),.B_FL(sum2[10]),.Carry_in(carry2[7]),.Sum_FA(sum3[6]),.Carry_out_FA(carry3[6]));
	 Full_Adder FA37(.A_FL(sum2[11]),.B_FL(sum2[12]),.Carry_in(carry2[9]),.Sum_FA(sum3[7]),.Carry_out_FA(carry3[7]));
	 Full_Adder FA38(.A_FL(sum2[13]),.B_FL(Points[4][7]),.Carry_in(carry2[11]),.Sum_FA(sum3[8]),.Carry_out_FA(carry3[8]));
	 Full_Adder FA39(.A_FL(Points[7][5]),.B_FL(Points[6][6]),.Carry_in(Points[5][7]),.Sum_FA(sum3[9]),.Carry_out_FA(carry3[9]));
	 
	 
	 // Stage 4 d=2
	 
	 Half_Adder HA41(.A_HA(Points[2][0]),.B_HA(Points[2][1]),.Sum(sum4[0]),.Carry(carry4[0]));
	 
	 
	 Full_Adder FA41(.A_FL(sum3[0]),.B_FL(Points[1][2]),.Carry_in(Points[0][3]),.Sum_FA(sum4[1]),.Carry_out_FA(carry4[1]));
	 Full_Adder FA42 (.A_FL(sum3[1]),.B_FL(Points[0][4]),.Carry_in(carry3[0]),.Sum_FA(sum4[2]),.Carry_out_FA(carry4[2]));
	 Full_Adder FA43(.A_FL(sum3[2]),.B_FL(carry2[0]),.Carry_in(carry3[1]),.Sum_FA(sum4[3]),.Carry_out_FA(carry4[3]));
	 Full_Adder FA44(.A_FL(sum3[3]),.B_FL(carry2[2]),.Carry_in(carry3[2]),.Sum_FA(sum4[4]),.Carry_out_FA(carry4[4]));
	 Full_Adder FA45(.A_FL(sum3[4]),.B_FL(carry2[4]),.Carry_in(carry3[3]),.Sum_FA(sum4[5]),.Carry_out_FA(carry4[5]));
	 Full_Adder FA46(.A_FL(sum3[5]),.B_FL(carry2[6]),.Carry_in(carry3[4]),.Sum_FA(sum4[6]),.Carry_out_FA(carry4[6]));
	 Full_Adder FA47(.A_FL(sum3[6]),.B_FL(carry2[8]),.Carry_in(carry3[5]),.Sum_FA(sum4[7]),.Carry_out_FA(carry4[7]));
	 Full_Adder FA48(.A_FL(sum3[7]),.B_FL(carry2[10]),.Carry_in(carry3[6]),.Sum_FA(sum4[8]),.Carry_out_FA(carry4[8]));
	 Full_Adder FA49(.A_FL(sum3[8]),.B_FL(carry2[12]),.Carry_in(carry3[7]),.Sum_FA(sum4[9]),.Carry_out_FA(carry4[9]));
	 Full_Adder FA410(.A_FL(sum3[9]),.B_FL(carry2[13]),.Carry_in(carry3[8]),.Sum_FA(sum4[10]),.Carry_out_FA(carry4[10]));
	 Full_Adder FA411(.A_FL(Points[7][6]),.B_FL(Points[6][7]),.Carry_in(carry3[9]),.Sum_FA(sum4[11]),.Carry_out_FA(carry4[11]));
	 
	 // Stage 5 final stage
	 
	Half_Adder HA51(.A_HA(Points[1][0]),.B_HA(Points[0][1]),.Sum(Y[1]),.Carry(carry5[0]));
	
	Full_Adder FA51(.A_FL(sum4[0]),.B_FL(Points[0][2]),.Carry_in(carry5[0]),.Sum_FA(Y[2]),.Carry_out_FA(carry5[1]));
	Full_Adder FA52(.A_FL(sum4[1]),.B_FL(carry4[0]),.Carry_in(carry5[1]),.Sum_FA(Y[3]),.Carry_out_FA(carry5[2]));
	Full_Adder FA53(.A_FL(sum4[2]),.B_FL(carry4[1]),.Carry_in(carry5[2]),.Sum_FA(Y[4]),.Carry_out_FA(carry5[3]));
	Full_Adder FA54(.A_FL(sum4[3]),.B_FL(carry4[2]),.Carry_in(carry5[3]),.Sum_FA(Y[5]),.Carry_out_FA(carry5[4]));
	Full_Adder FA55(.A_FL(sum4[4]),.B_FL(carry4[3]),.Carry_in(carry5[4]),.Sum_FA(Y[6]),.Carry_out_FA(carry5[5]));
	Full_Adder FA56(.A_FL(sum4[5]),.B_FL(carry4[4]),.Carry_in(carry5[5]),.Sum_FA(Y[7]),.Carry_out_FA(carry5[6]));
	Full_Adder FA57(.A_FL(sum4[6]),.B_FL(carry4[5]),.Carry_in(carry5[6]),.Sum_FA(Y[8]),.Carry_out_FA(carry5[7]));
	Full_Adder FA58(.A_FL(sum4[7]),.B_FL(carry4[6]),.Carry_in(carry5[7]),.Sum_FA(Y[9]),.Carry_out_FA(carry5[8]));
	Full_Adder FA59(.A_FL(sum4[8]),.B_FL(carry4[7]),.Carry_in(carry5[8]),.Sum_FA(Y[10]),.Carry_out_FA(carry5[9]));
	Full_Adder FA510(.A_FL(sum4[9]),.B_FL(carry4[8]),.Carry_in(carry5[9]),.Sum_FA(Y[11]),.Carry_out_FA(carry5[10]));
	Full_Adder FA511(.A_FL(sum4[10]),.B_FL(carry4[9]),.Carry_in(carry5[10]),.Sum_FA(Y[12]),.Carry_out_FA(carry5[11]));
	Full_Adder FA512(.A_FL(sum4[11]),.B_FL(carry4[10]),.Carry_in(carry5[11]),.Sum_FA(Y[13]),.Carry_out_FA(carry5[12]));
	Full_Adder FA513(.A_FL(Points[7][7]),.B_FL(carry4[11]),.Carry_in(carry5[12]),.Sum_FA(Y[14]),.Carry_out_FA(carry5[13]));
	
	assign Y[0]=Points[0][0];
	assign Y[15]=carry5[13];
		 
	 

endmodule