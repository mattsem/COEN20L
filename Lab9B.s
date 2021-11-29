.syntax		unified
.cpu		cortex-m4
.text


	//void __attribute__((weak)) Integrate(void)
		.global	Integrate
		.thumb_func
		.align
	Integrate:	//x=S16,v=S17,r=S18,prev=S19,a=S20,dx=S21,n=R4			
		PUSH	{R4,LR}
		VPUSH	{S16,S17,S18,S19,S20,S21,S22,S23,S24,S25,S26,S27,S28,S29}
		
		BL	DeltaX	//S0 receives dx
		VMOV	S21,S0 		//move S0 to S21
		
		
		VSUB.F32	S28,S28,S28	//load 0.0
		VMOV		S17,S28		//v=0.0
		VMOV		S20,S28		//a=0.0
		VMOV		S28,1.0
		VMOV		S16,S28		//x=1.0
		VMOV		S18,S28		//r=1.0
		LDR		R4,=0		//n=0

	REPT:
		MOV	R0,R4
		VMOV	S0,S18
		VMOV	S1,S17
		VMOV	S2,S20
		
		BL	UpdateDisplay		//call UD

		//MOV	R4,R0
		//VMOV	S18,S0
		//VMOV	S17,S1
		//VMOV	S20,S2
					
		VMOV	S19,S17			//prev=v


		
		VMOV		S28,1.0
		VDIV.F32	S22,S28,S16		//1/x,  S22=1/S16
		VADD.F32	S23,S16,S21		//x+dx,  S23=S16+S21
		VDIV.F32	S24,S28,S23		//1/S23,  S24=1/S23	
		VADD.F32	S25,S22,S24		//S22+S24, S25=S22+S24
		VMOV		S28,2.0
		VDIV.F32	S26,S25,S28		//S25/2,  S26=S25/2	
		VMOV		S18,S26

		VMUL.F32	S27,S26,S26		//R*R,   S27=S26*S26
		VADD.F32	S17,S17,S27		//V+=S27,  S17=S17+S27

		VADD.F32	S20,S20,S26		//a+=r,  S20=S20+S26					
				
		ADD		R4,R4,1		 	//n+=1,  R4=R4+1
				
		VADD.F32	S16,S16,S21		//x+=dx,  S16=S16+S21

	
		VCMP.F32	S17,S19			//compare v!=prev
		VMRS		APSR_nzcv,FPSCR		//set flags
		BNE		REPT			//if not equal keep looping					
			


		VPOP	{S16,S17,S18,S19,S20,S21,S22,S23,S24,S25,S26,S27,S28,S29}
		POP 	{R4,LR}
		BX	LR

	.end


/*
void __attribute__((weak)) Integrate(void)
    {
    float x, v, r, prev, a, dx ;
    int n ;

    dx = DeltaX() ;
    v = a = 0.0 ;
    x = r = 1.0 ;
    n = 0 ;
    do
        {
        UpdateDisplay(n, r, v, a) ;

        prev = v ;

        r = (1/x + 1/(x + dx))/2 ;
        v += r*r ;
        a += r ;
        n++ ;

        x += dx ;

        } while (v != prev) ;
    }
*/

