section .data
    prompt1 db "Enter the first number: "
    prompt1Len equ $-prompt1
    
    prompt2 db "Enter the second number: "
    prompt2Len equ $-prompt2
    
    resultPrompt db "The largest number is: "
    resultPromptLen equ $ - resultPrompt
    
section .bss
    number1 resb 4
    number2 resb 4
    
section .text
    global _start

_start:
    ; Prompt for the first number
    mov eax, 4
    mov ebx, 1
    mov ecx, prompt1
    mov edx, prompt1Len
    int 0x80
    
    ; Read the first number from user
    mov eax, 3
    mov ebx, 0
    mov ecx, number1
    mov edx, 4
    int 0x80
    
    ; Prompt for the second number
    mov eax, 4
    mov ebx, 1
    mov ecx, prompt2
    mov edx, prompt2Len
    int 0x80
    
    ; Read the second number from user
    mov eax, 3
    mov ebx, 0
    mov ecx, number2
    mov edx, 4
    int 0x80
    
    ; Convert the numbers from ASCII to integer
    mov eax, 0
    mov ecx, number1
    sub byte [ecx], '0'
    mov ecx, number2
    sub byte [ecx], '0'
    
    ; Compare the numbers
    mov eax, 0
    mov ecx, number1
    cmp ecx, [number2]
    jg first_bigger
    jmp second_bigger
    
first_bigger:
    ; afiseaza textul pentru rezultat
    mov eax, 4
    mov ebx, 1
    mov ecx, resultPrompt
    mov edx, resultPromptLen
    int 0x80

    ; afiseaza primul numar = max(nr1, nr2)
    mov eax, 4
    mov ebx, 1
    mov ecx, number1
    add byte [ecx], 48
    mov edx, 4
    int 0x80
    jmp exit_program
    
second_bigger:
    ; afiseaza textul pentru rezultat
    mov eax, 4
    mov ebx, 1
    mov ecx, resultPrompt
    mov edx, resultPromptLen
    int 0x80

    ; afiseaza al doilea numar = max(nr1, nr2)
    mov eax, 4
    mov ebx, 1
    mov ecx, number2
    add byte [ecx], 48
    mov edx, 4
    int 0x80

exit_program:
    ; Exit the program
    mov eax, 1
    xor ebx, ebx
    int 0x80

; cmds to run in terminal :
; nasm -f elf64 max.asm
; ld max.o -o max
; ./max
; rm -rf max max.o
