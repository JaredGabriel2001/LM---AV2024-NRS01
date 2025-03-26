; nasm -f elf64 GabrielJaredPedroPisseti.asm ; gcc -m64 -no-pie GabrielJaredPedroPisseti.o -o GabrielJaredPedroPisseti.x
; nasm -f elf64 GabrielJaredPedroPisseti.asm -o GabrielJaredPedroPisseti.o ; ld GabrielJaredPedroPisseti.o -o GabrielJaredPedroPisseti.x
section .data
    prompt1 db "Vetor de temperaturas (°C): ", 0   ; Mensagem para o primeiro vetor
    prompt2 db "Vetor de umidade relativa (%): ", 0 ; Mensagem para o segundo vetor

section .bss
    input resb 100              ; Buffer para entrada do usuário
    vetor1 resq 5               ; Espaço para 5 números em ponto flutuante
    vetor2 resq 5               ; Espaço para 5 números em ponto flutuante

section .text
    global _start

_start:
    ; Limpa o buffer antes de usar
    mov rdi, input              ; Aponta para o buffer
    mov rcx, 100                ; Tamanho do buffer
    xor rax, rax                ; RAX = 0
rep stosb                        ; Preenche com zeros

    ; Exibe a mensagem para o primeiro vetor
    mov rax, 1                  ; Código do syscall para write
    mov rdi, 1                  ; Saída padrão (stdout)
    mov rsi, prompt1            ; Mensagem para o primeiro vetor
    mov rdx, 28                 ; Tamanho da mensagem
    syscall

    ; Lê a entrada do usuário para o primeiro vetor
    mov rax, 0                  ; Código do syscall para read
    mov rdi, 0                  ; Entrada padrão (stdin)
    mov rsi, input              ; Buffer de entrada
    mov rdx, 100                ; Tamanho máximo da entrada
    syscall

    ; Limpa o buffer antes da próxima entrada
    mov rdi, input              ; Aponta para o buffer
    mov rcx, 100                ; Tamanho do buffer
    xor rax, rax                ; RAX = 0
rep stosb                        ; Preenche com zeros

    ; Exibe a mensagem para o segundo vetor
    mov rax, 1                  ; Código do syscall para write
    mov rdi, 1                  ; Saída padrão (stdout)
    mov rsi, prompt2            ; Mensagem para o segundo vetor
    mov rdx, 35                 ; Tamanho da mensagem
    syscall

    ; Lê a entrada do usuário para o segundo vetor
    mov rax, 0                  ; Código do syscall para read
    mov rdi, 0                  ; Entrada padrão (stdin)
    mov rsi, input              ; Buffer de entrada
    mov rdx, 100                ; Tamanho máximo da entrada
    syscall

    ; Fim do programa
    mov rax, 60                 ; Código do syscall para exit
    xor rdi, rdi                ; Código de saída 0
    syscall
