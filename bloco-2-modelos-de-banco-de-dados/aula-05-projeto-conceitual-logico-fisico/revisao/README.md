# Aula 05 — Revisão: Múltipla Escolha

> 🎯 8 questões sobre a [Aula 05 — Projeto de Banco de Dados: Conceitual, Lógico e Físico](../README.md). Só uma alternativa está correta em cada uma.

**Sem gabarito, de propósito.** Cada questão termina com a seção da aula onde a resposta está. Responda **tudo primeiro**, sem consultar — só depois volte às seções indicadas e corrija.

As três últimas são marcadas **[ENADE]**: trazem um **texto-base** com uma situação concreta, seguido do comando. São mais longas de ler e cobram interpretação, não memória — as alternativas continuam simples, como nas demais.

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

- **a)** ter escolhido o SGBD antes de conhecer o volume de dados esperado;
- **b)** ter tomado decisões físicas antes de construir e validar o modelo conceitual com o cliente;
- **c)** ter criado índices antes de medir o desempenho das consultas mais frequentes;
- **d)** ter carregado dados de teste antes da conclusão do levantamento de requisitos.

↩︎ *Aula 05, seção 3 — O modelo conceitual — o que o mundo é*

---

### Q-A05-07

**[ENADE]**

Uma clínica-escola mantém o banco do prontuário em um SGBD e decidiu trocar de fornecedor por questão de contrato. A equipe de dados foi consultada sobre o que precisará ser refeito na migração.

O levantamento mostrou que o diagrama de entidades e relacionamentos validado com a coordenação continua descrevendo corretamente o funcionamento da clínica, e que a estrutura de tabelas e colunas permanece a mesma. O que muda são os tipos exatos de cada coluna, os índices e a forma de armazenamento.

Considerando a situação apresentada, o documento que precisa ser refeito é o:

- **a)** modelo conceitual, porque ele descreve o minimundo que o novo SGBD vai atender;
- **b)** modelo lógico, porque tabelas e colunas são definidas pela linguagem de cada fornecedor;
- **c)** levantamento de requisitos, porque a troca de fornecedor altera o que o sistema guarda;
- **d)** modelo físico, porque ele é o único nível que assume compromisso com o SGBD escolhido.

↩︎ *Aula 05, seção 5 — O modelo físico — como isso vira arquivo*

---

### Q-A05-08

**[ENADE]**

Um laboratório de informática empresta equipamentos aos professores. Um professor reserva vários equipamentos ao longo do semestre, e um mesmo equipamento é reservado por vários professores. Para cada reserva, a secretaria precisa registrar a data prevista de retirada.

No modelo conceitual, a equipe desenhou `PROFESSOR` e `EQUIPAMENTO` ligados por um relacionamento `RESERVA`, com a data prevista como atributo desse relacionamento. Agora precisa traduzir o desenho para o modelo lógico relacional.

Considerando a situação apresentada, a tradução correta é:

- **a)** duas tabelas, com a data prevista como coluna de `EQUIPAMENTO`;
- **b)** duas tabelas, com a data prevista como coluna de `PROFESSOR`;
- **c)** três tabelas, com a data prevista na tabela que representa a reserva;
- **d)** três tabelas, com a data prevista repetida em `PROFESSOR` e em `EQUIPAMENTO`.

↩︎ *Aula 05, seção 4 — O modelo lógico — como isso vira tabela*

---

⬅️ [Voltar à Aula 05](../README.md) | 🏠 [Início](../../../README.md)
