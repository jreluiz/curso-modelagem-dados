# Aula 13 — Revisão: Múltipla Escolha

> 🎯 8 questões sobre a [Aula 13 — SQL DDL: Criando o Esquema](../README.md). Só uma alternativa está correta em cada uma.

**Sem gabarito, de propósito.** Cada questão termina com a seção da aula onde a resposta está. Responda **tudo primeiro**, sem consultar — só depois volte às seções indicadas e corrija.

---

### Q-A13-01

Por que o curso proíbe aspas duplas em nomes de tabela e coluna no PostgreSQL?

- **a)** Porque aspas duplas não são aceitas pelo padrão SQL;
- **b)** porque elas impedem a criação de índices sobre a coluna;
- **c)** porque o PostgreSQL normaliza identificadores não citados para minúsculas, mas preserva o que está entre aspas — `"Aluno"` e `aluno` viram nomes diferentes, e o nome citado passa a exigir aspas para sempre;
- **d)** porque aspas duplas são reservadas para valores de texto.

↩︎ *Aula 13, seção 1 — Do esquema relacional ao script*

---

### Q-A13-02

Qual tipo deve ser usado para armazenar valores monetários?

- **a)** `REAL`, por ocupar menos espaço;
- **b)** `DOUBLE PRECISION`, por ter maior precisão decimal;
- **c)** `FLOAT`, que é o tipo padrão para valores fracionários;
- **d)** `NUMERIC(p,s)`, porque os tipos binários não representam `0,10` exatamente e a diferença aparece no fechamento do caixa.

↩︎ *Aula 13, seção 2 — Tipos de dados*

---

### Q-A13-03

Por que a restrição `CHECK (data_devolucao IS NULL OR data_devolucao >= data_retirada)` precisa da primeira condição?

- **a)** Porque sem ela todo empréstimo em aberto seria rejeitado: comparação com nulo dá `UNKNOWN`, e ainda que o `CHECK` aceite `UNKNOWN`, escrever a condição deixa a intenção explícita e o comportamento previsível;
- **b)** porque o PostgreSQL não aceita `CHECK` com uma única condição;
- **c)** porque `IS NULL` é obrigatório em toda coluna opcional;
- **d)** porque a ordem das condições altera o plano de execução.

↩︎ *Aula 13, seção 3 — As restrições*

---

### Q-A13-04

Qual é a vantagem de escrever `CONSTRAINT ck_exemplar_situacao CHECK (...)` em vez de apenas `CHECK (...)`?

- **a)** A restrição nomeada é verificada mais rapidamente pelo SGBD;
- **b)** o erro em produção passa a citar o nome que você escolheu, e você sabe imediatamente qual regra foi violada;
- **c)** só restrições nomeadas podem ser removidas com `ALTER TABLE`;
- **d)** nomear é obrigatório para restrições que envolvem mais de uma coluna.

↩︎ *Aula 13, seção 3 — As restrições*

---

### Q-A13-05

Ao tentar `DELETE FROM obra WHERE isbn = '978-01'` numa obra que tem exemplares, com FK declarada `ON DELETE RESTRICT`, o que acontece?

- **a)** A obra é apagada e os exemplares ficam com `isbn` nulo;
- **b)** o comando é recusado com `violates foreign key constraint`, protegendo os exemplares de ficarem órfãos;
- **c)** a obra e os exemplares são apagados juntos;
- **d)** o comando é aceito, mas revertido automaticamente na próxima transação.

↩︎ *Aula 13, seção 4 — `ON DELETE` e `ON UPDATE` na prática*

---

### Q-A13-06

Uma tabela já tem 3 linhas e você precisa acrescentar a coluna `cpf`, obrigatória. Qual é a sequência correta?

- **a)** Adicionar aceitando nulo, preencher com `UPDATE`, depois `ALTER COLUMN ... SET NOT NULL`;
- **b)** `ADD COLUMN cpf VARCHAR(11) NOT NULL` diretamente, que o banco preenche com string vazia;
- **c)** apagar a tabela e recriá-la com a coluna nova;
- **d)** adicionar a coluna e criar um `CHECK` que a torne obrigatória.

↩︎ *Aula 13, seção 5 — `ALTER TABLE` e `DROP`*

---

### Q-A13-07

Num script que cria várias tabelas com chaves estrangeiras, qual é a ordem correta de criação e de remoção?

- **a)** A mesma ordem nos dois casos: alfabética;
- **b)** criar e apagar sempre na ordem em que aparecem no DER;
- **c)** a ordem é irrelevante quando se usa `CASCADE`;
- **d)** criar as referenciadas primeiro; ao apagar, o inverso — quem referencia sai antes.

↩︎ *Aula 13, seção 5 — `ALTER TABLE` e `DROP`*

---

### Q-A13-08

Qual comando do `psql` mostra como o banco realmente entendeu o seu DDL — colunas, tipos, restrições e chaves estrangeiras nos dois sentidos?

- **a)** `\l`;
- **b)** `\dt`;
- **c)** `\d nome_da_tabela`;
- **d)** `\di`.

↩︎ *Aula 13, seção 6 — Lendo os erros do PostgreSQL*

---

⬅️ [Voltar à Aula 13](../README.md) | ➡️ [Revisão da Aula 14](../../aula-14-sql-dml-consultas/revisao/README.md)
