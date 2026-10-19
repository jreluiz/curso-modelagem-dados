# Aula 12 — Consultas Básicas em SQL

> 🎯 Objetivos: escrever consultas com `SELECT`, `WHERE`, `ORDER BY` e `LIMIT` sobre uma tabela, juntar duas ou três tabelas seguindo as chaves estrangeiras, e transformar uma pergunta do minimundo em consulta.
> 🎬 Slides da aula: [apresentacao-12-consultas-basicas.pdf](apresentacao/apresentacao-12-consultas-basicas.pdf)
> 🧪 **O banco desta aula, no navegador:** [DB Fiddle — Biblioteca, Aula 12](https://www.db-fiddle.com/f/7pKUAennP692gFYe3JqY38/1) — o banco da Aula 11, já com os dados. Escreva as consultas no painel da direita (*Query SQL*) e clique em **Run**.

Na Aula 11, o esquema da biblioteca virou banco, e o banco aprendeu a dizer **não**. Hoje ele aprende a **responder**. Quem está com livro atrasado? Que exemplares estão na estante? Quais livros essa editora publicou? Cada pergunta do balcão vira um comando, o **`SELECT`**, e a resposta volta como uma tabela.

Não há tabela nova nem regra nova. As chaves estrangeiras que você desenhou desde a Aula 07 passam a servir de **caminho**: é seguindo as setas do esquema que uma consulta junta informação espalhada em várias tabelas.

## 1. `SELECT`: as colunas que a resposta mostra

A consulta mais simples pede todas as colunas de uma tabela:

```sql
SELECT * FROM editora;
```

| cnpj | nome | rua | numero | cidade |
|---|---|---|---|---|
| 11111111000101 | Editora Aurora | Rua das Flores | 100 | Porto Alegre |
| 22222222000102 | Editora Vértice | Av. Central | 2500 | São Paulo |
| 33333333000103 | Editora Ponte Alta | | | Curitiba |

Lê-se: *"selecione tudo (`*`) da tabela `editora`"*. Na maior parte das vezes, porém, a pergunta quer só algumas colunas. Elas vêm listadas no lugar do `*`, na ordem em que devem aparecer:

```sql
SELECT titulo, ano
FROM livro;
```

O resultado tem as seis linhas de `livro`, mas só as duas colunas pedidas. A tabela continua inteira no banco; a consulta só **lê**, e nunca muda nada.

> 💡 **A resposta de uma consulta também é uma tabela.** Ela tem colunas com nome e linhas, como as tabelas que você desenhou. É essa a ideia de Codd que a Aula 02 contou: tudo é tabela, inclusive a resposta, e por isso dá para combinar consultas como se combinam tabelas.

## 2. `WHERE`: as linhas que interessam, e o vazio

O `SELECT` escolhe as **colunas**; o **`WHERE`** escolhe as **linhas**. Só entram no resultado as linhas em que a condição é verdadeira:

```sql
SELECT titulo, ano
FROM livro
WHERE ano >= 2015;
```

Quatro dos seis livros passam: *Modelagem na Prática* (2019), *SQL para Iniciantes* (2021), *História da Computação* (2016) e *Projeto de Sistemas* (2023).

As peças que o curso usa numa condição:

| Peça | Significa | Exemplo |
|---|---|---|
| `=`, `<>` | igual, diferente | `situacao = 'disponivel'` |
| `<`, `<=`, `>`, `>=` | menor, maior… — vale para número, data e texto | `data_retirada < '2026-11-17'` |
| `AND`, `OR` | as duas condições; pelo menos uma | `ano >= 2015 AND cnpj = '33333333000103'` |
| `IN (…)` | um dos valores da lista | `situacao IN ('em reparo', 'descartado')` |
| `LIKE` | texto que segue um padrão; `%` vale "qualquer coisa" | `email LIKE '%@aluno.br'` |
| `IS NULL`, `IS NOT NULL` | vazio, preenchido | `data_devolucao IS NULL` |

Texto e data vão entre aspas simples, como no `INSERT`. E o texto é comparado letra por letra: `'ana souza'` não encontra `'Ana Souza'`.

**O vazio tem um teste próprio.** Os empréstimos em aberto são os que ainda não têm data de devolução. A tentação é escrever:

```sql
SELECT numero FROM emprestimo WHERE data_devolucao = NULL;    -- 0 linhas
```

E o resultado vem **vazio**, sem erro nenhum, embora existam quatro empréstimos em aberto. `NULL` não é um valor: é a **ausência** de valor. Por isso, comparar qualquer coisa com `NULL` usando `=` nunca dá verdadeiro, nem quando a coluna também está vazia. O teste certo é **`IS NULL`**:

```sql
SELECT numero, data_retirada, codigo_usuario
FROM emprestimo
WHERE data_devolucao IS NULL;                                  -- 4 linhas
```

> ⚠️ **O `= NULL` não dá erro, e é por isso que é perigoso.** O banco executa, devolve zero linhas, e quem lê conclui que *"não há empréstimo em aberto"*. A resposta errada parece uma resposta. Sempre que a condição envolver vazio, use `IS NULL` ou `IS NOT NULL`.

### ✏️ Tente você

Escreva a consulta que mostra o título e o ano dos livros da Editora Vértice (CNPJ `22222222000102`) publicados **antes** de 2015.

<details>
<summary>Resposta</summary>

```sql
SELECT titulo, ano
FROM livro
WHERE cnpj = '22222222000102' AND ano < 2015;
```

Uma linha: *Algoritmos em Português*, de 2008. *SQL para Iniciantes* também é da Vértice, mas é de 2021, e o `AND` exige as duas condições.
</details>

## 3. `ORDER BY` e `LIMIT`: a ordem da resposta

Sem pedido explícito, o banco devolve as linhas **na ordem que for mais conveniente para ele**, e essa ordem pode mudar de uma vez para outra. Se a ordem importa, ela se pede com **`ORDER BY`**:

```sql
SELECT titulo, ano
FROM livro
WHERE ano >= 2015
ORDER BY ano DESC;
```

| titulo | ano |
|---|---|
| Projeto de Sistemas | 2023 |
| SQL para Iniciantes | 2021 |
| Modelagem na Prática | 2019 |
| História da Computação | 2016 |

`DESC` é decrescente. Sem ele, a ordem é crescente: do menor número, da data mais antiga, do começo do alfabeto. E o **`LIMIT`** corta o resultado depois de ordenado. Os três livros mais antigos do acervo:

```sql
SELECT titulo, ano
FROM livro
ORDER BY ano
LIMIT 3;
```

A ordem das cláusulas é fixa, e é a ordem em que se pensa a pergunta:

```
   SELECT   as colunas que a resposta mostra
   FROM     a tabela de onde elas vêm
   WHERE    as linhas que interessam
   ORDER BY a ordem da resposta
   LIMIT    quantas linhas, no máximo
```

### ✏️ Tente você

Escreva a consulta que mostra os títulos dos três primeiros livros em ordem alfabética.

<details>
<summary>Resposta</summary>

```sql
SELECT titulo
FROM livro
ORDER BY titulo
LIMIT 3;
```

*Algoritmos em Português*, *História da Computação* e *Introdução aos Bancos de Dados*. Não há `WHERE`, porque a pergunta vale para o acervo inteiro: cada cláusula só entra quando a pergunta pede.
</details>

## 4. A primeira junção: `JOIN … ON`

A pergunta *"qual é a editora de cada livro?"* esbarra no que a normalização fez na Aula 10: o nome da editora **não está** em `livro`. Lá está só o `cnpj`, a chave estrangeira, e o nome mora em `editora`. Para responder, é preciso **juntar** as duas tabelas:

```sql
SELECT livro.titulo, editora.nome
FROM livro
JOIN editora ON livro.cnpj = editora.cnpj;
```

O `JOIN` põe lado a lado uma linha de `livro` e uma linha de `editora`, e o **`ON`** diz qual com qual: as que têm o **mesmo CNPJ**. É exatamente a ligação que a seta `cnpj → EDITORA` desenhava no esquema lógico.

| titulo | nome |
|---|---|
| Introdução aos Bancos de Dados | Editora Aurora |
| Modelagem na Prática | Editora Aurora |
| SQL para Iniciantes | Editora Vértice |
| Algoritmos em Português | Editora Vértice |
| História da Computação | Editora Ponte Alta |
| Projeto de Sistemas | Editora Ponte Alta |

Seis livros, seis linhas: cada livro encontrou a sua editora. É a junção que a Aula 10 prometia quando conferia a decomposição sem perda — juntar pela coluna em comum devolve a informação que a planilha tinha numa linha só.

**O nome da tabela na frente da coluna.** As duas tabelas têm uma coluna `cnpj` e uma coluna `nome`. Escrever só `cnpj = cnpj` deixa o banco sem saber qual é qual, e ele recusa: *`column reference "cnpj" is ambiguous`*. Para não escrever o nome inteiro toda vez, cada tabela pode ganhar um **apelido** curto no `FROM`:

```sql
SELECT l.titulo, ed.nome
FROM livro l
JOIN editora ed ON l.cnpj = ed.cnpj
WHERE ed.cidade = 'Curitiba';
```

> ⚠️ **Junção sem condição multiplica.** Uma forma antiga de juntar lista as tabelas separadas por vírgula, com a condição no `WHERE`: `FROM livro, editora WHERE livro.cnpj = editora.cnpj`. Se a condição for esquecida, o banco **não reclama**: combina cada livro com **cada** editora, e devolve 6 × 3 = **18** linhas. Doze delas dizem que um livro é de uma editora que não o publicou. Esse resultado tem nome, **produto cartesiano**, e o sintoma é sempre o mesmo: linhas demais, e repetidas.

### ✏️ Tente você

Escreva a consulta que mostra os títulos dos livros da **Editora Aurora**, usando o **nome** da editora, e não o CNPJ.

<details>
<summary>Resposta</summary>

```sql
SELECT l.titulo
FROM livro l
JOIN editora ed ON l.cnpj = ed.cnpj
WHERE ed.nome = 'Editora Aurora';
```

Duas linhas: *Introdução aos Bancos de Dados* e *Modelagem na Prática*. O nome só existe em `editora`, então a junção é obrigatória. Uma coluna pode estar no `WHERE` sem aparecer no `SELECT`.
</details>

## 5. Três tabelas: seguindo as setas

*"Quem está com livro emprestado agora, e qual livro?"* A resposta precisa de três tabelas: o empréstimo em aberto está em `emprestimo`, o nome está em `usuario` e o título está em `livro`. Cada `JOIN` a mais segue mais uma seta:

```sql
SELECT u.nome, l.titulo, em.data_retirada
FROM emprestimo em
JOIN usuario u ON em.codigo_usuario = u.codigo
JOIN livro   l ON em.isbn = l.isbn
WHERE em.data_devolucao IS NULL
ORDER BY em.data_retirada;
```

| nome | titulo | data_retirada |
|---|---|---|
| Ana Souza | Introdução aos Bancos de Dados | 2026-10-20 |
| Carlos Mendes | SQL para Iniciantes | 2026-11-05 |
| Carla Dias | Modelagem na Prática | 2026-11-20 |
| Eduardo Reis | Projeto de Sistemas | 2026-11-28 |

Repare no segundo `JOIN`. A chave estrangeira de `emprestimo` aponta para `exemplar`, e não para `livro`. Mas o `isbn` do empréstimo é o `isbn` do exemplar, que é o `isbn` do livro: é a chave da entidade dona, propagada pela entidade fraca (Aula 06) até o empréstimo (Aula 07). Por isso a consulta pode **pular** `exemplar` e ir direto ao livro.

Nem sempre dá para pular. Entre `livro` e `autor` não existe seta nenhuma: o N:M virou a tabela `escreve` na Aula 07, e a consulta **tem de passar por ela**.

### ✏️ Tente você

Escreva a consulta que mostra, para cada livro, o título e o sobrenome de cada autor.

<details>
<summary>Resposta</summary>

```sql
SELECT l.titulo, a.sobrenome
FROM livro l
JOIN escreve s ON l.isbn = s.isbn
JOIN autor   a ON s.cpf = a.cpf;
```

Oito linhas, uma por linha de `escreve`. Os livros com dois autores aparecem duas vezes, e isso está certo: cada linha da resposta é **uma autoria**, e não um livro.
</details>

## 6. Da pergunta do balcão à consulta

Hoje é 1º de dezembro de 2026, e a bibliotecária pergunta: *"quem está com livro atrasado, e qual livro? Quero mandar um e-mail para cada um."* O prazo de empréstimo é de 14 dias.

Toda consulta desta aula se monta com as mesmas quatro perguntas, e cada uma responde uma cláusula:

| Pergunta | Na biblioteca | Cláusula |
|---|---|---|
| **1.** O que a resposta mostra? | o nome, o e-mail e o título — e a data, para conferir | `SELECT` |
| **2.** Em que tabelas isso mora? | nome e e-mail em `usuario`, título em `livro`, a situação em `emprestimo` — e as setas que as ligam | `FROM` e `JOIN … ON` |
| **3.** Que linhas interessam? | não devolvido **e** retirado há mais de 14 dias, ou seja, antes de 17/11 | `WHERE` |
| **4.** Em que ordem? | o atraso mais antigo primeiro | `ORDER BY` |

As quatro respostas, juntas:

```sql
SELECT u.nome, u.email, l.titulo, em.data_retirada
FROM emprestimo em
JOIN usuario u ON em.codigo_usuario = u.codigo
JOIN livro   l ON em.isbn = l.isbn
WHERE em.data_devolucao IS NULL
  AND em.data_retirada < '2026-11-17'
ORDER BY em.data_retirada;
```

| nome | email | titulo | data_retirada |
|---|---|---|---|
| Ana Souza | ana@aluno.br | Introdução aos Bancos de Dados | 2026-10-20 |
| Carlos Mendes | carlos@prof.br | SQL para Iniciantes | 2026-11-05 |

Dois atrasados. Carla e Eduardo estão com livro, mas dentro do prazo.

> 💡 **Num sistema de verdade, a data não fica escrita na consulta.** O PostgreSQL sabe a data de hoje, `CURRENT_DATE`, e sabe fazer conta com datas: a condição vira `em.data_retirada < CURRENT_DATE - 14`. Aqui ela fica fixa para que o resultado seja o mesmo para todo mundo, em qualquer dia em que a consulta for rodada.

A Aula 01 começou com uma planilha que se contradizia. O curso termina com um banco que **recusa** o que contradiz as regras do minimundo e **responde** ao que se pergunta a ele. Cada pedaço da consulta acima saiu de uma decisão tomada no papel: o `JOIN` segue uma seta da Aula 07, o `IS NULL` respeita o vazio que a mesma Aula 07 ensinou a não tratar como erro, e o fato de o nome estar num lugar só é a normalização da Aula 10.

> 📖 **Daqui para a frente.** Contar e agrupar (`COUNT`, `GROUP BY`), consultas dentro de consultas, mudar e apagar dados, transações: é o caminho de um curso de SQL. A [documentação do PostgreSQL](https://www.postgresql.org/docs/current/tutorial-sql.html) tem um tutorial que repassa o que o curso viu e segue adiante, e o DB Fiddle continua aberto para experimentar.

> 💻 **Modelos desta aula:** [`perguntas-do-balcao.md`](exemplos/perguntas-do-balcao.md) — **três perguntas do balcão levadas até a consulta**, cada uma com a tabela das quatro perguntas, o `SELECT` comentado e o resultado; depois, os três defeitos que mais aparecem e o roteiro. Leia antes dos exercícios.

## 🏋️ Exercícios da aula

Em todos os exercícios:

- escreva cada consulta em SQL num bloco de código, com um comentário (`--`) dizendo **qual pergunta** ela responde;
- quando houver `JOIN`, diga **qual seta do esquema** cada `ON` segue.

**Rodar é opcional, e vale a pena.** Abra o [link da aula](https://www.db-fiddle.com/f/7pKUAennP692gFYe3JqY38/1), escreva a consulta no painel da direita e clique em **Run**. Confira o resultado com o número de linhas indicado em cada exercício.

Na pasta `aula-12/` do seu repositório, um arquivo `.md` por exercício:

1. **`ex01.md`** — Consultas sobre **uma tabela**. Escreva as quatro:

   - a) os exemplares que **não** estão disponíveis, com a situação de cada um;
   - b) o nome e o e-mail dos usuários com e-mail de professor (terminado em `@prof.br`), em ordem alfabética de nome;
   - c) os empréstimos **já devolvidos**, do mais recente para o mais antigo pela data de retirada;
   - d) o título e o ano dos **dois** livros mais recentes do acervo.

   *Confere assim: a) 5 linhas; b) 2 linhas, Carlos antes de Dora; c) 3 linhas, a primeira retirada em 03/11; d) 2 linhas, 2023 e 2021. Se a c) voltou vazia, procure um `= NULL` — ou um `<> NULL`, que tem o mesmo defeito.*

