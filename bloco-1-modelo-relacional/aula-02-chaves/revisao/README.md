# Aula 02 — Revisão: Múltipla Escolha

> 🎯 8 questões sobre a [Aula 02 — Chaves: Como Identificar uma Linha](../README.md). Só uma alternativa está correta em cada uma.

**Sem gabarito, de propósito.** Cada questão termina com a seção da aula onde a resposta está. Responda **tudo primeiro**, sem consultar — só depois volte às seções indicadas e corrija.

---

### Q-A02-01

Em `EXEMPLAR(tombo, isbn, titulo, data_aquisicao)`, sabendo que `tombo` identifica sozinho, o conjunto `(tombo, titulo)` é:

- **a)** Uma chave candidata, porque identifica unicamente;
- **b)** uma superchave, mas não uma chave candidata, porque não é mínima;
- **c)** uma chave composta, porque tem duas colunas;
- **d)** nada disso: acrescentar colunas destrói a capacidade de identificar.

↩︎ *Aula 02, seção 2 — Superchave: qualquer conjunto que identifica*

---

### Q-A02-02

Olhando as quatro linhas de hoje, o par `(isbn, data_aquisicao)` não se repete nenhuma vez. Ele pode ser declarado chave candidata?

- **a)** Sim, porque os dados provam que ele identifica;
- **b)** sim, desde que o par seja declarado `UNIQUE`;
- **c)** não, porque uma chave nunca pode ter mais de uma coluna;
- **d)** não, porque identificação se decide perguntando ao mundo, e a biblioteca pode comprar duas cópias da mesma obra no mesmo dia.

↩︎ *Aula 02, seção 2 — Superchave: qualquer conjunto que identifica*

---

### Q-A02-03

Numa tabela `ALUNO` com `matricula`, `cpf` e `email` — os três únicos — escolhe-se `matricula` como chave primária. Como se chamam `cpf` e `email` a partir daí?

- **a)** Chaves alternativas;
- **b)** superchaves;
- **c)** chaves estrangeiras;
- **d)** chaves parciais.

↩︎ *Aula 02, seção 4 — Chave primária e chave alternativa*

---

### Q-A02-04

Por que o e-mail costuma ser uma **má** escolha de chave primária, mesmo sendo único?

- **a)** Porque textos longos não podem ser chave em nenhum banco de dados;
- **b)** porque duas pessoas podem compartilhar o mesmo e-mail;
- **c)** porque ele muda quando a pessoa troca de provedor, e a chave primária precisa ser estável;
- **d)** porque o e-mail não é um dado obrigatório em nenhum cadastro.

↩︎ *Aula 02, seção 4 — Chave primária e chave alternativa*

---

### Q-A02-05

Na tabela `MATRICULA_TURMA(matricula, cod_turma, data_inscricao)`, em que um aluno cursa várias turmas e uma turma tem vários alunos, a chave primária é:

- **a)** `matricula`, porque identifica o aluno;
- **b)** `cod_turma`, porque a turma é a entidade principal;
- **c)** o par `(matricula, cod_turma)`, porque nenhuma das duas identifica sozinha e o par é mínimo;
- **d)** as três colunas juntas, para garantir unicidade.

↩︎ *Aula 02, seção 5 — Quando a chave precisa de duas colunas*

---

### Q-A02-06

O que há de errado em declarar `PRODUTO(codigo, nome, fabricante)` com as três colunas como chave primária, sabendo que `codigo` já identifica?

- **a)** Nada: quanto mais colunas na chave, mais garantida a unicidade;
- **b)** o problema é apenas estético, e não afeta o funcionamento;
- **c)** as três juntas deixam de identificar, porque `nome` pode repetir;
- **d)** a chave deixa de ser mínima, e o excesso será copiado em toda tabela que referenciar `PRODUTO`.

↩︎ *Aula 02, seção 5 — Quando a chave precisa de duas colunas*

---

### Q-A02-07

Uma tabela `PESSOA` usa um `id` artificial como chave primária e ninguém declarou nada sobre `cpf`. O que o banco aceita?

- **a)** Duas linhas com o mesmo CPF e `id` diferentes, criando duas pessoas onde havia uma;
- **b)** nada de anormal: o `id` artificial garante que não haja duplicidade de pessoas;
- **c)** duas linhas com o mesmo `id`, desde que o CPF seja diferente;
- **d)** nenhuma inserção, porque falta declarar a chave natural.

↩︎ *Aula 02, seção 6 — Chave natural × chave artificial*

---

### Q-A02-08

Qual das características abaixo é uma **vantagem** da chave natural sobre a artificial?

- **a)** Ela nunca muda, porque está definida no mundo real;
- **b)** ela permite conferir o dado com o documento de papel sem precisar de junção;
- **c)** ela é sempre mais curta e do mesmo tipo em todas as tabelas;
- **d)** ela dispensa a declaração de restrições de unicidade.

↩︎ *Aula 02, seção 6 — Chave natural × chave artificial*

---

⬅️ [Voltar à Aula 02](../README.md) | ➡️ [Revisão da Aula 03](../../aula-03-relacionamentos-chave-estrangeira/revisao/README.md)
