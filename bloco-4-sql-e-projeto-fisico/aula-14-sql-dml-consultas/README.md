# Aula 14 — SQL DML e Consultas

> 🎯 Objetivos: povoar um banco respeitando a integridade referencial, escrever consultas com junção, agregação e subconsulta, e reconhecer nelas os operadores da álgebra relacional.
> 🎬 Slides da aula: [apresentacao-14-sql-dml-consultas.pdf](apresentacao/apresentacao-14-sql-dml-consultas.pdf)

## 1. `INSERT`, `UPDATE`, `DELETE`

```sql
INSERT INTO obra (isbn, titulo, ano_publicacao, editora)
VALUES ('978-85-1234-567-8', 'Fundamentos de Bancos de Dados', 2003, 'Unicamp');

INSERT INTO autor (nome, nacionalidade) VALUES
    ('Célio Cardoso Guimarães', 'Brasileira'),
    ('Nivio Ziviani',           'Brasileira');     -- várias tuplas de uma vez
```

> 📏 **Sempre liste as colunas.** `INSERT INTO obra VALUES (...)` depende da ordem física das colunas — uma ordem que o modelo relacional diz não existir (Aula 09, seção 2). Um `ALTER TABLE ADD COLUMN` no futuro quebra todo `INSERT` que confiava nela, e quebra em silêncio se os tipos forem compatíveis.

### A ordem da carga

A integridade referencial impõe a sequência: **primeiro as tabelas referenciadas**.

```
1. obra, autor, area, funcionario, usuario     ← entidades fortes, sem FK
2. aluno, professor, servidor, telefone        ← subclasses e fracas
3. exemplar                                     ← depende de obra
4. escrita, classificacao                       ← associativas
5. emprestimo                                   ← depende de usuario, exemplar, funcionario
6. renovacao, multa                             ← dependem de emprestimo
```

Inverter a ordem produz `violates foreign key constraint` — o que é o banco fazendo exatamente o que você pediu.

### `UPDATE` e `DELETE`

```sql
UPDATE emprestimo
SET data_devolucao = CURRENT_DATE
WHERE id_emprestimo = 3;

DELETE FROM reserva
WHERE situacao = 'expirada' AND data_solicitacao < CURRENT_DATE - INTERVAL '90 days';
```

> ⚠️ **`UPDATE` e `DELETE` sem `WHERE` atingem a tabela inteira**, sem confirmação e sem aviso. O hábito que evita o desastre: escreva primeiro como `SELECT`, confira quantas linhas voltam, e só então troque o verbo. Em trabalho sério, `BEGIN` antes e `COMMIT` depois de conferir (Aula 15).

## 2. `SELECT`: a estrutura e a ordem real

```sql
SELECT   isbn, titulo, ano_publicacao
FROM     obra
WHERE    ano_publicacao > 2000
ORDER BY titulo;
```

A ordem em que você **escreve** não é a ordem em que o banco **executa**:

```
   escrita:    SELECT → FROM → WHERE → GROUP BY → HAVING → ORDER BY
   execução:   FROM → WHERE → GROUP BY → HAVING → SELECT → ORDER BY
                                                     ↑
                          o SELECT é quase o ÚLTIMO a rodar
```

Isso explica dois comportamentos que confundem:

- **Não se pode usar um apelido do `SELECT` no `WHERE`** — quando o `WHERE` roda, o `SELECT` ainda não aconteceu;
- **Pode-se usá-lo no `ORDER BY`** — que roda depois.

```sql
SELECT titulo, ano_publicacao AS ano FROM obra WHERE ano > 2000;    -- ❌ ERROR: column "ano" does not exist
SELECT titulo, ano_publicacao AS ano FROM obra ORDER BY ano;        -- ✅
```

> 💡 `SELECT` é a projeção **π** e `WHERE` é a seleção **σ** da Aula 11 — só que com os nomes trocados em relação à álgebra, uma pegadinha histórica do SQL. E `SELECT` sem `DISTINCT` **não** elimina duplicatas, ao contrário de `π`.

## 3. Junções

O `JOIN` é o `⋈` da álgebra, e a correspondência é direta.

```sql
SELECT u.nome, o.titulo, e.data_retirada
FROM emprestimo e
JOIN usuario  u ON e.matricula = u.matricula
JOIN exemplar x ON e.tombo     = x.tombo
JOIN obra     o ON x.isbn      = o.isbn
WHERE e.data_devolucao IS NULL
ORDER BY e.data_retirada;
```

Quatro tabelas, três condições de ligação. **A regra que evita o produto cartesiano: N tabelas exigem N−1 condições de junção.** Faltando uma, o resultado explode em linhas sem sentido — e não há erro, só um número absurdo de linhas.

| Junção | Devolve | Álgebra |
|---|---|---|
| `INNER JOIN` (ou só `JOIN`) | Só as linhas com par nas duas | `⋈` |
| `LEFT JOIN` | Todas da esquerda; nulos onde não há par | `⟕` |
| `RIGHT JOIN` | Todas da direita | `⟖` |
| `FULL JOIN` | Todas as duas | `⟗` |
| `CROSS JOIN` | Produto cartesiano | `×` |

