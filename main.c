#include <stdlib.h>
#include <stdio.h>
#ifndef AMOUNT_OF_NUMBERS
#define AMOUNT_OF_NUMBERS 50
#endif


float sum(int, float *, float *, float *);

int main(int argc, char** argv){
	int num=AMOUNT_OF_NUMBERS;
	float *x=(float*)malloc(num*sizeof(float));
	float *a=(float*)malloc(num*sizeof(float));
	float *l=(float*)malloc(num*sizeof(float));

	for(int i=0;i<num;i++){
		x[i]=i+1;
		a[i]=i+2;
		l[i]=i+3;
	}
	volatile int test;
	printf("%f\n",sum(num,x,a,l));
	free(x);
	free(a);
	free(l);
	return 0;
}
