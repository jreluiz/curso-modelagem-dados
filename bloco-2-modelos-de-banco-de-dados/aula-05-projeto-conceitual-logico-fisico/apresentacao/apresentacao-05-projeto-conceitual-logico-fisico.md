---
marp: true
theme: trilha
paginate: true
lang: pt-BR
footer: '🗄️ Curso de Modelagem de Dados · Aula 05'
---

<!-- _class: capa -->

<div class="emoji">🧭</div>

# Projeto de BD: Conceitual, Lógico e Físico

## Aula 05 · Bloco 2 — Modelos de Banco de Dados

<div class="meta">O mesmo empréstimo, escrito três vezes</div>

---

## 🎯 Nesta aula

1. O mesmo fato em **três documentos**
2. Projeto de BD: um **processo com etapas**
3. O modelo **conceitual** — o que o mundo é
4. O modelo **lógico** — como isso vira tabela
5. O modelo **físico** — como isso vira arquivo
6. Por que a **ordem não se inverte**

---

## O mesmo empréstimo, três vezes

```
  1. O DESENHO           (matricula)        (numero)
                              │                 │
                         ┌────────┐  1  ◇  N ┌────────────┐
                         │ ALUNO  │───FAZ────│ EMPRESTIMO │
                         └────────┘          └────────────┘

  2. AS TABELAS          ALUNO(matricula, nome)
                         EMPRESTIMO(numero, data, matricula → ALUNO)

  3. O ARMAZENAMENTO     matricula ... inteiro de 4 bytes, chave primária
                         índice ...... por matrícula
```

---

<!-- _class: lead -->

## Mudou o nível de detalhe

E mudou **quem precisa entender**.

O primeiro você mostra ao bibliotecário.
O terceiro só interessa a quem
vai instalar o banco.

---

## Um processo com entrada e saída

```
   REQUISITOS  ──▶  CONCEITUAL  ──▶   LÓGICO   ──▶   FÍSICO
   (Aula 04)          (o quê)       (como, no      (como, neste
                                     relacional)      SGBD)

   português         diagrama         tabelas        tipos, índices
                     de Chen        e chaves       e armazenamento
```

Entra a **lista de requisitos**; sai o **esquema** do banco.

---

<!-- _class: tabela-densa -->

## O conceitual **não** decide

| Isto não é decisão conceitual | Por quê |
|---|---|
| `matricula` é inteiro ou texto? | tipo de dado é decisão física |
| a tabela vai se chamar `tb_aluno`? | nome de tabela é decisão lógica |
| vai precisar de índice? | desempenho é decisão física |
| e se o banco for PostgreSQL? | o conceitual vale para qualquer SGBD |

---

<!-- _class: lead -->

## ⚠️ O conceitual é o único que o cliente confere

O bibliotecário não sabe dizer
se `matricula` deveria ser inteiro.

Mas sabe dizer, na hora, se um empréstimo
pode ter dois alunos.

---

<!-- _class: tabela-densa -->

## Do conceitual para o lógico

| No conceitual | Vira no lógico |
|---|---|
| Entidade | uma tabela |
| Atributo | uma coluna |
| Atributo que identifica | a chave primária |
| Relacionamento 1:N | uma coluna a mais **no lado N** |
| Relacionamento N:M | **uma tabela nova**, só para a ligação |

O losango **desapareceu** — tabela não tem losango.

---

## Por que a chave vai para o lado N

```
   NO CONCEITUAL                      NO LÓGICO

   AUTOR ──N── ESCREVE ──M── LIVRO    AUTOR(cpf, nome)
                  │                   LIVRO(isbn, titulo)
           ordem_assinatura           ESCREVE(cpf → AUTOR,
                                              isbn → LIVRO,
                                              ordem_assinatura)
```

**Uma célula guarda um valor só.** Um empréstimo tem um aluno: cabe.

---

## O modelo físico

Decide como o SGBD escolhido grava aquilo em disco.

- **Depende do SGBD** — o mesmo lógico gera arquivos diferentes;
- **É o único nível em que desempenho é assunto**;
- **É o mais fácil de mudar depois** — criar índice não altera significado.

Este curso **para no lógico**, de propósito.

---

<!-- _class: lead -->

## ⚠️ Índice não conserta modelo

Um esquema com dado repetido
em três tabelas continua se contradizendo
depois de qualquer índice.

A cura para modelo ruim é **modelagem**.

---

<!-- _class: tabela-densa -->

## Os três, lado a lado

| | Conceitual | Lógico | Físico |
|---|---|---|---|
| **Responde** | o que existe no mundo | como vira tabela | como vira arquivo |
| **Depende de** | nada além do minimundo | do modelo de dados | do SGBD |
| **Quem revisa** | o cliente e você | você | quem administra |
| **Quando muda** | quando o negócio muda | quando o conceitual muda | quando o desempenho exige |

Trocou de SGBD? **O conceitual continua valendo.**

---

<!-- _class: checkpoint -->

## 🏋️ Exercícios da aula

Na pasta `aula-05/`:

1. **`ex01.md`** — classifique seis decisões em conceitual, lógica ou física;
2. **`ex02.md`** — converta um fragmento conceitual em modelo lógico;
3. **`ex03.md`** — ache as invasões de nível no "conceitual" do estagiário e reescreva.

---

<!-- _class: lead -->

## ➡️ Próxima aula

**Aula 06 — A notação gráfica e os tipos de entidade**

O diagrama diz o tipo
**antes** de você ler o nome.
