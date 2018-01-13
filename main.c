#include <stdlib.h>
#include <stdio.h>
#ifndef AMOUNT_OF_NUMBERS
#define AMOUNT_OF_NUMBERS 50
#endif


double sum(int, double *, double *);

int main(int argc, char** argv){
	int num=AMOUNT_OF_NUMBERS;
	double *x=(double*)malloc(num*sizeof(double));
	double *a=(double*)malloc(num*sizeof(double));

	for(int i=0;i<num;i++){
		x[i]=i;
		a[i]=i;
	}
	printf("%f\n",sum(num,x,a));
	free(x);
	free(a);
	return 0;
}
