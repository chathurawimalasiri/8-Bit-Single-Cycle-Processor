@ lab 4
@ Group 02

	.text	@ instruction memory

	
	.global main
main:
	
	@ push (store) lr to the stack, allocate space for 100 chars (scanf)
	
	sub	sp, sp, #4
	str	lr, [sp, #0]
	
    @allocate stack for input
	sub	sp, sp, #4

	@printf for string
	ldr	r0, =formatr
	bl	printf

    @scanf for num
	ldr	r0, =formats
	mov	r1, sp	
	bl	scanf	@scanf("%d",sp)

	@copy num from the stack to register r4
	ldr	r4, [sp]

	@release stack
	add	sp, sp, #4

    cmp r4, #0
    bge else
    @printf for string
	ldr	r0, =format1
	bl	printf
    b exit

    else:
        mov r5, #0 @ int i=0
        
        loop:
        cmp r5,r4
        beq exit

        mov r1, r5
        ldr	r0, =format2
	    bl	printf

        sub	sp, sp, #200
        @scanf for string
        ldr	r0, =formatst
        mov	r1, sp
        bl	scanf	@scanf("%s",sp)

        mov r0, r1
        mov r1, r5
        ldr	r0, =format3
	    bl	printf

        

        //implement reverse string
        @function call
        mov	r0, sp
        bl	stringLen
        mov r7, r0; @ r7 = length of the string

        
        mov r6, #0  @ int j=0
        mov r8, sp
        add r8, r8, r7
        @add r8, r8, r7
        
        loop2:
        cmp  r6, r7
        beq exloop2
        
        sub r8, r8, #1
        ldrb r1,[r8,#0]
        ldr	r0, =formatp
        bl	printf

        add r6, r6, #1 @ j++
        b loop2

        exloop2:
        ldr	r0, =formatl
        bl	printf
        add r5,  r5, #1 @ i++
        add	sp, sp, #200

        b loop

exit:
	
    @ stack handling (pop lr from the stack) and return
	mov	r0, #0		@return 0
	ldr	lr, [sp, #0]
	add	sp, sp, #4
	mov	pc, lr		



	@ string length function
stringLen:
	sub	sp, sp, #4
	str	lr, [sp, #0]

	mov	r1, #0	@ length counter

lop:
	ldrb	r2, [r0, #0]
	cmp	r2, #0
	beq	endLoop

	add	r1, r1, #1	@ count length
	add	r0, r0, #1	@ move to the next element in the char array
	b	lop

endLoop:
	mov	r0, r1		@ to return the length
	ldr	lr, [sp, #0]
	add	sp, sp, #4
	mov	pc, lr

	.data	@ data memory
formatr:  .asciz "Enter the number of strings :\n"
formats:  .asciz "%d"
format1:  .asciz "Invalid Number\n"
format2:  .asciz "Enter input string %d\n"
formatp:  .asciz "%c"
formatl:  .asciz "\n"
formatst: .asciz " %[^\n]%*c"
format3:  .asciz "Output string %d is..\n"

