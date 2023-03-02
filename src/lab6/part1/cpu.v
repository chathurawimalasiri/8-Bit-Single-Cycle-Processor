/*
 *
 *	Part 3
 *	CPU
 *
 */ 


`include "alu.v"
`include "adder.v"
`include "control_unit.v"
//`include "mux_2to1_8bits.v"
`include "mux_2to1_32bits.v"
`include "reg_file.v"
`include "twos_complement_converter.v"
`include "new_adder.v"
`include "barrelShifter.v"
// `include "datamemory.v"

module cpu(PC, INSTRUCTION, CLK, RESET, READ, WRITE, BUSYWAIT,ADDRESS, WRITEDATA, READDATA);
	
	// port declarations
	input [31:0] INSTRUCTION;		// this is for 32 bits instruction
	input CLK, RESET, BUSYWAIT;			// 1 bit clock and reset
	input [7:0]   READDATA;
	output reg[31:0] PC;			// 32 bits PC
	output  READ ,WRITE;
	output [7:0] ADDRESS  ;
	output [7:0] WRITEDATA;
	// output reg[7:0] READDATA;
	// output reg BUSYWAIT;
	// output  BUSYWAIT;
	
	wire TWOs_ENABLE, IMMD_ENABLE, WRITEENABLE, ZERO, BEQ_ENABLE, JUMP_ENABLE, BEQ_SELECT,BEQ_JUMP_ENABLE,  MUX_WRITEDATA;
	wire BNE_ENABLE, SHIFT_ENABLE;							//task 5 new control signal
	wire BNE_BEQ_JUMP_ENABLE,BNE_SELECT;		// task 5 other wires
	//wire BUSYWAIT;
	wire [1:0] SHIFTOP;
	wire [2:0] ALUOP;
	wire [7:0] WRITEREG, READREG1, READREG2; 
	wire [7:0] OPCODE, ALU_RESULT, REGOUT1, REGOUT2, TWOs_CMPLEMENT, MUX1_RESULT, MUX2_RESULT,MUX4_RESULT, IMMEDIATE_VAL, WRITE_DATA, OUT_BARREL,ALU_BARREL_RESULT;
	wire [31:0] PC_NEXT, JUMP_PC, PC_ADD_4;

	
	// data_memory dm(CLK, RESET, READ, WRITE, ADDRESS, WRITEDATA, READDATA, BUSYWAIT);

	control_unit my_cu (BUSYWAIT,INSTRUCTION, READ, WRITE, MUX_WRITEDATA, ALUOP, TWOs_ENABLE, IMMD_ENABLE, WRITEENABLE, BEQ_ENABLE, JUMP_ENABLE, BNE_ENABLE, SHIFT_ENABLE, SHIFTOP,OPCODE);		   	// control unit module
	reg_file myreg (WRITE_DATA, REGOUT1, REGOUT2, WRITEREG[2:0], READREG1[2:0], READREG2[2:0], WRITEENABLE, CLK, RESET);	// 8x8 register file
	twos_complement_converter my2s_cmpl (TWOs_CMPLEMENT, REGOUT2);								// 2s complement unit
	
	mux_2to1_8bits my_2to1_mux1(MUX1_RESULT, REGOUT2, TWOs_CMPLEMENT, TWOs_ENABLE);					// 2 to 1 MUX in complement value select unit
	mux_2to1_8bits my_2to1_mux2(MUX2_RESULT ,MUX1_RESULT,IMMEDIATE_VAL, IMMD_ENABLE); 					// 2 to 1 MUX in immdiate value select unit
	mux_2to1_8bits my_2to1_mux4(MUX4_RESULT ,ALU_BARREL_RESULT,READDATA, MUX_WRITEDATA); 

	alu my_alu(ALU_RESULT ,ZERO, REGOUT1, MUX2_RESULT, ALUOP);								// ALU unit
	barrelShifter myBarrelShifter(OUT_BARREL,REGOUT1,MUX2_RESULT, SHIFTOP);					// barrel shifter
	mux_2to1_8bits my_2to1_mux3(ALU_BARREL_RESULT, ALU_RESULT ,OUT_BARREL,SHIFT_ENABLE);	// 2 to 1 MUX to select the ALU result and Barrel Shift result
	adder pc_adder (PC_ADD_4 ,PC, 32'd4);											// instruction add by 4 unit (PC + 4)
	
	// { {22{WRITEREG[7]}},WRITEREG,2'b00} --> WRITEREG size is 8bits. We need 32 bits size instruction.
	//  Therefore, WRITEREG is sign extended and shifted by 2
	newAdder address_adder (JUMP_PC , { {22{WRITEREG[7]}},WRITEREG,2'b00}, PC_ADD_4 );					// add 2 instructions 
	mux_2to1_32bits mux_beq(PC_NEXT , PC_ADD_4, JUMP_PC, BNE_BEQ_JUMP_ENABLE);							// 32 bits size 2*1 mux 
	
			


	and a1(BEQ_SELECT, ZERO, BEQ_ENABLE);											// AND gate to beq enable and zero signal
	and a2(BNE_SELECT,~ZERO,BNE_ENABLE);
	or o1(BEQ_JUMP_ENABLE,BEQ_SELECT,JUMP_ENABLE);										// OR gate to jump enable and AND gate signal
	or o2(BNE_BEQ_JUMP_ENABLE,BNE_SELECT,BEQ_JUMP_ENABLE);
	

	assign WRITE_DATA = MUX4_RESULT ;		// connect the MUX OUTPUT
	assign ADDRESS = ALU_RESULT;
	assign WRITEDATA = REGOUT1; 			// conncting regout1 to writedata for memory 
	
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
		begin
			wait(!BUSYWAIT);
			//   read = 0;
			//  write = 0;
			PC = #1 PC_NEXT ;
		end

	end		


endmodule	

