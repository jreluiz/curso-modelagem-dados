# Aula 13 — SQL DDL: Criando o Esquema

> 🎯 Objetivos: transformar um esquema relacional em um script `CREATE TABLE` completo, declarar as restrições que garantem a integridade e ler as mensagens de erro do PostgreSQL.

> 🛠️ A partir daqui você precisa do PostgreSQL instalado e do banco `curso_bd` criado — veja o [guia de ambiente](../../recursos/ambiente.md).
> 🎬 Slides da aula: [apresentacao-13-sql-ddl.pdf](apresentacao/apresentacao-13-sql-ddl.pdf)

## 1. Do esquema relacional ao script

O trabalho dos Blocos 2 e 3 termina aqui. Cada linha do esquema relacional da Aula 10 vira um `CREATE TABLE`, e cada restrição que você escreveu em português vira uma cláusula que o banco passa a **verificar sozinho**, para sempre.

```
OBRA(isbn, titulo, ano_publicacao, editora)
```

```sql
CREATE TABLE obra (
    isbn            VARCHAR(17)  PRIMARY KEY,
    titulo          VARCHAR(200) NOT NULL,
    ano_publicacao  INTEGER      NOT NULL,
    editora         VARCHAR(100)
);
```

**Convenções do curso**, e nenhuma delas é gosto pessoal:

- **Tudo em minúsculas, sem acento, sem aspas duplas.** O PostgreSQL normaliza identificadores não citados para minúsculas; usar aspas cria nomes que só funcionam entre aspas para sempre;
- **Nome de tabela no singular** — a tabela `obra` guarda obras, e a linha é uma obra. Coerente com a convenção de entidades do MER;
- **Palavras-chave em MAIÚSCULAS**, identificadores em minúsculas. É legível e é o padrão de mercado;
- **`_` para separar palavras**: `ano_publicacao`, nunca `anoPublicacao`.

## 2. Tipos de dados

Os que resolvem 95% dos casos no PostgreSQL:

| Tipo | Use para | Observação |
|---|---|---|
| `INTEGER` | Inteiros | ±2 bilhões, suficiente quase sempre |
| `BIGINT` | Inteiros grandes | Chaves artificiais de tabelas enormes |
| `NUMERIC(p,s)` | **Dinheiro e qualquer valor exato** | `NUMERIC(10,2)` = 10 dígitos, 2 decimais |
| `REAL` / `DOUBLE PRECISION` | Medidas científicas | **Nunca** para dinheiro |
| `VARCHAR(n)` | Texto com limite | O limite é uma restrição de domínio, use-o |
| `TEXT` | Texto sem limite conhecido | Observações, descrições longas |
| `CHAR(n)` | Texto de tamanho **fixo** | Raro. Só quando o tamanho é imutável (UF, `CHAR(2)`) |
| `DATE` | Data | Sem hora |
| `TIMESTAMP` | Data e hora | Prefira `TIMESTAMPTZ` se houver fusos |
| `BOOLEAN` | Verdadeiro/falso | `TRUE`, `FALSE`, `NULL` |
| `SERIAL` / `GENERATED AS IDENTITY` | Chave artificial autoincrementada | Veja abaixo |

> ⚠️ **Nunca use `REAL` ou `DOUBLE PRECISION` para dinheiro.** São binários e não representam `0,10` exatamente. Somar `0,10` dez vezes não dá `1,00`, e a diferença aparece no fechamento do caixa. Dinheiro é `NUMERIC(p,s)`, sempre.

### Chave artificial autoincrementada

```sql
-- Forma moderna, padrão SQL (preferida):
id_emprestimo INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY

-- Forma antiga, ainda muito comum:
id_emprestimo SERIAL PRIMARY KEY
```

As duas criam um contador automático. `GENERATED ALWAYS AS IDENTITY` é padrão SQL e impede que alguém insira um valor manualmente por engano — o curso usa esta.

## 3. As restrições

Aqui o modelo conceitual finalmente vira lei. Cada restrição corresponde a algo que você já decidiu:

| Restrição | Garante | Veio de |
|---|---|---|
| `PRIMARY KEY` | Único e não nulo | Integridade de entidade (Aula 09) |
| `FOREIGN KEY` | O valor existe na tabela referenciada | Integridade referencial |
| `NOT NULL` | Valor obrigatório | Participação total / atributo obrigatório |
| `UNIQUE` | Sem repetição | **Chave alternativa** (Aula 04) |
| `CHECK` | Condição arbitrária | Domínio e integridade semântica |
| `DEFAULT` | Valor padrão quando omitido | Conveniência |

```sql
CREATE TABLE exemplar (
    tombo           INTEGER      PRIMARY KEY,
    isbn            VARCHAR(17)  NOT NULL,
    data_aquisicao  DATE         NOT NULL DEFAULT CURRENT_DATE,
    situacao        VARCHAR(20)  NOT NULL DEFAULT 'disponivel',

    CONSTRAINT fk_exemplar_obra
        FOREIGN KEY (isbn) REFERENCES obra (isbn)
        ON DELETE RESTRICT ON UPDATE CASCADE,

    CONSTRAINT ck_exemplar_situacao
        CHECK (situacao IN ('disponivel', 'emprestado', 'manutencao', 'extraviado'))
);
```

