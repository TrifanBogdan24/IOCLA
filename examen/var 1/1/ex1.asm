%include "printf32.asm"
extern printf

section .bss
	answer resw 20

section .data
    products dw 0x10AD, 0x234D, 0x03AD, 0x7E00, 0x0AFE, 0x00A1, 0x1B32, 0x0, 0x1, 0xA, 0x00CB, 0xFF, 0x1123, 0xFFFF, 0x64, 0x3FBC, 0x128, 0x341, 0x2345, 0x1AFE
    products_len equ 20
    c_answer_len equ 5

section .text
global main

main:
    push ebp
    mov ebp, esp

    ; TODO a: Afisati restul impartirii la 23, pentru fiecare element.
	; Fiecare rest se va salva in vectorul answer (acesta este tot un vector de
	; words).
    ; ATENTIE la registrele folosite. Un singur octet poate NU fi de ajuns
    ; pentru catul impartirii.

    xor ecx, ecx
    xor eax, eax
    xor edx, edx

loop_a:
    xor ebx, ebx
    xor edx, edx
    mov ebx, 23
    cmp ecx , products_len
    jge end_loop_a

    xor eax, eax
    mov ax, word [products + ecx * 2]
    div ebx

    mov [answer + ecx * 2], edx

    inc ecx
    jmp loop_a


end_loop_a:


    ;; INSTRUCTIUNI AFISARE subpunct a). NU MODIFICATI!
a_print:
    xor ecx, ecx
a_print_loop:
	PRINTF32 `%hd \x0`, [answer + 2 * ecx]
	mov word [answer + 2 * ecx], 0
	inc ecx
	cmp ecx, products_len
	jb a_print_loop
	PRINTF32 `\n\x0`


    ; TODO b: Afisati produsul dintre numarul de elemente pare si cel al
    ;  elementelor impare. Rezultatul se va pune pe prima pozitie din vectorul
	; answer.

    xor ecx, ecx
    xor eax, eax
    xor edx, edx
    xor ebx, ebx
    xor esi, esi
    
loop_b:
    cmp ecx, products_len
    jge end_loop_b
    
    mov bx, 2
    mov ax, word[products + ecx*2]
    xor edx, edx

    div bx

    cmp dx, 1
    je nr_imp
    
    inc ecx
    jmp loop_b


nr_imp:
    inc esi
    inc ecx
    jmp loop_b


end_loop_b:
    xor ecx, ecx
    mov ecx, products_len
    sub ecx, esi
    
    imul ecx, esi
    mov [answer], ecx
    
    ;; INSTRUCTIUNI AFISARE subpunct b). NU MODIFICATI!
b_print:
	PRINTF32 `%hd\n\x0`, [answer]
	mov word [answer], 0


    ; TODO c: Daca elementul se afla pe o pozitie multiplu de 3 sau de 5,
    ; verificati daca cel mai semnificativ octet este par. Daca este par
    ; faceti-i flip (ii inversati toti bitii). Puneti rezultatul fiecarui flip
	; in vectorul answer.



    xor ecx, ecx
    xor eax, eax
    xor edx, edx
    xor ebx, ebx
    xor esi, esi

    ;; INSTRUCTIUNI AFISARE subpunct c). NU MODIFICATI!
c_print:
    cmp ecx, products_len
    jge end_loop_c1

    mov bx, 5
    mov eax, ecx

    div ebx

    cmp edx, 0
    je div


    xor edx, edx
    xor eax, eax
    xor ebx, ebx

    mov bx, 3
    mov eax, ecx

    div ebx

    cmp edx, 0
    je div
    inc ecx
    jmp c_print

div:
    mov ax, word[products + ecx]
    shr ax, 15
    xor ebx, ebx
    and bx, ax
    cmp bx, 0
    je inv

    inc ecx
    jmp c_print

inv:
    ;not ax
    mov [answer + 2 * esi], ax
    inc ecx
    inc esi
    jmp c_print


end_loop_c1:
    xor ecx, ecx

c_print_loop:
	PRINTF32 `%hx \x0`, [answer + 2 * ecx]
	inc ecx
	cmp ecx, c_answer_len
	jb c_print_loop
	PRINTF32 `\n\x0`


    ; Return 0.
    xor eax, eax
    leave
    ret
