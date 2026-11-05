## To compile:

```
nasm -f elf64 shebang.asm -o shebang.o && ld -s -n shebang.o -o shebang
nasm -f elf64 shebang-line.asm -o shebang-line.o && ld -s -n shebang-line.o -o shebang-line
```
