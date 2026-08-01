# Aula 15 — Junções e Agregação

> 🎯 Objetivos: reunir dados de várias tabelas com `JOIN`, reconhecer o que o `LEFT JOIN` revela e o `INNER JOIN` esconde, e produzir resumos com `GROUP BY` e `HAVING`.
> 🎬 Slides da aula: [apresentacao-15-juncoes-e-agregacao.pdf](apresentacao/apresentacao-15-juncoes-e-agregacao.pdf)

## 1. Por que os dados estão em duas tabelas

A Aula 07 separou o nome do usuário do empréstimo, para o nome não estar escrito em vinte lugares. Ótimo para guardar — e agora a tela do atendente precisa dos dois juntos.

**A junção é o preço da normalização, e ela é barata.** Você paga uma linha de SQL para reunir o que separou por bons motivos; o outro caminho seria pagar com dado contraditório, todo dia, para sempre.

```
   emprestimo                          usuario
   ┌────┬───────────┬─────┐            ┌───────────┬────────────┐
   │ id │ matricula │ ... │            │ matricula │ nome       │
   ├────┼───────────┼─────┤            ├───────────┼────────────┤
   │  1 │ 202310100 │     │───────────►│ 202310100 │ Ana Souza  │
   │  3 │ 202310200 │     │───────────►│ 202310200 │ Bruno Lima │
   └────┴───────────┴─────┘            └───────────┴────────────┘
                    a junção percorre a chave estrangeira
```

## 2. `INNER JOIN`

```sql
SELECT e.id_emprestimo, u.nome, e.data_retirada
  FROM emprestimo e
  JOIN usuario u ON u.matricula = e.matricula
 ORDER BY e.id_emprestimo;
```

```
 id_emprestimo |     nome     | data_retirada
---------------+--------------+---------------
             1 | Ana Souza    | 2026-03-02
             3 | Bruno Lima   | 2026-03-09
             4 | Daniel Prado | 2026-01-15
```

Três coisas na sintaxe: o **apelido** da tabela (`emprestimo e`), que encurta tudo o que vem depois; o `ON`, que diz **por onde** as tabelas se ligam; e o prefixo `u.`, que remove a ambiguidade quando as duas têm coluna de mesmo nome.

E a junção não para em duas tabelas. Para saber quem está com qual obra são quatro, porque o empréstimo aponta para o exemplar e o exemplar é que aponta para a obra:

```sql
SELECT u.nome AS usuario, o.titulo AS obra, x.tombo, e.data_prevista
  FROM emprestimo e
  JOIN usuario  u ON u.matricula = e.matricula
  JOIN exemplar x ON x.tombo     = e.tombo
  JOIN obra     o ON o.isbn      = x.isbn
 WHERE e.data_devolucao IS NULL
 ORDER BY e.data_prevista;
```

> 💡 **O `ON` é sempre a chave estrangeira encontrando a chave primária.** Se você não souber o que escrever no `ON`, volte ao diagrama: a linha que liga as duas tabelas é a resposta. E se não houver linha, as tabelas não se ligam — junção não inventa relacionamento.

> ⚠️ **Esquecer o `ON` produz o produto cartesiano:** cada linha de uma tabela combinada com cada linha da outra. Com 6 empréstimos e 6 usuários, 36 linhas de lixo. O sintoma é um resultado grande demais e visivelmente repetitivo.

## 3. `LEFT JOIN` e o que ele revela

O `INNER JOIN` só devolve linhas que têm par dos **dois** lados. Isso é o que você quer quase sempre — e é uma armadilha quando não é.

O acervo tem cinco obras. Esta consulta devolve quatro:

```sql
SELECT o.titulo, a.nome AS autor
  FROM obra o
  JOIN escrita s ON s.isbn     = o.isbn
  JOIN autor   a ON a.id_autor = s.id_autor;
```

"Introdução à Estatística" **sumiu** — ela existe, tem exemplar na prateleira, e não tem autor cadastrado. O `INNER JOIN` a descartou em silêncio.

```sql
  LEFT JOIN escrita s ON s.isbn     = o.isbn
  LEFT JOIN autor   a ON a.id_autor = s.id_autor
```

