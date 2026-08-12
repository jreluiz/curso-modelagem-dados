# Aula 01 — Revisão: Múltipla Escolha

> 🎯 8 questões sobre a [Aula 01 — A Redundância e a Resposta do SGBD](../README.md). Só uma alternativa está correta em cada uma.

**Sem gabarito, de propósito.** Cada questão termina com a seção da aula onde a resposta está. Responda **tudo primeiro**, sem consultar — só depois volte às seções indicadas e corrija.

As três últimas são marcadas **[ENADE]**: seguem o formato do exame, com cinco alternativas e enunciado mais longo. Leia com calma, que é assim que elas aparecem lá.

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

- **A)** o erro de digitação do atendente, que deveria ter conferido o cadastro antes de salvar a linha;
- **B)** o fato de o nome do aluno ser armazenado em toda linha de empréstimo, em vez de existir em um único lugar;
- **C)** a ausência de um SGBD, que teria recusado automaticamente o nome escrito de forma divergente;
- **D)** o uso da matrícula como identificador do aluno, quando o correto seria utilizar o CPF;
- **E)** o tamanho da planilha, que ultrapassou o volume em que uma pessoa consegue conferir os dados manualmente.

↩︎ *Aula 01, seção 2 — Redundância: o dado escrito duas vezes*

---

### Q-A01-07

**[ENADE]**

Avalie as asserções a seguir e a relação proposta entre elas.

I. Adotar um SGBD elimina a redundância de dados de um sistema.

PORQUE

II. Em um SGBD, cada dado é necessariamente armazenado uma única vez.

A respeito dessas asserções, assinale a opção correta.

- **A)** As asserções I e II são proposições verdadeiras, e a II é uma justificativa correta da I;
- **B)** As asserções I e II são proposições verdadeiras, mas a II não é uma justificativa correta da I;
- **C)** A asserção I é uma proposição verdadeira, e a II é uma proposição falsa;
- **D)** A asserção I é uma proposição falsa, e a II é uma proposição verdadeira;
- **E)** As asserções I e II são proposições falsas.

↩︎ *Aula 01, seção 7 — O que o SGBD não resolve sozinho*

---

### Q-A01-08

**[ENADE]**

A respeito das finalidades de um banco de dados e de um SGBD, avalie as afirmações a seguir.

I. O SGBD é a única via de acesso aos dados, e é justamente isso que torna possível verificar regras e controlar acessos simultâneos.

II. Um banco de dados serve a vários usuários e a vários programas, e não apenas ao sistema que o criou.

III. O principal objetivo de se adotar um SGBD é aumentar a velocidade de acesso aos dados.

É correto apenas o que se afirma em:

- **A)** I;
- **B)** II;
- **C)** I e II;
- **D)** I e III;
- **E)** II e III.

↩︎ *Aula 01, seção 6 — Para que serve: as quatro garantias*

---

⬅️ [Voltar à Aula 01](../README.md) | 🏠 [Início](../../../README.md)
