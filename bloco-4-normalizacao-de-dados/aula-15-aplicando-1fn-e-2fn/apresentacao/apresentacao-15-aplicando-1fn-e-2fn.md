---
marp: true
theme: trilha
paginate: true
lang: pt-BR
footer: '🗄️ Curso de Modelagem de Dados · Aula 15'
---

<!-- _class: capa -->

<div class="emoji">✂️</div>

# Aplicando a 1FN e a 2FN

## Aula 15 · Bloco 4 — Normalização de Dados

<div class="meta">Da tabela única às quatro tabelas, sem perder nada</div>

---

## 🎯 Nesta aula

1. A tabela **completa**
2. Passo 1 — a **1FN**
3. Passo 2 — a **2FN**
4. A conferência: **não perder informação**
5. A dependência **transitiva**
6. A **3FN**

---

## A tabela que a secretaria mandou

```
   INSCRICAO(cod_ev, matricula, nome_aluno, curso, titulo_evento,
             carga_horaria, sala, capacidade_sala, palestrantes,
             data_inscricao)
   CHAVE: (cod_ev, matricula)

   101 | 2023101 | Ana Souza | ADS | Pesquisa | 4 | S-204 | 40 | Marta; Carlos
   101 | 2023102 | Bruno Lima| ADS | Pesquisa | 4 | S-204 | 40 | Marta; Carlos
```

Duas coisas saltam aos olhos, e cada uma é uma forma normal.

---

## Passo 1 — a 1FN

`palestrantes` guarda uma **lista**. A cura é sempre a mesma:

```
   INSCRICAO(cod_ev, matricula, nome_aluno, curso, titulo_evento,
             carga_horaria, sala, capacidade_sala, data_inscricao)

   PALESTRANTE_EVENTO(cod_ev, nome_palestrante)
      chave: (cod_ev, nome_palestrante)
```

A tabela nova responde de graça: **em quantos eventos a Marta falou?**

---

## Passo 2 — a 2FN, mecanicamente

```
   PARA CADA determinante que é PARTE da chave:
       1. crie uma tabela nova
       2. o determinante vira a chave dela
       3. leve para lá tudo o que ele determina
       4. o determinante FICA na tabela original, como chave estrangeira
```

O passo **4** é o que mais gente esquece.

---

## O resultado

```
   ALUNO(matricula, nome_aluno, curso)

   EVENTO(cod_ev, titulo_evento, carga_horaria, sala, capacidade_sala)

   INSCRICAO(matricula → ALUNO, cod_ev → EVENTO, data_inscricao)
      chave: (cod_ev, matricula)

   PALESTRANTE_EVENTO(cod_ev → EVENTO, nome_palestrante)
```

> 💡 São as **mesmas quatro tabelas** que sairiam do DER da Aula 09.

---

## A conferência: não perder informação

**A coluna pela qual você separou é chave em pelo menos uma das tabelas resultantes?**

```
   `matricula` é chave em ALUNO?      SIM   ✅ sem perda
   `matricula` está em INSCRICAO?     SIM   ✅ dá para remontar
```

E mais: toda coluna original ainda existe? Remontar uma linha devolve a original? As três anomalias sumiram?

---

<!-- _class: lead -->

## ⚠️ O contraexemplo

Separar `ALUNO(matricula, nome, curso)`
em `ALUNO(matricula, nome)` e `CURSO(curso)`
**perde informação**.

Sobrou a lista de cursos existentes,
que não era a pergunta.

---

## Uma dependência que não é parcial

```
   EVENTO(cod_ev, titulo_evento, carga_horaria, sala, capacidade_sala)

   101 | Pesquisa em base | 4 | S-204 | 40
   103 | Escrita técnica  | 3 | S-204 | 40   ← 40 de novo
```

```
   cod_ev → sala              a sala depende do evento
   sala   → capacidade_sala   a capacidade depende da SALA
```

A chave tem **uma coluna só** — não há metade de que depender.

---

## A 3FN

Um esquema está na 3FN quando:

1. está na **2FN**; e
2. **nenhum atributo não-chave depende de outro atributo não-chave.**

| | O atributo depende de… | Só existe quando… |
|---|---|---|
| **2FN** | **parte da chave** | a chave é **composta** |
| **3FN** | **outro atributo não-chave** | sempre |

---

<!-- _class: lead -->

## ⚠️ Olhe a chave primeiro

Chave de uma coluna só?
Então **não é 2FN**, ponto final —
o que você encontrou é transitiva.

Quem decompõe certo mas justifica errado
perde a parte que importa.

---

<!-- _class: lead -->

## 💡 A frase que resume as três

**Todo atributo depende da chave,
da chave inteira,
e de nada além da chave.**

"Da chave" é a 1FN. "Da chave inteira", a 2FN.
"De nada além", a 3FN.

---

<!-- _class: checkpoint -->

## 🏋️ Exercícios da aula

Na pasta `aula-15/`:

1. **`ex01.md`** — leve `EMPRESTIMO` até a 2FN, mostrando os dois passos separados;
2. **`ex02.md`** — três decomposições: quais são sem perda?
3. **`ex03.md`** — em `FUNCIONARIO`, o problema é parcial ou transitivo? justifique pela chave.

---

<!-- _class: lead -->

## ➡️ Próxima aula

**Aula 16 — 3FN e 4FN**

A última forma normal do curso —
e a tabela que multiplica linhas sozinha.
