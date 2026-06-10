Universidade Federal de Alagoas (UFAL)

Instituto de Computação (IC)

Disciplina: Organização e Arquitetura de Computadores

Professor: Lucas Amorim
    
## Jogo da Forca em Assembly ASCII

Este projeto consiste no desenvolvimento do clássico Jogo da Forca, implementado inteiramente em linguagem de baixo nível (Assembly). O jogo roda diretamente no terminal, utilizando a seção de dados para desenhar a interface e o boneco em arte ASCII.

 Estrutura do Repositório

Dividimos o repositório em módulos com funções bem delineadas, de forma que a compreensão seja facilitada a partir da categorização. Não foram utilizadas bibliotecas com o objetivo de potencializar o aprendizado do grupo. Por fim, destacamos o quão intrisecamente ligados estão os diferentes módulos; de forma que uns dependem dos outros e funcionam, unicamente, em conjunto. A divisão existe somente a título de legibilidade e boas práticas, permitindo mudanças e adaptações práticas, estudo simplificado, dentre outros benefícios considerados pela equipe.

Requisitos e Ferramentas

    Arquitetura Alvo: x86_64
    Montador: Nasm
    Sistema Operacional: Linux (no Windows, necessário usar wsl 1 ou 2)
    

## Como Compilar e Executar (usando Makefile)

Certifique-se de ter as ferramentas de compilação instaladas em sua máquina. Para testar o jogo, abra o terminal na pasta raiz do projeto e execute:

# 1. Compilar os arquivos (usando o Makefile)
```Bash
make
```

# 2. Executar o jogo
```bash
./forca
```

## Como compilar e executar o jogo (Manualmente)

# 1. Gerar os arquivos objeto (.o)
Primeiro, compile cada arquivo fonte separadamente informando a arquitetura de 64 bits (elf64):

``` Bash
nasm -f elf64 Forca.asm -o Forca.o
nasm -f elf64 banco_palavras.asm -o banco_palavras.o
nasm -f elf64 draw_hangman.asm -o draw_hangman.o
nasm -f elf64 io.asm -o io.o
```


# 2. Linkar os arquivos (Gerar o executável)
Em seguida, utilize o linker para unir todos os objetos em um único arquivo executável chamado jogo_forca:
```Bash

ld Forca.o banco_palavras.o draw_hangman.o io.o -o jogo_forca
```

# 3. Executar o jogo
Por fim, inicie o executável:
```Bash

./jogo_forca
```

Como Jogar

    Ao executar o programa, o jogo escolhe automaticamente uma palavra secreta do banco de dados na seção .data.

    A tela inicial mostrará a forca vazia e os espaços sublinhados (_) equivalentes ao número de letras da palavra.

    Digite uma letra e aperte Enter.

    Acerto: A letra preenche as lacunas correspondentes na palavra.

    Erro: Uma nova parte do boneco é desenhada em ASCII e você perde uma vida.

    O jogo se encerra ao descobrir a palavra inteira (Vitória) ou após completar o boneco com 6 erros (Derrota).

    Projeto desenvolvido para fins acadêmicos - 2026.1.
