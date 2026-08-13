# 🔗 Links Úteis — Modelagem de Dados

> A **bibliografia** do curso está no [README](../README.md#-bibliografia), com o livro-base e as sete obras de apoio. Esta página é o resto: o que está **online**, e serve para consultar durante a aula.

## 📐 Desenhar o diagrama

- [Mermaid — `flowchart`](https://mermaid.js.org/syntax/flowchart.html) — **a sintaxe que este curso usa.** O DER em notação de Chen é montado com as formas do `flowchart`: `[retângulo]`, `{losango}`, `((elipse))`;
- [mermaid.live](https://mermaid.live) — editor online, mostra o erro de sintaxe na hora. Depure aqui antes de commitar;
- [Notação de Chen no Mermaid](notacoes-der.md) — o guia do curso: a tabela de formas, as três coisas que o Mermaid não desenha direito e a meia página de conversão para o pé-de-galinha.

> ⚠️ **Não use a página `entityRelationshipDiagram` do Mermaid.** Ela documenta o `erDiagram`, que desenha em **pé-de-galinha** e exige o tipo de cada coluna — ou seja, um modelo **lógico**. O curso desenha o **conceitual**, em Chen, e o `erDiagram` não tem como representar atributo em relacionamento, especialização nem agregação: os atributos moram dentro da caixa da entidade, e não existe losango onde pendurar nada.

## 🧰 Ferramenta CASE (entra no Bloco 3)

Nos **Blocos 1 e 2 você não precisa instalar nada** além de um editor e do Git.

- [brModelo](https://www.sis4.com/brModelo/) — a ferramenta do curso: brasileira, gratuita, em notação de Chen, e converte o conceitual em lógico num clique. Exige Java instalado;
- [draw.io](https://app.diagrams.net/) — alternativa que roda no navegador, sem instalar. Desenha qualquer notação, mas **não converte nem valida nada**: é papel quadriculado com ímãs;
- [Preparação do ambiente](ambiente.md) — o passo a passo, com o teste do Java e a checagem da convenção de cardinalidade da ferramenta.

## 🧠 Aprofundamento — o que ficou de fora

Nada daqui é cobrado. É a lista de para onde ir depois, na ordem em que costuma fazer diferença. A [Aula 16](../bloco-4-normalizacao-de-dados/aula-16-3fn-e-4fn/README.md#6-o-que-você-aprendeu-e-o-que-ficou-de-fora) diz por quê.

- **SQL** — o curso para no modelo lógico e não escreve uma linha de comando. Qualquer curso de SQL serve agora, e você chega nele com a vantagem que importa: já sabe **o que** pedir ao banco. O [SQL Murder Mystery](https://mystery.knightlab.com/) é a melhor primeira hora que existe, e o [SQLZoo](https://sqlzoo.net/) leva do zero ao agrupamento;
- **Formas normais além da 4FN** — BCNF e 5FN, no capítulo de normalização do Elmasri & Navathe. São casos raros, e a 4FN já é o limite do que aparece em projeto real;
- [Relational Algebra Calculator](https://dbis-uibk.github.io/relax/) — a **álgebra relacional**: escreva σ, π e ⋈ e veja o resultado sobre dados de verdade. É a teoria por trás do que um banco faz quando junta duas tabelas;
- [Use The Index, Luke!](https://use-the-index-luke.com/) — índices e desempenho sem matemática pesada. É o **projeto físico**, a terceira etapa que a Aula 05 nomeia e o curso não percorre. Está em inglês, com traduções para espanhol, alemão, francês e japonês;
- [CHEN, P. *The Entity-Relationship Model* (1976)](https://archive.org/details/entityrelationshx00chen) — o artigo que criou os losangos e retângulos. Vale a leitura pelo que ele **argumenta**, não pela notação. *(Cópia livre do Internet Archive; o original saiu na ACM TODS 1/1, atrás de assinatura.)*;
- [CODD, E. F. *A Relational Model of Data for Large Shared Data Banks* (1970)](https://www.seas.upenn.edu/~zives/03f/cis550/codd.pdf) — o artigo que criou o modelo relacional, seis anos antes.

## 🎓 Materiais do curso

- [Curso de Git e GitHub](https://github.com/jreluiz/curso-git-github) — o pré-requisito, e o único;
- [Curso de POO com Java](https://github.com/jreluiz/curso-java-poo) — modelar em classes. Os dois mundos se encontram na [Aula 10](../bloco-3-abordagem-entidade-relacionamento/aula-10-o-mesmo-caso-em-duas-notacoes/README.md), que desenha o mesmo caso em Chen e em UML;
- [Catálogo de minimundos](minimundos.md) · [Erros comuns](erros-comuns.md) · [Notações de DER](notacoes-der.md) · [Preparação do ambiente](ambiente.md).

---

🏠 [Voltar ao início](../README.md)
