extern scanf
extern printf


section .data
    uint_format    db "%zu", 0
    uint_format_newline    db "%zu", 10, 0
    pos1_str    db "Introduceti prima pozitie: ", 0
    pos2_str   db "Introduceti a doua pozitie: ", 0
    sum_str db "Suma este: %zu", 10, 0
    sum_interval_str db "Suma de la pozitia %zu la pozitia %zu este %zu", 10, 0
    arr     dd 100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400

section .bss
    suma resb 4
    poz1 resb 4
    poz2 resb 4

section .text
global main

sum:
    push ebp
    mov ebp, esp

    ; TODO b: Implement sum() to compute sum for array.

    mov eax, arr


iteratie_for:
    

    cmp eax, 0
    je end_for
    
    mov dx, [eax]

    cmp eax, poz1
    jl continue_for
    
    cmp eax, poz2
    jg  continue_for

    add suma, dx

continue_for:
    inc eax
    
end_for:

    mov ebx, suma
    leave
    ret

sum_interval:
    push ebp
    mov ebp, esp

    ; TODO b: Implement sum_interval() to compute sum for array between two positions.
    push eax
    push ebx
    push arr
    call sum

    leave
    ret


main:
    push ebp
    mov ebp, esp


    push dword 14
    push arr
    call sum
    add esp, 8

    push eax
    push sum_str
    call printf
    add esp, 8


    ; TODO b: Call sum_interval() and print result.
    push poz1
    push poz2
    push arr
    call sum

    push suma
    push sum_str
    call printf

    ; TODO c: Use scanf() to read positions from standard input.
    push poz1
    push pos1_str
    call scanf

    push poz2
    push pos2_str
    call scanf


    ; Return 0.
    xor eax, eax
    leave
    ret
