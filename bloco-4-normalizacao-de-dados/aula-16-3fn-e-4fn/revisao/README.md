# Aula 16 — Revisão: Múltipla Escolha

> 🎯 8 questões sobre a [Aula 16 — 3FN e 4FN](../README.md). Só uma alternativa está correta em cada uma.

**Sem gabarito, de propósito.** Cada questão termina com a seção da aula onde a resposta está. Responda **tudo primeiro**, sem consultar — só depois volte às seções indicadas e corrija.

As três últimas são marcadas **[ENADE]**: seguem o formato do exame, com cinco alternativas e enunciado mais longo.

---

### Q-A16-01

Ao eliminar uma dependência transitiva, o atributo determinante:

- **a)** permanece na tabela original como chave estrangeira para a tabela nova;
- **b)** é removido da tabela original, junto com o que ele determinava;
- **c)** passa a integrar a chave primária composta da tabela original;
- **d)** é substituído por um identificador numérico gerado pelo SGBD.

↩︎ *Aula 16, seção 1 — Aplicando a 3FN*

---

### Q-A16-02

Uma tabela guarda, para cada palestrante, os eventos em que ele fala **e** as áreas em que atua, sendo as duas coisas independentes entre si. O que acontece com as linhas?

- **a)** elas ficam com valores nulos nas colunas não preenchidas;
- **b)** o banco passa a guardar todas as combinações entre os dois conjuntos;
- **c)** a chave primária deixa de identificar as linhas da tabela;
- **d)** a tabela deixa de estar em 1FN, por conter valores não atômicos.

↩︎ *Aula 16, seção 2 — Uma tabela que multiplica linhas sozinha*

---

### Q-A16-03

O que a **4FN** exige?

- **a)** que nenhum atributo dependa de parte da chave primária composta;
- **b)** que toda decomposição realizada seja verificada quanto à perda;
- **c)** que não haja duas dependências multivaloradas independentes na mesma tabela;
- **d)** que os atributos multivalorados sejam eliminados de todo o esquema.

↩︎ *Aula 16, seção 4 — A 4FN*

---

### Q-A16-04

Na tabela `ALUNO_TELEFONE(matricula, telefone)`, com um único conjunto multivalorado, o que a 4FN recomenda?

- **a)** decompor em duas tabelas, uma para a matrícula e outra para o telefone;
- **b)** transformar os telefones em colunas numeradas, até o máximo previsto;
- **c)** acrescentar um segundo conjunto multivalorado para permitir a decomposição;
- **d)** nada: com um único conjunto, não há independência para separar.

↩︎ *Aula 16, seção 4 — A 4FN*

---

### Q-A16-05

Entre os assuntos que ficaram **fora** deste curso, qual deles é apontado como quase sempre sendo uma agregação disfarçada?

- **a)** a forma normal de Boyce-Codd;
- **b)** o projeto físico com índices;
- **c)** o relacionamento ternário;
- **d)** a álgebra relacional.

↩︎ *Aula 16, seção 6 — O que você aprendeu, e o que ficou de fora*

---

### Q-A16-06

**[ENADE]**

Uma equipe manteve, em uma única tabela, dois registros sobre cada instrutor de uma instituição: as turmas em que ele atua e os idiomas que ele fala. As duas informações não guardam relação entre si.

Um instrutor que atua em quatro turmas e fala três idiomas ocupa doze linhas na tabela. Ao acrescentar um quarto idioma, a equipe precisou inserir quatro novas linhas; como apenas três foram inseridas, a base passou a apresentar combinações incompletas.

Considerando a situação, a solução adequada é:

- **A)** acrescentar uma coluna que indique se a combinação é válida;
- **B)** aplicar a 2FN, separando os atributos que dependem de parte da chave;
- **C)** manter a tabela e criar uma rotina que gere as combinações faltantes;
- **D)** aplicar a 4FN, separando cada conjunto em sua própria tabela;
- **E)** aplicar a 3FN, eliminando a dependência transitiva entre turma e idioma.

↩︎ *Aula 16, seção 4 — A 4FN*

---

### Q-A16-07

**[ENADE]**

Avalie as asserções a seguir e a relação proposta entre elas.

I. Uma tabela que registra, para cada palestrante, os eventos em que ele fala e as áreas em que atua deve ser decomposta em duas.

PORQUE

II. Toda tabela que contenha um atributo multivalorado viola a quarta forma normal.

A respeito dessas asserções, assinale a opção correta.

- **A)** As asserções I e II são proposições verdadeiras, e a II é uma justificativa correta da I;
- **B)** As asserções I e II são proposições verdadeiras, mas a II não é uma justificativa correta da I;
- **C)** A asserção I é uma proposição verdadeira, e a II é uma proposição falsa;
- **D)** A asserção I é uma proposição falsa, e a II é uma proposição verdadeira;
- **E)** As asserções I e II são proposições falsas.

↩︎ *Aula 16, seção 4 — A 4FN*

---

### Q-A16-08

**[ENADE]**

A respeito das formas normais estudadas no curso, avalie as afirmações a seguir.

I. A 3FN resolve, na quase totalidade dos casos reais, as anomalias de inserção, alteração e exclusão.

II. A verificação de perda de informação deve ser feita após cada decomposição, e não apenas ao final do processo.

III. Atingir a forma normal mais alta possível é o objetivo de todo projeto de banco de dados.

É correto apenas o que se afirma em:

- **A)** I;
- **B)** III;
- **C)** I e III;
- **D)** II e III;
- **E)** I e II.

↩︎ *Aula 16, seção 5 — O quadro completo*

---

⬅️ [Voltar à Aula 16](../README.md) | 🏠 [Início](../../../README.md)
