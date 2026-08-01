# Aula 13 — SQL DDL: Criando o Esquema

> 🎯 Objetivos: escrever o `CREATE TABLE` de um esquema completo com chaves e restrições nomeadas, escolher a ação referencial de cada chave estrangeira e interpretar as mensagens de erro do PostgreSQL.
> 🎬 Slides da aula: [apresentacao-13-sql-ddl.pdf](apresentacao/apresentacao-13-sql-ddl.pdf)

## 1. Do esquema ao script

Você tem um esquema em papel desde a Aula 08. Agora ele vira um arquivo que qualquer PostgreSQL do mundo executa e reconstrói o banco do zero.

```
   No papel                              Em SQL
   ─────────────────────────────         ────────────────────────────────
   OBRA(isbn, titulo, ano, editora)      CREATE TABLE obra (
        ‾‾‾‾                                 isbn   VARCHAR(17) NOT NULL,
        ano entre 1450 e o ano atual         titulo VARCHAR(150) NOT NULL,
                                             ano    INTEGER NOT NULL,
                                             CONSTRAINT obra_pk PRIMARY KEY (isbn),
                                             CONSTRAINT obra_ano_ck
                                                 CHECK (ano BETWEEN 1450 AND 2100)
                                         );
```

A tradução é direta: o nome vira o nome, os atributos viram colunas, o domínio vira tipo mais `CHECK`, o sublinhado vira `PRIMARY KEY`, a seta vira `FOREIGN KEY`.

> 📏 **Regra do curso:** o script DDL fica no repositório e roda **do zero**, sempre. Nada de banco construído a cliques que ninguém sabe reproduzir. Se o seu esquema não cabe num arquivo versionado, ele não existe.

## 2. `CREATE TABLE` e os tipos

```sql
CREATE TABLE usuario (
    matricula     CHAR(9)      NOT NULL,
    nome          VARCHAR(80)  NOT NULL,
    email         VARCHAR(120) NOT NULL,
    categoria     VARCHAR(10)  NOT NULL,
    data_cadastro DATE         NOT NULL DEFAULT CURRENT_DATE
);
```

Cada linha é `nome_da_coluna TIPO restrições`. Os tipos são os da Aula 11, e `DEFAULT` diz o que gravar quando ninguém informa nada.

> ⚠️ **A vírgula sobrando antes do parêntese que fecha é o erro mais comum do mundo em DDL.** A última coluna e a última restrição **não** levam vírgula. O PostgreSQL responde `syntax error at or near ")"` e informa a linha; conte a partir dali para trás.

## 3. `NOT NULL`, `UNIQUE`, `CHECK`

As três primeiras restrições da Aula 04, agora escritas:

| Em SQL | Garante | Qual integridade |
|---|---|---|
| `NOT NULL` | A coluna nunca fica vazia | Domínio |
| `UNIQUE` | O valor não se repete na tabela | A chave alternativa da Aula 02 |
| `CHECK (…)` | A condição é verdadeira em toda linha | Domínio e semântica |

```sql
CONSTRAINT usuario_email_uk UNIQUE (email),
CONSTRAINT usuario_categoria_ck CHECK (categoria IN ('aluno', 'professor', 'servidor')),
CONSTRAINT emprestimo_prazo_ck  CHECK (data_prevista >= data_retirada)
```

> 💡 **Dê nome às suas restrições.** Sem `CONSTRAINT nome`, o PostgreSQL inventa um, e a mensagem de erro que chega ao usuário fala de `usuario_categoria_check`. Com nome escolhido por você, ela fala de uma regra do **seu** modelo — e quem lê o erro entende o que aconteceu. É a diferença entre um log legível e um enigma.

## 4. `PRIMARY KEY` e `FOREIGN KEY`

```sql
CONSTRAINT telefone_pk PRIMARY KEY (matricula, numero),

CONSTRAINT emprestimo_usuario_fk FOREIGN KEY (matricula)
    REFERENCES usuario (matricula)
```

