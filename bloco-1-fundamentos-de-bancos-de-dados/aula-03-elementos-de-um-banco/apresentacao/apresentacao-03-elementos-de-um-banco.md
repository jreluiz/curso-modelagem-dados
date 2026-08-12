---
marp: true
theme: trilha
paginate: true
lang: pt-BR
footer: '🗄️ Curso de Modelagem de Dados · Aula 03'
---

<!-- _class: capa -->

<div class="emoji">🧱</div>

# Os Elementos de um Banco de Dados

## Aula 03 · Bloco 1 — Fundamentos de Bancos de Dados

<div class="meta">Os nomes das coisas que você já está vendo</div>

---

## 🎯 Nesta aula

1. Os **cinco elementos** de uma tabela
2. **Entidade** — o que merece ser uma
3. **Atributo** e seus **quatro tipos**
4. O que **não** é entidade
5. O **processo de modelagem** em quatro etapas

---

## Cinco nomes para cinco coisas

```
   LIVRO
   ┌───────────────┬────────────────────────┬──────┬────────────┐
   │ isbn          │ titulo                 │ ano  │ aquisicao  │
   ├───────────────┼────────────────────────┼──────┼────────────┤
   │ 978-8535212   │ Banco de Dados         │ 2019 │ 2024-02-10 │
   │ 978-8521637   │ Engenharia de Software │ 2021 │ 2024-02-10 │
   └───────────────┴────────────────────────┴──────┴────────────┘
```

**Tabela** (relação) · **Linha** (tupla) · **Coluna** · **Valor** · **Domínio**

---

<!-- _class: lead -->

## 💡 O domínio é o mais útil dos cinco

É a primeira regra que o banco
pode verificar por você.

Se o domínio de `ano` são inteiros,
`mil novecentos` não entra —
e ninguém escreveu código para isso.

---

## Entidade: o teste das três perguntas

Coisa do mundo, distinguível, sobre a qual se guarda informação.

1. **Ela se distingue?**
2. **Tem mais de uma característica própria?**
3. **Alguém vai querer guardar algo sobre ela no futuro?**

Precisa passar nas **três**.

---

<!-- _class: tabela-densa -->

## Aplicando às candidatas da biblioteca

| Candidata | Distingue? | Mais de uma característica? | Vai crescer? | Veredito |
|---|:---:|:---:|:---:|---|
| `EDITORA` | sim | sim: cidade, site, contato | sim | **entidade** |
| `SITUACAO` | sim | não, só a descrição | não | **atributo** |
| `EMPRESTIMO` | sim | sim: datas, aluno, exemplar | sim | **entidade** |

Convenção do curso: **maiúsculas e singular** — `LIVRO`, não `livros`.

---

## Atributo: os quatro tipos

- **Simples** — um valor, indivisível para o propósito. `ano`, `isbn`;
- **Composto** — divide-se em partes que fazem sentido. `titulo`, `endereco`;
- **Multivalorado** — vários valores ao mesmo tempo. Os autores de um livro;
- **Derivado** — não se guarda, se **calcula**. Anos no acervo.

Em Chen, **cada tipo tem um desenho** — você reconhece pela forma.

---

## O primeiro diagrama do curso

```
        (isbn)          ← sublinhado: identifica
           │
      ┌────────┐        ((autores))  ← contorno duplo: multivalorado
      │ LIVRO  │────────
      └────────┘        (( anos ))   ← tracejado: derivado
           │
        (titulo)
        /      \
  (principal) (subtitulo)   ← composto
```

O desenho diz o tipo **antes** de você ler o nome.

---

<!-- _class: lead -->

## ⚠️ Atributo derivado não se armazena

Guardar `anos_no_acervo` como coluna
significa que ele fica errado no dia seguinte.

**Guarde o que não dá para deduzir.**

---

## O erro mais comum: promover atributo a entidade

`SITUACAO`, com quatro ocorrências: disponível, emprestado, em manutenção, extraviado.

Não passa no teste: **não tem característica própria** e ninguém vai pendurar nada nela. É um **atributo com domínio restrito**.

> 💡 O contrário também acontece, e é pior: `TELEFONE` como atributo simples quando a biblioteca precisa do tipo, do horário e de quem atendeu.

---

## O processo de modelagem em quatro etapas

```
   1. REQUISITOS   ──▶  o que o cliente precisa guardar   (Aula 04)
   2. CONCEITUAL   ──▶  entidades, atributos, ligações    (Bloco 2)
   3. LÓGICO       ──▶  tabelas, chaves e ligações        (Bloco 2)
   4. FÍSICO       ──▶  tipos, índices, armazenamento     (fora do curso)
```

**A ordem não se inverte** — e cada etapa é independente da seguinte.

---

<!-- _class: lead -->

## ⚠️ A primeira etapa não tem desenho nenhum

É texto em português.

Quem pula direto para o diagrama
está adivinhando o que o cliente quer.

---

<!-- _class: checkpoint -->

## 🏋️ Exercícios da aula

Na pasta `aula-03/`:

1. **`ex01.md`** — classifique oito atributos nos quatro tipos, com justificativa;
2. **`ex02.md`** — ache os candidatos a entidade da sala de estudos e aplique as três perguntas;
3. **`ex03.md`** — desenhe `EXEMPLAR` em Mermaid, com cinco atributos e o parágrafo em português.

---

<!-- _class: lead -->

## ➡️ Próxima aula

**Aula 04 — Requisitos, OLTP e OLAP**

Você não decide isso sozinho no papel.
Decide **perguntando** — e há
perguntas melhores que outras.
