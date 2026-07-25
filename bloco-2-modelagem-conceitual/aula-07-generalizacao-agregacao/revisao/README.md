# Aula 07 — Revisão: Múltipla Escolha

> 🎯 8 questões sobre a [Aula 07 — Generalização, Especialização e Agregação](../README.md). Só uma alternativa está correta em cada uma.

**Sem gabarito, de propósito.** Cada questão termina com a seção da aula onde a resposta está. Responda **tudo primeiro**, sem consultar — só depois volte às seções indicadas e corrija.

---

### Q-A07-01

Qual é a diferença entre **generalização** e **especialização**?

- **a)** Generalização vale para entidades fortes; especialização, para fracas;
- **b)** generalização produz relacionamentos N:M; especialização, relacionamentos 1:1;
- **c)** são conceitos incompatíveis: um modelo usa um ou outro;
- **d)** nenhuma no resultado — mudam apenas a direção do raciocínio: de baixo para cima ou de cima para baixo.

↩︎ *Aula 07, seção 1 — Quando duas entidades são quase iguais*

---

### Q-A07-02

Ao generalizar `ALUNO`, `PROFESSOR` e `SERVIDOR` em `USUARIO`, qual é o ganho concreto no modelo da biblioteca?

- **a)** O modelo passa a ocupar menos espaço em disco;
- **b)** `EMPRESTIMO` liga-se a `USUARIO` uma vez só e vale para os três tipos, em vez de precisar de três relacionamentos;
- **c)** as subclasses deixam de precisar de chave primária;
- **d)** a especialização elimina a necessidade de chaves estrangeiras.

↩︎ *Aula 07, seção 1 — Quando duas entidades são quase iguais*

---

### Q-A07-03

Qual é a relação entre a instância da superclasse e a da subclasse?

- **a)** São dois registros independentes, ligados por uma chave estrangeira comum;
- **b)** a subclasse é uma cópia da superclasse, atualizada por gatilho;
- **c)** são a mesma coisa vista em dois níveis, compartilhando o mesmo identificador;
- **d)** a superclasse existe apenas em tempo de projeto e desaparece no modelo lógico.

↩︎ *Aula 07, seção 2 — Herança*

---

### Q-A07-04

Numa especialização **sobreposta**, qual estratégia de mapeamento fica **impossível**?

- **a)** Tabela única com um campo discriminador `tipo`, porque um campo não guarda dois valores;
- **b)** uma tabela por subclasse mais a superclasse;
- **c)** uma tabela por subclasse sem a superclasse;
- **d)** tabela única com flags booleanas.

↩︎ *Aula 07, seção 3 — As duas restrições*

---

### Q-A07-05

Numa universidade em que todo usuário é obrigatoriamente aluno, professor ou servidor, e nunca mais de um, a especialização é:

- **a)** Sobreposta e total;
- **b)** disjunta e total;
- **c)** disjunta e parcial;
- **d)** sobreposta e parcial.

↩︎ *Aula 07, seção 3 — As duas restrições*

---

### Q-A07-06

O que distingue uma **categoria** (tipo união) de uma especialização comum?

- **a)** A categoria só admite duas superclasses;
- **b)** a categoria não permite herança de atributos;
- **c)** na categoria, a subclasse herda seletivamente de várias superclasses distintas, e cada instância vem de uma delas;
- **d)** a categoria é sempre parcial, enquanto a especialização é sempre total.

↩︎ *Aula 07, seção 4 — Categoria (união)*

---

### Q-A07-07

Uma bolsa precisa se relacionar com a **orientação inteira** (professor + aluno + projeto), e não com cada entidade isoladamente. Qual recurso resolve isso?

- **a)** A agregação — tratar o relacionamento como se fosse uma entidade, para que outra entidade possa se ligar a ele;
- **b)** um relacionamento quaternário entre as quatro entidades;
- **c)** uma especialização de `BOLSA` em três subtipos;
- **d)** três relacionamentos binários independentes.

↩︎ *Aula 07, seção 5 — Agregação: quando um relacionamento vira entidade*

---

### Q-A07-08

Por que `CLIENTE` → `CLIENTE_ATIVO` / `CLIENTE_INATIVO` **não** é uma boa especialização?

- **a)** Porque especializações precisam ter no mínimo três subclasses;
- **b)** porque os nomes das subclasses são longos demais;
- **c)** porque cliente é uma entidade forte e entidades fortes não se especializam;
- **d)** porque isso é estado, não tipo: a instância muda de categoria ao longo do tempo, e teria de ser apagada de uma tabela e criada noutra, perdendo o histórico.

↩︎ *Aula 07, seção 6 — Quando **não** especializar*

---

⬅️ [Voltar à Aula 07](../README.md) | ➡️ [Revisão da Aula 08](../../aula-08-estudo-de-caso-der/revisao/README.md)
