@ ARM Assembly - lab 2
@ Group Number :

	.text 	@ instruction memory
	.global main
main:
	@ stack handling, will discuss later
	@ push (store) lr to the stack
	sub sp, sp, #4
	str lr, [sp, #0]

	@ load values
	
	@ Write YOUR CODE HERE
	
	@	Sum = 0;
	@	for (i=0;i<10;i++){
	@			for(j=5;j<15;j++){
	@				if(i+j<10) sum+=i*2
	@				else sum+=(i&j);	
	@			}	
	@	} 
	@ Put final sum to r5


	@ ---------------------
	
	mov r5,#0    	 @ sum = 0
	mov r6,#0   	 @   i = 0
	
loop1:	cmp r6, #10   @ comparing i with 10
		bge exit1
		
		mov r1, #5   			@ j = 5
		loop2:  cmp r1, #15     @ comparing j with 15
				bge exit2       @ exit from loop2(jump to exit2 label)
				add r7, r6, r1  @ r7 = i+j
				
				cmp r7, #10  			 @ comparing with i +j<10
				bge else      			 @ jump to else part
				add r5, r5, r6, lsl #1   @ sum+=i*2
				b exit3                  @ jump to exit3 label
				
				else: and r8, r6, r1     @ r8 = i & j
				      add r5, r5, r8     @ sum += i&j
				
				exit3:  
				add r1, r1, #1   @ j++
				b loop2 		 @ calling loop2 again
				
	exit2:
	add r6,r6,#1   @ i++
	b loop1;       @ calling loop1 again	
	exit1:         @ exit from loop1
	
	
	@ ---------------------
	
	
	@ load aguments and print
	ldr r0, =format
	mov r1, r5
	bl printf

	@ stack handling (pop lr from the stack) and return
	ldr lr, [sp, #0]
	add sp, sp, #4
	mov pc, lr

	.data	@ data memory
format: .asciz "The Answer is %d (Expect 300 if correct)\n"