> 💡 **Nomeie suas restrições.** Sem `CONSTRAINT nome`, o PostgreSQL gera algo como `exemplar_situacao_check`. Com nome, o erro em produção diz `ck_exemplar_situacao` e você sabe imediatamente qual regra foi violada. Convenção do curso: `pk_`, `fk_`, `uq_`, `ck_` + tabela + coluna.

O `CHECK` é onde a **integridade semântica** da Aula 09 vira realidade:

```sql
CREATE TABLE emprestimo (
    id_emprestimo   INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    matricula       INTEGER NOT NULL,
    tombo           INTEGER NOT NULL,
    matricula_func  INTEGER NOT NULL,
    data_retirada   DATE    NOT NULL DEFAULT CURRENT_DATE,
    data_prevista   DATE    NOT NULL,
    data_devolucao  DATE,                    -- nulo = empréstimo em aberto

    CONSTRAINT fk_emp_usuario FOREIGN KEY (matricula)
        REFERENCES usuario (matricula) ON DELETE RESTRICT,
    CONSTRAINT fk_emp_exemplar FOREIGN KEY (tombo)
        REFERENCES exemplar (tombo) ON DELETE RESTRICT,
    CONSTRAINT fk_emp_funcionario FOREIGN KEY (matricula_func)
        REFERENCES funcionario (matricula_func) ON DELETE RESTRICT,

    CONSTRAINT ck_emp_prazo      CHECK (data_prevista > data_retirada),
    CONSTRAINT ck_emp_devolucao  CHECK (data_devolucao IS NULL
                                        OR data_devolucao >= data_retirada)
);
```

Repare em `ck_emp_devolucao`: sem o `data_devolucao IS NULL OR`, a restrição rejeitaria **todo empréstimo em aberto**, porque comparação com nulo dá `UNKNOWN`, e o `CHECK` só recusa quando o resultado é **falso**. Um `CHECK` que resulta em `UNKNOWN` **passa** — detalhe que engana muita gente nos dois sentidos.

### Chave composta e entidade fraca

```sql
CREATE TABLE renovacao (
    id_emprestimo       INTEGER NOT NULL,
    sequencia           INTEGER NOT NULL,
    data_renovacao      DATE    NOT NULL DEFAULT CURRENT_DATE,
    nova_data_prevista  DATE    NOT NULL,

    CONSTRAINT pk_renovacao PRIMARY KEY (id_emprestimo, sequencia),
    CONSTRAINT fk_renovacao_emprestimo FOREIGN KEY (id_emprestimo)
        REFERENCES emprestimo (id_emprestimo) ON DELETE CASCADE,
    CONSTRAINT ck_renovacao_seq CHECK (sequencia > 0)
);
```

A chave composta declara-se **depois** das colunas, com `PRIMARY KEY (a, b)`. E o `ON DELETE CASCADE` é a marca da entidade fraca — o que a Aula 09 concluiu, agora escrito.

## 4. `ON DELETE` e `ON UPDATE` na prática

Vamos ver o banco defendendo o modelo. Com a obra `978-01` tendo exemplares:

```sql
DELETE FROM obra WHERE isbn = '978-01';
```

```
ERROR:  update or delete on table "obra" violates foreign key constraint
        "fk_exemplar_obra" on table "exemplar"
DETAIL:  Key (isbn)=(978-01) is still referenced from table "exemplar".
```

**Isso é o sistema funcionando.** A mensagem diz exatamente qual restrição, qual chave e qual tabela — e impediu que exemplares ficassem órfãos.

Se fosse `ON DELETE CASCADE`, o mesmo comando apagaria a obra **e** todos os exemplares **e** todos os empréstimos daqueles exemplares, em silêncio, com resposta `DELETE 1`.

> ⚠️ Reveja a tabela de decisão da [Aula 09, seção 6](../../bloco-3-modelo-relacional/aula-09-modelo-relacional/README.md). A regra prática: **`CASCADE` só para entidade fraca**; para o resto, `RESTRICT`.

## 5. `ALTER TABLE` e `DROP`

Esquemas evoluem. `ALTER TABLE` altera sem perder os dados:

```sql
ALTER TABLE usuario ADD COLUMN data_nascimento DATE;
ALTER TABLE usuario ALTER COLUMN email SET NOT NULL;
ALTER TABLE usuario ADD CONSTRAINT uq_usuario_email UNIQUE (email);
ALTER TABLE usuario DROP COLUMN data_nascimento;
ALTER TABLE usuario RENAME COLUMN nome TO nome_completo;   -- quebra tudo que cita 'nome'
```

