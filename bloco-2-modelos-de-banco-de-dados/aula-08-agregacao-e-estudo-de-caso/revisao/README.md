# Aula 08 — Revisão: Múltipla Escolha

> 🎯 8 questões sobre a [Aula 08 — Agregação e Estudo de Caso](../README.md). Só uma alternativa está correta em cada uma.

**Sem gabarito, de propósito.** Cada questão termina com a seção da aula onde a resposta está. Responda **tudo primeiro**, sem consultar — só depois volte às seções indicadas e corrija.

As três últimas são marcadas **[ENADE]**: seguem o formato do exame, com cinco alternativas e enunciado mais longo.

---

### Q-A08-01

A **agregação** é usada quando:

- **a)** um relacionamento inteiro precisa participar de outro relacionamento;
- **b)** uma entidade tem atributos demais para caber num só retângulo;
- **c)** duas entidades diferentes compartilham a mesma chave primária;
- **d)** um relacionamento liga três entidades ao mesmo tempo.

↩︎ *Aula 08, seção 2 — Agregação: tratar um relacionamento como uma coisa*

---

### Q-A08-02

Na notação de Chen, como se desenha uma agregação?

- **a)** com um losango duplo ligando as entidades envolvidas;
- **b)** com uma linha tracejada entre os dois relacionamentos;
- **c)** com um retângulo em volta do relacionamento e das entidades que ele liga;
- **d)** com uma elipse dupla pendurada no relacionamento agregado.

↩︎ *Aula 08, seção 2 — Agregação: tratar um relacionamento como uma coisa*

---

### Q-A08-03

Ao converter uma agregação para o modelo lógico, o que ela se torna?

- **a)** uma coluna a mais em cada tabela envolvida;
- **b)** uma tabela associativa, referenciada por quem se liga à agregação;
- **c)** uma entidade fraca dependente das duas entidades agregadas;
- **d)** nada: agregação existe apenas no desenho e desaparece na conversão.

↩︎ *Aula 08, seção 3 — A alternativa: promover o relacionamento a entidade*

---

### Q-A08-04

No estudo de caso, a regra *"o prazo padrão é de quinze dias"* não aparece no diagrama. Por quê?

- **a)** porque ela foi considerada pouco importante para o projeto;
- **b)** porque ela pertence ao modelo físico, e não ao conceitual;
- **c)** porque ela será descoberta apenas na etapa de implementação;
- **d)** porque regras sem símbolo em Chen ficam na lista de regras, em texto.

↩︎ *Aula 08, seção 4 — Estudo de caso — o projeto, parte 1: o minimundo*

---

### Q-A08-05

No ritual de leitura do modelo, qual das perguntas revelaria que uma obra doada, **sem editora conhecida**, não cabe no modelo da biblioteca?

- **a)** ler cada linha do diagrama nas duas direções;
- **b)** inventar ocorrências reais e tentar guardá-las no modelo;
- **c)** procurar o mesmo dado escrito em dois lugares diferentes;
- **d)** verificar se a chave primária escolhida é a menor possível.

↩︎ *Aula 08, seção 6 — O ritual de leitura: o modelo em voz alta*

---

### Q-A08-06

**[ENADE]**

Uma biblioteca empresta salas de estudo. Um aluno reserva uma sala para uma data e um horário, e uma mesma sala é reservada por diversos alunos ao longo da semana.

Foi solicitada uma alteração no modelo: o aluno passa a poder requisitar equipamentos — projetor ou notebook — que ficam na sala durante o período reservado. O equipamento não pode ser retirado do prédio e não pertence a nenhuma sala em particular.

Considerando o modelo entidade-relacionamento, a representação correta é:

- **A)** ligar `EQUIPAMENTO` diretamente a `ALUNO`, pois é o aluno quem responde pelo equipamento;
- **B)** ligar `EQUIPAMENTO` diretamente a `SALA`, pois é nela que o equipamento permanece;
- **C)** tratar a reserva como uma agregação e ligar `EQUIPAMENTO` a essa unidade;
- **D)** criar dois relacionamentos independentes, de `EQUIPAMENTO` para `ALUNO` e para `SALA`;
- **E)** transformar `EQUIPAMENTO` em entidade fraca de `SALA`, identificada pelo horário de uso.

↩︎ *Aula 08, seção 1 — O relacionamento que precisa se relacionar*

---

### Q-A08-07

**[ENADE]**

Avalie as asserções a seguir e a relação proposta entre elas.

I. A agregação permite que um relacionamento participe de outro relacionamento.

PORQUE

II. Relacionamentos muitos-para-muitos dão origem a tabelas associativas no modelo lógico relacional.

A respeito dessas asserções, assinale a opção correta.

- **A)** As asserções I e II são proposições verdadeiras, e a II é uma justificativa correta da I;
- **B)** As asserções I e II são proposições verdadeiras, mas a II não é uma justificativa correta da I;
- **C)** A asserção I é uma proposição verdadeira, e a II é uma proposição falsa;
- **D)** A asserção I é uma proposição falsa, e a II é uma proposição verdadeira;
- **E)** As asserções I e II são proposições falsas.

↩︎ *Aula 08, seção 2 — Agregação: tratar um relacionamento como uma coisa*

---

### Q-A08-08

**[ENADE]**

A respeito da agregação no modelo entidade-relacionamento, avalie as afirmações a seguir.

I. Ela se justifica quando o elemento externo se liga ao encontro de duas entidades, e não a cada uma delas separadamente.

II. No modelo lógico, a agregação corresponde a uma tabela cuja chave é referenciada por quem se liga a ela.

III. Toda agregação pode ser substituída por dois relacionamentos independentes, sem perda de significado.

É correto apenas o que se afirma em:

- **A)** I;
- **B)** II;
- **C)** III;
- **D)** I e II;
- **E)** II e III.

↩︎ *Aula 08, seção 3 — A alternativa: promover o relacionamento a entidade*

---

⬅️ [Voltar à Aula 08](../README.md) | 🏠 [Início](../../../README.md)
