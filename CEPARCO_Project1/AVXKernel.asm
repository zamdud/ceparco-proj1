section .data
mask1 dd -1,-1,-1,0

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
    shr rcx, 2
    shl rcx, 2
    sub rax, rcx 
    
    cmp rcx, 0
    jz SKIP1

L1: 
    vmovdqu xmm0, [rdx+rsi*4-12]
    vmovdqu xmm1, [rdx+rsi*4-4]
    
    ; Simulate vperm2i128 with vshufps and vpermilps
    vshufps xmm2, xmm0, xmm0, 0b01001110 ; Rotate within the 128-bit lane
    vshufps xmm3, xmm1, xmm1, 0b01001110

    vpaddd xmm4, xmm2, xmm0
    vpaddd xmm5, xmm3, xmm1
    vphaddd xmm4, xmm4, xmm4
    vphaddd xmm5, xmm5, xmm5
    vphaddd xmm4, xmm4, xmm4
    vphaddd xmm5, xmm5, xmm5 

    vpsubd xmm0, xmm4, xmm0
    vpsubd xmm1, xmm5, xmm1
    vpsubd xmm2, xmm4, xmm2
    vpsubd xmm3, xmm5, xmm3
    
    vshufps xmm0, xmm2, xmm2, 0b11110000
    vpshufd xmm0, xmm0, 0b00110011
    vshufps xmm1, xmm3, xmm3, 0b11110000
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

L2: 
    vmovdqu xmm0, [rdx+rsi*4-12]
    vpand xmm0, xmm0, [mask1]
    vphaddd xmm0, xmm0, xmm0
    vphaddd xmm0, xmm0, xmm0
    
    vpermilps xmm4, xmm0, 0b00001110
    vpaddd xmm0, xmm0, xmm4

    vmovd [r8+rsi*4], xmm0
    inc rsi
    cmp rsi, rax
    jl L2

SKIP2:
    ret
