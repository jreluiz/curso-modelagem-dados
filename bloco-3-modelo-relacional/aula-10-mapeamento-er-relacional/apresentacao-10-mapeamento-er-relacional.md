---
marp: true
theme: trilha
paginate: true
lang: pt-BR
footer: '🗄️ Curso de Modelagem de Dados · Aula 10'
---

<!-- _class: capa -->

<div class="emoji">🔄</div>

# Mapeamento ER → Relacional

## Aula 10 · Bloco 3 — Modelo Relacional

<div class="meta">As sete regras que traduzem o diagrama em tabelas</div>

---

## 🎯 Nesta aula

1. Por que traduzir
2. As **sete regras** de mapeamento
3. **Especialização**: as quatro opções
4. O esquema completo da Biblioteca
5. O que **se perde** na tradução

---

## Por que traduzir

O DER fala de **coisas do mundo**. O SGBD só entende **tabelas**.

O mapeamento é mecânico — e é exatamente por isso que vale conhecê-lo: você faz a tradução sem pensar, e reserva o pensamento para o modelo conceitual, que é onde as decisões difíceis moram.

---

## Regras 1 e 2 — entidades

**Regra 1 — Entidade forte** → uma relação. Atributos simples viram colunas; a chave primária vira PK.

```
USUARIO(matricula, nome, email)
```

**Regra 2 — Entidade fraca** → uma relação cuja PK é **a chave do pai + a chave parcial**, e a parte do pai é também FK.

```
EXEMPLAR(cod_obra, num_exemplar, situacao)
         └──── FK para OBRA ────┘
```

---

## Regras 3 e 4 — relacionamentos 1:N e 1:1

**Regra 3 — 1:N** → a FK vai para o lado **N**. Nunca cria tabela.

```
EMPRESTIMO(id, matricula, ..., )     ← matricula é FK
```

**Regra 4 — 1:1** → a FK vai para o lado de **participação total**. Se os dois forem totais, considere fundir as duas entidades numa só.

> 💡 Errar o lado da FK num 1:N é o erro mais comum do mapeamento — e produz uma coluna cheia de nulos.

---

## Regras 5, 6 e 7

**Regra 5 — N:M** → **sempre** uma relação nova. PK composta pelas duas FKs, mais os atributos do relacionamento.

**Regra 6 — Atributo multivalorado** → uma relação nova, com FK para a entidade + o valor. PK é o par.

**Regra 7 — Relacionamento n-ário** → uma relação nova, com uma FK para **cada** entidade participante.

---

<!-- _class: lead -->

## 🔑 A regra que resume as três

Sempre que a estrutura **não couber**
numa coluna a mais,

ela vira **tabela**.

N:M, multivalorado e n-ário
são todos o mesmo caso.

---

<!-- _class: tabela-densa -->

## Especialização: as quatro opções

| Opção | Como fica | Melhor quando |
|---|---|---|
| **A** — super + subs | uma tabela por subclasse, mais a super | consultas frequentes à super |
| **B** — só as subs | sem a superclasse | especialização **total e disjunta** |
| **C** — tabela única + discriminador | tudo numa tabela, coluna `tipo` | poucas colunas exclusivas |
| **D** — tabela única + flags | tudo numa tabela, um booleano por subclasse | especialização **sobreposta** |

---

## Como escolher

**A** é a mais fiel ao modelo, e a que mais cobra junção.

**B** só funciona se a especialização for **total** — senão você perde as instâncias que não são de subclasse nenhuma.

**C** é a mais prática quando as subclasses têm poucos atributos exclusivos. O preço são colunas nulas.

> ⚠️ Não existe opção certa em abstrato. A escolha depende de **como o sistema consulta os dados** — e isso é pergunta para o cliente.

---

## O que se perde na tradução

O modelo relacional **não sabe representar**:

- **Participação total** — nada impede uma obra sem exemplar;
- **Restrição de disjunção** — nada impede alguém ser aluno e professor na opção D;
- **Cardinalidade (min,max)** exata — `(1,3)` vira só "tem FK";
- **O nome do relacionamento** — `EMPRESTA` some, sobra uma coluna `matricula`.

---

<!-- _class: lead -->

## ⚠️ O que se perde tem de ir para outro lugar

O que o esquema não expressa
vai para **`CHECK`**, para **gatilho**,
ou para a **lista de regras de negócio**.

O que **não** pode acontecer
é a regra simplesmente desaparecer
entre o DER e o `CREATE TABLE`.

---

<!-- _class: checkpoint -->

## 🏋️ Exercícios da aula

Na pasta `aula-10/`:

1. **`ex01.md`** — mapeie um DER completo aplicando as sete regras, uma por vez;
2. **`ex02.md`** — o N:M `ALUNO`–`DISCIPLINA` com repetição em semestres: por que a chave óbvia **não serve**;
3. **`ex03.md`** — o multivalorado `palavras_chave`, e por que "tudo num campo separado por vírgula" é ruim;
4. **`ex04.md`** — a mesma especialização nas opções A, B e C, comparando as consultas;
5. **Desafio 🌶️ `ex05.md`** — o ternário, e o fato que a decomposição em três binários **perderia**.

---

<!-- _class: lead -->

## ➡️ Próxima aula

**Aula 11 — Álgebra Relacional**

O que o SGBD realmente executa
quando você escreve um `SELECT`.
