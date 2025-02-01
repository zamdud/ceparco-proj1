// #include <stdio.h>
// #include <stdlib.h>
#include <windows.h>
// #include <time.h>

extern void CKernel(size_t ARRAY_SIZE, INT32* x, INT32* y)
{
    // const size_t ARRAY_BYTES = ARRAY_SIZE * sizeof(INT32); //For windows
    // const size_t ARRAY_BYTES = ARRAY_SIZE * 4; //MacOS

    //Declare Dynamic Array
    // int *x, *y;

    // x = (int*)malloc(ARRAY_BYTES);
    // y = (int*)malloc(ARRAY_BYTES);
    
    
    //Initialize Array

    // for(int i = 0; i<=ARRAY_BYTES; i++)
    // {
    //     x[i] = i+1;
    //     y[i] = 0;
    // }

    //Addition
    for(int i=3;i<ARRAY_SIZE-3;i++)
    {
        y[i] = x[i-3] + x[i-2] + x[i-1] + x[i] + x[i+1] + x[i+2] + x[i+3];
    }

    // for(int i=3;i<ARRAY_SIZE-3;i++)
    // {
    //     printf("y[%d] = %d\n",i,y[i]);
    // }

}