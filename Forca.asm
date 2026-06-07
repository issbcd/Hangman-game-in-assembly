section .data
    ; Variáveis de controle 
    numLifes db 6       ; 6 vidas: Cabeça, Torso, Braços e Pernas.
    gameState db 0      ; Rodando = 0, Vitória = 1, Derrota = 2

section .text
global _start

_start:
    ; (Aqui ficaria a configuração inicial feita pela Pessoa 4)

gameLoop:
    ; Funções para desenhar o jogo e obter input do usuário
    call drawHangman        
    call printWord   
    call getInput     

    ; Funções para processar o input e atualizar o estado do jogo
    call checkLetter    ; Atualiza a palavra e as lifes
    call checkWin       ; Muda o gameState para 1 se ganhou
    call checkLoss      ; Muda o gameState para 2 se perdeu

    ; Verifica se o jogo deve continuar
    mov al, [gameState]     ; lê o valor da memória que tem o estado do jogo 
    cmp al, 0               ; "gameState == 0?"
    je gameLoop             ; Se sim, o loop continua 

    ; Se chegou aqui, o gameState != 0, o jogo terminou
    cmp al, 1           ; "gameState == 1 (Vitoria)?"
    je victoryScreen    ; Se sim, vai para a tela de vitória
    jmp defeatScreen    ; Se não, vai para a tela de derrota


checkLetter:
    ; Em 64 bits, os pushes e pops DEVEM usar registradores de 64 bits (prefixo 'r')
    push rsi
    push rdi
    push rax
    push rbx
    push rcx

    ; Configuração dos "ponteiros" (agora usando rsi e rdi, de 64 bits)
    mov rsi, secretWord     ; rsi aponta para a primeira letra da palavra secreta
    mov rdi, maskedWord     ; rdi aponta para a primeira posição da máscara
    mov bl, 0               ; bl servirá como "marcador". 0 = não achou a letra, 1 = achou.

.letterLoop:
    mov cl, [rsi]               ; Pega a letra atual usando o ponteiro de 64 bits
    
    cmp cl, 0                   ; Checa se chegou no fim da string
    je .breakLetterLoop         ; Se sim, sai do loop.

    cmp cl, al                  ; Checa se a letra da palavra secreta (cl) é igual à letra digitada (al)
    jne .nextLetter             ; Se não for, avança para a próxima letra da palavra

                                ; Se chegou aqui, o usuário acertou uma letra!
    mov [rdi], al               ; Escreve a letra digitada (al) por cima do '_' na máscara (rdi)
    mov bl, 1                   ; Sinaliza no nosso marcador que houve um acerto

.nextLetter:
    inc rsi                     ; avança o ponteiro de 64 bits para a próxima letra
    inc rdi                     ; Avança o ponteiro de 64 bits da máscara também
    jmp .letterLoop             ; Retorna o loop para analisar a próxima letra

.breakLetterLoop:
                                ; Verifica o marcador para saber se houve acerto ou erro
    cmp bl, 0                   ; "bl == 0?", errou no chute
    jne .endFunction            ; "bl != 0?", acertou o chute, retorna para o loop principal.

                                ; Se chegou aqui, perdeu uma vida
    mov bl, [numLifes]          ; Pega a quantidade atual de vidas
    dec bl                      ; Subtrai 1
    mov [numLifes], bl          ; Salva de volta na memória

.endFunction:
    ; Restaura os registradores na ordem inversa que foram salvos (usando 64 bits)
    pop rcx
    pop rbx
    pop rax
    pop rdi
    pop rsi
    ret                        


checkWin:
    push rsi
    push rax

    mov rsi, maskedWord ; Aponta para o começo da máscara usando rsi

.underlineSearchLoop:
    mov al, [rsi]              ; Pega o caractere atual
    
    cmp al, 0                  ; Checa se chegou no fim da string
    je .declareVictory         ; Se chegou ao fim sem esbarrar em nenhum '_', o jogador venceu!
    
    cmp al, '_'                ; É um underline?
    je .stillMissingLetters    ; Se sim, interrompe a checagem, o jogo ainda não acabou.
    
    inc rsi                    ; Avança para a próxima letra
    jmp .underlineSearchLoop

.declareVictory:
    mov byte [gameState], 1  ; Muda a variável global informando a vitória
    
.stillMissingLetters:
    pop rax
    pop rsi
    ret


checkLoss:
    push rax

    mov al, [numLifes]         ; Lê a quantidade de vidas atual (numLifes)
    cmp al, 0                  ; Vidas == 0?
    jg .stillAlive             ; Vidas > 0, o jogo ainda não acabou.

    mov byte [gameState], 2  ; Se chegou aqui, vidas é 0. Decreta a derrota.

.stillAlive:
    pop rax
    ret