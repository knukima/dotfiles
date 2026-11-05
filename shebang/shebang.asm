bits 64
default rel

section .rodata
msg:
    db `\e[38;2;204;36;29m  ██   ██     ██\e[0m\n`     ; Red
    db `\e[38;2;214;93;14m███████████   ██\e[0m\n`     ; Orange
    db `\e[38;2;215;153;33m  ██   ██     ██\e[0m\n`    ; Yellow
    db `\e[38;2;152;151;26m███████████       \e[0m\n`  ; Green
    db `\e[38;2;104;157;106m  ██   ██     ██\e[0m\n`   ; Aqua
    db `\n`
msg_len equ $ - msg

section .text
global _start
_start:
    mov     eax, 1              ; SYS_write
    mov     edi, eax            ; fd = 1 (stdout)
    lea     rsi, [msg]
    mov     edx, msg_len
    syscall

    mov     eax, 60             ; SYS_exit
    xor     edi, edi
    syscall
