%include "utils/printf32.asm"


section .data
    arr1 db 0xaa, 0xbb, 0xcc, 0xdd, 0xee, 0xff, 0x99, 0x88
    len1 equ $-arr1
    arr2 db 0x12, 0x34, 0x56, 0x78, 0x90, 0xab, 0xcd, 0xef
    len2 equ $-arr2
    val1 dd 0xabcdef01
    val2 dd 0x62719012

section .bss
    nr_biti resb 4
    nr_biti_vector resb 4
    masca resb 8

section .text
global main
extern printf


main:

    push ebp
    mov ebp, esp


    ; TODO a: Print if sign bit is present or not.
    PRINTF32 `valoarea = %d. \x0`, [val1]
    mov ecx, 1      ; masca
    shl ecx, 31     ; masca
    PRINTF32 `masca = %d. \x0`, ecx
    and ecx, [val1]
    PRINTF32 `& si logic = %d. \x0`, ecx

    cmp ecx, 0
    je bit_neprezent_nr1
    PRINTF32 `Bitul are semn.\n\x0`
    jmp al_doilea_numar

bit_neprezent_nr1:
    PRINTF32 `Bitul nu are semn.\n\x0`
    jmp al_doilea_numar

al_doilea_numar:
    PRINTF32 `valoarea = %d. \x0`, [val2]
    mov ecx, 1      ; masca
    shl ecx, 31     ; masca
    PRINTF32 `masca = %d. \x0`, ecx
    and ecx, [val2]
    PRINTF32 `& si logic = %d. \x0`, ecx

    cmp ecx, 0
    je bit_neprezent_nr2
    PRINTF32 `Bitul are semn.\n\x0`
    jmp second_task

bit_neprezent_nr2:
    PRINTF32 `Bitul nu are semn.\n\x0`
    jmp second_task


second_task:
    ; TODO b: Print number of bits for integer value.


nr_biti_primul_numar:
    PRINTF32 `\n\n\x0`
    PRINTF32 `valoarea = %d.\n\x0`, [val1]

    mov eax, 0
    mov ebx, [val1]
    mov byte [nr_biti], 0
    mov ecx, 1 ; masca
 
loop_nr_biti_one:

    cmp eax, 32
    jl verifica_bit_pt_unu
    je end_loop_one
    jmp creste_contor_one

verifica_bit_pt_unu:

    PRINTF32 `valoarea = %d si masca = %d.\x0`, [val1], ecx
    mov ebx, [val1]
    and ebx, ecx
    PRINTF32 ` & si logic %d.\n\x0`, ebx
    cmp ebx, 0
    jne inca_un_bit_pt_unu
    jmp creste_contor_one

inca_un_bit_pt_unu:
    inc byte [nr_biti]
    jmp creste_contor_one

creste_contor_one:
    inc eax
    shl ecx, 1
    jmp loop_nr_biti_one

end_loop_one:
    PRINTF32 `Numarul de biti (%d) = %d.\n\x0`, [val1], [nr_biti]




nr_biti_al_doilea_numar:
    PRINTF32 `\n\n\x0`
    PRINTF32 `valoarea = %d.\n\x0`, [val2]

    mov eax, 0
    mov ebx, [val2]
    mov byte [nr_biti], 0
    mov ecx, 1 ; masca
 
loop_nr_biti_two:

    cmp eax, 32
    jl verifica_bit_pt_doi
    je end_loop_two
    jmp creste_contor_two

verifica_bit_pt_doi:

    PRINTF32 `valoarea = %d si masca = %d.\x0`, [val2], ecx
    mov ebx, [val2]
    and ebx, ecx
    PRINTF32 ` & si logic %d.\n\x0`, ebx
    cmp ebx, 0
    jne inca_un_bit_pt_doi
    jmp creste_contor_two

inca_un_bit_pt_doi:
    inc byte [nr_biti]
    jmp creste_contor_two

creste_contor_two:
    inc eax
    shl ecx, 1
    jmp loop_nr_biti_two

end_loop_two:
    PRINTF32 `Numarul de biti (%d) = %d.\n\x0`, [val2], [nr_biti]


    ; TODO c: Print number of bits for array.

    PRINTF32 `\n\nPrimul vector : \n\x0`
    mov esi, arr1   ; esi memoreaza vectorul
    mov ecx, len1   ; ecx reprezinta contorul / iteratorul (parcurge)
    mov byte [nr_biti_vector], 0

iter_first_vect:
    
    mov al, [esi]
    PRINTF32 `%u \x0`, eax
    mov byte [nr_biti], 0

count_bytes_one:
    cmp eax, 0
    jne verifica_bit_vect_unu
    je end_counting_one
    
verifica_bit_vect_unu:
    mov ebx, 1
    and ebx, eax

    cmp ebx, 0
    jne adauga_nr_biti_vect_unu
    jmp first_shift

adauga_nr_biti_vect_unu:
    inc byte [nr_biti]
    inc byte [nr_biti_vector]
    jmp first_shift

first_shift:
    shr eax, 1
    jmp count_bytes_one

end_counting_one:
    PRINTF32 `are %d biti\n\x0`, [nr_biti]
    inc esi
    loop iter_first_vect

end_loop_first_vector:
    PRINTF32 `\nNumarul de biti pentru primul vector este = %d\n\x0`, [nr_biti_vector]

pentru_al_doilea_vector:
    PRINTF32 `\n\n\Al doilea vector : \n\x0`
    mov esi, arr2   ; esi memoreaza vectorul
    mov ecx, len2   ; ecx reprezinta contorul / iteratorul (parcurge)
    mov byte [nr_biti_vector], 0

iter_second_vect:
    
    mov al, [esi]
    PRINTF32 `%u \x0`, eax
    mov byte [nr_biti], 0

count_bytes_two:
    cmp eax, 0
    jne verifica_bit_vect_doi
    je end_counting_two
    
verifica_bit_vect_doi:
    mov ebx, 1
    and ebx, eax

    cmp ebx, 0
    jne adauga_nr_biti_vect_doi
    jmp second_shift

adauga_nr_biti_vect_doi:
    inc byte [nr_biti]
    inc byte [nr_biti_vector]
    jmp second_shift

second_shift:
    shr eax, 1
    jmp count_bytes_two

end_counting_two:
    PRINTF32 `are %d biti\n\x0`, [nr_biti]
    inc esi
    loop iter_second_vect

end_loop_second_vector:
    PRINTF32 `\nNumarul de biti pentru al doilea vector este = %d\n\x0`, [nr_biti_vector]

    ; Return 0.
    xor eax, eax
    leave
    ret
