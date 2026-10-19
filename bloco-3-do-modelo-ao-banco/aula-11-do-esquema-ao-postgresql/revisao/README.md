# Aula 11 — Revisão: Múltipla Escolha

> 🎯 8 questões sobre a [Aula 11 — Do Esquema ao PostgreSQL](../README.md). Só uma alternativa está correta em cada uma.

**Sem gabarito, de propósito.** Cada questão termina com a seção da aula onde a resposta está. Responda **tudo primeiro**, sem consultar — só depois volte às seções indicadas e corrija.

As três últimas são marcadas **[ENADE]**: trazem um **texto-base** com uma situação concreta, seguido do comando. São mais longas de ler e cobram interpretação, não memória — as alternativas continuam simples, como nas demais.

---

### Q-A11-01

Sobre os comandos `CREATE TABLE` e `INSERT`, é correto afirmar que:

- **a)** `CREATE TABLE` manipula os dados, e `INSERT` define a estrutura;
- **b)** os dois são comandos de definição, porque ambos mudam o banco;
- **c)** `CREATE TABLE` é um comando de definição dos dados, e `INSERT`, de manipulação;
- **d)** os dois são comandos de consulta, como o `SELECT`.

↩︎ *Aula 11, seção 1 — Do modelo físico ao SQL*

---

### Q-A11-02

Na tabela `livro`, o ISBN — um código de 13 dígitos — é declarado como `CHAR(13)`, e não como um tipo numérico. Segundo a aula, o motivo é que:

- **a)** `CHAR` ocupa sempre menos espaço que qualquer tipo numérico;
- **b)** ele é feito de dígitos, mas ninguém faz conta com ele: é um identificador, não uma quantidade;
- **c)** toda chave primária precisa ser de um tipo de texto;
- **d)** o PostgreSQL não aceita números com mais de dez dígitos.

↩︎ *Aula 11, seção 2 — `CREATE TABLE`: a tabela, as colunas e os tipos*

---

### Q-A11-03

A tabela `exemplar` tem chave primária composta por `isbn` e `numero_ex`. Em SQL, essa chave é declarada:

- **a)** escrevendo `PRIMARY KEY` ao lado de cada uma das duas colunas;
- **b)** com `UNIQUE` nas duas colunas, porque `PRIMARY KEY` só vale para uma coluna;
- **c)** com `REFERENCES` nas duas colunas, porque a chave vem da entidade dona;
- **d)** numa linha à parte, no fim da tabela: `PRIMARY KEY (isbn, numero_ex)`.

↩︎ *Aula 11, seção 3 — As chaves: `PRIMARY KEY` e `UNIQUE`*

---

### Q-A11-04

Em `USUARIO(codigo, nome, email)`, o código é a chave primária e o e-mail é uma chave alternativa. No `CREATE TABLE`, a coluna `email` recebe:

- **a)** `NOT NULL UNIQUE`, porque continua única sem ser a referência das outras tabelas;
- **b)** `PRIMARY KEY`, porque toda chave candidata é primária;
- **c)** `REFERENCES usuario (email)`, porque aponta para a própria tabela;
- **d)** `CHECK`, porque é o formato do e-mail que identifica o usuário.

↩︎ *Aula 11, seção 3 — As chaves: `PRIMARY KEY` e `UNIQUE`*

---

### Q-A11-05

No dicionário de tradução do esquema lógico para o SQL, a participação total no lado N de um relacionamento 1:N vira:

- **a)** `NOT NULL` na chave estrangeira;
- **b)** `UNIQUE` na chave estrangeira;
- **c)** `ON DELETE SET NULL` na chave estrangeira;
- **d)** uma chave primária composta no lado N.

↩︎ *Aula 11, seção 5 — O esquema da biblioteca, inteiro em SQL*

---

### Q-A11-06

**[ENADE]**

Um estagiário da biblioteca recebeu o esquema lógico e escreveu o script de criação com as tabelas em ordem alfabética: `aluno`, `autor`, `editora`, `editora_telefone`, `emprestimo`, e assim por diante. Ao executar, o primeiro comando já falhou, com a mensagem *`relation "usuario" does not exist`*.

O estagiário concluiu que o banco "não aceita a tabela `aluno`".

Considerando a situação apresentada, a interpretação mais adequada é:

- **a)** o nome `usuario` é reservado no PostgreSQL e precisa ser trocado;
- **b)** a tabela `aluno` não pode ter chave estrangeira na chave primária e precisa de uma chave própria;
- **c)** a mensagem indica que o banco está vazio, e é preciso inserir os dados antes de criar as tabelas;
- **d)** `aluno` aponta para `usuario`, que ainda não foi criada: as tabelas apontadas precisam ser criadas antes das que apontam.

↩︎ *Aula 11, seção 4 — `NOT NULL` e a chave estrangeira*

---

### Q-A11-07

**[ENADE]**

Ao registrar um empréstimo, a equipe da biblioteca executou o comando abaixo e recebeu a recusa *`violates foreign key constraint "emprestimo_isbn_numero_ex_fkey"`*.

```sql
INSERT INTO emprestimo VALUES (9, '2026-11-30', NULL, 2, '9780000000017', 5);
```

Um colega conferiu a tabela `livro`, encontrou o ISBN `9780000000017` cadastrado e concluiu que o banco estava com defeito. Na tabela `exemplar`, esse livro tem os exemplares 1 e 2.

Considerando a situação apresentada, a interpretação mais adequada é:

- **a)** a recusa veio da `data_devolucao` vazia, que o banco não aceita em empréstimos;
- **b)** a chave estrangeira é composta e confere o par: o livro existe, mas não tem o exemplar número 5;
- **c)** o banco está com defeito, porque o ISBN existe na tabela `livro`;
- **d)** a chave estrangeira deveria apontar só para o `isbn`, e a recusa revela um erro no esquema.

↩︎ *Aula 11, seção 6 — `INSERT`, e o banco que recusa*

---

### Q-A11-08

**[ENADE]**

Revisando o banco da biblioteca, um analista encontrou quatro empréstimos com a `data_devolucao` vazia e propôs acrescentar `NOT NULL` à coluna, "para que o banco não aceite dado incompleto".

No minimundo, o empréstimo é registrado no momento da retirada, e a devolução é anotada quando o exemplar volta ao balcão.

Considerando a situação apresentada, a avaliação mais adequada é:

- **a)** a proposta está correta, porque coluna vazia é sempre uma falha de integridade;
- **b)** a proposta está correta, desde que os quatro empréstimos sejam apagados antes;
- **c)** a proposta impediria registrar empréstimo em aberto: vazio só é erro onde a regra diz que o dado é obrigatório;
- **d)** a proposta não muda nada, porque o PostgreSQL ignora `NOT NULL` em colunas de data.

↩︎ *Aula 11, seção 6 — `INSERT`, e o banco que recusa*

---

⬅️ [Voltar à Aula 11](../README.md) | 🏠 [Início](../../../README.md)
