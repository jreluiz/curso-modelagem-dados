# 💻 Caso de referência — Biblioteca Universitária

O modelo que atravessa o curso inteiro, agora rodando. É o que você abre quando travar no projeto final.

| Arquivo | O que é | Vem da |
|---|---|---|
| [`01-ddl.sql`](01-ddl.sql) | As 16 tabelas com todas as restrições | Aulas 08 → 10 → 13 |
| [`02-carga.sql`](02-carga.sql) | Dados de teste coerentes | Aula 13 |
| [`03-consultas.sql`](../../aula-14-sql-dml-consultas/exemplos/03-consultas.sql) | 15 consultas comentadas | Aula 14 |
| [`04-indices-transacoes.sql`](../../aula-15-projeto-fisico-transacoes/exemplos/04-indices-transacoes.sql) | Índices, `EXPLAIN`, transações | Aula 15 |

## Como rodar

```bash
createdb curso_bd        # se ainda não existir

cd bloco-4-sql-e-projeto-fisico
psql -d curso_bd -v ON_ERROR_STOP=1 -f aula-13-sql-ddl/exemplos/01-ddl.sql
psql -d curso_bd -v ON_ERROR_STOP=1 -f aula-13-sql-ddl/exemplos/02-carga.sql
psql -d curso_bd -f aula-14-sql-dml-consultas/exemplos/03-consultas.sql
psql -d curso_bd -f aula-15-projeto-fisico-transacoes/exemplos/04-indices-transacoes.sql
```

`ON_ERROR_STOP=1` faz o `psql` parar no primeiro erro em vez de seguir adiante deixando estrago. Use sempre.

O `01-ddl.sql` começa com `DROP TABLE IF EXISTS ... CASCADE`, então pode ser rodado **quantas vezes quiser** — é assim que se recomeça do zero quando um experimento dá errado.

## O que este caso exemplifica

| Conceito | Onde olhar |
|---|---|
| Entidade forte (Regra 1) | `usuario`, `obra`, `autor`, `area`, `funcionario` |
| Especialização, opção A (Aula 10, §9) | `aluno`, `professor`, `servidor` + o `CHECK` em `usuario.tipo` |
| Entidade fraca (Regra 2) | `renovacao` — chave `(id_emprestimo, sequencia)`, `ON DELETE CASCADE` |
| Atributo multivalorado (Regra 6) | `telefone` — chave `(matricula, numero)` |
| Relacionamento 1:N (Regra 3) | `exemplar.isbn`, e as **três** FKs de `emprestimo` |
| Relacionamento 1:1 (Regra 4a) | `multa` — a FK **é** a PK, o que garante o 1:1 sem `UNIQUE` |
| Relacionamento N:M (Regra 5) | `escrita` (com o atributo `ordem`) e `classificacao` |
| Ação referencial escolhida (Aula 09, §6) | `CASCADE` só nas fracas; `RESTRICT` no resto; `SET NULL` em `multa.matricula_func` |
| `CHECK` para domínio e integridade semântica | `ck_exemplar_situacao`, `ck_emp_prazo`, `ck_multa_perdao` |
| O `NULL` que engana num `CHECK` | `ck_emp_devolucao` — leia o comentário no arquivo |

## Detalhes da carga que existem de propósito

Os dados não são aleatórios. Cada peculiaridade exercita alguma coisa:

- **'Inteligência Artificial' não tem exemplar** — dá conteúdo ao `LEFT JOIN` e materializa o `(0,N)` decidido na Aula 08;
- **Célia Reis e Eliane Castro nunca pegaram nada** — é o resultado do `NOT EXISTS`;
- **'Inteligência Artificial' tem dois autores** — o atributo `ordem` deixa de ser teórico;
- **A obra de BD está em duas áreas** — prova o N:M de `classificacao`;
- **Bruno Lima pegou exemplares das duas obras de 2020** — é o único resultado da divisão relacional. Ana Souza pegou **mais** exemplares e mesmo assim não aparece: a divisão exige cobertura, não quantidade;
- **O empréstimo 5 tem duas renovações** — a entidade fraca com sequência 1 e 2;
- **Uma multa paga e uma perdoada** — exercita o `CHECK` que exige justificativa **e** funcionário juntos.

> ⚠️ A view `emprestimos_em_aberto` calcula `dias_atraso` com `CURRENT_DATE`. **O resultado muda conforme o dia em que você roda** — é um atributo derivado de verdade, e é assim que deve ser (Aula 04, §2). As datas da carga foram escolhidas em torno de meados de 2026.

## Sugestão de roteiro de exploração

1. Rode o `01` e o `02`, e então `\dt` para ver as 16 tabelas;
2. Rode `\d emprestimo` — repare que ele mostra as FKs **nos dois sentidos**: as que saem e as que chegam;
3. Tente `DELETE FROM obra WHERE isbn = '978-85-1234-567-8';` e leia o erro. É o `RESTRICT` protegendo os exemplares;
4. Tente `INSERT INTO exemplar (tombo, isbn) VALUES (9999, '000-inexistente');` e leia o erro. É a integridade referencial;
5. Tente `UPDATE exemplar SET situacao = 'perdido' WHERE tombo = 4419;` e leia o erro. É o `CHECK` de domínio;
6. Só então rode o `03` e o `04`.

Os passos 3, 4 e 5 são os mais importantes: **é vendo o banco recusar que você entende o que declarou.**

---

⬅️ [Voltar à Aula 13](../README.md) | 🏠 [Início do curso](../../../README.md)
