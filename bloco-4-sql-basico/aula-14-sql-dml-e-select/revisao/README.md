# Aula 14 — Revisão: Múltipla Escolha

> 🎯 8 questões sobre a [Aula 14 — SQL DML e o `SELECT` Simples](../README.md). Só uma alternativa está correta em cada uma.

**Sem gabarito, de propósito.** Cada questão termina com a seção da aula onde a resposta está. Responda **tudo primeiro**, sem consultar — só depois volte às seções indicadas e corrija.

---

### Q-A14-01

Por que o curso exige a lista de colunas no `INSERT`, mesmo sendo ela opcional em SQL?

- **a)** Porque sem ela o PostgreSQL recusa o comando;
- **b)** porque a lista de colunas acelera a inserção de muitas linhas;
- **c)** porque sem ela os valores são posicionais, e um `ALTER TABLE` de outra pessoa quebra o seu `INSERT` em silêncio, gravando o valor na coluna errada;
- **d)** porque só com a lista de colunas é possível inserir mais de uma linha por comando.

↩︎ *Aula 14, seção 1 — `INSERT`: sempre com a lista de colunas*

---

### Q-A14-02

Em que ordem os `INSERT` de uma carga devem ser escritos?

- **a)** Na ordem das dependências: primeiro as tabelas referenciadas, depois as que referenciam;
- **b)** em ordem alfabética de nome de tabela;
- **c)** na ordem inversa da criação das tabelas;
- **d)** tanto faz, porque o banco reordena as inserções automaticamente.

↩︎ *Aula 14, seção 1 — `INSERT`: sempre com a lista de colunas*

---

### Q-A14-03

Qual é a regra do curso para escrever um `UPDATE` com segurança?

- **a)** Rodar sempre com o usuário administrador, que pode desfazer qualquer alteração;
- **b)** escrever o comando primeiro como `SELECT`, conferir o número de linhas, e só então trocar por `UPDATE … SET`;
- **c)** limitar a alteração a uma coluna por comando;
- **d)** fazer um backup completo antes de cada alteração.

↩︎ *Aula 14, seção 2 — `UPDATE` e o `WHERE` que faltou*

---

### Q-A14-04

O resultado de um `SELECT` sem `ORDER BY` apareceu ordenado por data. O que se pode concluir?

- **a)** Que a tabela guarda as linhas fisicamente ordenadas por essa coluna;
- **b)** que o banco ordena pela chave primária quando nada é pedido;
- **c)** que existe um índice na coluna de data, e ele define a ordem do resultado;
- **d)** nada: sem `ORDER BY` não há ordem garantida, e essa coincidência do plano de execução muda quando a tabela cresce.

↩︎ *Aula 14, seção 4 — `SELECT`, `WHERE`, `ORDER BY`*

---

### Q-A14-05

`SELECT id_emprestimo FROM emprestimo WHERE data_devolucao = NULL;` devolveu zero linhas, embora existam quatro empréstimos em aberto. Por quê?

- **a)** Porque a coluna `data_devolucao` não existe na tabela;
- **b)** porque faltou aspas simples em torno de `NULL`;
- **c)** porque o `WHERE` só aceita comparações entre colunas do mesmo tipo;
- **d)** porque a comparação com nulo não deu falso: deu desconhecido, e o `WHERE` só aceita o que é verdadeiro — a forma certa é `IS NULL`.

↩︎ *Aula 14, seção 5 — Os operadores que o `=` não resolve*

---

### Q-A14-06

Qual das opções descreve corretamente o `BETWEEN`?

- **a)** Filtra uma faixa de valores excluindo as pontas;
- **b)** filtra uma faixa de valores incluindo as duas pontas;
- **c)** compara um valor com uma lista de possibilidades;
- **d)** casa um trecho de texto usando `%` e `_`.

↩︎ *Aula 14, seção 5 — Os operadores que o `=` não resolve*

---

### Q-A14-07

Que armadilha o `NOT IN` guarda?

- **a)** Se a lista contiver um único valor vazio, o resultado inteiro fica vazio;
- **b)** ele ignora silenciosamente os valores repetidos da lista;
- **c)** ele só funciona com colunas de texto;
- **d)** ele exige que a lista tenha no mínimo dois valores.

↩︎ *Aula 14, seção 5 — Os operadores que o `=` não resolve*

---

### Q-A14-08

`SELECT tombo FROM exemplar LIMIT 3;` devolve o quê?

- **a)** Os três primeiros exemplares cadastrados, na ordem de inserção;
- **b)** os três exemplares de menor tombo;
- **c)** três linhas quaisquer, porque não existem "primeiras" sem ordem declarada;
- **d)** um erro, porque `LIMIT` exige `ORDER BY` no PostgreSQL.

↩︎ *Aula 14, seção 6 — `DISTINCT` e `LIMIT`*

---

⬅️ [Voltar à Aula 14](../README.md) | ➡️ [Revisão da Aula 15](../../aula-15-juncoes-e-agregacao/revisao/README.md)
