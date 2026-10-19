# Criando a biblioteca — do esquema lógico ao banco

Este arquivo mostra **o percurso da tradução**: o esquema lógico entra, um banco no PostgreSQL sai, e cada linha do `CREATE TABLE` tem ao lado a decisão de modelagem de onde ela veio. É a referência de formato dos exercícios da [Aula 11](../README.md). O script inteiro, pronto para rodar, está em [`biblioteca.sql`](biblioteca.sql).

---

## O ponto de partida

O esquema da Aula 09, seção 6:

```
   USUARIO(codigo, nome, email)
   ALUNO(codigo → USUARIO, matricula, curso)
   PROFESSOR(codigo → USUARIO, siape, departamento)
   EDITORA(cnpj, nome, rua, numero, cidade)
   EDITORA_TELEFONE(cnpj → EDITORA, telefone)
   AUTOR(cpf, nome, sobrenome, nacionalidade)
   LIVRO(isbn, titulo, ano, cnpj → EDITORA)
   ESCREVE(cpf → AUTOR, isbn → LIVRO, ordem)
   EXEMPLAR(isbn → LIVRO, numero_ex, situacao)
   EMPRESTIMO(numero, data_retirada, data_devolucao, codigo_usuario → USUARIO,
              isbn + numero_ex → EXEMPLAR)
   OFICINA(codigo, tema, data, codigo_professor → PROFESSOR)
```

## Passo 1 — a ordem de criação

Uma tabela só pode ser criada depois das tabelas para onde as setas dela apontam. Seguindo as setas:

| Rodada | Tabelas | Por quê |
|---|---|---|
| 1 | `usuario`, `editora`, `autor` | não apontam para ninguém |
| 2 | `aluno`, `professor`, `editora_telefone`, `livro` | apontam só para a rodada 1 |
| 3 | `escreve`, `exemplar`, `oficina` | apontam para `autor`, `livro` e `professor` |
| 4 | `emprestimo` | aponta para `usuario` e para `exemplar` |

Dentro de uma rodada, a ordem tanto faz. O script segue a ordem do esquema sempre que ela respeita as rodadas.

## Passo 2 — cada coluna, um tipo

A pergunta é sempre a mesma: **o que essa coluna guarda, e alguém faz conta com ela?**

| Coluna | Tipo | A decisão |
|---|---|---|
| `codigo`, `numero`, `numero_ex`, `ordem` | `INTEGER` | número de verdade: conta, ordena, incrementa |
| `ano` | `INTEGER` + `CHECK` | número, mas nem todo número é um ano válido |
| `isbn`, `cnpj`, `cpf`, `matricula`, `siape` | `CHAR(n)` | dígitos de tamanho fixo, que ninguém soma |
| `nome`, `titulo`, `tema`, `curso`… | `VARCHAR(n)` | texto de tamanho variável |
| `numero` da editora | `VARCHAR(10)` | número de endereço tem "s/n" e "100-A" |
| `telefone` | `VARCHAR(20)` | tem parênteses, espaço e hífen |
| `data_retirada`, `data_devolucao`, `data` | `DATE` | data — o banco sabe comparar e contar dias |
| `situacao` | `VARCHAR(20)` + `CHECK` | texto, mas só quatro valores valem |

## Passo 3 — cada tabela, com a origem de cada restrição

Três tabelas mostram todos os casos. As outras seguem o mesmo molde.

**`livro`** — a entidade forte com um 1:N:

```sql
CREATE TABLE livro (
  isbn   CHAR(13)     PRIMARY KEY,           -- chave primária (Aula 07)
  titulo VARCHAR(200) NOT NULL,              -- toda obra tem título
  ano    INTEGER      CHECK (ano BETWEEN 1450 AND 2100),   -- domínio (Aula 07)
  cnpj   CHAR(14)     NOT NULL               -- participação total (Aula 06)
         REFERENCES editora (cnpj)           -- 1:N, a chave mora no lado N (Aula 07)
         ON DELETE RESTRICT                  -- recusar (Aula 07)
);
```

