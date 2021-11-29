	.syntax		unified
	.cpu		cortex-m4
	.text


	.global		Q16GoodRoot
	.thumb_func
	.align
Q16GoodRoot:
			//R0 = radicand,R1 = residue,r2=sqroot,r3=bit
	PUSH	{R4,R5,R12}	
				//bit = (1 << 30) >> (__CLZ(radicand) & ~1) 
	LDR	R3,=(1<<30)	//1 << 30
	CLZ	R12,R0		//R12=CLZ radicand
	MVN	R5,1		//R13=~1
	AND	R12,R12,R5	//R12= (CLZ(radicand) & ~1
	LSR	R3,R3,R12	//R3= bit
	
	MOV	R1,R0		//residue = u32int radicand
	
	LDR	R2,=0			//Sqrt = 0
    LOOP:
	CMP	R3,0
	BEQ	ENDLOOP
				//R4=temp
	ADD	R4,R2,R3	//R4=sqroot+bit
	CMP	R1,R4		//residue>=temp
	BLO	IFNOT		//residue< temp
   
		SUB 	R1,R1,R4	//residue=residue-temp
		ADD	R2,R2,R3,LSL 1	//sqroot=sqroot+bit
    IFNOT:	
	LSR	R2,R2,1		//sqroot>>=1
	LSR	R3,R3,2		//bit>>=2
	B	LOOP
ENDLOOP:	
	
	LSL	R2,R2,8
	MOV	R0,R2
	POP	{R4,R5,R12}

	BX	LR	//return sqrt <<8 to q16
.end





/*

Q16 __attribute__((weak)) Q16GoodRoot(Q16 radicand)
    {
    uint32_t residue, sqroot, bit ;

    // set 'bit' to highest bit position less than radicand
    bit = (1 << 30) >> (__CLZ(radicand) & ~1) ;

    residue = (uint32_t) radicand ;     // residue will be the 'remainder'
  
    sqroot  = 0 ;                       // sqroot will be integer square root
    while (bit != 0)
        {
        uint32_t temp ;

        temp = sqroot + bit ;           // Compute once, use twice
        if (residue >= temp)            // Room to subtract?
            {
            residue -= temp ;           // Yes - deduct from residue
            sqroot += (bit << 1) ;      // and step sqroot
            }

        sqroot >>= 1 ;                  // Slide evolving sqroot 1 bit down the residue
        bit >>= 2 ;                     // Slide the bitpick 1 bit down the sqroot
        }

    return (Q16) (sqroot << 8) ;        // scale result for Q16 format
    }

*/
