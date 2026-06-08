section .data
    ; 1. Exportando variáveis para que main.asm e io.asm possam enxergar
    global secretWord
    global maskedWord
    global sortear_palavra

    ; 2. Banco de palavras (todas terminadas em 0 obrigatoriamente)
    ; Deixei todas em maiúsculo para padronizar com a entrada do usuário
    palavra1 db "computadores", 0
    palavra2 db "processador", 0
    palavra3 db "lucas", 0
    palavra4 db "arquitetura", 0
    palavra5 db "professor", 0

    ; Array de ponteiros de 64 bits (dq = define quadword)
    banco_palavras dq palavra1, palavra2, palavra3, palavra4, palavra5
    qtd_palavras equ 5

section .bss
    ; 3. Reservando espaço na memória para as variáveis que a Pessoa 2 exige
    secretWord resb 32
    maskedWord resb 32
    randomByte resb 1

section .text

;-------------------------------------------------------------------------
; Função: sortear_palavra
;-------------------------------------------------------------------------
sortear_palavra:
    ; Salva TODOS os registradores usados para não quebrar main.asm
    push rax
    push rbx
    push rcx
    push rdx
    push rsi
    push rdi
    push r8
    push r11

    ; --- GERADOR ALEATÓRIO (Relógio do Sistema) ---
    mov rax, 318            ; syscall getrandom
    lea rdi, [rel randomByte]
    mov rsi, 1              ; le 1 byte aleatorio
    xor rdx, rdx            ; flags = 0
    syscall

    cmp rax, 1              ; conseguiu ler 1 byte?
    jne .fallback_rdtsc

    movzx rax, byte [rel randomByte]
    jmp .numero_pronto

.fallback_rdtsc:
    rdtsc                   ; le o clock
    shl rdx, 32
    or rax, rdx

.numero_pronto:
    
    xor rdx, rdx            ; Zera RDX (OBRIGATÓRIO ANTES DO DIV)
    mov rcx, qtd_palavras   ; rcx = 5
    div rcx                 ; Divide RAX por 5. O RESTO vai para RDX (0 a 4).

    ; --- PREPARANDO PONTEIROS ---
    lea rbx, [rel banco_palavras]
    mov rsi, [rbx + rdx*8]    ; RSI aponta para a palavra sorteada

    lea rdi, [rel secretWord] ; RDI aponta para secretWord
    lea r8, [rel maskedWord]  ; R8 aponta para maskedWord

.loop_copia:
    mov al, byte [rsi]      ; Lê a letra da palavra sorteada
    cmp al, 0               ; Chegou no Null Terminator?
    je .fim_copia           ; Se sim, acaba o loop

    ; Se não, copia a letra real e o underline
    mov byte [rdi], al      ; secretWord recebe a letra (ex: 'C')
    mov byte [r8], '_'      ; maskedWord recebe o underline '_'

    ; Avança todos os ponteiros
    inc rsi
    inc rdi
    inc r8
    jmp .loop_copia

.fim_copia:
    ; REGRA RIGOROSA: Colocar o terminador 0 no final das duas strings
    mov byte [rdi], 0
    mov byte [r8], 0

    ; Restaura os registradores na ordem inversa (LIFO)
    pop r11
    pop r8
    pop rdi
    pop rsi
    pop rdx
    pop rcx
    pop rbx
    pop rax
    
    ret
