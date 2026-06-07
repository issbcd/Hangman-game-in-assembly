section .data
    ; ==========================================================
    ; secao de dados: aqui ficam os textos e artes do jogo
    ; o numero 10 representa uma quebra de linha no terminal
    ; o numero 0 avisa para o computador que a string acabou
    ; ==========================================================
    
    ; sprite para 6 vidas (jogador ainda nao errou nada)
    sprite_6 db 10, "  +---+  ", 10, "  |   |  ", 10, "      |  ", 10, "      |  ", 10, "      |  ", 10, "=========", 10, 0
    
    ; sprite para 5 vidas (primeiro erro, desenha a cabeca)
    sprite_5 db 10, "  +---+  ", 10, "  |   |  ", 10, "  O   |  ", 10, "      |  ", 10, "      |  ", 10, "=========", 10, 0
    
    ; sprite para 4 vidas (segundo erro, desenha o tronco)
    sprite_4 db 10, "  +---+  ", 10, "  |   |  ", 10, "  O   |  ", 10, "  |   |  ", 10, "      |  ", 10, "=========", 10, 0
    
    ; sprite para 3 vidas (terceiro erro, desenha um braco)
    sprite_3 db 10, "  +---+  ", 10, "  |   |  ", 10, "  O   |  ", 10, " /|   |  ", 10, "      |  ", 10, "=========", 10, 0
    
    ; sprite para 2 vidas (quarto erro, desenha os dois bracos)
    sprite_2 db 10, "  +---+  ", 10, "  |   |  ", 10, "  O   |  ", 10, " /|\  |  ", 10, "      |  ", 10, "=========", 10, 0
    
    ; sprite para 1 vida (quinto erro, desenha uma perna)
    sprite_1 db 10, "  +---+  ", 10, "  |   |  ", 10, "  O   |  ", 10, " /|\  |  ", 10, " /    |  ", 10, "=========", 10, 0
    
    ; sprite para 0 vidas (sexto erro, desenha o corpo inteiro morto)
    sprite_0 db 10, "  +---+  ", 10, "  |   |  ", 10, "  O   |  ", 10, " /|\  |  ", 10, " / \  |  ", 10, "=========", 10, 0

section .text
    ; avisa ao compilador que essa funcao pode ser chamada por outros arquivos
    global draw_hangman

; ==========================================================
; funcao principal: draw_hangman
; rdi recebe a quantidade de vidas que restam no jogo (6 a 0)
; ==========================================================
draw_hangman:
    ; salva o endereco base da pilha atual na memoria
    push rbp
    ; copia o topo da pilha para o registrador base
    mov rbp, rsp
    ; guarda o valor antigo de rsi na pilha para nao perder
    push rsi

    ; compara o registrador rdi (numero de vidas) com o numero 6
    cmp rdi, 6
    ; se for igual a 6, pula a execucao para o bloco vidas_6
    je .vidas_6
    
    ; compara rdi com o numero 5
    cmp rdi, 5
    ; se for igual a 5, pula para o bloco vidas_5
    je .vidas_5
    
    ; compara rdi com o numero 4
    cmp rdi, 4
    ; se for igual a 4, pula para o bloco vidas_4
    je .vidas_4
    
    ; compara rdi com o numero 3
    cmp rdi, 3
    ; se for igual a 3, pula para o bloco vidas_3
    je .vidas_3
    
    ; compara rdi com o numero 2
    cmp rdi, 2
    ; se for igual a 2, pula para o bloco vidas_2
    je .vidas_2
    
    ; compara rdi com o numero 1
    cmp rdi, 1
    ; se for igual a 1, pula para o bloco vidas_1
    je .vidas_1
    
    ; compara rdi com o numero 0
    cmp rdi, 0
    ; se for igual a 0, pula para o bloco vidas_0
    je .vidas_0
    
    ; prevencao de erros: se nao for nenhum dos numeros acima, vai pro fim
    jmp .fim_draw

.vidas_6:
    ; carrega o endereco da string sprite_6 no registrador rsi
    mov rsi, sprite_6
    ; chama a funcao auxiliar para imprimir no terminal
    call print_ascii
    ; pula para o fim da funcao para nao executar os de baixo
    jmp .fim_draw

.vidas_5:
    ; carrega o endereco da string sprite_5 no registrador rsi
    mov rsi, sprite_5
    ; chama a funcao auxiliar para imprimir no terminal
    call print_ascii
    ; pula direto para o fim da funcao
    jmp .fim_draw

.vidas_4:
    ; carrega o endereco da string sprite_4 no registrador rsi
    mov rsi, sprite_4
    ; chama a rotina de impressao
    call print_ascii
    ; encerra e vai pro final
    jmp .fim_draw

.vidas_3:
    ; carrega o endereco da string sprite_3 no registrador rsi
    mov rsi, sprite_3
    ; chama a funcao de imprimir
    call print_ascii
    ; salta para a finalizacao
    jmp .fim_draw

.vidas_2:
    ; carrega o endereco da string sprite_2 no registrador rsi
    mov rsi, sprite_2
    ; aciona a impressao na tela
    call print_ascii
    ; vai para o bloco de saida
    jmp .fim_draw

.vidas_1:
    ; carrega o endereco da string sprite_1 no registrador rsi
    mov rsi, sprite_1
    ; imprime o boneco com uma perna
    call print_ascii
    ; finaliza
    jmp .fim_draw

.vidas_0:
    ; carrega o endereco da string sprite_0 no registrador rsi
    mov rsi, sprite_0
    ; imprime o boneco morto
    call print_ascii
    ; aqui nao precisa de jmp porque o proximo bloco ja e o fim

.fim_draw:
    ; restaura o valor original de rsi que estava salvo na pilha
    pop rsi
    ; restaura o endereco base da pilha
    pop rbp
    ; retorna o controle para o arquivo principal (main)
    ret

; ==========================================================
; funcao auxiliar: print_ascii
; rsi ja tem o endereco do sprite que queremos imprimir
; ==========================================================
print_ascii:
    ; guarda o estado de rax na pilha
    push rax
    ; guarda rdi na pilha
    push rdi
    ; guarda rdx na pilha
    push rdx
    ; guarda rcx na pilha
    push rcx

    ; coloca o valor 0 no rdx. ele vai ser nosso contador de tamanho
    mov rdx, 0

.len_loop:
    ; olha para a memoria somando o endereco inicial com nosso contador
    ; compara esse byte exato com o numero 0 (que e o fim da string)
    cmp byte [rsi + rdx], 0
    ; se o byte for 0, o texto acabou e pulamos para a hora de imprimir
    je .print_now
    ; se nao for 0, aumentamos nosso contador em 1
    inc rdx
    ; voltamos pro comeco do laco para testar o proximo byte
    jmp .len_loop

.print_now:
    ; chegamos aqui com o tamanho exato do texto dentro do rdx
    ; coloca 1 em rax para avisar o sistema operacional que queremos escrever
    mov rax, 1
    ; coloca 1 em rdi para dizer que queremos escrever no terminal (stdout)
    mov rdi, 1
    ; pede para o sistema operacional rodar o comando com essas instrucoes
    syscall

    ; tira rcx da pilha para recuperar seu valor
    pop rcx
    ; tira rdx da pilha
    pop rdx
    ; tira rdi da pilha
    pop rdi
    ; tira rax da pilha
    pop rax
    ; encerra esta funcao e volta para o draw_hangman
    ret