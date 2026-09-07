# Aula 06 — Revisão: Múltipla Escolha

> 🎯 8 questões sobre a [Aula 06 — A Notação Gráfica e os Tipos de Entidade](../README.md). Só uma alternativa está correta em cada uma.

**Sem gabarito, de propósito.** Cada questão termina com a seção da aula onde a resposta está. Responda **tudo primeiro**, sem consultar — só depois volte às seções indicadas e corrija.

As três últimas são marcadas **[ENADE]**: trazem um **texto-base** com uma situação concreta, seguido do comando. São mais longas de ler e cobram interpretação, não memória — as alternativas continuam simples, como nas demais.

> 💡 As três situações das questões **[ENADE]** são as mesmas dos exercícios da aula. Quem fez os exercícios responde em cinco minutos.

---

### Q-A06-01

Uma entidade é classificada como **fraca** quando:

- **a)** o vínculo dela com outra entidade é obrigatório em todas as ocorrências;
- **b)** ela não consegue se identificar sem a chave de outra entidade;
- **c)** ela tem poucos atributos além do próprio identificador;
- **d)** ela participa de um relacionamento com cardinalidade N.

↩︎ *Aula 06, seção 2 — Entidade forte e entidade fraca*

---

### Q-A06-02

Um atributo desenhado pendurado no **losango**, e não em nenhuma das duas entidades, indica que aquele dado:

- **a)** pertence à entidade que está do lado de cardinalidade N;
- **b)** é calculado a partir dos atributos das duas entidades ligadas;
- **c)** só faz sentido para o par de ocorrências que o relacionamento une;
- **d)** é opcional, e por isso não coube dentro de nenhuma entidade.

↩︎ *Aula 06, seção 3 — O relacionamento e o que mora dentro dele*

---

### Q-A06-03

Na convenção deste curso, qual dos trechos abaixo afirma que **uma editora publica vários livros**?

- **a)** `EDITORA ---|1| PUBLICA ---|N| LIVRO`
- **b)** `EDITORA ---|N| PUBLICA ---|1| LIVRO`
- **c)** `EDITORA ---|N| PUBLICA ---|M| LIVRO`
- **d)** `EDITORA ---|1| PUBLICA ---|1| LIVRO`

↩︎ *Aula 06, seção 4 — Cardinalidade: quantos de cada lado*

---

### Q-A06-04

A linha dupla `===` desenhada do lado de uma entidade afirma que:

- **a)** aquela entidade participa do relacionamento com cardinalidade N;
- **b)** o relacionamento tem pelo menos um atributo próprio;
- **c)** aquela entidade é fraca e depende da outra para se identificar;
- **d)** nenhuma ocorrência daquela entidade existe fora daquele relacionamento.

↩︎ *Aula 06, seção 5 — Participação: pode zero?*

---

### Q-A06-05

Por que um autorrelacionamento exige que as duas pontas recebam um **papel**?

- **a)** porque o Mermaid não desenha laço, e o papel substitui o símbolo que falta;
- **b)** porque é o papel que define a cardinalidade de cada um dos dois lados;
- **c)** porque as duas pontas saem da mesma entidade, e sem o nome não se sabe qual é qual;
- **d)** porque o papel se torna a chave primária da tabela gerada na conversão.

↩︎ *Aula 06, seção 6 — O relacionamento de uma entidade com ela mesma*

---

### Q-A06-06

**[ENADE]**

A hemeroteca de uma biblioteca universitária controlava os periódicos numa planilha única, com uma linha por fascículo recebido. Cada linha repetia o título da revista, o ISSN e o nome da editora, e trazia o número do fascículo, o mês e o ano.

Ao modelar o acervo, a equipe percebeu que os fascículos são numerados de 1 em diante dentro de cada revista: existe o fascículo 3 da revista A e o fascículo 3 da revista B, e os dois são coisas diferentes. Falta decidir como representar o fascículo no modelo conceitual.

Considerando a situação apresentada, a representação correta é:

- **a)** `FASCICULO` como entidade fraca de `REVISTA`, com a numeração servindo de chave parcial;
- **b)** `FASCICULO` como entidade forte, tendo o número do fascículo como identificador;
- **c)** o fascículo como atributo multivalorado de `REVISTA`, já que uma revista tem vários;
- **d)** `FASCICULO` como relacionamento entre `REVISTA` e `EDITORA`, com mês e ano como atributos.

↩︎ *Aula 06, seção 2 — Entidade forte e entidade fraca*

---

### Q-A06-07

**[ENADE]**

Uma biblioteca resolveu informatizar o quadro de pessoal. No primeiro rascunho, a analista desenhou duas entidades — `SUPERVISOR` e `ATENDENTE` —, cada uma com matrícula funcional, nome, ramal e data de admissão, ligadas por um relacionamento `CHEFIA` de cardinalidade 1:N.

Três meses depois da implantação, uma atendente foi promovida a supervisora. A equipe descobriu que o registro dela precisaria ser apagado de uma tabela e recriado na outra, e que o histórico de quem ela havia acompanhado passaria a apontar para uma matrícula que não existe mais.

Considerando a situação descrita, o erro de modelagem cometido no rascunho foi:

- **a)** usar cardinalidade 1:N onde caberia N:M, já que um atendente tem vários supervisores ao longo do tempo;
- **b)** deixar de registrar a data de início da supervisão, sem a qual o histórico não se reconstrói;
- **c)** não criar uma entidade `CARGO`, que permitiria trocar a função sem mexer no registro da pessoa;
- **d)** modelar como duas entidades aquilo que é uma entidade só, ligada a si mesma em dois papéis.

↩︎ *Aula 06, seção 6 — O relacionamento de uma entidade com ela mesma*

---

### Q-A06-08

**[ENADE]**

O saguão de uma biblioteca tem um guarda-volumes com 120 armários. Cada armário tem um número, fica num corredor e abre com uma chave, que traz um código gravado. Uma chave abre um armário só e nunca é remanejada para outro.

Ao modelar o guarda-volumes, um estagiário criou as entidades `ARMARIO` e `CHAVE`, ligadas por um relacionamento de cardinalidade 1:1 com participação total dos dois lados. A coordenadora pediu que ele revisse a decisão antes de seguir.

Considerando a situação apresentada, o motivo da revisão é que:

- **a)** um relacionamento 1:1 não admite participação total dos dois lados, pois nenhuma das duas entidades poderia ser cadastrada primeiro;
- **b)** a chave não tem atributo nem relacionamento próprio além do código, e por isso é atributo do armário;
- **c)** o relacionamento deveria ser 1:N, porque um armário acumula chaves diferentes ao longo do tempo;
- **d)** `ARMARIO` deveria ser entidade fraca de `CORREDOR`, já que o número só distingue dentro do corredor.

↩︎ *Aula 06, seção 4 — Cardinalidade: quantos de cada lado*

---

⬅️ [Voltar à Aula 06](../README.md) | 🏠 [Início](../../../README.md)
