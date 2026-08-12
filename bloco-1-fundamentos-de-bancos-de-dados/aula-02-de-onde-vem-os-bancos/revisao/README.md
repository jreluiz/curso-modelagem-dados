# Aula 02 — Revisão: Múltipla Escolha

> 🎯 8 questões sobre a [Aula 02 — De Onde Vêm os Bancos de Dados](../README.md). Só uma alternativa está correta em cada uma.

**Sem gabarito, de propósito.** Cada questão termina com a seção da aula onde a resposta está. Responda **tudo primeiro**, sem consultar — só depois volte às seções indicadas e corrija.

As três últimas são marcadas **[ENADE]**: seguem o formato do exame, com cinco alternativas e enunciado mais longo.

---

### Q-A02-01

O modelo hierárquico organiza os dados em árvore, e nele cada registro tem exatamente um pai. Qual das situações abaixo esse modelo **não** representa bem?

- **a)** uma faculdade que tem cursos, e cada curso tem turmas;
- **b)** um aluno matriculado em duas turmas ao mesmo tempo;
- **c)** um livro do acervo que possui vários exemplares físicos;
- **d)** um departamento que se divide em vários setores.

↩︎ *Aula 02, seção 2 — Hierárquico e rede*

---

### Q-A02-02

A principal consequência prática da proposta publicada por Codd em 1970 foi:

- **a)** reduzir o espaço ocupado em disco, por eliminar os ponteiros entre registros;
- **b)** permitir que um mesmo registro tivesse vários pais, o que a árvore não permitia;
- **c)** tornar a busca mais rápida do que era nos modelos hierárquico e de rede;
- **d)** separar o que o programa pede do modo como o dado é efetivamente buscado.

↩︎ *Aula 02, seção 3 — 1970: Codd e o modelo relacional*

---

### Q-A02-03

Nos sistemas de arquivos isolados dos anos 1960, acrescentar um campo ao arquivo de alunos obrigava a reescrever e recompilar todos os programas que liam aquele arquivo. Esse problema chama-se:

- **a)** dependência de formato;
- **b)** redundância entre sistemas;
- **c)** ausência de controle de simultaneidade;
- **d)** falta de política de segurança.

↩︎ *Aula 02, seção 1 — Antes do banco: o programa que sabia tudo*

---

### Q-A02-04

Um aplicativo de celular precisa guardar dados no próprio aparelho e funcionar sem internet, sem depender de nenhum servidor. Entre os SGBD vistos na aula, o adequado é:

- **a)** Oracle Database;
- **b)** PostgreSQL;
- **c)** SQLite;
- **d)** SQL Server.

↩︎ *Aula 02, seção 5 — Os principais SGBD hoje*

---

### Q-A02-05

O atendente da biblioteca entra no sistema com usuário e senha corretos e tenta apagar o histórico de empréstimos, mas o sistema recusa a operação. O que impediu a exclusão foi:

- **a)** a autenticação;
- **b)** a auditoria;
- **c)** a cópia de segurança;
- **d)** a autorização.

↩︎ *Aula 02, seção 6 — Política de segurança de um banco de dados*

---

### Q-A02-06

**[ENADE]**

Uma faculdade mantém três sistemas independentes, cada um com seus próprios arquivos: o de empréstimos da biblioteca, o da secretaria acadêmica e o da tesouraria. Os três guardam dados dos mesmos alunos, entre eles nome, endereço e telefone.

Um aluno mudou de endereço e comunicou a secretaria, que atualizou o cadastro dela. Meses depois, a biblioteca continuava enviando avisos de devolução para o endereço antigo, e a tesouraria emitia cobranças para um terceiro endereço, registrado ainda antes.

Considerando a situação descrita, o problema que ela ilustra é:

- **A)** a ausência de autenticação, que permitiu alterações não identificadas no cadastro;
- **B)** a dependência de formato, que impediu a secretaria de acrescentar campos ao arquivo;
- **C)** a falta de controle de simultaneidade entre os três sistemas no momento da gravação;
- **D)** a redundância entre sistemas, com o mesmo dado mantido em vários arquivos independentes;
- **E)** a ausência de auditoria, que impossibilitou descobrir quem alterou o endereço do aluno.

↩︎ *Aula 02, seção 1 — Antes do banco: o programa que sabia tudo*

---

### Q-A02-07

**[ENADE]**

Avalie as asserções a seguir e a relação proposta entre elas.

I. O modelo relacional continua sendo o mais utilizado em sistemas corporativos.

PORQUE

II. Os bancos NoSQL surgiram para substituir o modelo relacional, que não é capaz de armazenar grandes volumes de dados.

A respeito dessas asserções, assinale a opção correta.

- **A)** As asserções I e II são proposições verdadeiras, e a II é uma justificativa correta da I;
- **B)** As asserções I e II são proposições verdadeiras, mas a II não é uma justificativa correta da I;
- **C)** A asserção I é uma proposição verdadeira, e a II é uma proposição falsa;
- **D)** A asserção I é uma proposição falsa, e a II é uma proposição verdadeira;
- **E)** As asserções I e II são proposições falsas.

↩︎ *Aula 02, seção 4 — Depois do relacional*

---

### Q-A02-08

**[ENADE]**

A respeito dos pilares de uma política de segurança de banco de dados, avalie as afirmações a seguir.

I. A autenticação verifica se o usuário é quem diz ser, e ocorre uma vez, na entrada do sistema.

II. A autorização verifica, a cada operação, se aquele usuário tem permissão para realizá-la.

III. A auditoria impede que operações indevidas sejam realizadas sobre os dados.

É correto apenas o que se afirma em:

- **A)** I e II;
- **B)** I e III;
- **C)** II e III;
- **D)** I, II e III;
- **E)** II.

↩︎ *Aula 02, seção 6 — Política de segurança de um banco de dados*

---

⬅️ [Voltar à Aula 02](../README.md) | 🏠 [Início](../../../README.md)
