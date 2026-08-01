# Aula 09 — Por Que um SGBD Existe

> 🎯 Objetivos: nomear os quatro pecados do arquivo solto, listar o que um SGBD garante que uma planilha não garante e reconhecer os papéis de quem trabalha com um banco de dados.
> 🎬 Slides da aula: [apresentacao-09-por-que-um-sgbd-existe.pdf](apresentacao/apresentacao-09-por-que-um-sgbd-existe.pdf)

## 1. Metade do problema você já resolveu

As oito aulas anteriores foram sobre **o que guardar e como organizar**. Você sabe separar assuntos em tabelas, escolher chaves, ligar por chave estrangeira e normalizar até a 3FN. No papel, o modelo da Biblioteca está pronto.

E ele continua sendo um desenho.

Um esquema bem normalizado escrito numa planilha compartilhada não impede ninguém de digitar um empréstimo para uma matrícula que não existe. Não impede dois atendentes de emprestarem o mesmo exemplar no mesmo segundo. Não sobrevive a uma queda de energia no meio de uma operação.

**Este bloco é sobre o programa que faz o modelo valer.** A pergunta desta aula é por que ele existe.

## 2. Os quatro pecados do arquivo solto

Volte à planilha da Aula 01 — a que misturava aluno, livro e empréstimo na mesma linha. Ela tinha quatro defeitos estruturais, e você resolveu **dois** com modelagem:

**Redundância.** O mesmo dado guardado em vários lugares. ✅ *Resolvido separando em tabelas.*

**Inconsistência.** A consequência inevitável da redundância: duas cópias do mesmo dado só ficam iguais enquanto todo mundo lembra de atualizar as duas. ✅ *Resolvido junto com a primeira.*

**Dependência entre programa e dado.** O programa que lê a planilha sabe que o telefone é a quarta coluna. Insira uma coluna no meio e todo programa quebra. ❌ *Modelagem não resolve.*

**Isolamento dos dados.** Empréstimos numa planilha, alunos noutra, acervo numa terceira, cada uma num formato. Responder "quais alunos estão com livros atrasados?" vira trabalho manual de cruzamento. ❌ *Modelagem não resolve.*

> 💡 Os dois primeiros são problemas de **como o dado está organizado** — e por isso cederam ao modelo. Os dois últimos são problemas de **quem controla o acesso ao dado**, e para eles não existe diagrama que ajude. Existe programa.

## 3. O que um SGBD acrescenta

Um **Sistema Gerenciador de Banco de Dados** é o programa que fica entre você e os dados: PostgreSQL, MySQL, Oracle, SQL Server, SQLite. Você nunca abre o arquivo — pede ao SGBD.

Parece uma barreira inútil até você ver o que ela oferece:

| O SGBD garante | O que isso significa na prática |
|---|---|
| **Restrições de integridade** | O banco **recusa** um empréstimo para um aluno que não existe, um ano de publicação `'antigo'` ou um tombo repetido |
| **Controle de concorrência** | Duas pessoas emprestando o último exemplar ao mesmo tempo: uma consegue, a outra recebe uma recusa clara |
| **Segurança e autorização** | O atendente vê empréstimos, não vê salários. O mesmo banco, visões diferentes |
| **Backup e recuperação** | Faltou luz no meio de uma operação? Ao voltar, o banco está num estado coerente — nem meia operação, nem dado corrompido |
| **Independência de dados** | Acrescentar uma coluna não quebra os programas que não a usam |
| **Linguagem de consulta** | "Quais alunos estão atrasados?" é uma frase, não um projeto |

Repare que a primeira linha é a Aula 04 inteira. As restrições de integridade que você aprendeu a **declarar** só valem alguma coisa porque existe alguém para **verificá-las** em toda escrita, para sempre, sem esquecer.

Na prática, a diferença tem esta cara:

```
   Na planilha                          No banco
   ─────────────────────────────        ──────────────────────────────────────
   digita matrícula 9999999             ERROR: insert or update on table
   a célula aceita                      "emprestimo" violates foreign key
   ninguém percebe                      constraint "emprestimo_usuario_fk"
   o relatório do mês fecha errado      DETAIL: Key (matricula)=(9999999)
                                        is not present in table "usuario".
```

