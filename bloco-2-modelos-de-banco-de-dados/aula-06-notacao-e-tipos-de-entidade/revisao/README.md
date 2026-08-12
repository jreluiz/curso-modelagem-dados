# Aula 06 — Revisão: Múltipla Escolha

> 🎯 8 questões sobre a [Aula 06 — A Notação Gráfica e os Tipos de Entidade](../README.md). Só uma alternativa está correta em cada uma.

**Sem gabarito, de propósito.** Cada questão termina com a seção da aula onde a resposta está. Responda **tudo primeiro**, sem consultar — só depois volte às seções indicadas e corrija.

As três últimas são marcadas **[ENADE]**: seguem o formato do exame, com cinco alternativas e enunciado mais longo.

---

### Q-A06-01

Na notação de Chen, as formas usadas para **entidade**, **relacionamento** e **atributo** são, respectivamente:

- **a)** losango, retângulo e elipse;
- **b)** retângulo, losango e elipse;
- **c)** elipse, retângulo e losango;
- **d)** retângulo, elipse e losango.

↩︎ *Aula 06, seção 1 — O diagrama diz o tipo antes de você ler o nome*

---

### Q-A06-02

O que caracteriza uma **entidade fraca**?

- **a)** participar obrigatoriamente de algum relacionamento do modelo;
- **b)** possuir menos atributos do que as demais entidades do diagrama;
- **c)** ser apagada automaticamente quando a entidade dona é apagada;
- **d)** não conseguir se identificar sem a chave da entidade da qual depende.

↩︎ *Aula 06, seção 2 — Entidade forte e entidade fraca*

---

### Q-A06-03

A biblioteca precisa registrar **a ordem em que cada autor assina** uma obra. Onde esse dado deve ficar no modelo conceitual?

- **a)** no relacionamento entre autor e livro;
- **b)** como atributo multivalorado de `LIVRO`;
- **c)** como atributo simples de `AUTOR`;
- **d)** numa entidade fraca dependente de `AUTOR`.

↩︎ *Aula 06, seção 3 — O relacionamento e o que mora dentro dele*

---

### Q-A06-04

Uma editora publica muitas obras, e cada obra tem uma única editora. Como isso se escreve na notação de Chen?

- **a)** `EDITORA ---|N| PUBLICA{PUBLICA} ---|1| LIVRO`
- **b)** `EDITORA ---|N| PUBLICA{PUBLICA} ---|M| LIVRO`
- **c)** `EDITORA ---|1| PUBLICA{PUBLICA} ---|N| LIVRO`
- **d)** `EDITORA ---|1| PUBLICA{PUBLICA} ---|1| LIVRO`

↩︎ *Aula 06, seção 4 — Cardinalidade: quantos de cada lado*

---

### Q-A06-05

A **linha dupla** entre uma entidade e um relacionamento indica que:

- **a)** o relacionamento possui atributos próprios;
- **b)** a cardinalidade daquele lado é obrigatoriamente `N`;
- **c)** as duas entidades ligadas têm a mesma chave primária;
- **d)** a entidade não pode existir fora daquele relacionamento.

↩︎ *Aula 06, seção 5 — Participação: pode zero?*

---

### Q-A06-06

**[ENADE]**

Uma equipe modelou o acervo de uma biblioteca afirmando, no diagrama, que cada livro possui um autor e que cada autor pode ter escrito vários livros. O modelo foi aprovado e o cadastro começou.

Na terceira semana, chegou à biblioteca uma obra assinada por três autores. Verificou-se, além disso, que a ficha catalográfica precisa registrar a ordem em que os autores assinam a obra, pois apenas o primeiro aparece na referência abreviada.

Considerando a situação, a alteração correta no modelo conceitual é:

- **A)** acrescentar os atributos `autor2` e `autor3` à entidade `LIVRO`, mantendo o relacionamento como está;
- **B)** transformar `AUTOR` em entidade fraca de `LIVRO`, identificada pela ordem de assinatura;
- **C)** manter o relacionamento e registrar a ordem como atributo multivalorado de `LIVRO`;
- **D)** criar um relacionamento adicional entre `LIVRO` e `AUTOR` para cada posição de assinatura;
- **E)** tornar o relacionamento N:M e registrar a ordem de assinatura como atributo do relacionamento.

↩︎ *Aula 06, seção 3 — O relacionamento e o que mora dentro dele*

---

### Q-A06-07

**[ENADE]**

Avalie as asserções a seguir e a relação proposta entre elas.

I. Na biblioteca, `EXEMPLAR` é modelado como entidade fraca de `LIVRO`.

PORQUE

II. Toda entidade que participa obrigatoriamente de um relacionamento é classificada como entidade fraca.

A respeito dessas asserções, assinale a opção correta.

- **A)** As asserções I e II são proposições verdadeiras, e a II é uma justificativa correta da I;
- **B)** As asserções I e II são proposições verdadeiras, mas a II não é uma justificativa correta da I;
- **C)** A asserção I é uma proposição verdadeira, e a II é uma proposição falsa;
- **D)** A asserção I é uma proposição falsa, e a II é uma proposição verdadeira;
- **E)** As asserções I e II são proposições falsas.

↩︎ *Aula 06, seção 2 — Entidade forte e entidade fraca*

---

### Q-A06-08

**[ENADE]**

A respeito da cardinalidade e da participação em um diagrama entidade-relacionamento, avalie as afirmações a seguir.

I. A linha dupla indica que a entidade participa do relacionamento com, no máximo, uma ocorrência.

II. Cardinalidade e obrigatoriedade são eixos independentes: um mesmo lado pode ser `1` e opcional, ou `1` e obrigatório.

III. Um relacionamento muitos-para-muitos é escrito com a mesma letra nos dois lados, indicando quantidades necessariamente iguais.

É correto apenas o que se afirma em:

- **A)** I;
- **B)** II;
- **C)** III;
- **D)** I e II;
- **E)** II e III.

↩︎ *Aula 06, seção 5 — Participação: pode zero?*

---

⬅️ [Voltar à Aula 06](../README.md) | 🏠 [Início](../../../README.md)
