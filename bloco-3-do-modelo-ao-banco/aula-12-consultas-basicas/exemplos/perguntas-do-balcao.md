# Perguntas do balcão — da frase à consulta

Este arquivo mostra **o percurso de uma consulta**: a pergunta entra em português, passa pelas quatro perguntas da seção 6 e sai como `SELECT`, com o resultado ao lado para conferir. É a referência de formato dos exercícios da [Aula 12](../README.md). Todos os resultados abaixo foram obtidos no banco do [link da aula](https://www.db-fiddle.com/f/7pKUAennP692gFYe3JqY38/1).

---

## Pergunta 1 — uma junção, com ordem

*"Que livros da Editora Ponte Alta nós temos, do mais novo para o mais antigo?"*

| Pergunta | Resposta |
|---|---|
| O que a resposta mostra? | o título e o ano |
| Em que tabelas isso mora? | `livro`; e o nome da editora, em `editora` — seta `livro.cnpj → editora` |
| Que linhas interessam? | as da editora de nome *Editora Ponte Alta* |
| Em que ordem? | ano decrescente |

```sql
-- Que livros da Editora Ponte Alta temos, do mais novo para o mais antigo?
SELECT l.titulo, l.ano
FROM livro l
JOIN editora ed ON l.cnpj = ed.cnpj        -- a seta livro.cnpj → editora
WHERE ed.nome = 'Editora Ponte Alta'
ORDER BY l.ano DESC;
```

| titulo | ano |
|---|---|
| Projeto de Sistemas | 2023 |
| História da Computação | 2016 |

## Pergunta 2 — uma lista no `WHERE`

*"Que exemplares estão fora de circulação — em reparo ou descartados — e de que livro?"*

| Pergunta | Resposta |
|---|---|
| O que a resposta mostra? | o título, o número do exemplar e a situação |
| Em que tabelas isso mora? | `exemplar`; o título em `livro` — seta `exemplar.isbn → livro` |
| Que linhas interessam? | situação *em reparo* **ou** *descartado* |
| Em que ordem? | a pergunta não pede |

```sql
-- Que exemplares estão em reparo ou descartados, e de que livro?
SELECT l.titulo, x.numero_ex, x.situacao
FROM exemplar x
JOIN livro l ON x.isbn = l.isbn            -- a seta exemplar.isbn → livro
WHERE x.situacao IN ('em reparo', 'descartado');
```

| titulo | numero_ex | situacao |
|---|---|---|
| Algoritmos em Português | 1 | em reparo |

O `IN` é um atalho para dois `=` ligados por `OR`: `x.situacao = 'em reparo' OR x.situacao = 'descartado'` dá o mesmo resultado.

## Pergunta 3 — três tabelas, e o vazio que aparece

*"Quem já retirou* SQL para Iniciantes*, e quando?"*

| Pergunta | Resposta |
|---|---|
| O que a resposta mostra? | o nome, a data de retirada e a de devolução |
| Em que tabelas isso mora? | `emprestimo`; o nome em `usuario`; o título em `livro` |
| Que linhas interessam? | as do livro de título *SQL para Iniciantes* |
| Em que ordem? | a da retirada |

```sql
-- Quem já retirou "SQL para Iniciantes", e quando?
SELECT u.nome, em.data_retirada, em.data_devolucao
FROM emprestimo em
JOIN usuario u ON em.codigo_usuario = u.codigo   -- a seta emprestimo → usuario
JOIN livro   l ON em.isbn = l.isbn               -- o isbn que veio de exemplar
WHERE l.titulo = 'SQL para Iniciantes'
ORDER BY em.data_retirada;
```

| nome | data_retirada | data_devolucao |
|---|---|---|
| Bruno Lima | 2026-11-03 | 2026-11-10 |
| Carlos Mendes | 2026-11-05 | *(vazio)* |

Os dois retiraram exemplares **diferentes** do mesmo livro, o 1 e o 2, e por isso o empréstimo de Carlos começou antes de o de Bruno terminar. A data de devolução vazia é o empréstimo em aberto: o `SELECT` mostra o vazio como ele está, sem esconder a linha.

## Os três defeitos que mais aparecem

**1. O `= NULL`, que devolve nada sem dar erro.**

```sql
SELECT numero FROM emprestimo WHERE data_devolucao = NULL;     -- 0 linhas
SELECT numero FROM emprestimo WHERE data_devolucao IS NULL;    -- 4 linhas
```

Comparar com `NULL` usando `=` ou `<>` nunca dá verdadeiro. O sintoma é uma resposta vazia onde deveria haver linhas.

**2. A junção sem condição, que multiplica.**

```sql
SELECT l.titulo, ed.nome FROM livro l, editora ed;             -- 18 linhas
```

Cada um dos 6 livros aparece com cada uma das 3 editoras. O sintoma é o contrário do primeiro: linhas demais, cada título repetido tantas vezes quantas são as editoras.

**3. A coluna de nome repetido, sem dizer de qual tabela.**

```sql
SELECT titulo, nome FROM livro JOIN editora ON cnpj = cnpj;
-- ERRO: column reference "cnpj" is ambiguous
```

Esse pelo menos avisa. A correção é escrever a tabela, ou o apelido dela, antes da coluna: `livro.cnpj = editora.cnpj`.

## O roteiro, para qualquer pergunta

```
   1. O que a resposta mostra?       → SELECT, as colunas
   2. Em que tabelas isso mora?      → FROM e JOIN … ON, seguindo as setas
   3. Que linhas interessam?         → WHERE — e IS NULL, se envolver vazio
   4. Em que ordem? Quantas?         → ORDER BY e LIMIT
   5. Conferiu? O número de linhas faz sentido para o minimundo?
```

---

⬅️ [Voltar à Aula 12](../README.md)
