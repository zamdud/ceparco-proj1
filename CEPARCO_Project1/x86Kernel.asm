section .text
bits 64
default rel 

global x86Kernel
x86Kernel:   
    ;rcx = n
    ;rdx = address of X
    ;r8 = address of Y
    ;r9 = current index
    ;r11 = running sum
    
    xor r9, r9                      ;init i
    xor r11, r11                    ;int running sum
    add r9, 3                      ;start at index 3         
    add r8, 3*4    

    L1: add r9, 4                  ;[i+3]+1 -> last term in formula
        cmp r9, rcx                ;if [i+3]+1 > n
        jg end                      ;end if true
        sub r9d, 4

        add r11d, [rdx+r9*4-12]     ;x[i-3]
        add r11d, [rdx+r9*4-8]      ;x[i-2]
        add r11d, [rdx+r9*4-4]      ;x[i-1]
        add r11d, [rdx+r9*4]        ;x[i]
        add r11d, [rdx+r9*4+4]      ;x[i+1]
        add r11d, [rdx+r9*4+8]      ;x[i+2]
        add r11d, [rdx+r9*4+12]     ;x[i+3]
        
        inc r9                     ;increment index
        mov [r8], r11d             ;store sum to y   
        add r8, 4
        xor r11D, r11d              ;set running sum to 0
        jmp L1                      ;jump back to loop 
    end:   
        ret