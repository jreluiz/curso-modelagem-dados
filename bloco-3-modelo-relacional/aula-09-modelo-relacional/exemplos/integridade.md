# Aula 09 — Restrições de integridade em ação

As quatro restrições, cada uma com uma violação concreta e a mensagem que o PostgreSQL devolve.

## Integridade de domínio

```
OBRA(isbn, titulo, ano_publicacao, editora)
     domínio de ano_publicacao: inteiro entre 1450 e o ano corrente
```

| Tentativa | O que acontece |
|---|---|
| `ano_publicacao = 'antigo'` | Rejeitado pelo **tipo**: `invalid input syntax for type integer` |
| `ano_publicacao = 1204` | Rejeitado pelo **`CHECK`**: `violates check constraint "ck_obra_ano"` |
| `ano_publicacao = 2003` | ✅ |

> 💡 O tipo cuida da forma; o `CHECK` cuida do significado. Um `INTEGER` sozinho aceita `1204` e `-50` — o domínio real do atributo é mais estreito que o tipo, e escrevê-lo é trabalho seu.

## Integridade de entidade

A chave primária **nunca é nula e nunca repete**.

```sql
INSERT INTO exemplar (tombo, isbn) VALUES (NULL, '978-85-1234-567-8');
-- ERROR: null value in column "tombo" of relation "exemplar"
--        violates not-null constraint

INSERT INTO exemplar (tombo, isbn) VALUES (4417, '978-85-1234-567-8');
-- ERROR: duplicate key value violates unique constraint "exemplar_pkey"
-- DETAIL: Key (tombo)=(4417) already exists.
```

Um identificador vazio não identifica; um repetido identifica duas coisas. As duas metades da regra têm o mesmo motivo.

## Integridade referencial

```
   USUARIO                          EMPRESTIMO
   ┌───────────┬──────────┐         ┌────┬───────────┬───────┐
   │ matricula │  nome    │         │ id │ matricula │ tombo │
   ├───────────┼──────────┤         ├────┼───────────┼───────┤
   │  2023101  │ Ana      │◄────────┤ 1  │  2023101  │ 4417  │  ✅
   │  2023102  │ Bruno    │◄────────┤ 2  │  2023102  │ 4418  │  ✅
   └───────────┴──────────┘    ✗────┤ 3  │  9999999  │ 4419  │  ❌ VIOLA
                                    └────┴───────────┴───────┘
```

```sql
INSERT INTO emprestimo (matricula, tombo, matricula_func, data_prevista)
VALUES (9999999, 4419, 900, CURRENT_DATE + 14);
-- ERROR: insert or update on table "emprestimo" violates foreign key
--        constraint "fk_emp_usuario"
-- DETAIL: Key (matricula)=(9999999) is not present in table "usuario".
```

E no sentido inverso:

```sql
DELETE FROM obra WHERE isbn = '978-85-1234-567-8';
-- ERROR: update or delete on table "obra" violates foreign key constraint
--        "fk_exemplar_obra" on table "exemplar"
-- DETAIL: Key (isbn)=(978-85-1234-567-8) is still referenced from table "exemplar".
```

**Isso é o sistema funcionando.** A mensagem diz a restrição, a chave e a tabela — e impediu que exemplares ficassem órfãos.

## Integridade semântica

Tudo o mais que precisa ser verdade:

```sql
-- Devolver antes de retirar:
UPDATE emprestimo SET data_devolucao = '2020-01-01' WHERE id_emprestimo = 1;
-- ERROR: new row for relation "emprestimo" violates check constraint
--        "ck_emp_devolucao"

-- Multa de valor zero:
INSERT INTO multa (id_emprestimo, valor) VALUES (4, 0);
-- ERROR: new row for relation "multa" violates check constraint "ck_multa_valor"
```

Parte da integridade semântica **não cabe** num `CHECK` — "um exemplar em manutenção não pode ser emprestado" envolve duas tabelas, e exige gatilho ou verificação na aplicação. Saber o que cabe e o que não cabe evita horas tentando declarar o indeclarável.

## O nulo, na prática

```sql
SELECT COUNT(*) AS total,
       COUNT(data_devolucao) AS devolvidos,
       COUNT(*) - COUNT(data_devolucao) AS em_aberto
FROM emprestimo;
```

`COUNT(*)` conta **linhas**; `COUNT(coluna)` conta **valores não nulos**. A diferença entre os dois é a quantidade de empréstimos em aberto — um truque útil e uma armadilha para quem não sabe.

```sql
SELECT * FROM emprestimo WHERE data_devolucao = NULL;   -- ZERO linhas, sempre
SELECT * FROM emprestimo WHERE data_devolucao IS NULL;  -- ✅ o correto
```

Nulo não é igual a nada, **nem a si mesmo**. A tabela-verdade de três valores:

| `A` | `B` | `A = B` | Aceito pelo `WHERE`? |
|---|---|---|:---:|
| 5 | 5 | verdadeiro | ✅ |
| 5 | 3 | falso | ❌ |
| 5 | nulo | **desconhecido** | ❌ |
| nulo | nulo | **desconhecido** | ❌ |

E o detalhe que inverte a expectativa: um **`CHECK`** que resulta em `desconhecido` **passa**. É por isso que `ck_emp_devolucao` precisa do `IS NULL OR` — sem ele, todo empréstimo em aberto seria rejeitado; com ele, o `CHECK` deixa passar corretamente.

## Ações referenciais: a tabela de decisão do caso

| FK | `ON DELETE` | Por quê |
|---|---|---|
| `emprestimo.matricula` → `usuario` | `RESTRICT` | Apagar o usuário apagaria o histórico. Usuário que sai é **inativado** |
| `emprestimo.tombo` → `exemplar` | `RESTRICT` | Idem |
| `emprestimo.matricula_func` → `funcionario` | `RESTRICT` | Idem |
| `telefone.matricula` → `usuario` | `CASCADE` | Entidade fraca: sem o dono, não tem sentido |
| `renovacao.id_emprestimo` → `emprestimo` | `CASCADE` | Entidade fraca |
| `multa.id_emprestimo` → `emprestimo` | `CASCADE` | Dependência total (1:1) |
| `multa.matricula_func` → `funcionario` | `SET NULL` | O funcionário pode sair; a multa continua perdoada, perde-se só quem autorizou |
| `exemplar.isbn` → `obra` | `RESTRICT` | Apagar a obra apagaria exemplares que existem na estante |
| `escrita.isbn` → `obra` | `CASCADE` | A autoria não existe sem a obra |
| `escrita.id_autor` → `autor` | `RESTRICT` | Apagar o autor não pode apagar a autoria de obras existentes |

> ⚠️ **A regra em uma linha:** `CASCADE` só onde a entidade dependente **não faz sentido sozinha**. Nos demais, `RESTRICT` — e que o banco reclame. Um `DELETE` de uma linha em `obra` com `CASCADE` mal declarado apagaria exemplares, empréstimos, renovações e multas em silêncio, respondendo `DELETE 1`.

---

⬅️ [Voltar à Aula 09](../README.md) | 🏠 [Início do curso](../../../README.md)
