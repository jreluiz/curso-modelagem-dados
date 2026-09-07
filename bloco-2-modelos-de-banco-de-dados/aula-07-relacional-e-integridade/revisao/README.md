# Aula 07 — Revisão: Múltipla Escolha

> 🎯 8 questões sobre a [Aula 07 — Do Relacional à Integridade Referencial](../README.md). Só uma alternativa está correta em cada uma.

**Sem gabarito, de propósito.** Cada questão termina com a seção da aula onde a resposta está. Responda **tudo primeiro**, sem consultar — só depois volte às seções indicadas e corrija.

As três últimas são marcadas **[ENADE]**: trazem um **texto-base** com uma situação concreta, seguido do comando. São mais longas de ler e cobram interpretação, não memória — as alternativas continuam simples, como nas demais.

> 💡 As três situações das questões **[ENADE]** são as mesmas dos exercícios da aula. Quem fez os exercícios responde em cinco minutos.

---

### Q-A07-01

No modelo relacional, a **cardinalidade de uma relação** é:

- **a)** o número de atributos que ela possui;
- **b)** a quantidade de ocorrências de uma entidade que participam de um relacionamento;
- **c)** o número de tuplas que ela contém no momento;
- **d)** a proporção entre as chaves primárias e as chaves estrangeiras dela.

↩︎ *Aula 07, seção 1 — A tabela, agora com os nomes formais*

---

### Q-A07-02

Uma **chave candidata** é:

- **a)** cada conjunto mínimo de atributos que identifica uma tupla;
- **b)** o conjunto de atributos escolhido para ser copiado nas tabelas que fazem referência;
- **c)** qualquer atributo cujos valores não se repetem na tabela hoje;
- **d)** o conjunto de atributos que melhor descreve a ocorrência representada.

↩︎ *Aula 07, seção 2 — Chaves: o que identifica uma tupla*

---

### Q-A07-03

Na conversão de um autorrelacionamento **1:N** para o modelo lógico, a chave estrangeira:

- **a)** obriga a criação de uma tabela associativa, como em todo autorrelacionamento;
- **b)** aponta para a tabela correspondente ao papel de cardinalidade N;
- **c)** é dispensável, porque as duas pontas já estão na mesma tabela;
- **d)** aponta para a própria tabela, e recebe um nome derivado do papel.

↩︎ *Aula 07, seção 3 — Do losango para a coluna*

---

### Q-A07-04

A integridade **de entidade** garante que:

- **a)** todo valor gravado numa coluna pertence ao domínio declarado para ela;
- **b)** nenhuma parte da chave primária de uma tupla fica vazia;
- **c)** toda chave estrangeira aponta para uma linha que existe;
- **d)** duas tuplas de uma mesma relação nunca têm todos os atributos iguais.

↩︎ *Aula 07, seção 4 — As três integridades*

---

### Q-A07-05

A política de exclusão **propagar** é adequada quando:

- **a)** a entidade do outro lado não existe fora daquele relacionamento;
- **b)** a chave estrangeira daquela ligação aceita valor vazio;
- **c)** o relacionamento convertido tem cardinalidade 1:1;
- **d)** a tabela referenciada tem poucas linhas cadastradas.

↩︎ *Aula 07, seção 5 — E quando alguém apaga o outro lado?*

---

### Q-A07-06

**[ENADE]**

Uma biblioteca universitária entrou numa rede de empréstimo entre instituições. Cada parceira tem CNPJ e uma sigla própria — e é pela sigla que os bibliotecários se referem umas às outras no dia a dia. Os dois são únicos na rede.

Ao converter o modelo, o analista escolheu a sigla como chave primária de `INSTITUICAO`, argumentando que ela é mais curta e mais legível que o CNPJ. Dois anos depois, uma das parceiras passou por fusão e mudou de sigla, e a equipe descobriu que a sigla antiga estava copiada em 1.400 pedidos já registrados.

Considerando a situação apresentada, o erro do analista foi:

- **a)** escolher como chave primária um atributo que não é único dentro da rede;
- **b)** manter o CNPJ na tabela depois de ter adotado outra coluna como chave primária;
- **c)** deixar de criar uma chave artificial, que é sempre a escolha correta em tabela referenciada;
- **d)** privilegiar tamanho e legibilidade sobre estabilidade, que é o primeiro dos três critérios.

↩︎ *Aula 07, seção 2 — Chaves: o que identifica uma tupla*

---

### Q-A07-07

**[ENADE]**

O acervo de uma biblioteca passou a registrar as referências bibliográficas entre as obras: uma obra cita várias outras e é citada por várias, e de cada citação interessa a página em que ela aparece na obra que cita.

Ao converter o modelo para o esquema lógico, uma estagiária propôs acrescentar à tabela `OBRA` duas colunas: uma `isbn_citada`, apontando para a própria `OBRA`, e uma `pagina`.

Considerando a situação descrita, a proposta está incorreta porque:

- **a)** uma chave estrangeira não pode apontar para a tabela em que ela própria está;
- **b)** o relacionamento é N:M e exige tabela própria, onde a página também passa a morar;
- **c)** a página é atributo da obra citada, e não da obra que faz a citação;
- **d)** faltou nomear os papéis, e sem eles a coluna `isbn_citada` fica ambígua.

↩︎ *Aula 07, seção 3 — Do losango para a coluna*

---

### Q-A07-08

**[ENADE]**

A coordenação de uma biblioteca pediu que uma obra desatualizada fosse apagada do sistema. A obra tem quatro exemplares na estante, aparece em 62 empréstimos do histórico e é citada por três outras obras do acervo.

O analista verificou que a exclusão exigiria decidir três políticas diferentes, e que uma delas destruiria registros de empréstimos já devolvidos — que a instituição mantém para sempre, por norma interna.

Considerando a situação apresentada, a recomendação adequada é:

- **a)** propagar a exclusão nas três ligações, já que a obra deixou de fazer parte do acervo;
- **b)** anular as três chaves estrangeiras, preservando as linhas que apontavam para a obra;
- **c)** não apagar a obra, e registrar a retirada de circulação como um atributo de situação;
- **d)** apagar somente os exemplares, mantendo a obra e as demais ligações intactas.

↩︎ *Aula 07, seção 5 — E quando alguém apaga o outro lado?*

---

⬅️ [Voltar à Aula 07](../README.md) | 🏠 [Início](../../../README.md)
