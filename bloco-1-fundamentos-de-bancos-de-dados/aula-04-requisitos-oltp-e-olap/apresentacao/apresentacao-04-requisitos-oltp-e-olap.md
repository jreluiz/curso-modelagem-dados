---
marp: true
theme: trilha
paginate: true
lang: pt-BR
footer: '🗄️ Curso de Modelagem de Dados · Aula 04'
---

<!-- _class: capa -->

<div class="emoji">⚖️</div>

# Requisitos, OLTP e OLAP

## Aula 04 · Bloco 1 — Fundamentos de Bancos de Dados

<div class="meta">As perguntas que revelam a estrutura escondida</div>

---

## 🎯 Nesta aula

1. Levantar requisitos é **fazer perguntas**
2. De onde vêm os requisitos — e o que cada fonte **esconde**
3. A primeira bifurcação: **operar ou analisar?**
4. **OLTP** e **OLAP**
5. O que fazer com as respostas

---

## Quatro perguntas que revelam a estrutura

O bibliotecário diz: *"o aluno pega o livro e devolve em quinze dias"*.

- **Quantos?** → decide a cardinalidade;
- **Pode zero?** → decide o que é obrigatório;
- **Precisa do histórico?** → decide se o dado é apagado ou preservado;
- **Quem pode ver?** → decide a política de segurança.

---

<!-- _class: lead -->

## ⚠️ "Quantos" e "pode zero" são duas perguntas

Um empréstimo tem no máximo um aluno
**e** obrigatoriamente um aluno.

São afirmações diferentes sobre o mundo,
e cada uma vira uma coisa diferente no diagrama.

---

<!-- _class: tabela-densa -->

## De onde vêm os requisitos

| Fonte | O que dá bem | O que esconde |
|---|---|---|
| **Entrevista** | as regras que a pessoa sabe explicar | o que ela faz sem perceber |
| **Documento** | os campos que existem de verdade | por que existem |
| **Sistema legado** | o comportamento real, testado | as decisões erradas |
| **Observação** | o passo que ninguém conta | leva tempo |

Nenhuma delas basta sozinha.

---

<!-- _class: lead -->

## 💡 A pergunta mais produtiva não está na lista

*"Me dá um exemplo de quando isso deu errado?"*

As exceções que o cliente lembra
são exatamente as regras
que ele esqueceu de contar.

---

## A primeira bifurcação

```
  "Preciso registrar o empréstimo      "Preciso saber quais assuntos foram
   enquanto o aluno espera."            mais procurados em 5 anos."

  → uma operação, agora, rápida        → pergunta sobre milhões de registros
  → escreve pouca coisa                → lê muito, não escreve nada
  → precisa estar certa na hora        → pode demorar alguns segundos
```

**Este banco existe para operar o dia a dia, ou para analisar o que já aconteceu?**

---

## OLTP — o banco que opera

- **Muitas operações curtas** — centenas por minuto, poucas linhas cada;
- **Escrita frequente** — insere, atualiza, corrige;
- **Dado atual** — este exemplar está emprestado ou não;
- **Modelo normalizado** — cada dado num lugar só;
- **Precisa estar certo na hora** — o aluno está no balcão.

---

## OLAP — o banco que analisa

- **Poucas consultas, cada uma pesada** — uma pergunta varre anos;
- **Leitura quase pura** — os dados entram em carga programada;
- **Dado histórico** — a série inteira, inclusive o encerrado;
- **Modelo desnormalizado de propósito**;
- **Pode demorar** — ninguém espera um relatório anual no balcão.

**Granularidade** — o nível de detalhe em que o dado é guardado.

---

<!-- _class: lead -->

## ⚠️ Desnormalizar em OLAP é decisão consciente

Ela só é legítima porque o dado analítico
**não é alterado**.

A anomalia de alteração da Aula 01
não acontece onde ninguém altera.

---

<!-- _class: tabela-densa -->

## Os dois, lado a lado

| | OLTP | OLAP |
|---|---|---|
| **Pergunta típica** | "este exemplar está disponível?" | "o que cresceu em 5 anos?" |
| **Operações** | muitas e curtas | poucas e longas |
| **Predomina** | escrita | leitura |
| **Recorte do tempo** | o estado de agora | a série histórica |
| **Modelo** | normalizado | desnormalizado |

Não são tecnologias: são **cargas de trabalho**.

---

## O que fazer com as respostas

```
   O CLIENTE DISSE                 VOCÊ ESCREVE

   "O aluno pega o livro     →   RN-01. Um empréstimo refere-se a
    e devolve em 15 dias."         exatamente um exemplar e um aluno.
                                 RN-02. Um aluno pode ter vários
                                   empréstimos simultâneos.
                                 RN-03. O prazo padrão é de 15 dias.
                                 RN-04. O devolvido fica no histórico.
```

Uma frase virou **quatro regras numeradas** — e a RN-04 não estava na fala.

---

<!-- _class: checkpoint -->

## 🏋️ Exercícios da aula

Na pasta `aula-04/`:

1. **`ex01.md`** — seis perguntas de levantamento sobre a regra da reserva;
2. **`ex02.md`** — classifique seis cenários em OLTP ou OLAP, citando a dimensão que decidiu;
3. **`ex03.md`** — **autoral**: escolha um minimundo ⭐ do catálogo e faça oito perguntas.

---

<!-- _class: lead -->

## ➡️ Próxima aula

**Aula 05 — Projeto de BD: conceitual, lógico e físico**

O mesmo empréstimo, escrito três vezes —
e quem precisa entender cada uma delas.
