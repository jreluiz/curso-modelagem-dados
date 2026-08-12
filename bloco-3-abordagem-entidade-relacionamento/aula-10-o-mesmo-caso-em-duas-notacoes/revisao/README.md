# Aula 10 — Revisão: Múltipla Escolha

> 🎯 8 questões sobre a [Aula 10 — O Mesmo Caso em Duas Notações](../README.md). Só uma alternativa está correta em cada uma.

**Sem gabarito, de propósito.** Cada questão termina com a seção da aula onde a resposta está. Responda **tudo primeiro**, sem consultar — só depois volte às seções indicadas e corrija.

As três últimas são marcadas **[ENADE]**: seguem o formato do exame, com cinco alternativas e enunciado mais longo.

---

### Q-A10-01

O terceiro compartimento de uma classe, no diagrama de classes UML, é reservado para:

- **a)** as chaves primárias e alternativas;
- **b)** as associações com as demais classes;
- **c)** as operações que a classe oferece;
- **d)** as restrições de integridade referencial.

↩︎ *Aula 10, seção 2 — A classe*

---

### Q-A10-02

A multiplicidade `1..*` em uma ponta de associação UML corresponde, no DER de Chen, a:

- **a)** cardinalidade `1` com participação total;
- **b)** cardinalidade `N` com participação total;
- **c)** cardinalidade `N` com participação parcial;
- **d)** cardinalidade `1` com participação parcial.

↩︎ *Aula 10, seção 3 — Associação e multiplicidade*

---

### Q-A10-03

O que se **perde** ao converter um DER em diagrama de classes UML?

- **a)** a indicação de qual atributo é a chave primária;
- **b)** a quantidade de ocorrências em cada ponta da ligação;
- **c)** o nome das entidades e o nome dos relacionamentos;
- **d)** a informação sobre quais atributos são obrigatórios.

↩︎ *Aula 10, seção 5 — A tabela de conversão*

---

### Q-A10-04

No diagrama de classes, o **triângulo vazado** da herança aponta para:

- **a)** a classe que tem mais atributos próprios;
- **b)** a classe de associação, quando houver;
- **c)** a subclasse, indicando a direção da especialização;
- **d)** a superclasse, ou seja, o conceito mais geral.

↩︎ *Aula 10, seção 4 — Herança*

---

### Q-A10-05

Uma agregação do DER, ao ser convertida para UML, corresponde a:

- **a)** uma associação com multiplicidade `1` nas duas pontas;
- **b)** uma classe de associação, pendurada na própria associação;
- **c)** uma herança entre a classe agregada e as classes agregadoras;
- **d)** um atributo composto, dentro de uma das classes envolvidas.

↩︎ *Aula 10, seção 5 — A tabela de conversão*

---

### Q-A10-06

**[ENADE]**

Uma equipe de desenvolvimento entregou à equipe de banco de dados o diagrama de classes de um sistema de eventos. O diagrama traz as classes `Pessoa`, `Evento` e `Sala`, com atributos tipados, associações nomeadas e multiplicidades em todas as pontas.

A equipe de banco de dados precisa transformar esse diagrama em um esquema relacional para implantação.

Considerando o que a notação UML registra e o que ela não registra, a primeira providência é:

- **A)** redesenhar o diagrama na notação de Chen, pois a UML não representa associações entre conceitos;
- **B)** solicitar as operações de cada classe, sem as quais as tabelas não podem ser definidas;
- **C)** converter cada multiplicidade em cardinalidade, pois a UML não expressa obrigatoriedade;
- **D)** definir a chave primária de cada classe, informação que a UML não registra;
- **E)** eliminar as classes de associação, que não têm equivalente no modelo relacional.

↩︎ *Aula 10, seção 5 — A tabela de conversão*

---

### Q-A10-07

**[ENADE]**

Avalie as asserções a seguir e a relação proposta entre elas.

I. Ao converter um diagrama de classes em um modelo de dados, é necessário decidir a chave primária de cada classe.

PORQUE

II. A UML não representa chave primária: um objeto tem identidade própria e não depende do valor de um atributo para se distinguir dos demais.

A respeito dessas asserções, assinale a opção correta.

- **A)** As asserções I e II são proposições verdadeiras, e a II é uma justificativa correta da I;
- **B)** As asserções I e II são proposições verdadeiras, mas a II não é uma justificativa correta da I;
- **C)** A asserção I é uma proposição verdadeira, e a II é uma proposição falsa;
- **D)** A asserção I é uma proposição falsa, e a II é uma proposição verdadeira;
- **E)** As asserções I e II são proposições falsas.

↩︎ *Aula 10, seção 5 — A tabela de conversão*

---

### Q-A10-08

**[ENADE]**

A respeito da comparação entre o DER de Chen e o diagrama de classes UML, avalie as afirmações a seguir.

I. A multiplicidade colocada junto a uma classe indica quantas ocorrências da **outra** classe participam da associação.

II. A multiplicidade reúne em um único símbolo as duas perguntas que, em Chen, aparecem em dois lugares do desenho: "quantos?" e "pode zero?".

III. O triângulo vazado da herança aponta para a superclasse, e lê-se de baixo para cima com a expressão "é um".

É correto apenas o que se afirma em:

- **A)** I;
- **B)** II;
- **C)** III;
- **D)** I e II;
- **E)** II e III.

↩︎ *Aula 10, seção 3 — Associação e multiplicidade*

---

⬅️ [Voltar à Aula 10](../README.md) | 🏠 [Início](../../../README.md)
