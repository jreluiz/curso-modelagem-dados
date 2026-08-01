# Aula 13 — Revisão: Múltipla Escolha

> 🎯 8 questões sobre a [Aula 13 — SQL DDL: Criando o Esquema](../README.md). Só uma alternativa está correta em cada uma.

**Sem gabarito, de propósito.** Cada questão termina com a seção da aula onde a resposta está. Responda **tudo primeiro**, sem consultar — só depois volte às seções indicadas e corrija.

---

### Q-A13-01

Qual é a regra do curso sobre o script DDL?

- **a)** Que ele seja gerado por um cliente gráfico a partir do banco pronto;
- **b)** que ele fique no repositório e rode do zero, sempre — se o esquema não cabe num arquivo versionado, ele não existe;
- **c)** que ele seja executado apenas uma vez, na criação do banco, e depois arquivado;
- **d)** que ele seja dividido em um arquivo por tabela, para facilitar a revisão.

↩︎ *Aula 13, seção 1 — Do esquema ao script*

---

### Q-A13-02

O PostgreSQL respondeu `syntax error at or near ")"` no seu `CREATE TABLE`. Qual é a causa mais provável?

- **a)** Falta o ponto e vírgula no fim do comando;
- **b)** um tipo de dado foi escrito com nome inválido;
- **c)** a tabela já existe no banco;
- **d)** sobrou uma vírgula antes do parêntese que fecha: a última coluna ou restrição não leva vírgula.

↩︎ *Aula 13, seção 2 — `CREATE TABLE` e os tipos*

---

### Q-A13-03

Por que o curso insiste em dar nome às restrições com `CONSTRAINT nome`?

- **a)** Porque sem nome o PostgreSQL recusa a criação da tabela;
- **b)** porque restrições nomeadas são verificadas mais rápido;
- **c)** porque a mensagem de erro passa a falar de uma regra do seu modelo, e quem lê o erro entende o que aconteceu;
- **d)** porque só restrições nomeadas podem ser removidas depois com `ALTER TABLE`.

↩︎ *Aula 13, seção 3 — `NOT NULL`, `UNIQUE`, `CHECK`*

---

### Q-A13-04

O que `PRIMARY KEY` já implica, sem que você precise escrever?

- **a)** `NOT NULL` e `UNIQUE` — é a integridade de entidade inteira, numa palavra;
- **b)** `NOT NULL` apenas, porque a unicidade precisa ser declarada à parte;
- **c)** `CHECK` de domínio sobre a coluna;
- **d)** `ON DELETE RESTRICT` nas chaves estrangeiras que a referenciam.

↩︎ *Aula 13, seção 4 — `PRIMARY KEY` e `FOREIGN KEY`*

---

### Q-A13-05

Qual é a ação referencial padrão de uma `FOREIGN KEY` no PostgreSQL, quando nada é declarado?

- **a)** `RESTRICT`: a operação de exclusão é recusada;
- **b)** `CASCADE`: as linhas dependentes são apagadas junto;
- **c)** `SET NULL`: a coluna de FK é esvaziada;
- **d)** nenhuma: sem declaração explícita, a FK não é verificada na exclusão.

↩︎ *Aula 13, seção 5 — `ON DELETE` e `ON UPDATE`*

---

### Q-A13-06

`ALTER TABLE usuario ADD COLUMN nascimento DATE NOT NULL;` falhou numa tabela que já tem 400 linhas. Por quê?

- **a)** Porque `ALTER TABLE` não aceita colunas do tipo `DATE`;
- **b)** porque a tabela precisa estar vazia para qualquer `ALTER TABLE`;
- **c)** porque o banco não sabe o que pôr nas linhas existentes: ou se informa um `DEFAULT`, ou se adiciona a coluna opcional, preenche e só então torna obrigatória;
- **d)** porque a coluna precisa ser criada dentro de uma transação explícita.

↩︎ *Aula 13, seção 6 — `ALTER` e `DROP`*

---

### Q-A13-07

Num script que roda do zero repetidas vezes, em que ordem devem aparecer os `DROP TABLE`?

- **a)** Na mesma ordem dos `CREATE`, para manter a leitura coerente;
- **b)** em ordem alfabética, que é como o banco os processa;
- **c)** tanto faz, porque `DROP TABLE IF EXISTS` nunca falha;
- **d)** na ordem inversa à dos `CREATE`: primeiro quem aponta, depois quem é apontado.

↩︎ *Aula 13, seção 6 — `ALTER` e `DROP`*

---

### Q-A13-08

`ERROR: duplicate key value violates unique constraint "usuario_pk"` apareceu ao rodar a carga. O que aconteceu?

- **a)** O arquivo de carga tem uma linha com valor nulo na chave;
- **b)** a carga foi rodada duas vezes sobre o mesmo banco — a cura é rodar de novo o script que começa com `DROP TABLE IF EXISTS`;
- **c)** a chave primária foi declarada com o tipo errado;
- **d)** a tabela referenciada ainda não existe.

↩︎ *Aula 13, seção 7 — Os erros que você vai ver*

---

⬅️ [Voltar à Aula 13](../README.md) | ➡️ [Revisão da Aula 14](../../aula-14-sql-dml-e-select/revisao/README.md)
