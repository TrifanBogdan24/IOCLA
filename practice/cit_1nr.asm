section .data
    afis1     db "Primul numar = "
    ; afis2     db "Al doilea numar = "
    ; rezultat  db "Cel mai mare numar = "

    afis1_len    equ $-afis1
    ;afis2_len    equ $-afis2
    ;rezultat_len equ $-rezultat

    ; ordine db-equ / db-equ / db-equ
    ; nu db-db-db / equ-equ-equ

section .bss
    nr1 resb 4
    nr2 resb 4

section .text
    global _start

_start:
    ; afisarea primului mesaj
    mov eax, 4
    mov ebx, 1
    mov ecx, afis1
    mov edx, afis1_len
    int 0x80

    ; citirea primului numar
    mov eax, 3 
    mov ebx, 0
    mov ecx, nr1
    int 0x80

exit_program:
    mov eax, 1
    xor ebx, ebx
    int 0x80

; cmds to write in terminal :
; nasm -f elf64 cit_1nr.asm
; ld cit_1nr.o -o cit_1nr
; ./cit_1nr
; rm -rf *.o cit_1.nr
