---
marp: true
theme: trilha
paginate: true
lang: pt-BR
footer: '🗄️ Curso de Modelagem de Dados · Aula 16'
---

<!-- _class: capa -->

<div class="emoji">🏁</div>

# 3FN e 4FN

## Aula 16 · Bloco 4 — Normalização de Dados

<div class="meta">A última forma normal — e o fim do caminho</div>

---

## 🎯 Nesta aula

1. Aplicando a **3FN**
2. A tabela que **multiplica linhas sozinha**
3. **Dependência multivalorada**
4. A **4FN**
5. O **quadro completo** e o roteiro
6. O que você aprendeu, e o que **ficou de fora**

---

## Aplicando a 3FN

```
   ANTES   EVENTO(cod_ev, titulo, carga_horaria, sala, capacidade_sala)
           cod_ev → sala       e       sala → capacidade_sala

   DEPOIS  EVENTO(cod_ev, titulo, carga_horaria, sala → SALA)
           SALA(sala, capacidade_sala)
              S-204 | 40
              S-101 | 25
```

A capacidade passou a existir em **um lugar só** — e a sala nova, sem evento marcado, agora cabe.

---

## O esquema em 3FN

```
   ALUNO(matricula, nome_aluno, curso)
   SALA(sala, capacidade_sala)
   EVENTO(cod_ev, titulo_evento, carga_horaria, sala → SALA)
   INSCRICAO(matricula → ALUNO, cod_ev → EVENTO, data_inscricao)
   PALESTRANTE_EVENTO(cod_ev → EVENTO, nome_palestrante)
```

> 💡 **Para 95% dos esquemas, acabou aqui.**

---

## Uma tabela que multiplica linhas sozinha

```
   PALESTRANTE_INFO
   ┌────────────────┬──────────┬──────────────────┐
   │ nome_palestr.  │ cod_ev   │ area             │
   ├────────────────┼──────────┼──────────────────┤
   │ Marta Dias     │   101    │ Metodologia      │
   │ Marta Dias     │   101    │ Redação técnica  │
   │ Marta Dias     │   102    │ Metodologia      │
   │ Marta Dias     │   102    │ Redação técnica  │
   └────────────────┴──────────┴──────────────────┘
```

Dois eventos × duas áreas = **quatro linhas que ninguém escreveu de propósito**.

---

<!-- _class: lead -->

## A terceira linha afirma uma frase sem sentido

*"A Marta atua em metodologia
no evento 102."*

A área dela não tem relação com o evento.

Uma área nova exige inserir **duas** linhas.

---

## Dependência multivalorada

Um atributo determina um **conjunto** de valores, não um valor só.

```
   nome_palestrante ↠ cod_ev      "a Marta tem um conjunto de eventos"
   nome_palestrante ↠ area        "a Marta tem um conjunto de áreas"
```

O problema não é ter **uma**. É ter **duas, independentes**, na mesma tabela.

> ⚠️ Se a área dependesse do evento, a tabela estaria certa.

---

## A 4FN

1. Está na **3FN**; e
2. **não há duas dependências multivaloradas independentes** na mesma tabela.

```
   PALESTRANTE_EVENTO(nome_palestrante, cod_ev)
   PALESTRANTE_AREA(nome_palestrante, area)
```

Quatro linhas viraram quatro — mas agora **cada uma afirma um fato**, e a terceira área custa **uma** linha.

---

<!-- _class: lead -->

## ⚠️ Não dispare a 4FN ao ver um multivalorado

Com **um** conjunto só,
não há independência para separar.

A 4FN precisa de **duas**.

---

<!-- _class: tabela-densa -->

## O quadro completo

| Forma | Proíbe | Como se reconhece |
|---|---|---|
| **1FN** | valor não atômico | lista na célula, colunas numeradas |
| **2FN** | dependência parcial | depende de metade da chave composta |
| **3FN** | dependência transitiva | não-chave determinando outro não-chave |
| **4FN** | duas multivaloradas independentes | linhas que se multiplicam sem sentido |

---

## O roteiro, em cinco perguntas

```
   1. Alguma célula guarda mais de um valor?           → 1FN
   2. A chave é composta? Algum atributo depende
      só de uma parte dela?                             → 2FN
   3. Algum atributo não-chave determina outro?        → 3FN
   4. Há duas listas independentes na mesma tabela?    → 4FN
   5. Cada decomposição é sem perda?                   → sempre
```

A **5** não é uma etapa: é a que se faz **depois de cada uma** das outras.

---

## O que ficou de fora — e por onde continuar

| Assunto | Onde continuar |
|---|---|
| **SQL** — criar, consultar, alterar | qualquer curso de SQL: você já sabe **o que** pedir |
| **Álgebra relacional** | Date, capítulo de álgebra |
| **BCNF e 5FN** | Elmasri & Navathe, capítulo de normalização |
| **Projeto físico** | Silberschatz, parte de armazenamento |
| **Relacionamento ternário** | Heuser — quase sempre é agregação disfarçada |

---

<!-- _class: lead -->

## 💡 O que você leva daqui não é uma notação

Notação se aprende numa tarde
e muda com a ferramenta.

O que fica é perguntar *"quantos?"*,
*"pode zero?"*, *"se isto mudar,
quantos lugares eu altero?"* —
e **escrever a justificativa** ao lado do desenho.

---

<!-- _class: checkpoint -->

## 🏋️ Exercícios da aula

Na pasta `aula-16/`:

1. **`ex01.md`** — leve `EMPRESTIMO` até a 3FN, com a cadeia de dependências;
2. **`ex02.md`** — quatro tabelas: quais precisam da 4FN?
3. **`ex03.md`** — **autoral**: uma tabela desnormalizada sua, até a 3FN, com a conferência.

---

<!-- _class: lead -->

## 🏁 Fim do curso

Modelo sem argumento é
chute bem desenhado.

Obrigado — e `git push`.
