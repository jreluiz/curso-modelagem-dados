# Aula 14 — Revisão: Múltipla Escolha

> 🎯 8 questões sobre a [Aula 14 — Dependência Funcional, 1FN e 2FN](../README.md). Só uma alternativa está correta em cada uma.

**Sem gabarito, de propósito.** Cada questão termina com a seção da aula onde a resposta está. Responda **tudo primeiro**, sem consultar — só depois volte às seções indicadas e corrija.

As três últimas são marcadas **[ENADE]**: seguem o formato do exame, com cinco alternativas e enunciado mais longo.

---

### Q-A14-01

A notação `X → Y` significa que:

- **a)** os valores de `X` e de `Y` são sempre iguais entre si;
- **b)** para cada valor de `X` existe um único valor de `Y`;
- **c)** `Y` é a chave primária da tabela e `X` é a chave estrangeira;
- **d)** para cada valor de `Y` existe um único valor de `X`.

↩︎ *Aula 14, seção 2 — A dependência funcional*

---

### Q-A14-02

Como se confirma que uma dependência funcional vale?

- **a)** verificando se ela se sustenta em todas as linhas já cadastradas;
- **b)** conferindo se o atributo determinado é uma chave alternativa;
- **c)** aplicando a decomposição e observando se as anomalias desaparecem;
- **d)** perguntando ao minimundo, porque os dados só podem derrubá-la.

↩︎ *Aula 14, seção 2 — A dependência funcional*

---

### Q-A14-03

Uma tabela guarda telefones nas colunas `telefone1`, `telefone2` e `telefone3`. Sobre a 1FN, é correto afirmar que:

- **a)** ela não está em 1FN: o atributo multivalorado deve virar uma tabela própria;
- **b)** ela está em 1FN, porque cada célula guarda um único valor;
- **c)** ela está em 1FN apenas se nenhuma linha usar as três colunas;
- **d)** a 1FN não se aplica, por se tratar de atributo opcional.

↩︎ *Aula 14, seção 4 — A 1FN: cada célula guarda um valor*

---

### Q-A14-04

O que é uma **dependência parcial**?

- **a)** um atributo que depende de outro atributo não-chave da tabela;
- **b)** uma dependência que vale apenas para parte das linhas cadastradas;
- **c)** um atributo que depende de apenas parte de uma chave composta;
- **d)** uma dependência entre atributos de duas tabelas diferentes.

↩︎ *Aula 14, seção 5 — Dependência parcial*

---

### Q-A14-05

Uma tabela está em 1FN e sua chave primária tem **uma única coluna**. Sobre a 2FN:

- **a)** é preciso analisar cada atributo para verificar dependências parciais;
- **b)** a tabela não pode estar em 2FN, que exige chave composta;
- **c)** a 2FN só se aplica depois que a 3FN for verificada;
- **d)** a tabela já está em 2FN, pois não há parte de chave da qual depender.

↩︎ *Aula 14, seção 6 — A 2FN*

---

### Q-A14-06

**[ENADE]**

Uma equipe analisou a tabela `INSCRICAO(cod_ev, matricula, nome_aluno, titulo_evento, data_inscricao)`, cuja chave primária é o par `(cod_ev, matricula)`.

Consultando os 300 registros já cadastrados, a equipe observou que nenhum aluno aparecia com dois nomes diferentes e que nenhum código de evento aparecia com dois títulos. Concluiu, a partir dessa observação, que a tabela não apresentava problemas de dependência e a manteve como estava.

Considerando o método de identificação de dependências funcionais, a conclusão da equipe é:

- **A)** correta, pois a ausência de contradições nos dados confirma as dependências;
- **B)** correta, desde que a verificação seja repetida periodicamente sobre a base;
- **C)** incorreta, pois os dados não provam dependências, e as observadas são justamente parciais;
- **D)** incorreta, pois a análise deveria ter começado pela verificação da 3FN;
- **E)** incorreta, pois dependências funcionais só existem em tabelas com chave simples.

↩︎ *Aula 14, seção 5 — Dependência parcial*

---

### Q-A14-07

**[ENADE]**

Avalie as asserções a seguir e a relação proposta entre elas.

I. Substituir um atributo multivalorado por uma tabela própria é a forma correta de atender à 1FN.

PORQUE

II. No modelo entidade-relacionamento, um atributo multivalorado é representado por uma elipse de contorno duplo.

A respeito dessas asserções, assinale a opção correta.

- **A)** As asserções I e II são proposições verdadeiras, e a II é uma justificativa correta da I;
- **B)** As asserções I e II são proposições verdadeiras, mas a II não é uma justificativa correta da I;
- **C)** A asserção I é uma proposição verdadeira, e a II é uma proposição falsa;
- **D)** A asserção I é uma proposição falsa, e a II é uma proposição verdadeira;
- **E)** As asserções I e II são proposições falsas.

↩︎ *Aula 14, seção 4 — A 1FN: cada célula guarda um valor*

---

### Q-A14-08

**[ENADE]**

A respeito da 1FN e da 2FN, avalie as afirmações a seguir.

I. Um valor é considerado atômico ou não conforme o propósito do banco: `endereco` numa única coluna pode estar em 1FN em um sistema e não estar em outro.

II. A dependência parcial só pode ocorrer em tabelas cuja chave primária é composta.

III. Uma tabela em 2FN não apresenta atributos que dependam de outros atributos não-chave.

É correto apenas o que se afirma em:

- **A)** I;
- **B)** III;
- **C)** I e III;
- **D)** I e II;
- **E)** II e III.

↩︎ *Aula 14, seção 6 — A 2FN*

---

⬅️ [Voltar à Aula 14](../README.md) | 🏠 [Início](../../../README.md)
