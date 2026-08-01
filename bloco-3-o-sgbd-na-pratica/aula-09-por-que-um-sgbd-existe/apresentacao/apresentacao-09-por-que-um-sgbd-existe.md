---
marp: true
theme: trilha
paginate: true
lang: pt-BR
footer: '🗄️ Curso de Modelagem de Dados · Aula 09'
---

<!-- _class: capa -->

<div class="emoji">🗄️</div>

# Por Que um SGBD Existe

## Aula 09 · Bloco 3 — O SGBD na Prática

<div class="meta">Metade do problema você já resolveu. A outra metade é programa.</div>

---

## 🎯 Nesta aula

1. Metade do problema **já está resolvida**
2. Os **quatro pecados** do arquivo solto
3. O que um **SGBD acrescenta**
4. **Concorrência**, num exemplo
5. **Recuperação** — quando falta luz
6. Quando **não** usar um SGBD
7. **Quem é quem**

---

<!-- _class: lead -->

## 💡 O modelo está pronto — e continua sendo um desenho

Um esquema bem normalizado
numa planilha compartilhada

não impede ninguém de digitar
um empréstimo para uma matrícula que não existe.

Nem sobrevive a uma queda de energia
no meio de uma operação.

---

<!-- _class: tabela-densa -->

## Os quatro pecados — e o que a modelagem resolveu

| Pecado | Modelagem resolve? |
|---|:---:|
| **Redundância** — o mesmo dado em vários lugares | ✅ |
| **Inconsistência** — as cópias discordam | ✅ |
| **Dependência programa–dado** — insira uma coluna e tudo quebra | ❌ |
| **Isolamento** — cada coisa num arquivo, num formato | ❌ |

Os dois primeiros são de **organização**. Os dois últimos, de **controle de acesso**.

---

<!-- _class: tabela-densa -->

## O que o SGBD acrescenta

| Garante | Na prática |
|---|---|
| **Integridade** | recusa empréstimo para aluno que não existe |
| **Concorrência** | dois emprestando o último exemplar: um consegue |
| **Segurança** | o atendente vê empréstimos, não vê salários |
| **Recuperação** | faltou luz? ao voltar, estado coerente |
| **Consulta** | "quem está atrasado?" é uma frase, não um projeto |

---

## A diferença tem esta cara

```
Na planilha                     No banco
─────────────────────────       ────────────────────────────────────
digita matrícula 9999999        ERROR: violates foreign key constraint
a célula aceita                 "emprestimo_usuario_fk"
ninguém percebe                 DETAIL: Key (matricula)=(9999999)
o relatório fecha errado        is not present in table "usuario".
```

O banco não é mais **inteligente** que a planilha. É mais **teimoso**.

---

<!-- _class: lead -->

## ⚠️ O SGBD não conserta um modelo ruim

Ele garante que as regras
que **você declarou** sejam cumpridas.

Se você declarou que um empréstimo
pode existir sem exemplar,

o banco vai defender essa bobagem
com todo o rigor.

---

## Concorrência: a atualização perdida

```
Atendente A                        Atendente B
──────────────────────────────────────────────────────
lê situação do 4417: LIVRE
                                   lê situação do 4417: LIVRE
grava: EMPRESTADO para Ana
                                   grava: EMPRESTADO para Bruno
──────────────────────────────────────────────────────
O exemplar saiu com a Ana. O sistema diz Bruno.
```

Ninguém errou. Nenhum código está errado. **Ninguém está coordenando.**

---

## Recuperação: quando falta luz

Registrar um empréstimo são **dois passos**:

1. gravar a linha em `EMPRESTIMO`;
2. mudar a situação do exemplar.

Se a energia cai entre os dois, o banco diz "disponível" e o livro está na mochila de alguém.

O SGBD trata os dois como **uma unidade indivisível** — e você não escreve uma linha para isso.

---

<!-- _class: tabela-densa -->

## Quando **não** usar um SGBD

| Caso | Compart.? | Relac.? | Sobrevive? | Veredito |
|---|:---:|:---:|:---:|---|
| Lista de compras no celular | não | não | não | arquivo |
| Configuração de um programa | não | não | sim | arquivo |
| Estoque de uma loja | sim | sim | sim | **banco** |
| Notas de uma turma | sim | pouco | sim | depende |

A última linha é a interessante — e a resposta muda quando chega a segunda turma.

---

<!-- _class: lista-limpa -->

## Quem é quem

- 🔧 **DBA** — cuida do servidor: desempenho, backup, permissões;
- 📐 **Projetista de dados** — decide **quais dados existem**. É o papel das oito aulas anteriores;
- 💻 **Desenvolvedor** — escreve os programas que usam o banco;
- 👤 **Usuário final** — é para ele que tudo isso é feito.

---

<!-- _class: lead -->

## ⚠️ Erro de DBA × erro de modelagem

Erro de DBA aparece **no mesmo dia**:
o servidor cai, alguém liga.

Erro de modelagem aparece **dois anos depois**,
quando descobrem que o sistema não consegue
responder a uma pergunta simples.

Não há correção rápida para isso.

---

<!-- _class: checkpoint -->

## 🏋️ Exercícios da aula

Na pasta `aula-09/`:

1. **`ex01.md`** — quais pecados **sobrevivem** à separação em tabelas?
2. **`ex02.md`** — três situações que só o SGBD impede, contadas como histórias;
3. **`ex03.md`** — a resposta ao cliente que prefere a planilha, com uma concessão honesta;
4. **`ex04.md`** — os quatro atores na Biblioteca, com frases mutuamente exclusivas;
5. **Desafio 🌶️ `ex05.md`** — um caso real em que a planilha ganha, e o dia em que ela perde.

---

<!-- _class: lead -->

## ➡️ Próxima aula

**Aula 10 — Arquitetura e independência de dados**

Esquema × instância, os três níveis,
e o banco que descreve a si mesmo.
