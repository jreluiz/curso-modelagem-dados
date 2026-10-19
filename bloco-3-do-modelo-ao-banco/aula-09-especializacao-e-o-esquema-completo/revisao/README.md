# Aula 09 — Revisão: Múltipla Escolha

> 🎯 8 questões sobre a [Aula 09 — Especialização e o Esquema Completo](../README.md). Só uma alternativa está correta em cada uma.

**Sem gabarito, de propósito.** Cada questão termina com a seção da aula onde a resposta está. Responda **tudo primeiro**, sem consultar — só depois volte às seções indicadas e corrija.

As três últimas são marcadas **[ENADE]**: trazem um **texto-base** com uma situação concreta, seguido do comando. São mais longas de ler e cobram interpretação, não memória — as alternativas continuam simples, como nas demais.

---

### Q-A09-01

Segundo a aula, a **generalização** é:

- **a)** dividir uma entidade em subclasses que herdam os atributos dela;
- **b)** reunir numa superclasse o que várias entidades já existentes têm em comum;
- **c)** transformar um relacionamento N:M numa entidade com chave própria;
- **d)** agrupar numa tabela as colunas que se repetem em várias tabelas do esquema lógico.

↩︎ *Aula 09, seção 1 — A entidade que não cabe em si mesma*

---

### Q-A09-02

Numa faculdade, todo funcionário é professor ou técnico-administrativo, e ninguém ocupa os dois cargos ao mesmo tempo. A especialização de `FUNCIONARIO` em `PROFESSOR` e `TECNICO` é:

- **a)** parcial e disjunta;
- **b)** parcial e sobreposta;
- **c)** total e sobreposta;
- **d)** total e disjunta.

↩︎ *Aula 09, seção 2 — As duas perguntas que toda especialização responde*

---

### Q-A09-03

Um analista propôs especializar `EXEMPLAR` em `EXEMPLAR_DISPONIVEL` e `EXEMPLAR_EMPRESTADO`. Segundo a aula, a proposta:

- **a)** não se justifica, porque a diferença muda com o tempo e não traz atributo próprio — é um atributo de situação;
- **b)** se justifica, porque as duas subclasses têm tratamentos diferentes no balcão de empréstimo;
- **c)** se justifica, desde que a especialização seja marcada como total e disjunta;
- **d)** não se justifica, porque especialização só se aplica a entidades que representam pessoas.

↩︎ *Aula 09, seção 3 — Quando não especializar*

---

### Q-A09-04

No esquema lógico, o atributo multivalorado `telefones` de uma editora deve ser convertido em:

- **a)** três colunas, `telefone1`, `telefone2` e `telefone3`, na tabela da editora;
- **b)** uma única coluna de texto, com os telefones separados por vírgula;
- **c)** uma tabela nova, com a chave da editora e o telefone, que juntos formam a chave primária;
- **d)** uma chave estrangeira na tabela da editora, apontando para uma tabela de telefones.

↩︎ *Aula 09, seção 4 — Atributo composto e multivalorado: o que a Aula 07 não converteu*

---

### Q-A09-05

Na estratégia de conversão que cria uma tabela para a superclasse e uma tabela para cada subclasse, a chave primária de cada subclasse:

- **a)** é também chave estrangeira para a tabela da superclasse;
- **b)** é gerada de forma independente, sem relação com a superclasse;
- **c)** é formada pela chave da superclasse somada a um número sequencial;
- **d)** é diferente em cada subclasse, para que a mesma ocorrência não apareça em duas delas.

↩︎ *Aula 09, seção 5 — A especialização vira tabela*

---

### Q-A09-06

**[ENADE]**

Uma biblioteca passou a registrar, além de livros, periódicos e mídias. Todo item do acervo tem código de tombo, título e ano; livros têm também ISBN e edição; periódicos, ISSN e periodicidade; mídias, tipo e duração. Todo item é exatamente um desses três tipos, e os empréstimos valem para qualquer item.

Na conversão, o analista criou uma tabela única `ITEM`, com as colunas de todos os tipos e mais uma coluna `tipo`. Em pouco tempo, cada linha tinha dois terços das colunas vazias, e um livro apareceu cadastrado com a duração preenchida.

Considerando a situação apresentada, a conversão mais adequada é:

- **a)** manter a tabela única e acrescentar uma coluna de tipo para cada combinação possível de tipos;
- **b)** criar só as tabelas `LIVRO`, `PERIODICO` e `MIDIA`, cada uma com uma chave estrangeira própria no empréstimo;
- **c)** criar a tabela `ITEM` com os atributos comuns e uma tabela para cada tipo, cuja chave primária também aponta para `ITEM`;
- **d)** transformar o tipo do item num atributo multivalorado, convertido em tabela própria.

↩︎ *Aula 09, seção 5 — A especialização vira tabela*

---

### Q-A09-07

**[ENADE]**

Ao converter o cadastro de funcionários de uma biblioteca, o analista criou a tabela `FUNCIONARIO(matricula, nome, endereco, telefone1, telefone2, idioma1, idioma2)`, com o endereço gravado numa coluna só, como texto livre.

Três meses depois, a biblioteca não conseguia listar os funcionários de um bairro, um funcionário com três telefones teve um deles descartado, e procurar quem fala espanhol exigia olhar em duas colunas.

Considerando a situação apresentada, a correção adequada é:

- **a)** aumentar para cinco o número de colunas de telefone e de idioma, cobrindo os casos raros;
- **b)** transformar o endereço numa tabela própria, ligada ao funcionário, e manter as colunas numeradas;
- **c)** juntar telefones e idiomas numa só coluna de texto, separados por vírgula, para facilitar a busca;
- **d)** dividir o endereço em uma coluna por parte e converter telefones e idiomas em uma tabela própria cada um.

↩︎ *Aula 09, seção 4 — Atributo composto e multivalorado: o que a Aula 07 não converteu*

---

### Q-A09-08

**[ENADE]**

Nos eventos de uma biblioteca, toda pessoa cadastrada tem CPF e nome. Palestrantes têm também um minicurrículo, e participantes, um e-mail. Uma pessoa pode ser palestrante e participante ao mesmo tempo, e os organizadores não são nenhuma das duas coisas.

O analista converteu a especialização criando só as tabelas `PALESTRANTE(cpf, nome, minicurriculo)` e `PARTICIPANTE(cpf, nome, email)`. Os organizadores ficaram sem cadastro, e quem é as duas coisas teve o nome gravado duas vezes — numa correção, ele foi alterado em apenas uma das tabelas.

Considerando a situação apresentada, a causa dos problemas é:

- **a)** a especialização deveria ter sido desenhada como total e disjunta, que é o caso de qualquer cadastro de pessoas;
- **b)** a estratégia de criar só as subclasses exige especialização total e disjunta, e esta é parcial e sobreposta;
- **c)** a chave primária das duas tabelas deveria ser um código gerado pelo sistema, e não o CPF;
- **d)** o nome deveria ter sido tratado como atributo multivalorado, já que aparece em duas tabelas.

↩︎ *Aula 09, seção 5 — A especialização vira tabela*

---

⬅️ [Voltar à Aula 09](../README.md) | 🏠 [Início](../../../README.md)
