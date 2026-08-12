---
marp: true
theme: trilha
paginate: true
lang: pt-BR
footer: '🗄️ Curso de Modelagem de Dados · Aula 10'
---

<!-- _class: capa -->

<div class="emoji">🔄</div>

# O Mesmo Caso em Duas Notações

## Aula 10 · Bloco 3 — Abordagem Entidade-Relacionamento

<div class="meta">DER e classes UML, lado a lado</div>

---

## 🎯 Nesta aula

1. O caso, em **DER**
2. A **classe** em UML
3. **Associação** e **multiplicidade**
4. **Herança** — o triângulo
5. A tabela de **conversão**
6. O que cada notação **mostra melhor**

---

<!-- _class: lead -->

## 💡 As duas não competem

O **DER** é feito para dados:
nasceu em 1976, para descrever
o que um banco guarda.

A **UML** é feita para sistemas:
classes que têm dados **e comportamento**.

---

## A classe: três compartimentos

```
   ┌──────────────────────────┐
   │         Evento           │  ← nome
   ├──────────────────────────┤
   │ -codigo : int            │  ← atributos, com TIPO
   │ -titulo : String         │     - privado  + público
   │ -cargaHoraria : int      │
   ├──────────────────────────┤
   │ +inscrever(p : Pessoa)   │  ← operações — não existem no DER
   └──────────────────────────┘
```

Num modelo de **dados**, o terceiro compartimento fica vazio. E está certo.

---

## Associação: a linha entre duas classes

```
   ┌────────┐  1              0..*  ┌────────┐
   │  Sala  │─────────recebe────────│ Evento │
   └────────┘                       └────────┘
```

O relacionamento do DER vira **associação**: uma linha com um **nome** e com a **multiplicidade** nas pontas.

---

## Multiplicidade

| Multiplicidade | Lê-se | Em Chen seria |
|---|---|---|
| `1` | exatamente um | `1` + participação total |
| `0..1` | nenhum ou um | `1` + participação parcial |
| `1..*` | um ou mais | `N` + participação total |
| `0..*` | qualquer quantidade | `N` + participação parcial |

---

<!-- _class: lead -->

## 💡 É a fusão dos dois eixos da Aula 06

"Quantos?" e "pode zero?" eram
duas respostas em dois lugares do desenho.

Em UML viram **um símbolo só**.

---

## O lado do número é o mesmo nas duas

O `0..*` encostado em `Evento` diz *"uma sala recebe de zero a muitos eventos"* — exatamente como o `N` encostado em `EVENTO` no DER.

**A conversão é direta, ponta por ponta.**

> ⚠️ Onde o lado troca de verdade é na notação **`(min,max)`**: lá o par ao lado de uma entidade diz quantas vezes **cada ocorrência dela** participa. É a notação da ferramenta da Aula 12.

---

## Herança: o triângulo

```
                  ┌──────────────┐
                  │   Pessoa     │
                  │ -matricula   │
                  │ -nome        │
                  └──────△───────┘
                    ┌────┴────┐
          ┌─────────┴──┐   ┌──┴──────────┐
          │   Aluno    │   │ Professor   │
          │ -curso     │   │ -departamento│
          └────────────┘   └─────────────┘
```

O triângulo **aponta para o geral**. Lê-se de baixo para cima: *"aluno é uma pessoa"*.

---

<!-- _class: tabela-densa -->

## A tabela de conversão

| No DER (Chen) | No diagrama de classes |
|---|---|
| Entidade | **classe** |
| Atributo identificador (sublinhado) | atributo comum — a UML **não marca chave** |
| Relacionamento (losango) | **associação**, com nome |
| Cardinalidade `1`, `N` | **multiplicidade** `1`, `0..*` |
| Participação total | multiplicidade que **começa em 1** |
| Agregação | **classe de associação** |
| — | **herança** e **operações** |

---

<!-- _class: lead -->

## ⚠️ A UML não marca chave primária

E não é esquecimento:
objeto tem identidade própria na memória.

Quando o modelo UML virar banco,
alguém decide a chave **de novo**.

---

<!-- _class: tabela-densa -->

## O que cada uma mostra melhor

| | DER de Chen | Classes UML |
|---|---|---|
| Feito para | dados | sistemas inteiros |
| Mostra bem | multivalorado, derivado, participação, chave | herança, comportamento, tipos |
| Esconde | comportamento e tipo | chave e os tipos de atributo |
| Público | quem modela o banco, e o cliente | equipe de desenvolvimento |

Nenhuma é a versão moderna da outra.

---

<!-- _class: checkpoint -->

## 🏋️ Exercícios da aula

Na pasta `aula-10/`:

1. **`ex01.md`** — converta quatro lados do DER da biblioteca em multiplicidade UML;
2. **`ex02.md`** — desenhe `Livro`, `Exemplar` e `Editora` em `classDiagram`, e diga o que se perdeu;
3. **`ex03.md`** — a herança dos funcionários, e o que aconteceria em Chen puro.

---

<!-- _class: lead -->

## ➡️ Próxima aula

**Aula 11 — Especialização e generalização**

Quando a herança se justifica —
e as três perguntas que recusam
a maioria dos casos.
