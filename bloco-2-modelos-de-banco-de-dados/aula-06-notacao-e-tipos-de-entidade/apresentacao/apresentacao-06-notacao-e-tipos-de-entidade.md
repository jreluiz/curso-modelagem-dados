---
marp: true
theme: trilha
paginate: true
lang: pt-BR
footer: '🗄️ Curso de Modelagem de Dados · Aula 06'
---

<!-- _class: capa -->

<div class="emoji">📐</div>

# A Notação Gráfica e os Tipos de Entidade

## Aula 06 · Bloco 2 — Modelos de Banco de Dados

<div class="meta">Forma geométrica primeiro, nome depois</div>

---

## 🎯 Nesta aula

1. As **formas** da notação de Chen
2. Entidade **forte** e entidade **fraca**
3. O **relacionamento** e o que mora dentro dele
4. **Cardinalidade** — e a armadilha do lado
5. **Participação** — pode zero?

---

## Três formas para três conceitos

```
        (isbn)                              (cnpj)
           │                                   │
      ┌────────┐   1   ◇   N   ┌─────────────┐
      │ LIVRO  │───PUBLICADO───│   EDITORA   │
      └────────┘      _POR     └─────────────┘
           │
       (titulo)

   RETÂNGULO = entidade    LOSANGO = relacionamento    ELIPSE = atributo
```

Você lê o desenho de longe, **antes** de ler qualquer palavra.

---

## A obra e o volume físico

*"Banco de Dados"* é uma **obra**. A biblioteca tem **quatro cópias** dela na estante — e é uma cópia específica que o aluno leva para casa.

As cópias são numeradas **1, 2, 3, 4 dentro de cada obra**.

Não existe "o exemplar 3" sem dizer de qual obra.

---

## Entidade fraca: não se identifica sozinha

```
   ┌────────┐   1                     N   ╔════════════╗
   │ LIVRO  │─────── ◈ VOLUME_DE ◈ ══════ ║  EXEMPLAR  ║
   └────────┘                             ╚════════════╝

     ◈  losango duplo  →  relacionamento identificador
     ║  retângulo duplo →  entidade fraca
     ═  linha dupla     →  participação total
```

A chave completa é o par `(isbn, numero)` — o `numero` é **chave parcial**.

---

<!-- _class: lead -->

## ⚠️ Vínculo obrigatório não é fraqueza

Um `EMPRESTIMO` exige um aluno,
mas tem número próprio: é **forte**.

O teste: tire a entidade dona
e pergunte se a chave ainda identifica.

---

## O relacionamento pode ter atributos

A biblioteca precisa saber **a ordem em que os autores assinam** a obra.

```
   ┌────────┐   N   ◇   M   ┌────────┐
   │ AUTOR  │────ESCREVE────│ LIVRO  │
   └────────┘       │       └────────┘
                    │
            (ordem_assinatura)
```

Não é do livro nem do autor: é **da ligação entre os dois**.

---

<!-- _class: lead -->

## 💡 Atributo no losango é a assinatura de um N:M

A quantidade de um produto num pedido.
A data de inscrição de um atleta numa competição.
A ordem de um autor num livro.

Se você não acha onde pôr um dado,
ele é de uma ligação que você ainda não desenhou.

---

## Cardinalidade: quantos de cada lado

| Escreve-se | Lê-se | Exemplo |
|---|---|---|
| `1` e `1` | um para um | um exemplar, uma posição na estante |
| `1` e `N` | um para muitos | uma editora publica muitos livros |
| `N` e `M` | muitos para muitos | muitos autores, muitos livros |

O **1:N** é o caso mais comum. O **1:1** merece desconfiança.

---

<!-- _class: lead -->

## ⚠️ A armadilha do lado

O número encostado em `EDITORA`
diz **quantas editoras** entram na ligação.

Leia a frase inteira:
*"uma editora publica N livros"*.

---

## As duas perguntas, separadas

```
   "Um livro pode ter vários autores?"    → sim  ─┐
                                                  ├─▶  N:M
   "Um autor pode ter vários livros?"     → sim  ─┘

   "Um livro pode ter várias editoras?"   → não  ─┐
                                                  ├─▶  1:N
   "Uma editora pode ter vários livros?"  → sim  ─┘
```

Dez segundos, e a resposta **já é o diagrama**.

---

## Participação: pode zero?

- **Parcial** — a ocorrência existe sem participar. Aluno recém-matriculado ainda não pegou livro. Linha simples;
- **Total** — a ocorrência **não existe** fora da ligação. Todo exemplar é de alguma obra. Linha dupla `═══`.

> 💡 **"Quantos" decide de que lado a ligação vira coluna. "Pode zero" decide se essa coluna aceita ficar vazia.**

---

<!-- _class: checkpoint -->

## 🏋️ Exercícios da aula

Na pasta `aula-06/`:

1. **`ex01.md`** — oito frases lendo o DER nas duas direções, marcando as participações totais;
2. **`ex02.md`** — ache os dois erros do modelo da sala de estudos e corrija;
3. **`ex03.md`** — desenhe a reserva de salas em Mermaid, com cardinalidade e participação.

---

<!-- _class: lead -->

## ➡️ Próxima aula

**Aula 07 — Do relacional à integridade referencial**

O losango vira coluna,
e o banco passa a recusar
o que o mundo não permite.
