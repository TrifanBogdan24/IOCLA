section .data
    afis1        db "Primul numar = "
    afis1_len    equ $-afis1

    afis2        db "Al doilea numar = "
    afis2_len    equ $-afis2

    rezultat     db "Cel mai mare numar = "
    rezultat_len equ $-rezultat

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

    ; afisarea celui de al doilea mesaj
    mov eax, 4
    mov ebx, 1
    mov ecx, afis2
    mov edx, afis2_len
    int 0x80

    ; citirea celui de al doilea numar
    mov eax, 3
    mov ebx, 0
    mov ecx, nr1
    int 0x80

exit_program:
    mov eax, 1
    xor ebx, ebx
    int 0x80

; cmds to write in terminal :
;
; nasm -f elf64 cit_2nr.asm
; ld cit_2nr.o -o cit_1nr
; ./cit_2nr
; rm -rf *.o cit_2.nr
;
; one-liner :
; nasm -f elf64 cit_2nr.asm ; ld cit_2nr.o -o cit_1nr ; ./cit_2nr
