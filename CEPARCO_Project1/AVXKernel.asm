section .data
mask1 dd -1,-1,-1,-1,-1,-1,-1,0 

section .text
bits 64
default rel

global AVXKernel

AVXKernel:
    ;rcx = n
    ;rdx = address of X
    ;r8 = address of Y
    sub rcx, 6
    mov rsi, 3
    
    mov rax, rcx ; Flag for handling edge case
    shr rcx, 1
    shl rcx, 1
    
    sub rax, rcx 
    
    cmp rcx, 0
    jz SKIP1

L1: vmovdqu xmm0, [rdx+rsi*4-12]
    vmovdqu xmm1, [rdx+rsi*4+4]

    vmovdqu xmm2, [rdx+rsi*4-4] 
    vmovdqu xmm3, [rdx+rsi*4+12] 

    vpaddd xmm4, xmm0, xmm1
    vpaddd xmm5, xmm2, xmm3

    vphaddd xmm4, xmm4, xmm4
    vphaddd xmm5, xmm5, xmm5
    vphaddd xmm4, xmm4, xmm4
    vphaddd xmm5, xmm5, xmm5 

    vpsubd xmm0, xmm4, xmm0
    vpsubd xmm1, xmm4, xmm1    ;ymm0 and ymm1

    vpsubd xmm2, xmm5, xmm2
    vpsubd xmm3, xmm5, xmm3    ;ymm2 and ymm3

    vshufps xmm0, xmm1, 0b11110000
    vpshufd xmm0, xmm0, 0b00110011
    vshufps xmm2, xmm3, 0b11110000
    vpshufd xmm2, xmm2, 0b00110011
    vmovq [r8+rsi*4], xmm0
    vmovq [r8+rsi*4+8], xmm2
    add rsi, 2
    cmp rsi, rcx
    jl L1
SKIP1:

    cmp rax, 0
    jz SKIP2
    add rcx, 3
    add rax, rcx

L2: vmovdqu xmm0, [rdx+rsi*4-12]
    vmovdqu xmm1, [rdx+rsi*4+4]

    vpaddd xmm4, xmm0, xmm1
    vphaddd xmm4, xmm4, xmm4
    vphaddd xmm4, xmm4, xmm4
    vpsubd xmm1, xmm4, xmm1
    vpshufd xmm1, xmm1, 0b00110011
    vmovd [r8+rsi*4], xmm1
    inc rsi
    cmp rsi, rax
    jl L2
    
SKIP2:

    ret