/*
 *
 *	Part 3
 *	CPU
 *
 */ 


`include "alu.v"
`include "adder.v"
`include "control_unit.v"
`include "mux_2to1_8bits.v"
`include "mux_2to1_32bits.v"
`include "reg_file.v"
`include "twos_complement_converter.v"
`include "new_adder.v"


module cpu(PC, INSTRUCTION, CLK, RESET);
	
	// port declarations
	input [31:0] INSTRUCTION;		// this is for 32 bits instruction
	input CLK, RESET;			// 1 bit clock and reset
	output reg[31:0] PC;			// 32 bits PC
	
	wire TWOs_ENABLE, IMMD_ENABLE, WRITEENABLE, ZERO, BEQ_ENABLE, JUMP_ENABLE, BEQ_SELECT,BEQ_JUMP_ENABLE;
	wire [2:0] ALUOP;
	wire [7:0] WRITEREG, READREG1, READREG2; 
	wire [7:0] OPCODE, ALU_RESULT, REGOUT1, REGOUT2, TWOs_CMPLEMENT, MUX1_RESULT, MUX2_RESULT, IMMEDIATE_VAL, WRITE_DATA;
	wire [31:0] PC_NEXT, JUMP_PC, PC_ADD_4;


	// initiating the modules
	control_unit my_cu ( ALUOP, TWOs_ENABLE, IMMD_ENABLE, WRITEENABLE, BEQ_ENABLE, JUMP_ENABLE, OPCODE);		   	// control unit module
	reg_file myreg (WRITE_DATA, REGOUT1, REGOUT2, WRITEREG[2:0], READREG1[2:0], READREG2[2:0], WRITEENABLE, CLK, RESET);	// 8x8 register file
	twos_complement_converter my2s_cmpl (TWOs_CMPLEMENT, REGOUT2);								// 2s complement unit
	mux_2to1_8bits my_2to1_mux1 (MUX1_RESULT, REGOUT2, TWOs_CMPLEMENT, TWOs_ENABLE);					// 2 to 1 MUX in complement value select unit
	mux_2to1_8bits my_2to1_mux2 (MUX2_RESULT ,MUX1_RESULT,IMMEDIATE_VAL, IMMD_ENABLE); 					// 2 to 1 MUX in immdiate value select unit
	alu my_alu (ALU_RESULT ,ZERO, REGOUT1, MUX2_RESULT, ALUOP);								// ALU unit
	adder pc_adder (PC_ADD_4 ,PC, 32'd4);											// instruction add by 4 unit (PC + 4)
	
	// { {22{WRITEREG[7]}},WRITEREG,2'b00} --> WRITEREG size is 8bits. We need 32 bits size instruction.
	//  Therefore, WRITEREG is sign extended and shifted by 2
	newAdder address_adder (JUMP_PC , { {22{WRITEREG[7]}},WRITEREG,2'b00}, PC_ADD_4 );					// add 2 instructions 
	mux_2to1_32bits mux_beq(PC_NEXT , PC_ADD_4, JUMP_PC, BEQ_JUMP_ENABLE);							// 32 bits size 2*1 mux 
	

	and a1(BEQ_SELECT, ZERO, BEQ_ENABLE);											// AND gate to beq enable and zero signal
	or o1(BEQ_JUMP_ENABLE,BEQ_SELECT,JUMP_ENABLE);										// OR gate to jump enable and AND gate signal


	assign WRITE_DATA = ALU_RESULT ;		// connect the alu output and register file write data
	
	// decoding instruction
	assign IMMEDIATE_VAL = INSTRUCTION[7:0];	// get immediate value
	assign READREG2 = INSTRUCTION[7:0];		// get RS
	assign READREG1 = INSTRUCTION[15:8];		// get RT
	assign WRITEREG = INSTRUCTION[23:16];		// get RD
	assign OPCODE = INSTRUCTION[31:24];             // get 8-bits op-code


	


	always @ ( posedge CLK ) begin
		
		if( RESET )	

			PC = 0 ;						// reset the PC
		
		else
	   		PC = #1 PC_NEXT ;				// increment the PC  

	end		


endmodule	

