# Aula 13 — Revisão: Múltipla Escolha

> 🎯 8 questões sobre a [Aula 13 — Por que Normalizar](../README.md). Só uma alternativa está correta em cada uma.

**Sem gabarito, de propósito.** Cada questão termina com a seção da aula onde a resposta está. Responda **tudo primeiro**, sem consultar — só depois volte às seções indicadas e corrija.

As três últimas são marcadas **[ENADE]**: seguem o formato do exame, com cinco alternativas e enunciado mais longo.

---

### Q-A13-01

Segundo a aula, normalizar é:

- **a)** reunir tabelas pequenas em uma tabela maior, para facilitar a consulta;
- **b)** eliminar da tabela toda coluna cujo valor se repita em mais de uma linha;
- **c)** decompor esquemas para eliminar redundância que causa anomalia, sem perder informação;
- **d)** ordenar as linhas de uma tabela segundo a chave primária escolhida.

↩︎ *Aula 13, seção 2 — O que é normalização*

---

### Q-A13-02

Na tabela `INSCRICAO` da seção 1, um evento recém-criado, ainda sem nenhum inscrito, não pode ser cadastrado. Que anomalia é essa?

- **a)** de inserção;
- **b)** de exclusão;
- **c)** de alteração;
- **d)** de integridade referencial.

↩︎ *Aula 13, seção 1 — A planilha volta, disfarçada de tabela*

---

### Q-A13-03

O que significa dizer que as formas normais são **cumulativas**?

- **a)** que cada uma delas elimina um tipo diferente de anomalia;
- **b)** que um esquema na 3FN atende também às exigências da 2FN e da 1FN;
- **c)** que aplicá-las na ordem produz sempre o mesmo número de tabelas;
- **d)** que a soma das decomposições precisa reconstruir a tabela original.

↩︎ *Aula 13, seção 4 — O panorama: a escada das formas normais*

---

### Q-A13-04

O que a **2FN** proíbe, segundo o panorama da aula?

- **a)** valores não atômicos dentro de uma célula;
- **b)** duas dependências multivaloradas independentes na mesma tabela;
- **c)** atributo que depende de outro atributo não-chave;
- **d)** atributo que depende de apenas parte da chave composta.

↩︎ *Aula 13, seção 4 — O panorama: a escada das formas normais*

---

### Q-A13-05

Em qual situação a **desnormalização** é considerada uma decisão legítima?

- **a)** num banco analítico, com o motivo registrado e alguém responsável pelas cópias;
- **b)** sempre que a equipe achar que o número de tabelas ficou grande demais;
- **c)** quando o esquema já atingiu a 4FN e não há mais o que decompor;
- **d)** quando o modelo conceitual foi validado com o cliente antes da conversão.

↩︎ *Aula 13, seção 6 — Até onde normalizar*

---

### Q-A13-06

**[ENADE]**

Uma equipe recebeu a reclamação de que um relatório mensal estava lento. Sem medir o tempo das operações nem identificar a causa, decidiu reunir três tabelas normalizadas em uma única tabela, repetindo em cada linha o nome do aluno, o nome do curso e o título do evento.

O relatório ficou mais rápido. Seis meses depois, constatou-se que 400 registros traziam grafias diferentes para o nome de um mesmo curso, e que ninguém sabia informar qual delas era a correta.

Considerando a situação, avalie a conduta da equipe:

- **A)** a decisão foi correta, pois desempenho tem prioridade sobre a consistência dos dados;
- **B)** a desnormalização é legítima, mas exige medição prévia, motivo registrado e alguém responsável por manter as cópias;
- **C)** o erro foi não ter aplicado a 4FN antes de reunir as tabelas;
- **D)** o erro foi reunir três tabelas, e não apenas duas, o que multiplicou as grafias divergentes;
- **E)** a decisão foi incorreta porque desnormalizar é sempre um erro de projeto.

↩︎ *Aula 13, seção 6 — Até onde normalizar*

---

### Q-A13-07

**[ENADE]**

Avalie as asserções a seguir e a relação proposta entre elas.

I. A normalização de um esquema deve ser conduzida a partir da observação dos dados já cadastrados na tabela.

PORQUE

II. Um conjunto de linhas pode mostrar que uma dependência **não** existe, mas nunca provar que ela existe.

A respeito dessas asserções, assinale a opção correta.

- **A)** As asserções I e II são proposições verdadeiras, e a II é uma justificativa correta da I;
- **B)** As asserções I e II são proposições verdadeiras, mas a II não é uma justificativa correta da I;
- **C)** A asserção I é uma proposição verdadeira, e a II é uma proposição falsa;
- **D)** A asserção I é uma proposição falsa, e a II é uma proposição verdadeira;
- **E)** As asserções I e II são proposições falsas.

↩︎ *Aula 13, seção 7 — O caminho das próximas três aulas*

---

### Q-A13-08

**[ENADE]**

A respeito da normalização de dados, avalie as afirmações a seguir.

I. As formas normais são cumulativas: um esquema na 3FN atende também às exigências da 2FN e da 1FN.

II. A normalização melhora o desempenho de todas as consultas executadas sobre o banco.

III. Toda repetição de valor em uma tabela caracteriza redundância e deve ser eliminada.

É correto apenas o que se afirma em:

- **A)** I;
- **B)** II;
- **C)** III;
- **D)** I e II;
- **E)** II e III.

↩︎ *Aula 13, seção 3 — Os objetivos, e o preço*

---

⬅️ [Voltar à Aula 13](../README.md) | 🏠 [Início](../../../README.md)