**`exemplar`** — a entidade fraca:

```sql
CREATE TABLE exemplar (
  isbn      CHAR(13) REFERENCES livro (isbn)
            ON DELETE CASCADE,               -- propagar: sem a obra, não existe (Aula 06)
  numero_ex INTEGER,                         -- o discriminador (Aula 06)
  situacao  VARCHAR(20) NOT NULL
            CHECK (situacao IN ('disponivel', 'emprestado', 'em reparo', 'descartado')),
  PRIMARY KEY (isbn, numero_ex)              -- chave da dona + discriminador
);
```

**`aluno`** — a subclasse, na estratégia B:

```sql
CREATE TABLE aluno (
  codigo    INTEGER PRIMARY KEY              -- a chave da subclasse é a da superclasse…
            REFERENCES usuario (codigo)      -- …e aponta para ela (Aula 09)
            ON DELETE CASCADE,               -- o pedaço de aluno não vive sem o usuário
  matricula CHAR(7) NOT NULL UNIQUE,         -- chave alternativa (Aula 07)
  curso     VARCHAR(60) NOT NULL
);
```

## Passo 4 — os dados, e as seis tentativas

O script insere os dados na mesma ordem das rodadas. Depois disso, seis tentativas mostram cada regra agindo. Elas **não estão** no script — escreva cada uma no painel da direita do link e clique em **Run**:

```sql
-- 1. chave primária repetida
INSERT INTO editora VALUES ('11111111000101', 'Outra Editora', NULL, NULL, 'Recife');
-- ERRO: duplicate key value violates unique constraint "editora_pkey"

-- 2. chave estrangeira para o nada
INSERT INTO livro VALUES ('9780000000099', 'Livro Novo', 2025, '99999999000199');
-- ERRO: insert or update on table "livro" violates foreign key constraint "livro_cnpj_fkey"

-- 3. obrigatório vazio
INSERT INTO usuario VALUES (8, NULL, 'sem.nome@aluno.br');
-- ERRO: null value in column "nome" of relation "usuario" violates not-null constraint

-- 4. valor fora do domínio
INSERT INTO exemplar VALUES ('9780000000017', 3, 'sumido');
-- ERRO: new row for relation "exemplar" violates check constraint "exemplar_situacao_check"

-- 5. a política recusar
DELETE FROM editora WHERE cnpj = '11111111000101';
-- ERRO: update or delete on table "editora" violates RESTRICT setting of
--       foreign key constraint "livro_cnpj_fkey" on table "livro"

-- 6. vazio onde vazio é permitido
INSERT INTO emprestimo VALUES (8, '2026-11-30', NULL, 2, '9780000000017', 2);
-- aceito: é um empréstimo em aberto
```

E uma sétima, que pega quem esquece que a chave estrangeira composta confere **as duas colunas juntas**:

```sql
INSERT INTO emprestimo VALUES (9, '2026-11-30', NULL, 2, '9780000000017', 5);
-- ERRO: insert or update on table "emprestimo" violates foreign key constraint
--       "emprestimo_isbn_numero_ex_fkey"
```

O livro `9780000000017` existe, mas não tem exemplar número 5 — e é o par que tem de existir.

## O roteiro, para qualquer esquema

```
   1. Em que ordem? As tabelas apontadas antes das que apontam.
   2. Que tipo?    Se ninguém faz conta, é texto; se só alguns valores valem, CHECK.
   3. Que chave?   PRIMARY KEY — numa linha à parte se for composta;
                   as candidatas que sobraram, UNIQUE.
   4. Que seta?    REFERENCES; NOT NULL se a participação for total;
                   ON DELETE conforme a política escolhida.
   5. Conferiu?    Uma tentativa que deveria ser recusada para cada regra.
```

---

⬅️ [Voltar à Aula 11](../README.md)
