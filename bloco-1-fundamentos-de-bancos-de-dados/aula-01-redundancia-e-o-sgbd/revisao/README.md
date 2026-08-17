# Aula 01 — Revisão: Múltipla Escolha

> 🎯 8 questões sobre a [Aula 01 — A Redundância e a Resposta do SGBD](../README.md). Só uma alternativa está correta em cada uma.

**Sem gabarito, de propósito.** Cada questão termina com a seção da aula onde a resposta está. Responda **tudo primeiro**, sem consultar — só depois volte às seções indicadas e corrija.

📝 **As respostas vão pelo formulário:** [responder a revisão da Aula 01](https://docs.google.com/forms/d/e/1FAIpQLSeSfrJIQsOkjSccqwXQFNXzpfSsAx3sJ04jaVQMXiFXPGUVXA/viewform)

Leia as 8 questões aqui e decida suas respostas antes de abrir o formulário: é **uma resposta por aluno**, com conta Google, e não dá para editar depois de enviar. Ele também pede seu usuário do GitHub. Se o seu nome não estiver na lista da turma, marque a última opção e escreva o nome completo no campo seguinte.

As três últimas são marcadas **[ENADE]**: trazem um **texto-base** com uma situação concreta, seguido do comando. São mais longas de ler e cobram interpretação, não memória — as alternativas continuam simples, como nas demais.

---

### Q-A01-01

Na planilha da biblioteca, a matrícula `2023101` aparece em três linhas, e o nome "Ana Souza" também. Sobre essas duas repetições:

- **a)** as duas são redundância, porque em ambos os casos um mesmo valor se repete;
- **b)** nenhuma das duas é redundância, porque a planilha continua funcionando normalmente;
- **c)** só o nome é redundância; a matrícula repetida é referência a três empréstimos diferentes;
- **d)** só a matrícula é redundância, porque é ela que identifica o aluno.

↩︎ *Aula 01, seção 2 — Redundância: o dado escrito duas vezes*

---

### Q-A01-02

A biblioteca comprou um livro novo, que ainda não foi emprestado por ninguém. Na planilha da seção 1 não existe onde registrar o título dele sem inventar um empréstimo que não aconteceu. Esse problema chama-se:

- **a)** anomalia de inserção;
- **b)** anomalia de exclusão;
- **c)** anomalia de alteração;
- **d)** violação de integridade.

↩︎ *Aula 01, seção 3 — As três anomalias*

---

### Q-A01-03

Uma pasta no computador guarda 200 fotos de viagem e 30 boletos em PDF. Segundo a definição vista na aula, essa pasta não é um banco de dados porque:

- **a)** os arquivos não estão organizados em formato de tabela;
- **b)** não há um SGBD instalado naquela máquina;
- **c)** o volume de dados é pequeno demais para justificar o nome;
- **d)** os dados não são relacionados entre si nem representam um recorte do mundo com significado.

↩︎ *Aula 01, seção 4 — O que é um banco de dados*

---

### Q-A01-04

Um técnico anuncia: "instalei o PostgreSQL no servidor da biblioteca". O que exatamente foi instalado?

- **a)** um banco de dados;
- **b)** um SGBD;
- **c)** a aplicação de controle de empréstimos da biblioteca;
- **d)** um banco de dados e a aplicação que o consulta.

↩︎ *Aula 01, seção 5 — O que é um SGBD*

---

### Q-A01-05

Dois atendentes registram, no mesmo instante, o empréstimo do último exemplar disponível de uma obra. Os dois registros são gravados, e o sistema passa a afirmar que o mesmo exemplar está com duas pessoas. Qual das garantias vistas na aula falhou?

- **a)** integridade;
- **b)** segurança;
- **c)** acesso concorrente;
- **d)** recuperação.

↩︎ *Aula 01, seção 6 — Para que serve: as quatro garantias*

---

### Q-A01-06

**[ENADE]**

A biblioteca de uma faculdade controla os empréstimos em uma planilha, com uma linha por empréstimo. Em cada linha são registrados o número do empréstimo, a matrícula e o nome do aluno, o tombo e o título do livro, e a data de retirada.

Após alguns meses de uso, a coordenação percebeu que a mesma matrícula aparecia associada ora a "Ana Souza", ora a "Ana Sousa". Ao investigar, verificou-se que um atendente havia digitado o sobrenome de forma diferente em um dos registros, e que não havia como o sistema saber qual das duas grafias era a correta.

Considerando a situação descrita, a causa-raiz do problema é:

- **a)** o erro de digitação do atendente, que deveria ter conferido o cadastro antes de salvar a linha;
- **b)** o fato de o nome do aluno ser armazenado em toda linha de empréstimo, em vez de existir em um único lugar;
- **c)** a ausência de um SGBD, que teria recusado automaticamente o nome escrito de forma divergente;
- **d)** o uso da matrícula como identificador do aluno, quando o correto seria utilizar o CPF.

↩︎ *Aula 01, seção 2 — Redundância: o dado escrito duas vezes*

---

### Q-A01-07

**[ENADE]**

A biblioteca trocou a planilha por um banco de dados com SGBD. A equipe de desenvolvimento criou uma tabela de empréstimos com as mesmas colunas da planilha antiga — número do empréstimo, matrícula e nome do aluno, tombo e título do livro, data de retirada — e migrou para dentro dela os quatro mil registros existentes.

Seis meses depois, a coordenação encontrou de novo a mesma matrícula associada a duas grafias diferentes do nome do aluno, desta vez em empréstimos registrados já no sistema novo. O SGBD estava em produção, sem nenhuma falha registrada, e havia aceitado todas as gravações sem apontar erro.

Considerando a situação descrita, a contradição voltou a aparecer porque:

- **a)** o SGBD obedece ao modelo que lhe foi dado, e o modelo migrado manteve o nome do aluno repetido em cada empréstimo;
- **b)** a migração dos quatro mil registros foi feita sem que o SGBD verificasse os dados que já vinham errados da planilha;
- **c)** faltou declarar uma regra de integridade proibindo que a coluna do nome do aluno recebesse duas grafias distintas;
- **d)** o SGBD só elimina a redundância depois que as tabelas passam pelo processo de normalização, ainda não executado.

↩︎ *Aula 01, seção 7 — O que o SGBD não resolve sozinho*

---

### Q-A01-08

**[ENADE]**

A direção de uma faculdade avalia trocar a planilha de empréstimos da biblioteca por um banco de dados com SGBD. O responsável de TI defendeu a proposta com um único argumento: as consultas ao acervo passariam a responder mais rápido, porque o SGBD é um programa otimizado e a planilha não é.

Uma das bibliotecárias então observou que, na semana anterior, dois atendentes haviam registrado ao mesmo tempo a saída do último exemplar de uma obra, e que a planilha aceitou os dois registros sem qualquer aviso.

Considerando a situação descrita, a observação da bibliotecária é pertinente porque:

- **a)** demonstra que o ganho de desempenho prometido pelo responsável de TI só se confirma quando há poucos usuários simultâneos;
- **b)** mostra que a planilha precisa ser substituída por um SGBD capaz de bloquear o arquivo enquanto um dos atendentes o mantiver aberto;
- **c)** revela uma falha de integridade, já que a planilha aceitou um dado que violava a regra de haver um só exemplar disponível;
- **d)** aponta um problema de acesso concorrente, que está entre as garantias de um SGBD — ao contrário do desempenho, que não está.

↩︎ *Aula 01, seção 6 — Para que serve: as quatro garantias*

---

⬅️ [Voltar à Aula 01](../README.md) | 🏠 [Início](../../../README.md)
