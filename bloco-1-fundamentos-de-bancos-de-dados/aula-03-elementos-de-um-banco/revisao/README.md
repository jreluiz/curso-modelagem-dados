# Aula 03 — Revisão: Múltipla Escolha

> 🎯 8 questões sobre a [Aula 03 — Os Elementos de um Banco de Dados](../README.md). Só uma alternativa está correta em cada uma.

**Sem gabarito, de propósito.** Cada questão termina com a seção da aula onde a resposta está. Responda **tudo primeiro**, sem consultar — só depois volte às seções indicadas e corrija.

📝 **As respostas vão pelo formulário:** [responder a revisão da Aula 03](https://docs.google.com/forms/d/e/1FAIpQLSeBonzekOFuwleTMbKl4KU7CfSKD2YobUC09fcb-7NFymd5LA/viewform)

Leia as 8 questões aqui e decida suas respostas antes de abrir o formulário: é **uma resposta por aluno**, com conta Google, e não dá para editar depois de enviar. Ele também pede seu usuário do GitHub. Se o seu nome não estiver na lista da turma, marque a última opção e escreva o nome completo no campo seguinte.

As três últimas são marcadas **[ENADE]**: trazem um **texto-base** com uma situação concreta, seguido do comando. São mais longas de ler e cobram interpretação, não memória — as alternativas continuam simples, como nas demais.

---

### Q-A03-01

Na tabela `LIVRO`, a coluna `ano` aceita apenas números inteiros de quatro dígitos. Esse conjunto de valores que a coluna aceita chama-se:

- **a)** tupla;
- **b)** domínio;
- **c)** relação;
- **d)** atributo derivado.

↩︎ *Aula 03, seção 1 — Os elementos*

---

### Q-A03-02

Qual dos atributos abaixo é **derivado**?

- **a)** o ISBN de um livro;
- **b)** os telefones de contato de uma editora;
- **c)** o endereço de um aluno;
- **d)** a quantidade de exemplares que a biblioteca tem de uma obra.

↩︎ *Aula 03, seção 3 — Atributo e seus tipos*

---

### Q-A03-03

Uma candidata a entidade tem apenas um código e uma descrição, possui quatro ocorrências fixas e ninguém pretende guardar mais nada sobre ela, hoje ou no futuro. Segundo o teste visto na aula, ela deve ser modelada como:

- **a)** atributo com domínio restrito;
- **b)** entidade fraca, por depender de outra para existir;
- **c)** entidade com chave composta;
- **d)** atributo derivado, por ser calculável.

↩︎ *Aula 03, seção 4 — O que não é entidade*

---

### Q-A03-04

A ordem correta das quatro etapas do processo de modelagem é:

- **a)** conceitual, requisitos, lógico, físico;
- **b)** requisitos, lógico, conceitual, físico;
- **c)** requisitos, conceitual, lógico, físico;
- **d)** conceitual, lógico, físico, requisitos.

↩︎ *Aula 03, seção 5 — O processo de modelagem em quatro etapas*

---

### Q-A03-05

No vocabulário formal do modelo relacional, uma linha de uma tabela chama-se:

- **a)** domínio;
- **b)** tupla;
- **c)** relação;
- **d)** atributo.

↩︎ *Aula 03, seção 1 — Os elementos*

---

### Q-A03-06

**[ENADE]**

Durante o levantamento de um sistema acadêmico, um analista desenhou a entidade `ALUNO` na notação de Chen, com quatro atributos ligados a ela.

No desenho, `matricula` aparece **sublinhada**; `nome` está numa elipse comum; `telefone` está numa elipse de contorno **duplo**; e `idade` está numa elipse de contorno **tracejado**.

Com base exclusivamente no que essa notação representa, é correto afirmar que:

- **a)** o atributo `matricula` é multivalorado, por estar sublinhado no diagrama;
- **b)** cada aluno possui um único telefone, e sua idade é armazenada no banco;
- **c)** a idade é armazenada, e o telefone é calculado a partir de outro atributo;
- **d)** cada aluno pode ter vários telefones, e a idade não é armazenada, e sim calculada.

↩︎ *Aula 03, seção 3 — Atributo e seus tipos*

---

### Q-A03-07

**[ENADE]**

Numa primeira versão do modelo da biblioteca, `telefone` foi tratado como atributo multivalorado da entidade `ALUNO`: cada aluno pode ter vários números, e todos ficam pendurados nele.

Ao revisar os requisitos com o pessoal do balcão, a equipe descobriu que é preciso saber, **de cada número**, se ele é fixo, celular ou de recado, em que horário aquela pessoa costuma atender e qual foi a última data em que o contato deu certo.

Considerando a situação descrita, a decisão correta de modelagem é:

- **a)** transformar `telefone` em entidade própria, porque agora há características a guardar sobre cada número, e não sobre o aluno;
- **b)** manter `telefone` como atributo multivalorado e pendurar nele os atributos tipo, horário de atendimento e data do último contato;
- **c)** criar a entidade `TIPO_TELEFONE`, com as ocorrências fixo, celular e recado, mantendo `telefone` como atributo do aluno;
- **d)** manter `telefone` como atributo simples e registrar o tipo, o horário e a data num campo de observações do cadastro do aluno.

↩︎ *Aula 03, seção 4 — O que não é entidade*

---

### Q-A03-08

**[ENADE]**

Uma equipe recebeu o pedido de um sistema para a secretaria de uma faculdade e começou o trabalho definindo, no PostgreSQL, o tipo de cada coluna e os índices de cada tabela, com base no que imaginava que a secretaria precisaria guardar.

Três semanas depois, ao conversar pela primeira vez com os funcionários, descobriu que um aluno pode trancar a matrícula e retomá-la em outro curso — situação que as tabelas já criadas não comportam sem serem refeitas.

Considerando a situação descrita e as quatro etapas da modelagem, o erro da equipe foi:

- **a)** escolher o PostgreSQL antes de comparar o desempenho dele com o de outros SGBD para o volume de dados previsto;
- **b)** definir os índices na mesma etapa em que definiu os tipos das colunas, quando as duas coisas pertencem a etapas diferentes;
- **c)** começar pela etapa física, que é a última — são as três primeiras que dizem o que guardar, e só a primeira conversa com o cliente;
- **d)** documentar o modelo conceitual só depois de criar as tabelas, em vez de tratar os dois na mesma etapa.

↩︎ *Aula 03, seção 5 — O processo de modelagem em quatro etapas*

---

⬅️ [Voltar à Aula 03](../README.md) | 🏠 [Início](../../../README.md)