O `LEFT JOIN` é o que responde perguntas com "inclusive os que não têm":

```sql
-- Todos os usuários, com a contagem de empréstimos (inclusive os que nunca pegaram nada)
SELECT u.nome, COUNT(e.id_emprestimo) AS total
FROM usuario u
LEFT JOIN emprestimo e ON u.matricula = e.matricula
GROUP BY u.matricula, u.nome
ORDER BY total DESC;
```

> ⚠️ **Repare em `COUNT(e.id_emprestimo)`, e não `COUNT(*)`.** Num `LEFT JOIN`, o usuário sem empréstimos aparece com uma linha de nulos — e `COUNT(*)` contaria essa linha, devolvendo **1** para quem nunca pegou nada. `COUNT(coluna)` ignora nulos e devolve **0**, que é a resposta certa. É a lógica de três valores da Aula 09 aparecendo onde ninguém espera.

> ⚠️ **Filtrar a tabela da direita no `WHERE` transforma seu `LEFT JOIN` em `INNER JOIN` sem avisar.** `WHERE e.situacao = 'x'` descarta as linhas de nulo que o `LEFT JOIN` criou. Para filtrar preservando o comportamento, a condição vai no `ON`.

## 4. Agrupamento e agregação

Funções de agregação: `COUNT`, `SUM`, `AVG`, `MAX`, `MIN`. Nenhuma delas existe na álgebra relacional clássica — são extensão prática do SQL.

```sql
SELECT o.titulo,
       COUNT(x.tombo)                                   AS total_exemplares,
       COUNT(*) FILTER (WHERE x.situacao = 'disponivel') AS disponiveis
FROM obra o
LEFT JOIN exemplar x ON o.isbn = x.isbn
GROUP BY o.isbn, o.titulo
HAVING COUNT(x.tombo) > 1
ORDER BY total_exemplares DESC;
```

**`WHERE` × `HAVING`** — a distinção que mais cai em avaliação:

| | Filtra | Roda | Pode usar agregação? |
|---|---|---|---|
| `WHERE` | **linhas**, antes de agrupar | Antes do `GROUP BY` | ❌ Não |
| `HAVING` | **grupos**, depois de agrupar | Depois do `GROUP BY` | ✅ Sim |

```sql
-- "obras publicadas depois de 2000 que têm mais de 2 exemplares"
SELECT o.titulo, COUNT(*) AS n
FROM obra o JOIN exemplar x ON o.isbn = x.isbn
WHERE  o.ano_publicacao > 2000     -- filtra LINHAS (antes)
GROUP BY o.isbn, o.titulo
HAVING COUNT(*) > 2;               -- filtra GRUPOS (depois)
```

> ⚠️ **A regra do `GROUP BY`:** todo campo do `SELECT` que não está dentro de uma agregação **precisa** estar no `GROUP BY`. Senão vem o erro campeão do curso: `column "o.titulo" must appear in the GROUP BY clause or be used in an aggregate function`. E faz sentido: se o grupo tem 40 linhas, *qual* dos 40 títulos o banco deveria devolver?

## 5. Subconsultas

Uma consulta dentro de outra. Três formas de usá-la:

**No `WHERE`, com `IN`:**

```sql
SELECT nome FROM usuario
WHERE matricula IN (SELECT matricula FROM emprestimo WHERE data_devolucao IS NULL);
```

**Correlacionada, com `EXISTS`** — a subconsulta referencia a externa e roda por linha:

```sql
SELECT u.nome FROM usuario u
WHERE EXISTS (SELECT 1 FROM emprestimo e
              WHERE e.matricula = u.matricula AND e.data_devolucao IS NULL);
```

**Negada, com `NOT EXISTS`** — os que **não** têm:

```sql
SELECT u.nome FROM usuario u
WHERE NOT EXISTS (SELECT 1 FROM emprestimo e WHERE e.matricula = u.matricula);
```

> ⚠️ **Prefira `NOT EXISTS` a `NOT IN`, sempre.** Se a subconsulta do `NOT IN` devolver um único nulo, o resultado inteiro vem **vazio**, sem erro e sem aviso — a armadilha da Aula 09, seção 5. `NOT EXISTS` trata nulos como você espera.

**No `FROM`**, como tabela derivada:

```sql
SELECT tipo, AVG(total) AS media_emprestimos
FROM (SELECT u.matricula, u.tipo, COUNT(e.id_emprestimo) AS total
      FROM usuario u LEFT JOIN emprestimo e ON u.matricula = e.matricula
      GROUP BY u.matricula, u.tipo) AS por_usuario
GROUP BY tipo;
```

### A divisão relacional em SQL

A operação `÷` da Aula 11 não tem sintaxe própria. Escreve-se com **dupla negação**: *"usuários para os quais não existe obra de 2020 que eles não tenham pego"*.

