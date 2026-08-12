# Aula 04 — Revisão: Múltipla Escolha

> 🎯 8 questões sobre a [Aula 04 — Requisitos, OLTP e OLAP](../README.md). Só uma alternativa está correta em cada uma.

**Sem gabarito, de propósito.** Cada questão termina com a seção da aula onde a resposta está. Responda **tudo primeiro**, sem consultar — só depois volte às seções indicadas e corrija.

As três últimas são marcadas **[ENADE]**: seguem o formato do exame, com cinco alternativas e enunciado mais longo.

---

### Q-A04-01

Entre as quatro perguntas de levantamento vistas na aula, qual delas revela se um dado é **obrigatório**?

- **a)** Quantos?
- **b)** Precisa do histórico?
- **c)** Pode zero?
- **d)** Quem pode ver?

↩︎ *Aula 04, seção 1 — Levantar requisitos é fazer perguntas*

---

### Q-A04-02

Segundo a aula, o que uma entrevista com o cliente tende a **esconder**?

- **a)** o que a pessoa faz sem perceber que faz;
- **b)** os campos que existem de verdade nos formulários em uso;
- **c)** as decisões erradas tomadas no sistema antigo;
- **d)** as regras de negócio que a pessoa sabe explicar bem.

↩︎ *Aula 04, seção 2 — De onde vêm os requisitos*

---

### Q-A04-03

Qual das características abaixo é típica de uma carga **OLTP**?

- **a)** poucas consultas, cada uma varrendo vários anos de dados;
- **b)** muitas operações curtas, com escrita frequente e dado atual;
- **c)** modelo desnormalizado para acelerar a montagem de relatórios;
- **d)** dados carregados periodicamente, em lote, a partir de outro banco.

↩︎ *Aula 04, seção 4 — OLTP — o banco que opera*

---

### Q-A04-04

O nível de detalhe em que o dado é guardado em um banco analítico chama-se:

- **a)** domínio;
- **b)** cardinalidade;
- **c)** normalização;
- **d)** granularidade.

↩︎ *Aula 04, seção 5 — OLAP — o banco que analisa*

---

### Q-A04-05

Por que a desnormalização é considerada aceitável em um banco de dados OLAP?

- **a)** porque o dado analítico é carregado uma vez e lido muitas, sem sofrer alteração;
- **b)** porque relatórios gerenciais não precisam de dados corretos, apenas aproximados;
- **c)** porque os sistemas gerenciadores usados em OLAP não permitem normalizar tabelas;
- **d)** porque a anomalia de alteração só acontece em bancos de dados de pequeno porte.

↩︎ *Aula 04, seção 5 — OLAP — o banco que analisa*

---

### Q-A04-06

**[ENADE]**

Uma rede com 40 lojas registra, em média, três mil vendas por dia. No caixa, cada venda precisa ser registrada em poucos segundos, com o cliente aguardando, e o estoque precisa refletir imediatamente o que foi vendido.

Paralelamente, a diretoria solicitou um painel que compare o desempenho das lojas por região, por categoria de produto e por período do ano, considerando os últimos quatro anos de operação. As primeiras versões desse painel, executadas diretamente sobre a base das lojas, deixaram os caixas visivelmente lentos no horário de pico.

Considerando a situação apresentada, a solução adequada é:

- **A)** utilizar uma base única e desnormalizada, atendendo às duas necessidades com o mesmo modelo;
- **B)** manter uma base OLTP normalizada para as operações das lojas e uma base OLAP para as análises, alimentada por cargas periódicas;
- **C)** adotar um banco de dados NoSQL, por ser o único capaz de atender simultaneamente aos dois tipos de carga;
- **D)** manter a base única e restringir a execução do painel aos horários de menor movimento das lojas;
- **E)** desnormalizar a base das lojas, de modo que as consultas do painel deixem de exigir junções.

↩︎ *Aula 04, seção 6 — Cenários e a convivência*

---

### Q-A04-07

**[ENADE]**

Avalie as asserções a seguir e a relação proposta entre elas.

I. Em um banco de dados OLAP, admite-se a desnormalização do modelo.

PORQUE

II. A normalização é uma técnica desnecessária quando o volume de dados envolvido é grande.

A respeito dessas asserções, assinale a opção correta.

- **A)** As asserções I e II são proposições verdadeiras, e a II é uma justificativa correta da I;
- **B)** As asserções I e II são proposições verdadeiras, mas a II não é uma justificativa correta da I;
- **C)** A asserção I é uma proposição verdadeira, e a II é uma proposição falsa;
- **D)** A asserção I é uma proposição falsa, e a II é uma proposição verdadeira;
- **E)** As asserções I e II são proposições falsas.

↩︎ *Aula 04, seção 5 — OLAP — o banco que analisa*

---

### Q-A04-08

**[ENADE]**

A respeito das fontes utilizadas no levantamento de requisitos, avalie as afirmações a seguir.

I. A observação do trabalho em andamento revela passos do processo que o entrevistado não menciona espontaneamente.

II. Um sistema legado mostra o comportamento real do processo, mas pode conter decisões equivocadas que seriam reproduzidas no novo modelo.

III. A entrevista, por ser conduzida junto a quem conhece o processo, dispensa a consulta às demais fontes.

É correto apenas o que se afirma em:

- **A)** I;
- **B)** III;
- **C)** I e III;
- **D)** II e III;
- **E)** I e II.

↩︎ *Aula 04, seção 2 — De onde vêm os requisitos*

---

⬅️ [Voltar à Aula 04](../README.md) | 🏠 [Início](../../../README.md)
