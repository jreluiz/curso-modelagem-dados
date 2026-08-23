# Aula 04 — Revisão: Múltipla Escolha

> 🎯 8 questões sobre a [Aula 04 — Requisitos, OLTP e OLAP](../README.md). Só uma alternativa está correta em cada uma.

**Sem gabarito, de propósito.** Cada questão termina com a seção da aula onde a resposta está. Responda **tudo primeiro**, sem consultar — só depois volte às seções indicadas e corrija.

📝 **As respostas vão pelo formulário:** [responder a revisão da Aula 04](https://docs.google.com/forms/d/e/1FAIpQLSdCMsHBHsOHvJQc_hqeJMYJq68YeJk1kcw_koRYbnwgJSND-A/viewform)

Leia as 8 questões aqui e decida suas respostas antes de abrir o formulário: é **uma resposta por aluno**, com conta Google, e não dá para editar depois de enviar. Ele também pede seu usuário do GitHub. Se o seu nome não estiver na lista da turma, marque a última opção e escreva o nome completo no campo seguinte.

As três últimas são marcadas **[ENADE]**: trazem um **texto-base** com uma situação concreta, seguido do comando. São mais longas de ler e cobram interpretação, não memória — as alternativas continuam simples, como nas demais.

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

- **a)** adotar um banco de dados NoSQL, por ser o único capaz de atender simultaneamente aos dois tipos de carga;
- **b)** manter uma base OLTP normalizada para as operações das lojas e uma base OLAP para as análises, alimentada por cargas periódicas;
- **c)** desnormalizar a base das lojas, de modo que as consultas do painel deixem de exigir junções;
- **d)** manter a base única e restringir a execução do painel aos horários de menor movimento das lojas.

↩︎ *Aula 04, seção 6 — Cenários e a convivência*

---

### Q-A04-07

**[ENADE]**

A equipe que mantém o banco da rede de lojas resolveu repetir, dentro de cada item vendido na base do caixa, o nome e a categoria do produto. A justificativa registrada em ata foi que "o banco analítico da empresa já é desnormalizado, e funciona bem".

Três meses depois, a área de cadastro corrigiu o nome de um produto que estava grafado errado desde o começo. A partir dali, o relatório de vendas passou a exibir o mesmo produto sob dois nomes diferentes, conforme a data da venda.

Considerando a situação descrita, o erro da equipe foi:

- **a)** desnormalizar sem antes medir se as junções eram de fato o gargalo das consultas do caixa;
- **b)** permitir que a área de cadastro alterasse o nome de um produto já usado em vendas registradas;
- **c)** levar para uma base que sofre alterações uma decisão que só é legítima onde o dado é carregado uma vez e apenas lido;
- **d)** repetir dois atributos em vez de um só, quando bastaria copiar a categoria para acelerar o relatório.

↩︎ *Aula 04, seção 5 — OLAP — o banco que analisa*

---

### Q-A04-08

**[ENADE]**

Ao levantar os requisitos da biblioteca, a analista entrevistou o bibliotecário-chefe, que descreveu com clareza o fluxo de empréstimo e de devolução. Satisfeita com a riqueza do relato, ela deu a etapa por encerrada.

Semanas depois, ao examinar o formulário de empréstimo em papel, encontrou um campo "observação" preenchido à mão em cerca de um a cada dez registros. Ali estava anotado quando o exemplar voltou danificado, quem pagou o reparo e se o aluno ficou impedido de novos empréstimos — nada disso mencionado na entrevista.

Considerando a situação descrita, o que ela revela sobre o levantamento de requisitos é que:

- **a)** a entrevista foi mal conduzida, e o problema teria sido evitado com perguntas mais específicas ao bibliotecário-chefe;
- **b)** o formulário em papel deveria ter sido substituído por um sistema antes do levantamento, para que os dados chegassem estruturados;
- **c)** o campo "observação" é um vício do processo antigo, e levá-lo para o novo modelo reproduziria uma decisão equivocada do legado;
- **d)** nenhuma fonte basta sozinha — o entrevistado não conta o que faz sem perceber que faz, e é o documento que expõe isso.

↩︎ *Aula 04, seção 2 — De onde vêm os requisitos*

---

⬅️ [Voltar à Aula 04](../README.md) | 🏠 [Início](../../../README.md)
