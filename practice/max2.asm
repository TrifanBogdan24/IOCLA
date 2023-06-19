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

    ; convertim primul numar din ASCII in intreg
    mov eax, 0
    mov ecx, nr1
    sub byte [ecx], '0'





    ; afisarea celui de al doilea mesaj
    mov eax, 4
    mov ebx, 1
    mov ecx, afis2
    mov edx, afis2_len
    int 0x80

    ; citirea celui de al doilea numar
    mov eax, 3
    mov ebx, 0
    mov ecx, nr2
    int 0x80


    ; convertim al doilea numar din ASCII in intreg
    mov eax, 0
    mov ecx, nr2
    sub byte [ecx], '0'


    ; comparare numere
    mov eax, 0
    mov ecx, nr1
    
    cmp ecx, [nr2]
    jg primul
    jmp al_doilea 


primul:
    ; afiseaza textul pentru rezultat
    mov eax, 4
    mov ebx, 1
    mov ecx, rezultat
    mov edx, rezultat_len
    int 0x80

    ; afiseaza primul numar
    mov eax, 4
    mov ebx, 1
    mov ecx, nr1
    add byte [ecx], 48
    mov edx, 4
    int 0x80
    jmp exit_program


al_doilea:
    ; afiseaza textul pentru rezultat
    mov eax, 4
    mov ebx, 1
    mov ecx, rezultat
    mov edx, rezultat_len
    int 0x80

    ; afiseaza al doilea numar
    mov eax, 4
    mov ebx, 1
    mov ecx, nr2
    add byte [ecx], 48
    mov edx, 4
    int 0x80

exit_program:
    mov eax, 1
    xor ebx, ebx
    int 0x80

; cmds to write in terminal :
;
; nasm -f elf64 max2.asm
; ld max2.o -o max2
; ./max2
; rm -rf *.o max2
;
; one-liner :
; nasm -f elf64 max2.asm ; ld max2.o -o max2 ; ./max2
