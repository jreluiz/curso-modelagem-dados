# Aula 14 — Revisão: Múltipla Escolha

> 🎯 8 questões sobre a [Aula 14 — SQL DML e Consultas](../README.md). Só uma alternativa está correta em cada uma.

**Sem gabarito, de propósito.** Cada questão termina com a seção da aula onde a resposta está. Responda **tudo primeiro**, sem consultar — só depois volte às seções indicadas e corrija.

---

### Q-A14-01

Por que se deve sempre listar as colunas num `INSERT`?

- **a)** Porque o PostgreSQL recusa `INSERT` sem lista de colunas;
- **b)** porque omiti-las faz o comando depender da ordem física das colunas — uma ordem que o modelo relacional diz não existir, e que um `ALTER TABLE` futuro quebra em silêncio;
- **c)** porque a lista de colunas acelera a inserção;
- **d)** porque sem ela não é possível inserir várias tuplas de uma vez.

↩︎ *Aula 14, seção 1 — `INSERT`, `UPDATE`, `DELETE`*

---

### Q-A14-02

Qual é a ordem correta de carga num esquema com chaves estrangeiras?

- **a)** Primeiro as tabelas referenciadas (entidades fortes), depois as fracas e as associativas;
- **b)** primeiro as tabelas associativas, que ligam as demais;
- **c)** a ordem é irrelevante: o SGBD resolve as dependências sozinho;
- **d)** primeiro as tabelas com mais colunas.

↩︎ *Aula 14, seção 1 — `INSERT`, `UPDATE`, `DELETE`*

---

### Q-A14-03

`SELECT titulo, ano_publicacao AS ano FROM obra WHERE ano > 2000` falha com `column "ano" does not exist`. Por quê?

- **a)** Porque apelidos precisam ser declarados entre aspas duplas;
- **b)** porque `ano` é palavra reservada do SQL;
- **c)** porque o `WHERE` é executado antes do `SELECT`, então o apelido ainda não existe — no `ORDER BY`, que roda depois, ele funcionaria;
- **d)** porque apelidos só podem ser usados em consultas com junção.

↩︎ *Aula 14, seção 2 — `SELECT`: a estrutura e a ordem real*

---

### Q-A14-04

Numa consulta que junta 4 tabelas, quantas condições de junção são necessárias?

- **a)** Uma por tabela, ou seja, 4;
- **b)** duas, uma para cada par;
- **c)** depende da quantidade de chaves estrangeiras envolvidas;
- **d)** três — N tabelas exigem N−1 condições; faltando uma, o resultado explode em linhas sem sentido, e sem erro.

↩︎ *Aula 14, seção 3 — Junções*

---

### Q-A14-05

Num `LEFT JOIN` entre `usuario` e `emprestimo`, por que usar `COUNT(e.id_emprestimo)` em vez de `COUNT(*)`?

- **a)** Porque `COUNT(*)` não funciona junto com `GROUP BY`;
- **b)** porque `COUNT(*)` é mais lento em consultas com junção;
- **c)** porque o usuário sem empréstimos gera uma linha de nulos, e `COUNT(*)` a contaria, devolvendo 1 para quem nunca pegou nada; `COUNT(coluna)` ignora nulos e devolve 0;
- **d)** porque `COUNT(*)` só pode ser usado sem apelido de tabela.

↩︎ *Aula 14, seção 3 — Junções*

---

### Q-A14-06

Qual é a diferença entre `WHERE` e `HAVING`?

- **a)** `WHERE` filtra grupos e `HAVING` filtra linhas;
- **b)** os dois são equivalentes; `HAVING` é apenas a forma antiga;
- **c)** `HAVING` só pode ser usado sem `GROUP BY`;
- **d)** `WHERE` filtra linhas antes de agrupar e não aceita agregação; `HAVING` filtra grupos depois de agrupar e aceita.

↩︎ *Aula 14, seção 4 — Agrupamento e agregação*

---

### Q-A14-07

Por que preferir `NOT EXISTS` a `NOT IN`?

- **a)** Porque, se a subconsulta do `NOT IN` devolver um único nulo, o resultado inteiro vem vazio, sem erro e sem aviso;
- **b)** porque `NOT IN` não aceita subconsultas correlacionadas;
- **c)** porque `NOT IN` não é suportado pelo PostgreSQL;
- **d)** porque `NOT EXISTS` devolve as linhas ordenadas.

↩︎ *Aula 14, seção 5 — Subconsultas*

---

### Q-A14-08

Uma `VIEW` no SQL corresponde a que nível da arquitetura em três níveis?

- **a)** Ao nível interno, porque define como os dados são lidos do disco;
- **b)** ao nível externo: é o recorte que um grupo de usuários enxerga do esquema conceitual;
- **c)** ao nível conceitual, porque descreve todas as entidades;
- **d)** a nenhum: `VIEW` é um recurso de desempenho, fora da arquitetura.

↩︎ *Aula 14, seção 6 — `VIEW`: o nível externo, enfim*

---

⬅️ [Voltar à Aula 14](../README.md) | ➡️ [Revisão da Aula 15](../../aula-15-projeto-fisico-transacoes/revisao/README.md)
