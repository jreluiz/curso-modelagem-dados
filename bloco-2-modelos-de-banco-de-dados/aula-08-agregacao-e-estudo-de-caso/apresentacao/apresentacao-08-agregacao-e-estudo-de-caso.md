---
marp: true
theme: trilha
paginate: true
lang: pt-BR
footer: '🗄️ Curso de Modelagem de Dados · Aula 08'
---

<!-- _class: capa -->

<div class="emoji">📦</div>

# Agregação e Estudo de Caso

## Aula 08 · Bloco 2 — Modelos de Banco de Dados

<div class="meta">Quando a ligação vira uma coisa</div>

---

## 🎯 Nesta aula

1. O relacionamento que **precisa se relacionar**
2. **Agregação** — tratar a ligação como uma coisa
3. A alternativa: **entidade associativa**
4. Estudo de caso — o **minimundo** e as regras
5. Estudo de caso — o **diagrama** e o esquema
6. O **ritual de leitura** do modelo

---

## A biblioteca empresta salas de estudo

```
   ALUNO ──N── RESERVA ──M── SALA          e a reserva tem data_hora
```

Regra nova do balcão: *"o aluno pode requisitar um projetor **para aquela reserva**"*.

- Ligar ao `ALUNO`? Ele reserva quatro salas por semana;
- Ligar à `SALA`? O projetor não é da sala, é levado até ela;
- Dois relacionamentos separados? Permite a **combinação impossível**.

---

## O modelo que aceita o impossível

```
   ┌──────────────┐  N        1 ┌────────┐  N       M ┌────────┐
   │ EQUIPAMENTO  │──USA────────│ ALUNO  │──RESERVA───│  SALA  │
   └──────┬───────┘             └────────┘            └────┬───┘
          │  N                                             │ 1
          └──────────────── EM ─────────────────────────────┘
```

O projetor ligado à Ana **e** à sala 204,
sem que exista reserva nenhuma da Ana para a 204.

---

## Agregação: a caixa em volta

```
   ┌─────────────────────────────────────┐
   │  ALUNO ──N── RESERVA ──M── SALA     │  ← USO_DA_SALA
   │                 │                   │
   │            (data_hora)              │
   └──────────────┬──────────────────────┘
                  │ 1
             REQUISITA ──N── EQUIPAMENTO
```

O que está na caixa é **uma unidade**: *este aluno, nesta sala, neste horário*.

---

<!-- _class: lead -->

## 💡 O teste que identifica uma agregação

*"O que está do outro lado se liga a uma
das entidades, ou ao **encontro** delas?"*

A prescrição que sai de uma consulta.
O pagamento de uma matrícula num curso.
O equipamento de uma reserva.

---

## A alternativa: entidade associativa

```
   RESERVA(codigo, data_hora, matricula → ALUNO, cod_sala → SALA)
   REQUISICAO(codigo → RESERVA, patrimonio → EQUIPAMENTO)
```

| | Agregação | Entidade associativa |
|---|---|---|
| Onde vive | modelo **conceitual** | modelo **lógico** |
| O que preserva | que aquilo **é** uma ligação | a facilidade de referenciar |

Toda agregação **vira** tabela associativa na conversão.

---

## Estudo de caso: o minimundo

> A biblioteca controla o acervo e os empréstimos. O acervo é formado por **obras**, e de cada obra há um ou mais **exemplares** físicos, numerados dentro da obra. Uma obra tem ISBN, título, ano e uma editora; é escrita por um ou mais autores, e a **ordem de assinatura** importa. Os alunos retiram exemplares por quinze dias. O histórico é mantido para sempre.

---

## As regras numeradas

```
   RN-01  Uma obra é publicada por exatamente uma editora.
   RN-02  Uma obra tem um ou mais autores, com ordem de assinatura.
   RN-03  Uma obra tem zero ou mais exemplares no acervo.
   RN-04  Um exemplar pertence a uma obra e é numerado dentro dela.
   RN-05  Um empréstimo refere-se a exatamente um exemplar.
   RN-06  Um empréstimo pertence a exatamente um aluno.
   RN-08  O prazo padrão é de quinze dias.       ← não vira desenho
   RN-09  Empréstimo devolvido fica no histórico. ← não vira desenho
```

---

<!-- _class: tabela-densa -->

## Cada traço aponta para uma regra

| Trecho do diagrama | Regra | Decisão |
|---|:---:|---|
| `ESCREVE` N:M com `ordem` no losango | RN-02 | a ordem é do par |
| linha dupla em `LIVRO` no `PUBLICADO_POR` | RN-01 | toda obra tem editora |
| `EXEMPLAR` com retângulo duplo | RN-04 | entidade fraca |
| linha simples em `LIVRO` no `VOLUME_DE` | RN-03 | obra sem exemplar existe |

---

## O esquema lógico completo

```
   ALUNO(matricula, nome, email)
   EDITORA(cnpj, nome, cidade)
   AUTOR(cpf, nome, nacionalidade)
   LIVRO(isbn, titulo, ano, cnpj → EDITORA)
   ESCREVE(cpf → AUTOR, isbn → LIVRO, ordem)
   EXEMPLAR(isbn → LIVRO, numero_ex, situacao)
   EMPRESTIMO(numero, data_retirada, data_devolucao,
              matricula → ALUNO, isbn + numero_ex → EXEMPLAR)
```

---

## O ritual de leitura: quatro perguntas

1. **Leia cada linha nas duas direções.** A frase é verdade no minimundo?
2. **Invente três ocorrências reais** e tente guardá-las;
3. **Tente inserir e apagar** — o que não cabe? O que some sem querer?
4. **Procure o mesmo dado em dois lugares.**

> ⚠️ Este modelo passa nas quatro e **ainda tem um furo conhecido**: nada impede dois empréstimos em aberto do mesmo exemplar.

---

<!-- _class: lead -->

## Modelo bom não é o sem furo

É o que **sabe onde estão os seus furos** —
e os deixa por escrito.

---

<!-- _class: checkpoint -->

## 🏋️ Exercícios da aula

Na pasta `aula-08/`:

1. **`ex01.md`** — quatro situações: exige agregação ou relacionamento comum?
2. **`ex02.md`** — converta a agregação em esquema lógico e escolha a política de exclusão;
3. **`ex03.md`** — **autoral**: um minimundo ⭐⭐ do catálogo, do texto ao esquema.

---

<!-- _class: lead -->

## ➡️ Próxima aula

**Aula 09 — Como se conduz uma modelagem**

Trinta frases, dezoito substantivos,
uma folha em branco.
Por onde se começa?