```
             titulo             |       autor
--------------------------------+--------------------
 Introdução à Estatística       |
 Redes de Computadores          | Andrew Tanenbaum
 Redes de Computadores          | David Wetherall
```

O `LEFT JOIN` mantém **todas** as linhas da tabela da esquerda e preenche com vazio o que não tem par. E daí sai o uso mais valioso dele — **encontrar o que não tem par**:

```sql
SELECT o.isbn, o.titulo
  FROM obra o
  LEFT JOIN escrita s ON s.isbn = o.isbn
 WHERE s.isbn IS NULL;              -- obras sem nenhum autor
```

> 📏 **Regra prática:** quando um relatório vier com menos linhas do que você esperava, troque o `JOIN` por `LEFT JOIN` antes de procurar erro em qualquer outro lugar. Na maioria das vezes o dado está lá, e a junção o descartou.

## 4. Contar, somar, medir

As funções de agregação transformam **muitas linhas em um valor**:

| Função | O que faz |
|---|---|
| `count(*)` | Conta linhas |
| `count(coluna)` | Conta valores **não vazios** daquela coluna |
| `sum`, `avg` | Soma, média |
| `min`, `max` | Menor, maior |

```sql
SELECT count(*)              AS total_emprestimos,
       count(data_devolucao) AS ja_devolvidos
  FROM emprestimo;
```
```
 total_emprestimos | ja_devolvidos
-------------------+---------------
                 6 |             2
```

> 💡 **A diferença entre os dois números é a resposta de "quantos estão em aberto?"** — porque `count(coluna)` ignora os vazios. É um truque útil, e uma armadilha para quem espera que os dois contem a mesma coisa.

## 5. `GROUP BY`: um resultado por grupo

Sem `GROUP BY`, a agregação devolve uma linha. Com ele, devolve uma **por grupo**:

```sql
SELECT u.categoria, count(*) AS emprestimos
  FROM emprestimo e
  JOIN usuario u ON u.matricula = e.matricula
 GROUP BY u.categoria;
```
```
 categoria | emprestimos
-----------+-------------
 aluno     |           5
 professor |           1
```

> ⚠️ **O erro mais comum de todas as aulas de SQL:**
>
> ```
> ERROR:  column "u.nome" must appear in the GROUP BY clause
>         or be used in an aggregate function
> ```
>
> Você pediu um valor de linha ao lado de um resultado de grupo. Se o grupo "aluno" tem cinco empréstimos de três pessoas, **qual nome** o banco deveria mostrar? Todo campo do `SELECT` que não está dentro de uma função de agregação precisa estar no `GROUP BY`. Ou agrupe por ele, ou agregue-o, ou tire-o da consulta.

## 6. `HAVING`: filtrar grupos

`WHERE` filtra **linhas**, antes do agrupamento. `HAVING` filtra **grupos**, depois:

```sql
SELECT o.titulo, count(x.tombo) AS exemplares
  FROM obra o
  JOIN exemplar x ON x.isbn = o.isbn
 GROUP BY o.isbn, o.titulo
HAVING count(x.tombo) > 1;
```

Não dá para escrever `WHERE count(...) > 1`: na hora em que o `WHERE` roda, ainda não existe contagem nenhuma. A ordem é sempre `FROM` → `WHERE` → `GROUP BY` → `HAVING` → `ORDER BY`.

## 7. Subconsulta e `VIEW`

Uma consulta dentro da outra, para perguntar "existe?":

```sql
SELECT u.matricula, u.nome
  FROM usuario u
 WHERE NOT EXISTS (SELECT 1 FROM emprestimo e WHERE e.matricula = u.matricula);
```

> ⚠️ Existe uma forma parecida com `NOT IN`, e ela tem a armadilha do nulo: se a subconsulta devolver um único vazio, o resultado inteiro é vazio, sem erro. Prefira `NOT EXISTS`. O detalhe está nos [erros comuns](../../recursos/erros-comuns.md).

E a `VIEW` é uma consulta com nome guardado — o **nível externo** da Aula 10, virando comando:

