---
marp: true
theme: trilha
paginate: true
lang: pt-BR
footer: '🗄️ Curso de Modelagem de Dados · Aula 16'
---

<!-- _class: capa -->

<div class="emoji">🏁</div>

# Revisão e Próximos Passos

## Aula 16 · Bloco 4 — SQL Básico

<div class="meta">Quinze aulas atrás você tinha uma planilha</div>

---

## 🎯 Nesta aula

1. O **mapa** do curso
2. Do minimundo ao banco, o **caminho inteiro**
3. O que ficou **de fora**, e por quê
4. **NoSQL** em duas páginas
5. **ORM** e o descompasso
6. Para onde ir

---

## O mapa do curso

```
📄 Texto      →  📐 DER    →  🗂️ Esquema   →  🗄️ Banco   →  🔍 Consultas
em português     Mermaid      normalizado     rodando       respondidas

Aulas 05, 08     Aulas 01–04  Aulas 06, 07    Aulas 09–13   Aulas 14, 15
recortar e       tabela,      mapear e        SGBD e DDL    DML e junções
perguntar        chave, FK    normalizar
```

Os Blocos 1 e 2 ocupam **metade do curso** e não tocam num computador.

---

<!-- _class: lead -->

## 💡 Foi de propósito

As decisões que custam caro
são todas tomadas **antes**
de existir uma linha de SQL.

E nenhum banco
conserta um modelo errado.

---

<!-- _class: lista-limpa -->

## Três ideias atravessaram as dezesseis aulas

- ⚛️ **Um valor por célula** → virou a 1FN e o tipo de coluna;
- 📍 **Cada dado num lugar só** → virou a 3FN, e é por isso que existe a junção;
- 🔀 **A ordem das linhas não significa nada** → virou o `ORDER BY`.

Nenhuma delas é sintaxe. São **propriedades do modelo relacional** — valem em qualquer banco.

---

<!-- _class: tabela-densa -->

## O roteiro para levar embora

| # | Passo | Como saber que deu certo |
|:---:|---|---|
| 1 | Recortar o minimundo | a lista do que **ficou de fora** está escrita |
| 2 | Achar entidades e atributos | nenhuma tabela tem só código e nome |
| 3 | Perguntar ao cliente | cada resposta mudou alguma coisa |
| 4 | Desenhar o DER | toda linha lida em voz alta é verdade |
| 5 | Mapear e normalizar | nenhum dado em dois lugares |
| 6 | DDL, carga, consultas | o script roda do zero, duas vezes |

---

<!-- _class: tabela-densa -->

## O que ficou de fora — e onde continuar

| Assunto | Onde estudar |
|---|---|
| **Álgebra relacional** | calculadora interativa (links úteis) |
| **BCNF, 4FN e além** | livro-base, normalização |
| **Projeto físico** (índices, plano) | *Use The Index, Luke!* |
| **Especialização e herança** | livro-base, modelagem conceitual |
| **Relacionamento ternário** | livro-base, modelagem conceitual |

---

<!-- _class: lead -->

## 💡 Nada disso é "avançado demais" para sempre

Ficaram fora porque **este** curso
tem dezesseis aulas e escolheu

profundidade em uma metade
em vez de superfície nas duas.

Quando você precisar de um deles,
vai reconhecer o problema —
que é a parte difícil.

---

## NoSQL: o mesmo empréstimo, duas formas

```
Relacional (3 tabelas)          Documento (1 documento)
──────────────────────          ────────────────────────────────
emprestimo(1, '2023101',        { "id": 1,
           4417, ...)             "usuario": { "nome": "Ana Souza" },
usuario('2023101',                "exemplar": { "titulo": "Banco de Dados" }
        'Ana Souza', ...)       }
```

Lê-se de uma vez, sem junção — e o nome da Ana está dentro de **cada** empréstimo dela.

---

<!-- _class: lead -->

## ⚠️ "NoSQL não tem esquema" é falso

O esquema existe.

Ele saiu do banco e entrou no **código**,
espalhado por todo lugar
que lê aquele documento.

A pergunta não é *se* há esquema.
É **quem o verifica** —
o banco uma vez, ou você em toda leitura.

---

## ORM e o descompasso

```
No código                       No banco
class Usuario {                 CREATE TABLE usuario (
    String matricula;               matricula CHAR(9) PRIMARY KEY,
    List<Emprestimo> emprestimos;   ...
}                               );
```

Objetos têm herança e listas aninhadas. Tabelas têm chaves e valores atômicos.

O ORM esconde a diferença **até o dia em que ela aparece** — geralmente como 500 idas ao banco onde bastaria uma.

---

<!-- _class: lead -->

## 📏 É por isso que este curso existe assim

Quem entende o modelo relacional
usa o ORM e **sabe o que ele está gerando**.

Quem não entende fica refém dele,

e não tem como diagnosticar o dia
em que a aplicação fica lenta
sem motivo aparente.

---

<!-- _class: checkpoint -->

## 🏋️ Exercícios da aula

Na pasta `aula-16/`:

1. **`ex01.md`** — autoavaliação dos nove passos, com o que faltou nos abaixo de 4;
2. **`ex02.md`** — refaça o modelo da Aula 05 do zero e compare as duas versões;
3. **`ex03.md`** — relacional ou NoSQL para três sistemas (um deles: os dois);
4. **`ex04.md`** — plano de estudo de três meses, com critério verificável;
5. **Desafio 🌶️ `ex05.md`** — a **crítica** do seu próprio projeto final.

---

<!-- _class: lead -->

## 🏁 Fim do curso

Você entrou sabendo que dados
ficam guardados em algum lugar.

Sai capaz de ler um texto em português
e devolver um banco íntegro,
normalizado e **defensável**.

**Bom trabalho.** 🙂
