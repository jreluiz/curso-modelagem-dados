# 🗄️ Curso de Modelagem de Dados

> 📋 Pré-requisito: [Curso de Git e GitHub](https://github.com/jreluiz/curso-git-github) concluído.
> 🎒 Não é preciso saber programar — o curso começa na régua e no lápis, não no teclado.

## 🎯 Objetivos do curso

Ao final do curso, você será capaz de:

- Explicar **por que um SGBD existe** e o que a arquitetura em três níveis resolve;
- Ler um **minimundo** e transformá-lo em um **modelo entidade-relacionamento** completo, com entidades, atributos, cardinalidades, entidades fracas e especializações;
- Traduzir o DER para o **modelo relacional** aplicando as regras de mapeamento, com chaves e restrições de integridade explícitas;
- Consultar um esquema em **álgebra relacional** e reconhecer a mesma operação escrita em SQL;
- **Normalizar** um esquema até a 3FN/BCNF e **defender por escrito** cada decomposição;
- Escrever o **DDL e as consultas SQL** que dão vida ao modelo no PostgreSQL, e entender o que o banco faz no disco;
- Trabalhar como um profissional: todo modelo versionado com Git e revisado via GitHub.

## 🗺️ Plano de aulas

### Bloco 1 — Fundamentos de bancos de dados

| Aula | Tema | Conteúdo |
|:---:|------|----------|
| 01 | [Por que bancos de dados existem](bloco-1-fundamentos-bd/aula-01-por-que-bancos-de-dados/README.md) | Os pecados do arquivo solto, o que um SGBD faz, os atores |
| 02 | [Arquitetura e independência de dados](bloco-1-fundamentos-bd/aula-02-arquitetura-independencia/README.md) | Esquema × instância, três níveis, DDL/DML/DCL, catálogo |
| 03 | [Projeto de BD e o minimundo](bloco-1-fundamentos-bd/aula-03-projeto-de-bd-e-minimundo/README.md) | As quatro fases, recortar a realidade, perguntas ao cliente |
| 04 | [MER: entidades e atributos](bloco-1-fundamentos-bd/aula-04-mer-entidades-atributos/README.md) | Tipos de atributo, domínio, chaves, notação de Chen e Mermaid |

### Bloco 2 — Modelagem conceitual

| Aula | Tema | Conteúdo |
|:---:|------|----------|
| 05 | [Relacionamentos e cardinalidade](bloco-2-modelagem-conceitual/aula-05-relacionamentos-cardinalidade/README.md) | Grau, razão 1:1/1:N/N:M, participação, notação (min,max) |
| 06 | [Entidades fracas e chaves](bloco-2-modelagem-conceitual/aula-06-entidades-fracas-chaves/README.md) | Relacionamento identificador, chave parcial, natural × surrogate |
| 07 | [Generalização e agregação](bloco-2-modelagem-conceitual/aula-07-generalizacao-agregacao/README.md) | Super/subclasse, disjunta × sobreposta, categoria, agregação |
| 08 | [Estudo de caso: do minimundo ao DER](bloco-2-modelagem-conceitual/aula-08-estudo-de-caso-der/README.md) | Roteiro em 6 passos e os sete erros clássicos de modelagem |

### Bloco 3 — Modelo relacional e normalização

| Aula | Tema | Conteúdo |
|:---:|------|----------|
| 09 | [O modelo relacional](bloco-3-modelo-relacional/aula-09-modelo-relacional/README.md) | Relação e tupla, chaves, integridade, `NULL`, ações referenciais |
| 10 | [Mapeamento ER → relacional](bloco-3-modelo-relacional/aula-10-mapeamento-er-relacional/README.md) | As sete regras e as quatro opções para especialização |
| 11 | [Álgebra relacional](bloco-3-modelo-relacional/aula-11-algebra-relacional/README.md) | σ, π, ρ, junções, divisão — o que o SGBD realmente executa |
| 12 | [Normalização](bloco-3-modelo-relacional/aula-12-normalizacao/README.md) | Anomalias, dependências funcionais, 1FN–BCNF, decomposição |

### Bloco 4 — SQL e projeto físico

| Aula | Tema | Conteúdo |
|:---:|------|----------|
| 13 | [SQL DDL: criando o esquema](bloco-4-sql-e-projeto-fisico/aula-13-sql-ddl/README.md) | `CREATE TABLE`, tipos, restrições, `ON DELETE`, `ALTER` |
| 14 | [SQL DML e consultas](bloco-4-sql-e-projeto-fisico/aula-14-sql-dml-consultas/README.md) | `INSERT`/`UPDATE`/`DELETE`, junções, `GROUP BY`, subconsultas, `VIEW` |
| 15 | [Projeto físico e transações](bloco-4-sql-e-projeto-fisico/aula-15-projeto-fisico-transacoes/README.md) | Índices e árvore B, `EXPLAIN`, ACID, concorrência, `GRANT` |
| 16 | [Revisão e próximos passos](bloco-4-sql-e-projeto-fisico/aula-16-revisao-proximos-passos/README.md) | Mapa do curso, modelagem dimensional, NoSQL, ORM |

## 📦 Projetos práticos

| Projeto | Quando | Modalidade |
|---------|:---:|------------|
| [Trabalho em dupla — Modelagem via Pull Request](projetos/trabalho-em-dupla.md) | Bloco 3 | Dupla (PRs revisados) |
| [Projeto final — Do minimundo ao banco rodando](projetos/projeto-final.md) | Bloco 4 | Individual |

## 🔁 O ritual Git de toda aula

**Todo laboratório começa e termina com Git.** Sem exceção:

```bash
# ── Início da aula ──
cd exercicios-modelagem-dados
git pull                                 # atualiza (se você usa mais de um PC)

# ── Durante a aula ──
mkdir aula-XX-tema && cd aula-XX-tema     # uma pasta por aula
# ... lê o minimundo, desenha o DER, escreve a justificativa ...
psql -d curso_bd -f ex01.sql              # a partir do Bloco 4
git add .
git commit -m "Resolve exercícios da aula XX"   # commit por exercício concluído

# ── Fim da aula (OBRIGATÓRIO) ──
git push                                  # sem push = sem entrega!
```

> 📏 **Regra do curso (e do mercado):** todo modelo vem acompanhado da **justificativa por escrito**. Um DER sem argumento é um chute bem desenhado — e some na primeira pergunta do cliente.

## 🛠️ Ambiente

Consulte o [guia de preparação do ambiente](recursos/ambiente.md): PostgreSQL, cliente gráfico, o banco `curso_bd` e o seu repositório de exercícios. Até o Bloco 3 você precisa apenas de um editor de texto — o banco entra na Aula 13.

## ⚡ Links rápidos

- 📐 [Notações de DER em 10 minutos](recursos/notacoes-der.md) — Chen, pé-de-galinha e Mermaid lado a lado
- 🧯 [Erros comuns](recursos/erros-comuns.md) — da cardinalidade invertida ao `violates foreign key constraint`
- 🌍 [Catálogo de minimundos](recursos/minimundos.md) — 12 enunciados para praticar
- 🔗 [Links úteis](recursos/links-uteis.md)
- 📚 [Curso de Git e GitHub](https://github.com/jreluiz/curso-git-github) (pré-requisito)

## 📖 Livro-base

GUIMARÃES, Célio Cardoso. **Fundamentos de Bancos de Dados: Modelagem, Projeto e Linguagem SQL**. Campinas: Editora da Unicamp.

As aulas seguem a progressão do livro e marcam com `> 📖` onde aprofundar cada tema. O curso é autocontido — o livro é o passo seguinte, não um pré-requisito.

---

*Este repositório continua evoluindo — modelos e materiais novos são commitados aqui. Primeiro passo de toda sessão de estudo: `git pull`.* 🙂
