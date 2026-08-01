# Aula 14 — SQL DML e o `SELECT` Simples

> 🎯 Objetivos: inserir, alterar e apagar linhas com segurança, consultar uma tabela com filtro e ordenação, e usar os operadores que o `=` não resolve — a começar pelo vazio.
> 🎬 Slides da aula: [apresentacao-14-sql-dml-e-select.pdf](apresentacao/apresentacao-14-sql-dml-e-select.pdf)

## 1. `INSERT`: sempre com a lista de colunas

```sql
INSERT INTO usuario (matricula, nome, email, categoria)
VALUES ('202500100', 'Joana Ribeiro', 'joana.ribeiro@escola.br', 'aluno');
```

`data_cadastro` não foi informada e o banco põe o `DEFAULT` que você declarou na Aula 13. Várias linhas cabem num comando só:

```sql
INSERT INTO area (codigo_area, nome) VALUES
    ('IA',  'Inteligência Artificial'),
    ('SEG', 'Segurança da Informação');
```

> ⚠️ **A lista de colunas é opcional em SQL e obrigatória neste curso.** Sem ela, os valores são posicionais — e a ordem das colunas é justamente o que o modelo relacional diz **não** existir (Aula 01). Um `ALTER TABLE` de alguém quebra o seu `INSERT` em silêncio, gravando e-mail na coluna de categoria. Escrever os nomes custa dez segundos e imuniza.

> ⚠️ **A ordem dos `INSERT` é a ordem das dependências:** primeiro as tabelas referenciadas, depois as que referenciam. Inverter produz `violates foreign key constraint`.

## 2. `UPDATE` e o `WHERE` que faltou

```sql
UPDATE exemplar SET situacao = 'disponivel' WHERE tombo = 4421;
```

Duas colunas de uma vez, separadas por vírgula:

```sql
UPDATE emprestimo
   SET data_devolucao = DATE '2026-03-14',
       data_prevista  = DATE '2026-03-16'
 WHERE id_emprestimo = 1;
```

> ⚠️ **`UPDATE` sem `WHERE` altera a tabela inteira.** Não há confirmação, não há aviso, e a resposta `UPDATE 4127` chega depois. É o erro mais caro desta aula.

> 📏 **Regra do curso, e vale para o resto da carreira:** escreva o comando primeiro como `SELECT`, confira o número de linhas, e só então troque `SELECT *` por `UPDATE … SET`. Em trabalho sério, embrulhe em transação:
>
> ```sql
> BEGIN;
> UPDATE exemplar SET situacao = 'disponivel' WHERE tombo = 4421;
> -- confira; se estiver errado: ROLLBACK;
> COMMIT;
> ```

## 3. `DELETE`

```sql
DELETE FROM reserva WHERE situacao = 'cancelada';
```

Vale tudo o que foi dito do `UPDATE`, com um agravante: não há como conferir depois. E as ações referenciais da Aula 13 entram em cena aqui — um `DELETE` numa tabela pode apagar linhas em outras, se você declarou `CASCADE`.

> ⚠️ **`DELETE` e `DROP` não são a mesma coisa.** `DELETE FROM reserva;` apaga todas as linhas e deixa a tabela de pé. `DROP TABLE reserva;` apaga a tabela inteira. O primeiro se desfaz dentro de uma transação; o segundo, não.

## 4. `SELECT`, `WHERE`, `ORDER BY`

O comando que você vai usar mais que todos os outros somados:

```sql
SELECT titulo, ano_publicacao, editora
  FROM obra
 WHERE ano_publicacao >= 2011
 ORDER BY ano_publicacao DESC;
```

```
          titulo          | ano_publicacao | editora
--------------------------+----------------+---------
 Engenharia de Software   |           2018 | Pearson
 Introdução à Estatística |           2015 | LTC
 Redes de Computadores    |           2011 | Pearson
```

Três partes, nesta ordem: **o que** trazer (`SELECT`), **de onde** (`FROM`), **quais linhas** (`WHERE`) e **em que ordem** (`ORDER BY`, com `ASC` ou `DESC`).

> ⚠️ **Sem `ORDER BY`, não há ordem garantida** — é a propriedade da Aula 01 aparecendo na prática. Se o resultado parece ordenado, é coincidência do plano de execução, e ela muda quando a tabela cresce.

> 💡 `SELECT *` traz todas as colunas e é ótimo para explorar. Em código que vai ficar, liste as colunas: é a independência lógica da Aula 10, e o custo é digitar.

## 5. Os operadores que o `=` não resolve

**`IS NULL` — o mais importante da aula.** A Aula 04 disse que nulo não é igual a nada, nem a si mesmo. Aqui está a consequência:

```sql
SELECT id_emprestimo, matricula, tombo, data_prevista
  FROM emprestimo
 WHERE data_devolucao IS NULL;      -- ✅ 4 empréstimos em aberto
```

```sql
SELECT id_emprestimo FROM emprestimo WHERE data_devolucao = NULL;
```
```
 id_emprestimo
---------------
(0 rows)
```

**Zero linhas, sem erro e sem aviso.** A comparação com nulo não deu falso — deu *desconhecido*, e o `WHERE` só aceita o que é verdadeiro. É a armadilha mais cara do SQL básico, porque ela não parece um erro: parece que não há empréstimos em aberto.

