---
marp: true
theme: trilha
paginate: true
lang: pt-BR
footer: '🗄️ Curso de Modelagem de Dados · Aula 14'
---

<!-- _class: capa -->

<div class="emoji">🧮</div>

# Dependência Funcional, 1FN e 2FN

## Aula 14 · Bloco 4 — Normalização de Dados

<div class="meta">"Se eu sei isto, eu sei aquilo"</div>

---

## 🎯 Nesta aula

1. A **dependência funcional**
2. Como se **descobre** uma
3. A **1FN** — cada célula, um valor
4. **Dependência parcial**
5. A **2FN** — e quando ela é automática

---

## Uma relação de mão única

```
   matricula = 2023101   ──▶   nome_aluno = Ana Souza
                         ──▶   curso      = ADS
```

Sabendo a matrícula, sei o nome e o curso.

Sabendo que o nome é "Ana Souza", sei a matrícula? **Não** — pode haver outra.

---

## `X → Y`: X determina Y

Para **cada** valor de `X`, existe **um único** valor de `Y`.

```
   matricula → nome_aluno            cod_ev → titulo_evento
   matricula → curso                 cod_ev → carga_horaria

   (cod_ev, matricula) → data_inscricao    ← determinante composto
```

O lado esquerdo é o **determinante**.

---

<!-- _class: tabela-densa -->

## Como se descobre: perguntando

| A pergunta | O que a resposta decide |
|---|---|
| *"Um aluno pode ter dois nomes?"* | se `matricula → nome_aluno` vale |
| *"Um evento pode ter duas salas?"* | se `cod_ev → sala` vale |
| *"O aluno se inscreve duas vezes no mesmo evento?"* | se o par é chave |

Três coisas que **parecem** DF e não são: o sentido inverso, o conjunto de valores, e a **coincidência nos dados**.

---

<!-- _class: lead -->

## ⚠️ Dados de exemplo não provam dependência

Quatro linhas coerentes provam apenas
que ainda não apareceu contraexemplo.

Uma linha com a mesma matrícula
e dois nomes **derruba** a dependência na hora.

**Dado desmente; quem confirma é o cliente.**

---

## A 1FN: cada célula guarda um valor

```
   ❌ LISTA NA CÉLULA          ❌ COLUNAS NUMERADAS
   ┌───────────┬────────────┐  ┌───────────┬───────────┬───────────┐
   │ matricula │ telefones  │  │ matricula │ telefone1 │ telefone2 │
   │  2023101  │ 9999-1111, │  └───────────┴───────────┴───────────┘
   │           │ 9999-2222  │
   └───────────┴────────────┘  ✅ EM 1FN: TELEFONE_ALUNO
                                  chave: (matricula, telefone)
```

---

<!-- _class: lead -->

## ⚠️ `telefone1`, `telefone2`, `telefone3` **não** está em 1FN

Quem tem quatro não cabe.
Quem tem um desperdiça duas colunas.
Procurar exige olhar em três lugares.

**Atributo multivalorado vira entidade própria.** Sempre.

---

## As dependências da tabela de inscrições

```
   CHAVE: (cod_ev, matricula)

   (cod_ev, matricula) → data_inscricao      ✅ chave INTEIRA
    matricula          → nome_aluno, curso   ⚠️ metade da chave
    cod_ev             → titulo, carga, sala ⚠️ a outra metade
```

Escrever as dependências antes de decompor é o equivalente a escrever as regras antes de desenhar o DER.

---

## Dependência parcial

Um atributo que depende de **parte** da chave composta, e não dela toda.

É a causa direta das anomalias da Aula 13: o nome da Ana depende só da matrícula, então se repete em toda linha em que a matrícula aparece.

> ⚠️ **Só existe com chave composta.** Se a chave tem uma coluna só, não há metade de que depender.

---

## A 2FN

Um esquema está na 2FN quando:

1. está na **1FN**; e
2. **nenhum atributo não-chave depende de parte da chave.**

```
   EMPRESTIMO_ITEM(num_emprestimo, isbn, numero_ex, titulo_livro)
      chave: (num_emprestimo, isbn, numero_ex)
      isbn → titulo_livro     ⚠️ parte da chave — não está em 2FN
```

---

<!-- _class: lead -->

## ⚠️ Chave simples? Já está em 2FN

Sem fazer nada.

A análise da 2FN só tem trabalho
quando a chave é **composta** —
e quem não olha a chave antes
gasta meia hora provando o óbvio.

---

<!-- _class: checkpoint -->

## 🏋️ Exercícios da aula

Na pasta `aula-14/`:

1. **`ex01.md`** — seis dependências: valem? e qual pergunta você faria para confirmar;
2. **`ex02.md`** — a tabela de palestrantes está em 1FN? reescreva o que for preciso;
3. **`ex03.md`** — liste as DFs de `EMPRESTIMO_DETALHE`, marque as parciais e diga a forma normal.

---

<!-- _class: lead -->

## ➡️ Próxima aula

**Aula 15 — Aplicando a 1FN e a 2FN**

Da tabela única às quatro tabelas,
passo a passo — conferindo
que nada se perdeu no caminho.
