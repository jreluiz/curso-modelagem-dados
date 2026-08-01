# Aula 16 — Revisão: Múltipla Escolha

> 🎯 8 questões sobre a [Aula 16 — Revisão e Próximos Passos](../README.md). Só uma alternativa está correta em cada uma.

**Sem gabarito, de propósito.** Cada questão termina com a seção da aula onde a resposta está. Responda **tudo primeiro**, sem consultar — só depois volte às seções indicadas e corrija.

---

### Q-A16-01

Os Blocos 1 e 2 ocupam metade do curso e não tocam num computador. Qual é a justificativa dada?

- **a)** Que a instalação do PostgreSQL costuma atrasar o início das aulas;
- **b)** que modelagem é assunto teórico e SQL é assunto prático, e os dois não se misturam;
- **c)** que os alunos precisam de tempo para conseguir uma máquina adequada;
- **d)** que as decisões que custam caro são tomadas antes de existir uma linha de SQL, e nenhum banco conserta um modelo errado.

↩︎ *Aula 16, seção 1 — O mapa do curso*

---

### Q-A16-02

"A ordem das linhas não significa nada" atravessou o curso inteiro. Em que ela virou, na prática?

- **a)** No `DISTINCT`, que elimina repetições;
- **b)** no `ORDER BY`: se você quer ordem, precisa pedi-la;
- **c)** na chave primária, que fixa a posição de cada linha;
- **d)** no `LIMIT`, que corta o resultado.

↩︎ *Aula 16, seção 1 — O mapa do curso*

---

### Q-A16-03

Segundo o roteiro de nove passos, como se sabe que o passo "desenhar o DER" deu certo?

- **a)** Toda linha lida em voz alta é verdade;
- **b)** o diagrama tem no mínimo cinco entidades;
- **c)** o desenho cabe numa página;
- **d)** todas as entidades têm chave artificial.

↩︎ *Aula 16, seção 2 — Do minimundo ao banco, o caminho inteiro*

---

### Q-A16-04

Por que álgebra relacional, BCNF e projeto físico ficaram de fora do curso?

- **a)** Porque são assuntos obsoletos, substituídos por técnicas modernas;
- **b)** porque exigem software proprietário que a turma não tem;
- **c)** porque o curso tem dezesseis aulas e escolheu profundidade em uma metade em vez de superfície nas duas;
- **d)** porque não têm aplicação prática fora da pesquisa acadêmica.

↩︎ *Aula 16, seção 3 — O que ficou de fora, e por quê*

---

### Q-A16-05

No exemplo do empréstimo guardado como documento, o nome da Ana aparece dentro de cada empréstimo dela. Como a aula classifica isso?

- **a)** Como um erro de modelagem que o MongoDB corrige automaticamente;
- **b)** como uma otimização que elimina a necessidade de normalizar;
- **c)** como a redundância da Aula 01 de volta, agora por escolha — e quando ela mudar de nome, alguém terá que percorrer todos os documentos;
- **d)** como uma consequência inevitável de qualquer banco não relacional.

↩︎ *Aula 16, seção 4 — NoSQL, em duas páginas*

---

### Q-A16-06

Por que a afirmação "NoSQL não tem esquema" é falsa?

- **a)** Porque o esquema existe: ele saiu do banco e entrou no código, espalhado por todo lugar que lê aquele documento;
- **b)** porque os bancos de documento exigem a declaração prévia dos campos;
- **c)** porque o esquema é gerado automaticamente a partir do primeiro documento inserido;
- **d)** porque só os bancos de grafo dispensam esquema.

↩︎ *Aula 16, seção 4 — NoSQL, em duas páginas*

---

### Q-A16-07

Como o descompasso objeto-relacional costuma se manifestar na prática?

- **a)** Como erros de compilação ao mapear classes em tabelas;
- **b)** como uma consulta que faz 500 idas ao banco onde bastaria uma;
- **c)** como perda de dados na gravação de objetos aninhados;
- **d)** como incompatibilidade entre o ORM e a versão do SGBD.

↩︎ *Aula 16, seção 5 — ORM e o descompasso*

---

### Q-A16-08

Qual capítulo do livro-base a aula recomenda, se você só for ler um a mais?

- **a)** O de álgebra relacional, porque explica de onde veio o `JOIN`;
- **b)** o de projeto físico, porque é o que resolve problemas de desempenho;
- **c)** o de modelagem conceitual, por causa da especialização;
- **d)** o de normalização além da 3FN, porque é curto e fecha o assunto que o curso deixou pela metade de propósito.

↩︎ *Aula 16, seção 6 — Para onde ir*

---

⬅️ [Voltar à Aula 16](../README.md) | 🏠 [Início do curso](../../../README.md)
