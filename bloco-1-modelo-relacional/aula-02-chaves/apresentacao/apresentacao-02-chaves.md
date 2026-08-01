---
marp: true
theme: trilha
paginate: true
lang: pt-BR
footer: '🗄️ Curso de Modelagem de Dados · Aula 02'
---

<!-- _class: capa -->

<div class="emoji">🔑</div>

# Chaves

## Aula 02 · Bloco 1 — O Modelo Relacional

<div class="meta">Como apontar para uma linha e não errar</div>

---

## 🎯 Nesta aula

1. O que é **identificar**
2. **Superchave** — qualquer conjunto que serve
3. **Chave candidata** — a superchave sem gordura
4. **Primária** e **alternativa**
5. Quando a chave precisa ser **composta**
6. **Natural** × **artificial**

---

## A pergunta da aula

```
EXEMPLAR
┌───────┬──────────────┬───────────────────────┬────────────┐
│ tombo │ isbn         │ titulo                │ aquisicao  │
├───────┼──────────────┼───────────────────────┼────────────┤
│ 4417  │ 978-85-111-1 │ Banco de Dados        │ 2019-04-10 │
│ 4419  │ 978-85-111-1 │ Banco de Dados        │ 2021-08-03 │
└───────┴──────────────┴───────────────────────┴────────────┘
```

**Como você aponta para a segunda linha?**

Por `titulo` não dá. Por `isbn` também não — são duas cópias da mesma obra.

---

## Superchave: qualquer conjunto que identifica

Sem exigência de economia. Em `EXEMPLAR`:

- `(tombo)` — funciona;
- `(tombo, titulo)` — funciona, com uma coluna sobrando;
- `(tombo, isbn, titulo, aquisicao)` — a tabela inteira. Funciona, e é ridículo.

**Acrescentar colunas a uma superchave produz outra superchave.**

---

<!-- _class: lead -->

## ⚠️ Chave é regra do mundo, não coincidência dos dados

`(isbn, aquisicao)` parece funcionar
nas quatro linhas de hoje.

Mas a biblioteca **pode** comprar
duas cópias no mesmo dia.

Identificação se decide perguntando ao cliente,
não olhando a instância.

---

## Chave candidata: a superchave mínima

Tire uma coluna de cada vez e veja se ainda identifica:

- De `(tombo, titulo)` tire `titulo` → ainda identifica → **não era mínima**;
- De `(tombo)` tire `tombo` → sobra nada → **é mínima**.

Uma tabela pode ter **várias** candidatas:

`ALUNO(matricula, cpf, email, nome)` — as três primeiras identificam sozinhas.

---

## Primária e alternativa

Quando há mais de uma candidata, **alguém escolhe**. Três critérios, nesta ordem:

1. **Estabilidade** — o valor nunca muda? E-mail muda. Matrícula, não;
2. **Obrigatoriedade** — todo mundo tem? O estrangeiro pode não ter CPF;
3. **Simplicidade** — a PK vai ser copiada em toda tabela que referenciar esta.

As candidatas que sobraram são **chaves alternativas** — e o banco também garante que elas não repetem.

---

<!-- _class: lead -->

## ⚠️ CPF e e-mail: as duas piores escolhas clássicas

O e-mail muda quando a pessoa troca de provedor.

O CPF nem sempre existe no dia do cadastro.

Isso não os desqualifica como
chaves **alternativas** —
continuam únicos, e o banco deve garantir isso.

---

## Chave composta

```
MATRICULA_TURMA
┌───────────┬──────────┬────────────┐
│ matricula │ cod_turma│ data_insc  │
├───────────┼──────────┼────────────┤
│  2023101  │ BD-2026A │ 14/02      │
│  2023101  │ ES-2026A │ 14/02      │
│  2023102  │ BD-2026A │ 16/02      │
└───────────┴──────────┴────────────┘
```

Nenhuma das duas sozinha identifica. O **par** identifica, e é mínimo.

---

<!-- _class: tabela-densa -->

## Natural × artificial

| | Natural (`tombo`, `matricula`) | Artificial (`id` 1, 2, 3…) |
|---|---|---|
| **A favor** | legível; já existe; confere com o papel | nunca muda; sempre existe; curta |
| **Contra** | pode mudar; pode faltar; pode ser longa | não diz nada; exige junção para exibir |

---

<!-- _class: lead -->

## ⚠️ A armadilha da chave artificial

```
id │ cpf         │ nome
 1 │ 111.111.111 │ Ana Souza
 2 │ 111.111.111 │ Ana M. Souza   ← o banco aceitou
```

Duas linhas para uma pessoa só.

A chave artificial é a PK.
**A natural continua precisando ser garantida.**

---

<!-- _class: checkpoint -->

## 🏋️ Exercícios da aula

Na pasta `aula-02/`:

1. **`ex01.md`** — liste todas as chaves candidatas de `FUNCIONARIO` e prove a minimalidade;
2. **`ex02.md`** — escolha a PK com os três critérios, um parágrafo cada;
3. **`ex03.md`** — três equipes, três PKs: descreva o evento que quebra cada uma;
4. **`ex04.md`** — modele professor × disciplina × semestre e prove a chave;
5. **Desafio 🌶️ `ex05.md`** — defenda a chave natural contra a padronização por `id`.

---

<!-- _class: lead -->

## ➡️ Próxima aula

**Aula 03 — Relacionamentos e chave estrangeira**

Duas tabelas que precisam se falar —
e de que lado mora a coluna que as liga.
