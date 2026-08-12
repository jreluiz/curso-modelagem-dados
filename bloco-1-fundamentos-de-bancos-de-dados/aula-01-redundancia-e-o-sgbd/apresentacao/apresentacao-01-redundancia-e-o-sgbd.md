---
marp: true
theme: trilha
paginate: true
lang: pt-BR
footer: '🗄️ Curso de Modelagem de Dados · Aula 01'
---

<!-- _class: capa -->

<div class="emoji">🧾</div>

# A Redundância e a Resposta do SGBD

## Aula 01 · Bloco 1 — Fundamentos de Bancos de Dados

<div class="meta">Por que a planilha da biblioteca acaba mentindo</div>

---

## 🎯 Nesta aula

1. A planilha que **se contradiz**
2. **Redundância** — o dado escrito duas vezes
3. As **três anomalias**
4. O que é um **banco de dados**
5. O que é um **SGBD**
6. As **quatro garantias** — e o que elas não cobrem

---

## A biblioteca controla empréstimos numa planilha

```
┌───────────┬───────────┬────────────┬───────┬────────────────────────┐
│ n_emprest │ matricula │ nome_aluno │ tombo │ titulo_livro           │
├───────────┼───────────┼────────────┼───────┼────────────────────────┤
│   1001    │  2023101  │ Ana Souza  │ 4417  │ Banco de Dados         │
│   1002    │  2023101  │ Ana Souza  │ 4418  │ Engenharia de Software │
│   1003    │  2023102  │ Bruno Lima │ 4417  │ Banco de Dados         │
│   1004    │  2023101  │ Ana Sousa  │ 4420  │ Redes de Computadores  │
└───────────┴───────────┴────────────┴───────┴────────────────────────┘
```

Funciona — até a linha **1004**.

---

<!-- _class: lead -->

## O erro de digitação não é o problema

O problema é que o nome da Ana
está escrito **três vezes**.

Todo dado repetido é uma oportunidade
de discordar de si mesmo.

---

## Repetição legítima × redundância

**Repetição legítima** — a matrícula `2023101` em três empréstimos.
São três empréstimos da mesma pessoa. A informação é essa.

**Redundância** — o **nome** "Ana Souza" três vezes.
O nome não é informação sobre o empréstimo.

> ⚠️ A pergunta que separa as duas:
> **"se isto mudar, quantos lugares eu preciso alterar?"**

---

<!-- _class: tabela-densa -->

## As três anomalias

| Anomalia | Quando aparece | O que dá errado |
|---|---|---|
| **Alteração** | ao mudar um dado repetido | algumas cópias mudam, outras não |
| **Inserção** | ao cadastrar algo sem par | não há onde guardar, a não ser inventando |
| **Exclusão** | ao apagar um registro | some junto o que ninguém mandou apagar |

Livro novo, ainda não emprestado: **não cabe** na planilha.

---

<!-- _class: lead -->

## ⚠️ As três têm a mesma causa

A planilha guarda coisas de
**naturezas diferentes** na mesma linha.

Aluno, livro e empréstimo
são três assuntos, amontoados em um.

---

## O que é um banco de dados

Coleção de dados **relacionados entre si**, com **significado**, organizada para servir a **vários usuários e programas**.

Cada pedaço exclui alguma coisa:

- **relacionados** — pasta com fotos e boletos não é banco de dados;
- **com significado** — a biblioteca guarda o ISBN, não a cor da capa;
- **vários usuários** — separa banco de "arquivo do meu programa".

---

## O que é um SGBD

```
   você / o programa
          ▼
   ┌─────────────┐
   │    SGBD     │ ← recebe pedidos, verifica regras, controla quem mexe
   └─────────────┘
          ▼
   ┌─────────────┐
   │   os dados  │ ← ninguém toca aqui diretamente
   └─────────────┘
```

Todo acesso passa por **um lugar só**. É a ideia inteira.

---

<!-- _class: lead -->

## ⚠️ São três coisas diferentes

**Banco de dados** — os dados
**SGBD** — o programa que os gerencia
**Aplicação** — o sistema da biblioteca

Dizer "instalei um banco de dados"
quando se instalou um SGBD
é o deslize mais comum da área.

---

## As quatro garantias

- **Integridade** — empréstimo para matrícula inexistente não entra;
- **Acesso concorrente** — duas pessoas no último exemplar: uma recebe "não há";
- **Segurança** — cada um enxerga e altera só o que lhe compete;
- **Recuperação** — energia caiu no meio: volta a um estado coerente.

Nenhuma das quatro é sobre **velocidade**.

---

## O que o SGBD não resolve sozinho

- **Não elimina a redundância.** Ele obedece ao modelo que você desenhar;
- **Não sabe o que é verdade** no seu mundo — só as regras declaradas;
- **Não conserta dado que já entrou errado.**

> 💡 Um SGBD excelente sobre um modelo ruim
> é uma planilha cara: os mesmos três problemas, agora com backup.

---

<!-- _class: checkpoint -->

## 🏋️ Exercícios da aula

Na pasta `aula-01/`:

1. **`ex01.md`** — liste os valores redundantes e prove as três anomalias na planilha;
2. **`ex02.md`** — separe a planilha em três tabelas por assunto, dizendo o que cada separação resolveu;
3. **`ex03.md`** — explique as quatro garantias ao diretor, uma frase concreta para cada.

---

<!-- _class: lead -->

## ➡️ Próxima aula

**Aula 02 — De onde vêm os bancos de dados**

Como se chegou até aqui: arquivos soltos,
árvores, redes — e a ideia de 1970
que continua de pé.
