`include "reg.v"
`include "alu.v"

    // opcodes
    // loadi= "00000000";
	// mov 	= "00000001";
	// add 	= "00000010";
	// sub 	= "00000011";
	// and 	= "00000100";
	// or 	= "00000101";

module cpu (PC, INSTRUCTION, CLK, RESET );

    // port declaration
    input CLK, RESET;
    input [31:0] INSTRUCTION;
    output reg [31:0] PC ;
    
    // wires for internal implementation
    wire SUB_SELECT, IMM_SELECT, WRITE_ENABLE;
    wire [7:0] ALU_OUT, REGOUT1, REGOUT2, TWOS, SUB_RESULT, IMM_RESULT;
    wire [2:0] ALUOP;
    wire [31:0] NEXTPC;
    
        //  opcode = INSTRUCTION[31:24]; // opcode
        //  rd = INSTRUCTION[23:16];     // destination
        //  rt = INSTRUCTION[15:8];      // operand 1
        //  rs = INSTRUCTION[7:0];       // operand 2 or immediate

    //  initiating the modules
    cu mycu(ALUOP, WRITE_ENABLE,SUB_SELECT, IMM_SELECT , INSTRUCTION[31:24] );
    reg_file myregfile(ALU_OUT, REGOUT1, REGOUT2, INSTRUCTION[18:16], INSTRUCTION[10:8],INSTRUCTION[2:0], WRITE_ENABLE, CLK, RESET);
    twos_comp for_sub(TWOS, REGOUT2);
    mux select2s(SUB_RESULT, REGOUT2, TWOS, SUB_SELECT);
    mux immediate_or_reg(IMM_RESULT, SUB_RESULT, INSTRUCTION[7:0], IMM_SELECT);
    Alu alu(ALU_OUT, REGOUT1, IMM_RESULT, ALUOP);   
    addr adr(NEXTPC, PC, 32'd4);

    
    // pc update with clock
    always @(posedge CLK) begin
        if(RESET) PC = 0;
        else #1 PC = NEXTPC;
    end
    
endmodule

// 2 into 1 mux
module mux (OUTPUT, INPUT1, INPUT2, SELECT);
    input SELECT;
    input[7:0] INPUT1, INPUT2;
    output reg [7:0] OUTPUT;
    always @(*) begin
        if (SELECT==0) OUTPUT = INPUT1;
        else OUTPUT = INPUT2;
    end
    
endmodule

// 2s complement generator
module twos_comp (OUTPUT, INPUT);
    input[7:0] INPUT;
    output[7:0] OUTPUT;
    assign  #1 OUTPUT = ~INPUT + 8'd1;
endmodule

// control unit
module   cu(ALUOP, WRITEENABLE, MUXSUB, MUXIMM, OPCODE);
    input [7:0] OPCODE;
    output reg WRITEENABLE, MUXSUB, MUXIMM;
    output reg [2:0] ALUOP;

    always @(*) begin
        #1

        // MUXIMM = immediate value selector 
        // ALUOP = alu opcode
        // MUXSUB = 2s complement selector
        // WRITEENABLE = write enable signal

        case (OPCODE)   /// INSTRUCTION[31:24]
            
            'b00000000: begin // loadi
                MUXIMM = 'b1 ; 
                ALUOP = 3'b000;
                MUXSUB = 'b0;
                WRITEENABLE = 'b1;

            end 

            'b00000001: begin  // mov
                MUXIMM = 'b0;
                ALUOP = 3'b000;
                MUXSUB = 'b0;
                WRITEENABLE = 'b1;
            end

            'b00000010: begin // add
                MUXIMM = 'b0 ;
                ALUOP = 3'b001;
                MUXSUB = 'b0;
                WRITEENABLE = 'b1;
            end
                
            'b00000011: begin // sub
                MUXIMM = 'b0 ;
                ALUOP = 3'b001;
                MUXSUB = 'b1;
                WRITEENABLE = 'b1;
            end

            'b00000100: begin // and
                MUXIMM = 'b0 ;
                ALUOP = 3'b010;
                MUXSUB = 'b0;
                WRITEENABLE = 'b1;
            end

            'b00000101: begin // or
                MUXIMM = 'b0 ;
                ALUOP = 3'b011;
                MUXSUB = 'b0;
                WRITEENABLE = 'b1;
            end

            default: begin // for other inputs. 
                MUXIMM = 'bx ;
                ALUOP = 3'bxxx;
                MUXSUB = 'bx;
                WRITEENABLE = 'b0;
            end
                
        endcase   
    end
endmodule
      
// adder
module addr (NEXTPC, PC, FOUR);

// port declaration
input [31:0] PC, FOUR ;
output [31:0] NEXTPC;
assign  #1 NEXTPC =  PC + FOUR;

endmodule