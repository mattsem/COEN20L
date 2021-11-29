	.syntax		unified
	.cpu		cortex-m4
	.text


/* int32_t Add(int32_t a, int32_t b) */
	.global Add
	.thumb_func
	.align
Add:
	ADD 	R0,R0,R1	//a+b
	BX	LR
	

/* int32_t Less1(int32_t a) */
	.global Less1
	.thumb_func
	.align
Less1:
	SUB	R0,R0,1		//a-1
	BX	LR


/* int32_t Square2x(int32_t x) */
	.global Square2x
	.thumb_func
	.align
Square2x:
	ADD R0, R0, R0		// ADD r0 and r0 to r0
	B Square		//Branch to Prof code

/* int32_t Last(int32_t x) */	
	.global Last
	.thumb_func
	.align
Last:
	PUSH {R5,LR}		//push r5 and lr onto stack
	MOV R5,R0		//Move R0 to R5
	BL SquareRoot
	ADD R0,R0,R5		
	POP {R5,LR}		//take r5 and lr off of stack
	BX LR

		

	.end	//EOF
