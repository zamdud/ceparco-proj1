section .data
mask1 dd -1,-1,-1,-1,-1,-1,-1,0
mask2 dd 0,-1,-1,-1,-1,-1,-1,-1

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

    mov rax, rcx ; Flag for handling edge case
    shr rax, 2
    imul rax, -4
    add rax, rcx
    sub rcx, rax
    shr rcx, 2

    cmp rcx, 0
    jz SKIP1

L1:     vmovdqu ymm0, [rdx]
        vmovdqu ymm2, [rdx+8]
        
        vpand ymm1, ymm0, [mask2]
        vpand ymm0, ymm0, [mask1]
        vpand ymm3, ymm2, [mask2]
        vpand ymm2, ymm2, [mask1]

        vphaddd ymm0, ymm0, ymm0
        vphaddd ymm1, ymm1, ymm1
        vphaddd ymm2, ymm2, ymm2
        vphaddd ymm3, ymm3, ymm3
        
        vphaddd ymm0, ymm0, ymm0
        vphaddd ymm1, ymm1, ymm1
        vphaddd ymm2, ymm2, ymm2
        vphaddd ymm3, ymm3, ymm3
        
        vpermq ymm4, ymm0, 0b00001110
        vpermq ymm5, ymm1, 0b00001110
        vpermq ymm6, ymm2, 0b00001110
        vpermq ymm7, ymm3, 0b00001110
        
        vpaddd ymm0, ymm0, ymm4
        vpaddd ymm1, ymm1, ymm5
        vpaddd ymm2, ymm2, ymm6
        vpaddd ymm3, ymm3, ymm7
        
        vmovd [r8], xmm0
        vmovd [r8+4], xmm1
        vmovd [r8+8], xmm2
        vmovd [r8+12], xmm3

        add rdx, 4*4
        add r8, 4*4
        dec rcx
        jnz L1
SKIP1:    
    mov rcx, rax
    cmp rcx, 0
    jz SKIP2

L2: vmovdqu ymm0, [rdx]
    vpand ymm0, ymm0, [mask1]
    vphaddd ymm0, ymm0, ymm0
    vphaddd ymm0, ymm0, ymm0
    vpermq ymm4, ymm0, 0b00001110
    vpaddd ymm0, ymm0, ymm4
    vmovd [r8], xmm0
    add rdx, 4
    add r8, 4
    dec rcx
    jnz L2

SKIP2:
    ret
    