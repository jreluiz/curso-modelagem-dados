# 🗄️ Curso de Modelagem de Dados

> 📋 Pré-requisito: [Curso de Git e GitHub](https://github.com/jreluiz/curso-git-github) concluído.
> 🎒 Não é preciso saber programar — o curso começa numa planilha que deu errado, não no teclado.

## 🎯 Objetivos do curso

Ao final do curso, você será capaz de:

- Separar uma planilha em **tabelas** e explicar as três anomalias que isso resolve;
- Escolher **chaves** com critério e ligar tabelas por **chave estrangeira**, sabendo de que lado ela mora;
- Declarar as **restrições de integridade** que fazem o banco recusar dado errado;
- Ler um **minimundo** em português e transformá-lo num **DER** em Mermaid, com as perguntas ao cliente escritas;
- **Mapear** o diagrama para um esquema relacional e **normalizá-lo** até a 3FN, defendendo cada decisão;
- Instalar o **PostgreSQL**, criar o banco e entender o que um SGBD garante que uma planilha não garante;
- Escrever o **DDL** que dá vida ao modelo e as **consultas** que respondem perguntas de verdade;
- Trabalhar como um profissional: todo modelo versionado com Git e revisado via GitHub.

## 🗺️ Plano de aulas

### Bloco 1 — O modelo relacional: tabelas, chaves e relacionamentos

| Aula | Tema | Conteúdo |
|:---:|------|----------|
| 01 | [Da planilha à tabela](bloco-1-modelo-relacional/aula-01-da-planilha-a-tabela/README.md) | As três anomalias, relação e tupla, grau e cardinalidade, esquema |
| 02 | [Chaves: como identificar uma linha](bloco-1-modelo-relacional/aula-02-chaves/README.md) | Superchave, candidata, primária, composta, natural × artificial |
| 03 | [Relacionamentos e chave estrangeira](bloco-1-modelo-relacional/aula-03-relacionamentos-chave-estrangeira/README.md) | Ligação por valor, 1:1, 1:N, N:M, tabela associativa, autorrelacionamento |
| 04 | [Integridade e o valor nulo](bloco-1-modelo-relacional/aula-04-integridade-e-nulo/README.md) | As quatro restrições, os três sentidos do nulo, ações referenciais |

### Bloco 2 — Do minimundo ao esquema relacional

| Aula | Tema | Conteúdo |
|:---:|------|----------|
| 05 | [O minimundo e o DER](bloco-2-do-minimundo-ao-esquema/aula-05-minimundo-e-der/README.md) | Recortar a realidade, entidade × atributo, Mermaid `erDiagram` |
| 06 | [Do DER às tabelas](bloco-2-do-minimundo-ao-esquema/aula-06-do-der-as-tabelas/README.md) | As cinco regras de mapeamento e o que a tradução perde |
| 07 | [Normalização até a 3FN](bloco-2-do-minimundo-ao-esquema/aula-07-normalizacao/README.md) | Dependência funcional sem fórmula, 1FN, 2FN, 3FN, quando não normalizar |
| 08 | [Estudo de caso](bloco-2-do-minimundo-ao-esquema/aula-08-estudo-de-caso/README.md) | O roteiro em 6 passos, os cinco erros clássicos, validar com o cliente |

### Bloco 3 — O SGBD na prática

| Aula | Tema | Conteúdo |
|:---:|------|----------|
| 09 | [Por que um SGBD existe](bloco-3-o-sgbd-na-pratica/aula-09-por-que-um-sgbd-existe/README.md) | Os quatro pecados do arquivo solto, o que o SGBD garante, os atores |
| 10 | [Arquitetura e independência de dados](bloco-3-o-sgbd-na-pratica/aula-10-arquitetura-independencia/README.md) | Esquema × instância, três níveis, DDL/DML/DCL, catálogo |
| 11 | [PostgreSQL na prática](bloco-3-o-sgbd-na-pratica/aula-11-postgresql-na-pratica/README.md) | Instalar, `psql`, criar o banco, ler o catálogo, os tipos de dados |
| 12 | [O que o SGBD garante](bloco-3-o-sgbd-na-pratica/aula-12-o-que-o-sgbd-garante/README.md) | Transação, `COMMIT`/`ROLLBACK`, ACID, concorrência, permissões, backup |

### Bloco 4 — SQL básico

| Aula | Tema | Conteúdo |
|:---:|------|----------|
| 13 | [SQL DDL: criando o esquema](bloco-4-sql-basico/aula-13-sql-ddl/README.md) | `CREATE TABLE`, restrições nomeadas, `ON DELETE`, `ALTER`, os erros |
| 14 | [SQL DML e o `SELECT` simples](bloco-4-sql-basico/aula-14-sql-dml-e-select/README.md) | `INSERT`/`UPDATE`/`DELETE`, `WHERE`, `ORDER BY`, `IS NULL`, `LIKE` |
| 15 | [Junções e agregação](bloco-4-sql-basico/aula-15-juncoes-e-agregacao/README.md) | `JOIN`, `LEFT JOIN`, `GROUP BY`, `HAVING`, subconsulta, `VIEW` |
| 16 | [Revisão e próximos passos](bloco-4-sql-basico/aula-16-revisao-proximos-passos/README.md) | O mapa do curso, o que ficou de fora, NoSQL, ORM |

## 📦 Projetos práticos

| Projeto | Quando | Modalidade |
|---------|:---:|------------|
| [Trabalho em dupla — Modelagem via Pull Request](projetos/trabalho-em-dupla.md) | Após a Aula 08 | Dupla (PRs revisados) |
| [Projeto final — Do minimundo ao banco rodando](projetos/projeto-final.md) | Após a Aula 15 | Individual |

## 🔁 O ritual Git de toda aula

**Todo laboratório começa e termina com Git.** Sem exceção:

```bash
# ── Início da aula ──
cd exercicios-modelagem-dados
git pull                                 # atualiza (se você usa mais de um PC)

# ── Durante a aula ──
mkdir aula-XX-tema && cd aula-XX-tema     # uma pasta por aula
# ... lê o minimundo, desenha o esquema, escreve a justificativa ...
psql -d curso_bd -f ex01.sql              # a partir da Aula 11
git add .
git commit -m "Resolve exercícios da aula XX"   # commit por exercício concluído

# ── Fim da aula (OBRIGATÓRIO) ──
git push                                  # sem push = sem entrega!
```

> 📏 **Regra do curso (e do mercado):** todo modelo vem acompanhado da **justificativa por escrito**. Um diagrama sem argumento é um chute bem desenhado — e some na primeira pergunta do cliente.

## 🛠️ Ambiente

Consulte o [guia de preparação do ambiente](recursos/ambiente.md): PostgreSQL, cliente gráfico, o banco `curso_bd` e o seu repositório de exercícios. Nos Blocos 1 e 2 você precisa apenas de um editor de texto — **o banco entra na Aula 11**.

## ⚡ Links rápidos

- 📅 [Cronograma da turma 2026/2](CRONOGRAMA.md) — as datas dos encontros, se você está cursando isto numa disciplina
- 📐 [Desenhando o DER em Mermaid](recursos/notacoes-der.md) — a notação do curso, e meia página de Chen para ler o livro
- 🧯 [Erros comuns](recursos/erros-comuns.md) — da FK do lado errado ao `violates foreign key constraint`
- 🌍 [Catálogo de minimundos](recursos/minimundos.md) — 12 enunciados para praticar
- 🔗 [Links úteis](recursos/links-uteis.md)
- 📚 [Curso de Git e GitHub](https://github.com/jreluiz/curso-git-github) (pré-requisito)

## 📖 Livro-base

GUIMARÃES, Célio Cardoso. **Fundamentos de Bancos de Dados: Modelagem, Projeto e Linguagem SQL**. Campinas: Editora da Unicamp.

As aulas marcam com `> 📖` onde aprofundar cada tema. O curso é autocontido — o livro é o passo seguinte, não um pré-requisito. Alguns assuntos ficaram **deliberadamente de fora** (álgebra relacional, BCNF, projeto físico); a [Aula 16](bloco-4-sql-basico/aula-16-revisao-proximos-passos/README.md) diz quais são e por onde continuar.

---

*Este repositório continua evoluindo — modelos e materiais novos são commitados aqui. Primeiro passo de toda sessão de estudo: `git pull`.* 🙂
