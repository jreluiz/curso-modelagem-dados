# Aula 01 — Revisão: Múltipla Escolha

> 🎯 8 questões sobre a [Aula 01 — Da Planilha à Tabela](../README.md). Só uma alternativa está correta em cada uma.

**Sem gabarito, de propósito.** Cada questão termina com a seção da aula onde a resposta está. Responda **tudo primeiro**, sem consultar — só depois volte às seções indicadas e corrija.

---

### Q-A01-01

Na planilha de empréstimos, o nome "Ana Souza" aparece em três linhas e numa delas está escrito "Ana Sousa". Qual é a **causa** desse problema?

- **a)** Falta de atenção de quem digitou, que se resolve com treinamento da equipe;
- **b)** o volume de dados, que ficou grande demais para uma planilha;
- **c)** o dado está escrito em mais de um lugar, e cópias só ficam iguais enquanto alguém lembra de atualizar todas;
- **d)** a ausência de uma coluna de identificação única na planilha.

↩︎ *Aula 01, seção 1 — A planilha que não aguenta mais*

---

### Q-A01-02

Chegou um livro novo na biblioteca e ele ainda não foi emprestado por ninguém. Na planilha única, **não há onde cadastrá-lo** sem inventar um empréstimo falso. Que anomalia é essa?

- **a)** Anomalia de inserção;
- **b)** anomalia de alteração;
- **c)** anomalia de exclusão;
- **d)** anomalia de redundância.

↩︎ *Aula 01, seção 2 — As três anomalias*

---

### Q-A01-03

A relação `EXEMPLAR(tombo, isbn, data_aquisicao, situacao)` tem 40 linhas hoje. O **grau** e a **cardinalidade** são, respectivamente:

- **a)** 40 e 4;
- **b)** 40 e 40;
- **c)** 4 e 4;
- **d)** 4 e 40.

↩︎ *Aula 01, seção 5 — Grau e cardinalidade: as duas contagens*

---

### Q-A01-04

Por que se diz que **não existe "a primeira linha"** de uma tabela?

- **a)** Porque o banco embaralha as linhas de propósito, por segurança;
- **b)** porque uma relação é formalmente um conjunto, e conjuntos não têm ordem entre seus elementos;
- **c)** porque a primeira linha é sempre reservada para os nomes das colunas;
- **d)** porque a ordem depende do programa usado para consultar o banco.

↩︎ *Aula 01, seção 4 — O vocabulário do modelo relacional*

---

### Q-A01-05

A biblioteca cadastra um aluno novo. O que muda na relação `ALUNO`?

- **a)** O grau aumenta em 1;
- **b)** a cardinalidade aumenta em 1;
- **c)** os dois aumentam em 1;
- **d)** nenhum dos dois muda, porque ambos descrevem o esquema.

↩︎ *Aula 01, seção 5 — Grau e cardinalidade: as duas contagens*

---

### Q-A01-06

Qual das afirmações abaixo descreve o **esquema**, e não a instância?

- **a)** Existem 4.317 obras cadastradas hoje;
- **b)** a obra de ISBN 978-85-1111-111-1 chama-se *Fundamentos de Bancos de Dados*;
- **c)** doze empréstimos estão em atraso nesta manhã;
- **d)** a tabela `OBRA` tem uma coluna `ano_publicacao` do tipo inteiro.

↩︎ *Aula 01, seção 6 — Como se escreve um esquema*

---

### Q-A01-07

Ao apagar o empréstimo 1004 da planilha única, some junto a única menção ao livro 4420, que continua existindo na prateleira. Que anomalia é essa?

- **a)** Anomalia de exclusão;
- **b)** anomalia de inserção;
- **c)** anomalia de alteração;
- **d)** violação de integridade referencial.

↩︎ *Aula 01, seção 2 — As três anomalias*

---

### Q-A01-08

Depois de separar a planilha em `ALUNO`, `LIVRO` e `EMPRESTIMO`, o que a coluna `matricula` passa a significar dentro de `EMPRESTIMO`?

- **a)** Uma cópia de segurança do dado, para o caso de a tabela `ALUNO` ser apagada;
- **b)** o número da linha da tabela `ALUNO` onde o aluno está guardado;
- **c)** uma referência: um valor que aponta para uma linha de outra tabela;
- **d)** um atributo próprio do empréstimo, sem relação com a tabela `ALUNO`.

↩︎ *Aula 01, seção 3 — Uma tabela por assunto*

---

⬅️ [Voltar à Aula 01](../README.md) | ➡️ [Revisão da Aula 02](../../aula-02-chaves/revisao/README.md)
