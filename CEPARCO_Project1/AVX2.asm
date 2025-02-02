section .data
mask dd -1,-1,-1,-1,-1,-1,-1,0

section .text
bits 64
default rel

global AVX2Kernel

AVX2Kernel:
    ;rcx = n
    ;rdx = address of X
    ;r8 = address of Y
    sub rcx, 6
    add r8, 3*4

L1:     vmovdqu ymm0, [rdx]
        vmovdqu ymm1, [rdx+4]
        vpand ymm0, ymm0, [mask]
        vpand ymm1, ymm1, [mask]
        vphaddd ymm0, ymm0, ymm0
        vphaddd ymm1, ymm1, ymm1
        vphaddd ymm0, ymm0, ymm0
        vphaddd ymm1, ymm1, ymm1
        vpermq ymm2, ymm0, 0b00001110
        vpermq ymm3, ymm1, 0b00001110
        vpaddd ymm0, ymm0, ymm2
        vpaddd ymm1, ymm1, ymm3
        vmovd [r8], xmm0
        vmovd [r8+4], xmm1

        add rdx, 2*4
        add r8, 2*4
        sub rcx, 2
        jnz L1
    
    ret
    