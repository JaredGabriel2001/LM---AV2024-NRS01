; nasm -f elf64 -g -F dwarf GabrielJaredPedroPisseti.asm ; gcc -m64 -no-pie -g GabrielJaredPedroPisseti.o -o GabrielJaredPedroPisseti.x


section .data
    temperatura : db "Vetor de temperaturas (°C): ", 0   
    umidade     : db "Vetor de umidade relativa (%): ", 0 
    scanTemp    : db "%f, %f, %f, %f, %f", 0
    scanUmi     : db "%f, %f, %f, %f, %f", 0
    printMedTemp: db "Média das Temperaturas: %.2f °C", 10, 0
    printMedUmi : db "Média da Umidade: %.2f%", 10, 0
    divisor     : dd 5.0
    resDiv      : dd 1.8 ; resultado da divisão de 9/5
    somaConvert : dd 32.0 ; valor que soma 32 da formula: F=C*(9/5)+32.
    printConver : db "%.1f °C -> %.1f °F", 10, 0
    printMsgConversoes : db "Conversoes:", 10, 0
    printAnomalia : db "Anomalias: Temperatura %.1f °C fora do intervalo esperado!"
    
section .bss
    vetTemp         resd 5               
    vetUmi          resd 5              
    resMedTemp      resd 1
    resMedUmi       resd 1 
    vetFahrenheit   resd 5
    vetAnomalias    resd 5
    devio_padrao    rest 1
section .text
    global main
    extern scanf, printf

main:
    push rbp
    mov rbp, rsp

    xor rax, rax
    mov rdi, temperatura 
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
    call printf

    ;lendo temperaturas
    xor rax, rax
    mov rdi, scanUmi
    lea rsi, [vetUmi] 
    lea rdx, [vetUmi+4]
    lea rcx, [vetUmi+8] 
    lea r8,  [vetUmi+12]
    lea r9,  [vetUmi+16]
    call scanf

media_temp:
    xorps xmm0, xmm0

    addss xmm0, [vetTemp]
    addss xmm0, [vetTemp+4]
    addss xmm0, [vetTemp+8]
    addss xmm0, [vetTemp+12]
    addss xmm0, [vetTemp+16]
    divss xmm0, dword [divisor]
    movss [resMedTemp], xmm0

    cvtss2sd xmm0, xmm0

    mov rax, 1
    mov rdi, printMedTemp 
    call printf
media_Umi:

    xorps xmm1, xmm1
    addss xmm1, [vetUmi]
    addss xmm1, [vetUmi+4]
    addss xmm1, [vetUmi+8]
    addss xmm1, [vetUmi+12]
    addss xmm1, [vetUmi+16]
    divss xmm1, dword [divisor]
    movss [resMedUmi], xmm1

    cvtss2sd xmm1, xmm1
    movsd xmm0, xmm1

    mov rax, 1
    mov rdi, printMedUmi 
    call printf
desvio_padrao:

    movss xmm0, [vetTemp]
    movss xmm1, [resMedTemp]
    subss xmm0, xmm1
    mulss xmm0, xmm0
    addps xmm11, xmm0 ; valor de (xi - X)^2 da primeira posicao do vetor

    movss xmm0, [vetTemp+4]
    movss xmm1, [resMedTemp]
    subss xmm0, xmm1
    mulss xmm0, xmm0
    addps xmm11, xmm0 ; valor de (xi - X)^2 da segunda posicao do vetor

    movss xmm0, [vetTemp+8]
    movss xmm1, [resMedTemp]
    subss xmm0, xmm1
    mulss xmm0, xmm0
    addps xmm11, xmm0 ; valor de (xi - X)^2 da terceira posicao do vetor

    movss xmm0, [vetTemp+12]
    movss xmm1, [resMedTemp]
    subss xmm0, xmm1
    mulss xmm0, xmm0
    addps xmm11, xmm0 ; valor de (xi - X)^2 da quarta posicao do vetor

    movss xmm0, [vetTemp+16]
    movss xmm1, [resMedTemp]
    subss xmm0, xmm1
    mulss xmm0, xmm0
    addps xmm11, xmm0 ; valor de (xi - X)^2 da quinta posicao do vetor

    divss xmm11, dword [divisor] ; resultado do somatorio de ((xi - X)^2)/n
    sqrtss xmm11, xmm11    ; resultado da raiz quadrada, ou seja, o desvio padrao está em xmm11
anomalias:
    
    
converter:

    mov rax, rax
    mov rdi, printMsgConversoes
    call printf

    ;F=C*(9/5)+32.
    movss xmm0, [vetTemp]
    mulss xmm0, [resDiv]      ; resultado de 9/5
    addss xmm0, [somaConvert] ; 32
    movss dword [vetFahrenheit], xmm0

    movss xmm0, [vetTemp]
    movss xmm1, [vetFahrenheit]
    cvtss2sd xmm0, xmm0
    cvtss2sd xmm1, xmm1
    mov rax, 2
    mov rdi, printConver 
    call printf

    movss xmm0, [vetTemp+4]
    mulss xmm0, [resDiv]
    addss xmm0, [somaConvert]
    movss [vetFahrenheit+4], xmm0

    movss xmm0, [vetTemp+4]
    movss xmm1, [vetFahrenheit+4]
    cvtss2sd xmm0, xmm0
    cvtss2sd xmm1, xmm1
    mov rax, 2
    mov rdi, printConver 
    call printf

    movss xmm0, [vetTemp+8]
    mulss xmm0, [resDiv]
    addss xmm0, [somaConvert]
    movss [vetFahrenheit+8], xmm0

    movss xmm0, [vetTemp+8]
    movss xmm1, [vetFahrenheit+8]
    cvtss2sd xmm0, xmm0
    cvtss2sd xmm1, xmm1
    mov rax, 2
    mov rdi, printConver 
    call printf

    movss xmm0, [vetTemp+12]
    mulss xmm0, [resDiv]
    addss xmm0, [somaConvert]
    movss [vetFahrenheit+12], xmm0

    movss xmm0, [vetTemp+12]
    movss xmm1, [vetFahrenheit+12]
    cvtss2sd xmm0, xmm0
    cvtss2sd xmm1, xmm1
    mov rax, 2
    mov rdi, printConver 
    call printf

    movss xmm0, [vetTemp+16]
    mulss xmm0, [resDiv]
    addss xmm0, [somaConvert]
    movss [vetFahrenheit+16], xmm0

    movss xmm0, [vetTemp+16]
    movss xmm1, [vetFahrenheit+16]
    cvtss2sd xmm0, xmm0
    cvtss2sd xmm1, xmm1
    mov rax, 2
    mov rdi, printConver 
    call printf
    
fim:
    mov rsp, rbp
    pop rbp

    ret