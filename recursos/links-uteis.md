# 🔗 Links Úteis — Modelagem de Dados

## 📖 Referência (para consultar, não para ler de capa a capa)

- **GUIMARÃES, Célio Cardoso. *Fundamentos de Bancos de Dados: Modelagem, Projeto e Linguagem SQL*. Campinas: Editora da Unicamp** — o livro-base do curso, escrito em português e com a progressão que as 16 aulas seguem;
- [Documentação oficial do PostgreSQL](https://www.postgresql.org/docs/current/) — **a** fonte sobre tipos, restrições e SQL. O tutorial dos primeiros capítulos é surpreendentemente bom;
- [PostgreSQL — tipos de dados](https://www.postgresql.org/docs/current/datatype.html) — a página que você vai abrir toda vez que escrever um `CREATE TABLE`;
- [Use The Index, Luke!](https://use-the-index-luke.com/pt/) — índices e desempenho explicados sem matemática pesada, com versão em português;
- [DevDocs — PostgreSQL](https://devdocs.io/postgresql/) — a mesma documentação, com busca muito mais rápida.

## 📐 Diagramas e notações

- [Mermaid — Entity Relationship Diagram](https://mermaid.js.org/syntax/entityRelationshipDiagram.html) — a sintaxe que usamos no repositório; a página tem a tabela de cardinalidades;
- [mermaid.live](https://mermaid.live) — editor online, mostra o erro de sintaxe na hora. Depure aqui antes de commitar;
- [brModelo](https://www.sis4.com/brModelo/) — ferramenta brasileira e gratuita em **notação de Chen**, a do livro;
- [dbdiagram.io](https://dbdiagram.io/) — desenha rápido em pé-de-galinha e exporta o SQL;
- [Guia rápido do curso](notacoes-der.md) — Chen, (min,max) e Mermaid lado a lado.

## 🎮 Prática interativa

- [SQLZoo](https://sqlzoo.net/) — exercícios de SQL do zero ao `GROUP BY`, direto no navegador;
- [SQL Murder Mystery](https://mystery.knightlab.com/) — um crime resolvido com consultas; a melhor primeira hora de SQL que existe;
- [DB Fiddle](https://www.db-fiddle.com/) — cria um PostgreSQL temporário no navegador e devolve um link. Ideal para pedir ajuda: mande o link, não o print;
- [pgexercises.com](https://pgexercises.com/) — exercícios em PostgreSQL com solução comentada, organizados por dificuldade;
- [Relational Algebra Calculator](https://dbis-uibk.github.io/relax/) — escreva σ, π e ⋈ e veja o resultado sobre dados de verdade. Companhia obrigatória da Aula 11.

## 🧠 Aprofundamento

- [Normalização — série de artigos em pt-BR (DevMedia)](https://www.devmedia.com.br/normalizacao-de-dados/1930) — revisão das formas normais com exemplos;
- [Codd, E. F. *A Relational Model of Data for Large Shared Data Banks* (1970)](https://dl.acm.org/doi/10.1145/362384.362685) — o artigo que fundou tudo isto. Sete páginas, e mais legível do que a fama sugere;
- [Chen, P. *The Entity-Relationship Model* (1976)](https://dl.acm.org/doi/10.1145/320434.320440) — a origem da notação de losangos e retângulos;
- [Modelagem dimensional — Kimball Group](https://www.kimballgroup.com/data-warehouse-business-intelligence-resources/kimball-techniques/dimensional-modeling-techniques/) — o passo seguinte, quando o assunto virar *data warehouse* (panorama na Aula 16).

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
