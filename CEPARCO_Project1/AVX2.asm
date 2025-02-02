section .data
mask1 dd -1,-1,-1,-1,-1,-1,-1,0 

section .text
bits 64
default rel

global AVX2Kernel

AVX2Kernel:
    ;rcx = n
    ;rdx = address of X
    ;r8 = address of Y
    sub rcx, 6
    mov rsi, 3
    
    mov rax, rcx ; Flag for handling edge case
    shr rcx, 2
    shl rcx, 2
    sub rax, rcx 
    
    cmp rcx, 0
    jz SKIP1

L1: vmovdqu ymm0, [rdx+rsi*4-12]
    vmovdqu ymm1, [rdx+rsi*4-4] 
    vperm2i128 ymm2, ymm0, ymm0, 1
    vperm2i128 ymm3, ymm1, ymm1, 1
    vpaddd ymm4, ymm2, ymm0
    vpaddd ymm5, ymm3, ymm1
    vphaddd ymm4, ymm4, ymm4
    vphaddd ymm5, ymm5, ymm5
    vphaddd ymm4, ymm4, ymm4
    vphaddd ymm5, ymm5, ymm5 
    vpsubd ymm0, ymm4, ymm0
    vpsubd ymm1, ymm5, ymm1
    vpsubd ymm2, ymm4, ymm2
    vpsubd ymm3, ymm5, ymm3
    vshufps xmm0, xmm2, 0b11110000
    vpshufd xmm0, xmm0, 0b00110011
    vshufps xmm1, xmm3, 0b11110000
    vpshufd xmm1, xmm1, 0b00110011
    vmovq [r8+rsi*4], xmm0
    vmovq [r8+rsi*4+8], xmm1
    add rsi, 4
    cmp rsi, rcx
    jl L1
SKIP1:

    cmp rax, 0
    jz SKIP2
    add rcx, 3
    add rax, rcx

L2: vmovdqu ymm0, [rdx+rsi*4-12]
    vpand ymm0, ymm0, [mask1]
    vphaddd ymm0, ymm0, ymm0
    vphaddd ymm0, ymm0, ymm0
    vpermq ymm4, ymm0, 0b00001110
    vpaddd ymm0, ymm0, ymm4
    vmovd [r8+rsi*4], xmm0
    inc rsi
    cmp rsi, rax
    jl L2
    
SKIP2:

    ret