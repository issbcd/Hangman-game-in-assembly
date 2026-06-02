<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>README - Jogo da Forca em Assembly</title>
    <style>
        body {
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Helvetica, Arial, sans-serif, "Apple Color Emoji", "Segoe UI Emoji", "Segoe UI Symbol";
            line-height: 1.6;
            color: #24292e;
            background-color: #ffffff;
            max-width: 900px;
            margin: 0 auto;
            padding: 40px 20px;
        }
        h1, h2, h3 {
            margin-top: 24px;
            margin-bottom: 16px;
            font-weight: 600;
            line-height: 1.25;
        }
        h1, h2 {
            padding-bottom: 0.3em;
            border-bottom: 1px solid #eaecef;
        }
        .header-academic {
            background-color: #f6f8fa;
            border: 1px solid #d1d5da;
            border-radius: 6px;
            padding: 20px;
            margin-bottom: 30px;
            text-align: center;
        }
        .header-academic h2 {
            border-bottom: none;
            margin-top: 0;
            margin-bottom: 5px;
            color: #0366d6;
        }
        .header-academic h3 {
            margin-top: 0;
            margin-bottom: 15px;
            color: #586069;
            font-weight: 400;
        }
        .header-academic p {
            margin: 5px 0;
            font-size: 16px;
        }
        ul {
            padding-left: 2em;
        }
        li {
            margin-bottom: 0.25em;
        }
        code {
            padding: 0.2em 0.4em;
            margin: 0;
            font-size: 85%;
            background-color: rgba(27,31,35,0.05);
            border-radius: 3px;
            font-family: "SFMono-Regular", Consolas, "Liberation Mono", Menlo, Courier, monospace;
        }
        pre {
            padding: 16px;
            overflow: auto;
            font-size: 85%;
            line-height: 1.45;
            background-color: #f6f8fa;
            border-radius: 3px;
        }
        pre code {
            background-color: transparent;
            padding: 0;
        }
        .badge {
            display: inline-block;
            padding: 0.25em 0.5em;
            font-size: 12px;
            font-weight: 600;
            line-height: 1;
            text-align: center;
            white-space: nowrap;
            vertical-align: baseline;
            border-radius: 0.25rem;
            color: #fff;
            background-color: #28a745;
        }
    </style>
</head>
<body>

    <div class="header-academic">
        <h2>Universidade Federal de Alagoas (UFAL)</h2>
        <h3>Instituto de Computação (IC)</h3>
        <p><strong>Disciplina:</strong> Organização e Arquitetura de Computadores</p>
        <p><strong>Professor:</strong> Lucas Amorim</p>
        <p><strong>Ano:</strong> 2026</p>
        <br>
        <span class="badge">Projeto Final</span>
    </div>

    <h1>🕹️ Jogo da Forca em Assembly ASCII</h1>

    <p>Este projeto consiste no desenvolvimento de um clássico Jogo da Forca, implementado inteiramente em linguagem Assembly de baixo nível. O jogo é executado diretamente no terminal e utiliza arte ASCII para a interface do usuário e renderização do boneco.</p>

    <h2>👥 Equipe de Desenvolvimento</h2>
    <p>O projeto foi planejado e modularizado para ser desenvolvido por 4 membros, dividindo responsabilidades entre Entrada/Saída, Lógica de Jogo, Interface Gráfica (ASCII) e Integração de Dados:</p>
    <ul>
        <li><strong>Charlie</strong> — <em>[Inserir Papel, ex: Gerente de Dados e Integração]</em></li>
        <li><strong>[Nome do Membro 2]</strong> — <em>[Inserir Papel, ex: Engenheiro de Lógica e Estado]</em></li>
        <li><strong>[Nome do Membro 3]</strong> — <em>[Inserir Papel, ex: Mestre da Arte ASCII e UI]</em></li>
        <li><strong>[Nome do Membro 4]</strong> — <em>[Inserir Papel, ex: Especialista em I/O]</em></li>
    </ul>

    <h2>⚙️ Arquitetura e Ferramentas</h2>
    <ul>
        <li><strong>Arquitetura Alvo:</strong> <em>[Ex: x86_64]</em></li>
        <li><strong>Sistema Operacional:</strong> <em>[Ex: Linux Ubuntu]</em></li>
        <li><strong>Assembler (Montador):</strong> <em>[Ex: NASM]</em></li>
        <li><strong>Linker:</strong> <em>[Ex: ld (GNU Linker)]</em></li>
    </ul>

    <h2>🚀 Como Compilar e Executar</h2>
    <p>Para executar o projeto em sua máquina local, certifique-se de ter o montador adequado instalado. Siga os passos abaixo no terminal:</p>

    <pre><code># 1. Clonar o repositório
git clone https://github.com/usuario/forca-assembly.git

# 2. Entrar no diretório do projeto
cd forca-assembly

# 3. Compilar o código fonte
# (Substitua os comandos abaixo pelo seu Makefile ou script de compilação)
nasm -f elf64 main.asm -o main.o
ld main.o -o forca

# 4. Executar o jogo
./forca</code></pre>

    <h2>🎮 Como Jogar</h2>
    <ol>
        <li>Ao iniciar o programa, uma palavra secreta será escolhida aleatoriamente pelo sistema.</li>
        <li>Você verá um quadro com a forca vazia e espaços correspondentes ao número de letras da palavra.</li>
        <li>Digite uma letra pelo teclado e pressione <code>Enter</code>.</li>
        <li>Se a letra existir na palavra, ela será revelada nos espaços correspondentes.</li>
        <li>Se você errar, uma parte do boneco será desenhada.</li>
        <li>O jogo termina quando você descobre a palavra inteira (Vitória) ou quando o desenho do boneco é concluído após 6 erros (Derrota).</li>
    </ol>

    <hr>
    <p><em>Projeto desenvolvido para fins acadêmicos - UFAL IC 2026.1.</em></p>

</body>
</html>
