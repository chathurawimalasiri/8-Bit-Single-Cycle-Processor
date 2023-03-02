/*
Module  : Data Cache 
Author  : Isuru Nawinne, Kisaru Liyanage
Date    : 25/05/2020

Description	:

This file presents a skeleton implementation of the cache controller using a Finite State Machine model. Note that this code is not complete.
*/

`timescale  1ns/100ps

module dcache (clock, reset, read, write, writedata, address, readdata, busywait, mem_busywait, mem_read, mem_write, mem_writedata, mem_readdata, mem_address, dirty, hit, tag, index, tag1, writedata1 );
    
	
	input clock, reset, read, write, mem_busywait;
	input [7:0] writedata, address;
	input [31:0] mem_readdata, writedata1;
	input [2:0] tag, index, tag1;
	
	input dirty, hit;
	
	output busywait, mem_read, mem_write;
	output [5:0] mem_address;
	output [7:0] readdata;
	output [31:0] mem_writedata;
	
	reg [31:0] mem_writedata;
	reg [5:0] mem_address;
	reg mem_read,mem_write,busywait;
	
    /*
    Combinational part for indexing, tag comparison for hit deciding, etc.
    ...
    ...
    */
    

    /* Cache Controller FSM Start */

    parameter IDLE = 3'b000, MEM_READ = 3'b001, WRITE_BACK = 3'b010;
    reg [2:0] state, next_state;

    // combinational next state logic
    always @(*)
    begin
        case (state)
            IDLE:
                if ((read || write) && !dirty && !hit)  
                    next_state = MEM_READ;
                else if ((read || write) && dirty && !hit)
                    next_state = WRITE_BACK;
                else
                    next_state = IDLE;
            
            MEM_READ:
                if (!mem_busywait)
                    next_state = IDLE;
                else    
                    next_state = MEM_READ;
            
			WRITE_BACK:
				if (!mem_busywait)
                    next_state = MEM_READ;
                else    
                    next_state = WRITE_BACK;
				
			
        endcase
    end

    // combinational output logic
    always @(*)
    begin
        case(state)
            IDLE:
            begin
                mem_read = 0;
                mem_write = 0;
                mem_address = 8'dx;
                mem_writedata = 8'dx;
                busywait = 0;
            end
         
            MEM_READ: 
            begin
                mem_read = 1;
                mem_write = 0;
                mem_address = {tag, index};
                mem_writedata = 32'dx;
                busywait = 1;
            end
			
			WRITE_BACK:
			begin
                mem_read = 0;
                mem_write = 1;
                mem_address = {tag1, index};
                mem_writedata = writedata1; 
                busywait = 1;
            end
            
        endcase
    end

    // sequential logic for state transitioning 
    always @(posedge clock, reset)
    begin
        if(reset)
            state = IDLE;
        else
            state = next_state;
    end

    /* Cache Controller FSM End */

endmodule