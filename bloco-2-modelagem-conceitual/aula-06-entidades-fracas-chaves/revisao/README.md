# Aula 06 — Revisão: Múltipla Escolha

> 🎯 8 questões sobre a [Aula 06 — Entidades Fracas e Chaves](../README.md). Só uma alternativa está correta em cada uma.

**Sem gabarito, de propósito.** Cada questão termina com a seção da aula onde a resposta está. Responda **tudo primeiro**, sem consultar — só depois volte às seções indicadas e corrija.

---

### Q-A06-01

O que caracteriza uma **entidade fraca**?

- **a)** Ter poucos atributos em relação às demais entidades do modelo;
- **b)** não ter chave própria: sua identificação depende da chave da entidade proprietária;
- **c)** ter uma chave estrangeira obrigatória (`NOT NULL`);
- **d)** participar de um único relacionamento no modelo inteiro.

↩︎ *Aula 06, seção 1 — A entidade que não se identifica sozinha*

---

### Q-A06-02

Qual afirmação sobre o **relacionamento identificador** é verdadeira?

- **a)** Ele é sempre N:M, porque liga muitas fracas a muitas proprietárias;
- **b)** ele pode ter participação parcial do lado fraco, se a entidade for opcional;
- **c)** ele liga duas entidades fracas entre si;
- **d)** ele é sempre 1:N e total do lado fraco — nenhuma instância fraca existe sem a proprietária.

↩︎ *Aula 06, seção 2 — Relacionamento identificador e chave parcial*

---

### Q-A06-03

`PEDIDO` tem número único no sistema inteiro e exige um cliente (FK `NOT NULL`). É entidade fraca?

- **a)** Não. Ele depende do cliente para existir, mas se identifica sozinho — é forte com FK obrigatória;
- **b)** sim, porque a FK obrigatória caracteriza dependência;
- **c)** sim, porque todo pedido pertence a um cliente;
- **d)** depende do SGBD utilizado.

↩︎ *Aula 06, seção 3 — O teste que separa fraca de forte*

---

### Q-A06-04

Qual é o **teste decisivo** para saber se uma entidade é fraca?

- **a)** Verificar se ela tem menos de cinco atributos;
- **b)** verificar se a chave estrangeira aceita nulo;
- **c)** apagar mentalmente a entidade proprietária e perguntar se a chave da candidata ainda identifica cada instância;
- **d)** verificar se ela participa de algum relacionamento N:M.

↩︎ *Aula 06, seção 3 — O teste que separa fraca de forte*

---

### Q-A06-05

Um paciente informa vários convênios, e para cada um interessam a carteirinha e a data de validade. Como modelar?

- **a)** Como atributo multivalorado simples, já que são vários valores;
- **b)** como três colunas: `convenio1`, `convenio2`, `convenio3`;
- **c)** como um único campo de texto separado por vírgulas;
- **d)** como entidade (fraca ou forte, conforme o convênio seja compartilhado), porque cada valor tem características próprias.

↩︎ *Aula 06, seção 4 — Entidade fraca × atributo multivalorado*

---

### Q-A06-06

Na entidade `TELEFONE(matricula, numero, tipo)`, por que a chave inclui `matricula`?

- **a)** Porque dois usuários podem ter o mesmo número — mãe e filho no mesmo telefone residencial — e o modelo precisa permitir isso;
- **b)** porque toda chave de entidade fraca precisa ter exatamente dois atributos;
- **c)** porque `numero` é um campo de texto e textos não podem ser chave;
- **d)** porque a matrícula é mais curta que o número de telefone.

↩︎ *Aula 06, seção 4 — Entidade fraca × atributo multivalorado*

---

### Q-A06-07

A biblioteca decide numerar os exemplares de 1 em diante **dentro de cada obra**, em vez de usar tombo único no acervo. O que muda?

- **a)** Nada no modelo conceitual, apenas no DDL;
- **b)** a obra passa a ser entidade fraca do exemplar;
- **c)** `EXEMPLAR` passa a ser entidade fraca, com chave `(isbn, numero)`;
- **d)** o relacionamento entre obra e exemplar passa a ser N:M.

↩︎ *Aula 06, seção 5 — Chaves candidatas na prática*

---

### Q-A06-08

Uma equipe adota `id` sequencial como chave primária em todas as tabelas. Qual é o erro mais comum nessa política?

- **a)** Chaves artificiais tornam as consultas mais lentas;
- **b)** esquecer de declarar a chave natural como `UNIQUE`, o que faz o banco aceitar dois usuários com o mesmo CPF;
- **c)** chaves artificiais não podem ser referenciadas por chaves estrangeiras;
- **d)** o SGBD passa a exigir uma tabela auxiliar para gerar os números.

↩︎ *Aula 06, seção 6 — Chave natural × chave artificial*

---

⬅️ [Voltar à Aula 06](../README.md) | ➡️ [Revisão da Aula 07](../../aula-07-generalizacao-agregacao/revisao/README.md)
