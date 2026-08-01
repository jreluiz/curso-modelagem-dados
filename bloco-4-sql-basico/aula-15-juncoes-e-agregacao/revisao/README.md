# Aula 15 — Revisão: Múltipla Escolha

> 🎯 8 questões sobre a [Aula 15 — Junções e Agregação](../README.md). Só uma alternativa está correta em cada uma.

**Sem gabarito, de propósito.** Cada questão termina com a seção da aula onde a resposta está. Responda **tudo primeiro**, sem consultar — só depois volte às seções indicadas e corrija.

---

### Q-A15-01

Por que a aula diz que "a junção é o preço da normalização, e ela é barata"?

- **a)** Porque se paga uma linha de SQL para reunir o que foi separado por bons motivos, enquanto o outro caminho seria pagar com dado contraditório todos os dias;
- **b)** porque junções são executadas em memória e não tocam o disco;
- **c)** porque o banco cria índices automáticos para toda junção;
- **d)** porque uma junção sempre devolve menos linhas que a consulta original.

↩︎ *Aula 15, seção 1 — Por que os dados estão em duas tabelas*

---

### Q-A15-02

Você não sabe o que escrever no `ON` de uma junção. Onde está a resposta?

- **a)** Na ordem em que as tabelas foram criadas no script DDL;
- **b)** na primeira coluna de cada uma das duas tabelas;
- **c)** no diagrama: a linha que liga as duas tabelas é a chave estrangeira encontrando a chave primária;
- **d)** em qualquer par de colunas do mesmo tipo, porque o banco resolve o resto.

↩︎ *Aula 15, seção 2 — `INNER JOIN`*

---

### Q-A15-03

Uma junção entre duas tabelas de 6 linhas cada devolveu 36 linhas visivelmente repetitivas. O que aconteceu?

- **a)** As duas tabelas têm chaves primárias duplicadas;
- **b)** faltou `DISTINCT` na consulta;
- **c)** a junção foi feita na direção errada;
- **d)** o `ON` foi esquecido, e o resultado é o produto cartesiano: cada linha de uma combinada com cada linha da outra.

↩︎ *Aula 15, seção 2 — `INNER JOIN`*

---

### Q-A15-04

O acervo tem cinco obras, e a consulta com `JOIN` entre `obra`, `escrita` e `autor` devolveu quatro títulos. O que explica a diferença?

- **a)** Uma das obras tem dois autores, e o banco removeu a linha repetida;
- **b)** uma obra não tem autor cadastrado, e o `INNER JOIN` a descartou em silêncio — o `LEFT JOIN` a traria de volta com o autor vazio;
- **c)** o `JOIN` limita o resultado às quatro primeiras linhas;
- **d)** a quinta obra tem ISBN inválido e foi recusada pela junção.

↩︎ *Aula 15, seção 3 — `LEFT JOIN` e o que ele revela*

---

### Q-A15-05

`count(*)` devolveu 6 e `count(data_devolucao)` devolveu 2 na mesma tabela. Por quê?

- **a)** Porque `count(*)` conta também as linhas apagadas;
- **b)** porque `count(coluna)` conta apenas os valores não vazios, e a diferença entre os dois é o número de empréstimos em aberto;
- **c)** porque `count(*)` inclui as linhas de outras tabelas ligadas por chave estrangeira;
- **d)** porque `count(coluna)` conta valores distintos.

↩︎ *Aula 15, seção 4 — Contar, somar, medir*

---

### Q-A15-06

`ERROR: column "u.nome" must appear in the GROUP BY clause or be used in an aggregate function`. O que esse erro está dizendo?

- **a)** Que a coluna `nome` não existe na tabela `usuario`;
- **b)** que faltou o apelido `u` na cláusula `FROM`;
- **c)** que o `GROUP BY` não aceita colunas de texto;
- **d)** que você pediu um valor de linha ao lado de um resultado de grupo, e o banco não tem como escolher qual dos nomes do grupo mostrar.

↩︎ *Aula 15, seção 5 — `GROUP BY`: um resultado por grupo*

---

### Q-A15-07

Por que não é possível escrever `WHERE count(x.tombo) > 1`?

- **a)** Porque `count` só pode aparecer na cláusula `SELECT`;
- **b)** porque o `WHERE` não aceita comparações numéricas com funções;
- **c)** porque na hora em que o `WHERE` roda ainda não existe contagem nenhuma: filtrar grupos é papel do `HAVING`;
- **d)** porque `count(*)` e `count(coluna)` dariam resultados diferentes na mesma consulta.

↩︎ *Aula 15, seção 6 — `HAVING`: filtrar grupos*

---

### Q-A15-08

O que uma `VIEW` protege quando o esquema muda por baixo dela?

- **a)** A tela de quem a consulta: basta reescrever a `VIEW` e o usuário continua pedindo o mesmo nome — é a independência lógica da Aula 10;
- **b)** os dados, porque a `VIEW` guarda uma cópia deles;
- **c)** o desempenho, porque a `VIEW` mantém o resultado em memória;
- **d)** as permissões, porque toda `VIEW` é somente leitura por definição.

↩︎ *Aula 15, seção 7 — Subconsulta e `VIEW`*

---

⬅️ [Voltar à Aula 15](../README.md) | ➡️ [Revisão da Aula 16](../../aula-16-revisao-proximos-passos/revisao/README.md)
