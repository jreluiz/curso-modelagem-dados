# Aula 01 — Por Que Bancos de Dados Existem

> 🎯 Objetivos: identificar os problemas que surgem quando dados vivem em arquivos soltos, explicar o que um SGBD acrescenta e reconhecer os papéis de quem trabalha com um banco de dados.

## 1. A planilha que deu certo até dar errado

Toda organização começa igual. Alguém abre uma planilha para controlar os empréstimos da biblioteca:

| aluno | cpf | curso | telefone | livro | isbn | autor | data_retirada |
|-------|-----|-------|----------|-------|------|-------|---------------|
| Ana Souza | 111.111.111-11 | Sistemas de Informação | 3399-1111 | Banco de Dados | 978-85-1234-567-8 | Guimarães | 04/03/2026 |
| Ana Souza | 111.111.111-11 | Sistemas de Informação | 3399-1111 | Algoritmos | 978-85-9999-111-2 | Ziviani | 11/03/2026 |
| Bruno Lima | 222.222.222-22 | Sistemas de Informacao | 3399-2222 | Banco de Dados | 978-85-1234-567-8 | C. Guimarães | 12/03/2026 |

Funciona. Funciona por meses. E então a Ana troca de telefone.

Você tem duas linhas para atualizar. Encontra uma. E agora existem dois telefones diferentes para a mesma pessoa, e **nenhum critério para saber qual é o certo**.

Repare que a tabela já tem outros três defeitos, e todos vieram de graça junto com o primeiro:

- "Sistemas de Informação" e "Sistemas de Informacao" são cursos diferentes para o computador;
- "Guimarães" e "C. Guimarães" são dois autores;
- O ISBN `978-85-1234-567-8` aparece duas vezes, e nada impede que na terceira o título venha escrito diferente.

## 2. Os quatro pecados do arquivo solto

O caso acima não é falta de capricho. É estrutural, e tem nome:

**Redundância.** O mesmo dado guardado em vários lugares. O telefone da Ana está em duas linhas hoje e estará em quinze no ano que vem.

**Inconsistência.** A consequência inevitável da redundância. Duas cópias do mesmo dado só ficam iguais enquanto **todo mundo** lembra de atualizar todas. Ninguém lembra sempre.

**Dependência entre programa e dado.** O programa que lê a planilha sabe que o telefone é a quarta coluna. Insira uma coluna no meio e todo programa quebra. Os dados e o código que os lê estão amarrados um ao outro.

**Isolamento dos dados.** Os empréstimos estão numa planilha, a lista de alunos numa segunda, o acervo numa terceira, cada uma num formato. Responder "quais alunos do curso X estão com livros atrasados?" vira um trabalho manual de cruzamento.

> 💡 **A raiz de tudo é uma só:** o dado não tem **um lugar único** onde mora. Guarde o telefone da Ana em exatamente um lugar do mundo e três dos quatro pecados desaparecem sozinhos. É por isso que a próxima ferramenta que você vai aprender chama-se *modelagem*, e não *programação*.

## 3. O que um SGBD acrescenta

Um **Sistema Gerenciador de Banco de Dados** (SGBD) é o programa que fica entre você e os dados: PostgreSQL, MySQL, Oracle, SQL Server, SQLite. Você nunca abre o arquivo — pede ao SGBD.

Parece uma barreira inútil até você ver o que ela oferece:

| O SGBD garante | O que isso significa na prática |
|---|---|
| **Controle de redundância** | Cada dado tem um lugar. O telefone da Ana existe uma vez |
| **Restrições de integridade** | O banco **recusa** um empréstimo para um aluno que não existe, uma nota 11 ou um CPF repetido |
| **Compartilhamento com controle de concorrência** | Duas pessoas emprestando o último exemplar ao mesmo tempo: uma consegue, a outra recebe uma recusa clara |
| **Segurança e autorização** | O atendente vê empréstimos, não vê salários. O mesmo banco, visões diferentes |
| **Backup e recuperação** | Faltou luz no meio de uma operação? Ao voltar, o banco está num estado coerente — nem meia operação, nem dado corrompido |
| **Independência de dados** | Acrescentar uma coluna não quebra os programas que não a usam |
| **Linguagem de consulta** | "Quais alunos do curso X estão atrasados?" é uma frase, não um projeto |

> ⚠️ **O SGBD não conserta um modelo ruim.** Ele garante que as regras que você declarou sejam cumpridas — e só isso. Se você declarou que um empréstimo pode existir sem exemplar, o banco vai defender essa bobagem com todo o rigor. **Qualidade do dado é decisão de projeto, e é sobre isso o resto do curso.**

## 4. Controle de concorrência, em um exemplo

Dois atendentes, um exemplar disponível, mesmo instante:

```
Atendente A                          Atendente B
─────────────────────────────────────────────────────────
lê situação do tombo 4417: LIVRE
                                     lê situação do tombo 4417: LIVRE
grava: EMPRESTADO para Ana
                                     grava: EMPRESTADO para Bruno
─────────────────────────────────────────────────────────
Resultado: o exemplar está com a Ana, o sistema diz que está com o Bruno,
e a leitura de A foi sobrescrita sem que ninguém percebesse.
```

