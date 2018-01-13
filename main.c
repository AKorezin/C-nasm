#include <stdlib.h>
#include <stdio.h>
#ifndef AMOUNT_OF_NUMBERS
#define AMOUNT_OF_NUMBERS 50
#endif


float sum(int, float *, float *);

int main(int argc, char** argv){
	int num=AMOUNT_OF_NUMBERS;
	float *x=(float*)malloc(num*sizeof(float));
	float *a=(float*)malloc(num*sizeof(float));

	for(int i=0;i<num;i++){
		x[i]=i;
		a[i]=i;
	}
	volatile int test;
	printf("%f\n",sum(num,x,a));
	free(x);
	free(a);
	return 0;
}
