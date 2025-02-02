
section .data
empty dd 0,0,0,0
mask1 dd -1,-1,-1,-1
mask2 dd -1,-1,-1,0
base dq 2
boundary dq 7

section .text
bits 64
default rel

global x86XMMSIMD

x86XMMSIMD:
	lea r13, [rdx]
    lea r14, [r8]

    xor r9,r9
    xor r10,r10
    xor r11,r11 
    mov r9, 0          
    mov r10, [base]     
    mov r11, [boundary] 

    cmp rcx, r11
    jl finbyboundary 

     start:
        cmp r9, r10	
        jle fix

        jmp startop
    fix:        
        mov dword[r14], 0 	
        inc r9
        add r13, 4
        add r14, 4
        jmp start



    startop:
        vmovdqu xmm0, [mask1]	              
        mov r11,-3
        vmaskmovps xmm1, xmm0, [r13+r11*4]
        vmovdqu xmm0, [mask2] 	             
        mov r11,1
        vmaskmovps xmm3, xmm0, [r13+r11*4]

        vphaddd xmm4,xmm1,xmm3          
        vphaddd xmm1,xmm4,[empty]       
        vphaddd xmm4,xmm1,[empty]       
        
        
        vbroadcastss xmm4,xmm4
        vextractps [r14],xmm4,0   
        
        mov r12, r9
        add r12, 3 
        
       
        cmp r12,[boundary]
        jge finbyoperation
        inc r9                         
        add r13, 4
        add r14, 4
        jmp startop
    
    finbyboundary:
        vbroadcastss xmm4,[empty]
        vextractps [r14],xmm4,0 

    finbyoperation:
        inc r9                         
        add r13, 4
        add r14, 4
        mov dword[r14], 0
        add r14, 4
        mov dword[r14], 0
        add r14, 4
        mov dword[r14], 0
        add r14, 4

ret