O banco não é mais inteligente que a planilha — ele é mais **teimoso**. Você escreveu a regra uma vez, e ele a cobra todas as vezes, inclusive quando é inconveniente, inclusive às sextas-feiras.

> ⚠️ **O SGBD não conserta um modelo ruim.** Ele garante que as regras que você declarou sejam cumpridas — e só isso. Se você declarou que um empréstimo pode existir sem exemplar, o banco vai defender essa bobagem com todo o rigor. Qualidade do dado continua sendo decisão de projeto.

## 4. Concorrência, num exemplo

Dois atendentes, um exemplar disponível, mesmo instante:

```
   Atendente A                          Atendente B
   ─────────────────────────────────────────────────────────
   lê a situação do tombo 4417: LIVRE
                                        lê a situação do tombo 4417: LIVRE
   grava: EMPRESTADO para Ana
                                        grava: EMPRESTADO para Bruno
   ─────────────────────────────────────────────────────────
   O exemplar saiu com a Ana, o sistema diz que está com o Bruno,
   e a escrita de A foi sobrescrita sem que ninguém percebesse.
```

Isso chama-se **atualização perdida**, e é a razão mais simples para não escrever o seu próprio "banco de dados" com arquivos. Nenhuma das duas pessoas errou; nenhum código está errado. O problema é que ninguém está coordenando os dois.

O SGBD coordena. Como ele faz isso é a Aula 12.

## 5. Recuperação: o que acontece quando falta luz

Registrar um empréstimo são dois passos: gravar a linha em `EMPRESTIMO` e mudar a situação do exemplar para `emprestado`. Se a energia cai entre um e outro, o banco fica dizendo que o exemplar está disponível — e ele está na mochila de alguém.

Um SGBD trata os dois passos como **uma unidade indivisível**: ou os dois acontecem, ou nenhum acontece. Ao religar, ele consulta o próprio registro de operações e desfaz o que ficou pela metade.

Você não escreve uma linha de código para isso. É o comportamento padrão, e é uma das coisas mais difíceis de reproduzir por conta própria.

## 6. Quando **não** usar um SGBD

Boa engenharia é saber o custo. Um SGBD cobra instalação, administração, aprendizado e uma camada a mais entre você e o dado. Não compensa quando:

- Os dados são **pequenos, estáveis e de um usuário só** — uma lista de tarefas pessoal não precisa de PostgreSQL;
- Você precisa **entregar o arquivo** para alguém abrir e mexer: aí é CSV ou planilha mesmo;
- O dado é **descartável**: registro temporário, cache, resultado intermediário;
- O acesso é **sequencial e completo**, sem consulta: ler um arquivo de configuração inteiro na inicialização.

> 💡 A pergunta que decide é sempre a mesma: **os dados vão ser compartilhados, relacionados e viver mais que o programa que os criou?** Três sins e você precisa de um banco. Três nãos e um arquivo resolve.

Aplicada a quatro casos reais:

| Caso | Compartilhado? | Relacionado? | Sobrevive ao programa? | Veredito |
|---|:---:|:---:|:---:|---|
| Lista de compras no celular | não | não | não | Arquivo |
| Configuração de um programa | não | não | sim | Arquivo |
| Controle de estoque de uma loja | sim | sim | sim | **Banco** |
| Planilha de notas de uma turma | sim | pouco | sim | Depende — e a resposta muda quando chega a segunda turma |

> ⚠️ A última linha é a interessante. A maioria dos sistemas que precisam de banco **começou** parecendo o caso da planilha de notas, e ninguém percebeu o dia em que a resposta mudou. Quando alguém percebe, já existem trinta arquivos e três versões da verdade.

## 7. Quem é quem

Um banco em produção tem gente com responsabilidades diferentes, e este curso forma principalmente o segundo papel da lista:

