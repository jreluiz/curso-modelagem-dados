---
marp: true
theme: trilha
paginate: true
lang: pt-BR
footer: '🗄️ Curso de Modelagem de Dados · Aula 12'
---

<!-- _class: capa -->

<div class="emoji">🛠️</div>

# Ferramentas CASE na Prática

## Aula 12 · Bloco 3 — Abordagem Entidade-Relacionamento

<div class="meta">A ferramenta faz o desenho; você faz as decisões</div>

---

## 🎯 Nesta aula

1. De onde **vieram** as ferramentas CASE
2. As ferramentas de **hoje**
3. O **roteiro** no brModelo
4. O que a **conversão automática** entrega
5. Do rascunho ao **esquema revisado**

---

## A crise do software e a resposta

Nos anos 70, projetos atrasavam e estouravam orçamento com tanta regularidade que o problema ganhou nome. Uma das respostas foi **automatizar o trabalho de projetar**.

| Categoria | Cobre | Exemplo |
|---|---|---|
| **Upper CASE** | análise e projeto | desenhar o DER, o dicionário de dados |
| **Lower CASE** | implementação e manutenção | gerar o esquema, depurar |
| **I-CASE** | o ciclo inteiro | manter modelo e código em sincronia |

---

<!-- _class: lead -->

## A promessa dos anos 90 não se cumpriu

A ferramenta **não** gerou o sistema
inteiro a partir do modelo.

O que sobrou é modesto e útil:
desenho, verificação, conversão
e **engenharia reversa**.

---

<!-- _class: tabela-densa -->

## As ferramentas de hoje

| Ferramenta | Notação | Onde brilha | Custo |
|---|---|---|---|
| **brModelo** | **Chen** | ensino; a notação deste curso | gratuita |
| **draw.io** | livre | rascunho no navegador | gratuita |
| **MySQL Workbench** | pé-de-galinha | modelar pensando na implantação | gratuita |
| **Oracle Data Modeler** | pé-de-galinha | projetos grandes | gratuita |
| **erwin** | pé-de-galinha | padrão corporativo | paga |
| **Astah / Visual Paradigm** | UML | quando o principal é o de classes | paga |

---

<!-- _class: lead -->

## ⚠️ Ferramenta não é notação

Trocar de ferramenta é aprender menus.
Trocar de notação é aprender
a ler outro diagrama.

Comece pelo modelo, não pelo *download*.

---

## O roteiro no brModelo

```
   1. ENTIDADES        um retângulo por entidade. MAIÚSCULAS, singular
   2. ATRIBUTOS        marque o identificador — ela sublinha sozinha
   3. RELACIONAMENTOS  losango ligado às duas, nome com verbo
   4. CARDINALIDADE    escolha (1,1), (1,n), (0,n)  ⚠️ ver abaixo
   5. CONVERSÃO        Ferramentas → Converter para lógico
   6. REVISÃO          o passo que ninguém faz
```

É o mesmo roteiro da Aula 09 — e é bom que seja.

---

## ⚠️ A ferramenta usa `(min,max)`

```
   O curso   [EDITORA] ──1──  {PUBLICA}  ──N── [LIVRO]
                                           ↑ junto de LIVRO

   brModelo  [EDITORA] ─(1,n)─ {PUBLICA} ─(1,1)─ [LIVRO]
                         ↑ junto de EDITORA
```

**O mesmo fato, com os símbolos espelhados.** Leia a frase em voz alta e confira.

---

## O que a conversão automática entrega

```
   USUARIO(id_usuario, nome, email)
   LIVRO(id_livro, titulo, ano, id_editora)
   EXEMPLAR(id_exemplar, situacao, id_livro)
   EMPRESTIMO(id_emprestimo, data_retirada, id_usuario, id_exemplar)
```

Funciona. E tem **quatro coisas para revisar** — todas conhecidas do Bloco 2.

---

<!-- _class: tabela-densa -->

## As quatro revisões

| O que a ferramenta fez | Por que revisar |
|---|---|
| criou `id_exemplar` | `EXEMPLAR` era **entidade fraca**: a chave natural é `(isbn, numero_ex)` |
| trocou `isbn` por `id_livro` | `isbn` já identificava, e é o que o bibliotecário usa |
| não declarou política de exclusão | recusar, propagar ou anular é decisão do **modelo** |
| não disse o que aceita vazio | a participação total do diagrama se perdeu |

---

## Quando a ferramenta não tem a construção

**Agregação** — poucas desenham a caixa. Use a **entidade associativa** e registre numa decisão que aquilo era agregação no conceitual.

**Especialização** — sem o círculo `d`/`o`, desenhe superclasse e subclasses ligadas por `1:1` total, e escreva qual das quatro combinações é.

> 💡 Quando a ferramenta não alcança o modelo, **quem cede é o desenho, nunca a decisão**.

---

## O esquema depois da revisão

```
   USUARIO(matricula, nome, email)
   EDITORA(cnpj, nome, cidade)
   LIVRO(isbn, titulo, ano, cnpj → EDITORA)
   EXEMPLAR(isbn → LIVRO, numero_ex, situacao)
   EMPRESTIMO(numero, data_retirada, data_devolucao,
              matricula → USUARIO, isbn + numero_ex → EXEMPLAR)

   D-05  Chaves naturais mantidas. Alternativa descartada: as artificiais
         da ferramenta. Por quê: já identificam, são estáveis, aparecem no balcão.
```

---

<!-- _class: lead -->

## O trabalho não é desenhar — é decidir

A ferramenta faz o desenho em minutos
e a conversão em um clique.

As duas decisões acima levaram mais tempo
que tudo isso junto. E são elas
que alguém vai ler daqui a dois anos.

---

<!-- _class: checkpoint -->

## 🏋️ Exercícios da aula

Na pasta `aula-12/`:

1. **`ex01.md`** — aponte quatro coisas a revisar na conversão do modelo de eventos;
2. **`ex02.md`** — escolha a ferramenta para três situações, com a tabela da aula;
3. **`ex03.md`** — **autoral**: um minimundo de Bloco 3, com especialização classificada.

---

<!-- _class: lead -->

## ➡️ Próxima aula

**Aula 13 — Por que normalizar**

O modelo pode estar bem desenhado,
bem documentado, feito em ferramenta —
e ainda guardar o mesmo dado em dois lugares.
