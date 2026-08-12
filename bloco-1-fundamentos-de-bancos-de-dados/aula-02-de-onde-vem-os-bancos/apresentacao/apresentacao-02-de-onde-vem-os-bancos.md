---
marp: true
theme: trilha
paginate: true
lang: pt-BR
footer: '🗄️ Curso de Modelagem de Dados · Aula 02'
---

<!-- _class: capa -->

<div class="emoji">🕰️</div>

# De Onde Vêm os Bancos de Dados

## Aula 02 · Bloco 1 — Fundamentos de Bancos de Dados

<div class="meta">Sessenta anos de tentativas, e a ideia que ficou</div>

---

## 🎯 Nesta aula

1. Antes do banco: **o programa que sabia tudo**
2. **Hierárquico** e **rede**
3. **1970** — Codd e o modelo relacional
4. Depois do relacional: **objeto-relacional** e **NoSQL**
5. Os principais **SGBD** de hoje
6. **Política de segurança** de um banco

---

## Anos 1960: cada sistema com seu arquivo

```
   EMPRÉSTIMOS ──▶ arquivo-alunos-biblioteca
   SECRETARIA  ──▶ arquivo-alunos-secretaria
   TESOURARIA  ──▶ arquivo-alunos-financeiro
```

Três arquivos, os mesmos alunos, **três verdades possíveis**.

- **Redundância entre sistemas** — muda o endereço num, não muda no outro;
- **Dependência de formato** — campo novo obriga a recompilar tudo;
- **Sem controle de acesso** e **sem controle de simultaneidade**.

---

<!-- _class: lead -->

## 💡 Os quatro problemas são as quatro garantias

...da Aula 01, ditas ao contrário.

A história dos bancos de dados
é a história de resolver estes quatro,
um de cada vez.

---

## Hierárquico e rede: ligar por ponteiros

```
   HIERÁRQUICO — um pai só        REDE — vários pais
   ┌──────────┐                   ┌──────────┐  ┌──────────┐
   │  CURSO   │                   │ TURMA A  │  │ TURMA B  │
   └────┬─────┘                   └────┬─────┘  └────┬─────┘
   ┌────▼─────┐                        └────┬────────┘
   │  TURMA   │                        ┌────▼─────┐
   └────┬─────┘                        │  ALUNO   │
   ┌────▼─────┐                        └──────────┘
   │  ALUNO   │                   o mesmo aluno em duas turmas
   └──────────┘
```

O aluno em duas turmas **não tem um pai: tem dois**.

---

<!-- _class: lead -->

## ⚠️ Os dois cobraram caro

O **caminho até o dado** ficava
escrito dentro do programa.

Mudou a estrutura, quebrou o programa.

---

## 1970: Codd e o modelo relacional

```
   ALUNO                          EMPRESTIMO
   ┌───────────┬────────────┐     ┌───────────┬───────────┐
   │ matricula │ nome       │     │ n_emprest │ matricula │
   ├───────────┼────────────┤     ├───────────┼───────────┤
   │  2023101  │ Ana Souza  │◀────│   1001    │  2023101  │
   └───────────┴────────────┘     └───────────┴───────────┘
        a ligação é o valor aparecer nos dois lados
```

O programa diz **o que** quer; o SGBD decide **como** buscar.

É essa separação que fez o modelo vencer — e ele domina até hoje.

---

<!-- _class: tabela-densa -->

## A história em cinco linhas

| Década | Modelo | A ideia central |
|:---:|---|---|
| 1960 | Arquivos isolados | cada sistema com o seu arquivo |
| 1960–70 | Hierárquico | árvore, um pai por registro |
| 1970 | Rede | grafo, vários pais por registro |
| 1970– | **Relacional** | tabelas ligadas por valores iguais |
| 2009– | NoSQL | abre mão de garantias para distribuir |

---

<!-- _class: lead -->

## ⚠️ NoSQL não substituiu o relacional

E o nome engana:
não é "sem SQL", é *not only SQL*.

São ferramentas para problemas diferentes.

---

<!-- _class: tabela-densa -->

## Os principais SGBD hoje

| SGBD | Licença | Onde aparece |
|---|---|---|
| **PostgreSQL** | livre | o mais completo dos livres |
| **MySQL / MariaDB** | livre | web e hospedagem |
| **SQLite** | livre | embutido, sem servidor |
| **Oracle** | proprietária | corporações, bancos, governo |
| **SQL Server** | proprietária | infraestrutura Microsoft |

Critérios: **licença**, **porte**, **o que a equipe sabe operar**.

---

## Política de segurança: três pilares

- **Autenticação** — *"você é quem diz ser?"* Uma vez, na entrada;
- **Autorização** — *"você pode fazer isso?"* A cada operação;
- **Auditoria** — *"quem fez isso, e quando?"* Não impede; permite descobrir.

> ⚠️ Estar autenticado **não dá direito a nada**. Confundir as duas primeiras é como um usuário comum acaba apagando o que não devia.

---

## Menor privilégio, na biblioteca

| Perfil | Pode alterar | Nunca pode |
|---|---|---|
| Aluno | nada | ver empréstimo de outro aluno |
| Atendente | empréstimo e devolução | apagar histórico |
| Chefe | acervo e empréstimos | apagar histórico |

**Ninguém apaga o histórico, nem o chefe.** Corrige-se com um novo registro.

---

<!-- _class: checkpoint -->

## 🏋️ Exercícios da aula

Na pasta `aula-02/`:

1. **`ex01.md`** — associe seis características aos cinco modelos e às décadas;
2. **`ex02.md`** — escolha o SGBD para três cenários, justificando por licença, porte ou instalação;
3. **`ex03.md`** — escreva a política de segurança com um quarto perfil: o estagiário.

---

<!-- _class: lead -->

## ➡️ Próxima aula

**Aula 03 — Os elementos de um banco de dados**

Os nomes das coisas que você já está vendo —
e o primeiro diagrama do curso.
