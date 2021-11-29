#include <stdint.h>
#include <stdio.h>


int32_t Bits2Signed(int8_t bits[8]){
	int32_t temp = 0;
	if(bits[7]){
		temp = -128;
	} 

	int n=0;
	for(int i=6; i>=0;i--){
		n=2*n+bits[i];
	}
	n += temp;
	return n;
}




uint32_t Bits2Unsigned(int8_t bits[8]){
	int n=0;
	for(int i=7; i>=0;i--){
		n=2*n+bits[i];
	}
	return n;
}

void Increment(int8_t bits[8]){
	int i=0;
	while(bits[i] == 1){
		bits[i] = 0;
		i++;
	}
	bits[i] =1;
}

void Unsigned2Bits(uint32_t n, int8_t bits[8]){
	int i;	
	for(i = 0; i<=7; i++){
		bits[i] = n % 2;
		n = n/2;
	}

}










