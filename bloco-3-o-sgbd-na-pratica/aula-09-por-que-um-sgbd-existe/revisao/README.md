# Aula 09 — Revisão: Múltipla Escolha

> 🎯 8 questões sobre a [Aula 09 — Por Que um SGBD Existe](../README.md). Só uma alternativa está correta em cada uma.

**Sem gabarito, de propósito.** Cada questão termina com a seção da aula onde a resposta está. Responda **tudo primeiro**, sem consultar — só depois volte às seções indicadas e corrija.

---

### Q-A09-01

Dos quatro pecados do arquivo solto, quais **dois** a modelagem sozinha já resolve?

- **a)** Dependência entre programa e dado, e isolamento dos dados;
- **b)** redundância e inconsistência;
- **c)** redundância e isolamento dos dados;
- **d)** inconsistência e dependência entre programa e dado.

↩︎ *Aula 09, seção 2 — Os quatro pecados do arquivo solto*

---

### Q-A09-02

Por que a inconsistência é descrita como consequência inevitável da redundância?

- **a)** Porque dados repetidos ocupam mais espaço e o disco corrompe as cópias;
- **b)** porque a planilha não permite copiar valores entre células;
- **c)** porque duas cópias do mesmo dado só ficam iguais enquanto todo mundo lembra de atualizar as duas;
- **d)** porque o SGBD sincroniza as cópias apenas uma vez por dia.

↩︎ *Aula 09, seção 2 — Os quatro pecados do arquivo solto*

---

### Q-A09-03

A aula diz que o banco "não é mais inteligente que a planilha — ele é mais teimoso". O que essa frase quer dizer?

- **a)** Que a regra é escrita uma vez e cobrada em todas as escritas, inclusive quando é inconveniente;
- **b)** que o banco recusa comandos que não entende, exigindo sintaxe perfeita;
- **c)** que o banco é mais lento que a planilha por causa das verificações;
- **d)** que o banco impede alterações no esquema depois que os dados entram.

↩︎ *Aula 09, seção 3 — O que um SGBD acrescenta*

---

### Q-A09-04

Você declarou, por engano, que um empréstimo pode existir sem exemplar. O que o SGBD faz?

- **a)** Recusa a declaração, porque ela contraria a integridade referencial;
- **b)** corrige o modelo automaticamente ao detectar a inconsistência;
- **c)** aceita a declaração, mas avisa o administrador toda vez que ela for usada;
- **d)** aceita e defende essa bobagem com todo o rigor: o SGBD garante as regras declaradas, e qualidade do dado continua sendo decisão de projeto.

↩︎ *Aula 09, seção 3 — O que um SGBD acrescenta*

---

### Q-A09-05

Dois atendentes leem a situação do tombo 4417 como LIVRE e cada um grava um empréstimo. Como se chama o que aconteceu?

- **a)** Violação de integridade referencial;
- **b)** falha de recuperação;
- **c)** dependência transitiva;
- **d)** atualização perdida — a escrita do primeiro foi sobrescrita sem que ninguém percebesse.

↩︎ *Aula 09, seção 4 — Concorrência, num exemplo*

---

### Q-A09-06

Registrar um empréstimo exige gravar a linha e mudar a situação do exemplar. Se a energia cai entre os dois passos, o que um SGBD faz ao religar?

- **a)** Consulta o próprio registro de operações e desfaz o que ficou pela metade, tratando os dois passos como unidade indivisível;
- **b)** mantém o primeiro passo e pede ao operador que refaça o segundo;
- **c)** apaga a tabela envolvida e a recria a partir do último backup;
- **d)** nada: recuperação é responsabilidade do programa que fez a gravação.

↩︎ *Aula 09, seção 5 — Recuperação: o que acontece quando falta luz*

---

### Q-A09-07

Qual é a pergunta de três partes que decide entre arquivo e banco?

- **a)** Os dados são grandes, rápidos e complexos?;
- **b)** os dados são estruturados, tipados e validados?;
- **c)** os dados vão ser compartilhados, relacionados e viver mais que o programa que os criou?;
- **d)** os dados são confidenciais, auditáveis e regulados?.

↩︎ *Aula 09, seção 6 — Quando **não** usar um SGBD*

---

### Q-A09-08

Por que a aula diz que o erro de modelagem é mais grave que o erro de DBA?

- **a)** Porque o erro de DBA nunca derruba o servidor;
- **b)** porque o erro de DBA aparece no mesmo dia, enquanto o de modelagem aparece dois anos depois — quando se descobre que a informação nunca foi guardada de forma que permitisse responder à pergunta;
- **c)** porque o projetista de dados ganha mais que o DBA;
- **d)** porque erros de modelagem violam restrições de integridade e erros de DBA não.

↩︎ *Aula 09, seção 7 — Quem é quem*

---

⬅️ [Voltar à Aula 09](../README.md) | ➡️ [Revisão da Aula 10](../../aula-10-arquitetura-independencia/revisao/README.md)
