section .data
    ; exporta variaveis globais p outras func
    global secretWord
    global maskedWord
    global sortear_palavra

    ; palavras do banco de dados
    palavra1 db "computadores", 0
    palavra2 db "processador", 0
    palavra3 db "lucas", 0
    palavra4 db "arquitetura", 0
    palavra5 db "professor", 0

    ;  array
    banco_palavras dq palavra1, palavra2, palavra3, palavra4, palavra5
    qtd_palavras equ 5

section .bss
    ; reserva espaco na memoria p as variaveis da pessoa 2
    secretWord resb 32
    maskedWord resb 32
    randomByte resb 1

section .text


sortear_palavra:
    ; salva todos os registradores usados para nao quebrar main
    push rax
    push rbx
    push rcx
    push rdx
    push rsi
    push rdi
    push r8
    push r11

    ; random generator
    mov rax, 318            ; syscall getrandom
    lea rdi, [rel randomByte]
    mov rsi, 1              ; le 1 byte aleatorio
    xor rdx, rdx            ; flags = 0
    syscall

    cmp rax, 1              ; ve se leu 1 byte
    jne .fallback_rdtsc

    movzx rax, byte [rel randomByte]
    jmp .numero_pronto

.fallback_rdtsc:
    rdtsc                   ; le o clock
    shl rdx, 32
    or rax, rdx

.numero_pronto:
    
    xor rdx, rdx            ; zera rdx (obrigado antes de div)
    mov rcx, qtd_palavras   ; rcx = 5
    div rcx                 ; Divide rax por 5. O resto vai para RDX (0 a 4).

    ; --- PREPARANDO PONTEIROS ---
    lea rbx, [rel banco_palavras]
    mov rsi, [rbx + rdx*8]    ; rsi aponta para a palavra sorteada

    lea rdi, [rel secretWord] ; rdi aponta para secretWord
    lea r8, [rel maskedWord]  ; r8 aponta para maskedWord

.loop_copia:
    mov al, byte [rsi]      ; le a letra da palavra sorteada
    cmp al, 0               ; ve chegou no null terminator
    je .fim_copia           ; se sim, acaba o loop

    ; se nao copia a letra real e o underline
    mov byte [rdi], al      ; secretWord recebe a letra 
    mov byte [r8], '_'      ; maskedWord recebe o underline '_'

    ; avanca todos os ponteiros
    inc rsi
    inc rdi
    inc r8
    jmp .loop_copia

.fim_copia:
    ; coloca o terminador 0 no final das strings
    mov byte [rdi], 0
    mov byte [r8], 0

    ; restaura os registradores na ordem inversa
    pop r11
    pop r8
    pop rdiz
    pop rsi
    pop rdx
    pop rcx
    pop rbx
    pop rax
    
    ret