2. **`ex02.md`** — Consultas sobre **duas tabelas**. Escreva as três:

   - a) o título de cada livro da Editora Vértice, usando o **nome** da editora;
   - b) o título do livro e o número de cada exemplar **disponível**, em ordem de título;
   - c) o nome e o curso de cada aluno, em ordem alfabética de nome.

   *Confere assim: a) 2 linhas; b) 4 linhas; c) 5 linhas — e Carlos Mendes está entre elas, com o Mestrado em Computação. Se você estranhou um professor na lista, releia a especialização sobreposta da Aula 09.*

3. **`ex03.md`** — Do balcão à consulta, e de volta. Para as duas primeiras, preencha antes a tabela das quatro perguntas da seção 6; depois escreva a consulta.

   - a) *"Que livros a Ana Souza já retirou, e quando?"* — use o **nome** dela, e não o código;
   - b) *"Quem são os autores de* Projeto de Sistemas*, na ordem em que aparecem na capa?"*
   - c) O caminho inverso: escreva, numa frase do balcão, a pergunta que esta consulta responde, e explique por que ela consegue ir de `oficina` direto para `usuario` sem passar por `professor`.

   ```sql
   SELECT u.nome, o.tema, o.data
   FROM oficina o
   JOIN usuario u ON o.codigo_professor = u.codigo
   ORDER BY o.data;
   ```

   *Confere assim: a) 2 linhas, com o mesmo título duas vezes — e está certo, são dois empréstimos; b) 2 linhas, e a ordem da capa é a coluna `ordem` de `escreve`; c) a pista está na estratégia B da Aula 09: qual é a chave primária de `professor`, e de onde ela vem?*

### 📤 Entrega

Estes exercícios são feitos em sala e vão para o **seu repositório** `exercicios-modelagem-dados`:

```bash
cd ..                 # da pasta da aula para a raiz do repositório
git add aula-12/
git commit -m "Resolve exercícios da aula 12"
git push
```

Confira no navegador que a pasta apareceu em `github.com/SEU-USUARIO/exercicios-modelagem-dados`.

## 🧠 Revisão

[8 questões de múltipla escolha](revisao/README.md) para conferir se os conceitos ficaram sólidos. Responda sem consultar a aula — depois volte e corrija.

---

⬅️ [Aula 11 — Do Esquema ao PostgreSQL](../aula-11-do-esquema-ao-postgresql/README.md) | 📚 [Leituras complementares](../../leituras-complementares/README.md)
