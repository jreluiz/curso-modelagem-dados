# 🔗 Links Úteis — Modelagem de Dados

## 📖 Referência (para consultar, não para ler de capa a capa)

- **GUIMARÃES, Célio Cardoso. *Fundamentos de Bancos de Dados: Modelagem, Projeto e Linguagem SQL*. Campinas: Editora da Unicamp** — o livro-base do curso, escrito em português e com a progressão que as 16 aulas seguem;
- [Documentação oficial do PostgreSQL](https://www.postgresql.org/docs/current/) — **a** fonte sobre tipos, restrições e SQL. O tutorial dos primeiros capítulos é surpreendentemente bom;
- [PostgreSQL — tipos de dados](https://www.postgresql.org/docs/current/datatype.html) — a página que você vai abrir toda vez que escrever um `CREATE TABLE`;
- [DevDocs — PostgreSQL](https://devdocs.io/postgresql/) — a mesma documentação, com busca muito mais rápida.

## 📐 Diagramas e notações

- [Mermaid — Entity Relationship Diagram](https://mermaid.js.org/syntax/entityRelationshipDiagram.html) — a sintaxe que usamos no repositório; a página tem a tabela de cardinalidades;
- [mermaid.live](https://mermaid.live) — editor online, mostra o erro de sintaxe na hora. Depure aqui antes de commitar;
- [dbdiagram.io](https://dbdiagram.io/) — desenha rápido em pé-de-galinha e exporta o SQL;
- [brModelo](https://www.sis4.com/brModelo/) — ferramenta brasileira e gratuita em **notação de Chen**, útil para acompanhar os diagramas do livro;
- [Guia rápido do curso](notacoes-der.md) — Mermaid do zero, mais a meia página de Chen para ler o livro.

## 🎮 Prática interativa

- [SQLZoo](https://sqlzoo.net/) — exercícios de SQL do zero ao `GROUP BY`, direto no navegador;
- [SQL Murder Mystery](https://mystery.knightlab.com/) — um crime resolvido com consultas; a melhor primeira hora de SQL que existe;
- [DB Fiddle](https://www.db-fiddle.com/) — cria um PostgreSQL temporário no navegador e devolve um link. Ideal para pedir ajuda: mande o link, não o print;
- [pgexercises.com](https://pgexercises.com/) — exercícios em PostgreSQL com solução comentada, organizados por dificuldade.

## 🧠 Aprofundamento — o que ficou de fora deste curso

Nada daqui é cobrado. É a lista de para onde ir depois, na ordem em que costuma fazer diferença:

- [Normalização — série de artigos em pt-BR (DevMedia)](https://www.devmedia.com.br/normalizacao-de-dados/1930) — as formas normais além da 3FN, com exemplos;
- [Use The Index, Luke!](https://use-the-index-luke.com/) — índices e desempenho explicados sem matemática pesada. Está em inglês, com traduções para espanhol, alemão, francês e japonês. O assunto do "projeto físico", que este curso só menciona;
- [Relational Algebra Calculator](https://dbis-uibk.github.io/relax/) — escreva σ, π e ⋈ e veja o resultado sobre dados de verdade. É a teoria por trás do `JOIN` da Aula 15;
- [Chen, P. *The Entity-Relationship Model* (1976)](https://dl.acm.org/doi/10.1145/320434.320440) — a origem da notação de losangos e retângulos que o livro-base usa.

## 🧰 Ferramentas

- [PostgreSQL — download](https://www.postgresql.org/download/) — instalador para os três sistemas;
- [DBeaver Community](https://dbeaver.io/) — cliente gráfico multi-banco, gera diagrama a partir do banco existente;
- [pgAdmin 4](https://www.pgadmin.org/) — cliente oficial do PostgreSQL;
- [Guia de preparação do ambiente](ambiente.md) — o passo a passo do curso.

## 🎓 Materiais do curso

- [Curso de Git e GitHub](https://github.com/jreluiz/curso-git-github) (pré-requisito);
- [Curso de POO com Java](https://github.com/jreluiz/curso-java-poo) — modelar em classes; o encontro dos dois mundos está na Aula 16;
- [Catálogo de minimundos](minimundos.md) · [Erros comuns](erros-comuns.md) · [Notações de DER](notacoes-der.md) · [Preparação do ambiente](ambiente.md).

---

🏠 [Voltar ao início](../README.md)
