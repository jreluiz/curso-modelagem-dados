# Aula 15 — Revisão: Múltipla Escolha

> 🎯 8 questões sobre a [Aula 15 — Aplicando a 1FN e a 2FN](../README.md). Só uma alternativa está correta em cada uma.

**Sem gabarito, de propósito.** Cada questão termina com a seção da aula onde a resposta está. Responda **tudo primeiro**, sem consultar — só depois volte às seções indicadas e corrija.

As três últimas são marcadas **[ENADE]**: seguem o formato do exame, com cinco alternativas e enunciado mais longo.

---

### Q-A15-01

Ao levar uma coluna que guarda uma lista para a 1FN, o que se faz?

- **a)** cria-se uma coluna numerada para cada valor possível da lista;
- **b)** mantém-se a lista e declara-se a coluna como multivalorada;
- **c)** apaga-se a coluna, por não ser possível representá-la em 1FN;
- **d)** cria-se uma tabela própria, com um valor por linha.

↩︎ *Aula 15, seção 2 — Passo 1 — a 1FN*

---

### Q-A15-02

No procedimento de eliminação de uma dependência parcial, o que acontece com o **determinante** na tabela original?

- **a)** é removido, pois passou a existir na tabela nova;
- **b)** é substituído por uma coluna artificial gerada automaticamente;
- **c)** permanece, funcionando como chave estrangeira para a tabela nova;
- **d)** é duplicado, ficando como chave primária nas duas tabelas.

↩︎ *Aula 15, seção 3 — Passo 2 — a 2FN*

---

### Q-A15-03

Qual pergunta verifica, no nível deste curso, se uma decomposição foi **sem perda**?

- **a)** as duas tabelas resultantes têm o mesmo número de linhas?
- **b)** a coluna pela qual se separou é chave em pelo menos uma das tabelas resultantes?
- **c)** a tabela original tinha chave composta antes da decomposição?
- **d)** o número de tabelas do esquema aumentou depois da decomposição?

↩︎ *Aula 15, seção 4 — A conferência: não perder informação*

---

### Q-A15-04

Em `EVENTO(cod_ev, titulo, sala, capacidade_sala)`, com chave `cod_ev`, a capacidade se repete a cada evento realizado na mesma sala. Esse problema é uma dependência:

- **a)** transitiva, porque `capacidade_sala` depende de `sala`, que depende da chave;
- **b)** parcial, porque `capacidade_sala` depende de apenas parte da chave;
- **c)** multivalorada, porque uma sala comporta vários eventos diferentes;
- **d)** inexistente, porque a repetição de valores não caracteriza problema.

↩︎ *Aula 15, seção 5 — Uma dependência que não é parcial — e ainda incomoda*

---

### Q-A15-05

O que distingue a **2FN** da **3FN**?

- **a)** a 2FN trata de valores atômicos e a 3FN, de chaves compostas;
- **b)** na 2FN o atributo depende de parte da chave; na 3FN, de outro atributo não-chave;
- **c)** a 2FN se aplica a qualquer chave e a 3FN, apenas a chaves simples;
- **d)** a 3FN elimina dependências multivaloradas independentes na mesma tabela.

↩︎ *Aula 15, seção 6 — A 3FN*

---

### Q-A15-06

**[ENADE]**

Um analista decompôs a tabela `ALUNO(matricula, nome, curso)` em duas: `ALUNO(matricula, nome)` e `CURSO(curso)`.

Ao tentar reconstruir a informação original, verificou que era possível saber quais cursos existem e quais alunos estão cadastrados, mas não era mais possível saber **em qual curso cada aluno está**.

Considerando os critérios de decomposição, a avaliação correta é:

- **A)** a decomposição está correta, pois ambas as tabelas atendem à 3FN;
- **B)** a decomposição está correta, e a informação perdida pode ser recuperada pela ordem das linhas;
- **C)** a decomposição está incorreta, pois toda tabela precisa manter no mínimo três colunas;
- **D)** a decomposição está incorreta, pois `curso` deveria ter permanecido como chave primária de `ALUNO`;
- **E)** a decomposição está incorreta, pois houve perda de informação: a ligação entre aluno e curso desapareceu.

↩︎ *Aula 15, seção 4 — A conferência: não perder informação*

---

### Q-A15-07

**[ENADE]**

Avalie as asserções a seguir e a relação proposta entre elas.

I. Ao eliminar uma dependência parcial, o atributo determinante permanece na tabela original.

PORQUE

II. Sem o determinante na tabela original, a ligação com a tabela criada se perderia e a decomposição deixaria de ser sem perda.

A respeito dessas asserções, assinale a opção correta.

- **A)** As asserções I e II são proposições verdadeiras, e a II é uma justificativa correta da I;
- **B)** As asserções I e II são proposições verdadeiras, mas a II não é uma justificativa correta da I;
- **C)** A asserção I é uma proposição verdadeira, e a II é uma proposição falsa;
- **D)** A asserção I é uma proposição falsa, e a II é uma proposição verdadeira;
- **E)** As asserções I e II são proposições falsas.

↩︎ *Aula 15, seção 3 — Passo 2 — a 2FN*

---

### Q-A15-08

**[ENADE]**

A respeito da aplicação das formas normais, avalie as afirmações a seguir.

I. Em uma tabela cuja chave primária tem uma única coluna, qualquer problema de dependência encontrado entre atributos não-chave é de natureza parcial.

II. A ordem 1FN → 2FN → 3FN é um roteiro de trabalho, e não a única sequência capaz de chegar ao esquema normalizado.

III. Uma decomposição pode eliminar a redundância e, ainda assim, ser incorreta, caso não permita reconstruir a informação original.

É correto apenas o que se afirma em:

- **A)** I;
- **B)** II e III;
- **C)** I e II;
- **D)** III;
- **E)** I e III.

↩︎ *Aula 15, seção 6 — A 3FN*

---

⬅️ [Voltar à Aula 15](../README.md) | 🏠 [Início](../../../README.md)
