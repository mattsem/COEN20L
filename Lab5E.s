	.syntax		unified
	.cpu		cortex-m4
	.text

	

//void Log2Phys(uint32_t lba, uint32_t heads, uint32_t sectors, CHS *phy);
	.global Log2Phys
	.thumb_func
	.align

Log2Phys:
	PUSH	{R6-R11}

	MUL	R6,R1,R2
	UDIV	R7,R0,R2	//R7 = cylinder
	STRH	R7,[R3]	
	
	UDIV	R8,R0,R2	//R8=lba/sectors
	UDIV 	R9,R8,R1	//R9 = quotient
	MLS	R10,R1,R9,R8	//R10 = (R8)%R1 = head
	STRB	R10,[R3,2]
				//R8 = lba/sectors
	MLS	R11,R2,R8,R0 	//lba%sectors
	ADD	R11,R11,1 	//R11 = lba%sectors+1 = sector
	STRB	R11,[R3,3]

	POP	{R6-R11}	
	BX	LR
			
.end




