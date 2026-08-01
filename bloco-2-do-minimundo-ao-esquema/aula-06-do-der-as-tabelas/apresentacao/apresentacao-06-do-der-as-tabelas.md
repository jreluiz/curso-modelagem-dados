---
marp: true
theme: trilha
paginate: true
lang: pt-BR
footer: '🗄️ Curso de Modelagem de Dados · Aula 06'
---

<!-- _class: capa -->

<div class="emoji">🗂️</div>

# Do DER às Tabelas

## Aula 06 · Bloco 2 — Do Minimundo ao Esquema

<div class="meta">Cinco regras, aplicadas na ordem</div>

---

## 🎯 Nesta aula

1. Por que **traduzir**
2. Regra 1 — **entidade** vira tabela
3. Regra 2 — **multivalorado** vira tabela
4. Regra 3 — **1:N** vira FK do lado N
5. Regra 4 — **N:M** vira associativa
6. Regra 5 — **1:1** e a escolha do lado
7. O que se **perde**

---

<!-- _class: lead -->

## 💡 O diagrama é bom para conversar com gente

Banco de dados não conhece
losango, seta nem retângulo.

Conhece **tabela, coluna e chave**.

A boa notícia: a tradução é mecânica.

---

<!-- _class: tabela-densa -->

## Aplique na ordem, e sem pular

| Ordem | Regra | O que ela consome |
|:---:|---|---|
| 1ª | Entidade vira tabela | os retângulos |
| 2ª | Multivalorado vira tabela | os atributos com mais de um valor |
| 3ª | 1:N vira FK do lado N | as linhas `\|\|--o{` |
| 4ª | N:M vira associativa | as linhas `}o--o{` |
| 5ª | 1:1 vira FK do lado obrigatório | as linhas `\|\|--o\|` |

Ao fim, **todo elemento do diagrama foi consumido por exatamente uma regra**.

---

## Regra 1 — Entidade vira tabela

```
No diagrama                      No esquema
OBRA {                           OBRA(isbn, titulo, ano, editora)
  varchar isbn PK        ───►         ‾‾‾‾
  varchar titulo
  int ano_publicacao
}
```

A mais simples, e a que produz mais tabela.

**Aplique-a primeiro, em todas as entidades**, antes de tocar num relacionamento.

---

## Regra 2 — Multivalorado vira tabela

```
TELEFONE(matricula, numero, tipo)
         ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾
         matricula → USUARIO(matricula)
```

A chave é **chave do dono + o que distingue os valores entre si**.

Só `matricula` não serve (três telefones). Só `numero` não serve (duas pessoas informam o mesmo ramal).

> 💡 É a **tabela dependente** da Aula 04 — a única em que "em cascata" é a ação certa.

---

## Regra 3 — 1:N vira FK do lado N

```
OBRA ||--o{ EXEMPLAR       EXEMPLAR(tombo, isbn, aquisicao, situacao)
                     ───►           ‾‾‾‾‾
                                    isbn → OBRA(isbn)   obrigatória
```

**A FK vai para o lado N**, onde cabe um valor só.

E o **mínimo** do símbolo decide se ela é obrigatória.

---

## Regra 4 — N:M vira tabela associativa

```
ESCRITA
┌────────────────┬──────────┬───────┐
│ isbn           │ id_autor │ ordem │
├────────────────┼──────────┼───────┤
│ 978-85-111-1   │    7     │   1   │ ← Silva é a primeira
│ 978-85-111-1   │   12     │   2   │ ← Souza é o segundo
│ 978-85-222-2   │   12     │   1   │ ← e o primeiro na outra obra
└────────────────┴──────────┴───────┘
```

A PK é o **par de FKs**. `ordem` não cabe em nenhum dos dois lados — é do par.

---

<!-- _class: lead -->

## ⚠️ Quando o par não basta como chave

Um usuário reserva uma obra,
desiste, e reserva de novo seis meses depois.

Duas linhas com o **mesmo par**.

Pergunte sempre:
*"esta combinação pode se repetir ao longo do tempo?"*

---

## Regra 5 — 1:1, e a escolha do lado

```
EMPRESTIMO ||--o| MULTA    MULTA(id_emprestimo, valor, data_pagamento)
                     ───►        ‾‾‾‾‾‾‾‾‾‾‾‾‾
                                 id_emprestimo → EMPRESTIMO
```

Toda multa vem de um empréstimo (**obrigatório**); nem todo empréstimo gera multa (**opcional**).

A FK vai para o lado obrigatório — e ainda serve de chave primária.

---

<!-- _class: tabela-densa -->

## O que se perde na tradução

| No diagrama | No esquema | O que fazer |
|---|---|---|
| "toda obra tem **pelo menos um** exemplar" | não é expressável | lista de regras de negócio |
| o rótulo `"assina"` | vira coluna sem nome | comentário no script |
| "máximo 3 empréstimos por aluno" | não é expressável | regra escrita |

---

<!-- _class: lead -->

## ⚠️ A perda que mais dói

FK obrigatória garante
*"todo exemplar tem obra"*.

O contrário — *"toda obra tem exemplar"* —
**não vira restrição nenhuma**,
porque a FK está do outro lado.

Guardar essa assimetria economiza horas.

---

<!-- _class: checkpoint -->

## 🏋️ Exercícios da aula

Na pasta `aula-06/`:

1. **`ex01.md`** — mapeie 4 relacionamentos aplicando as regras **na ordem**;
2. **`ex02.md`** — professor × disciplina × semestre: a chave é o par?
3. **`ex03.md`** — dois multivalorados, com a chave de cada um justificada;
4. **`ex04.md`** — mapeie **o seu DER inteiro**, com a lista das regras que não couberam;
5. **Desafio 🌶️ `ex05.md`** — cônjuge e filho na mesma tabela: duas FKs, um problema.

---

<!-- _class: lead -->

## ➡️ Próxima aula

**Aula 07 — Normalização até a 3FN**

As anomalias da Aula 01 voltam —
agora dentro de um esquema
que passou por todas as regras.
