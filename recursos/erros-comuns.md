# 🧯 Erros Comuns

Duas metades: os erros de **modelagem** (que ninguém aponta para você, porque o modelo não "roda") e os erros do **PostgreSQL** (que aparecem em letras vermelhas). Os primeiros são mais caros.

---

## Parte 1 — Erros de modelagem

### Promover um atributo a entidade sem necessidade

**Sintoma:** o modelo tem uma tabela `SEXO`, com duas linhas: "M" e "F". Ou uma tabela `ESTADO_CIVIL` com quatro.

**Causa:** confundir "é um valor de domínio limitado" com "é uma coisa do mundo com identidade própria".

**Cura:** uma entidade precisa ter **atributos próprios** ou **relacionamentos próprios**. Se a tal entidade só tem código e descrição, e ninguém nunca vai pendurar nada nela, ela é um atributo com domínio restrito. Pergunte: *"o cliente algum dia vai querer guardar mais alguma coisa sobre isso?"* Se sim, entidade. Se não, atributo.

> 💡 O contrário também acontece e é pior: `TELEFONE` tratado como atributo quando o cliente precisa saber o tipo, o horário de contato e quem atendeu. Aí é entidade.

---

### O N:M que ninguém viu

**Sintoma:** o modelo diz que `PEDIDO` tem uma FK para `PRODUTO`. Aí chega o primeiro pedido com dois produtos.

**Causa:** ler o relacionamento em uma direção só. "Um pedido tem um produto" parece verdade quando você imagina o pedido mais simples possível.

**Cura:** leia **sempre nas duas direções**, e sempre no plural: *"Um pedido pode conter **vários** produtos?"* e *"Um produto pode aparecer em **vários** pedidos?"* Dois "sim" = N:M = precisa de **tabela associativa**. Não existe N:M direto entre duas tabelas — a FK não tem onde caber.

---

### A chave estrangeira do lado errado

**Sintoma:** num 1:N entre `DEPARTAMENTO` e `FUNCIONARIO`, a FK foi parar em `DEPARTAMENTO`. Aí o primeiro departamento com dois funcionários obriga a repetir a linha inteira do departamento.

**Causa:** copiar a direção da seta do diagrama em vez de perguntar de que lado cabe um valor só.

**Cura:** **a FK mora sempre do lado N** — do lado que tem um só do outro. Um funcionário tem um departamento: a coluna `departamento_id` cabe na linha do funcionário. Um departamento tem muitos funcionários: não cabe uma coluna com muitos valores, porque a célula guarda um valor só.

> ⚠️ Teste de uma linha: *"desse lado, quantos do outro cabem?"* Se a resposta for "vários", a FK **não** é aqui.

---

### "Quantos" e "é obrigatório" são duas perguntas

**Sintoma:** o aluno escreve "1:N obrigatório" achando que disse duas coisas sobre o mesmo lado.

**Causa:** são eixos **independentes**. O primeiro responde *"quantos, no máximo?"*; o segundo responde *"pode zero?"*.

**Cura:** todo lado de todo relacionamento tem **duas** respostas. Um departamento tem no máximo 1 gerente (quantos) e obrigatoriamente 1 gerente (não pode zero). São afirmações diferentes sobre o mundo, e no esquema viram coisas diferentes: a primeira decide onde a FK mora, a segunda decide se ela é `NOT NULL`.

---

### Entidade dependente × entidade com FK obrigatória

**Sintoma:** tudo que tem FK `NOT NULL` é tratado como parte da outra tabela, com `ON DELETE CASCADE` em tudo.

**Causa:** confundir *dependência de existência* com *dependência de identificação*.

**Cura:** a entidade dependente é a que **não consegue se identificar sozinha** — a chave dela inclui a chave da dona. `DEPENDENTE` de um funcionário é dependente: existem dois "João" e só o par (funcionário, nome) distingue. Já `PEDIDO` tem número próprio e único: mesmo que exija cliente, se identifica sozinho.

> ⚠️ Teste decisivo: **tire a tabela dona e pergunte se a chave ainda identifica.** Se a resposta for não, é dependente — e só aí `CASCADE` é a ação certa.

---

