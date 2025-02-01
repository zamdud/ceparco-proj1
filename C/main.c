#include "stdio.h"
#include "stdlib.h"
#include "windows.h"


void CKernel(size_t n, INT32* X, INT32* Y);
extern void x86Kernel(size_t n, INT32* X, INT32* Y);
extern void ACXKernel(size_t n, INT32* X, INT32* Y);
extern void AVX2Kernel(size_t n, INT32* X, INT32* Y);

int main() {
	const size_t n = 1<<20;
	const size_t ARRAY_BYTES = n * sizeof(INT32);
	int i;
	
	// DECLARE VECTORS
	INT32* X, * Y;
	X = (INT32*)malloc(ARRAY_BYTES);
	Y = (INT32*)malloc(ARRAY_BYTES);

	// INITIALIZE ARRAYS
	for (i = 0; i < n; i++) {
		X[i] = i + 1;
		Y[i] = 0;
	}
	
	// Timing portion
	

	// C Kernel Implementation
	//CKernel(n, X, Y);
	
	// x86 Kernel Implementation
	//x86Kernel(n, X, Y);

	// AVX Kernel Implementation
	//AVXKernel(n, X, Y);

	// AVX2 Kernel Implementation
	//AVX2Kernel(n, X, Y);

	// ERROR CHECKING

	for (i = 3; i < n-3; i++) {
		printf("Y[%d] = %d\n", i, Y[i]);
	}

	return 0;
}