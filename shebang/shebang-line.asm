%define RD "204;36;29"
%define RL "251;73;52"
%define GD "152;151;26"
%define GL "184;187;38"
%define YD "215;153;33"
%define YL "250;189;47"
%define BD "69;133;136"
%define BL "131;165;152"
%define PD "177;98;134"
%define PL "211;134;155"
%define AD "104;157;106"
%define AL "142;192;124"

%macro seg 4
    db `\e[38;2;`, %1, `m`, %3, `\e[38;2;`, %2, `m`, %4, `    `
%endmacro

%macro line 2
    seg RD, RL, %1, %2
    seg GD, GL, %1, %2
    seg YD, YL, %1, %2
    seg BD, BL, %1, %2
    seg PD, PL, %1, %2
    seg AD, AL, %1, %2
    db `\e[0m\n`
%endmacro

section .data
msg:
    db 10
    line "  ██  ██  ", "  ██"
    line "██████████", "  ██"
    line "  ██  ██  ", "  ██"
    line "██████████", "    "
    line "  ██  ██  ", "  ██"
    db 10
len equ $ - msg

section .text
global _start
_start:
    mov     eax, 1
    mov     edi, 1
    lea     rsi, [rel msg]
    mov     edx, len
    syscall
    mov     eax, 60
    xor     edi, edi
    syscall
