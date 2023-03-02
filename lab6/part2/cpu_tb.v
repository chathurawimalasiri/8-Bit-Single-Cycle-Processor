// Computer Architecture (CO224) - Lab 05
// Design: Testbench of Integrated CPU of Simple Processor
// Author: Isuru Nawinne

`include "cpu.v"
`include "datamemory.v"
 `include "cache.v"

`timescale 1ns/100ps

module cpu_tb;

    reg CLK, RESET;

	//reg [7:0] address, writedata, READDATA;
	
	wire BUSYWAIT, WRITE, READ, mem_busywait,mem_write, mem_read  ;
	wire [7:0] READDATA, WRITEDATA, ADDRESS;
    wire [31:0] PC, mem_readdata, mem_writedata;
    wire [31:0] INSTRUCTION;
    wire [5:0] mem_address;
    
    /* 
    ------------------------
     SIMPLE INSTRUCTION MEM
    ------------------------
    */
    
    // TODO: Initialize an array of registers (8x1024) named 'instr_mem' to be used as instruction memory
	
	reg [7:0] instr_mem [1023:0]; 	// instruction array
    
    // TODO: Create combinational logic to support CPU instruction fetching, given the Program Counter(PC) value 
    //       (make sure you include the delay for instruction fetching here)
    
	assign #2 INSTRUCTION = {instr_mem[PC + 3],instr_mem[PC + 2],instr_mem[PC + 1],instr_mem[PC]};	// fetching instruction with time delay
	
    initial
    begin
        // Initialize instruction memory with the set of instructions you need execute on CPU
        
        // METHOD 1: manually loading instructions to instr_mem
        //{instr_mem[10'd3], instr_mem[10'd2], instr_mem[10'd1], instr_mem[10'd0]} = 32'b00000000000001000000000000000101;
        //{instr_mem[10'd7], instr_mem[10'd6], instr_mem[10'd5], instr_mem[10'd4]} = 32'b00000000000000100000000000001001;
        //{instr_mem[10'd11], instr_mem[10'd10], instr_mem[10'd9], instr_mem[10'd8]} = 32'b00000010000001100000010000000010;
		
        // METHOD 2: loading instr_mem content from instr_mem.mem file
        $readmemb("instr_mem.mem", instr_mem);
    end


    
    /*
    -----
     CPU
    -----
    */
    cpu mycpu(WRITEDATA, ADDRESS, WRITE, READ, PC, INSTRUCTION, CLK, RESET, BUSYWAIT, READDATA );
	
	 /*
    -----
     CACHE MEMORY
    -----
    */
    dcache mycache(CLK,RESET,READ,WRITE,ADDRESS,WRITEDATA,mem_busywait,mem_readdata,READDATA,mem_read,mem_write,BUSYWAIT,mem_address,mem_writedata );
    
    /*
    -----
     DATA MEMORY
    -----
    */
    data_memory my_data_memory(CLK, RESET, mem_read, mem_write, mem_address, mem_writedata, mem_readdata, mem_busywait );


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
        #1500
        $finish;
        
    end
    
    // clock signal generation
    always #4 CLK = ~CLK;
 

endmodule
