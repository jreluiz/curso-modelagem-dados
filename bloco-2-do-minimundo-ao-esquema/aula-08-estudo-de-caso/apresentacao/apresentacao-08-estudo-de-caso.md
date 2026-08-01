---
marp: true
theme: trilha
paginate: true
lang: pt-BR
footer: '🗄️ Curso de Modelagem de Dados · Aula 08'
---

<!-- _class: capa -->

<div class="emoji">🏛️</div>

# Estudo de Caso

## Aula 08 · Bloco 2 — Do Minimundo ao Esquema

<div class="meta">Do minimundo ao esquema pronto, em seis passos</div>

---

## 🎯 Nesta aula

1. O caso **inteiro**, de uma vez
2. O **roteiro em seis passos**
3. As **três decisões** que definiram o modelo
4. O **resultado** — 13 tabelas
5. Os **cinco erros clássicos**
6. **Validar** com o cliente

---

<!-- _class: lead -->

## 📏 Repare no tamanho do enunciado

Sete parágrafos.
Oito regras de negócio.

Um minimundo de estudo que precisa
de três páginas não é mais profundo —
é **mal recortado**.

A profundidade vem da discussão,
e discutir exige que sobre atenção.

---

<!-- _class: tabela-densa -->

## O roteiro em seis passos

| # | O que fazer | Entregável |
|:---:|---|---|
| 1 | **Recortar** | lista de exclusões justificadas |
| 2 | **Grifar** substantivos e verbos | três listas de candidatos |
| 3 | **Decidir** entidade × atributo | entidades com seus atributos |
| 4 | **Perguntar** ao cliente | perguntas + o que cada resposta mudou |
| 5 | **Desenhar** e ler em voz alta | DER + o parágrafo do que ele afirma |
| 6 | **Mapear e conferir** | esquema + regras que não couberam |

---

<!-- _class: lead -->

## ⚠️ O passo 4 é o que todo mundo pula

Modelo feito sem perguntar
é modelo que responde ao que **você** imaginou,

não ao que o cliente faz.

---

## As três decisões que definiram este modelo

**Obra ≠ exemplar.** *"Vocês emprestam o título ou o volume físico?"* — separou uma entidade em duas.

**A reserva é da obra, não do exemplar.** O usuário quer *o livro*; qualquer cópia serve.

**`categoria` é atributo, não entidade.** Três valores fixos, nada a guardar dentro.

> 💡 As três são respostas a **perguntas**, não deduções do texto.

---

## O resultado

```
erDiagram
    USUARIO ||--o{ EMPRESTIMO : "toma emprestado"
    EXEMPLAR ||--o{ EMPRESTIMO : "é objeto de"
    EMPRESTIMO ||--o{ RENOVACAO : "é prorrogado por"
    EMPRESTIMO ||--o| MULTA : "gera"
    OBRA ||--o{ EXEMPLAR : "tem cópias físicas"
    USUARIO ||--o{ RESERVA : "solicita"
    OBRA ||--o{ RESERVA : "é reservada em"
```

**10 entidades + 1 multivalorado + 2 N:M → 13 tabelas.**

---

## Erro 1 — O atributo promovido a entidade

```
✗ SITUACAO(cod, descricao)  — quatro linhas e nada mais
  EXEMPLAR(tombo, isbn, cod_situacao)

✅ EXEMPLAR(tombo, isbn, situacao)
```

Uma junção a mais em toda consulta, e nenhuma pergunta nova respondida.

---

## Erro 2 e 3 — O N:M invisível e a FK do lado errado

```
✗ OBRA(isbn, titulo, matricula_reservou)   ← quebra na segunda reserva
✅ RESERVA(id_reserva, matricula, isbn, ...)

✗ OBRA(isbn, titulo, tombo)                ← quebra no segundo exemplar
✅ EXEMPLAR(tombo, isbn, ...)
```

A cura dos dois é a mesma: **pergunte nas duas direções, sempre no plural**.

---

## Erro 4 e 5 — O dado repetido e o ciclo redundante

```
✗ EMPRESTIMO(id, matricula, nome_usuario, tombo, retirada)
                            ‾‾‾‾‾‾‾‾‾‾‾‾ dependência transitiva

✗ EMPRESTIMO(id, tombo, isbn, ...)
                        ‾‾‾‾ o exemplar já determina a obra
```

O ciclo permite a contradição: um empréstimo cujo `isbn` não é o da obra do `tombo`.

---

<!-- _class: lista-limpa -->

## Validar com o cliente

- 🗣️ **Leia frases, não desenhos** — "um empréstimo é de um exemplar só" o bibliotecário sabe julgar; um losango, não;
- 🎲 **Traga casos estranhos** — "e se o aluno perder o livro?". É no caso raro que o modelo quebra;
- 📝 **Anote o que o modelo não faz** — todo "isso a gente resolve na mão" vira uma regra escrita, com data e nome.

---

<!-- _class: lead -->

## 📏 A regra do curso, e do mercado

Todo modelo vem acompanhado
da **justificativa por escrito**.

Um diagrama sem argumento
é um chute bem desenhado —

e some na primeira pergunta do cliente.

---

<!-- _class: checkpoint -->

## 🏋️ Exercícios da aula

Na pasta `aula-08/`:

1. **`ex01.md`** — percorra **os seis passos** num minimundo ⭐⭐;
2. **`ex02.md`** — ache os **cinco erros** num esquema de clínica;
3. **`ex03.md`** — defenda três decisões que poderiam ter sido outras;
4. **`ex04.md`** — revise o modelo de um colega, com o caso que quebra cada problema;
5. **Desafio 🌶️ `ex05.md`** — a Biblioteca com várias unidades: o que quebra?

---

<!-- _class: lead -->

## 🤝 Começa aqui o trabalho em dupla

Modelagem de um minimundo
revisada por **Pull Requests**.

Você já tem tudo de que precisa.

**Próxima aula:** 09 — Por que um SGBD existe
