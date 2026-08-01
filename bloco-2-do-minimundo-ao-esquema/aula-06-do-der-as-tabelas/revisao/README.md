# Aula 06 — Revisão: Múltipla Escolha

> 🎯 8 questões sobre a [Aula 06 — Do DER às Tabelas](../README.md). Só uma alternativa está correta em cada uma.

**Sem gabarito, de propósito.** Cada questão termina com a seção da aula onde a resposta está. Responda **tudo primeiro**, sem consultar — só depois volte às seções indicadas e corrija.

---

### Q-A06-01

Ao terminar de aplicar as cinco regras de mapeamento, apareceu no esquema uma tabela que não veio de nenhuma delas. O que isso indica?

- **a)** Que o mapeamento está correto: tabelas extras são normais;
- **b)** que uma das cinco regras foi aplicada duas vezes;
- **c)** que a tabela foi inventada, e inventar aqui costuma ser sinal de que o diagrama estava incompleto;
- **d)** que o diagrama precisa ser redesenhado em outra notação.

↩︎ *Aula 06, seção 1 — Por que traduzir*

---

### Q-A06-02

Um usuário informa vários telefones. A tabela resultante é `TELEFONE(matricula, numero, tipo)`. Por que a chave primária não pode ser só `matricula`?

- **a)** Porque `matricula` é chave estrangeira, e chave estrangeira nunca entra na chave primária;
- **b)** porque a chave primária precisa ter o mesmo nome da tabela;
- **c)** porque `numero` é um dado mais importante que `matricula`;
- **d)** porque a mesma pessoa tem três telefones, e `matricula` sozinha se repetiria em três linhas.

↩︎ *Aula 06, seção 3 — Regra 2 — Atributo multivalorado vira tabela*

---

### Q-A06-03

No mapeamento de `OBRA ||--o{ EXEMPLAR`, o que o **mínimo** do símbolo do lado esquerdo decide?

- **a)** Se a coluna `isbn` em `EXEMPLAR` é obrigatória — como todo exemplar tem exatamente uma obra, ela não pode ficar vazia;
- **b)** de que lado a chave estrangeira vai morar;
- **c)** se é preciso criar uma tabela associativa;
- **d)** se a chave primária de `EXEMPLAR` precisa ser composta.

↩︎ *Aula 06, seção 4 — Regra 3 — 1:N vira chave estrangeira do lado N*

---

### Q-A06-04

Um N:M entre `OBRA` e `AUTOR` produz `ESCRITA(isbn, id_autor, ordem)`. Qual é a chave primária habitual dessa tabela?

- **a)** Só `isbn`, porque a obra é a entidade principal;
- **b)** o par de chaves estrangeiras, `(isbn, id_autor)`;
- **c)** só `ordem`, porque é o atributo próprio do relacionamento;
- **d)** as três colunas juntas.

↩︎ *Aula 06, seção 5 — Regra 4 — N:M vira tabela associativa*

---

### Q-A06-05

Um usuário reserva uma obra, desiste, e reserva a mesma obra seis meses depois. O que isso faz com a chave da tabela associativa?

- **a)** Nada: a segunda reserva simplesmente substitui a primeira;
- **b)** o par de FKs deixa de identificar, e a tabela precisa de uma chave própria ou de mais uma coluna na chave, como a data;
- **c)** obriga a criar uma segunda tabela associativa para as reservas antigas;
- **d)** obriga a transformar o relacionamento em 1:N.

↩︎ *Aula 06, seção 5 — Regra 4 — N:M vira tabela associativa*

---

### Q-A06-06

Em `EMPRESTIMO ||--o| MULTA`, por que a chave estrangeira fica do lado da multa?

- **a)** Porque toda multa vem de um empréstimo, enquanto nem todo empréstimo gera multa — do outro lado, a coluna ficaria vazia na maioria das linhas;
- **b)** porque `MULTA` foi criada depois de `EMPRESTIMO` no diagrama;
- **c)** porque num 1:1 a FK vai sempre para a tabela de nome menor;
- **d)** porque a multa tem valor monetário, e valores monetários exigem chave estrangeira própria.

↩︎ *Aula 06, seção 6 — Regra 5 — 1:1, e a escolha do lado*

---

### Q-A06-07

A regra "toda obra tem pelo menos um exemplar" é descrita como a perda que mais dói na tradução. Por quê?

- **a)** Porque ela exige uma chave composta que o esquema não suporta;
- **b)** porque ela some do diagrama assim que o esquema é escrito;
- **c)** porque ela só pode ser garantida criando uma sexta regra de mapeamento;
- **d)** porque a chave estrangeira está do lado do exemplar: marcá-la como obrigatória garante "todo exemplar tem obra", mas o contrário não vira restrição nenhuma.

↩︎ *Aula 06, seção 7 — O que se perde na tradução*

---

### Q-A06-08

O que a aula recomenda fazer com a regra "máximo 3 empréstimos por aluno", já que ela não é expressável no esquema?

- **a)** Abandoná-la, porque regra que o esquema não expressa não é regra;
- **b)** transformá-la num relacionamento com cardinalidade máxima 3 no diagrama;
- **c)** mantê-la escrita na lista de regras de negócio, para que a aplicação a verifique;
- **d)** criar três colunas de empréstimo na tabela `ALUNO`.

↩︎ *Aula 06, seção 7 — O que se perde na tradução*

---

⬅️ [Voltar à Aula 06](../README.md) | ➡️ [Revisão da Aula 07](../../aula-07-normalizacao/revisao/README.md)