`PRIMARY KEY` já implica `NOT NULL` e `UNIQUE` — é a integridade de entidade da Aula 04, inteira, numa palavra. E ela aceita mais de uma coluna, que é como a chave composta da Aula 02 se escreve.

`FOREIGN KEY … REFERENCES` é a integridade referencial. A partir do momento em que ela existe, o banco recusa:

```
ERROR:  insert or update on table "emprestimo" violates foreign key constraint "emprestimo_usuario_fk"
DETAIL:  Key (matricula)=(999999999) is not present in table "usuario".
```

Leia a mensagem inteira: ela diz a tabela, a restrição, a coluna e **o valor culpado**. O PostgreSQL é bom nisso, e a maioria das pessoas desiste de ler no `ERROR:`.

## 5. `ON DELETE` e `ON UPDATE`

As ações referenciais da Aula 04, agora com sintaxe:

| Em SQL | O que faz ao apagar a linha referenciada |
|---|---|
| `ON DELETE RESTRICT` | Recusa a operação. **É o padrão** |
| `ON DELETE CASCADE` | Apaga junto as linhas dependentes |
| `ON DELETE SET NULL` | Esvazia a FK dos dependentes (exige coluna opcional) |

```sql
-- Tabela dependente: sem o usuário, o telefone é um número solto
CONSTRAINT telefone_usuario_fk FOREIGN KEY (matricula)
    REFERENCES usuario (matricula) ON DELETE CASCADE,

-- Apagar um usuário apagaria o histórico: recusa-se
CONSTRAINT emprestimo_usuario_fk FOREIGN KEY (matricula)
    REFERENCES usuario (matricula) ON DELETE RESTRICT,

-- O funcionário pode sair; a multa continua perdoada
CONSTRAINT multa_funcionario_fk FOREIGN KEY (matricula_func)
    REFERENCES funcionario (matricula_func) ON DELETE SET NULL
```

> ⚠️ **`CASCADE` só onde a linha dependente não faz sentido sozinha.** Um `DELETE` de uma linha pode apagar exemplares, empréstimos, renovações e multas em silêncio. O comando que causou isso tinha uma linha, e não houve pergunta nenhuma.

## 6. `ALTER` e `DROP`

O esquema muda. Quando ele muda num banco que já tem dados, `ALTER TABLE` faz a mudança sem recriar nada:

```sql
ALTER TABLE usuario ADD COLUMN ativo BOOLEAN NOT NULL DEFAULT TRUE;
ALTER TABLE usuario ADD CONSTRAINT usuario_email_ck CHECK (email LIKE '%@%');
ALTER TABLE usuario DROP COLUMN ativo;
```

> ⚠️ **`ADD COLUMN … NOT NULL` sem `DEFAULT` falha se a tabela já tiver linhas** — o banco não sabe o que pôr nas existentes. Ou informe um `DEFAULT`, ou adicione a coluna opcional, preencha, e só então torne obrigatória.

E `DROP TABLE` apaga a tabela inteira. Num script que precisa rodar do zero repetidas vezes, ele aparece no começo:

```sql
DROP TABLE IF EXISTS multa;
DROP TABLE IF EXISTS emprestimo;
```

> ⚠️ **A ordem dos `DROP` é a inversa da ordem dos `CREATE`.** Primeiro quem aponta, depois quem é apontado — senão o banco recusa apagar uma tabela que ainda é referenciada.

## 7. Os erros que você vai ver

Os três mais frequentes, com a cura:

```
ERROR:  duplicate key value violates unique constraint "usuario_pk"
DETAIL:  Key (matricula)=(202310100) already exists.
```
Você rodou a carga duas vezes. Rode o `02-ddl.sql` de novo, que começa com `DROP TABLE IF EXISTS`.

```
ERROR:  new row for relation "usuario" violates check constraint "usuario_categoria_ck"
DETAIL:  Failing row contains (111111111, X, x@y.br, estagiario, 2026-08-01).
```
O domínio recusou o valor. A linha inteira está no `DETAIL` — o culpado é `estagiario`.

