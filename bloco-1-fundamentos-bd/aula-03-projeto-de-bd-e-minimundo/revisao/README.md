# Aula 03 — Revisão: Múltipla Escolha

> 🎯 8 questões sobre a [Aula 03 — O Projeto de Banco de Dados e o Minimundo](../README.md). Só uma alternativa está correta em cada uma.

**Sem gabarito, de propósito.** Cada questão termina com a seção da aula onde a resposta está. Responda **tudo primeiro**, sem consultar — só depois volte às seções indicadas e corrija.

---

### Q-A03-01

O que é o **minimundo** de um projeto de banco de dados?

- **a)** A menor quantidade de tabelas capaz de atender aos requisitos;
- **b)** o conjunto de usuários que terão acesso ao sistema;
- **c)** um protótipo reduzido do banco, usado para testes antes da versão final;
- **d)** o recorte da realidade que o banco vai representar — uma decisão de projeto, não algo dado pela natureza.

↩︎ *Aula 03, seção 1 — Minimundo: recortar a realidade*

---

### Q-A03-02

A equipe decide não guardar a data de devolução efetiva dos empréstimos. Qual é a consequência?

- **a)** Nenhuma, desde que a data prevista seja registrada corretamente;
- **b)** apenas uma perda de desempenho nas consultas de atraso;
- **c)** nenhuma consulta futura conseguirá calcular atrasos, porque a informação nunca foi guardada;
- **d)** o SGBD calculará a data automaticamente a partir do histórico de alterações.

↩︎ *Aula 03, seção 1 — Minimundo: recortar a realidade*

---

### Q-A03-03

"Vamos criar um índice em `data_pedido` para acelerar o relatório mensal." A que fase do projeto essa decisão pertence?

- **a)** Projeto físico;
- **b)** projeto lógico;
- **c)** projeto conceitual;
- **d)** levantamento de requisitos.

↩︎ *Aula 03, seção 2 — As quatro fases*

---

### Q-A03-04

Por que o projeto conceitual ignora deliberadamente o SGBD que será usado?

- **a)** Porque a escolha do SGBD só é feita depois que o sistema está pronto;
- **b)** porque é a única fase que o cliente consegue validar, e ela sobrevive à troca de tecnologia;
- **c)** porque os SGBDs modernos geram o modelo conceitual automaticamente;
- **d)** porque a fase conceitual trata apenas de desempenho, que é independente do produto.

↩︎ *Aula 03, seção 3 — Por que o conceitual ignora o SGBD*

---

### Q-A03-05

Na leitura de um enunciado, o que os **numerais e quantificadores** (*vários*, *cada*, *um ou mais*) indicam?

- **a)** Candidatos a entidade;
- **b)** candidatos a atributo;
- **c)** a cardinalidade dos relacionamentos — e são a informação mais fácil de perder na leitura;
- **d)** regras de negócio que não cabem no diagrama.

↩︎ *Aula 03, seção 4 — Lendo um enunciado: substantivos e verbos*

---

### Q-A03-06

Quando "editora" deve ser modelada como **entidade** em vez de atributo?

- **a)** Quando a biblioteca precisar guardar mais coisas sobre ela — endereço, contato — em vez de apenas o nome impresso na capa;
- **b)** sempre, porque todo substantivo do enunciado é uma entidade;
- **c)** nunca, porque editora é um valor textual e valores textuais são atributos;
- **d)** quando houver mais de dez editoras diferentes no acervo.

↩︎ *Aula 03, seção 4 — Lendo um enunciado: substantivos e verbos*

---

### Q-A03-07

Qual é a pergunta mais rentável que um modelador pode fazer ao cliente?

- **a)** "Quantos usuários simultâneos o sistema terá?";
- **b)** "Isso muda? E quando muda, vocês precisam saber como era antes?";
- **c)** "Qual banco de dados vocês preferem usar?";
- **d)** "Qual o orçamento disponível para o projeto?".

↩︎ *Aula 03, seção 5 — As perguntas que todo modelador faz*

---

### Q-A03-08

"O limite de empréstimos depende da categoria do usuário." O que se faz com uma informação dessas?

- **a)** Descarta-se, porque não é representável no modelo entidade-relacionamento;
- **b)** transforma-se obrigatoriamente em um relacionamento no DER;
- **c)** guarda-se apenas na memória da equipe, já que muda com frequência;
- **d)** registra-se como regra de negócio, numa lista numerada que acompanha o diagrama.

↩︎ *Aula 03, seção 6 — O que fazer com o que não cabe no diagrama*

---

⬅️ [Voltar à Aula 03](../README.md) | ➡️ [Revisão da Aula 04](../../aula-04-mer-entidades-atributos/revisao/README.md)