### FK apontando para atributo que não é chave

**Sintoma:** `PEDIDO.nome_cliente` referenciando `CLIENTE.nome`.

**Causa:** referenciar o que é legível em vez do que é identificador.

**Cura:** chave estrangeira referencia **chave primária ou candidata (`UNIQUE`)** — nada mais. Nome não é único, e se fosse, mudaria. O nome legível você busca com uma junção.

---

### Chave primária composta desnecessária

**Sintoma:** `PRODUTO` com PK `(codigo, nome, fabricante)`.

**Causa:** achar que a PK precisa "descrever" a linha.

**Cura:** a chave é o **conjunto mínimo** que identifica. Se `codigo` já identifica, acrescentar qualquer coisa não é chave candidata — é desperdício que se propaga para toda FK que apontar para ela.

---

### A tabela que não foi normalizada por preguiça

**Sintoma:** `PEDIDO(numero, data, cliente_id, cliente_nome, cliente_cidade, ...)` — "é que assim eu não preciso de junção".

**Causa:** otimizar antes de existir problema, e pagar com o dado errado em dois lugares.

**Cura:** o nome do cliente depende do **cliente**, não do pedido — é 3FN e a regra é uma frase: *todo atributo depende da chave, e de nada além dela*. Quando o cliente muda de cidade, a versão duplicada não muda junto, e aí ninguém sabe qual é a verdadeira.

> 💡 Desnormalizar é decisão legítima — **depois** de medir, com o motivo escrito e alguém responsável por manter as cópias em dia. Antes disso é só erro com nome bonito.

---

### O ciclo redundante

**Sintoma:** `ALUNO` → `TURMA` → `CURSO`, e também `ALUNO` → `CURSO` direto.

**Causa:** modelar cada frase do enunciado como um relacionamento independente.

**Cura:** nem todo ciclo é erro — o erro é o ciclo em que **um caminho é derivável do outro**. Se o curso do aluno é sempre o curso da turma dele, o relacionamento direto é redundante e vai permitir contradição. Se o aluno pode se matricular em curso diferente do da turma, os dois caminhos significam coisas diferentes e ambos ficam. Decida com o cliente, e **escreva a decisão**.

---

### O modelo que não foi lido em voz alta

**Sintoma:** o diagrama está bonito e ninguém percebeu que ele afirma que um empréstimo pode existir sem exemplar.

**Cura:** o ritual final de todo modelo — leia **cada** linha do diagrama como uma frase em português e pergunte se é verdade no minimundo. Cinco minutos de leitura em voz alta encontram mais defeitos que uma hora olhando o desenho.

---

## Parte 2 — Erros do PostgreSQL

### `ERROR: relation "aluno" does not exist`

**Causa:** a tabela não foi criada, você está no banco errado, ou — o caso mais cruel — criou com aspas duplas e maiúsculas: `CREATE TABLE "Aluno"`.

**Cura:** `\dt` no `psql` lista as tabelas do banco atual e `\c curso_bd` troca de banco. Sobre as aspas: o PostgreSQL **normaliza tudo para minúsculas** quando você não usa aspas, mas preserva exatamente o que está entre elas. `"Aluno"` e `aluno` viram nomes diferentes. **Nunca use aspas duplas em nome de tabela ou coluna** — é o único conselho deste arquivo que não tem exceção.

---

### `ERROR: insert or update on table "emprestimo" violates foreign key constraint "emprestimo_cpf_fkey"` — `DETAIL: Key (cpf)=(12345678901) is not present in table "aluno".`

**Causa:** integridade referencial funcionando exatamente como você pediu. Está tentando referenciar algo que não existe.

**Cura:** insira na ordem das dependências — **primeiro as tabelas referenciadas, depois as que referenciam**. No script de carga, a ordem é sempre: tabelas independentes → tabelas dependentes → tabelas associativas. Se o erro aparece num `DELETE`, é o inverso: alguém ainda aponta para a linha que você quer apagar; ou apague os dependentes antes, ou declare `ON DELETE CASCADE` sabendo o que está autorizando.

---

### `ERROR: duplicate key value violates unique constraint "aluno_pkey"`

