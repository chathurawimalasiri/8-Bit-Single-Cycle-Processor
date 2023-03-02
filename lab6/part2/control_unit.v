/*
 *
 *	Part 3
 *	CONTROL UNIT
 *
 *
 */

`timescale 1ns/100ps

module control_unit(BUSYWAIT, INSTRUCTION, WRITE, READ, MUX_MEMORY, ALUOP,MUX_2SCMPL,MUX_IMMD,FINAL_WRITEENABLE,BEQ_ENABLE, JUMP_ENABLE, BNE_ENABLE, SHIFT_ENABLE, SHIFTOP, OP );


	input BUSYWAIT;
	input [7:0] OP;						// opcode
	input [31:0] INSTRUCTION;
	output reg MUX_2SCMPL, MUX_IMMD, FINAL_WRITEENABLE, BEQ_ENABLE, JUMP_ENABLE, BNE_ENABLE, SHIFT_ENABLE, WRITE, READ, MUX_MEMORY;		// 1 bit outputs from control unit
	output reg [1:0] SHIFTOP;				// shift type
	output reg [2:0] ALUOP;					// 3-bits ALU opcode
	reg WRITEENABLE;
	
	always @(INSTRUCTION)
	begin 	
	
		#1

		case(OP)
			// case for load immediate value
			8'b00000000: begin
			
				ALUOP = 3'b000;		// alu operation code 
				MUX_2SCMPL = 1'b0;	// 2s complement select pin
				MUX_IMMD = 1'b1;	// immediadte value select pin
				WRITEENABLE = 1'b1;	// register write enable pin
				BEQ_ENABLE = 1'b0;	// branch equal enable pin
				JUMP_ENABLE = 1'b0;	// jump enable pin
				BNE_ENABLE = 1'b0;	// bne enable pin
				SHIFT_ENABLE = 1'b0;	// right left shift enable pin
				SHIFTOP = 2'bXX;	// shift type
				WRITE = 1'b0;		// memory write pin
				READ = 1'b0;		// memory read pin
				MUX_MEMORY = 1'b0;	// memory output write to register access pin
				
			end
			
			// case for move register value
			8'b00000001: begin

				ALUOP = 3'b000;		// alu operation code
                                MUX_2SCMPL = 1'b0;	// 2s complement select pin
                                MUX_IMMD = 1'b0;	// immediadte value select pin
                                WRITEENABLE = 1'b1;	// register write enable pin
				BEQ_ENABLE = 1'b0;      // branch equal enable pin
                                JUMP_ENABLE = 'b0;      // jump enable pin
				BNE_ENABLE = 1'b0;	// bne enable pin
				SHIFT_ENABLE = 1'b0;	// right left shift enable pin
				SHIFTOP = 2'bXX;	// shift type
				WRITE = 1'b0;		// memory write pin
				READ = 1'b0;		// memory read pin
				MUX_MEMORY = 1'b0;	// memory output write to register access pin
				
			end

			// case for add operation
			8'b00000010: begin
				
				ALUOP = 3'b001;		// alu operation code
                                MUX_2SCMPL = 1'b0;	// 2s complement select pin
                                MUX_IMMD = 1'b0;	// immediadte value select pin
                                WRITEENABLE = 1'b1;	// register write enable pin
				BEQ_ENABLE = 1'b0;      // branch equal enable pin
                                JUMP_ENABLE = 1'b0;     // jump enable pin
				BNE_ENABLE = 1'b0;	// bne enable pin
				SHIFT_ENABLE = 1'b0;	// right left shift enable pin
				SHIFTOP = 2'bXX;	// shift type
				WRITE = 1'b0;		// memory write pin
				READ = 1'b0;		// memory read pin
				MUX_MEMORY = 1'b0;	// memory output write to register access pin
				
			end

			// case for sub operation
			8'b00000011: begin

				ALUOP = 3'b001;		// alu operation code
                                MUX_2SCMPL = 1'b1;	// 2s complement select pin
                                MUX_IMMD = 1'b0;	// immediadte value select pin
                                WRITEENABLE = 1'b1;	// register write enable pin
				BEQ_ENABLE = 1'b0;      // branch equal enable pin
                                JUMP_ENABLE = 1'b0;     // jump enable pin
				BNE_ENABLE = 1'b0;	// bne enable pin
				SHIFT_ENABLE = 1'b0;	// right left shift enable pin
				SHIFTOP = 2'bXX;	// shift type
				WRITE = 1'b0;		// memory write pin
				READ = 1'b0;		// memory read pin
				MUX_MEMORY = 1'b0;	// memory output write to register access pin
				
			end	


			// case for and operation
			8'b00000100: begin
				
				ALUOP = 3'b010;		// alu operation code
                                MUX_2SCMPL = 1'b0;	// 2s complement select pin
                                MUX_IMMD = 1'b0;	// immediadte value select pin
                                WRITEENABLE = 1'b1;	// register write enable pin
				BEQ_ENABLE = 1'b0;      // branch equal enable pin
                                JUMP_ENABLE = 1'b0;     // jump enable pin
				BNE_ENABLE = 1'b0;	// bne enable pin
				SHIFT_ENABLE = 1'b0;	// right left shift enable pin
				SHIFTOP = 2'bXX;	// shift type
				WRITE = 1'b0;		// memory write pin
				READ = 1'b0;		// memory read pin
				MUX_MEMORY = 1'b0;	// memory output write to register access pin
				
                        end

			// case for or operation
			8'b00000101: begin
				
				ALUOP = 3'b011;		// alu operation code
                                MUX_2SCMPL = 1'b0;	// 2s complement select pin
                                MUX_IMMD = 1'b0;	// immediadte value select pin
                                WRITEENABLE = 1'b1;	// register write enable pin
				BEQ_ENABLE = 1'b0;      // branch equal enable pin
                                JUMP_ENABLE = 1'b0;     // jump enable pin
				BNE_ENABLE = 1'b0;	// bne enable pin
				SHIFT_ENABLE = 1'b0;	// right left shift enable pin
				SHIFTOP = 2'bXX;	// shift type
				WRITE = 1'b0;		// memory write pin
				READ = 1'b0;		// memory read pin
				MUX_MEMORY = 1'b0;	// memory output write to register access pin
				
                        end

			// case for beq
			8'b00000111: begin

				ALUOP = 3'b001;         // alu operation code
                                MUX_2SCMPL = 1'b1;      // 2s complement select pin
                                MUX_IMMD = 1'b0;        // immediadte value select pin
                                WRITEENABLE = 1'b0;     // register write enable pin
                                BEQ_ENABLE = 1'b1;      // branch equal enable pin
                                JUMP_ENABLE = 1'b0;     // jump enable pin
				BNE_ENABLE = 1'b0;	// bne enable pin
				SHIFT_ENABLE = 1'b0;	// right left shift enable pin
				SHIFTOP = 2'bXX;	// shift type
				WRITE = 1'b0;		// memory write pin
				READ = 1'b0;		// memory read pin
				MUX_MEMORY = 1'b0;	// memory output write to register access pin
				
			end	

			// case for jump
			8'b00000110: begin

				ALUOP = 3'b111;         // alu operation code
                                MUX_2SCMPL = 1'b0;      // 2s complement select pin
                                MUX_IMMD = 1'b0;        // immediadte value select pin
                                WRITEENABLE = 1'b0;     // register write enable pin
                                BEQ_ENABLE = 1'b0;      // branch equal enable pin
                                JUMP_ENABLE = 1'b1;     // jump enable pin
				BNE_ENABLE = 1'b0;	// bne enable pin
				SHIFT_ENABLE = 1'b0;	// right left shift enable pin
				SHIFTOP = 2'bXX;	// shift type
				WRITE = 1'b0;		// memory write pin
				READ = 1'b0;		// memory read pin
				MUX_MEMORY = 1'b0;	// memory output write to register access pin
				

			end
			
			
			
			// case for multiplication 
			8'b00001100: begin
				
				ALUOP = 3'b100;         // alu operation code
				MUX_2SCMPL = 1'b0;      // 2s complement select pin
				MUX_IMMD = 1'b0;        // immediadte value select pin
				WRITEENABLE = 1'b1;     // register write enable pin
				BEQ_ENABLE = 1'b0;      // branch equal enable pin
				JUMP_ENABLE = 1'b0;     // jump enable pin
				BNE_ENABLE = 1'b0;	// bne enable pin
				SHIFT_ENABLE = 1'b0;	// right left shift enable pin
				SHIFTOP = 2'bXX;	// shift type
				WRITE = 1'b0;		// memory write pin
				READ = 1'b0;		// memory read pin
				MUX_MEMORY = 1'b0;	// memory output write to register access pin
				
			end
			
			// case for left logical shift
			8'b00001101: begin
				
				ALUOP = 3'b101;         // alu operation code
				MUX_2SCMPL = 1'b0;      // 2s complement select pin
				MUX_IMMD = 1'b1;        // immediadte value select pin
				WRITEENABLE = 1'b1;     // register write enable pin
				BEQ_ENABLE = 1'b0;      // branch equal enable pin
				JUMP_ENABLE = 1'b0;     // jump enable pin
				BNE_ENABLE = 1'b0;	// bne enable pin
				SHIFT_ENABLE = 1'b1;	// right left shift enable pin
				SHIFTOP = 2'b11;	// shift type
				WRITE = 1'b0;		// memory write pin
				READ = 1'b0;		// memory read pin
				MUX_MEMORY = 1'b0;	// memory output write to register access pin
				
			
			end
			
			// case for right logical shift
			8'b00001110: begin
			
				ALUOP = 3'b101;         // alu operation code
				MUX_2SCMPL = 1'b0;      // 2s complement select pin
				MUX_IMMD = 1'b1;        // immediadte value select pin
				WRITEENABLE = 1'b1;     // register write enable pin
				BEQ_ENABLE = 1'b0;      // branch equal enable pin
				JUMP_ENABLE = 1'b0;     // jump enable pin
				BNE_ENABLE = 1'b0;	// bne enable pin
				SHIFT_ENABLE = 1'b1;	// right left shift enable pin
				SHIFTOP = 2'b00;	// shift type
				WRITE = 1'b0;		// memory write pin
				READ = 1'b0;		// memory read pin
				MUX_MEMORY = 1'b0;	// memory output write to register access pin
				
			end
			
			// case for right arithmetic shift
			8'b00001111: begin
				
				ALUOP = 3'b110;         // alu operation code
				MUX_2SCMPL = 1'b0;      // 2s complement select pin
				MUX_IMMD = 1'b1;        // immediadte value select pin
				WRITEENABLE = 1'b1;     // register write enable pin
				BEQ_ENABLE = 1'b0;      // branch equal enable pin
				JUMP_ENABLE = 1'b0;     // jump enable pin
				BNE_ENABLE = 1'b0;	// bne enable pin
				SHIFT_ENABLE = 1'b1;	// right left shift enable pin
				SHIFTOP = 2'b01;	// shift type
				WRITE = 1'b0;		// memory write pin
				READ = 1'b0;		// memory read pin
				MUX_MEMORY = 1'b0;	// memory output write to register access pin
			
			end
			
			// case for rotate right 
			8'b00010000: begin
				
				ALUOP = 3'b110;         // alu operation code
				MUX_2SCMPL = 1'b0;      // 2s complement select pin
				MUX_IMMD = 1'b1;        // immediadte value select pin
				WRITEENABLE = 1'b1;     // register write enable pin
				BEQ_ENABLE = 1'b0;      // branch equal enable pin
				JUMP_ENABLE = 1'b0;     // jump enable pin
				BNE_ENABLE = 1'b0;	// bne enable pin
				SHIFT_ENABLE = 1'b1;	// right left shift enable pin
				SHIFTOP = 2'b10;	// shift type
				WRITE = 1'b0;		// memory write pin
				READ = 1'b0;		// memory read pin
				MUX_MEMORY = 1'b0;	// memory output write to register access pin
			
			end
			
			
			
			// case for bne
			8'b00010001: begin
				
				ALUOP = 3'b111;         // alu operation code
                                MUX_2SCMPL = 1'b1;      // 2s complement select pin
                                MUX_IMMD = 1'b0;        // immediadte value select pin
                                WRITEENABLE = 1'b0;     // register write enable pin
                                BEQ_ENABLE = 1'b0;      // branch equal enable pin
                                JUMP_ENABLE = 1'b0;     // jump enable pin
				BNE_ENABLE = 1'b1;	// bne enable pin
				SHIFT_ENABLE = 1'b0;	// right left shift enable pin
				SHIFTOP = 2'bXX;	// shift type
				WRITE = 1'b0;		// memory write pin
				READ = 1'b0;		// memory read pin
				MUX_MEMORY = 1'b0;	// memory output write to register access pin

			end
			
			// case for lwd
			8'b00001000: begin
			
				ALUOP = 3'b000;         // alu operation code
				MUX_2SCMPL = 1'b0;      // 2s complement select pin
				MUX_IMMD = 1'b0;        // immediadte value select pin
				WRITEENABLE = 1'b1;     // register write enable pin
				BEQ_ENABLE = 1'b0;      // branch equal enable pin
				JUMP_ENABLE = 1'b0;     // jump enable pin
				BNE_ENABLE = 1'b0;	// bne enable pin
				SHIFT_ENABLE = 1'b0;	// right left shift enable pin
				SHIFTOP = 2'b00;	// shift type
				WRITE = 1'b0;		// memory write pin
				READ = 1'b1;		// memory read pin
				MUX_MEMORY = 1'b1;	// memory output write to register access pin
			
			end
			
			
			// case for lwi
			8'b00001001: begin
			
				ALUOP = 3'b000;         // alu operation code
				MUX_2SCMPL = 1'b0;      // 2s complement select pin
				MUX_IMMD = 1'b1;        // immediadte value select pin
				WRITEENABLE = 1'b1;     // register write enable pin
				BEQ_ENABLE = 1'b0;      // branch equal enable pin
				JUMP_ENABLE = 1'b0;     // jump enable pin
				BNE_ENABLE = 1'b0;	// bne enable pin
				SHIFT_ENABLE = 1'b0;	// right left shift enable pin
				SHIFTOP = 2'b00;	// shift type
				WRITE = 1'b0;		// memory write pin
				READ = 1'b1;		// memory read pin
				MUX_MEMORY = 1'b1;	// memory output write to register access pin
			
			end
			
			
			// case for swd
			8'b00001010: begin
			
				ALUOP = 3'b000;         // alu operation code
				MUX_2SCMPL = 1'b0;      // 2s complement select pin
				MUX_IMMD = 1'b0;        // immediadte value select pin
				WRITEENABLE = 1'b0;     // register write enable pin
				BEQ_ENABLE = 1'b0;      // branch equal enable pin
				JUMP_ENABLE = 1'b0;     // jump enable pin
				BNE_ENABLE = 1'b0;	// bne enable pin
				SHIFT_ENABLE = 1'b0;	// right left shift enable pin
				SHIFTOP = 2'b00;	// shift type
				WRITE = 1'b1;		// memory write pin
				READ = 1'b0;		// memory read pin
				MUX_MEMORY = 1'b0;	// memory output write to register access pin
			
			end
			
			
			// case for swi
			8'b00001011: begin
			
				ALUOP = 3'b000;         // alu operation code
				MUX_2SCMPL = 1'b0;      // 2s complement select pin
				MUX_IMMD = 1'b1;        // immediadte value select pin
				WRITEENABLE = 1'b0;     // register write enable pin
				BEQ_ENABLE = 1'b0;      // branch equal enable pin
				JUMP_ENABLE = 1'b0;     // jump enable pin
				BNE_ENABLE = 1'b0;	// bne enable pin
				SHIFT_ENABLE = 1'b0;	// right left shift enable pin
				SHIFTOP = 2'b00;	// shift type
				WRITE = 1'b1;		// memory write pin
				READ = 1'b0;		// memory read pin
				MUX_MEMORY = 1'b0;	// memory output write to register access pin
			
			end
	
			
		endcase
	end

	// set read and write singnals to zero when busywait signal is zero
	always @(BUSYWAIT) begin
		if (BUSYWAIT == 0) begin
			READ = 0;
			WRITE = 0;

		end
		
	end


	
	// always @(posedge BUSYWAIT) begin
	// 	WRITEENABLE = 0;
	// end


	// always @(negedge BUSYWAIT) begin
	// 	WRITEENABLE = 1;

	// end
	always @(MUX_MEMORY, WRITEENABLE, BUSYWAIT) begin
		// If data memory is not used and WRITEENABLE is 1, then we can write to register file
        // If data memory is used and WRITEENABLE is 1 and busywait is not 1, then we can write to register
		FINAL_WRITEENABLE = (!MUX_MEMORY & WRITEENABLE) | (MUX_MEMORY & WRITEENABLE & !BUSYWAIT);
		
	end


endmodule
					
	

