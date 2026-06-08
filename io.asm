section .data
    ; 10 = quebra de linha e 0 = fim da string
    msg_victory db 10, "===================================", 10, "Boa champs! Salvou o boneco", 10, "===================================", 10, 0
    msg_defeat db 10, "===================================", 10, "Vixe man. Matou o boneco :/", 10, "===================================", 10, 0
    msg_prompt db 10, "Digite uma letra e aperte enter: ", 0
    msg_newline db 10, 0

section .bss
    buffer_teclado resb 2  ; reserva 2 bytes (pra letra e pro enter)

section .text
    ; ADICIONADO: Avisa o compilador que essa variável vem de outro arquivo
    extern maskedWord

    ; torna as funcoes globais pra o assembler junte tudo dboa
    global getInput
    global printWord
    global victoryScreen
    global defeatScreen

; pede uma letra ao usuarioo e guarda em AL
getInput:
    ; preserva os registradores
    push rbx
    push rcx
    push rdx
    push rsi 
    push rdi 

    ;p exibir o prompt 
    mov rax, 1               ; syscall 1 = sys_write
    mov rdi, 1               ; 1 = stdout
    mov rsi, msg_prompt      ; endereço da msg 
    mov rdx, 34              ; tamanho da string (proximo)
    syscall 

    ; lê a letra que a pessoa digitou no teclado
    mov rax, 0              ; syscall 0 = sys_read
    mov rdi, 0              ; 0 = stdin (teclado)
    mov rsi, buffer_teclado ; onde vai salvar temporariamente na memória
    mov rdx, 2              ; lê 2 bytes (a letra e o caractere do 'Enter')
    syscall

    mov al, [buffer_teclado]

    ;p restaurar os registradores
    pop rdi
    pop rsi
    pop rdx
    pop rcx
    pop rbx
    ret         ; retorna pro gameloop

; funcao de printar a palavra escondida (os underlines)
printWord:
    push rax
    push rbx
    push rcx
    push rdx
    push rsi
    push rdi

    mov rsi, maskedWord  ; aponta pro inicio da palavra escondida/mascarada (pessoa 4)

.loop_print:
    mov al, [rsi]           ; lê o caractere atual da memória
    cmp al, 0               ; checou se é o Null Terminator (fim da string)?
    je .fim_print           ; se for 0, sai do loop

    ;o sys_write precisa de um ponteiro de memo p imprimir
    mov rax, 1              ; syscall 1 = sys_write
    mov rdi, 1              ; 1 = stdout (tela)
    mov rdx, 1              ; imprime apenas 1 caractere por vez
    syscall

    inc rsi                 ; avança para a próxima posição
    jmp .loop_print         ; repete 

.fim_print:
    ; faz o print da quebra de linha sem estragar o pop rsi q vem dps
    mov rax, 1
    mov rdi, 1
    mov rsi, msg_newline
    mov rdx, 1
    syscall

    pop rdi
    pop rsi         
    pop rdx
    pop rcx
    pop rbx
    pop rax
    ret

victoryScreen:
    mov rax, 1
    mov rdi, 1
    mov rsi, msg_victory
    mov rdx, 113           ; tamanho aproximado da mensagem
    syscall

    ; finaliza o programa (sys_exit = 60)
    mov rax, 60             
    mov rdi, 0              
    syscall

defeatScreen:
    mov rax, 1
    mov rdi, 1
    mov rsi, msg_defeat
    mov rdx, 113            ; tamanho aproximado da mensagem
    syscall

    ; finaliza o programa com código de erro (sys_exit = 60)
    mov rax, 60             
    mov rdi, 1              
    syscall