- **Administrador de banco de dados (DBA)** — cuida do servidor: instalação, desempenho, backup, permissões, segurança. Responde por *o banco está no ar e íntegro*;
- **Projetista de dados** — decide **quais dados existem e como se relacionam**. Traduz o que o cliente diz num modelo. É o papel das oito aulas anteriores;
- **Desenvolvedor de aplicações** — escreve os programas que consultam e alteram o banco;
- **Usuário final** — usa o sistema sem saber que existe um banco embaixo. É para ele que tudo isso é feito.

> ⚠️ Erro de DBA aparece no mesmo dia: o servidor cai, o backup falha, alguém liga. **Erro de modelagem aparece dois anos depois**, quando descobrem que o sistema não consegue responder a uma pergunta simples porque a informação nunca foi guardada de forma que permitisse respondê-la. Não há correção rápida para isso.

> 📖 Os capítulos introdutórios do livro-base cobrem as vantagens do SGBD e os papéis envolvidos. Vale ler a comparação histórica: entender o que o SGBD resolveu explica por que ele é como é.

## 🏋️ Exercícios da aula

Na pasta `aula-09/` do seu repositório:

1. **`ex01.md`** — retome a planilha que você analisou no `ex01` da Aula 01. Você já separou os dados em tabelas. Agora responda: **quais dos quatro pecados continuam lá**, mesmo com as tabelas separadas, e o que exatamente um SGBD faria por cada um? Descreva um evento concreto para cada pecado sobrevivente. *Confira assim: pelo menos dois pecados sobrevivem à separação — se você achou que todos foram resolvidos, releia a seção 2.*
2. **`ex02.md`** — descreva **três situações concretas** que a modelagem sozinha não impede e o SGBD impede: (a) uma que envolva integridade referencial; (b) uma que envolva duas pessoas ao mesmo tempo; (c) uma que envolva uma falha no meio da operação. Escreva cada uma como uma pequena história com nomes e horários, não como definição. *Confira assim: em cada história, aponte o instante exato em que o estrago aconteceria sem o SGBD.*
3. **`ex03.md`** — um cliente diz: *"não precisamos de banco de dados, a planilha compartilhada na nuvem já resolve, e ainda é de graça."* Escreva a resposta que você daria — em **no máximo 15 linhas**, sem jargão, e reconhecendo honestamente onde ele tem razão. Depois escreva, em 3 linhas, o critério objetivo que decidiria a questão. *Confira assim: se a sua resposta não contém nenhuma concessão ao cliente, ela não vai convencer ninguém — a planilha realmente ganha em alguns pontos.*
4. **`ex04.md`** — no cenário da Biblioteca, diga **quem seria cada um dos quatro atores** da seção 7 e escreva, para cada um, uma frase de algo que essa pessoa faz e que os outros três não fazem. Depois responda: qual dos quatro erros demora mais para aparecer, e por quê? *Confira assim: as quatro frases precisam ser mutuamente exclusivas — se duas pessoas fazem a mesma coisa, você não separou os papéis.*
5. **Desafio 🌶️ `ex05.md`** — descreva um caso **real e específico** em que a planilha é a escolha **certa** e o banco de dados seria um erro. Não vale generalidade: dê o contexto, o volume de dados, quem usa, por quanto tempo, e explique o que exatamente se perderia ao migrar para um SGBD. Depois descreva o evento que mudaria a sua recomendação. *Confira assim: um bom projetista sabe quando não projetar — mas também sabe dizer em que dia a decisão precisa ser revista.*

## 🧠 Revisão

[8 questões de múltipla escolha](revisao/README.md) para conferir se os conceitos ficaram sólidos. Responda sem consultar a aula — depois volte e corrija.

## ✅ Entrega

```bash
git add aula-09/
git commit -m "Resolve exercícios da aula 09 (por que um SGBD existe)"
git push
```

---

⬅️ [Aula 08](../../bloco-2-do-minimundo-ao-esquema/aula-08-estudo-de-caso/README.md) | ➡️ [Aula 10 — Arquitetura e independência de dados](../aula-10-arquitetura-independencia/README.md)