```sql
SELECT u.nome
FROM usuario u
WHERE NOT EXISTS (
    SELECT 1 FROM obra o
    WHERE o.ano_publicacao = 2020
      AND NOT EXISTS (
          SELECT 1
          FROM emprestimo e JOIN exemplar x ON e.tombo = x.tombo
          WHERE e.matricula = u.matricula AND x.isbn = o.isbn
      )
);
```

É a consulta mais difícil do curso. Leia de dentro para fora, e note que a estrutura é sempre a mesma: `NOT EXISTS ( ... AND NOT EXISTS ( ... ) )`.

## 6. `VIEW`: o nível externo, enfim

A `VIEW` é uma consulta guardada com nome, que se usa como se fosse tabela. É o **nível externo** da arquitetura em três níveis (Aula 02) tornado concreto:

```sql
CREATE VIEW emprestimos_em_aberto AS
SELECT u.matricula, u.nome, o.titulo, e.data_prevista,
       CURRENT_DATE - e.data_prevista AS dias_atraso
FROM emprestimo e
JOIN usuario  u ON e.matricula = u.matricula
JOIN exemplar x ON e.tombo     = x.tombo
JOIN obra     o ON x.isbn      = o.isbn
WHERE e.data_devolucao IS NULL;
```

```sql
SELECT * FROM emprestimos_em_aberto WHERE dias_atraso > 0;
```

O que a `VIEW` entrega:

- **Simplifica** — a junção de quatro tabelas vira um nome;
- **Protege** — dê `SELECT` na view e não na tabela, e o usuário vê só o recorte autorizado (Aula 15);
- **Isola** — se `USUARIO` for dividida em duas tabelas, a view absorve a mudança e os programas não percebem. É a **independência lógica** da Aula 02 acontecendo de verdade;
- **Documenta** — `dias_atraso` é o atributo derivado que a Aula 04 mandou não armazenar. Aqui ele é calculado na hora, sempre correto.

> 💡 A view **não guarda dados** — ela é reexecutada a cada consulta. Para guardar o resultado (e ganhar velocidade em troca de dados possivelmente desatualizados), existe `CREATE MATERIALIZED VIEW`, que precisa de `REFRESH` explícito.

> 💻 **Scripts desta aula:** [`03-consultas.sql`](exemplos/03-consultas.sql) — todas as consultas acima, rodando sobre a carga da Aula 13.

## 🏋️ Exercícios da aula

Na pasta `aula-14/` do seu repositório. Rode tudo com `psql -d curso_bd -v ON_ERROR_STOP=1 -f exNN.sql` e **cole a saída** em comentário.

1. **`ex01.sql`** — escreva a carga de dados do esquema que você criou na Aula 13: mínimo de **5 linhas por tabela**, na ordem correta de dependências, com dados coerentes (nomes reais, datas plausíveis, valores que fazem sentido). No fim do script, um `SELECT COUNT(*)` por tabela para conferir;
2. **`ex02.sql`** — cinco consultas com junção, cada uma com um comentário dizendo o que ela responde em português: (a) duas tabelas; (b) três tabelas; (c) um `LEFT JOIN` que mostre também os registros sem correspondência; (d) uma que use a mesma tabela duas vezes (autojunção, com `AS`); (e) uma com junção **e** filtro no `WHERE`;
3. **`ex03.sql`** — cinco consultas com agregação: (a) uma contagem simples; (b) um `GROUP BY` com `COUNT`; (c) um `GROUP BY` com `SUM` ou `AVG`; (d) uma com `HAVING`; (e) uma que combine `WHERE` **e** `HAVING`, com um comentário explicando por que cada filtro está onde está. Inclua também uma consulta **errada** de propósito (campo fora do `GROUP BY`) com a mensagem de erro colada;
4. **`ex04.sql`** — três subconsultas: (a) uma com `IN`; (b) uma com `EXISTS` correlacionada; (c) uma com `NOT EXISTS`. Depois escreva a versão (c) usando `NOT IN`, insira um nulo que faça o resultado ficar vazio, e cole as duas saídas lado a lado provando a diferença;
5. **Desafio 🌶️ `ex05.sql`** — (a) crie uma `VIEW` que junte pelo menos três tabelas e inclua um campo **derivado** (calculado); (b) escreva duas consultas sobre a view; (c) escreva uma consulta de **divisão relacional** sobre o seu esquema, no formato `NOT EXISTS`/`NOT EXISTS`, com um comentário traduzindo-a para português e outro mostrando a expressão `÷` correspondente da Aula 11.

## 🧠 Revisão

[8 questões de múltipla escolha](revisao/README.md) para conferir se os conceitos ficaram sólidos. Responda sem consultar a aula — depois volte e corrija.

## ✅ Entrega

```bash
git add aula-14/
git commit -m "Resolve exercícios da aula 14 (SQL DML e consultas)"
git push
```

---

⬅️ [Aula 13](../aula-13-sql-ddl/README.md) | ➡️ [Aula 15 — Projeto físico e transações](../aula-15-projeto-fisico-transacoes/README.md)
