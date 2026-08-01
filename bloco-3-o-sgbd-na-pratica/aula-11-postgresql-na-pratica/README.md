# Aula 11 — PostgreSQL na Prática

> 🎯 Objetivos: criar o banco do curso, navegar por ele com os comandos essenciais do `psql`, ler o catálogo e escolher o tipo de dado certo para cada atributo do seu modelo.
> 🎬 Slides da aula: [apresentacao-11-postgresql-na-pratica.pdf](apresentacao/apresentacao-11-postgresql-na-pratica.pdf)

## 1. O que você vai instalar

Duas coisas, e a segunda é opcional:

- **O servidor PostgreSQL** — o SGBD propriamente dito, o programa que fica rodando e guardando os dados;
- **Um cliente** — o programa com que você conversa com o servidor. O `psql`, que vem junto, é o do curso. Um cliente gráfico é conforto.

O passo a passo por sistema operacional está no [guia de ambiente](../../recursos/ambiente.md). Faça-o antes de continuar, e confirme com:

```bash
psql --version
```

Se responder `psql (PostgreSQL) 15.x` ou superior, você está pronto. Se responder "command not found", a instalação não terminou ou o `PATH` não foi atualizado — reabra o terminal antes de concluir que deu errado.

> 💡 Servidor e cliente são programas diferentes que **conversam por rede**, mesmo quando estão na mesma máquina. É por isso que existe uma porta (5432), um usuário e uma senha para uma coisa que está no seu próprio computador. Essa separação é o que permite, amanhã, o mesmo `psql` conectar num banco que está em outro continente.

## 2. Criar o banco do curso

Um servidor PostgreSQL guarda **vários bancos** independentes. O do curso chama-se `curso_bd`:

```bash
createdb curso_bd     # cria
psql -d curso_bd      # entra
```

Você deve ver o *prompt* mudar para `curso_bd=#`. Está dentro.

Se o `createdb` reclamar de usuário, entre pelo `psql` e crie por dentro:

```sql
CREATE DATABASE curso_bd;
\c curso_bd
```

Agora ponha alguma coisa lá dentro para ter o que olhar:

```bash
psql -d curso_bd -v ON_ERROR_STOP=1 -f 00-primeiro-contato.sql
```

> ⚠️ `-v ON_ERROR_STOP=1` faz o `psql` **parar no primeiro erro** em vez de seguir adiante deixando estrago. Sem essa opção, um script com um erro na linha 3 continua rodando as outras 200 linhas em cima de um banco meio construído. Adote o hábito agora.

> 💻 **Script desta aula:** [`00-primeiro-contato.sql`](exemplos/00-primeiro-contato.sql) — duas tabelas com dados, para você ter o que explorar. Ele usa a linguagem da Aula 13; **não tente entendê-lo ainda**, só rode.

## 3. `psql`: os comandos que valem decorar

Comandos que começam com contrabarra são do `psql`, não do SQL — eles não vão para o servidor, são atalhos do cliente:

| Comando | O que faz |
|---------|-----------|
| `\l` | Lista os bancos do servidor |
| `\c curso_bd` | Conecta a um banco |
| `\dt` | Lista as tabelas do banco atual |
| `\d livro` | Mostra a estrutura da tabela `livro` |
| `\i arquivo.sql` | Executa um script |
| `\x` | Alterna a saída para vertical — salva vidas em tabela larga |
| `\?` | Ajuda dos comandos `\` |
| `\q` | Sai |

Rode `\dt` e veja o que você acabou de criar:

```
               List of relations
 Schema |        Name        | Type  |  Owner
--------+--------------------+-------+---------
 public | emprestimo_simples | table | jreluiz
 public | livro              | table | jreluiz
(2 rows)
```

> ⚠️ Esqueceu o ponto e vírgula no fim de um comando SQL e o *prompt* virou `curso_bd-#`? O `psql` está esperando você terminar a frase. Digite `;` e Enter. Se quiser abandonar, `\r` limpa o que estava escrito.

## 4. Um cliente gráfico, se quiser

Escolha **um**:

