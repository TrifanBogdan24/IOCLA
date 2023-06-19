%include "./utils/printf32.asm"
extern printf

section .data

int_arr dd 11, 20, 39, 57, 99, 100, 88, 19, 29, 42
len equ 10
limit dd 3000

section .bss
	; TODO a: Reserve space for an array of `len` integers. The array name is `res_arr`
	res_arr resw 10 	; len = 10 (linia 7)
	nr_mai_mari resb 1
	maximul resb 1

section .text
global main

main:
	push ebp
	mov ebp, esp
	mov byte [nr_mai_mari], -1

	; TODO a: Fill in the first `len` elements of `res_array` using the folloing formula:
	; res_arr[i] = 65 * int_arr[i] + 7
	; Print res_arr with all elements on the same line separated by a space

	xor ecx, ecx
	xor eax, eax
	xor edx, edx

iteratie:
	cmp ecx, len
	jge stop_iteratie

	mov ax, word [int_arr + ecx * 4]
	PRINTF32 `65 * %d + 7 = \x0`, eax

	mov ebx, 65
	imul eax, ebx
	add eax, 7
	mov [res_arr + ecx * 4], eax

	PRINTF32 `%d\n\x0`, eax
	
	inc ecx
	jmp iteratie

stop_iteratie:
	mov byte [nr_mai_mari], -1

	; TODO b: Find the number of all the elements of `res_arr` that are strictly greater than `limit`



	xor ecx, ecx
	mov ebx, limit 	; nu exista un astfel de numar
	mov byte [nr_mai_mari], 0
	inc ebx
	xor eax, eax
	xor edx, edx

iteratie_doi:
	cmp ecx, len
	jge end_iteratie_doi

	mov ax, [res_arr + ecx * 4]
	; PRINTF32 `\n%d %d\x0`, eax, [limit]

	cmp eax, [limit]
	jg mai_mari
	jmp continue_iteratie_doi

mai_mari:
	PRINTF32 `\n%d %d\x0`, eax, [limit]
	inc byte [nr_mai_mari]
	inc edx
	jmp continue_iteratie_doi

continue_iteratie_doi:
	inc ecx
	jmp iteratie_doi

end_iteratie_doi:

	PRINTF32 `\n\n\Numarul de elemente mai mari = %d\n\x0`, edx
	; TODO c: Find the largest number from `res_arr` that is strictly smaller than `limit`



	mov byte [maximul], -1


	xor ecx, ecx
	xor eax, eax
	xor edx, edx
	mov edx, -1

iteratie_trei:
	xor ebx, ebx
	
	cmp ecx, len
	jge end_iteratie_trei
	
	mov ax, [res_arr + ecx * 4]
	; PRINTF32 `%d < %d\n\x0`, eax, [limit]

	cmp eax, [limit]
	jl mai_mic_limita
	jmp continue_iteratie_trei

mai_mic_limita:
	PRINTF32 `%d < %d\n\x0`, eax, [limit]
	cmp eax, edx
	jge update_maxim
	jmp continue_iteratie_trei

update_maxim:
	mov edx, eax
	jmp continue_iteratie_trei

continue_iteratie_trei:
	inc ecx
	jmp iteratie_trei

end_iteratie_trei:
	PRINTF32 `\n\Elementul maxim = %d\n\x0`, edx

	; Return 0.
	xor eax, eax
	leave
	ret
