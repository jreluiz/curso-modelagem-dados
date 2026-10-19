# Aula 12 — Revisão: Múltipla Escolha

> 🎯 8 questões sobre a [Aula 12 — Consultas Básicas em SQL](../README.md). Só uma alternativa está correta em cada uma.

**Sem gabarito, de propósito.** Cada questão termina com a seção da aula onde a resposta está. Responda **tudo primeiro**, sem consultar — só depois volte às seções indicadas e corrija.

As três últimas são marcadas **[ENADE]**: trazem um **texto-base** com uma situação concreta, seguido do comando. São mais longas de ler e cobram interpretação, não memória — as alternativas continuam simples, como nas demais.

---

### Q-A12-01

Sobre a consulta `SELECT titulo, ano FROM livro;`, é correto afirmar que:

- **a)** o resultado tem todas as linhas de `livro`, mas só as colunas `titulo` e `ano`;
- **b)** as outras colunas de `livro` são apagadas da tabela;
- **c)** o resultado tem só a primeira linha de `livro`;
- **d)** a consulta falha, porque é preciso usar `*` para ler uma tabela.

↩︎ *Aula 12, seção 1 — `SELECT`: as colunas que a resposta mostra*

---

### Q-A12-02

Para listar os empréstimos em aberto — os que têm a `data_devolucao` vazia —, a condição correta é:

- **a)** `WHERE data_devolucao = NULL`;
- **b)** `WHERE data_devolucao = ''`;
- **c)** `WHERE data_devolucao = 0`;
- **d)** `WHERE data_devolucao IS NULL`.

↩︎ *Aula 12, seção 2 — `WHERE`: as linhas que interessam, e o vazio*

---

### Q-A12-03

Sobre `ORDER BY` e `LIMIT`, é correto afirmar que:

- **a)** sem `ORDER BY`, o banco devolve sempre as linhas na ordem em que elas foram inseridas;
- **b)** `ORDER BY ano DESC LIMIT 2` devolve os dois livros mais recentes;
- **c)** o `LIMIT` é aplicado antes do `ORDER BY`, e por isso escolhe as linhas ao acaso;
- **d)** o `ORDER BY` só aceita colunas que aparecem no `WHERE`.

↩︎ *Aula 12, seção 3 — `ORDER BY` e `LIMIT`: a ordem da resposta*

---

### Q-A12-04

Na consulta abaixo, a condição do `ON`:

```sql
SELECT livro.titulo, editora.nome
FROM livro
JOIN editora ON livro.cnpj = editora.cnpj;
```

- **a)** separa os livros sem editora, e por isso o resultado tem menos linhas que a tabela `livro`;
- **b)** cria uma coluna nova, `cnpj`, na tabela `livro`;
- **c)** diz qual linha de `editora` vai ao lado de cada linha de `livro`: a que tem o mesmo CNPJ;
- **d)** ordena o resultado pelo CNPJ.

↩︎ *Aula 12, seção 4 — A primeira junção: `JOIN … ON`*

---

### Q-A12-05

Para listar o título de cada livro com o sobrenome de cada autor, a consulta precisa passar pela tabela `escreve` porque:

- **a)** `escreve` é a única tabela que tem a coluna `titulo`;
- **b)** uma junção de três tabelas é sempre mais rápida que uma de duas;
- **c)** a chave estrangeira de `autor` para `livro` está vazia;
- **d)** o relacionamento N:M entre livro e autor virou a tabela `escreve`, e não existe seta direta entre `livro` e `autor`.

↩︎ *Aula 12, seção 5 — Três tabelas: seguindo as setas*

---

### Q-A12-06

**[ENADE]**

Para montar o relatório "livros e suas editoras", um estagiário escreveu a consulta abaixo. O acervo tem 6 livros e 3 editoras.

```sql
SELECT l.titulo, ed.nome FROM livro l, editora ed;
```

O relatório saiu com 18 linhas, e cada título aparecia ao lado das três editoras. O estagiário concluiu que o cadastro estava com livros duplicados.

Considerando a situação apresentada, a interpretação mais adequada é:

- **a)** o cadastro tem livros duplicados, e as linhas repetidas devem ser apagadas;
- **b)** a consulta está certa, e cada livro foi publicado pelas três editoras;
- **c)** faltou a condição de junção: sem ela, cada livro é combinado com cada editora, e o resultado tem 6 × 3 linhas;
- **d)** o `SELECT` deveria usar `*`, para mostrar todas as colunas e desfazer a repetição.

↩︎ *Aula 12, seção 4 — A primeira junção: `JOIN … ON`*

---

### Q-A12-07

**[ENADE]**

A bibliotecária pediu a lista dos empréstimos em aberto. O analista executou a consulta abaixo, recebeu zero linhas, sem nenhuma mensagem de erro, e respondeu que não havia empréstimo em aberto.

```sql
SELECT numero FROM emprestimo WHERE data_devolucao = NULL;
```

No balcão, porém, quatro exemplares estavam fora da estante, com a retirada registrada e sem devolução.

Considerando a situação apresentada, a interpretação mais adequada é:

- **a)** a consulta está errada: comparar com `NULL` usando `=` nunca dá verdadeiro, e o teste certo é `IS NULL`;
- **b)** a consulta está certa, e os quatro exemplares foram devolvidos sem registro;
- **c)** o banco está com defeito, porque deveria ter mostrado uma mensagem de erro;
- **d)** a coluna `data_devolucao` deveria ser `NOT NULL`, para que a consulta funcionasse.

↩︎ *Aula 12, seção 2 — `WHERE`: as linhas que interessam, e o vazio*

---

### Q-A12-08

**[ENADE]**

A coordenação de um curso pediu à biblioteca a lista dos alunos com empréstimo em aberto, com o nome e o curso de cada um, para mandar um lembrete às turmas.

No esquema da biblioteca, o empréstimo guarda o código do usuário; o nome e o e-mail estão em `USUARIO`; e `ALUNO(codigo → USUARIO, matricula, curso)` é a subclasse da estratégia B da Aula 09.

Considerando a situação apresentada, as tabelas de que a consulta precisa são:

- **a)** só `emprestimo`, porque o código do usuário já está nela;
- **b)** `emprestimo`, `usuario` e `aluno`: o nome mora em `usuario`, o curso em `aluno`, e as duas se ligam pelo `codigo`;
- **c)** `emprestimo` e `livro`, porque todo empréstimo é de um livro;
- **d)** `emprestimo`, `exemplar`, `livro`, `usuario` e `aluno`, porque a consulta precisa passar por todas as setas do esquema.

↩︎ *Aula 12, seção 6 — Da pergunta do balcão à consulta*

---

⬅️ [Voltar à Aula 12](../README.md) | 🏠 [Início](../../../README.md)
