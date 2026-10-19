# 🗄️ Curso de Modelagem de Dados

> 📋 Pré-requisito: [Curso de Git e GitHub](https://github.com/jreluiz/curso-git-github) concluído.
> 🎒 Não é preciso saber programar — o curso começa numa planilha que deu errado, não no teclado.

## 🎯 Objetivos do curso

Ao final do curso, você será capaz de:

- Reconhecer a **redundância** num conjunto de dados e nomear as três **anomalias** que ela produz;
- Explicar o que um **banco de dados** e um **SGBD** fazem — e o que eles não fazem por você;
- Situar os **modelos de dados** na ordem em que surgiram e escolher um SGBD com critério;
- Escrever a **política de segurança** de um banco: quem pode ler, alterar e nunca apagar;
- Conduzir um **levantamento de requisitos** e decidir se o banco é **OLTP** ou **OLAP**;
- Desenhar um **DER na notação de Chen** — retângulo, losango e elipse —, incluindo **autorrelacionamento com papéis**, e traduzi-lo em **modelo lógico**;
- Aplicar **especialização, generalização e agregação**, e converter **qualquer DER em esquema de tabelas**;
- **Normalizar** um esquema até a **3FN**, defendendo cada decomposição por escrito;
- Criar no **PostgreSQL** o banco que o modelo descreve, com chaves e integridade, e fazer as **primeiras consultas em SQL**;
- Trabalhar como um profissional: todo modelo versionado com Git e justificado por escrito.

## 🗺️ Plano de aulas

### Bloco 1 — Fundamentos de Bancos de Dados

| Aula | Tema | Conteúdo |
|:---:|------|----------|
| 01 | [A redundância e a resposta do SGBD](bloco-1-fundamentos-de-bancos-de-dados/aula-01-redundancia-e-o-sgbd/README.md) | Redundância, as três anomalias, banco de dados, SGBD, as quatro garantias |
| 02 | [De onde vêm os bancos de dados](bloco-1-fundamentos-de-bancos-de-dados/aula-02-de-onde-vem-os-bancos/README.md) | Arquivos, hierárquico, rede, Codd, NoSQL, principais SGBD, política de segurança |
| 03 | [Os elementos de um banco de dados](bloco-1-fundamentos-de-bancos-de-dados/aula-03-elementos-de-um-banco/README.md) | Tabela, tupla, domínio, entidade, os quatro tipos de atributo, as quatro etapas |
| 04 | [Requisitos, OLTP e OLAP](bloco-1-fundamentos-de-bancos-de-dados/aula-04-requisitos-oltp-e-olap/README.md) | As quatro perguntas, fontes de requisito, OLTP, OLAP, granularidade |

### Bloco 2 — Modelos de Banco de Dados

| Aula | Tema | Conteúdo |
|:---:|------|----------|
| 05 | [Projeto de BD: conceitual, lógico e físico](bloco-2-modelos-de-banco-de-dados/aula-05-projeto-conceitual-logico-fisico/README.md) | Projeto de banco de dados, os três modelos e o que cada um decide |
| 06 | [A notação gráfica e os tipos de entidade](bloco-2-modelos-de-banco-de-dados/aula-06-notacao-e-tipos-de-entidade/README.md) | Formas de Chen, entidade forte e fraca, os três tipos de relacionamento, participação, autorrelacionamento e papel |
| 07 | [Do relacional à integridade referencial](bloco-2-modelos-de-banco-de-dados/aula-07-relacional-e-integridade/README.md) | Relação e tupla, chaves, chave estrangeira, as três integridades, políticas de exclusão |
| 08 | [Agregação e estudo de caso](bloco-2-modelos-de-banco-de-dados/aula-08-agregacao-e-estudo-de-caso/README.md) | Agregação, entidade associativa e o projeto completo da Biblioteca, do minimundo ao esquema |

### Bloco 3 — Do Modelo ao Banco

| Aula | Tema | Conteúdo |
|:---:|------|----------|
| 09 | [Especialização e o esquema completo](bloco-3-do-modelo-ao-banco/aula-09-especializacao-e-o-esquema-completo/README.md) | Especialização e generalização, atributo composto e multivalorado, e a conversão de todo construto do DER em tabelas |
| 10 | [Normalização essencial](bloco-3-do-modelo-ao-banco/aula-10-normalizacao-essencial/README.md) | Dependência funcional, 1FN, 2FN e 3FN num encontro só |
| 11 | [Do esquema ao PostgreSQL](bloco-3-do-modelo-ao-banco/aula-11-do-esquema-ao-postgresql/README.md) | O modelo físico na prática: as tabelas, as chaves e as regras de exclusão escritas em SQL, e o banco recusando o que viola a integridade |
| 12 | [Consultas básicas em SQL](bloco-3-do-modelo-ao-banco/aula-12-consultas-basicas/README.md) | Perguntar ao banco: filtrar, ordenar e juntar tabelas seguindo as chaves estrangeiras |

### 📚 Leituras complementares

Os tópicos da ementa que não têm aula própria, no mesmo formato das aulas, para ler no seu ritmo — [ver o índice](leituras-complementares/README.md).

| Leitura | Conteúdo |
|---|---|
| [Como se conduz uma modelagem](leituras-complementares/como-se-conduz-uma-modelagem/README.md) | As quatro estratégias, descrição em alto nível e expandida, dicionário de dados, registro de decisão |
| [O mesmo caso em duas notações](leituras-complementares/o-mesmo-caso-em-duas-notacoes/README.md) | Classe, associação, multiplicidade, herança em UML e a tabela de conversão a partir do DER |
| [Especialização, generalização e as ferramentas](leituras-complementares/especializacao-e-generalizacao/README.md) | Total × parcial, disjunta × sobreposta, quando não especializar, e o que é uma ferramenta CASE |
| [Ferramentas CASE na prática](leituras-complementares/ferramentas-case-na-pratica/README.md) | Upper e lower CASE, as ferramentas de hoje, o brModelo e a revisão da conversão automática |
| [Por que normalizar](leituras-complementares/por-que-normalizar/README.md) | Conceito, objetivos, o panorama das formas normais e até onde normalizar |
| [Dependência funcional, 1FN e 2FN](leituras-complementares/dependencia-funcional-1fn-2fn/README.md) | Dependência funcional, valor atômico, dependência parcial e a definição da 2FN |
| [Aplicando a 1FN e a 2FN](leituras-complementares/aplicando-1fn-e-2fn/README.md) | A decomposição passo a passo, a conferência sem perda e a definição da 3FN |
| [3FN e 4FN](leituras-complementares/3fn-e-4fn/README.md) | A 3FN aplicada, dependência multivalorada e a 4FN |

## 🔁 O ritual Git de toda aula

**Todo laboratório começa e termina com Git.** Sem exceção:

```bash
# ── Início da aula ──
cd exercicios-modelagem-dados
git pull                                 # atualiza (se você usa mais de um PC)

# ── Durante a aula ──
mkdir aula-XX-tema && cd aula-XX-tema     # uma pasta por aula
# ... lê o enunciado, desenha o diagrama, escreve a justificativa ...
git add .
git commit -m "Resolve exercícios da aula XX"   # commit por exercício concluído

# ── Fim da aula (OBRIGATÓRIO) ──
git push                                  # sem push = sem entrega!
```

> 📏 **Regra do curso (e do mercado):** todo modelo vem acompanhado da **justificativa por escrito**. Um diagrama sem argumento é um chute bem desenhado — e some na primeira pergunta do cliente.

## 🛠️ Ambiente

Consulte o [guia de preparação do ambiente](recursos/ambiente.md). Nos **Blocos 1 e 2 você precisa apenas de um editor de texto e do Git** — os diagramas são escritos em Mermaid, que o GitHub renderiza sozinho. No **Bloco 3**, as Aulas 11 e 12 usam o **PostgreSQL** pelo navegador, no DB Fiddle — também sem instalar nada.

## ⚡ Links rápidos

- 📅 [Cronograma da turma 2026/2](CRONOGRAMA.md) — as datas dos encontros, se você está cursando isto numa turma
- 📐 [Desenhando o DER na notação de Chen](recursos/notacoes-der.md) — a notação do curso, com a tabela de formas, o autorrelacionamento e as quatro limitações do Mermaid
- 🧯 [Erros comuns](recursos/erros-comuns.md) — vinte e dois erros de modelagem, abstração e normalização, com sintoma, causa e cura
- 🌍 [Catálogo de minimundos](recursos/minimundos.md) — 12 enunciados para os exercícios autorais
- 📚 [Leituras complementares](leituras-complementares/README.md) — os tópicos da ementa sem aula própria, para ler no seu ritmo
- 🔗 [Links úteis](recursos/links-uteis.md)
- 📚 [Curso de Git e GitHub](https://github.com/jreluiz/curso-git-github) (pré-requisito)

## 📚 Bibliografia

**Livro-base:**

- HEUSER, Carlos Alberto. **Projeto de Banco de Dados**. 6. ed. Porto Alegre: Bookman, 2009. (Série Livros Didáticos Informática UFRGS, v. 4)

**Bibliografia de apoio:**

| Obra | Onde ela ajuda mais |
|---|---|
| GUIMARÃES, Célio Cardoso. **Fundamentos de Bancos de Dados: Modelagem, Projeto e Linguagem SQL**. Campinas: Editora da Unicamp. | Bloco 1 — a motivação histórica e a evolução dos modelos; e a linguagem SQL das Aulas 11 e 12 |
| ELMASRI, Ramez; NAVATHE, Shamkant B. **Sistemas de Banco de Dados**. 7. ed. São Paulo: Pearson, 2018. | Aula 09 e as leituras de abordagem entidade-relacionamento e UML |
| MACHADO, Felipe Nery Rodrigues. **Banco de Dados: Projeto e Implementação**. 3. ed. São Paulo: Érica. | Bloco 1 (OLTP e OLAP), Aula 11 (a implementação) e a leitura de ferramentas CASE |
| DATE, C. J. **Introdução a Sistemas de Bancos de Dados**. 8. ed. Rio de Janeiro: Elsevier, 2004. | Aula 10 e as leituras de normalização — dependência funcional e formas normais com rigor |
| SILBERSCHATZ, A.; KORTH, H. F.; SUDARSHAN, S. **Sistema de Banco de Dados**. 7. ed. Rio de Janeiro: LTC, 2020. | apoio geral, em todos os blocos |
| FOWLER, Martin. **UML Essencial**. 3. ed. Porto Alegre: Bookman, 2005. | a leitura *O mesmo caso em duas notações* — diagrama de classes e herança |
| CHEN, Peter Pin-Shan. *The Entity-Relationship Model — Toward a Unified View of Data*. ACM TODS, 1976. | a notação do curso, no artigo original |
| CODD, E. F. *A Relational Model of Data for Large Shared Data Banks*. CACM, 1970. | Bloco 1 — o artigo que criou o modelo relacional |

As aulas marcam com `> 📖` onde aprofundar cada tema. **O curso é autocontido** — os livros são o passo seguinte, não um pré-requisito.

Alguns assuntos ficaram **deliberadamente de fora**: o SQL além do básico das Aulas 11 e 12 (agrupamento, subconsulta, transação), álgebra relacional, BCNF, o projeto físico a fundo (índices e desempenho) e o relacionamento ternário. A leitura [3FN e 4FN](leituras-complementares/3fn-e-4fn/README.md) e os [links úteis](recursos/links-uteis.md) dizem por onde continuar.

---

*Este repositório continua evoluindo — modelos e materiais novos são commitados aqui. Primeiro passo de toda sessão de estudo: `git pull`.* 🙂