```
ERROR:  relation "aluno" does not exist
```
A tabela não existe, você está no banco errado, ou criou o nome entre aspas duplas. **Nunca use aspas duplas em nome de tabela ou coluna** — é o único conselho do curso que não tem exceção.

> 💻 **Scripts desta aula:** [`02-ddl.sql`](exemplos/02-ddl.sql) — as 13 tabelas da Biblioteca · [`03-carga.sql`](exemplos/03-carga.sql) — os dados, na ordem das dependências.

> 📖 O capítulo de SQL do livro-base cobre a DDL com o padrão ANSI. As diferenças em relação ao PostgreSQL são poucas e a [documentação oficial](https://www.postgresql.org/docs/current/sql-createtable.html) resolve cada uma.

## 🏋️ Exercícios da aula

Na pasta `aula-13/` do seu repositório:

1. **`ex01.sql`** — escreva o DDL completo do **seu** modelo (o do `ex04` da Aula 06), com todas as tabelas, chaves, restrições nomeadas e ações referenciais justificadas em comentário. O script tem que rodar do zero, duas vezes seguidas, sem erro. *Confira assim: `psql -d curso_bd -v ON_ERROR_STOP=1 -f ex01.sql` duas vezes seguidas; se a segunda falhar, faltam os `DROP TABLE IF EXISTS` na ordem certa.*
2. **`ex02.sql`** — acrescente ao seu esquema **três `CHECK`** que representem regras reais do seu minimundo, cada um com nome próprio e um comentário dizendo que frase do enunciado ele implementa. Pelo menos um deve comparar **duas colunas** da mesma linha. *Confira assim: para cada `CHECK`, escreva também o `INSERT` que ele deve recusar, rode, e cole a mensagem de erro.*
3. **`ex03.sql`** — prove que as suas chaves estrangeiras funcionam. Escreva **três `INSERT` que devem falhar**: um violando FK, um violando `UNIQUE` e um violando `NOT NULL`. Cole a saída dos três, e explique em uma linha o que cada mensagem está dizendo. *Confira assim: as três mensagens precisam citar o nome da restrição que você escolheu — se citarem nomes automáticos, você não nomeou as restrições.*
4. **`ex04.sql`** — o cliente pediu duas mudanças no banco **que já está em produção com dados**: (a) guardar a data de nascimento dos usuários, obrigatória; (b) impedir que dois registros tenham o mesmo e-mail. Escreva os `ALTER TABLE` que fazem isso sem perder dado nenhum, e explique por que (a) não pode ser feito num comando só. *Confira assim: rode contra o seu banco já carregado; se algum comando falhar, é exatamente o problema que o exercício quer que você resolva.*
5. **Desafio 🌶️ `ex05.sql`** — rode o [`02-ddl.sql`](exemplos/02-ddl.sql) e o [`03-carga.sql`](exemplos/03-carga.sql) da Biblioteca. Depois: (a) tente apagar o usuário `202310100` e explique o que acontece; (b) tente apagar a obra `978-85-1111-111-1` e explique; (c) apague o usuário `900100100` e conte quantas linhas sumiram, em quais tabelas; (d) mude uma ação referencial do `02-ddl.sql` de forma a tornar o item (a) destrutivo, rode de novo e mostre o estrago. Ao fim, escreva as três perguntas que você fará antes de declarar um `CASCADE`. *Confira assim: os itens (a) e (b) devem ser recusados pelo banco, e o (c) tem que apagar linhas em mais de uma tabela.*

## 🧠 Revisão

[8 questões de múltipla escolha](revisao/README.md) para conferir se os conceitos ficaram sólidos. Responda sem consultar a aula — depois volte e corrija.

## ✅ Entrega

```bash
psql -d curso_bd -v ON_ERROR_STOP=1 -f ex01.sql
git add aula-13/
git commit -m "Resolve exercícios da aula 13 (SQL DDL)"
git push
```

---

⬅️ [Aula 12](../../bloco-3-o-sgbd-na-pratica/aula-12-o-que-o-sgbd-garante/README.md) | ➡️ [Aula 14 — SQL DML e o `SELECT` simples](../aula-14-sql-dml-e-select/README.md)
