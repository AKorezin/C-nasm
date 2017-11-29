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

float add_f(int l, float *a, float *b){
	float s=0;
	for(int i=0;i<l;i++){
		s+=a[i]*b[i];
	}
	return s;
}
double add_d(int l, double *a, double *b){
	double s=0;
	for(int i=0;i<l;i++){
		s+=a[i]*b[i];
	}
	return s;
}

int add_asm(int l,int *a, int *b);

int add_xmm_asm(int l, int *a, int *b);

float add_f_asm(int l, float *a, float *b);
double add_d_asm(int l, double *a, double *b);

uint64_t rdtsc();

int main(int argc, char** argv){
	int l=AMOUNT_OF_NUMBERS;
	int op=AMOUNT_OF_ITERATIONS;
	int *a=(int*)aligned_alloc(32,l*sizeof(int));
	int *b=(int*)aligned_alloc(32,l*sizeof(int));
	float *a_f=(float*)malloc(l*sizeof(float));
	float *b_f=(float*)malloc(l*sizeof(float));
	double *a_d=(double*)malloc(l*sizeof(double));
	double *b_d=(double*)malloc(l*sizeof(double));


	for(int i=0;i<l;i++){
		a[i]=i;
		b[i]=i;
		a_f[i]=i;
		b_f[i]=i;
		a_d[i]=i;
		b_d[i]=i;
	}
	volatile int test;
	printf("%d\n",add(l,a,b));
	printf("%d\n",add_asm(l,a,b));
	printf("%d\n\n",add_xmm_asm(l,a,b));
	printf("%f\n",add_f(l,a_f,b_f));
	printf("%f\n\n",add_f_asm(l,a_f,b_f));
	printf("%f\n",add_d(l,a_d,b_d));
	printf("%f\n\n",add_d_asm(l,a_d,b_d));
	uint64_t t[8];
	double ticks;
	int j=0;
	for(int i=0;i<8;i++){
		t[i]=0;
	}
	
	t[j]=rdtsc();
	for(int i=0;i<op;i++)
		test=add(l,a,b);
	j++;
	t[j]=rdtsc();
	for(int i=0;i<op;i++)
		test=add_asm(l,a,b);
	j++;
	t[j]=rdtsc();
	for(int i=0;i<op;i++)
		test=add_xmm_asm(l,a,b);
	j++;
	t[j]=rdtsc();
	for(int i=0;i<op;i++)
		test=add_f(l,a_f,b_f);
	j++;
	t[j]=rdtsc();
	for(int i=0;i<op;i++)
		test=add_f_asm(l,a_f,b_f);
	j++;
	t[j]=rdtsc();
	for(int i=0;i<op;i++)
		test=add_d(l,a_d,b_d);
	j++;
	t[j]=rdtsc();
	for(int i=0;i<op;i++)
		test=add_d_asm(l,a_d,b_d);
	j++;
	t[j]=rdtsc();
	for(int i=0;i<7;i++){
		ticks=(double)(t[i+1]-t[i])/(2*l-1)/op;
		printf("%f\n",ticks);
		if(i==2 || i==4){
			printf("\n");
		}
	}
	free(a);
	free(b);
	free(a_f);
	free(b_f);
	free(a_d);
	free(b_d);
	return 0;
}
