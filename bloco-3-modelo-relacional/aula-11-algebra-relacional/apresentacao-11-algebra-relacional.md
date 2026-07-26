---
marp: true
theme: trilha
paginate: true
lang: pt-BR
footer: '🗄️ Curso de Modelagem de Dados · Aula 11'
---

<!-- _class: capa -->

<div class="emoji">➗</div>

# Álgebra Relacional

## Aula 11 · Bloco 3 — Modelo Relacional

<div class="meta">O que o SGBD executa quando você escreve um SELECT</div>

---

## 🎯 Nesta aula

1. Por que estudar isto
2. **σ** seleção · **π** projeção · **ρ** renomeação
3. Operações de conjunto: **∪ ∩ −**
4. **×** produto cartesiano e **⋈** junção
5. **÷** divisão — o "para todos"

---

## Por que estudar isto

A álgebra relacional é a **linguagem interna** do SGBD.

Quando você escreve um `SELECT`, o otimizador o converte numa expressão algébrica, reordena as operações e escolhe um plano.

Entender a álgebra é entender **por que uma consulta é lenta** — e por que trocar a ordem de duas condições às vezes muda tudo.

---

## Os operadores unários

**σ (seleção)** — escolhe **linhas**. É o `WHERE`.

```
σ ano > 2000 (OBRA)
```

**π (projeção)** — escolhe **colunas**. É o `SELECT` de colunas. E **elimina duplicatas**.

```
π titulo, ano (OBRA)
```

**ρ (renomeação)** — dá outro nome a uma relação ou coluna. É o `AS`.

---

<!-- _class: lead -->

## 💡 A ordem importa — muito

```
π titulo ( σ ano > 2000 (OBRA) )
```

**seleciona primeiro, projeta depois.**

Filtrar antes reduz o volume que
as operações seguintes precisam processar.

É exatamente isso que o otimizador
tenta fazer sozinho.

---

## Operações de conjunto

**∪ união** · **∩ interseção** · **− diferença**

As três exigem **compatibilidade de união**: mesmo número de atributos, com domínios compatíveis, na mesma ordem.

```
π matricula (ALUNO)  −  π matricula (EMPRESTIMO)
```

*"alunos que nunca pegaram nada emprestado"*

---

## Produto cartesiano e junção

**× (produto cartesiano)** combina **toda linha com toda linha**. Uma tabela de 1.000 com uma de 500 dá 500.000 linhas — quase todas sem sentido.

**⋈ (junção)** é o produto cartesiano **seguido de uma seleção**:

```
OBRA ⋈ EXEMPLAR    ≡    σ condição (OBRA × EXEMPLAR)
```

> ⚠️ Todo `SELECT` sem `WHERE` de ligação entre duas tabelas é um produto cartesiano. É o bug que trava o banco.

---

## As variedades de junção

**Natural (⋈)** — liga pelos atributos de mesmo nome, automaticamente.

**Theta (⋈θ)** — liga por uma condição qualquer.

**Externas** — mantêm as linhas sem par:

- **esquerda** — tudo da esquerda, mesmo sem correspondência;
- **direita** — o espelho;
- **completa** — os dois lados.

> 💡 Junção externa esquerda é como se responde *"obras que **não** têm exemplar"*.

---

<!-- _class: lead -->

## ➗ Divisão — o "para todos"

A operação que responde:

**"quais alunos pegaram emprestadas
TODAS as obras da área X?"**

É a única que expressa
o quantificador universal.

E a única que **não tem** um comando SQL direto —
resolve-se com dupla negação.

---

## Montando sequências

Expressões se encadeiam. Cada operação recebe relações e devolve uma relação.

```
π nome (
    σ curso = 'SI' (USUARIO)
    ⋈
    σ data_devolucao IS NULL (EMPRESTIMO)
)
```

*"nomes dos alunos de SI com empréstimo em aberto"*

---

## O que a álgebra **não** tem

- **Agregação** — `SUM`, `AVG`, `COUNT` não são da álgebra clássica;
- **Ordenação** — relação não tem ordem, lembra?
- **Recursão** — hierarquias de profundidade arbitrária.

O SQL acrescentou tudo isso. Por isso o SQL é mais que a álgebra — mas a álgebra continua sendo o **núcleo** que o otimizador manipula.

---

<!-- _class: checkpoint -->

## 🏋️ Exercícios da aula

Na pasta `aula-11/`:

1. **`ex01.md`** — traduza 8 perguntas em português para expressões algébricas;
2. **`ex02.md`** — a mesma expressão em duas ordens: qual é mais eficiente, e por quê;
3. **`ex03.md`** — as três operações de conjunto, com a compatibilidade verificada;
4. **`ex04.md`** — junção interna × externa: quando cada uma responde a pergunta certa;
5. **Desafio 🌶️ `ex05.md`** — uma divisão relacional, com os dados que provam o resultado.

---

<!-- _class: lead -->

## ➡️ Próxima aula

**Aula 12 — Normalização**

Por que uma tabela mal desenhada
mente — e como consertar.
