# Aula 11 — Revisão: Múltipla Escolha

> 🎯 8 questões sobre a [Aula 11 — Especialização, Generalização e as Ferramentas](../README.md). Só uma alternativa está correta em cada uma.

**Sem gabarito, de propósito.** Cada questão termina com a seção da aula onde a resposta está. Responda **tudo primeiro**, sem consultar — só depois volte às seções indicadas e corrija.

As três últimas são marcadas **[ENADE]**: seguem o formato do exame, com cinco alternativas e enunciado mais longo.

---

### Q-A11-01

O que caracteriza a **generalização**?

- **a)** partir de uma entidade genérica e identificar subconjuntos com características próprias;
- **b)** transformar um relacionamento N:M em uma entidade associativa;
- **c)** repetir, em cada subclasse, os atributos comuns a todas elas;
- **d)** partir de entidades semelhantes e criar uma superclasse com o que é comum.

↩︎ *Aula 11, seção 2 — Especialização e generalização*

---

### Q-A11-02

Uma especialização é classificada como **total** quando:

- **a)** as subclasses não podem ter atributos próprios além dos herdados;
- **b)** uma ocorrência pode pertencer a mais de uma subclasse ao mesmo tempo;
- **c)** toda ocorrência da superclasse pertence a alguma das subclasses;
- **d)** todas as subclasses possuem a mesma quantidade de ocorrências.

↩︎ *Aula 11, seção 3 — As duas perguntas que toda especialização responde*

---

### Q-A11-03

Numa faculdade em que o professor pode cursar a pós-graduação da própria instituição, a especialização de `PESSOA` em `ALUNO` e `PROFESSOR` é:

- **a)** disjunta, porque cada pessoa tem uma única matrícula;
- **b)** sobreposta, porque a mesma pessoa pode estar nas duas subclasses;
- **c)** parcial, porque nem toda pessoa da instituição estuda;
- **d)** indefinida, porque o eixo só é decidido no modelo lógico.

↩︎ *Aula 11, seção 3 — As duas perguntas que toda especialização responde*

---

### Q-A11-04

Por que `ALUNO` e `EX_ALUNO` **não** devem ser subclasses de `PESSOA`?

- **a)** porque a diferença entre as duas é um papel que muda com o tempo;
- **b)** porque nenhuma das duas teria atributos próprios em modelo algum;
- **c)** porque uma especialização não pode ter apenas duas subclasses;
- **d)** porque a superclasse `PESSOA` é genérica demais para ser especializada.

↩︎ *Aula 11, seção 4 — Quando não especializar*

---

### Q-A11-05

O que uma ferramenta CASE de modelagem **faz**?

- **a)** decide se um conceito do minimundo é entidade ou atributo;
- **b)** levanta com o cliente as regras de negócio que faltaram;
- **c)** converte o modelo conceitual em lógico aplicando as regras de conversão;
- **d)** garante que o modelo desenhado está correto para o negócio.

↩︎ *Aula 11, seção 6 — O que é uma ferramenta CASE*

---

### Q-A11-06

**[ENADE]**

Uma universidade modelou seus servidores especializando a entidade `FUNCIONARIO` em `PROFESSOR` e `PESQUISADOR`. A especialização foi declarada como **disjunta**, e o sistema passou a impedir que um mesmo funcionário fosse cadastrado nas duas subclasses.

Meses depois, a instituição contratou profissionais que atuam simultaneamente em ensino e em pesquisa, com atribuições e adicionais distintos em cada função. O cadastro passou a recusar esses casos, e os setores começaram a criar segundos registros com matrículas fictícias.

Considerando a situação, a correção adequada no modelo é:

- **A)** eliminar a especialização e manter apenas `FUNCIONARIO`, com um atributo `funcao`;
- **B)** transformar `PROFESSOR` e `PESQUISADOR` em entidades independentes, sem superclasse;
- **C)** declarar a especialização como sobreposta, permitindo a ocorrência nas duas subclasses;
- **D)** declarar a especialização como parcial, o que libera o cadastro nas duas subclasses;
- **E)** criar uma terceira subclasse `PROFESSOR_PESQUISADOR`, mantendo a disjunção.

↩︎ *Aula 11, seção 3 — As duas perguntas que toda especialização responde*

---

### Q-A11-07

**[ENADE]**

Avalie as asserções a seguir e a relação proposta entre elas.

I. A especialização de `USUARIO` em `ALUNO` e `PROFESSOR` se justifica quando cada subclasse possui atributos ou relacionamentos próprios.

PORQUE

II. Uma ferramenta CASE é capaz de converter um modelo conceitual em modelo lógico aplicando automaticamente as regras de conversão.

A respeito dessas asserções, assinale a opção correta.

- **A)** As asserções I e II são proposições verdadeiras, e a II é uma justificativa correta da I;
- **B)** As asserções I e II são proposições verdadeiras, mas a II não é uma justificativa correta da I;
- **C)** A asserção I é uma proposição verdadeira, e a II é uma proposição falsa;
- **D)** A asserção I é uma proposição falsa, e a II é uma proposição verdadeira;
- **E)** As asserções I e II são proposições falsas.

↩︎ *Aula 11, seção 6 — O que é uma ferramenta CASE*

---

### Q-A11-08

**[ENADE]**

A respeito de especialização e generalização no modelo entidade-relacionamento, avalie as afirmações a seguir.

I. Toda especialização responde a duas perguntas independentes: se é total ou parcial, e se é disjunta ou sobreposta.

II. Uma subclasse cujo único traço distintivo é uma situação que muda ao longo do tempo justifica a criação da especialização.

III. No diagrama de classes UML, o próprio símbolo da herança registra se a especialização é total e disjunta.

É correto apenas o que se afirma em:

- **A)** I;
- **B)** II;
- **C)** III;
- **D)** I e II;
- **E)** I e III.

↩︎ *Aula 11, seção 5 — Estudo de caso: o mesmo modelo nas duas notações*

---

⬅️ [Voltar à Aula 11](../README.md) | 🏠 [Início](../../../README.md)
