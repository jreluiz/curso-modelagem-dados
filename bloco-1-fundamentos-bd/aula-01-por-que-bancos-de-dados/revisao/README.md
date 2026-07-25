# Aula 01 — Revisão: Múltipla Escolha

> 🎯 8 questões sobre a [Aula 01 — Por Que Bancos de Dados Existem](../README.md). Só uma alternativa está correta em cada uma.

**Sem gabarito, de propósito.** Cada questão termina com a seção da aula onde a resposta está. Responda **tudo primeiro**, sem consultar — só depois volte às seções indicadas e corrija.

---

### Q-A01-01

Uma planilha guarda o telefone de cada aluno repetido em toda linha de empréstimo. O aluno troca de telefone e apenas metade das linhas é atualizada. Qual é a **causa raiz** do problema?

- **a)** Falta de atenção de quem digitou;
- **b)** ausência de uma coluna de data de atualização;
- **c)** o dado não tem um lugar único onde mora, então existem várias cópias que precisam ser mantidas iguais manualmente;
- **d)** a planilha não tem tamanho suficiente para os dados.

↩︎ *Aula 01, seção 2 — Os quatro pecados do arquivo solto*

---

### Q-A01-02

Um programa lê a planilha assumindo que o telefone é a quarta coluna. Alguém insere uma coluna nova no meio e o programa passa a exibir o curso onde deveria exibir o telefone. Que problema é esse?

- **a)** Redundância;
- **b)** inconsistência;
- **c)** isolamento dos dados;
- **d)** dependência entre programa e dado.

↩︎ *Aula 01, seção 2 — Os quatro pecados do arquivo solto*

---

### Q-A01-03

Qual afirmação sobre um SGBD é **verdadeira**?

- **a)** Ele impede que se projete um modelo de dados ruim;
- **b)** ele garante as regras que você declarou — e apenas essas;
- **c)** ele elimina automaticamente toda redundância, sem intervenção do projetista;
- **d)** ele dispensa a etapa de modelagem, já que organiza os dados sozinho.

↩︎ *Aula 01, seção 3 — O que um SGBD acrescenta*

---

### Q-A01-04

Dois atendentes leem que o exemplar 4417 está livre no mesmo instante e ambos o emprestam. O primeiro empréstimo é sobrescrito sem que ninguém perceba. Como se chama esse problema?

- **a)** Atualização perdida (*lost update*);
- **b)** leitura suja (*dirty read*);
- **c)** violação de integridade referencial;
- **d)** anomalia de exclusão.

↩︎ *Aula 01, seção 4 — Controle de concorrência, em um exemplo*

---

### Q-A01-05

Transferir um exemplar entre unidades exige dar baixa numa e entrada na outra. Falta energia entre os dois passos. O que um SGBD faz ao religar?

- **a)** Consulta o próprio registro de operações e desfaz o que ficou pela metade, deixando o banco num estado coerente;
- **b)** mantém o primeiro passo aplicado, já que ele foi concluído com sucesso;
- **c)** exige que o administrador refaça manualmente a operação interrompida;
- **d)** aplica automaticamente o segundo passo, completando a operação.

↩︎ *Aula 01, seção 5 — Recuperação: o que acontece quando falta luz*

---

### Q-A01-06

Em qual situação um arquivo simples é a escolha **mais adequada** que um SGBD?

- **a)** Controle de estoque de uma loja com três funcionários simultâneos;
- **b)** cadastro de pacientes de uma clínica, consultado todos os dias;
- **c)** um arquivo de configuração lido inteiro na inicialização do programa, sem consultas;
- **d)** sistema de reservas de um hotel com 40 quartos.

↩︎ *Aula 01, seção 6 — Quando **não** usar um SGBD*

---

### Q-A01-07

Qual é a diferença entre o erro de um DBA e o erro de um projetista de dados?

- **a)** O erro do DBA é sempre mais grave, porque derruba o servidor;
- **b)** não há diferença prática: os dois aparecem no mesmo prazo;
- **c)** o erro do projetista é detectado pelo SGBD assim que ocorre;
- **d)** o erro do DBA aparece no mesmo dia; o de modelagem aparece anos depois, quando se descobre que a informação necessária nunca foi guardada.

↩︎ *Aula 01, seção 7 — Quem é quem*

---

### Q-A01-08

Na tabela da seção 1, a mesma pessoa aparece com o curso escrito "Sistemas de Informação" numa linha e "Sistemas de Informacao" noutra. Qual pecado isso ilustra, e por que ele é consequência de outro?

- **a)** Dependência programa-dado, consequência da falta de tipagem;
- **b)** inconsistência, consequência inevitável da redundância — duas cópias só ficam iguais enquanto todos lembram de atualizar as duas;
- **c)** isolamento dos dados, consequência de as informações estarem em planilhas separadas;
- **d)** redundância, consequência da inconsistência.

↩︎ *Aula 01, seção 2 — Os quatro pecados do arquivo solto*

---

⬅️ [Voltar à Aula 01](../README.md) | ➡️ [Revisão da Aula 02](../../aula-02-arquitetura-independencia/revisao/README.md)
