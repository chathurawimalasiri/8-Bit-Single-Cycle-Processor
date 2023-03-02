// Computer Architecture (CO224) - Lab 05
// Design: Testbench of Integrated CPU of Simple Processor
// Author: Isuru Nawinne
`timescale 1ns/100ps
`include "cpu.v"
`include "data memory.v"
`include "cache.v"
`include "instructionmemory.v"
`include "icache.v"

module cpu_tb;

    reg CLK, RESET, IREAD;

	//reg [7:0] address, writedata, READDATA;
	
	wire BUSYWAIT, WRITE, READ, MEM_READ, MEM_WRITE, MEM_BUSYWAIT, INSREAD, IMEM_BUSYWAIT,I_BUSYWAIT, D_BUSYWAIT ;
	wire [5:0] MEM_ADDRESS, INS_ADDRESS;
	wire [7:0] READDATA, WRITEDATA, ADDRESS;
	wire [31:0] MEM_WRITEDATA, MEM_READDATA;
    wire [31:0] PC;
    wire [31:0] INSTRUCTION;
    wire [127:0] READINST;
    
    /* 
    ------------------------
     SIMPLE INSTRUCTION MEM
    ------------------------
    */
    
    // TODO: Initialize an array of registers (8x1024) named 'instr_mem' to be used as instruction memory
	
	//reg [7:0] instr_mem [1023:0]; 	// instruction array
    
    // TODO: Create combinational logic to support CPU instruction fetching, given the Program Counter(PC) value 
    //       (make sure you include the delay for instruction fetching here)
    
	//assign #2 INSTRUCTION = {instr_mem[PC + 3],instr_mem[PC + 2],instr_mem[PC + 1],instr_mem[PC]};	// fetching instruction with time delay
	
    // initial
    // begin
    //     // Initialize instruction memory with the set of instructions you need execute on CPU
        
    //     // METHOD 1: manually loading instructions to instr_mem
    //     //{instr_mem[10'd3], instr_mem[10'd2], instr_mem[10'd1], instr_mem[10'd0]} = 32'b00000000000001000000000000000101;
    //     //{instr_mem[10'd7], instr_mem[10'd6], instr_mem[10'd5], instr_mem[10'd4]} = 32'b00000000000000100000000000001001;
    //     //{instr_mem[10'd11], instr_mem[10'd10], instr_mem[10'd9], instr_mem[10'd8]} = 32'b00000010000001100000010000000010;
		
    //     // METHOD 2: loading instr_mem content from instr_mem.mem file
    //     $readmemb("instr_mem.mem", instr_mem);
    // end

    /*
    -----
     CPU
    -----
    */
    cpu mycpu(WRITEDATA, ADDRESS, WRITE, READ, PC, INSTRUCTION, CLK, RESET, BUSYWAIT, READDATA );
	
	/*
    -----
     CACHE
    -----
    */
	
	
	dcache mycache( CLK, RESET, READ, WRITE, ADDRESS, WRITEDATA, MEM_BUSYWAIT, MEM_READDATA, READDATA, MEM_READ, MEM_WRITE, D_BUSYWAIT, MEM_ADDRESS, MEM_WRITEDATA);
	
	 /*
    -----
     DATA MEMORY
    -----
    */
	
	data_memory my_data_memeory(CLK, RESET, MEM_READ, MEM_WRITE, MEM_ADDRESS, MEM_WRITEDATA, MEM_READDATA, MEM_BUSYWAIT );
    

    /*
    -----
     INSTRUCTION CACHE
    -----
    */
    icache my_icache(CLK ,RESET ,PC[9:0] ,IREAD ,IMEM_BUSYWAIT ,READINST ,INSTRUCTION ,I_BUSYWAIT ,INSREAD ,INS_ADDRESS);

    
    /*
    -----
     INSTRUCTION MEMORY
    -----
    */
    instruction_memory insmem(CLK,INSREAD,INS_ADDRESS,READINST,IMEM_BUSYWAIT);

    assign BUSYWAIT = D_BUSYWAIT || I_BUSYWAIT;

    initial
    begin
    
        // generate files needed to plot the waveform using GTKWave
        $dumpfile("cpu_wavedata.vcd");
	$dumpvars(0, cpu_tb);
        
        CLK = 1'b0;
        RESET = 1'b0;
        
        // TODO: Reset the CPU (by giving a pulse to RESET signal) to start the program execution
        
	RESET = 1'b1;
	#5

	RESET = 1'b0;
        // finish simulation after some time
        #5000
        $finish;
        
    end
    
    // clock signal generation
    always #4 CLK = ~CLK;


    always @(PC) begin
		
        IREAD = 1;
        //$display("iread on");
    end

    always @(I_BUSYWAIT)
    begin
        if ( I_BUSYWAIT == 0)
            IREAD = 0;

		
	end
 

endmodule
