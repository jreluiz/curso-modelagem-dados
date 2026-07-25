# Aula 09 — Revisão: Múltipla Escolha

> 🎯 8 questões sobre a [Aula 09 — O Modelo Relacional](../README.md). Só uma alternativa está correta em cada uma.

**Sem gabarito, de propósito.** Cada questão termina com a seção da aula onde a resposta está. Responda **tudo primeiro**, sem consultar — só depois volte às seções indicadas e corrija.

---

### Q-A09-01

Na relação `EXEMPLAR(tombo, isbn, data_aquisicao, situacao)` com 40 linhas, o **grau** e a **cardinalidade** são, respectivamente:

- **a)** 40 e 4;
- **b)** 4 e 4;
- **c)** 4 e 40;
- **d)** 40 e 40.

↩︎ *Aula 09, seção 1 — Relação, tupla, atributo, domínio*

---

### Q-A09-02

Por que um `SELECT` sem `ORDER BY` não tem ordem garantida?

- **a)** Porque o SQL sempre devolve as linhas em ordem aleatória, por segurança;
- **b)** porque uma relação é um conjunto, e conjuntos não têm ordem — se o resultado parece ordenado, é coincidência do plano de execução;
- **c)** porque o SGBD ordena pela chave primária apenas quando há índice;
- **d)** porque a ordem depende do cliente usado para consultar.

↩︎ *Aula 09, seção 2 — As propriedades de uma relação*

---

### Q-A09-03

Em que ponto o SQL **viola** a definição formal de relação?

- **a)** Ao permitir chaves compostas;
- **b)** ao aceitar valores nulos em colunas não chave;
- **c)** ao exigir que toda tabela tenha chave primária;
- **d)** ao aceitar linhas duplicadas numa tabela sem chave declarada — o que faz dele um trabalho com multiconjuntos, e não conjuntos.

↩︎ *Aula 09, seção 2 — As propriedades de uma relação*

---

### Q-A09-04

Uma chave estrangeira pode referenciar:

- **a)** Chave primária ou chave candidata (`UNIQUE`) da relação referenciada;
- **b)** qualquer atributo da relação referenciada, desde que do mesmo tipo;
- **c)** apenas a chave primária, nunca uma candidata;
- **d)** qualquer atributo, inclusive de relações diferentes da referenciada.

↩︎ *Aula 09, seção 3 — Chaves, com o vocabulário completo*

---

### Q-A09-05

Registrar `data_devolucao` anterior a `data_retirada` viola qual restrição de integridade?

- **a)** De entidade;
- **b)** referencial;
- **c)** de domínio;
- **d)** semântica (ou de negócio).

↩︎ *Aula 09, seção 4 — As quatro restrições de integridade*

---

### Q-A09-06

A consulta `SELECT * FROM emprestimo WHERE data_devolucao = NULL` devolve zero linhas mesmo havendo empréstimos em aberto. Por quê?

- **a)** Porque comparação com nulo resulta em `UNKNOWN`, e o `WHERE` só aceita linhas cujo resultado seja verdadeiro — a forma correta é `IS NULL`;
- **b)** porque `data_devolucao` é uma coluna de data e datas não aceitam nulo;
- **c)** porque falta um índice na coluna consultada;
- **d)** porque o `SELECT *` não funciona com colunas opcionais.

↩︎ *Aula 09, seção 5 — O valor nulo e seus três significados*

---

### Q-A09-07

`SELECT COUNT(*), COUNT(data_devolucao) FROM emprestimo` devolve `100, 73`. O que significa a diferença?

- **a)** Que 27 linhas estão corrompidas;
- **b)** que há 27 empréstimos em aberto: `COUNT(*)` conta linhas e `COUNT(coluna)` conta valores não nulos;
- **c)** que 27 empréstimos foram apagados e o contador não foi atualizado;
- **d)** que a tabela tem 27 linhas duplicadas.

↩︎ *Aula 09, seção 5 — O valor nulo e seus três significados*

---

### Q-A09-08

Em que situação `ON DELETE CASCADE` é a escolha **correta**?

- **a)** Sempre, porque evita erros de integridade referencial ao apagar registros;
- **b)** na FK de `EMPRESTIMO` para `USUARIO`, para limpar o histórico junto com o usuário;
- **c)** quando a entidade dependente não faz sentido sozinha — o caso da entidade fraca, como `TELEFONE` ou `RENOVACAO`;
- **d)** nunca: `RESTRICT` é sempre preferível, sem exceção.

↩︎ *Aula 09, seção 6 — Ações referenciais*

---

⬅️ [Voltar à Aula 09](../README.md) | ➡️ [Revisão da Aula 10](../../aula-10-mapeamento-er-relacional/revisao/README.md)
