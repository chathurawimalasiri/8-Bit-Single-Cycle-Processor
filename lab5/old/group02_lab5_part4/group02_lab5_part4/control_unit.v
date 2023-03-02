/*
 *
 *	Part 3
 *	CONTROL UNIT
 *
 */


module control_unit(ALUOP,MUX_2SCMPL,MUX_IMMD,WRITEENABLE,BEQ_ENABLE, JUMP_ENABLE, OP);

	input [7:0] OP;						// opcode

	output reg MUX_2SCMPL, MUX_IMMD, WRITEENABLE, BEQ_ENABLE, JUMP_ENABLE;		// 1 bit outputs from control unit
	output reg [2:0] ALUOP;					// 3-bits ALU opcode

	
	always @(*)
	begin 	
		
		#1

		case(OP)
			// case for load immediate value
			8'b00000000: begin
			
				ALUOP = 3'b000;		// alu operation code 
				MUX_2SCMPL = 'b0;	// 2s complement select pin
				MUX_IMMD = 'b1;		// immediadte value select pin
				WRITEENABLE = 'b1;	// register write enable pin
				BEQ_ENABLE = 'b0;	// branch equal enable pin
				JUMP_ENABLE = 'b0;	// jump enable pin

			end
			
			// case for move register value
			8'b00000001: begin

				ALUOP = 3'b000;		// alu operation code
                                MUX_2SCMPL = 'b0;	// 2s complement select pin
                                MUX_IMMD = 'b0;		// immediadte value select pin
                                WRITEENABLE = 'b1;	// register write enable pin
				BEQ_ENABLE = 'b0;       // branch equal enable pin
                                JUMP_ENABLE = 'b0;      // jump enable pin

			end

			// case for add operation
			8'b00000010: begin
				
				ALUOP = 3'b001;		// alu operation code
                                MUX_2SCMPL = 'b0;	// 2s complement select pin
                                MUX_IMMD = 'b0;		// immediadte value select pin
                                WRITEENABLE = 'b1;	// register write enable pin
				BEQ_ENABLE = 'b0;       // branch equal enable pin
                                JUMP_ENABLE = 'b0;      // jump enable pin

			end

			// case for sub operation
			8'b00000011: begin

				ALUOP = 3'b001;		// alu operation code
                                MUX_2SCMPL = 'b1;	// 2s complement select pin
                                MUX_IMMD = 'b0;		// immediadte value select pin
                                WRITEENABLE = 'b1;	// register write enable pin
				BEQ_ENABLE = 'b0;       // branch equal enable pin
                                JUMP_ENABLE = 'b0;      // jump enable pin
			
			end	


			// case for and operation
			8'b00000100: begin
				
				ALUOP = 3'b010;		// alu operation code
                                MUX_2SCMPL = 'b0;	// 2s complement select pin
                                MUX_IMMD = 'b0;		// immediadte value select pin
                                WRITEENABLE = 'b1;	// register write enable pin
				BEQ_ENABLE = 'b0;       // branch equal enable pin
                                JUMP_ENABLE = 'b0;      // jump enable pin

                        end

			// case for or operation
			8'b00000101: begin
				
				ALUOP = 3'b011;		// alu operation code
                                MUX_2SCMPL = 'b0;	// 2s complement select pin
                                MUX_IMMD = 'b0;		// immediadte value select pin
                                WRITEENABLE = 'b1;	// register write enable pin
				BEQ_ENABLE = 'b0;       // branch equal enable pin
                                JUMP_ENABLE = 'b0;      // jump enable pin

                        end

			// case for beq
			8'b00000111: begin

				ALUOP = 3'b001;         // alu operation code
                                MUX_2SCMPL = 'b1;       // 2s complement select pin
                                MUX_IMMD = 'b0;         // immediadte value select pin
                                WRITEENABLE = 'b0;      // register write enable pin
                                BEQ_ENABLE = 'b1;       // branch equal enable pin
                                JUMP_ENABLE = 'b0;      // jump enable pin

			end	

			// case for jump
			8'b00000110: begin

				ALUOP = 3'b111;         // alu operation code
                                MUX_2SCMPL = 'b0;       // 2s complement select pin
                                MUX_IMMD = 'b0;         // immediadte value select pin
                                WRITEENABLE = 'b0;      // register write enable pin
                                BEQ_ENABLE = 'b0;       // branch equal enable pin
                                JUMP_ENABLE = 'b1;      // jump enable pin

			end

				
		endcase
	end

endmodule
					
	

