---
marp: true
theme: trilha
paginate: true
lang: pt-BR
footer: '🗄️ Curso de Modelagem de Dados · Aula 05'
---

<!-- _class: capa -->

<div class="emoji">🌍</div>

# O Minimundo e o DER

## Aula 05 · Bloco 2 — Do Minimundo ao Esquema

<div class="meta">Um texto em português vira um diagrama</div>

---

## 🎯 Nesta aula

1. O **minimundo** — a parte da realidade que entra
2. **Substantivos e verbos**, a primeira leitura
3. **Entidade ou atributo?** O teste que decide
4. O diagrama em **Mermaid**
5. Dizendo **"quantos"** e **"pode zero"**
6. As **perguntas** que faltam ao cliente

---

## O que chega até você

> *"A biblioteca central atende usuários vinculados à universidade, identificados pela matrícula, com nome, e-mail e a data em que se cadastraram. Um usuário pode informar vários telefones, cada um com um tipo."*

Um parágrafo escrito por alguém que entende de **biblioteca**, não de banco de dados.

Transformar isso em tabelas é o trabalho.

---

<!-- _class: lead -->

## 📏 O primeiro passo não é modelar — é recortar

Uma biblioteca tem iluminação,
contrato de limpeza, goteira no telhado
e um gato que dorme na recepção.

Nada disso entra.

E o que ficou de fora
ficou **por decisão**, não por esquecimento —
então **escreva a lista**.

---

## Substantivos e verbos

```
A biblioteca atende USUÁRIOS vinculados à universidade, identificados
                    ~~~~~~~~
pela MATRÍCULA, com NOME, E-MAIL e a DATA em que se cadastraram.
     ‾‾‾‾‾‾‾‾‾      ‾‾‾‾  ‾‾‾‾‾‾    ‾‾‾‾
Um usuário pode INFORMAR vários TELEFONES, cada um com um TIPO.
                ~~~~~~~~        ~~~~~~~~~                 ‾‾‾‾

~~~~  entidade ou relacionamento        ‾‾‾‾  atributo
```

> ⚠️ É truque de primeira leitura, não método. Linguagem natural mente.

---

## Entidade ou atributo? Duas perguntas

**1. Você guarda mais de um valor?**
Um usuário tem vários telefones → não cabe como coluna → é entidade.

**2. A coisa tem propriedades próprias?**
O telefone tem `tipo`. Se fosse só o número, e um só, seria coluna.

---

<!-- _class: lead -->

## ⚠️ O erro mais comum de quem começa

Uma tabela `CATEGORIA` com três linhas —
aluno, professor, servidor —
e nada além de código e nome.

Isso não é entidade.
É **atributo com domínio restrito**.

*"Vocês algum dia vão querer guardar
mais alguma coisa sobre isso?"*

---

## O diagrama em Mermaid

```
erDiagram
    USUARIO ||--o{ TELEFONE : "informa"

    USUARIO {
        char9 matricula PK
        varchar nome
        varchar categoria
    }
```

---

<!-- _class: lista-limpa -->

## Três coisas que se repetem em todo diagrama

- 🔠 **Nome da entidade em maiúsculas**, sem espaço nem acento — `ITEM_PEDIDO`, nunca `Item Pedido`;
- 🔑 **`PK`, `FK` e `UK`** marcam chave primária, estrangeira e única;
- 🏷️ **O rótulo é obrigatório** — sem os dois-pontos e o texto entre aspas, não renderiza.

---

## O símbolo guarda as duas respostas

```
              ||--o{
              ‾‾  ‾‾
              │    └── direita: mín 0, máx N → "zero ou vários"
              └─────── esquerda: mín 1, máx 1 → "um e apenas um"
```

| Peça | `\|\|` | `\|o` | `}\|` | `}o` |
|:---:|:---:|:---:|:---:|:---:|
| **Mínimo** | 1 | 0 | 1 | 0 |
| **Máximo** | 1 | 1 | N | N |

---

<!-- _class: lead -->

## 📏 Todo diagrama vem com um parágrafo

O desenho mostra a **forma**.

O texto carrega o **compromisso**.

*"Um usuário informa zero ou muitos telefones;
todo telefone pertence a exatamente um usuário."*

---

<!-- _class: lista-limpa -->

## As perguntas que sempre valem

- 🔢 **"Pode ter mais de um?"** — separa atributo de entidade;
- ⭕ **"Pode não ter nenhum?"** — decide se a coluna é obrigatória;
- ⏳ **"Isso muda com o tempo? Precisam do histórico?"** — a que mais destrói modelos quando é feita tarde;
- 🎯 **"Vocês emprestam o título ou o volume físico?"** — a pergunta específica deste domínio. Todo domínio tem a sua.

---

<!-- _class: checkpoint -->

## 🏋️ Exercícios da aula

Na pasta `aula-05/`:

1. **`ex01.md`** — o **recorte** de um minimundo, com 4 exclusões justificadas;
2. **`ex02.md`** — grife substantivos e verbos, e **derrube** um candidato de cada lista;
3. **`ex03.md`** — o DER em Mermaid, com 4 entidades e o parágrafo do que ele afirma;
4. **`ex04.md`** — 6 perguntas ao cliente, e o que muda no diagrama conforme a resposta;
5. **Desafio 🌶️ `ex05.md`** — um atributo que vira entidade, e uma entidade que vira atributo.

---

<!-- _class: lead -->

## ➡️ Próxima aula

**Aula 06 — Do DER às tabelas**

Banco de dados não conhece
losango, seta nem retângulo.

Cinco regras resolvem a tradução.