Os outros três:

| Operador | Para quê | Exemplo |
|---|---|---|
| `LIKE` | Texto que contém, começa ou termina | `titulo LIKE '%Software%'` |
| `BETWEEN` | Faixa de valores, inclusive as pontas | `ano_publicacao BETWEEN 2010 AND 2015` |
| `IN` | Um valor de uma lista | `categoria IN ('professor', 'servidor')` |

No `LIKE`, `%` casa com qualquer coisa e `_` casa com um caractere. `'%Software%'` acha "Engenharia de Software" e "Software Livre"; `'Software%'` acha só o segundo.

> ⚠️ Todos os três têm a forma negada — `NOT LIKE`, `NOT BETWEEN`, `NOT IN`. E o `NOT IN` guarda a mesma armadilha do nulo: se a lista contiver um único vazio, o resultado é vazio. A cura está nos [erros comuns](../../recursos/erros-comuns.md).

## 6. `DISTINCT` e `LIMIT`

```sql
SELECT DISTINCT editora FROM obra ORDER BY editora;   -- sem repetir
SELECT tombo, data_aquisicao FROM exemplar ORDER BY data_aquisicao LIMIT 3;
```

`DISTINCT` elimina linhas repetidas do resultado — e a necessidade dele é uma lembrança de que o SQL, ao contrário da teoria, aceita repetição. `LIMIT` corta o resultado, e é o que torna seguro explorar uma tabela de dez milhões de linhas.

> 💡 `LIMIT` sem `ORDER BY` devolve "três linhas quaisquer", não "as três primeiras" — porque não existem "primeiras" sem ordem declarada. Os dois andam juntos.

> 💻 **Script desta aula:** [`04-dml-select.sql`](exemplos/04-dml-select.sql) — todos os comandos acima. As demonstrações que alteram dados estão dentro de `BEGIN … ROLLBACK`, para o seu banco continuar igual.

> 📖 O capítulo de SQL do livro-base cobre a DML e o `SELECT` de uma tabela. As junções, que vêm na próxima aula, costumam estar no mesmo capítulo.

## 🏋️ Exercícios da aula

Na pasta `aula-14/` do seu repositório, com o banco da Biblioteca carregado:

1. **`ex01.sql`** — escreva a **carga de dados do seu modelo** (o do `ex01` da Aula 13): no mínimo 5 linhas por tabela, com a lista de colunas sempre explícita e na ordem correta das dependências. *Confira assim: rode o seu DDL e depois a carga, do zero; se algum `INSERT` falhar por FK, a ordem está errada.*
2. **`ex02.sql`** — na Biblioteca, escreva e rode: (a) registrar a devolução do empréstimo 2 hoje; (b) mudar a situação do exemplar 4418 para `disponivel`; (c) as duas coisas dentro de **uma transação**, com `SELECT` de conferência antes e depois. Cole a saída. *Confira assim: as duas alterações descrevem o mesmo evento do mundo — se uma acontecer sem a outra, o banco fica mentindo.*
3. **`ex03.sql`** — cinco consultas sobre a Biblioteca, cada uma com o resultado colado: (a) obras publicadas depois de 2010, da mais nova para a mais antiga; (b) usuários que não são alunos; (c) exemplares que não estão disponíveis; (d) obras cujo título contém "de"; (e) empréstimos com retirada em março de 2026. *Confira assim: some as linhas de (b) e as de "usuários alunos" — o total tem que dar 6.*
4. **`ex04.sql`** — sobre nulos: (a) liste os empréstimos em aberto; (b) rode a mesma consulta com `= NULL` e explique o resultado em três linhas; (c) conte quantos empréstimos existem e quantos têm devolução registrada, num comando só, e explique por que os dois números diferem; (d) liste as multas que **não** foram perdoadas. *Confira assim: o item (c) precisa devolver dois números numa linha só, e a diferença entre eles é a resposta de (a).*
5. **Desafio 🌶️ `ex05.sql`** — alguém rodou `UPDATE exemplar SET situacao = 'disponivel';` sem `WHERE` no banco da Biblioteca. (a) Descreva o estrago exato: quantas linhas mudaram e que informação do mundo real se perdeu; (b) escreva a consulta que, usando **outra tabela**, permite reconstruir a situação correta de cada exemplar; (c) escreva o `UPDATE` que faz a correção; (d) escreva a versão preventiva do comando original — o `SELECT` que deveria ter sido escrito antes. Rode tudo dentro de uma transação e desfaça ao final. *Confira assim: a tabela que salva a reconstrução é a de empréstimos, e a chave está em quais deles ainda estão em aberto.*

## 🧠 Revisão

[8 questões de múltipla escolha](revisao/README.md) para conferir se os conceitos ficaram sólidos. Responda sem consultar a aula — depois volte e corrija.

## ✅ Entrega

```bash
psql -d curso_bd -v ON_ERROR_STOP=1 -f ex01.sql
git add aula-14/
git commit -m "Resolve exercícios da aula 14 (DML e SELECT)"
git push
```

---

⬅️ [Aula 13](../aula-13-sql-ddl/README.md) | ➡️ [Aula 15 — Junções e agregação](../aula-15-juncoes-e-agregacao/README.md)
