section .text
    global _start

extern printf
extern scanf

_start:
    push ebp

exist_program:
    mov eax, 1
    xor ebx, ebx
    int 0x80

;
; one-liner :
; nasm -f elf64 stiva.asm ; ld stiva.o -o stiva ; ./stiva