> ⚠️ **`ADD COLUMN ... NOT NULL` sem `DEFAULT` falha se a tabela já tiver linhas** — as existentes ficariam nulas. A sequência correta é: adicionar aceitando nulo, preencher com `UPDATE`, depois `SET NOT NULL`. Três comandos, e a migração não derruba nada.

Para remover:

```sql
DROP TABLE exemplar;              -- falha se houver FK apontando para ela
DROP TABLE exemplar CASCADE;      -- remove também as restrições dependentes
DROP TABLE IF EXISTS exemplar;    -- não reclama se não existir
```

### A ordem importa

Ao criar, as tabelas **referenciadas vêm primeiro**. Ao apagar, o inverso:

```sql
-- Cabeçalho padrão de todo script de recriação do curso:
DROP TABLE IF EXISTS renovacao, multa, emprestimo, reserva, telefone,
                     classificacao, escrita, exemplar, aluno, professor,
                     servidor, usuario, obra, autor, area, funcionario CASCADE;
```

## 6. Lendo os erros do PostgreSQL

O compilador do curso de programação é substituído aqui pelo **verificador de restrições**. Ele é um bom professor: reclama sempre no mesmo formato e diz onde.

```
ERROR:  null value in column "titulo" of relation "obra" violates not-null constraint
DETAIL:  Failing row contains (978-03, null, 2020, Campus).
```

Três informações em duas linhas: **qual restrição** (`not-null`), **qual coluna** (`titulo`) e **qual linha** causou. A linha `DETAIL` é a mais útil e a mais ignorada.

Catálogo completo com causa e cura: [erros comuns](../../recursos/erros-comuns.md#parte-2--erros-do-postgresql).

Para conferir o que o banco realmente entendeu do seu DDL:

```
curso_bd=# \d exemplar
```

Ele devolve as colunas, os tipos, os valores padrão, os índices, as restrições `CHECK` e as chaves estrangeiras — **nos dois sentidos**, inclusive quem referencia esta tabela. É a forma mais rápida de descobrir que uma restrição que você achou que declarou não está lá.

> 💻 **Scripts desta aula:** [`01-ddl.sql`](exemplos/01-ddl.sql) e [`02-carga.sql`](exemplos/02-carga.sql) — o esquema completo da Biblioteca, pronto para rodar. Veja o [README dos exemplos](exemplos/README.md).

## 🏋️ Exercícios da aula

Na pasta `aula-13/` do seu repositório. **Todo script precisa rodar do zero** — teste com `psql -d curso_bd -v ON_ERROR_STOP=1 -f ex01.sql`.

1. **`ex01.sql`** — escreva o DDL completo das tabelas `cliente`, `categoria`, `produto`, `pedido` e `item_pedido` do esquema que você mapeou no `ex01.md` da Aula 10. Inclua todas as PKs, FKs, `NOT NULL` e a ordem correta de criação. No topo do arquivo, um comentário com o esquema relacional em texto;
2. **`ex02.sql`** — acrescente ao script anterior, com `ALTER TABLE`, **cinco restrições `CHECK`** que traduzam regras de negócio reais: preço positivo, quantidade positiva, data de entrega não anterior à do pedido, situação num domínio fechado, e-mail contendo `@`. Nomeie todas seguindo a convenção `ck_tabela_coluna`;
3. **`ex03.sql`** — **prove que suas restrições funcionam.** Escreva um `INSERT` que viole cada uma das cinco restrições do exercício anterior, e cole a **mensagem de erro exata** do PostgreSQL num comentário abaixo de cada um. Um script de exercício que só contém comandos que funcionam não prova nada;
4. **`ex04.sql`** — a loja passou a precisar guardar o CPF do cliente (obrigatório e único) e a data de cancelamento do pedido (opcional). A tabela `cliente` já tem 3 registros. Escreva a **sequência correta** de `ALTER TABLE` que faz essa migração sem perder dados nem falhar, com um comentário explicando por que cada passo é necessário nessa ordem;
5. **Desafio 🌶️ `ex05.sql`** — escreva o DDL **completo** do modelo da Biblioteca (Aula 10, seção 10): as 16 tabelas, todas as FKs com a ação referencial que você justificou no `ex03.md` da Aula 09, e pelo menos 8 `CHECK`. O script precisa rodar do zero, duas vezes seguidas, sem erro — o que exige o cabeçalho de `DROP` da seção 5. Ao final, rode `\d` em três tabelas e cole a saída num comentário, conferindo se o banco entendeu o que você quis dizer.

## 🧠 Revisão

[8 questões de múltipla escolha](revisao/README.md) para conferir se os conceitos ficaram sólidos. Responda sem consultar a aula — depois volte e corrija.

## ✅ Entrega

```bash
git add aula-13/
git commit -m "Resolve exercícios da aula 13 (SQL DDL)"
git push
```

---

⬅️ [Aula 12](../../bloco-3-modelo-relacional/aula-12-normalizacao/README.md) | ➡️ [Aula 14 — SQL DML e consultas](../aula-14-sql-dml-consultas/README.md)