```sql
CREATE OR REPLACE VIEW emprestimos_em_aberto AS
SELECT e.id_emprestimo, u.nome AS usuario, o.titulo AS obra,
       e.data_prevista, CURRENT_DATE - e.data_prevista AS dias_de_atraso
  FROM emprestimo e
  JOIN usuario  u ON u.matricula = e.matricula
  JOIN exemplar x ON x.tombo     = e.tombo
  JOIN obra     o ON o.isbn      = x.isbn
 WHERE e.data_devolucao IS NULL;

SELECT * FROM emprestimos_em_aberto;    -- daqui em diante, é como se fosse uma tabela
```

O atendente consulta `emprestimos_em_aberto` e nunca precisa saber que são quatro tabelas. Se o esquema mudar por baixo, você reescreve a `VIEW` e a tela dele continua funcionando: é a independência lógica que a Aula 10 prometeu.

> 💻 **Script desta aula:** [`05-juncoes-agregacao.sql`](exemplos/05-juncoes-agregacao.sql) — todas as consultas acima, com os resultados.

> 📖 As junções são a versão prática de uma teoria chamada **álgebra relacional**, que este curso não trata. Se você quiser ver de onde o `JOIN` veio, o [guia de links](../../recursos/links-uteis.md) tem por onde começar.

## 🏋️ Exercícios da aula

Na pasta `aula-15/` do seu repositório, com o banco da Biblioteca carregado:

1. **`ex01.sql`** — quatro consultas com junção de **duas** tabelas, cada uma com o resultado colado: (a) exemplares com o título da obra; (b) reservas com o nome de quem reservou; (c) empréstimos com o nome do funcionário que os registrou; (d) telefones com o nome do dono. *Confira assim: nenhuma das quatro pode devolver mais linhas que a tabela do lado N — se devolver, falta condição no `ON`.*
2. **`ex02.sql`** — duas consultas com junção de **três ou mais** tabelas: (a) quem está com qual obra, hoje, em aberto; (b) as áreas de conhecimento de cada obra, com o nome da área e o título. Cole os resultados. *Confira assim: em (a) o caminho passa obrigatoriamente por `exemplar` — empréstimo não aponta para obra.*
3. **`ex03.sql`** — cinco resumos com `GROUP BY`: (a) empréstimos por usuário; (b) exemplares por situação; (c) obras por editora; (d) reservas por situação; (e) obras por área. Ordene cada um do maior para o menor. *Confira assim: a soma das contagens de (b) tem que dar 7, o total de exemplares.*
4. **`ex04.sql`** — usando `LEFT JOIN` e `HAVING`: (a) liste **todas** as obras com a contagem de exemplares, incluindo as que têm zero; (b) liste os usuários que têm mais de um empréstimo; (c) liste os autores que não escreveram nenhuma obra cadastrada; (d) explique em três linhas por que (a) precisa de `LEFT JOIN` e (b) precisa de `HAVING`. *Confira assim: se (a) devolver 5 linhas, está certo; se devolver menos, você usou `JOIN` em vez de `LEFT JOIN`.*
5. **Desafio 🌶️ `ex05.sql`** — monte o **relatório mensal da biblioteca** numa consulta só, com no mínimo três tabelas, `GROUP BY`, `HAVING` e ordenação: por categoria de usuário, quantos empréstimos, quantos ainda em aberto e qual a média de dias entre retirada e devolução dos já devolvidos — mostrando apenas as categorias com mais de um empréstimo. Depois transforme a consulta numa `VIEW` chamada `relatorio_mensal` e explique, em três linhas, o que essa `VIEW` protege quando o esquema mudar. *Confira assim: a média precisa ignorar os empréstimos em aberto — se a sua conta incluir os vazios, o número vai sair errado sem avisar.*

## 🧠 Revisão

[8 questões de múltipla escolha](revisao/README.md) para conferir se os conceitos ficaram sólidos. Responda sem consultar a aula — depois volte e corrija.

## ✅ Entrega

```bash
psql -d curso_bd -v ON_ERROR_STOP=1 -f ex05.sql
git add aula-15/
git commit -m "Resolve exercícios da aula 15 (junções e agregação)"
git push
```

> 🎓 **É aqui que começa o [projeto final](../../projetos/projeto-final.md)** — do minimundo ao banco rodando. Você já tem todas as peças.

---

⬅️ [Aula 14](../aula-14-sql-dml-e-select/README.md) | ➡️ [Aula 16 — Revisão e próximos passos](../aula-16-revisao-proximos-passos/README.md)
