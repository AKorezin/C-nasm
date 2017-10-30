#include <stdlib.h>
#include <stdio.h>
#include <stdint.h>
#ifndef AMOUNT_OF_NUMBERS
#define AMOUNT_OF_NUMBERS 50
#endif
#ifndef AMOUNT_OF_ITERATIONS
#define AMOUNT_OF_ITERATIONS 1000000
#endif

int add(int l, int *a, int *b){
	int s=0;
	for(int i=0;i<l;i++){
		s+=a[i]*b[i];
	}
	return s;
}

int add_asm(int l,int *a, int *b);

int add_xmm_asm(int l, int *a, int *b);

uint64_t rdtsc();

int main(int argc, char** argv){
	int l=AMOUNT_OF_NUMBERS;
	int op=AMOUNT_OF_ITERATIONS;
	int *a=(int*)malloc(l*sizeof(int));
	int *b=(int*)malloc(l*sizeof(int));


	for(int i=0;i<l;i++){
		a[i]=i;
		b[i]=i;
	}
	volatile int test;
	printf("%d\n",add(l,a,b));
	printf("%d\n",add_asm(l,a,b));
	printf("%d\n",add_xmm_asm(l,a,b));
	uint64_t t1=0,t2=0,t3=0,t4=0;
	double ticks1,ticks2,ticks3;
	t1=rdtsc();
	for(int i=0;i<op;i++)
		test=add(l,a,b);
	t2=rdtsc();
	for(int i=0;i<op;i++)
		test=add_asm(l,a,b);
	t3=rdtsc();
	for(int i=0;i<op;i++)
		test=add_xmm_asm(l,a,b);
	t4=rdtsc();
	ticks1=(double)(t2-t1)/(2*l-1)/op;
	ticks2=(double)(t3-t2)/(2*l-1)/op;
	ticks3=(double)(t4-t3)/(2*l-1)/op;
	printf("%f\n%f\n%f\n",ticks1,ticks2,ticks3);
	free(a);
	free(b);
	return 0;
}
