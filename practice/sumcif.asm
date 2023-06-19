section .data
    afis1       db  "Nunarul = "
    afis1_len   equ $-afis1

    rezultat        db  "Suma cifrelor = "
    rezultat_len    equ $-rezultat

section .bss
    nr1 resb 4

section .text
    global _start

_start:
    mov eax, 0
    mov ebx, 0

    ; afisarea primului mesaj
    mov eax, 4
    mov ebx, 1
    mov ecx, afis1
    mov edx, efis1_len
    int 0x80

    ; citirea primului numar
    mov eax, 4
    mov ebx, 1
    mov ecx, afis1
    mov edx, afis1_len
    int 0x80

exist_program:
    mov eax, 1
    xor ebx, ebx
    int 0x80

;
; one-liner :
; nasm -f elf64 sumcif.asm ; ld sumcif.o -o sumcif ; ./sumcif
