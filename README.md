Universidade Federal de Alagoas (UFAL)

Instituto de Computação (IC)

Disciplina: Organização e Arquitetura de Computadores

Professor: Lucas Amorim
    
## 🕹️ Jogo da Forca em Assembly ASCII

Este projeto consiste no desenvolvimento do clássico Jogo da Forca, implementado inteiramente em linguagem de baixo nível (Assembly). O jogo roda diretamente no terminal, utilizando a seção de dados para desenhar a interface e o boneco em arte ASCII.

📂 Estrutura do Repositório

O projeto adota uma arquitetura modular na main branch. A lógica, os dados e a interface estão separados fisicamente para facilitar a compilação paralela:
Plaintext

forca-assembly/
├── src/                    # Código-fonte principal (.asm)

│   ├── main.asm            # Arquivo de orquestração do jogo

│   ├── io.asm              # Sub-rotinas de teclado e terminal

│   ├── logic.asm           # Regras de acerto/erro e vidas

│   └── ui.asm              # Motor de renderização ASCII

├── inc/                    # Arquivos de cabeçalho e dados (.inc)

│   ├── constants.inc       # Macros do sistema (syscalls)

│   └── data.inc            # Banco de palavras e sprites ASCII

├── Makefile                # Script de automação

└── README.md               # Documentação principal

⚙️ Requisitos e Ferramentas

    Arquitetura Alvo: x86_64

    Sistema Operacional: Linux

🚀 Como Compilar e Executar

Certifique-se de ter as ferramentas de compilação instaladas em sua máquina. Para testar o jogo, abra o terminal na pasta raiz do projeto e execute:
Bash

# 1. Clonar o repositório
git clone https://github.com/usuario/forca-assembly.git
cd forca-assembly

# 2. Compilar os arquivos (usando o Makefile)
make

# 3. Executar o jogo
./forca

🎮 Como Jogar

    Ao executar o programa, o jogo escolhe automaticamente uma palavra secreta do banco de dados na seção .data.

    A tela inicial mostrará a forca vazia e os espaços sublinhados (_) equivalentes ao número de letras da palavra.

    Digite uma letra e aperte Enter.

    Acerto: A letra preenche as lacunas correspondentes na palavra.

    Erro: Uma nova parte do boneco é desenhada em ASCII e você perde uma vida.

    O jogo se encerra ao descobrir a palavra inteira (Vitória) ou após completar o boneco com 6 erros (Derrota).

    Projeto desenvolvido para fins acadêmicos - UFAL IC 2026.1.
