---
marp: true
theme: trilha
paginate: true
lang: pt-BR
footer: '🗄️ Curso de Modelagem de Dados · Aula 01'
---

<!-- _class: capa -->

<div class="emoji">📄</div>

# Da Planilha à Tabela

## Aula 01 · Bloco 1 — O Modelo Relacional

<div class="meta">Por que separar assuntos resolve três problemas de uma vez</div>

---

## 🎯 Nesta aula

1. A planilha que **não aguenta mais**
2. As **três anomalias**
3. Uma **tabela por assunto**
4. O **vocabulário** do modelo relacional
5. **Grau** e **cardinalidade**
6. Como se escreve um **esquema**

---

## A planilha da biblioteca

```
n_emprest │ matricula │ nome_aluno │ tombo │ titulo_livro    │ retirada
──────────┼───────────┼────────────┼───────┼─────────────────┼───────────
   1001   │  2023101  │ Ana Souza  │ 4417  │ Banco de Dados  │ 02/03
   1002   │  2023101  │ Ana Souza  │ 4418  │ Eng. de Software│ 02/03
   1003   │  2023102  │ Bruno Lima │ 4417  │ Banco de Dados  │ 09/03
   1004   │  2023101  │ Ana Sousa  │ 4420  │ Redes           │ 11/03
```

Funciona — até a linha 1004, onde alguém digitou **Sousa** com S.

---

<!-- _class: lead -->

## 💡 O erro de digitação não é o problema

O problema é que o nome da Ana
está escrito **três vezes**.

Todo dado repetido é uma oportunidade
de discordar de si mesmo.

E alguém sempre aproveita.

---

<!-- _class: lista-limpa -->

## As três anomalias

- ✏️ **De alteração** — a Ana mudou de nome: quantas linhas alterar? Todas as dela;
- ➕ **De inserção** — chegou um livro ainda não emprestado: **onde** cadastrar?
- ➖ **De exclusão** — apagar o empréstimo 1004 apaga a única menção ao livro 4420.

A causa é uma só: **a planilha guarda coisas de naturezas diferentes na mesma linha.**

---

## Uma tabela por assunto

```
ALUNO                        LIVRO
┌───────────┬────────────┐   ┌───────┬──────────────────┐
│ matricula │ nome       │   │ tombo │ titulo           │
├───────────┼────────────┤   ├───────┼──────────────────┤
│  2023101  │ Ana Souza  │   │ 4417  │ Banco de Dados   │
│  2023102  │ Bruno Lima │   │ 4420  │ Redes            │
└───────────┴────────────┘   └───────┴──────────────────┘

EMPRESTIMO(n_emprest, matricula, tombo, retirada)
```

O nome da Ana agora está escrito **uma vez**.

---

## O vocabulário formal

| Formal | No dia a dia | Formal | No dia a dia |
|---|---|---|---|
| **Relação** | tabela | **Domínio** | tipo de dado |
| **Tupla** | linha | **Grau** | nº de colunas |
| **Atributo** | coluna | **Cardinalidade** | nº de linhas |

> 💡 Vale conhecer os dois. O formal aparece em livro e em prova; o informal, em toda conversa de trabalho.

---

<!-- _class: lista-limpa -->

## Uma relação não é uma planilha

Formalmente, uma relação é um **conjunto** — e daí vêm duas surpresas:

- 🚫 **Não existem duas linhas iguais** — copiar e colar a mesma linha não é permitido;
- 🔀 **A ordem das linhas não significa nada** — não existe "a primeira linha da tabela".

---

<!-- _class: lead -->

## 💡 Por que isso importa

Se a ordem das linhas não existe,

uma consulta sem ordenação explícita
**não tem garantia** de trazer nada em ordem.

É a base formal do `ORDER BY`
que você vai escrever na Aula 14.

---

## Grau e cardinalidade

Duas perguntas diferentes, dois números diferentes:

**Grau** — quantos **atributos**. `ALUNO(matricula, nome, curso)` tem grau 3.
Só muda se alguém alterar o desenho da tabela.

**Cardinalidade** — quantas **tuplas**. Muda a cada matrícula nova.

> ⚠️ "Cardinalidade" volta na Aula 03 com **outro** sentido: a razão 1:N entre tabelas. Mesma palavra, sem parentesco.

---

## O esquema, em uma linha

```
ALUNO(matricula, nome, curso)
      ‾‾‾‾‾‾‾‾‾
```

Nome da relação, atributos entre parênteses, sublinhado no que identifica.

**Esquema** = a forma, o que não muda.
**Instância** = as linhas que estão lá agora.

Esquema você projeta uma vez. Instância muda o tempo todo.

---

<!-- _class: checkpoint -->

## 🏋️ Exercícios da aula

Na pasta `aula-01/`:

1. **`ex01.md`** — ache uma planilha real e liste **todo dado escrito mais de uma vez**;
2. **`ex02.md`** — classifique quatro situações nas três anomalias;
3. **`ex03.md`** — separe a planilha de uma clínica em tabelas, uma por assunto;
4. **`ex04.md`** — escreva o esquema de cada tabela, com grau e cardinalidade;
5. **Desafio 🌶️ `ex05.md`** — um caso em que a **planilha** é a escolha certa.

---

<!-- _class: lead -->

## ➡️ Próxima aula

**Aula 02 — Chaves: como identificar uma linha**

Você sublinhou `matricula` sem pensar.
Na próxima aula, o critério.
