# Aula 07 — Revisão: Múltipla Escolha

> 🎯 8 questões sobre a [Aula 07 — Do Relacional à Integridade Referencial](../README.md). Só uma alternativa está correta em cada uma.

**Sem gabarito, de propósito.** Cada questão termina com a seção da aula onde a resposta está. Responda **tudo primeiro**, sem consultar — só depois volte às seções indicadas e corrija.

As três últimas são marcadas **[ENADE]**: seguem o formato do exame, com cinco alternativas e enunciado mais longo.

---

### Q-A07-01

No vocabulário do modelo relacional, uma **tupla** corresponde a:

- **a)** o conjunto de valores aceitos por uma coluna;
- **b)** a descrição da estrutura da tabela, sem os dados;
- **c)** o número de colunas que a tabela possui;
- **d)** uma linha da tabela, ou seja, uma ocorrência do mundo.

↩︎ *Aula 07, seção 1 — A tabela, agora com os nomes formais*

---

### Q-A07-02

Uma tabela de alunos tem três colunas que identificam sozinhas cada linha: `matricula`, `cpf` e `email`. Ao escolher `matricula` como chave primária, as outras duas passam a ser:

- **a)** chaves estrangeiras;
- **b)** chaves alternativas;
- **c)** chaves parciais;
- **d)** atributos multivalorados.

↩︎ *Aula 07, seção 2 — Chaves: o que identifica uma tupla*

---

### Q-A07-03

Ao converter um relacionamento **N:M** para o modelo lógico, o que acontece com os atributos que estavam no losango?

- **a)** são distribuídos entre as duas tabelas ligadas;
- **b)** são descartados, porque losango não vira tabela;
- **c)** vão para a tabela associativa criada para a ligação;
- **d)** viram uma entidade fraca dependente das duas tabelas.

↩︎ *Aula 07, seção 3 — Do losango para a coluna*

---

### Q-A07-04

Um livro foi cadastrado com o CNPJ de uma editora que não existe na tabela `EDITORA`. Qual integridade foi violada?

- **a)** referencial;
- **b)** de entidade;
- **c)** de domínio;
- **d)** de cardinalidade.

↩︎ *Aula 07, seção 4 — As três integridades*

---

### Q-A07-05

A obra que está sendo removida do acervo tem três exemplares cadastrados. Qual política de exclusão é a adequada para os exemplares, e por quê?

- **a)** anular, porque o exemplar continua existindo fisicamente na estante;
- **b)** recusar, porque nenhum dado deve ser apagado junto com outro;
- **c)** propagar, porque exemplar é entidade fraca e não existe sem a obra;
- **d)** anular, porque a política de exclusão é sempre definida pelo SGBD.

↩︎ *Aula 07, seção 5 — E quando alguém apaga o outro lado?*

---

### Q-A07-06

**[ENADE]**

Em uma biblioteca, a tabela de livros mantém uma coluna que aponta para a tabela de editoras. Ao tentar remover do cadastro uma editora que havia encerrado as atividades, o funcionário recebeu uma recusa do sistema: havia 40 livros do acervo associados a ela.

O funcionário sugeriu, então, que o sistema fosse alterado para permitir a remoção, apagando automaticamente os livros associados.

Considerando a integridade referencial e o significado dos dados envolvidos, a decisão adequada é:

- **A)** aceitar a sugestão, pois a exclusão em cascata mantém o banco consistente em qualquer situação;
- **B)** aceitar a sugestão, desde que os livros apagados sejam recadastrados manualmente depois;
- **C)** remover a chave estrangeira do modelo, eliminando a origem da recusa;
- **D)** manter a recusa, pois os livros continuam no acervo e a decisão sobre eles precisa ser explícita;
- **E)** alterar a coluna para aceitar o nome da editora em vez do CNPJ, evitando a dependência entre as tabelas.

↩︎ *Aula 07, seção 5 — E quando alguém apaga o outro lado?*

---

### Q-A07-07

**[ENADE]**

Avalie as asserções a seguir e a relação proposta entre elas.

I. Em uma relação, nenhuma parte da chave primária pode ficar sem valor.

PORQUE

II. A chave primária é o que distingue uma tupla de todas as outras, e um valor ausente impediria essa distinção.

A respeito dessas asserções, assinale a opção correta.

- **A)** As asserções I e II são proposições verdadeiras, e a II é uma justificativa correta da I;
- **B)** As asserções I e II são proposições verdadeiras, mas a II não é uma justificativa correta da I;
- **C)** A asserção I é uma proposição verdadeira, e a II é uma proposição falsa;
- **D)** A asserção I é uma proposição falsa, e a II é uma proposição verdadeira;
- **E)** As asserções I e II são proposições falsas.

↩︎ *Aula 07, seção 4 — As três integridades*

---

### Q-A07-08

**[ENADE]**

A respeito da conversão de um diagrama entidade-relacionamento em esquema lógico relacional, avalie as afirmações a seguir.

I. Uma chave estrangeira pode referenciar qualquer coluna da outra tabela, desde que os valores estejam sem repetição no momento do cadastro.

II. Em um relacionamento 1:N, a chave estrangeira é acrescentada à tabela correspondente ao lado N.

III. Um relacionamento N:M origina uma tabela própria, cuja chave primária é composta pelas chaves das duas tabelas ligadas.

É correto apenas o que se afirma em:

- **A)** I;
- **B)** I e II;
- **C)** I e III;
- **D)** II;
- **E)** II e III.

↩︎ *Aula 07, seção 3 — Do losango para a coluna*

---

⬅️ [Voltar à Aula 07](../README.md) | 🏠 [Início](../../../README.md)
