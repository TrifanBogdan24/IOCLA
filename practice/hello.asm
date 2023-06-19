section .data
    msg db "Hello, world!", 0

section .text
    global _start

_start:
    mov eax, 4      ; system call for write
    mov ebx, 1      ; file descriptor (stdout)
    mov ecx, msg    ; message to write
    mov edx, 13     ; length of message
    int 0x80        ; syscall

    mov eax, 1      ; system call for exit
    xor ebx, ebx    ; exista status (0)
    int 0x80        ; invoke syscall
;
; cmds to write in terminal
; nasm -f elf64 hello.asm
; ld hello.o -o hello
; ./hello
; rm -rf hello hello.o
; 
; one-liner
; nasm -f elf64 hello.asm ; ld hello.o -o hello; ./hello
