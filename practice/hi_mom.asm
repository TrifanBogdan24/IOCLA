section .data
    hi_mom db "Hi, mom!", 10    ; string to print
    hi_mom_Len equ $-hi_mom       ; length of string

section .text
    global _start

_start:
    ; write system call
    mov eax, 4        ; sys_write
    mov ebx, 1        ; stdout
    mov ecx, hi_mom    ; message to write
    mov edx, hi_mom_Len ; message length
    int 0x80          ; call kernel

    ; exit system call
    mov eax, 1        ; sys_exit
    xor ebx, ebx      ; exit code 0 (success)
    int 0x80          ; call kernel

; cmds to write in terminal :
; nasm -f elf64 hi_mom.asm
; ld hi_mom.o -o hi_mom
; ./hi_mom
; rm -f hi_mom hi_mom.o