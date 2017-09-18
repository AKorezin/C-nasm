#include <stdlib.h>
#include <stdio.h>
#define N 50

int add(int l, int *a, int *b){
	int s=0;
	for(int i=0;i<l;i++){
		s+=a[i]*b[i];
	}
	return s;
}

int add_asm(int l,int *a, int *b);

int main(int argc, char** argv){
	int l=N;
	int *a=(int*)malloc(l*sizeof(int));
	int *b=(int*)malloc(l*sizeof(int));
	for(int i=0;i<l;i++){
		a[i]=i;
		b[i]=i;
	}
	printf("%d\n",add(l,a,b));
	printf("%d\n",add_asm(l,a,b));

	free(a);
	free(b);
	return 0;
}
