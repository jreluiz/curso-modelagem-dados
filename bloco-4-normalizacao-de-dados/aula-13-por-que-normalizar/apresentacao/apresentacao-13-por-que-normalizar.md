---
marp: true
theme: trilha
paginate: true
lang: pt-BR
footer: '🗄️ Curso de Modelagem de Dados · Aula 13'
---

<!-- _class: capa -->

<div class="emoji">🧹</div>

# Por que Normalizar

## Aula 13 · Bloco 4 — Normalização de Dados

<div class="meta">A planilha volta, disfarçada de tabela</div>

---

## 🎯 Nesta aula

1. A tabela que **se contradiz de novo**
2. O que é **normalização**
3. Os **objetivos** — e o preço
4. O **panorama** das formas normais
5. Os **três sintomas** visíveis
6. Até onde normalizar

---

## Uma tabela bem-comportada, com chave e tudo

```
   INSCRICAO
   ┌────────┬───────────┬────────────┬───────┬──────────────────┬──────┐
   │ cod_ev │ matricula │ nome_aluno │ curso │ titulo_evento    │ c.h. │
   ├────────┼───────────┼────────────┼───────┼──────────────────┼──────┤
   │  101   │  2023101  │ Ana Souza  │ ADS   │ Pesquisa em base │  4   │
   │  101   │  2023102  │ Bruno Lima │ ADS   │ Pesquisa em base │  4   │
   │  103   │  2023101  │ Ana Sousa  │ ADS   │ Escrita técnica  │  3   │
   └────────┴───────────┴────────────┴───────┴──────────────────┴──────┘
```

**"Ana Sousa"** na última linha. Você já viu esse filme na Aula 01.

---

## As três anomalias, de volta

- **Alteração** — mudou o título do evento 101? Duas linhas para corrigir;
- **Inserção** — evento novo, ainda sem inscritos, **não cabe**;
- **Exclusão** — cancelou a última inscrição do 102? Some o evento junto.

> ⚠️ **Isto acontece com um DER bem-feito.** Por pressa, por "assim vejo tudo numa tela", ou porque a conversão da Aula 12 saiu assim e ninguém revisou.

---

## O que é normalização

**Decompor** esquemas de tabela em esquemas menores, eliminando a **redundância que causa anomalia**, **sem perder informação**.

- **Decompor** — uma tabela vira duas ou mais, ligadas por chave;
- **Redundância que causa anomalia** — não é toda repetição;
- **Sem perder informação** — remontando, você obtém as linhas de antes.

---

<!-- _class: lead -->

## E três coisas que ela não é

**Não é apagar dado** — ele muda de endereço.

**Não é fazer tabelas pequenas por gosto** —
o critério é a anomalia.

**Não é otimização** — o ganho é de consistência.

---

<!-- _class: tabela-densa -->

## Os objetivos, e o preço

| Objetivo | Na prática |
|---|---|
| **Eliminar anomalias** | inserir, alterar e apagar param de contradizer |
| **Guardar cada fato uma vez** | acaba o "qual das duas cópias é a verdadeira" |
| **Esquema estável** | mudança de regra mexe numa tabela, não em cinco |

**O preço:** mais tabelas, e é preciso juntá-las para ver o todo.

---

<!-- _class: lead -->

## ⚠️ O preço é pago uma vez

A anomalia cobra **para sempre**.

Juntar tabelas é trabalho previsível.
Descobrir qual das duas grafias é a certa,
dois anos depois, é impossível.

---

## A escada das formas normais

```
   1FN  ──▶  2FN  ──▶  3FN  ──▶  BCNF  ──▶  4FN  ──▶  5FN
    │         │         │         │          │
    │         │         │         │          └─ duas listas independentes
    │         │         │         └─ refinamento da 3FN (fora do curso)
    │         │         └─ atributo que depende de outro não-chave
    │         └─ atributo que depende de parte da chave
    └─ valor que não é atômico
```

São **cumulativas**: para estar na 3FN, já é preciso estar na 2FN e na 1FN.

---

## Os três sintomas que se veem a olho nu

```
   1. CÉLULA COM LISTA      "Marta Dias; Carlos Reis" numa coluna só
                            → 1FN, a mais fácil de ver

   2. BLOCO QUE SE REPETE   o mesmo trio idêntico em várias linhas
                            → 2FN ou 3FN — a chave decide qual

   3. COLUNA VAZIA EM MASSA metade da tabela com traço na mesma coluna
                            → costuma ser especialização (Aula 11)
```

O terceiro não se cura normalizando.

---

## Até onde normalizar

A pergunta não é *"qual é a forma normal mais alta?"* — é *"que anomalia ainda existe?"*.

Na prática, **a 3FN resolve a quase totalidade dos casos**.

E há um caso legítimo de andar para trás: a **desnormalização** do banco analítico, com três exigências — **medida**, **escrita** e **com dono**.

---

<!-- _class: lead -->

## ⚠️ Sem as três, é o erro da Aula 01 com nome bonito

A diferença entre "otimização" e "descuido"
não está no esquema resultante:
os dois são idênticos.

Está no que foi **decidido antes**.

---

<!-- _class: checkpoint -->

## 🏋️ Exercícios da aula

Na pasta `aula-13/`:

1. **`ex01.md`** — os grupos redundantes e as três anomalias, com exemplos da tabela;
2. **`ex02.md`** — cinco afirmações: verdadeira ou falsa, com justificativa;
3. **`ex03.md`** — responda ao argumento da secretaria em oito linhas.

---

<!-- _class: lead -->

## ➡️ Próxima aula

**Aula 14 — Dependência funcional, 1FN e 2FN**

"Se eu sei a matrícula, o que mais eu sei?"
A pergunta que organiza o bloco inteiro.