**Causa:** duas linhas com a mesma chave primária. Em carga de teste, quase sempre é o script rodado duas vezes.

**Cura:** para recomeçar limpo, `TRUNCATE TABLE aluno CASCADE;` ou rode o `01-ddl.sql` de novo (ele começa com `DROP TABLE IF EXISTS`). Em produção isso é outra conversa — ali o erro está te protegendo.

---

### `ERROR: column "a.nome" must appear in the GROUP BY clause or be used in an aggregate function`

**Causa:** o campeão de todas as aulas de SQL. Você pediu um campo linha-a-linha ao lado de um resultado de grupo.

```sql
SELECT nome, COUNT(*) FROM aluno GROUP BY curso;   -- ✗ qual nome? são 40 alunos no grupo
```

**Cura:** todo campo do `SELECT` que **não** está dentro de uma função de agregação precisa estar no `GROUP BY`. Ou agrupe por ele, ou agregue-o (`MAX(nome)`), ou tire-o da consulta.

---

### `ERROR: null value in column "titulo" of relation "livro" violates not-null constraint`

**Causa:** faltou valor numa coluna obrigatória — geralmente porque o `INSERT` não listou as colunas e a ordem saiu trocada.

**Cura:** **sempre liste as colunas** no `INSERT`: `INSERT INTO livro (isbn, titulo, ano) VALUES (...)`. Mais longo de escrever, imune a mudança de esquema, e o erro vira legível.

---

### `ERROR: syntax error at or near ")"`

**Causa:** vírgula sobrando antes do parêntese que fecha o `CREATE TABLE` — o erro mais comum do mundo em DDL.

**Cura:** a última coluna e a última restrição **não** levam vírgula. O PostgreSQL informa a posição (`LINE 7:`); conte a partir dali para trás.

---

### `ERROR: operator does not exist: character varying = integer`

**Causa:** comparar texto com número — normalmente uma FK declarada como `VARCHAR` de um lado e `INTEGER` do outro.

**Cura:** os dois lados de uma FK precisam do **mesmo tipo**. Se o erro aparece num `WHERE`, converta explicitamente (`WHERE cpf = '123'::varchar`), mas entenda por que o tipo estava errado antes de converter.

---

### A consulta com `NOT IN` que devolve zero linhas sem motivo

**Causa:** não é erro, é `NULL`. Se a subconsulta de um `NOT IN` retorna **um único `NULL`**, o resultado inteiro é vazio — porque "x não está na lista" é indecidível quando a lista contém desconhecido.

```sql
SELECT * FROM aluno WHERE cpf NOT IN (SELECT cpf FROM emprestimo);  -- vazio se algum cpf for NULL
```

**Cura:** use `NOT EXISTS`, que trata `NULL` como você espera:

```sql
SELECT * FROM aluno a WHERE NOT EXISTS (SELECT 1 FROM emprestimo e WHERE e.cpf = a.cpf);
```

---

### O `UPDATE` sem `WHERE`

**Sintoma:** `UPDATE 4127` quando você esperava `UPDATE 1`.

**Cura preventiva, e vale para o resto da carreira:** escreva o comando primeiro como `SELECT`, confira o número de linhas, e só então troque `SELECT *` por `UPDATE ... SET`. Em trabalho sério, embrulhe em transação:

```sql
BEGIN;
UPDATE livro SET ano = 2020 WHERE isbn = '978-85-1234-567-8';
-- confira o resultado; se estiver errado: ROLLBACK;
COMMIT;
```

---

## Método universal de depuração de um modelo

Quando o modelo "parece certo" mas alguma coisa incomoda, rode estas quatro perguntas:

1. **Leia cada relacionamento em voz alta, nas duas direções.** A frase é verdade no minimundo?
2. **Invente três instâncias reais** e tente guardá-las no modelo. Alguma não cabe? Alguma exige repetir informação?
3. **Tente inserir e apagar.** Existe alguma informação que você só consegue guardar inventando uma linha falsa? (anomalia de inserção) Existe alguma que some sem querer? (anomalia de exclusão)
4. **Procure o mesmo dado escrito em dois lugares.** Se existe, quem garante que eles concordam?

---

🏠 [Voltar ao início](../README.md)
