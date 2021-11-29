
.syntax		unified
	.cpu	cortex-m4
	.text





//void PutNibble(void *nibbles, uint32_t which, uint32_t value) ;
	.global		PutNibble
	.thumb_func
	.align

PutNibble:
	PUSH	{R4,R5}
	MOV	R4,R0		//move *nibbles to R4
	MOV	R5,R1		//move u32 which to R1
	LSR	R5,R5,1		//which>>1==which/2
	ADD	R4,R4,R5	//Add which/2 + nibbles
	LDRB	R4,[R4]		//grab the u8 
	AND	R1,R1,1		//Turn R1 into 0=even, 1=odd
	CMP	R1,0		
	ITE	EQ		//if equal, then ___ else__
	
	BFIEQ	R4,R2,0,4	//takes the first half if equal	
	BFINE	R4,R2,4,4	//takes the second half if not
	STRB	R4,[R0,R5]	//store offset R5
	
	POP	{R4,R5}
	BX	LR


//uint32_t GetNibble(void *nibbles, uint32_t which) ;
	.global		GetNibble
	.thumb_func
	.align

GetNibble:
	PUSH	{R4,R5}
	MOV	R4,R0		//move *nibbles to R4
	MOV	R5,R1		//move which to r5
	LSR	R5,R5,1		//which/2
	ADD	R4,R4,R5	//R4 = nibbles +which/2
	LDRB	R4,[R4]		//grab u8			
	AND	R1,R1,1		//turn to even or odd
	CMP	R1,0		
	ITE	EQ

	UBFXEQ	R0,R4,0,4	//extends first half if equal
	UBFXNE	R0,R4,4,4	//extends second half if not
	
	POP	{R4,R5}
	BX	LR

.end

