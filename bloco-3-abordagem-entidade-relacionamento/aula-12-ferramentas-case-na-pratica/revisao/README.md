# Aula 12 — Revisão: Múltipla Escolha

> 🎯 8 questões sobre a [Aula 12 — Ferramentas CASE na Prática](../README.md). Só uma alternativa está correta em cada uma.

**Sem gabarito, de propósito.** Cada questão termina com a seção da aula onde a resposta está. Responda **tudo primeiro**, sem consultar — só depois volte às seções indicadas e corrija.

As três últimas são marcadas **[ENADE]**: seguem o formato do exame, com cinco alternativas e enunciado mais longo.

---

### Q-A12-01

Uma ferramenta classificada como **upper CASE** apoia:

- **a)** as etapas de análise e projeto, como o desenho do DER;
- **b)** as etapas de implementação, como a depuração de código;
- **c)** exclusivamente a engenharia reversa de bancos existentes;
- **d)** a gerência de configuração e o controle de versões do código.

↩︎ *Aula 12, seção 1 — De onde vieram*

---

### Q-A12-02

Entre as ferramentas apresentadas, qual desenha nativamente na **notação de Chen** e é gratuita?

- **a)** erwin Data Modeler;
- **b)** MySQL Workbench;
- **c)** Astah;
- **d)** brModelo.

↩︎ *Aula 12, seção 2 — As ferramentas de hoje*

---

### Q-A12-03

O processo que parte de um **banco de dados já existente** e produz o modelo correspondente chama-se:

- **a)** conversão automática;
- **b)** normalização do esquema;
- **c)** engenharia reversa;
- **d)** validação de consistência.

↩︎ *Aula 12, seção 1 — De onde vieram*

---

### Q-A12-04

Ao converter automaticamente um modelo conceitual em lógico, a ferramenta costuma criar uma chave artificial (`id_tabela`) em todas as tabelas. Por que isso merece revisão?

- **a)** porque chaves artificiais são proibidas no modelo relacional;
- **b)** porque o esquema deixa de dizer quem identifica a linha no mundo;
- **c)** porque chaves artificiais impedem a criação de chaves estrangeiras;
- **d)** porque a ferramenta não consegue converter entidades fracas com elas.

↩︎ *Aula 12, seção 4 — O que a conversão automática entrega*

---

### Q-A12-05

Qual informação do diagrama conceitual **se perde** na conversão automática e precisa ser recolocada à mão?

- **a)** os nomes das entidades convertidas em tabelas;
- **b)** a quantidade de colunas de cada tabela gerada;
- **c)** os atributos identificadores marcados no desenho;
- **d)** as políticas de exclusão e o que aceita valor vazio.

↩︎ *Aula 12, seção 4 — O que a conversão automática entrega*

---

### Q-A12-06

**[ENADE]**

Uma equipe modelou o banco de dados de uma biblioteca em uma ferramenta CASE, executou a conversão automática para o modelo lógico e implantou o esquema gerado sem revisão, por estar com o prazo apertado.

Semanas depois, verificou-se que a remoção de uma obra do catálogo não afetava os exemplares correspondentes, que permaneciam cadastrados apontando para uma obra inexistente; e que o campo de identificação usado pelos funcionários no balcão — o ISBN — havia se tornado uma coluna comum, ao lado de um identificador numérico criado pela ferramenta.

Considerando a situação, a origem dos dois problemas é:

- **A)** a escolha da notação de Chen, incompatível com a conversão automática;
- **B)** um defeito da ferramenta, que não implementa corretamente as regras de conversão;
- **C)** a ausência de normalização do esquema antes da implantação;
- **D)** o uso de uma ferramenta upper CASE onde seria necessária uma lower CASE;
- **E)** a ausência da revisão da conversão, etapa em que chaves e políticas de exclusão são decididas.

↩︎ *Aula 12, seção 4 — O que a conversão automática entrega*

---

### Q-A12-07

**[ENADE]**

Avalie as asserções a seguir e a relação proposta entre elas.

I. A ferramenta CASE garante que o modelo produzido esteja correto para o negócio do cliente.

PORQUE

II. A ferramenta aplica automaticamente as regras de conversão do modelo conceitual para o modelo lógico.

A respeito dessas asserções, assinale a opção correta.

- **A)** As asserções I e II são proposições verdadeiras, e a II é uma justificativa correta da I;
- **B)** As asserções I e II são proposições verdadeiras, mas a II não é uma justificativa correta da I;
- **C)** A asserção I é uma proposição verdadeira, e a II é uma proposição falsa;
- **D)** A asserção I é uma proposição falsa, e a II é uma proposição verdadeira;
- **E)** As asserções I e II são proposições falsas.

↩︎ *Aula 12, seção 3 — O roteiro no brModelo*

---

### Q-A12-08

**[ENADE]**

A respeito das ferramentas CASE, avalie as afirmações a seguir.

I. As ferramentas upper CASE apoiam a análise e o projeto; as lower CASE, a implementação e a manutenção.

II. A engenharia reversa parte de um banco de dados existente e produz o modelo correspondente, sendo usada para documentar sistemas herdados.

III. O uso de uma ferramenta CASE dispensa o levantamento de requisitos junto ao cliente, por derivar as regras do próprio modelo.

É correto apenas o que se afirma em:

- **A)** I;
- **B)** II;
- **C)** I e II;
- **D)** I e III;
- **E)** II e III.

↩︎ *Aula 12, seção 1 — De onde vieram*

---

⬅️ [Voltar à Aula 12](../README.md) | 🏠 [Início](../../../README.md)
