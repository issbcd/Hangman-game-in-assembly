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
    ; Boa prática: Salvar o estado dos registradores na pilha 
    push esi
    push edi
    push eax
    push ebx
    push ecx

    ; Configuração dos "ponteiros"
    mov esi, secretWord     ; esi aponta para a primeira letra da palavra secreta
    mov edi, maskedWord     ; edi aponta para a primeira posição da máscara
    mov bl, 0               ; bl servirá como "marcador". 0 = não achou a letra, 1 = achou.

.letterLoop:
    mov cl, [esi]               ; Pega a letra atual da palavra secreta e guarda em cl
    
    cmp cl, 0                   ; Checa se chegou no fim da string
    je .breakLetterLoop         ; Se sim, sai do loop.

    cmp cl, al                  ; Checa se a letra da palavra secreta (cl) é igual à letra digitada (al)
    jne .nextLetter             ; Se não for, avança para a próxima letra da palavra

                                ; Se chegou aqui, o usuário acertou uma letra!
    mov [edi], al               ; Escreve a letra digitada (al) por cima do '_' na máscara (edi)
    mov bl, 1                   ; Sinaliza no nosso marcador que houve um acerto

.nextLetter:
    inc esi                     ; avança o ponteiro da palavra secreta para a próxima letra
    inc edi                     ; Avança o ponteiro da máscara também
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
    ; Restaura os registradores na ordem inversa que foram salvos
    pop ecx
    pop ebx
    pop eax
    pop edi
    pop esi
    ret                        


checkWin:
    push esi
    push eax

    mov esi, maskedWord ; Aponta para o começo da máscara

.underlineSearchLoop:
    mov al, [esi]              ; Pega o caractere atual
    
    cmp al, 0                  ; Checa se chegou no fim da string
    je .declareVictory         ; Se chegou ao fim sem esbarrar em nenhum '_', o jogador venceu!
    
    cmp al, '_'                ; É um underline?
    je .stillMissingLetters    ; Se sim, interrompe a checagem, o jogo ainda não acabou.
    
    inc esi                    ; Avança para a próxima letra
    jmp .underlineSearchLoop

.declareVictory:
    mov byte [gameState], 1  ; Muda a variável global informando a vitória
    
.stillMissingLetters:
    pop eax
    pop esi
    ret


checkLoss:
    push eax

    mov al, [numLifes]         ; Lê a quantidade de vidas atual (numLifes)
    cmp al, 0                  ; Vidas == 0?
    jg .stillAlive             ; Vidas > 0, o jogo ainda não acabou.

    mov byte [gameState], 2  ; Se chegou aqui, vidas é 0. Decreta a derrotaaa

.stillAlive:
    pop eax
    ret
