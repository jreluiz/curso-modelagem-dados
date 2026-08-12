# Aula 05 — Revisão: Múltipla Escolha

> 🎯 8 questões sobre a [Aula 05 — Projeto de Banco de Dados: Conceitual, Lógico e Físico](../README.md). Só uma alternativa está correta em cada uma.

**Sem gabarito, de propósito.** Cada questão termina com a seção da aula onde a resposta está. Responda **tudo primeiro**, sem consultar — só depois volte às seções indicadas e corrija.

As três últimas são marcadas **[ENADE]**: seguem o formato do exame, com cinco alternativas e enunciado mais longo.

---

### Q-A05-01

O que **entra** e o que **sai** do processo de projeto de banco de dados, na definição da aula?

- **a)** entra o modelo lógico e sai o modelo conceitual;
- **b)** entram os arquivos do sistema antigo e sai o índice;
- **c)** entram os requisitos levantados e sai o esquema do banco;
- **d)** entra o SGBD escolhido e saem as regras de negócio.

↩︎ *Aula 05, seção 2 — Projeto de banco de dados é um processo com etapas*

---

### Q-A05-02

Qual das decisões abaixo **pertence** ao modelo conceitual?

- **a)** um empréstimo se refere a exatamente um exemplar;
- **b)** a coluna que guarda o título aceita até 200 caracteres;
- **c)** a tabela de empréstimos terá um índice pela data de retirada;
- **d)** a chave será um número inteiro gerado automaticamente pelo SGBD.

↩︎ *Aula 05, seção 3 — O modelo conceitual — o que o mundo é*

---

### Q-A05-03

No modelo lógico relacional, um relacionamento **N:M** do modelo conceitual é representado por:

- **a)** uma coluna a mais em cada uma das duas tabelas;
- **b)** um índice criado sobre as duas tabelas envolvidas;
- **c)** um losango, mantido como está no diagrama conceitual;
- **d)** uma tabela nova, criada só para registrar a ligação.

↩︎ *Aula 05, seção 4 — O modelo lógico — como isso vira tabela*

---

### Q-A05-04

Qual característica identifica uma decisão de **modelo físico**?

- **a)** ela descreve quantas ocorrências participam de um relacionamento;
- **b)** ela depende do SGBD escolhido e trata de tipo, tamanho ou índice;
- **c)** ela pode ser conferida pelo cliente numa reunião de validação;
- **d)** ela permanece válida mesmo quando a instituição troca de SGBD.

↩︎ *Aula 05, seção 5 — O modelo físico — como isso vira arquivo*

---

### Q-A05-05

A biblioteca vai trocar de SGBD no ano que vem. Qual dos três modelos **continua válido** sem alteração?

- **a)** o conceitual, porque não assume nenhuma tecnologia;
- **b)** o físico, porque descreve tipos que todo SGBD reconhece;
- **c)** o lógico, porque tabelas e colunas existem em qualquer SGBD;
- **d)** nenhum, porque a troca de SGBD refaz o projeto desde o início.

↩︎ *Aula 05, seção 6 — Por que a ordem não se inverte*

---

### Q-A05-06

**[ENADE]**

Uma equipe recebeu a tarefa de informatizar o controle de empréstimos de uma biblioteca. Na primeira semana, a equipe abriu o SGBD e criou as tabelas diretamente, definindo tipos de dados e índices a partir das telas que imaginava construir.

Na reunião seguinte, o bibliotecário informou que um exemplar pode ser emprestado para uso interno, sem sair do prédio, e que esse empréstimo não tem data de devolução prevista. A equipe descobriu que a estrutura criada não comportava o caso e que já havia dados de teste carregados.

Considerando a situação, a falha de método cometida pela equipe foi:

- **A)** ter escolhido o SGBD antes de conhecer o volume de dados esperado;
- **B)** ter tomado decisões físicas antes de construir e validar o modelo conceitual com o cliente;
- **C)** ter criado índices antes de medir o desempenho das consultas mais frequentes;
- **D)** ter carregado dados de teste antes da conclusão do levantamento de requisitos;
- **E)** ter adotado o modelo relacional sem antes comparar as alternativas disponíveis.

↩︎ *Aula 05, seção 3 — O modelo conceitual — o que o mundo é*

---

### Q-A05-07

**[ENADE]**

Avalie as asserções a seguir e a relação proposta entre elas.

I. O modelo físico é o documento adequado para validar, junto ao cliente, o entendimento do minimundo.

PORQUE

II. O modelo físico depende do SGBD escolhido e registra tipos de dados, tamanhos, índices e forma de armazenamento.

A respeito dessas asserções, assinale a opção correta.

- **A)** As asserções I e II são proposições verdadeiras, e a II é uma justificativa correta da I;
- **B)** As asserções I e II são proposições verdadeiras, mas a II não é uma justificativa correta da I;
- **C)** A asserção I é uma proposição verdadeira, e a II é uma proposição falsa;
- **D)** A asserção I é uma proposição falsa, e a II é uma proposição verdadeira;
- **E)** As asserções I e II são proposições falsas.

↩︎ *Aula 05, seção 5 — O modelo físico — como isso vira arquivo*

---

### Q-A05-08

**[ENADE]**

A respeito da passagem do modelo conceitual para o modelo lógico relacional, avalie as afirmações a seguir.

I. Um relacionamento 1:N é representado por uma coluna acrescentada à tabela do lado N, apontando para a chave da outra tabela.

II. O modelo lógico independe do modelo de dados adotado, sendo o mesmo documento para bancos relacionais e hierárquicos.

III. A definição dos índices necessários às consultas mais frequentes faz parte do modelo lógico.

É correto apenas o que se afirma em:

- **A)** I;
- **B)** II;
- **C)** I e III;
- **D)** II e III;
- **E)** I, II e III.

↩︎ *Aula 05, seção 4 — O modelo lógico — como isso vira tabela*

---

⬅️ [Voltar à Aula 05](../README.md) | 🏠 [Início](../../../README.md)
