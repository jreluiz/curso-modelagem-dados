---
marp: true
theme: trilha
paginate: true
lang: pt-BR
footer: '🗄️ Curso de Modelagem de Dados · Aula 03'
---

<!-- _class: capa -->

<div class="emoji">🔗</div>

# Relacionamentos e Chave Estrangeira

## Aula 03 · Bloco 1 — O Modelo Relacional

<div class="meta">De que lado mora a coluna que liga duas tabelas</div>

---

## 🎯 Nesta aula

1. Duas tabelas que precisam **se falar**
2. **Chave estrangeira** — ligação por valor
3. **1:N** — e o lado onde a FK mora
4. **1:1** — e por que ele é suspeito
5. **N:M** e a **tabela associativa**
6. **Autorrelacionamento**

---

## A coluna estranha

```
ALUNO                        EMPRESTIMO
┌───────────┬────────────┐   ┌───────────┬───────────┬──────────┐
│ matricula │ nome       │   │ n_emprest │ matricula │ retirada │
├───────────┼────────────┤   ├───────────┼───────────┼──────────┤
│  2023101  │ Ana Souza  │◄──┤   1001    │  2023101  │  02/03   │
│  2023102  │ Bruno Lima │◄──┤   1002    │  2023102  │  09/03   │
└───────────┴────────────┘   └───────────┴───────────┴──────────┘
```

`matricula` em `EMPRESTIMO` não descreve o empréstimo. Ela **aponta**.

---

<!-- _class: lead -->

## 💡 Ligação por valor

Se `EMPRESTIMO.matricula` vale `2023101`,
o empréstimo está ligado a esse aluno —

**esteja a linha dele onde estiver no disco.**

Ninguém guarda "a terceira linha da tabela ALUNO".
É daí que vem toda a independência
que você vai ver na Aula 10.

---

<!-- _class: lista-limpa -->

## As três regras da FK

- 🎯 Referencia uma **chave primária ou candidata** — nunca uma coluna qualquer;
- 🧩 Tem o **mesmo domínio** do atributo referenciado;
- ⭕ Vale **um valor que existe** do outro lado, **ou** vazio — nunca um valor inventado.

---

## 1:N — as duas perguntas

> *Um aluno pode ter **vários** empréstimos?* → **sim**
> *Um empréstimo pode ser de **vários** alunos?* → **não**

```
✗ ALUNO(matricula, nome, n_emprest)     ✅ EMPRESTIMO(n_emprest, matricula, ...)
  │ 2023101 │ Ana │ 1001, 1002 │                              ↑ FK
  ✗ dois valores numa célula
```

**A FK mora do lado N** — o lado em que cabe *um só* do outro.

---

<!-- _class: lead -->

## ⚠️ O teste de uma linha

*"Deste lado, quantos do outro cabem?"*

Se a resposta for **vários**,
a FK **não** é aqui.

Use este teste pelo resto do curso.

---

## E a segunda pergunta, que é independente

**"Quantos?"** decide **onde a FK mora**.

**"Pode zero?"** decide se ela é **obrigatória**.

- Um empréstimo sem aluno não existe → `matricula` é obrigatória;
- Um aluno sem empréstimo é normal → nada precisa ser declarado.

São duas perguntas separadas. Responda uma de cada vez.

---

<!-- _class: lista-limpa -->

## 1:1 — desconfie duas vezes

Antes de aceitar um 1:1, pergunte:

- 🤔 **Isto não é a mesma coisa partida em duas tabelas?** Se sempre existem juntas, são uma;
- ⏳ **O "um" vale para sempre?** "Uma unidade tem um chefe" vira "teve vários ao longo do tempo" na primeira reunião.

Sobrevivendo às duas: a FK vai para o **lado obrigatório**, e precisa ser **única**.

---

## N:M e a tabela associativa

```
ALUNO           MATRICULA_DISCIPLINA          DISCIPLINA
┌─────────┐     ┌───────────┬──────────┬──────┐  ┌──────────┐
│2023101  │◄────┤ 2023101   │ BD101    │ 8.5  ├─►│ BD101    │
│2023102  │◄────┤ 2023101   │ ES102    │ 7.0  ├─►│ ES102    │
└─────────┘     │ 2023102   │ BD101    │ 9.0  │  └──────────┘
                └───────────┴──────────┴──────┘
                  PK composta: (matricula, cod_disc)
```

Não existe lado onde a FK caiba. Nasce uma **terceira tabela**.

---

<!-- _class: lead -->

## 📏 A nota mora na associativa

`nota` não é do aluno — ele tem várias.

`nota` não é da disciplina — ela tem várias.

**É do par.**

Todo dado que só faz sentido para a
combinação de dois mora na associativa.

---

## Autorrelacionamento

```
FUNCIONARIO
┌───────────┬────────────┬─────────────────┐
│ matricula │ nome       │ matricula_chefe │
├───────────┼────────────┼─────────────────┤
│    100    │ Marina     │     (vazio)     │ ← diretora
│    101    │ Ana Souza  │       100       │
│    102    │ Bruno Lima │       101       │
└───────────┴────────────┴─────────────────┘
```

Uma FK que referencia **a própria tabela**. Vale tudo o que você já sabe.

---

<!-- _class: checkpoint -->

## 🏋️ Exercícios da aula

Na pasta `aula-03/`:

1. **`ex01.md`** — classifique cinco pares em 1:1 / 1:N / N:M e diga onde a FK mora;
2. **`ex02.md`** — corrija um modelo com a FK do lado errado;
3. **`ex03.md`** — modele aluno × projeto com **função** e **data de entrada**;
4. **`ex04.md`** — categorias dentro de categorias, com instância de três níveis;
5. **Desafio 🌶️ `ex05.md`** — reservas com fila, e a chave que o item (d) quebra.

---

<!-- _class: lead -->

## ➡️ Próxima aula

**Aula 04 — Integridade e o valor nulo**

O que o banco **recusa** —
e o que acontece quando alguém apaga o outro lado.
