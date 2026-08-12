---
marp: true
theme: trilha
paginate: true
lang: pt-BR
footer: '🗄️ Curso de Modelagem de Dados · Aula 07'
---

<!-- _class: capa -->

<div class="emoji">🔗</div>

# Do Relacional à Integridade Referencial

## Aula 07 · Bloco 2 — Modelos de Banco de Dados

<div class="meta">O losango vira coluna — e o banco passa a recusar</div>

---

## 🎯 Nesta aula

1. Relação, tupla, **esquema**
2. **Chaves** — candidata, primária, alternativa
3. Do **losango** para a **coluna**
4. As **três integridades**
5. E quando alguém **apaga** o outro lado?

---

## Os nomes formais

```
   ALUNO
   ┌───────────┬──────────────┬──────────────────────┐
   │ matricula │ nome         │ email                │
   ├───────────┼──────────────┼──────────────────────┤
   │  2023101  │ Ana Souza    │ ana@aluno.br         │  ← uma tupla
   └───────────┴──────────────┴──────────────────────┘
        ↑
     atributo
```

**Relação** · **Tupla** · **Atributo** (com seu **domínio**)
**Esquema de relação** — `ALUNO(matricula, nome, email)`

---

<!-- _class: lead -->

## ⚠️ "Cardinalidade" aparece aqui com outro sentido

No modelo relacional é o **número de tuplas**
que a relação tem hoje.

Nada a ver com o `1`, `N`, `M` do diagrama.
Quando alguém disser "cardinalidade",
pergunte de qual delas está falando.

---

## Chaves: o que identifica uma tupla

Em `ALUNO(matricula, nome, email, cpf)`:

- **Candidata** — cada conjunto **mínimo** que identifica: `matricula`, `cpf`, `email`;
- **Primária** — a candidata que você **escolhe**;
- **Alternativa** — as que sobraram.

Três critérios, nesta ordem: a que **nunca muda**, a **menor**, a que **nunca falta**.

---

<!-- _class: lead -->

## ⚠️ Chave é o conjunto mínimo

`PRODUTO(codigo, nome, fabricante)` como chave primária:

se `codigo` já identifica,
acrescentar não cria chave melhor —
cria uma chave grande, copiada inteira
em toda referência.

---

## Do losango para a coluna

```
   1:N     EDITORA(cnpj, nome)
           LIVRO(isbn, titulo, cnpj → EDITORA)        ← a FK vai para o lado N

   N:M     ESCREVE(cpf → AUTOR, isbn → LIVRO, ordem)  ← nasce uma tabela
           └────── chave primária composta ──────┘

   FRACA   EXEMPLAR(isbn → LIVRO, numero_ex, situacao)
           └──── chave primária composta ────┘
```

**Nenhum losango sobreviveu.** No lógico existem só tabelas e colunas.

---

<!-- _class: tabela-densa -->

## As três integridades

| Integridade | Garante | O banco recusa |
|---|---|---|
| **De domínio** | todo valor pertence ao conjunto da coluna | `mil novecentos` num ano |
| **De entidade** | nenhuma parte da chave fica vazia | empréstimo sem número |
| **Referencial** | toda FK aponta para linha existente | livro com editora inexistente |

A referencial impede a **referência órfã** — a linha que aponta para o nada.

---

## Quatro tentativas de gravação

| O que se tenta gravar | Resultado |
|---|---|
| `situacao` = `"disponivel?"` | recusado — **domínio** |
| empréstimo sem `numero` | recusado — **entidade** |
| empréstimo com aluno inexistente | recusado — **referencial** |
| empréstimo com `data_devolucao` vazia | **aceito** — está em aberto |

A última ensina mais: **integridade não é recusar o que parece estranho**.

---

## E quando alguém apaga o outro lado?

- **Recusar** — não deixa apagar a editora enquanto houver livros dela. O padrão prudente;
- **Propagar** — apaga junto. Só quando o outro lado **não existe sem este**;
- **Anular** — deixa a coluna vazia. Só quando a ligação é opcional.

> 💡 A escolha se decide olhando a **participação** que você desenhou na Aula 06.

---

<!-- _class: lead -->

## ⚠️ Propagar apaga dado sem perguntar

Antes de escolhê-la,
aplique o teste da entidade fraca:

se a entidade se identifica sozinha,
ela sobrevive à dona — e propagar
destrói histórico que ninguém mandou destruir.

---

## O esquema lógico da biblioteca

```
   ALUNO(matricula, nome, email)
   EDITORA(cnpj, nome, cidade)
   LIVRO(isbn, titulo, ano, cnpj → EDITORA)
   EXEMPLAR(isbn → LIVRO, numero_ex, situacao)
   EMPRESTIMO(numero, data_retirada, data_devolucao,
              matricula → ALUNO, isbn + numero_ex → EXEMPLAR)
```

Chave composta **se propaga**: a FK tem o mesmo formato da chave que aponta.

---

<!-- _class: checkpoint -->

## 🏋️ Exercícios da aula

Na pasta `aula-07/`:

1. **`ex01.md`** — ache as chaves candidatas de `FUNCIONARIO` e escolha a primária pelos três critérios;
2. **`ex02.md`** — converta o N:M de `ESCREVE` em esquema lógico;
3. **`ex03.md`** — diga qual integridade cada operação viola, ou qual política de exclusão você adotaria.

---

<!-- _class: lead -->

## ➡️ Próxima aula

**Aula 08 — Agregação e estudo de caso**

Quando o relacionamento inteiro
precisa participar de outro relacionamento.