- **[pgAdmin 4](https://www.pgadmin.org/)** — vem com o instalador do Windows, feito só para PostgreSQL;
- **[DBeaver Community](https://dbeaver.io/)** — funciona com qualquer banco e **gera o diagrama a partir das tabelas existentes**, o que é útil na Aula 13 para conferir se o seu script produziu o modelo que você desenhou.

> ⚠️ Cliente gráfico é conforto, não substituto. As aulas mostram os comandos no `psql` porque é o que existe em **qualquer** servidor, inclusive naquele em que você só tem um terminal — e porque clicar não ensina a ler mensagem de erro.

## 5. O catálogo por dentro

Na Aula 10 você viu que o banco guarda a própria descrição em tabelas. Agora dá para olhar. Digite `\d livro`:

```
                                    Table "public.livro"
  Column  |          Type          | Nullable |             Default
----------+------------------------+----------+---------------------------------
 tombo    | integer                | not null |
 titulo   | character varying(120) | not null |
 autor    | character varying(80)  | not null |
 ano      | integer                |          |
 situacao | character varying(20)  | not null | 'disponivel'::character varying
Indexes:
    "livro_pkey" PRIMARY KEY, btree (tombo)
Check constraints:
    "livro_ano_check" CHECK (ano >= 1450 AND ano <= 2100)
    "livro_situacao_check" CHECK (situacao::text = ANY (...))
Referenced by:
    TABLE "emprestimo_simples" CONSTRAINT "emprestimo_simples_tombo_fkey"
        FOREIGN KEY (tombo) REFERENCES livro(tombo)
```

Leia com calma: está tudo ali. A **chave primária** da Aula 02, o **domínio** e as restrições da Aula 04, e a **chave estrangeira** da Aula 03 — vista do outro lado, na linha `Referenced by`, que mostra quem aponta para esta tabela.

E o mesmo pode ser perguntado em SQL, porque o catálogo é tabela como qualquer outra:

```sql
SELECT table_name, column_name, data_type
FROM information_schema.columns
WHERE table_schema = 'public'
ORDER BY table_name, ordinal_position;
```

> 💡 `\d` é o comando mais útil do curso inteiro: ele mostra o seu modelo **como o banco realmente o entendeu**. Use-o toda vez que uma restrição não se comportar como você esperava — na maioria das vezes, ela não está lá.

## 6. Os tipos que você vai usar

O **domínio** que você escreveu em português na Aula 04 vira um tipo aqui. Estes seis resolvem quase tudo:

| Tipo | Para quê | Exemplo do modelo |
|---|---|---|
| `INTEGER` | Números inteiros | `tombo`, `ano_publicacao` |
| `VARCHAR(n)` | Texto de tamanho variável, com limite | `titulo VARCHAR(120)` |
| `CHAR(n)` | Texto de tamanho **fixo** | `matricula CHAR(9)` |
| `DATE` | Data sem hora | `data_retirada` |
| `NUMERIC(p,s)` | Números com casas decimais **exatas** | `valor NUMERIC(6,2)` |
| `BOOLEAN` | Verdadeiro ou falso | `ativo` |

> ⚠️ **Dinheiro nunca é `REAL` nem `FLOAT`.** Esses tipos guardam aproximações, e somar mil aproximações produz centavos que não existem. Para valor monetário, `NUMERIC(p,s)` — que guarda o número exato, com o preço de ser mais lento. Numa multa de biblioteca, ninguém vai medir a lentidão; todo mundo vai medir o centavo.

> 💡 `VARCHAR(n)` **não** é mais rápido que `TEXT` no PostgreSQL — o limite serve como restrição de domínio, não como otimização. Use `VARCHAR(n)` quando o limite significar alguma coisa no mundo real (um ISBN tem 17 caracteres) e não quando for um chute.

> 📖 A lista completa de tipos é uma das páginas mais consultadas da [documentação do PostgreSQL](https://www.postgresql.org/docs/current/datatype.html). Vale deixá-la num favorito: você vai voltar nela em toda tabela que criar.

## 🏋️ Exercícios da aula

Na pasta `aula-11/` do seu repositório:

1. **`ex01.md`** — instale o PostgreSQL, crie o banco `curso_bd` e rode o script desta aula. Entregue: a saída do `psql --version`, a saída do `\dt` e a saída do `\conninfo` (que diz a que banco e com que usuário você está conectado), coladas como texto. *Confira assim: o `\dt` precisa listar duas tabelas; se listar zero, o script rodou em outro banco.*
2. **`ex02.md`** — rode `\d livro` e `\d emprestimo_simples` e responda, citando o trecho da saída que prova cada resposta: (a) qual a chave primária de cada tabela? (b) que restrições de domínio existem em `livro`? (c) qual coluna aceita vazio e por quê? (d) onde aparece a chave estrangeira, e como ela é vista das **duas** tabelas? *Confira assim: a FK aparece de um jeito numa tabela e de outro na outra — as duas formas precisam estar na sua resposta.*
3. **`ex03.md`** — rode a consulta ao `information_schema` da seção 5 e cole o resultado. Depois responda: (a) quantas colunas o seu banco tem ao todo? (b) o `data_type` que o PostgreSQL reporta é igual ao que você escreveu no script? Aponte uma diferença e explique. *Confira assim: pelo menos um tipo que você escreveu aparece com outro nome — o PostgreSQL usa os nomes do padrão SQL.*
4. **`ex04.md`** — pegue o **seu** modelo do `ex04` da Aula 06 e escreva uma tabela de três colunas: atributo · domínio em português · tipo do PostgreSQL. Todos os atributos de todas as tabelas. Justifique em uma linha cada escolha de `VARCHAR(n)` — o que o número `n` significa no mundo real. *Confira assim: se algum `n` foi escolhido por chute, troque por um limite que você consiga defender, ou use `TEXT`.*
5. **Desafio 🌶️ `ex05.md`** — o `\d livro` mostra as restrições com nomes que ninguém escolheu: `livro_ano_check`, `livro_pkey`, `emprestimo_simples_tombo_fkey`. (a) Descubra a regra de formação desses nomes comparando os três; (b) encontre no `information_schema` a consulta que lista **todas** as restrições do seu banco com seus nomes e tipos; (c) explique por que dar nome às restrições você mesmo, em vez de aceitar o automático, é uma boa ideia — pense em quem lê a mensagem de erro. *Confira assim: a tabela do catálogo que você procura tem "constraint" no nome, e a regra de formação tem três partes.*

## 🧠 Revisão

[8 questões de múltipla escolha](revisao/README.md) para conferir se os conceitos ficaram sólidos. Responda sem consultar a aula — depois volte e corrija.

## ✅ Entrega

```bash
git add aula-11/
git commit -m "Resolve exercícios da aula 11 (PostgreSQL na prática)"
git push
```

---

⬅️ [Aula 10](../aula-10-arquitetura-independencia/README.md) | ➡️ [Aula 12 — O que o SGBD garante](../aula-12-o-que-o-sgbd-garante/README.md)
