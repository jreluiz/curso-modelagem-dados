# Aula 11 — Do Esquema ao PostgreSQL

> 🎯 Objetivos: situar o SQL e o PostgreSQL no projeto físico, escrever o `CREATE TABLE` de um esquema lógico com tipos, chaves, `NOT NULL` e regras de exclusão, e inserir dados vendo o banco recusar o que viola a integridade.
> 🎬 Slides da aula: [apresentacao-11-do-esquema-ao-postgresql.pdf](apresentacao/apresentacao-11-do-esquema-ao-postgresql.pdf)
> 🧪 **O banco desta aula, no navegador:** [DB Fiddle — Biblioteca, Aula 11](https://www.db-fiddle.com/f/nufw3xqoscSUJ7jv5Pdomo/0) — abra o link e clique em **Run**: o banco da biblioteca é criado na hora, sem instalar nada.

Na Aula 05, o projeto de banco de dados tinha três modelos: o **conceitual** (o DER), o **lógico** (as tabelas) e o **físico** (como tudo isso vira um banco de verdade, num SGBD específico). O curso inteiro, até aqui, trabalhou nos dois primeiros. Hoje o esquema da Aula 09, conferido pela Aula 10, atravessa a última etapa: vira um banco no **PostgreSQL**.

Não é preciso programar nem instalar nada. Os comandos desta aula são a tradução, quase palavra por palavra, de decisões que você já tomou no DER e no esquema lógico.

## 1. Do modelo físico ao SQL

Para conversar com um SGBD relacional existe uma linguagem própria: o **SQL**. Ela nasceu na IBM em 1974, com o nome SEQUEL, criada por Donald Chamberlin e Raymond Boyce sobre o modelo relacional de Codd que a Aula 02 contou. Virou padrão oficial em 1986, nos Estados Unidos, e em 1987 no mundo — e é por isso que, com pequenas diferenças, ela é a mesma em todo banco relacional.

Os comandos de SQL se dividem em dois grupos, e o curso usa só o começo de cada um:

| Grupo | Para quê | Nesta aula | Na Aula 12 |
|---|---|---|---|
| **definição** dos dados (DDL) | criar a estrutura: tabelas, colunas, chaves | `CREATE TABLE` | — |
| **manipulação** dos dados (DML) | pôr, ler, mudar e tirar dados | `INSERT` | `SELECT` |

O **PostgreSQL** é o SGBD que vamos usar. Ele nasceu em 1986 na Universidade da Califórnia em Berkeley, num projeto liderado por Michael Stonebraker, ganhou o SQL em 1994 e o nome atual em 1996. É gratuito e de código aberto, e na pesquisa do Stack Overflow de 2025 foi o banco mais usado por desenvolvedores: **55,6%** dos que responderam.

> 💡 **A Aula 05 prometeu um termo para o Bloco 3: independência de dados.** É o que se vê hoje. O mesmo esquema lógico poderia ser criado no MySQL ou no Oracle trocando quase só os nomes de alguns tipos — o lógico não sabe em que SGBD vai rodar. E quem consulta o banco não precisa saber como o PostgreSQL guarda os arquivos no disco: o físico esconde isso. Cada nível pode mudar sem obrigar o de cima a mudar junto.

**Onde o banco roda.** Usamos o [DB Fiddle](https://www.db-fiddle.com/), um serviço on-line: no painel da esquerda (*Schema SQL*) ficam os comandos que criam o banco; no da direita (*Query SQL*), as consultas; o botão **Run** executa tudo e mostra o resultado embaixo. Escolha **PostgreSQL v18** no menu *Database*. Se o serviço estiver fora do ar, o [REPL do PGlite](https://pglite.dev/repl/) é um PostgreSQL que roda dentro do próprio navegador.

## 2. `CREATE TABLE`: a tabela, as colunas e os tipos

O esquema lógico dizia `EDITORA(cnpj, nome, rua, numero, cidade)`. Em SQL:

```sql
CREATE TABLE editora (
  cnpj   CHAR(14)     PRIMARY KEY,   -- a chave primária
  nome   VARCHAR(100) NOT NULL,      -- obrigatório
  rua    VARCHAR(100),               -- o endereço composto: uma coluna por parte
  numero VARCHAR(10),
  cidade VARCHAR(60)
);
```

Cada coluna tem um **tipo**, que é o **domínio** da Aula 07 escrito para o banco. Os que o curso usa:

| Tipo | Guarda | Exemplo na biblioteca |
|---|---|---|
| `INTEGER` | número inteiro | `codigo` do usuário, `ano` do livro |
| `NUMERIC(p, s)` | número com casas decimais | o valor de uma multa: `NUMERIC(6, 2)` |
| `CHAR(n)` | texto de tamanho **fixo** | `cnpj` — sempre 14 caracteres |
| `VARCHAR(n)` | texto de tamanho **variável**, até `n` | `nome`, `titulo` |
| `DATE` | uma data | `data_retirada` |
| `BOOLEAN` | verdadeiro ou falso | se a sala tem quadro branco |

> ⚠️ **Nem todo número é número.** O ISBN, o CNPJ e o CPF são feitos de dígitos, mas ninguém soma dois ISBNs, e um CPF que começa com zero perderia o zero numa coluna `INTEGER`. Se não se faz conta com ele, é **texto**: `CHAR(13)` para o ISBN.

Quando o tipo não basta para dizer o que vale, entra o **`CHECK`** — a regra de domínio que a Aula 07 citava, agora com nome:

```sql
ano      INTEGER CHECK (ano BETWEEN 1450 AND 2100),
situacao VARCHAR(20) NOT NULL
         CHECK (situacao IN ('disponivel', 'emprestado', 'em reparo', 'descartado'))
```

Duas convenções que o curso segue: nomes de tabela e coluna em **minúsculas**, com `_` separando as palavras; e as palavras do SQL em **maiúsculas**, só para facilitar a leitura — o PostgreSQL aceita as duas formas.

### ✏️ Tente você

Escreva o `CREATE TABLE` da tabela `AUTOR(cpf, nome, sobrenome, nacionalidade)` da Aula 09. O nome e o sobrenome são obrigatórios; a nacionalidade, não.

<details>
<summary>Resposta</summary>

```sql
CREATE TABLE autor (
  cpf           CHAR(11)    PRIMARY KEY,
  nome          VARCHAR(60) NOT NULL,
  sobrenome     VARCHAR(60) NOT NULL,
  nacionalidade VARCHAR(40)
);
```

O CPF é `CHAR(11)` pela mesma razão do ISBN: dígitos, mas não um número. E a ausência de `NOT NULL` na nacionalidade **também é uma decisão**: ela aceita vazio.
</details>

## 3. As chaves: `PRIMARY KEY` e `UNIQUE`

A chave primária da Aula 07 vira **`PRIMARY KEY`**. Quando ela é de uma coluna só, vai ao lado da coluna, como em `editora`. Quando é **composta**, vai numa linha à parte, no fim, listando as colunas:

```sql
CREATE TABLE exemplar (                  -- a entidade fraca da Aula 06
  isbn      CHAR(13) REFERENCES livro (isbn) ON DELETE CASCADE,
  numero_ex INTEGER,
  situacao  VARCHAR(20) NOT NULL,
  PRIMARY KEY (isbn, numero_ex)          -- a chave da dona + o discriminador
);
```

Declarar `PRIMARY KEY` já garante a **integridade de entidade**: a coluna não aceita vazio e não aceita repetição.

As **chaves alternativas** — as candidatas que não foram escolhidas como primária — continuam únicas, e se declaram com **`UNIQUE`**. Na especialização da Aula 09, a `matricula` do aluno e o `siape` do professor:

```sql
CREATE TABLE aluno (
  codigo    INTEGER     PRIMARY KEY REFERENCES usuario (codigo) ON DELETE CASCADE,
  matricula CHAR(7)     NOT NULL UNIQUE,   -- chave alternativa
  curso     VARCHAR(60) NOT NULL
);
```

### ✏️ Tente você

Em `USUARIO(codigo, nome, email)`, o código é a chave primária, o nome é obrigatório e o e-mail é obrigatório e não pode se repetir. Escreva o `CREATE TABLE`.

<details>
<summary>Resposta</summary>

```sql
CREATE TABLE usuario (
  codigo INTEGER      PRIMARY KEY,
  nome   VARCHAR(100) NOT NULL,
  email  VARCHAR(100) NOT NULL UNIQUE
);
```

O `email` é **chave alternativa**: único, mas não é ele que as outras tabelas copiam. E o `nome` não tem `UNIQUE` — duas Anas Souza são o mundo, não um erro.
</details>

## 4. `NOT NULL` e a chave estrangeira

A seta `→` do esquema lógico vira **`REFERENCES`**: a coluna só aceita valores que existem na chave da outra tabela. É a **integridade referencial** da Aula 07, declarada.

```sql
CREATE TABLE livro (
  isbn   CHAR(13)     PRIMARY KEY,
  titulo VARCHAR(200) NOT NULL,
  ano    INTEGER      CHECK (ano BETWEEN 1450 AND 2100),
  cnpj   CHAR(14)     NOT NULL REFERENCES editora (cnpj) ON DELETE RESTRICT
);
```

Leia a última linha de trás para a frente, e cada pedaço é uma decisão de uma aula anterior:

- **`REFERENCES editora (cnpj)`** — o 1:N da Aula 07: a chave estrangeira mora no lado N;
- **`NOT NULL`** — a **participação total** da Aula 06: toda obra tem editora, então a coluna não aceita vazio;
- **`ON DELETE RESTRICT`** — a **política de exclusão** da Aula 07.

As três políticas, do vocabulário da Aula 07 para o SQL:

| Política | Em SQL | Na biblioteca |
|---|---|---|
| **recusar** | `ON DELETE RESTRICT` | apagar uma editora que tem livros |
| **propagar** | `ON DELETE CASCADE` | apagar um livro apaga os exemplares dele |
| **anular** | `ON DELETE SET NULL` | a ligação é opcional e a linha sobrevive sem ela |

Quando a chave apontada é **composta**, a chave estrangeira também é — *"chave composta se propaga"*, dizia a Aula 07. Ela vai numa linha à parte:

```sql
FOREIGN KEY (isbn, numero_ex) REFERENCES exemplar (isbn, numero_ex) ON DELETE RESTRICT
```

> ⚠️ **A ordem de criação importa.** Não dá para criar `livro` antes de `editora`: a chave estrangeira apontaria para uma tabela que ainda não existe, e o PostgreSQL recusa com *`relation "editora" does not exist`*. Crie primeiro as tabelas que **são apontadas**, depois as que **apontam**.

### ✏️ Tente você

Três ligações da biblioteca. Pelas regras da Aula 07, qual `ON DELETE` vai em cada chave estrangeira?

1. `exemplar.isbn → livro` — apagar um livro apaga os exemplares;
2. `emprestimo.codigo_usuario → usuario` — o histórico é para sempre;
3. `aluno.codigo → usuario` — a subclasse não existe sem a superclasse.

<details>
<summary>Resposta</summary>

1. **`ON DELETE CASCADE`** — exemplar é entidade fraca: sem o livro, não é coisa nenhuma;
2. **`ON DELETE RESTRICT`** — propagar apagaria o histórico de empréstimos, o alerta da Aula 07; e anular é impossível, porque a coluna é `NOT NULL` — participação total pede recusar ou propagar, nunca anular;
3. **`ON DELETE CASCADE`** — na estratégia B da Aula 09, a linha de `aluno` é o "pedaço de aluno" de um usuário; sem o usuário, ela não tem o que completar.
</details>

## 5. O esquema da biblioteca, inteiro em SQL

O esquema da Aula 09, seção 6, em ordem de criação:

```sql
CREATE TABLE usuario (
  codigo INTEGER PRIMARY KEY,
  nome   VARCHAR(100) NOT NULL,
  email  VARCHAR(100) NOT NULL UNIQUE
);
CREATE TABLE aluno (
  codigo    INTEGER PRIMARY KEY REFERENCES usuario (codigo) ON DELETE CASCADE,
  matricula CHAR(7) NOT NULL UNIQUE,
  curso     VARCHAR(60) NOT NULL
);
CREATE TABLE professor (
  codigo       INTEGER PRIMARY KEY REFERENCES usuario (codigo) ON DELETE CASCADE,
  siape        CHAR(6) NOT NULL UNIQUE,
  departamento VARCHAR(60) NOT NULL
);
CREATE TABLE editora (
  cnpj CHAR(14) PRIMARY KEY, nome VARCHAR(100) NOT NULL,
  rua VARCHAR(100), numero VARCHAR(10), cidade VARCHAR(60)
);
CREATE TABLE editora_telefone (
  cnpj     CHAR(14) REFERENCES editora (cnpj) ON DELETE CASCADE,
  telefone VARCHAR(20),
  PRIMARY KEY (cnpj, telefone)
);
CREATE TABLE autor (
  cpf CHAR(11) PRIMARY KEY, nome VARCHAR(60) NOT NULL,
  sobrenome VARCHAR(60) NOT NULL, nacionalidade VARCHAR(40)
);
CREATE TABLE livro (
  isbn   CHAR(13) PRIMARY KEY,
  titulo VARCHAR(200) NOT NULL,
  ano    INTEGER CHECK (ano BETWEEN 1450 AND 2100),
  cnpj   CHAR(14) NOT NULL REFERENCES editora (cnpj) ON DELETE RESTRICT
);
CREATE TABLE escreve (
  cpf   CHAR(11) REFERENCES autor (cpf),
  isbn  CHAR(13) REFERENCES livro (isbn) ON DELETE CASCADE,
  ordem INTEGER NOT NULL,
  PRIMARY KEY (cpf, isbn)
);
CREATE TABLE exemplar (
  isbn      CHAR(13) REFERENCES livro (isbn) ON DELETE CASCADE,
  numero_ex INTEGER,
  situacao  VARCHAR(20) NOT NULL
            CHECK (situacao IN ('disponivel', 'emprestado', 'em reparo', 'descartado')),
  PRIMARY KEY (isbn, numero_ex)
);
CREATE TABLE emprestimo (
  numero         INTEGER PRIMARY KEY,
  data_retirada  DATE NOT NULL,
  data_devolucao DATE,
  codigo_usuario INTEGER NOT NULL REFERENCES usuario (codigo) ON DELETE RESTRICT,
  isbn           CHAR(13) NOT NULL,
  numero_ex      INTEGER NOT NULL,
  FOREIGN KEY (isbn, numero_ex) REFERENCES exemplar (isbn, numero_ex) ON DELETE RESTRICT
);
CREATE TABLE oficina (
  codigo           INTEGER PRIMARY KEY,
  tema             VARCHAR(100) NOT NULL,
  data             DATE NOT NULL,
  codigo_professor INTEGER NOT NULL REFERENCES professor (codigo)
);
```

O dicionário inteiro da tradução, do esquema lógico para o SQL:

| No esquema lógico | No SQL |
|---|---|
| a chave primária | `PRIMARY KEY` — ao lado da coluna, ou numa linha à parte se for composta |
| a chave alternativa | `UNIQUE` |
| a seta `→` | `REFERENCES tabela (coluna)` — ou `FOREIGN KEY (…) REFERENCES` se for composta |
| a participação total | `NOT NULL` na chave estrangeira |
| o domínio | o tipo da coluna, mais `CHECK` quando o tipo não basta |
| a política de exclusão | `ON DELETE RESTRICT`, `CASCADE` ou `SET NULL` |

> 💻 **Modelos desta aula:**
> - [`criando-a-biblioteca.md`](exemplos/criando-a-biblioteca.md) — **o percurso completo**: a ordem de criação, o tipo de cada coluna, a origem de cada restrição e as tentativas que o banco recusa. É a referência de formato dos exercícios;
> - [`biblioteca.sql`](exemplos/biblioteca.sql) — o script pronto, com o esquema acima e os dados fictícios da biblioteca. É o mesmo que está no [link da aula](https://www.db-fiddle.com/f/nufw3xqoscSUJ7jv5Pdomo/0).

## 6. `INSERT`, e o banco que recusa

Com as tabelas criadas, os dados entram com **`INSERT`**:

```sql
INSERT INTO editora VALUES
  ('11111111000101', 'Editora Aurora', 'Rua das Flores', '100', 'Porto Alegre');

INSERT INTO usuario (codigo, nome, email)      -- nomeando as colunas
VALUES (1, 'Ana Souza', 'ana@aluno.br');
```

Os valores vêm **na ordem das colunas** da tabela — ou na ordem de uma lista de colunas dada logo depois do nome dela, que é a forma mais segura. Texto e data vão entre aspas simples; número, sem aspas; e `NULL` é o vazio.

Agora a parte que o curso inteiro preparou. Tudo o que você declarou no `CREATE TABLE` passa a ser **verificado pelo banco**, a cada gravação. Seis tentativas, feitas no PostgreSQL 18, com a mensagem que ele devolve:

| Tentativa | O PostgreSQL responde | A regra que agiu |
|---|---|---|
| uma editora com um CNPJ que já existe | `duplicate key value violates unique constraint "editora_pkey"` | integridade de **entidade** — chave primária |
| um livro com o CNPJ de uma editora que não existe | `insert or update on table "livro" violates foreign key constraint "livro_cnpj_fkey"` | integridade **referencial** |
| um usuário sem nome | `null value in column "nome" of relation "usuario" violates not-null constraint` | `NOT NULL` — o dado obrigatório |
| um exemplar com situação `'sumido'` | `new row for relation "exemplar" violates check constraint "exemplar_situacao_check"` | integridade de **domínio** — o `CHECK` |
| apagar uma editora que tem livros | `update or delete on table "editora" violates RESTRICT setting of foreign key constraint "livro_cnpj_fkey" on table "livro"` | a política **recusar** |
| um empréstimo com `data_devolucao` vazia | aceito | nenhuma — é empréstimo em aberto |

A última linha é a mesma da Aula 07, e continua sendo a que mais ensina: **integridade não é recusar o que parece estranho**. Vazio só é erro onde você declarou `NOT NULL`.

> 💡 **A mensagem diz o nome da regra.** O PostgreSQL dá um nome a cada restrição que você declarou: `livro_cnpj_fkey` é a chave estrangeira (*foreign key*) da coluna `cnpj` da tabela `livro`; `editora_pkey`, a chave primária de `editora`. Ler a mensagem é achar a linha do `CREATE TABLE` que recusou — e, por trás dela, a decisão de modelagem.

> ⚠️ **O apagar aparece aqui só para ver a política agindo.** O comando para tirar linhas (`DELETE`) e o comando para mudá-las ficam fora do curso, como as transações. O que importa nesta aula é ver que a decisão *"recusar"*, tomada no papel na Aula 07, virou o banco dizendo não.

O banco da biblioteca existe, com dados dentro. Na próxima aula, ele começa a responder perguntas.

## 🏋️ Exercícios da aula

Em todos os exercícios:

- escreva os comandos em SQL num bloco de código, com um comentário (`--`) explicando **cada decisão que não é óbvia** — por que esse tipo, por que essa política de exclusão;
- para cada `NOT NULL`, `UNIQUE`, `CHECK` e `ON DELETE`, diga de qual decisão de modelagem ele saiu.

**Rodar é opcional, e vale a pena.** Abra o [link da aula](https://www.db-fiddle.com/f/nufw3xqoscSUJ7jv5Pdomo/0), acrescente os seus comandos no fim do painel da esquerda e clique em **Run**. Se não aparecer erro, o banco aceitou.

Na pasta `aula-11/` do seu repositório, um arquivo `.md` por exercício:

1. **`ex01.md`** — Escreva o `CREATE TABLE` das salas de estudo e das reservas, com este esquema lógico: `SALA(numero, andar, capacidade)` e `RESERVA(numero_sala → SALA, data, horario, codigo_usuario → USUARIO)`, com chave `(numero_sala, data, horario)`. As regras: toda sala tem andar; a capacidade vai de 1 a 40 pessoas; toda reserva é de um usuário; apagar uma sala que tem reservas deve ser **recusado**; apagar um usuário apaga as reservas dele.

   *Confere assim: a chave de `RESERVA` é composta e vai numa linha à parte; as duas chaves estrangeiras têm políticas **diferentes**, e cada uma sai de uma frase do enunciado; e a capacidade precisa de um `CHECK`. Se `horario` virou `INTEGER`, pense em como guardar "14h30".*

2. **`ex02.md`** — Escreva o `CREATE TABLE` da especialização de espaços da Aula 09, na estratégia B: `ESPACO(numero, andar, capacidade)`, `SALA_ESTUDO(numero → ESPACO, quadro_branco)` e `AUDITORIO(numero → ESPACO, projetor_fixo, tamanho_palco)`, com o tamanho do palco em metros quadrados, com uma casa decimal.

   *Confere assim: em `SALA_ESTUDO` e em `AUDITORIO`, o `numero` é **ao mesmo tempo** `PRIMARY KEY` e `REFERENCES espaco` — se ele é só uma das duas coisas, releia a estratégia B. O `quadro_branco` e o `projetor_fixo` têm o mesmo tipo, e ele não é texto.*

3. **`ex03.md`** — Os seis comandos abaixo são executados **nesta ordem** no banco da biblioteca da aula. Para cada um, diga se ele é **aceito** ou **recusado** e, se for recusado, **qual regra** recusou.

   ```sql
   INSERT INTO usuario VALUES (7, 'Fábio Nunes', 'ana@aluno.br');
   INSERT INTO livro VALUES ('9780000000079', 'Banco de Dados Moderno', 2024, '33333333000103');
   INSERT INTO exemplar VALUES ('9780000000079', 1, 'disponivel');
   INSERT INTO emprestimo VALUES (8, '2026-11-30', NULL, 9, '9780000000079', 1);
   INSERT INTO exemplar VALUES ('9780000000079', 2, 'perdido');
   INSERT INTO aluno VALUES (5, '2025099', 'Pedagogia');
   ```

   *Confere assim: três são aceitos e três são recusados, cada recusado por uma regra diferente. O último comando surpreende quem esqueceu a Aula 09: o usuário 5 é a professora Dora — e a especialização da biblioteca é sobreposta. Depois de responder, rode no link e compare.*

### 📤 Entrega

Estes exercícios são feitos em sala e vão para o **seu repositório** `exercicios-modelagem-dados`:

```bash
cd ..                 # da pasta da aula para a raiz do repositório
git add aula-11/
git commit -m "Resolve exercícios da aula 11"
git push
```

Confira no navegador que a pasta apareceu em `github.com/SEU-USUARIO/exercicios-modelagem-dados`.

## 🧠 Revisão

[8 questões de múltipla escolha](revisao/README.md) para conferir se os conceitos ficaram sólidos. Responda sem consultar a aula — depois volte e corrija.

---

⬅️ [Aula 10 — Normalização Essencial](../aula-10-normalizacao-essencial/README.md) | ➡️ [Aula 12 — Consultas Básicas em SQL](../aula-12-consultas-basicas/README.md)
