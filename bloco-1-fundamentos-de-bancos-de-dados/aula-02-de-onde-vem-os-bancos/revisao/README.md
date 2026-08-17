# Aula 02 — Revisão: Múltipla Escolha

> 🎯 8 questões sobre a [Aula 02 — De Onde Vêm os Bancos de Dados](../README.md). Só uma alternativa está correta em cada uma.

**Sem gabarito, de propósito.** Cada questão termina com a seção da aula onde a resposta está. Responda **tudo primeiro**, sem consultar — só depois volte às seções indicadas e corrija.

📝 **As respostas vão pelo formulário:** [responder a revisão da Aula 02](https://docs.google.com/forms/d/e/1FAIpQLSdJJwys9vPqt4fYh3bVB5jw2aqlRvzgpMS_2YnXg_3cNrgiEA/viewform)

Leia as 8 questões aqui e decida suas respostas antes de abrir o formulário: é **uma resposta por aluno**, com conta Google, e não dá para editar depois de enviar. Ele também pede seu usuário do GitHub. Se o seu nome não estiver na lista da turma, marque a última opção e escreva o nome completo no campo seguinte.

As três últimas são marcadas **[ENADE]**: trazem um **texto-base** com uma situação concreta, seguido do comando. São mais longas de ler e cobram interpretação, não memória — as alternativas continuam simples, como nas demais.

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

- **a)** a dependência de formato, que impediu a secretaria de acrescentar campos ao arquivo;
- **b)** a falta de controle de simultaneidade entre os três sistemas no momento da gravação;
- **c)** a redundância entre sistemas, com o mesmo dado mantido em vários arquivos independentes;
- **d)** a ausência de autenticação, que permitiu alterações não identificadas no cadastro.

↩︎ *Aula 02, seção 1 — Antes do banco: o programa que sabia tudo*

---

### Q-A02-07

**[ENADE]**

Uma equipe vai construir o sistema acadêmico de uma faculdade: matrícula, histórico escolar, lançamento de notas e emissão de documentos. Na reunião de definição da arquitetura, um dos desenvolvedores propôs adotar um banco NoSQL de documentos, com o argumento de que o modelo relacional "é dos anos 1970 e já foi superado".

O coordenador da equipe observou que o sistema terá algumas dezenas de usuários simultâneos, dados fortemente relacionados entre si e regras que não podem ser violadas em hipótese alguma — como um aluno não poder ter duas matrículas ativas no mesmo curso.

Considerando a situação descrita, a proposta do desenvolvedor deve ser recusada porque:

- **a)** o NoSQL não substituiu o relacional: ele abre mão de parte das garantias para distribuir dados em muitas máquinas, e não é esse o problema deste sistema;
- **b)** bancos NoSQL não são capazes de armazenar o volume de dados que um sistema acadêmico acumula ao longo de vários anos;
- **c)** o modelo relacional é mais rápido que o NoSQL em qualquer cenário, e o desempenho é o critério que decide a escolha;
- **d)** bancos NoSQL não possuem política de segurança, o que impediria a faculdade de atender às exigências da LGPD.

↩︎ *Aula 02, seção 4 — Depois do relacional*

---

### Q-A02-08

**[ENADE]**

Numa biblioteca, um atendente devidamente cadastrado entrou no sistema com usuário e senha e apagou seis meses de histórico de empréstimos. A operação foi concluída sem erro algum. No dia seguinte, ao investigar o sumiço dos registros, a coordenação consultou o log do sistema e descobriu, em poucos minutos, qual conta havia executado a exclusão e em que horário.

Na reunião seguinte, o responsável pelo sistema afirmou que a política de segurança do banco havia funcionado, uma vez que foi possível identificar quem executou a operação.

Considerando a situação descrita, a afirmação do responsável:

- **a)** procede, porque identificar o autor de uma operação indevida é a finalidade da política de segurança de um banco de dados;
- **b)** não procede, porque a auditoria registra o que aconteceu mas não impede nada — o que falhou foi a autorização, que deveria ter recusado a exclusão;
- **c)** não procede, porque o atendente conseguiu entrar no sistema com credenciais válidas, o que caracteriza uma falha de autenticação;
- **d)** procede, desde que a coordenação restaure o histórico a partir da cópia de segurança mais recente, o que desfaz o efeito da exclusão.

↩︎ *Aula 02, seção 6 — Política de segurança de um banco de dados*

---

⬅️ [Voltar à Aula 02](../README.md) | 🏠 [Início](../../../README.md)
