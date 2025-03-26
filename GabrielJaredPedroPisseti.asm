; nasm -f elf64 GabrielJaredPedroPisseti.asm ; gcc -m64 -no-pie GabrielJaredPedroPisseti.o -o GabrielJaredPedroPisseti.x

section .data
    temperatura : db "Vetor de temperaturas (°C): ", 0   
    umidade     : db "Vetor de umidade relativa (%):  ", 0 
    scanTemp    : db "%f, %f, %f, %f, %f", 0
    scanUmi     : db "%f, %f, %f, %f, %f", 0
    printMedTemp: db "%.1f", 10, 0
    printMedUmi : db "%.1f", 10, 0
    ; printConver : 
section .bss

    vetTemp resd 5               
    vetUmi  resd 5              

section .text
    global main
    extern scanf, printf

main:
    push rbp
    mov rbp, rsp

    xor rax, rax
    mov rdi, temperatura 
    mov esi, 1
    call printf

    ;lendo temperaturas
    xor rax, rax
    mov rdi, scanTemp
    lea rsi, [vetTemp] 
    lea rdx, [vetTemp+4]
    lea rcx, [vetTemp+8] 
    lea r8, [vetTemp+12]
    lea r9, [vetTemp+16]
    call scanf

    xor rax, rax
    mov rdi, umidade 
    mov esi, 1
    call printf

    ;lendo temperaturas
    xor rax, rax
    mov rdi, scanTemp
    lea rsi, [vetUmi] 
    lea rdx, [vetUmi+4]
    lea rcx, [vetUmi+8] 
    lea r8,  [vetUmi+12]
    lea r9,  [vetUmi+16]
    call scanf

media:

converter:

fim:
