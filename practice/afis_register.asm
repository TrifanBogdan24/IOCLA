section .data
    text    db      "291 is the best!", 10, 0
    strformat db    "%s", 0

section .text
    global _start
extern _printf

_start:
    push    dword text
    push    dword strformat
    call    printf
    add     esp, 8

    mov eax, 1
    xor ebx, ebx
    int 0x80

; cmds to write in terminal :
;
; nasm -f elf64 afis_register.asm
; ld afis_register.o -o afis_register
; ./afis_register
; rm -rf *.o afis_register
;
; one-liner :
; nasm -f elf64 afis_register.asm ; ld afis_register.o -o afis_register ; ./afis_register