.syntax		unified
.cpu		cortex-m4
.text


//void CopyCell(uint32_t *dst, uint32_t *src) ;
	.global		CopyCell
	.thumb_func
	.align

CopyCell:		//R0 = *dst,R1 = *src
	PUSH	{R4}
	
	.rept	60
		LDR	R3,=0		//cols			
	
		.rept	60
			LDR	R4,[R1,R3,LSL 2]	//load src[cols] to r4
			STR	R4,[R0,R3,LSL 2] 	//store r4 to dst[cols]
			ADD R3,R3,1			//increment cols
		.endr


		ADD	R0,R0,960
		ADD	R1,R1,960
	.endr

	POP	{R4}
	BX	LR

//void FillCell(uint32_t *dst, uint32_t pixel) ;
	.global FillCell
	.thumb_func
	.align
FillCell:		//R0=*dst,R1 = pixel	
	
	.rept	60
		
		LDR	R3,=0		//cols			
	
		.rept	60
			
			STR	R1,[R0,R3,LSL 2]	//store pixel to dst[cols] 	
			ADD	R3,R3,1
		.endr

		ADD	R0,R0,960
	.endr

	BX	LR

.end
