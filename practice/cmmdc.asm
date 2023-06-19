section .data
    afisaj1 db "Scrieti primul numar = "
    afisaj1_len equ $-afisaj1

    afisaj2 db "Scrieti al doilea numar = "
    afisaj2_len equ $-afisaj2

    rezultat db "Cel mai mare numar = "
    rezultat_len equ $-rezultat

section .bss
    nr1 resb 4
    nr2 resb 4
    aux1 resb 4
    aux2 resb 4
    rez resb 4

section .text
    global _start

extern printf
extern scanf

_start:
    ; textul pentru primul numar
    mov eax, 4
    mov ebx, 1
    mov ecx, afisaj1
    mov edx, afisaj1_len
    int 0x80

    ; citirea primului numar
    mov eax, 3
    mov ebx, 0
    mov ecx, nr1
    mov edx, 4
    int 0x80

    ; convertim primul numar de la ASCII la intreg
    mov eax, 0
    mov ecx, nr1
    sub byte [ecx], '0'

    ; textul pentru al doilea numar
    mov eax, 4
    mov ebx, 1
    mov ecx, afisaj2
    mov edx, afisaj2_len
    int 0x80

    ; citirea celui de al doilea numar
    mov eax, 3
    mov ebx, 0
    mov ecx, nr2
    mov edx, 4
    int 0x80

    ; convertim al doilea numar de la ASCII la intreg
    mov eax, 0
    mov ecx, nr2
    sub byte [ecx], '0'


    ; afisam textul pentru rezultat
    mov eax, 4
    mov ebx, 1
    mov ecx, rezultat
    mov edx, rezultat_len
    int 0x80

    ; retinem numerele in doua registre consacrate : eax si ebx
    mov eax, dword [nr1]
    mov ebx, dword [nr2]

loop:
    ; scaderi succesive
    cmp eax, ebx                    ; if (nr1 ? nr2)
    jg diferenta_nr1_minus_nr2      ; =     cmmdc(nr1, nr2) = nr1
    jl diferenta_nr2_minus_nr1      ; >     nr1 = nr1 - nr2
    je exit_program                 ; <     nr2 = nr2 - nr1

diferenta_nr1_minus_nr2:
    neg ebx
    add eax, ebx
    neg ebx
    jmp loop

diferenta_nr2_minus_nr1:
    neg eax
    add ebx, eax
    neg eax
    jmp loop

exit_program:

    ; afisam cel mai mare divizor comun
    ; cmddc (nr1, nr2) = nr1_final = nr2_final = eax = ebx

    push  eax
    xor ebp, ebp
    popa 

    push rezultat
    call printf
    add esp, 8


    ; iesim din program
    mov eax, 1
    xor ebx, ebx
    int 0x80

; cmds to write in terminal
;
; nasm -f elf32 cmmdc.asm -o cmmdc.o
; ld -m elf_i386 cmmdc.o -o cmmdc
; ./cmmdc
; rm -rf *.o cmmdc
;
; one-liner
; nasm -f elf64 cmmdc.asm ; ld cmmdc.o -o cmmdc ; ./cmmdc
