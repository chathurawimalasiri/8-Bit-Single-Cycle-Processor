@ ARM Assembly - lab 3.1
@ 
@ Roshan Ragel - roshanr@pdn.ac.lk
@ Hasindu Gamaarachchi - hasindu@ce.pdn.ac.lk

	.text 	@ instruction memory

	
@ Write YOUR CODE HERE	

@ mypow(int x, int n){
@	int val = 1;
@	for(int i=0; i<n; i++){
@	val = val * x;
@	}
@return val;	
@}

@ ---------------------	
mypow:

		@ stack handeling
		sub sp, sp, #12
		@ no need to use str, lr because this is not resursive fn
		str r4,[sp, #8]
		str r5,[sp, #4]
		str r6,[sp, #0]

		mov r4, #1 @ i = 1
		mov r5, #1 @ val = 1 
		mov r6, #1 @ r6 = 1

loop:
		cmp r4, r1  
		bgt exit    @ i>n
		mul r6, r5, r0  @ r6 = r5 * x
		mov r5, r6      @ r5 = r6
		add r4, r4, #1  @ i++
		b loop

exit:
			mov r0, r6   @ r0 = r6

			@ restore value
			
			ldr r4, [sp, #8]
			ldr r5, [sp, #4]
			ldr r6, [sp, #0]
			add sp, sp, #12
			mov pc, lr   @ returning from the function


@ ---------------------	

	.global main
main:
	@ stack handling, will discuss later
	@ push (store) lr to the stack
	sub sp, sp, #4
	str lr, [sp, #0]

	mov r4, #-2 	@the value x
	mov r5, #3 	@the value n
	

	@ calling the mypow function
	mov r0, r4 	@the arg1 load
	mov r1, r5 	@the arg2 load
	bl mypow
	mov r6,r0
	

	@ load aguments and print
	ldr r0, =format
	mov r1, r4
	mov r2, r5
	mov r3, r6
	bl printf

	@ stack handling (pop lr from the stack) and return
	ldr lr, [sp, #0]
	add sp, sp, #4
	mov pc, lr

	.data	@ data memory
format: .asciz "%d^%d is %d\n"

