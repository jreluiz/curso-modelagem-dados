# Aula 15 — Revisão: Múltipla Escolha

> 🎯 8 questões sobre a [Aula 15 — Projeto Físico, Índices e Transações](../README.md). Só uma alternativa está correta em cada uma.

**Sem gabarito, de propósito.** Cada questão termina com a seção da aula onde a resposta está. Responda **tudo primeiro**, sem consultar — só depois volte às seções indicadas e corrija.

---

### Q-A15-01

Toda a discussão de desempenho em banco de dados gira em torno de qual objetivo?

- **a)** Aumentar a quantidade de memória disponível ao servidor;
- **b)** reduzir o número de tabelas do esquema;
- **c)** diminuir a quantidade de restrições verificadas;
- **d)** reduzir o número de páginas lidas do disco.

↩︎ *Aula 15, seção 1 — O que acontece embaixo*

---

### Q-A15-02

Por que a árvore B⁺ é a estrutura padrão de índice?

- **a)** Porque ocupa menos espaço que qualquer outra estrutura;
- **b)** porque dispensa atualização quando os dados mudam;
- **c)** porque se mantém equilibrada: todos os caminhos da raiz à folha têm o mesmo comprimento, que cresce logaritmicamente — 3 ou 4 níveis para 1 milhão de linhas;
- **d)** porque permite armazenar os dados diretamente nas folhas, dispensando a tabela.

↩︎ *Aula 15, seção 2 — Índice e a árvore B*

---

### Q-A15-03

Em qual coluna **não** vale a pena criar índice?

- **a)** Numa chave estrangeira usada em toda junção;
- **b)** em `situacao`, que tem 4 valores distintos — baixa seletividade faz o otimizador ignorar o índice, e ele ainda custa em toda escrita;
- **c)** numa coluna frequentemente usada em `ORDER BY`;
- **d)** numa coluna com muitos valores distintos usada em `WHERE`.

↩︎ *Aula 15, seção 3 — Quando criar — e o preço de criar demais*

---

### Q-A15-04

Qual é o custo permanente de manter um índice?

- **a)** Ele ocupa espaço e precisa ser atualizado a cada `INSERT`, `UPDATE` e `DELETE` — uma tabela com oito índices tem toda escrita multiplicada por nove;
- **b)** ele precisa ser reconstruído manualmente toda semana;
- **c)** ele impede o uso de chaves estrangeiras na mesma coluna;
- **d)** ele bloqueia a tabela durante as consultas.

↩︎ *Aula 15, seção 3 — Quando criar — e o preço de criar demais*

---

### Q-A15-05

Num plano de execução, qual é o sinal **mais útil** de que algo está errado?

- **a)** A estimativa `rows=N` muito diferente do `actual rows=N` — indica estatísticas desatualizadas;
- **b)** a presença de `Seq Scan`, que sempre indica falta de índice;
- **c)** um valor de `cost` acima de 1000, que é o limite aceitável;
- **d)** um `Execution Time` maior que o `Planning Time`.

↩︎ *Aula 15, seção 4 — `EXPLAIN`: lendo o plano*

---

### Q-A15-06

Qual letra do ACID garante que, se a energia cair no meio de uma transação, nenhum efeito parcial permaneça?

- **a)** Consistência;
- **b)** atomicidade;
- **c)** isolamento;
- **d)** durabilidade.

↩︎ *Aula 15, seção 5 — Transação e ACID*

---

### Q-A15-07

No PostgreSQL, o que acontece com um `UPDATE` executado sem `BEGIN`?

- **a)** Ele fica pendente até o próximo `COMMIT` explícito;
- **b)** ele é recusado, porque comandos de escrita exigem transação;
- **c)** ele é confirmado no instante em que roda (*autocommit*), e não há como desfazer;
- **d)** ele é aplicado apenas na sessão atual, até a desconexão.

↩︎ *Aula 15, seção 5 — Transação e ACID*

---

### Q-A15-08

T1 altera um dado, T2 o lê, e então T1 dá `ROLLBACK`. T2 trabalhou com um valor que nunca existiu oficialmente. Como se chama isso, e qual o nível mínimo que o evita?

- **a)** Atualização perdida, evitada por `READ UNCOMMITTED`;
- **b)** leitura não repetível, evitada por `READ COMMITTED`;
- **c)** leitura fantasma, evitada por `REPEATABLE READ`;
- **d)** leitura suja (*dirty read*), evitada a partir de `READ COMMITTED`.

↩︎ *Aula 15, seção 6 — Concorrência: o que o isolamento evita*

---

⬅️ [Voltar à Aula 15](../README.md) | ➡️ [Revisão da Aula 16](../../aula-16-revisao-proximos-passos/revisao/README.md)
