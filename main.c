#include <stdlib.h>
#include <stdio.h>
#ifndef AMOUNT_OF_NUMBERS
#define AMOUNT_OF_NUMBERS 50
#endif
#ifndef CONSTANT
#define CONSTANT 1
#endif


double sum(int, double *, double *, double *, double);

int main(int argc, char** argv){
	int num=AMOUNT_OF_NUMBERS;
	/*int *a=(int*)aligned_alloc(32,l*sizeof(int));
	int *b=(int*)aligned_alloc(32,l*sizeof(int));*/
	double *x=(double*)malloc(num*sizeof(double));
	double *a=(double*)malloc(num*sizeof(double));
	double *l=(double*)malloc(num*sizeof(double));
	double c=CONSTANT;

	for(int i=0;i<num;i++){
		x[i]=i;
		a[i]=i;
		l[i]=0;
	}
	volatile int test;
	printf("%f\n",sum(num,x,a,l,c));
	free(x);
	free(a);
	free(l);
	return 0;
}
