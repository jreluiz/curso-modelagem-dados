---
marp: true
theme: trilha
paginate: true
lang: pt-BR
footer: '🗄️ Curso de Modelagem de Dados · Aula 11'
---

<!-- _class: capa -->

<div class="emoji">🐘</div>

# PostgreSQL na Prática

## Aula 11 · Bloco 3 — O SGBD na Prática

<div class="meta">Criar o banco, andar por dentro dele, escolher os tipos</div>

---

## 🎯 Nesta aula

1. O que você vai **instalar**
2. **Criar** o banco do curso
3. `psql` — os comandos que valem **decorar**
4. Um **cliente gráfico**, se quiser
5. O **catálogo** por dentro
6. Os **tipos** que você vai usar

---

## Duas coisas, e a segunda é opcional

**O servidor PostgreSQL** — o programa que fica rodando e guardando os dados.

**Um cliente** — o programa com que você conversa com o servidor. O `psql` é o do curso.

```bash
psql --version     # psql (PostgreSQL) 15.x  → você está pronto
```

O passo a passo por sistema operacional está no guia de ambiente.

---

<!-- _class: lead -->

## 💡 Servidor e cliente conversam por rede

Mesmo quando estão na mesma máquina.

É por isso que existe uma porta (5432),
um usuário e uma senha
para algo que está no seu próprio computador.

Essa separação é o que permite, amanhã,
o mesmo `psql` conectar num banco
que está em outro continente.

---

## Criar o banco do curso

```bash
createdb curso_bd     # cria
psql -d curso_bd      # entra

psql -d curso_bd -v ON_ERROR_STOP=1 -f 00-primeiro-contato.sql
```

> ⚠️ `-v ON_ERROR_STOP=1` faz o `psql` **parar no primeiro erro**. Sem ele, um script com erro na linha 3 continua rodando as outras 200 em cima de um banco meio construído.

---

<!-- _class: tabela-densa -->

## `psql`: os comandos que valem decorar

| Comando | O que faz |
|---|---|
| `\l` | lista os bancos do servidor |
| `\c curso_bd` | conecta a um banco |
| `\dt` | lista as tabelas do banco atual |
| `\d livro` | mostra a estrutura da tabela |
| `\i arquivo.sql` | executa um script |
| `\x` | saída vertical — salva vidas em tabela larga |
| `\q` | sai |

---

<!-- _class: lead -->

## ⚠️ O prompt virou `curso_bd-#`?

Você esqueceu o ponto e vírgula.

O `psql` está esperando
você terminar a frase.

Digite `;` e Enter.
Para abandonar, `\r`.

---

## O catálogo por dentro: `\d livro`

```
  Column  |          Type          | Nullable |    Default
----------+------------------------+----------+----------------
 tombo    | integer                | not null |
 situacao | character varying(20)  | not null | 'disponivel'
Indexes:
    "livro_pkey" PRIMARY KEY, btree (tombo)
Check constraints:
    "livro_ano_check" CHECK (ano >= 1450 AND ano <= 2100)
Referenced by:
    TABLE "emprestimo_simples" ... FOREIGN KEY (tombo)
```

Chave da Aula 02 · restrições da Aula 04 · FK da Aula 03, vista **do outro lado**.

---

<!-- _class: lead -->

## 💡 `\d` é o comando mais útil do curso

Ele mostra o seu modelo
**como o banco realmente o entendeu**.

Use-o toda vez que uma restrição
não se comportar como você esperava.

Na maioria das vezes, ela não está lá.

---

<!-- _class: tabela-densa -->

## Os tipos que resolvem quase tudo

| Tipo | Para quê | Exemplo |
|---|---|---|
| `INTEGER` | números inteiros | `tombo`, `ano_publicacao` |
| `VARCHAR(n)` | texto com limite | `titulo VARCHAR(120)` |
| `CHAR(n)` | texto de tamanho **fixo** | `matricula CHAR(9)` |
| `DATE` | data sem hora | `data_retirada` |
| `NUMERIC(p,s)` | decimais **exatos** | `valor NUMERIC(6,2)` |
| `BOOLEAN` | verdadeiro ou falso | `ativo` |

---

<!-- _class: lead -->

## ⚠️ Dinheiro nunca é `REAL` nem `FLOAT`

Esses tipos guardam **aproximações**.

Somar mil aproximações produz
centavos que não existem.

Para valor monetário, `NUMERIC(p,s)` —
mais lento, e exato.

Ninguém vai medir a lentidão.
Todo mundo vai medir o centavo.

---

<!-- _class: checkpoint -->

## 🏋️ Exercícios da aula

Na pasta `aula-11/`:

1. **`ex01.md`** — instale, crie o banco e cole `\conninfo` e `\dt`;
2. **`ex02.md`** — leia o `\d` das duas tabelas, citando o trecho que prova cada resposta;
3. **`ex03.md`** — consulte o `information_schema` e ache um tipo que mudou de nome;
4. **`ex04.md`** — atributo · domínio em português · tipo, para **todo** o seu modelo;
5. **Desafio 🌶️ `ex05.md`** — a regra de formação dos nomes automáticos de restrição.

---

<!-- _class: lead -->

## ➡️ Próxima aula

**Aula 12 — O que o SGBD garante**

Transação, ACID,
duas pessoas ao mesmo tempo,
e o backup que ninguém testou.