Isso chama-se **atualização perdida** (*lost update*), e é a razão mais simples para não implementar seu próprio "banco de dados" com arquivos. Um SGBD resolve isso com transações e bloqueios — assunto da Aula 15.

## 5. Recuperação: o que acontece quando falta luz

Transferir um exemplar de uma unidade para outra são dois passos: dar baixa numa e dar entrada na outra. Se a energia cai no meio, o exemplar sumiu do mundo.

Um SGBD trata os dois passos como **uma unidade indivisível**: ou os dois acontecem, ou nenhum acontece. Ao religar, ele consulta o próprio registro de operações e desfaz o que ficou pela metade. Você não escreve uma linha para isso — é o comportamento padrão.

## 6. Quando **não** usar um SGBD

Boa engenharia é saber o custo. Um SGBD cobra instalação, administração, aprendizado e uma camada a mais entre você e o dado. Não compensa quando:

- Os dados são **pequenos, estáveis e de um usuário só** — uma lista de tarefas pessoal não precisa de PostgreSQL;
- Você precisa **entregar o arquivo** para alguém abrir e mexer: aí é CSV ou planilha mesmo;
- O dado é **descartável**: log temporário, cache, resultado intermediário;
- O acesso é **sequencial e completo**, sem consulta: ler um arquivo de configuração inteiro na inicialização.

> 💡 A pergunta que decide é sempre a mesma: **os dados vão ser compartilhados, relacionados e viver mais que o programa que os criou?** Três sins e você precisa de um banco. Três nãos e um arquivo resolve.

## 7. Quem é quem

Um banco de dados em produção tem gente com responsabilidades diferentes, e o curso forma principalmente o segundo papel da lista:

- **Administrador de banco de dados (DBA)** — cuida do servidor: instalação, desempenho, backup, permissões, segurança. Responde por *o banco está no ar e íntegro*;
- **Projetista de dados (modelador)** — decide **quais dados existem e como se relacionam**. Traduz o que o cliente diz em um modelo. É o papel deste curso, e o único que erra de forma silenciosa e cara;
- **Desenvolvedor de aplicações** — escreve os programas que consultam e alteram o banco;
- **Usuário final** — usa o sistema sem saber que existe um banco embaixo. É para ele que tudo isso é feito.

> ⚠️ Erro de DBA aparece no mesmo dia: o servidor cai, o backup falha, alguém liga. **Erro de modelagem aparece dois anos depois**, quando descobrem que o sistema não consegue responder a uma pergunta simples porque a informação nunca foi guardada de forma que permitisse respondê-la. Não há *hotfix* para isso.

## 🏋️ Exercícios da aula

Na pasta `aula-01/` do seu repositório:

1. **`ex01.md`** — encontre (ou invente com fidelidade) uma planilha real usada por alguém que você conhece: controle de estoque, lista de contatos de um grupo, escala de plantão. Copie umas 6 linhas dela, anonimizando o que for pessoal, e aponte **cada um dos quatro pecados** da seção 2 que ela comete. Se algum não estiver lá, explique por que aquele caso escapou;
2. **`ex02.md`** — usando a tabela da seção 1, descreva **três situações concretas** de perda de informação: (a) um dado que só pode ser guardado inventando um empréstimo falso; (b) um dado que desaparece quando um empréstimo é apagado; (c) um dado que pode ficar contraditório. Escreva cada uma como uma pequena história, não como definição;
3. **`ex03.md`** — um cliente diz: *"não precisamos de banco de dados, a planilha compartilhada na nuvem já resolve, e ainda é de graça."* Escreva a resposta que você daria — **em no máximo 15 linhas**, sem jargão, e reconhecendo honestamente onde ele tem razão. Depois escreva, em 3 linhas, o critério objetivo que decidiria a questão;
4. **`ex04.md`** — no cenário de uma biblioteca universitária, liste **quem seria cada um dos quatro atores** da seção 7 e escreva, para cada um, uma frase de algo que essa pessoa faz e que os outros três não fazem;
5. **Desafio 🌶️ `ex05.md`** — descreva um caso **real e específico** em que a planilha é a escolha **certa** e o banco de dados seria um erro. Não vale generalidade: dê o contexto, o volume de dados, quem usa, por quanto tempo, e explique o que exatamente se perderia ao migrar para um SGBD. Um bom projetista sabe quando não projetar.

## 🧠 Revisão

[8 questões de múltipla escolha](revisao/README.md) para conferir se os conceitos ficaram sólidos. Responda sem consultar a aula — depois volte e corrija.

## ✅ Entrega

```bash
git add aula-01/
git commit -m "Resolve exercícios da aula 01 (por que bancos de dados)"
git push
```

---

⬅️ [Voltar ao plano de aulas](../../README.md) | ➡️ [Aula 02 — Arquitetura e independência de dados](../aula-02-arquitetura-independencia/README.md)
