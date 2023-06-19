%include "utils/printf32.asm"

section .data
    num dd 13456198
    num1 dd 3453235129  ; 00 10 5
    num2 dd 13456198    ; 01 8  0
    num3 dd 55555123    ; 11 8  3

section .bss
    poz resb 8
    paritate resb 8
    nr_biti resb 8
    cons_biti resb 8
    nr_perechi resb 8

section .text
global main
extern printf

main:
    push ebp
    mov ebp, esp

    ;TODO a: print least significant 2 bits of the second most significant byte of num

    PRINTF32 `Numarul = %d are 2 lsb of 2 msb = \x0`, [num]


primul_bit:
    mov ebx, [num]
    mov eax, 1
    shl eax, 17
    and ebx, eax

    cmp ebx, 0
    je bit_poz_17_egal_0
    PRINTF32 `1\x0`
    jmp al_doilea_bit

bit_poz_17_egal_0:
    PRINTF32 `0\x0`
    jmp al_doilea_bit

al_doilea_bit:
    mov ebx, [num]
    mov eax, 1
    shl eax, 16
    and ebx, eax

    cmp ebx, 0
    je bit_poz_16_egal_0
    PRINTF32 `1\x0`
    jmp subpunct_b

bit_poz_16_egal_0:
    PRINTF32 `0\x0`
    jmp subpunct_b

subpunct_b:
    PRINTF32 `\n\x0`
    ;TODO b: print number of bits set on odd positions

    mov eax, 1
    shl eax, 31
    mov byte [poz], 32
    mov byte [paritate], 1
    mov byte [nr_biti], 0
    PRINTF32 `base_2( %d ) = \x0`, [num]



trasnf_base_2:
    cmp byte [poz], 0
    je subpunct_c

    mov ebx, [num]
    and ebx, eax

    cmp ebx, 0
    je bit_nul
    jne bit_nenul

bit_nul:
    PRINTF32 `0\x0`
    jmp update_paritate

bit_nenul:
    PRINTF32 `1\x0`
    cmp byte [paritate], 0
    je creste_nr_biti_poz_pare
    jmp update_paritate

creste_nr_biti_poz_pare:
    inc byte [nr_biti]
    jmp update_paritate

update_paritate:
    cmp byte [paritate], 0
    je  devine_impar
    jne devine_par

devine_impar:
    mov byte [paritate], 1
    jmp cont_base_2

devine_par:
    mov byte [paritate], 0
    jmp cont_base_2

cont_base_2:
    dec byte [poz]
    shr eax, 1
    jmp trasnf_base_2

subpunct_c:
    PRINTF32 `\n\Numarul de biti setati pe pozitii pare = %d\n\x0`, [nr_biti]

    ;TODO c: print number of groups of 3 consecutive bits set

    mov eax, 1
    shl eax, 31

    mov byte [nr_biti], 0
    mov byte [cons_biti], 0
    mov byte [nr_perechi], 0

transformare_baza_2:
    cmp eax, 0
    je end_transform_2

    mov ebx, [num]
    and ebx, eax
    cmp ebx, 0
    jne increase_consecutivi

    ; bitul are valoarea 0
    PRINTF32 `0\x0`
    mov byte [cons_biti], 0
    jmp continue_shifting    

increase_consecutivi:
    ; bitul are valoarea 1
    PRINTF32 `1\x0`
    inc byte [cons_biti]
    cmp byte [cons_biti], 3
    je pereche
    jmp continue_shifting

pereche:
    ; avem o pereche
    inc byte [nr_perechi]
    mov byte [cons_biti], 2

continue_shifting:
    shr eax, 1
    jmp transformare_baza_2

end_transform_2:
    PRINTF32 `\n\Numarul de perechi de 3 biti consecutivi 1 din %d = %d\n\x0`, [num], [nr_perechi] 

    xor eax, eax
    leave
    ret
