@ ARM Assembly - lab 3.2 
@ Group Number :

	.text 	@ instruction memory

	
@ Write YOUR CODE HERE	
@GCD(int a,int b){
@	if(b==0){
@		return a;
@	}else{
@		return GCD(b, a%b);
@	}
@}

@ ---------------------	
 @ r0 = a @ r1 =b
gcd:

			@ stack handeling
			sub sp, sp, #4
			str lr , [sp, #0]


			cmp r1, #0 
			beq exit  @ if b==0 return a

			b mod @cal culate a%b
done:

			bl gcd @ branch and link to gcd fn

exit:

			@ restore stack and returning
			ldr lr , [sp, #0]
			add sp, sp, #4
			mov pc, lr


@ modulus function
mod:
			@ preserving using register values in stack
			sub		sp, sp, #4
			str		r7 , [sp, #0]
			
			@ saving initial value of  r1
			mov		r7, r1

			@ getting how many counts need to pass r0, by r1
while:
			cmp		r0, r1
			
			blt		exit_while
			add		r1, r1, r7 @ r1+=r1
			
			b		while
exit_while:
			sub r1, r1, r7
			sub r1, r0, r1 @ r1 = r0%r1
			mov r0, r7 @ r0 = r1
			
			@ restoring values
			ldr		r7 , [sp, #0]
			add		sp, sp, #4
			b		done


@ ---------------------	

	.global main
main:
	@ stack handling, will discuss later
	@ push (store) lr to the stack
	sub sp, sp, #4
	str lr, [sp, #0]

	mov r4, #10 	@the value a
	mov r5, #10   	@the value b
	

	@ calling the mypow function
	mov r0, r4 	@the arg1 load
	mov r1, r5 	@the arg2 load
	bl gcd
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
format: .asciz "gcd(%d,%d) = %d\n"

