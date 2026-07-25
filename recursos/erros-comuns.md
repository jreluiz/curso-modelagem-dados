# 🧯 Erros Comuns

Duas metades: os erros de **modelagem** (que ninguém aponta para você, porque o modelo não "roda") e os erros do **PostgreSQL** (que aparecem em letras vermelhas). Os primeiros são mais caros.

---

## Parte 1 — Erros de modelagem conceitual

### Promover um atributo a entidade sem necessidade

**Sintoma:** o DER tem uma entidade `SEXO`, com dois registros: "M" e "F". Ou uma entidade `ESTADO_CIVIL` com quatro.

**Causa:** confundir "é um valor de domínio limitado" com "é uma coisa do mundo com identidade própria".

**Cura:** uma entidade precisa ter **atributos próprios** ou **relacionamentos próprios**. Se a tal entidade só tem código e descrição, e ninguém nunca vai pendurar nada nela, ela é um atributo com domínio restrito. Pergunte: *"o cliente algum dia vai querer guardar mais alguma coisa sobre isso?"* Se sim, entidade. Se não, atributo.

> 💡 O contrário também acontece e é pior: `TELEFONE` tratado como atributo quando o cliente precisa saber o tipo, o horário de contato e quem atendeu. Aí é entidade.

---

### O N:M que ninguém viu

**Sintoma:** o modelo diz que um `PEDIDO` tem uma FK para `PRODUTO`. Aí chega o primeiro pedido com dois produtos.

**Causa:** ler o relacionamento em uma direção só. "Um pedido tem um produto" parece verdade quando você imagina o pedido mais simples possível.

**Cura:** leia **sempre nas duas direções**, e sempre no plural: *"Um pedido pode conter **vários** produtos?"* e *"Um produto pode aparecer em **vários** pedidos?"* Dois "sim" = N:M = precisa de entidade associativa.

---

### Cardinalidade invertida

**Sintoma:** o modelo diz 1:N, mas os dados dizem o contrário — ou a FK acaba na tabela errada e você precisa repetir linha.

**Causa:** em Chen, o número fica do lado oposto ao que a intuição pede.

**Cura:** o teste da frase única. Escreva: **"Um(a) ⟨A⟩ se relaciona com quantos(as) ⟨B⟩?"** e depois a recíproca. Anote os dois números *antes* de desenhar qualquer coisa. Melhor ainda: use `(min,max)`, que não deixa margem.

---

### Participação total confundida com cardinalidade

**Sintoma:** o aluno escreve "1:N total" achando que disse duas coisas sobre o mesmo lado.

**Causa:** são eixos **independentes**. Cardinalidade responde *"quantos, no máximo?"*; participação responde *"pode zero?"*.

**Cura:** todo lado de todo relacionamento tem **duas** respostas. Um departamento tem no máximo 1 gerente (cardinalidade) e obrigatoriamente 1 gerente (participação total). São afirmações diferentes sobre o mundo.

---

### Entidade fraca × entidade com FK obrigatória

**Sintoma:** tudo que tem FK `NOT NULL` vira entidade fraca no modelo.

**Causa:** confundir *dependência de existência* com *dependência de identificação*.

**Cura:** a entidade fraca é a que **não consegue se identificar sozinha** — a chave dela inclui a chave da dona. `DEPENDENTE` de um funcionário é fraca: existem dois "João" e só o par (funcionário, nome) distingue. Já `PEDIDO` tem número próprio e único: mesmo que exija cliente, é forte.

> ⚠️ Teste decisivo: **remova a entidade dona e pergunte se a chave ainda identifica**. Se a resposta for não, é fraca.

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

### O ciclo redundante

**Sintoma:** `ALUNO` → `TURMA` → `CURSO`, e também `ALUNO` → `CURSO` direto.

**Causa:** modelar cada frase do enunciado como um relacionamento independente.

**Cura:** nem todo ciclo é erro — o erro é o ciclo em que **um caminho é derivável do outro**. Se o curso do aluno é sempre o curso da turma dele, o relacionamento direto é redundante e vai permitir contradição. Se o aluno pode se matricular em curso diferente do da turma, os dois caminhos significam coisas diferentes e ambos ficam. Decida com o cliente, e **escreva a decisão**.

---

### Especialização que não paga o próprio custo

**Sintoma:** `PESSOA` especializada em `PESSOA_FISICA` e `PESSOA_JURIDICA`, com uma subclasse tendo um único atributo diferente.

**Causa:** aplicar herança por reflexo, vindo da programação orientada a objetos.

**Cura:** especialize quando a subclasse tiver **atributos próprios relevantes** ou **participar de relacionamentos próprios**. Um atributo a mais resolve-se com um campo opcional e um `CHECK`. Regra prática: menos de dois atributos exclusivos e nenhum relacionamento exclusivo, não especialize.

---

### O modelo que não foi lido em voz alta

**Sintoma:** o DER está bonito e ninguém percebeu que ele afirma que um empréstimo pode existir sem exemplar.

**Cura:** o ritual final de todo modelo — leia **cada** linha do diagrama como uma frase em português e pergunte se é verdade no minimundo. Cinco minutos de leitura em voz alta encontram mais defeitos que uma hora olhando o desenho.

---

## Parte 2 — Erros do PostgreSQL

### `ERROR: relation "aluno" does not exist`

**Causa:** a tabela não foi criada, você está no banco errado, ou — o caso mais cruel — criou com aspas duplas e maiúsculas: `CREATE TABLE "Aluno"`.

**Cura:** `\dt` no `psql` lista as tabelas do banco atual e `\c curso_bd` troca de banco. Sobre as aspas: o PostgreSQL **normaliza tudo para minúsculas** quando você não usa aspas, mas preserva exatamente o que está entre elas. `"Aluno"` e `aluno` viram nomes diferentes. **Nunca use aspas duplas em nome de tabela ou coluna** — é o único conselho deste arquivo que não tem exceção.

---

### `ERROR: insert or update on table "emprestimo" violates foreign key constraint "emprestimo_cpf_fkey"` — `DETAIL: Key (cpf)=(12345678901) is not present in table "aluno".`

**Causa:** integridade referencial funcionando exatamente como você pediu. Está tentando referenciar algo que não existe.

**Cura:** insira na ordem das dependências — **primeiro as tabelas referenciadas, depois as que referenciam**. No script de carga, a ordem é sempre: entidades fortes → entidades fracas → tabelas associativas. Se o erro aparece num `DELETE`, é o inverso: alguém ainda aponta para a linha que você quer apagar; ou apague os dependentes antes, ou declare `ON DELETE CASCADE` sabendo o que está autorizando.

---

### `ERROR: duplicate key value violates unique constraint "aluno_pkey"`

**Causa:** dois registros com a mesma chave primária. Em carga de teste, quase sempre é o script rodado duas vezes.

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
3. **Tente inserir e apagar.** Existe alguma informação que você só consegue guardar inventando um registro falso? (anomalia de inserção) Existe alguma que some sem querer? (anomalia de exclusão)
4. **Procure o mesmo dado escrito em dois lugares.** Se existe, quem garante que eles concordam?

---

🏠 [Voltar ao início](../README.md)
