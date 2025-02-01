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
        vpand ymm0, ymm0, [mask] 
        vphaddd ymm0, ymm0, ymm0
        vphaddd ymm0, ymm0, ymm0
        vextracti128 xmm1, ymm0, 1
        vpaddd xmm0, xmm0, xmm1
        vmovd [r8], xmm0
        add rdx, 4
        add r8, 4
        loop L1
    
    ret
    