`include "reg.v"
`include "alu.v"

    // opcodes
    // loadi= "00000000";
	// mov 	= "00000001";
	// add 	= "00000010";
	// sub 	= "00000011";
	// and 	= "00000100";
	// or 	= "00000101";
    // j	= "00000110";
	// beq	= "00000111";

module cpu (PC, INSTRUCTION, CLK, RESET );

    // port declaration
    input CLK, RESET;
    input [31:0] INSTRUCTION;
    output reg [31:0] PC ;
    
    // wires for internal implementation
    wire SUB_SELECT, IMM_SELECT, WRITE_ENABLE, ZERO,BRANCH,JUMP,BNE, AND_OUT, OR_OUT, AND_OUT2, SLL;
    wire [7:0] ALU_OUT, REGOUT1, REGOUT2, TWOS, SUB_RESULT, IMM_RESULT;
    wire [2:0] ALUOP;
    wire [31:0] NEXTPC,B_MUX_OUT, ADDR_OUT, NEXTPC2;
    
        //  opcode = INSTRUCTION[31:24]; // opcode
        //  rd = INSTRUCTION[23:16];     // destination
        //  rt = INSTRUCTION[15:8];      // operand 1
        //  rs = INSTRUCTION[7:0];       // operand 2 or immediate

    //  initiating the modules    
    cu mucu(ALUOP, WRITE_ENABLE,SUB_SELECT, IMM_SELECT ,BRANCH,JUMP,BNE,SLL, INSTRUCTION[31:24] );
    reg_file myregfile(ALU_OUT, REGOUT1, REGOUT2, INSTRUCTION[18:16], INSTRUCTION[10:8],INSTRUCTION[2:0], WRITE_ENABLE, CLK, RESET);
    twos_comp for_sub(TWOS, REGOUT2);
    mux select2s(SUB_RESULT, REGOUT2, TWOS, SUB_SELECT);
    mux immediate_or_reg(IMM_RESULT, SUB_RESULT, INSTRUCTION[7:0], IMM_SELECT);
    Alu alu(ZERO, ALU_OUT, REGOUT1, IMM_RESULT, ALUOP, SLL);  
    addr adr(NEXTPC, PC, 'd4);

    andgate a1(AND_OUT, BRANCH, ZERO);
    andgate a2(AND_OUT2, BNE, ~ZERO);
    or or1(OR_OUT,AND_OUT, AND_OUT2, JUMP);
    newaddr na(ADDR_OUT, NEXTPC, INSTRUCTION[23:16]);
    //mux32 branch_mux(B_MUX_OUT, NEXTPC, ADDR_OUT , AND_OUT );
    mux32 jump_mux (NEXTPC2 ,NEXTPC, ADDR_OUT,OR_OUT);

    
    // pc update with clock
    always @(posedge CLK) begin
        if(RESET) PC = 0;
        else #1 PC = NEXTPC2;
    end

endmodule

// 2 into 1 mux
module mux (OUTPUT, INPUT1, INPUT2, SELECT);
    input SELECT;
    input[7:0] INPUT1, INPUT2;
    output reg [7:0] OUTPUT;
    always @(*) begin
        if (SELECT==0) OUTPUT = INPUT1;
        else if (SELECT == 1) OUTPUT = INPUT2;
        // else what should do
    end
    
endmodule

// 2s complement generator
module twos_comp (OUTPUT, INPUT);
    input[7:0] INPUT;
    output[7:0] OUTPUT;
    assign  #1 OUTPUT = ~INPUT+1;
       
endmodule

// control unit
module   cu(ALUOP, WRITEENABLE, MUXSUB, MUXIMM,BRANCH,JUMP,BNE,SLL, OPCODE);
    input [7:0] OPCODE;
    output reg WRITEENABLE, MUXSUB, MUXIMM, BRANCH, JUMP, BNE;
    output reg [2:0] ALUOP;

    always @(*) begin
        #1
        case (OPCODE)   /// INSTRUCTION[31:24]
            
            'b00000000: begin // loadi
                MUXIMM = 'b1 ;// select for immediate value for loadi 
                ALUOP = 3'b000;
                MUXSUB = 'b0;
                WRITEENABLE = 'b1;
                BRANCH = 'b0;
                JUMP = 'b0;
                BNE = 'b0;
                SLL = 'bx;

            end 

            'b00000001: begin  // mov
                MUXIMM = 'b0;
                ALUOP = 3'b000;
                MUXSUB = 'b0;
                WRITEENABLE = 'b1;
                BRANCH = 'b0;
                JUMP = 'b0;
                BNE = 'b0;
                SLL = 'bx;

            end

            'b00000010: begin // add
                MUXIMM = 'b0 ;
                ALUOP = 3'b001;
                MUXSUB = 'b0;
                WRITEENABLE = 'b1;
                BRANCH = 'b0;
                JUMP = 'b0;
                BNE = 'b0;
                SLL = 'bx;
            end
                
            'b00000011: begin // sub
                MUXIMM = 'b0 ;
                ALUOP = 3'b001;
                MUXSUB = 'b1;
                WRITEENABLE = 'b1;
                BRANCH = 'b0;
                JUMP = 'b0;
                BNE = 'b0;
                SLL = 'bx;
            end

            'b00000100: begin // and
                MUXIMM = 'b0 ;
                ALUOP = 3'b010;
                MUXSUB = 'b0;
                WRITEENABLE = 'b1;
                BRANCH = 'b0;
                JUMP = 'b0;
                BNE = 'b0;
                SLL = 'bx;
            end

            'b00000101: begin // or
                MUXIMM = 'b0 ;
                ALUOP = 3'b011;
                MUXSUB = 'b0;
                WRITEENABLE = 'b1;
                BRANCH = 'b0;
                JUMP = 'b0;
                BNE = 'b0;
                SLL = 'bx;
            end
            
            'b00000110: begin // jump
                MUXIMM = 'bx ;
                ALUOP = 3'bxxx;
                MUXSUB = 'bx;
                WRITEENABLE = 'b0;
                BRANCH = 'b0;
                JUMP = 'b1;
                BNE = 'b0;
                SLL = 'bx;
            end

            'b00000111: begin // branch beq
                MUXIMM = 'b0 ;
                ALUOP = 3'b001; // add
                MUXSUB = 'b1;   // sub 
                WRITEENABLE = 'b0;
                BRANCH = 'b1;
                JUMP = 'b0;
                BNE = 'b0;
                SLL = 'bx;
            end

            'b00001000: begin // branch bne
                MUXIMM = 'b0 ;
                ALUOP = 3'b001; // add
                MUXSUB = 'b1;   // sub 
                WRITEENABLE = 'b0;
                BRANCH = 'b0;
                JUMP = 'b0;
                BNE = 'b1;
                SLL = 'bx;
            end

            'b00001001: begin // mult
                MUXIMM = 'b0 ;
                ALUOP = 3'b100; // change this with alu mult
                MUXSUB = 'b0;
                WRITEENABLE = 'b1;
                BRANCH = 'b0;
                JUMP = 'b0;
                BNE = 'b0;
                SLL = 'bx;
            end

            'b00001010: begin // sll
                MUXIMM = 'b0 ;
                ALUOP = 3'b101;
                MUXSUB = 'b0;
                WRITEENABLE = 'b1;
                BRANCH = 'b0;
                JUMP = 'b0;
                BNE = 'b0;
                SLL = 'b1;
            end

            'b00001011: begin // srl
                MUXIMM = 'b0 ;
                ALUOP = 3'b101;
                MUXSUB = 'b0;
                WRITEENABLE = 'b1;
                BRANCH = 'b0;
                JUMP = 'b0;
                BNE = 'b0;
                SLL = 'b0;
            end

            'b00001100: begin // sra
                MUXIMM = 'b0 ;
                ALUOP = 3'b110; 
                MUXSUB = 'b0;
                WRITEENABLE = 'b1;
                BRANCH = 'b0;
                JUMP = 'b0;
                BNE = 'b0;
                SLL = 'bx;
            end

            'b00001101: begin // ror
                MUXIMM = 'b0 ;
                ALUOP = 3'b111; 
                MUXSUB = 'b0;
                WRITEENABLE = 'b1;
                BRANCH = 'b0;
                JUMP = 'b0;
                BNE = 'b0;
                SLL = 'bx;
            end

            default: begin
                MUXIMM = 'bx ;
                ALUOP = 3'bxxx;
                MUXSUB = 'bx;
                WRITEENABLE = 'b0;
                BRANCH = 'bx;
                JUMP = 'bx;
                BNE = 'bx;
                SLL = 'bx;
            end
                
        endcase   
    end
endmodule

// adder
module addr (NEXTPC, PC, FOUR);

input [31:0] PC, FOUR ;
output [31:0] NEXTPC;
assign  #1 NEXTPC =  PC + FOUR;


    
endmodule

// adder
module newaddr (NEW_ADDR, CURRENT_ADDR, OFFSET);

input[7:0] OFFSET;
input [31:0]  CURRENT_ADDR ;
output [31:0] NEW_ADDR;
wire[31:0] EXTENDED, SHIFTED;

assign EXTENDED = { {24{OFFSET[7]}}, OFFSET[7:0] };
assign SHIFTED = EXTENDED *4;
assign  #2 NEW_ADDR =  SHIFTED + CURRENT_ADDR ;


    
endmodule

// AND GATE
module andgate (OUTPUT, INPUT1, INPUT2);
    input INPUT1, INPUT2;
    output OUTPUT;
    assign OUTPUT = INPUT1 & INPUT2;
endmodule

// 32 bit 2 into 1 mux
module mux32 (OUTPUT, INPUT1, INPUT2, SELECT);
    input SELECT;
    input[31:0] INPUT1, INPUT2;
    output reg [31:0] OUTPUT;
    always @(*) begin
        if (SELECT==0) OUTPUT = INPUT1;
        else if (SELECT ==1) OUTPUT = INPUT2;
    end
    
endmodule