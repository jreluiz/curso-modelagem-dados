# Aula 09 — Revisão: Múltipla Escolha

> 🎯 8 questões sobre a [Aula 09 — Como se Conduz uma Modelagem](../README.md). Só uma alternativa está correta em cada uma.

**Sem gabarito, de propósito.** Cada questão termina com a seção da aula onde a resposta está. Responda **tudo primeiro**, sem consultar — só depois volte às seções indicadas e corrija.

As três últimas são marcadas **[ENADE]**: seguem o formato do exame, com cinco alternativas e enunciado mais longo.

---

### Q-A09-01

A estratégia que parte dos **dados concretos já existentes** — campos de formulário, colunas de planilha — e os agrupa em entidades chama-se:

- **a)** top-down;
- **b)** bottom-up;
- **c)** inside-out;
- **d)** mista.

↩︎ *Aula 09, seção 2 — As quatro estratégias de modelagem*

---

### Q-A09-02

O que caracteriza a estratégia **inside-out**?

- **a)** escolher uma entidade central e ir puxando as vizinhas dela;
- **b)** dividir o domínio em partes, modelar cada uma e integrar depois;
- **c)** começar por conceitos amplos e refiná-los em conceitos menores;
- **d)** partir dos relatórios que o cliente já emite e reconstruir as tabelas.

↩︎ *Aula 09, seção 2 — As quatro estratégias de modelagem*

---

### Q-A09-03

Qual é a diferença entre a **descrição em alto nível** e a **descrição expandida** de um mesmo DER?

- **a)** a expandida corrige erros que a de alto nível deixou passar;
- **b)** a de alto nível é o modelo conceitual e a expandida é o lógico;
- **c)** cada uma representa uma parte diferente do sistema modelado;
- **d)** o nível de detalhe: a expandida acrescenta atributos, chaves e participação.

↩︎ *Aula 09, seção 3 — O mesmo modelo em dois níveis*

---

### Q-A09-04

O que um **registro de decisão** guarda, e um dicionário de dados não?

- **a)** o domínio de cada atributo do modelo;
- **b)** as regras de negócio que não viraram desenho;
- **c)** a alternativa descartada e o motivo da recusa;
- **d)** a cardinalidade de cada lado de cada relacionamento.

↩︎ *Aula 09, seção 4 — A documentação: o que o desenho não guarda*

---

### Q-A09-05

Por que o roteiro da aula deixa os **atributos para a quarta etapa**, depois das entidades, dos relacionamentos e da cardinalidade?

- **a)** porque começar pelos atributos leva a redesenhar o formulário antigo, com os defeitos dele;
- **b)** porque atributos só podem ser definidos depois que as chaves primárias forem escolhidas;
- **c)** porque a ferramenta CASE exige essa ordem para converter o modelo automaticamente;
- **d)** porque atributos pertencem ao modelo lógico, e o roteiro trata do modelo conceitual.

↩︎ *Aula 09, seção 5 — O roteiro de uma sessão de modelagem*

---

### Q-A09-06

**[ENADE]**

Uma equipe foi contratada para modelar o banco de dados de uma secretaria acadêmica. Como ponto de partida, recebeu doze planilhas em uso há seis anos, mantidas por diferentes setores.

A equipe converteu cada planilha em uma entidade e cada coluna em um atributo. O modelo resultante ficou pronto rapidamente, mas reproduziu problemas conhecidos do material antigo: campos como `telefone1`, `telefone2` e `telefone3`, colunas preenchidas apenas por um dos setores e o nome do curso repetido em quatro planilhas diferentes.

Considerando a situação, avalie a conduta da equipe:

- **A)** a estratégia bottom-up é legítima, mas exige questionar cada campo herdado antes de convertê-lo em atributo;
- **B)** a estratégia bottom-up é inadequada para qualquer projeto, pois sempre reproduz os defeitos da fonte;
- **C)** o erro foi não ter aplicado a estratégia inside-out, única capaz de eliminar redundância;
- **D)** a conduta está correta, e os problemas apontados são resolvidos automaticamente pela normalização;
- **E)** o erro foi documentar o modelo antes de validá-lo com os setores responsáveis pelas planilhas.

↩︎ *Aula 09, seção 2 — As quatro estratégias de modelagem*

---

### Q-A09-07

**[ENADE]**

Avalie as asserções a seguir e a relação proposta entre elas.

I. A descrição em alto nível deve ser apresentada ao cliente antes da descrição expandida.

PORQUE

II. A descrição em alto nível contém mais informação que a expandida, por representar o modelo completo do sistema.

A respeito dessas asserções, assinale a opção correta.

- **A)** As asserções I e II são proposições verdadeiras, e a II é uma justificativa correta da I;
- **B)** As asserções I e II são proposições verdadeiras, mas a II não é uma justificativa correta da I;
- **C)** A asserção I é uma proposição verdadeira, e a II é uma proposição falsa;
- **D)** A asserção I é uma proposição falsa, e a II é uma proposição verdadeira;
- **E)** As asserções I e II são proposições falsas.

↩︎ *Aula 09, seção 3 — O mesmo modelo em dois níveis*

---

### Q-A09-08

**[ENADE]**

A respeito da documentação que acompanha um diagrama entidade-relacionamento, avalie as afirmações a seguir.

I. O dicionário de dados dispensa a lista de regras de negócio, por já registrar todos os atributos e seus domínios.

II. O registro de decisão guarda a alternativa que foi descartada e o motivo da recusa.

III. A descrição em alto nível e a descrição expandida são modelos distintos, cada um com suas próprias decisões de projeto.

É correto apenas o que se afirma em:

- **A)** I;
- **B)** II;
- **C)** III;
- **D)** I e II;
- **E)** II e III.

↩︎ *Aula 09, seção 4 — A documentação: o que o desenho não guarda*

---

⬅️ [Voltar à Aula 09](../README.md) | 🏠 [Início](../../../README.md)
