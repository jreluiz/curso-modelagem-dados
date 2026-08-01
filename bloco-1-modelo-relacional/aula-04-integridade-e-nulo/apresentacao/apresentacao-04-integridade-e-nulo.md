---
marp: true
theme: trilha
paginate: true
lang: pt-BR
footer: '🗄️ Curso de Modelagem de Dados · Aula 04'
---

<!-- _class: capa -->

<div class="emoji">🛡️</div>

# Integridade e o Valor Nulo

## Aula 04 · Bloco 1 — O Modelo Relacional

<div class="meta">O que o banco recusa, e o que ele faz ao apagar</div>

---

## 🎯 Nesta aula

1. O que o banco **recusa**
2. As **quatro restrições** de integridade
3. O **valor nulo** e seus três significados
4. As **ações referenciais**

---

## Quatro tentativas, quatro recusas

| Tentativa | Por que o banco recusa |
|---|---|
| `ano_publicacao = 'mil e quinhentos'` | não é um ano |
| exemplar com `tombo` vazio | sem identificação |
| empréstimo para a matrícula `9999999` | esse aluno não existe |
| devolução anterior à retirada | o tempo não anda para trás |

São as **quatro restrições de integridade**.

---

<!-- _class: lead -->

## 💡 "O sistema não deixa" × "combinamos que ninguém faz"

A primeira é verificada
em toda escrita, sem falhar.

A segunda dura até a primeira pressa.

---

<!-- _class: lista-limpa -->

## As quatro restrições

- 🎨 **De domínio** — todo valor pertence ao domínio da coluna. Tipo **e** faixa de valores;
- 🔑 **De entidade** — a chave primária **nunca** é vazia e nunca repete;
- 🔗 **Referencial** — toda FK aponta para algo que **existe**, ou é vazia;
- 📋 **Semântica** — tudo o mais que precisa ser verdade no seu minimundo.

---

## Integridade referencial, desenhada

```
ALUNO                        EMPRESTIMO
┌───────────┬────────────┐   ┌───────────┬───────────┐
│ matricula │ nome       │   │ n_emprest │ matricula │
├───────────┼────────────┤   ├───────────┼───────────┤
│  2023101  │ Ana Souza  │◄──┤   1001    │  2023101  │ ✅ existe
│  2023102  │ Bruno Lima │◄──┤   1002    │  2023102  │ ✅ existe
└───────────┴────────────┘ ✗─┤   1003    │  9999999  │ ❌ VIOLA
                             └───────────┴───────────┘
```

É a restrição que impede o **registro órfão**.

---

## O nulo e seus três significados

`NULL` **não é** zero. **Não é** texto vazio. É a **ausência de valor**:

1. **Não se aplica** — `data_devolucao` de um empréstimo em aberto;
2. **Desconhecido** — o aluno tem telefone, ninguém anotou;
3. **Não informado** — o aluno se recusou a dar.

Os três são "vazio" para o banco. Para você, significam coisas incompatíveis.

---

<!-- _class: tabela-densa -->

## Nulo não é igual a nada — nem a si mesmo

| `A` | `B` | `A = B` |
|:---:|:---:|:---:|
| 5 | 5 | verdadeiro |
| 5 | 3 | falso |
| 5 | nulo | **desconhecido** |
| nulo | nulo | **desconhecido** |

E o filtro só aceita o que é **verdadeiro** — *desconhecido* é descartado junto com *falso*.

---

<!-- _class: lead -->

## 📏 A regra do curso sobre nulos

Declare **obrigatório** tudo que não tenha
um motivo **escrito** para ser opcional.

E **documente o significado**
de cada vazio que sobrar.

Na Biblioteca, `data_devolucao` vazia
significa exatamente uma coisa:
**empréstimo em aberto**.

---

<!-- _class: tabela-densa -->

## Ações referenciais: o que fazer ao apagar

| Ação | O que acontece com as linhas dependentes |
|---|---|
| **Recusar** | a operação falha e nada acontece — **o padrão** |
| **Em cascata** | apaga junto todas as que apontavam |
| **Esvaziar** | põe vazio na FK (exige coluna opcional) |

---

## Como escolher, na Biblioteca

| Relacionamento | Ação | Por quê |
|---|---|---|
| `EMPRESTIMO` → `ALUNO` | recusar | apagaria o histórico |
| `TELEFONE` → `ALUNO` | cascata | é parte do aluno |
| `EXEMPLAR` → `OBRA` | recusar | o volume existe na prateleira |
| `MULTA` → `FUNCIONARIO` | esvaziar | ele sai, a multa continua perdoada |

---

<!-- _class: lead -->

## ⚠️ Cascata é certa para o dependente e perigosa para o resto

Um comando de **uma linha** apagando uma obra
pode levar junto exemplares,
empréstimos, renovações e multas.

Em silêncio. Sem aviso. Sem pergunta.

**Teste:** tire a tabela dona e pergunte
se a linha ainda significa alguma coisa.

---

<!-- _class: checkpoint -->

## 🏋️ Exercícios da aula

Na pasta `aula-04/`:

1. **`ex01.md`** — classifique sete violações nas quatro restrições;
2. **`ex02.md`** — escreva o domínio de cada atributo do seu modelo;
3. **`ex03.md`** — escolha a ação referencial das seis FKs da Biblioteca;
4. **`ex04.md`** — o relatório que voltou vazio por causa de um nulo;
5. **Desafio 🌶️ `ex05.md`** — projete uma cascata que apaga o que ninguém queria.

---

<!-- _class: lead -->

## ➡️ Próxima aula

**Aula 05 — O minimundo e o DER**

Até aqui alguém já tinha decidido
quais tabelas existiam.

Agora chega um texto em português.
