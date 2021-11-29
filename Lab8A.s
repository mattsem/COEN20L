.syntax	unified
.cpu	cortex-m4
.text



//uint32_t Zeller1(uint32_t k, uint32_t m, uint32_t D, uint32_t C) ;
	.global	Zeller1
	.thumb_func
	.align
Zeller1:			
	PUSH	{R4,R5,R6,R7,R8,R9}
	MOV	R4,R0
	MOV	R5,R1		//R2=D,R3=c,R4=k,R5=m
	LDR	R8,=13	
	MUL	R5,R5,R8	//13m
	SUB	R5,R5,1		//13m-1
	LDR	R8,=5		
	SDIV	R5,R5,R8	//(13*m-1)/5
	ADD	R5,R5,R4	//k+(13m-1)/5
	ADD	R5,R5,R2	//k+(13m-1)/5+D
	LDR	R8,=4
	SDIV	R2,R2,R8	//R2=D/4
	ADD	R5,R5,R2	//k+(13m-1)/5+D+D/4
	LDR	R8,=2	
	MUL	R7,R3,R8	//R7=c*2
	SUB	R5,R5,R7	//k+(13m-1)/5+D+D/4-c*2
	LDR	R8,=4
	SDIV	R3,R3,R8	//R3=c/4
	ADD	R5,R5,R3	//k+(13m-1)/5+D+D/4+C/4-C*2		

	LDR	R8,=7
	SDIV	R9,R5,R8	
	MUL	R1,R9,R8	
	SUB	R0,R5,R1 	//mod 7
	
	CMP	R0,0
	BGE	L1
	
		ADD	R0,R0,7
	L1:

	POP	{R4,R5,R6,R7,R8,R9}
	BX	LR

//uint32_t Zeller2(uint32_t k, uint32_t m, uint32_t D, uint32_t C) ;
	.global	Zeller2
	.thumb_func
	.align
Zeller2:
     PUSH    {R4,R5,R6,R7,R8,R9}
        MOV     R4,R0
        MOV     R5,R1           //R2=D,R3=c,R4=k,R5=m
        LDR     R8,=13
        MUL     R5,R5,R8        //13m
        SUB     R5,R5,1         //13m-1

        LDR     R8,=3435973837
	UMULL	R9,R8,R8,R5
	LSR	R5,R8,2	
				//(13*m-1)/5


        ADD     R5,R5,R4        //k+(13m-1)/5
        ADD     R5,R5,R2        //k+(13m-1)/5+D
        

	ASR	R2,R2,2
				//R2=D/4


        ADD     R5,R5,R2        //k+(13m-1)/5+D+D/4
        LDR     R8,=2
        MUL     R7,R3,R8        //R7=c*2
        SUB     R5,R5,R7        //k+(13m-1)/5+D+D/4-c*2
       
	ASR	R3,R3,2         //R3=c/4


        ADD     R5,R5,R3        //k+(13m-1)/5+D+D/4+C/4-C*2


	MOV	R9,R5
        LDR	R8,=2454267027
	SMMLA	R8,R8,R9,R9
	LSR	R9,R9,31
	ADD	R9,R9,R8,ASR 2
				//f/7	
	LDR 	R8,=7
        MUL     R1,R9,R8
        SUB     R0,R5,R1        //mod 7

        CMP     R0,0
        BGE     L2

                ADD     R0,R0,7
        L2:

        POP     {R4,R5,R6,R7,R8,R9}
        BX      LR


//uint32_t Zeller3(uint32_t k, uint32_t m, uint32_t D, uint32_t C) ;
	.global	Zeller3
	.thumb_func
	.align
Zeller3:
	PUSH    {R4,R5,R6,R7,R8,R9}
        MOV     R4,R0
        MOV     R5,R1           //R2=D,R3=c,R4=k,R5=m
        
	
	LSL	R8,R5,3
	ADD	R8,R8,R5,LSL 2
	ADD	R8,R8,R5
	MOV	R5,R8		//13m


        SUB     R5,R5,1         //13m-1
        LDR     R8,=5
        SDIV    R5,R5,R8        //(13*m-1)/5
        ADD     R5,R5,R4        //k+(13m-1)/5
        ADD     R5,R5,R2        //k+(13m-1)/5+D
        LDR     R8,=4
        SDIV    R2,R2,R8        //R2=D/4
        ADD     R5,R5,R2        //k+(13m-1)/5+D+D/4

	LSL	R7,R3,1 //R7=c*2

        SUB     R5,R5,R7        //k+(13m-1)/5+D+D/4-c*2
        LDR     R8,=4
        SDIV    R3,R3,R8        //R3=c/4
        ADD     R5,R5,R3        //k+(13m-1)/5+D+D/4+C/4-C*2

        LDR     R8,=7
        SDIV    R9,R5,R8
	
	RSB	R1,R9,R9,LSL 3	//mul by 7
       
        SUB     R0,R5,R1        //mod 7

        CMP     R0,0
        BGE     L3

                ADD     R0,R0,7
        L3:

        POP     {R4,R5,R6,R7,R8,R9}
        BX      LR


.end
