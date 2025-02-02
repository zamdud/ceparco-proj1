#include <stdio.h>
#include <stdlib.h>
#include <windows.h>
#include <time.h>

extern void CKernel(size_t n, INT32* X, INT32* Y);
extern void x86Kernel(size_t n, INT32* X, INT32* Y);
extern void AVXKernel(size_t n, INT32* X, INT32* Y);
extern void AVX2Kernel(size_t n, INT32* X, INT32* Y);

int main() {
	const size_t n = 1<<28;
	const size_t ARRAY_BYTES = n * sizeof(INT32);
	int i;
	// NUMBER OF TIMES RUNNING THE KERNEL
	const size_t loop = 50;

	// DECLARE VECTORS
	INT32* X, * Y;
	X = (INT32*)malloc(ARRAY_BYTES);
	Y = (INT32*)malloc(ARRAY_BYTES);
		
	// INITIALIZE ARRAYS
	for (i = 0; i < n; i++) {
		X[i] = i + 1;
		Y[i] = 0;
	}

	CKernel(n, X, Y);
	x86Kernel(n, X, Y);
	AVX2Kernel(n, X, Y);

	//timer variables
	clock_t start, end;
	double elapse, time_taken;
	elapse = 0.0f;

	// Timing portion 

	for (int i = 0; i < loop; i++) {
		start = clock();
		// C Kernel Implementation
		CKernel(n, X, Y);
		end = clock();
		time_taken = ((double)(end - start)) * 1E3 / CLOCKS_PER_SEC;
		elapse = elapse + time_taken;
	}
	printf("Function (in C) average time for %lu loops is %f milliseconds for array size %lu \n", loop, elapse / loop, n);
	printf("---Correctness Check: C---\n");
	for (i = 0; i < 10; i++) {
		printf("Y[%d] = %d\n", i, Y[i]);
	}

	for (i = n - 11; i < n; i++) {
		printf("Y[%d] = %d\n", i, Y[i]);
	}
	
	// RESET TIME
	elapse = 0;

	// RE-INITIALIZE OUTPUT ARRAY
	for (i = 0; i < n; i++) {
		Y[i] = 0;
	}

	for (int i = 0; i < loop; i++) {
		start = clock();
		// x86 Kernel Implementation
		x86Kernel(n, X, Y);
		end = clock();
		time_taken = ((double)(end - start)) * 1E3 / CLOCKS_PER_SEC;
		elapse = elapse + time_taken;
	}
	printf("Function (in x86) average time for %lu loops is %f milliseconds for array size %lu \n", loop, elapse / loop, n);
	// ERROR CHECKING
	printf("---Correctness Check: x86-64---\n");
	for (i = 0; i < 10; i++) {
		printf("Y[%d] = %d\n", i, Y[i]);
	}

	for (i = n - 11; i < n; i++) {
		printf("Y[%d] = %d\n", i, Y[i]);
	}
	
	// RESET TIME
	elapse = 0;

	// RE-INITIALIZE OUTPUT ARRAY
	for (i = 0; i < n; i++) {
		Y[i] = 0;
	}

	for (int i = 0; i < loop; i++) {
		start = clock();
		// AVX Kernel Implementation
		AVXKernel(n, X, Y);
		end = clock();
		time_taken = ((double)(end - start)) * 1E3 / CLOCKS_PER_SEC;
		elapse = elapse + time_taken;
	}
	printf("Function (in AVX) average time for %lu loops is %f milliseconds to execute an array size %lu \n", loop, elapse / loop, n);
	printf("---Correctness Check: AVX---\n");
	for (i = 0; i < 10; i++) {
		printf("Y[%d] = %d\n", i, Y[i]);
	}

	for (i = n - 11; i < n; i++) {
		printf("Y[%d] = %d\n", i, Y[i]);
	}
	// RESET TIME
	elapse = 0;

	// RE-INITIALIZE OUTPUT ARRAY
	for (i = 0; i < n; i++) {
		Y[i] = 0;
	}

	for (int i = 0; i < loop; i++) {
		start = clock();
		// AVX2 Kernel Implementation
		AVX2Kernel(n, X, Y);
		end = clock();
		time_taken = ((double)(end - start)) * 1E3 / CLOCKS_PER_SEC;
		elapse = elapse + time_taken;
	}
	printf("Function (in AVX2) average time for %lu loops is %f milliseconds to execute an array size %lu \n", loop, elapse / loop, n);


	// ERROR CHECKING
	printf("---Correctness Check: AVX2---\n");
	for (i = 0; i < 10; i++) {
		printf("Y[%d] = %d\n", i, Y[i]);
	}

	for (i = n - 11; i < n; i++) {
		printf("Y[%d] = %d\n", i, Y[i]);
	}

	return 0;
}
