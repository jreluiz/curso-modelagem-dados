# Aula 11 — Revisão: Múltipla Escolha

> 🎯 8 questões sobre a [Aula 11 — Álgebra Relacional](../README.md). Só uma alternativa está correta em cada uma.

**Sem gabarito, de propósito.** Cada questão termina com a seção da aula onde a resposta está. Responda **tudo primeiro**, sem consultar — só depois volte às seções indicadas e corrija.

---

### Q-A11-01

Por que a álgebra relacional é chamada de **fechada**?

- **a)** Porque seu conjunto de operadores não pode ser estendido;
- **b)** porque as consultas são executadas sem acesso ao disco;
- **c)** porque só funciona sobre relações normalizadas;
- **d)** porque toda operação devolve uma relação, então a saída de uma pode ser entrada da outra — é o que permite compor consultas indefinidamente.

↩︎ *Aula 11, seção 1 — Por que estudar isto*

---

### Q-A11-02

Qual é a correspondência correta entre a álgebra e o SQL?

- **a)** `σ` é o `WHERE` e `π` é a lista do `SELECT`;
- **b)** `σ` é a lista do `SELECT` e `π` é o `WHERE`;
- **c)** `σ` é o `JOIN` e `π` é o `GROUP BY`;
- **d)** `σ` é o `ORDER BY` e `π` é o `DISTINCT`.

↩︎ *Aula 11, seção 8 — Montando sequências*

---

### Q-A11-03

Qual é a diferença entre `π tipo (USUARIO)` e `SELECT tipo FROM usuario`?

- **a)** Nenhuma: são exatamente equivalentes;
- **b)** a projeção elimina duplicatas (devolve uma linha por tipo distinto), enquanto o `SELECT` devolve uma linha por usuário — para igualar é preciso `SELECT DISTINCT`;
- **c)** a projeção devolve as linhas ordenadas, e o `SELECT` não;
- **d)** a projeção só funciona sobre atributos-chave.

↩︎ *Aula 11, seção 3 — Projeção (π)*

---

### Q-A11-04

Por que `π nome (σ tipo = 'professor' (USUARIO))` é preferível à ordem inversa?

- **a)** Porque a projeção não pode ser aplicada antes de uma seleção, por regra da álgebra;
- **b)** porque o resultado seria diferente nas duas ordens;
- **c)** porque selecionar antes descarta linhas cedo, e tudo que vem depois trabalha sobre menos dados — o *pushdown* que todo otimizador aplica;
- **d)** porque a projeção exige que a relação esteja ordenada.

↩︎ *Aula 11, seção 3 — Projeção (π)*

---

### Q-A11-05

Para escrever `π matricula (USUARIO) − π matricula (EMPRESTIMO)`, o que precisa ser verdade?

- **a)** As duas relações precisam ter chave primária declarada;
- **b)** as duas expressões precisam ter compatibilidade de união: mesmo número de atributos, na mesma ordem, com domínios compatíveis;
- **c)** as duas relações precisam ter a mesma quantidade de tuplas;
- **d)** é preciso que exista uma chave estrangeira entre elas.

↩︎ *Aula 11, seção 5 — Operações de conjunto*

---

### Q-A11-06

Qual é a armadilha da **junção natural** (`⋈` sem condição explícita)?

- **a)** Ela sempre produz um produto cartesiano quando não há atributos em comum;
- **b)** ela descarta as tuplas da relação da esquerda;
- **c)** ela usa todos os atributos de mesmo nome nas duas relações — se ambas tiverem uma coluna `situacao`, a junção exigirá que as duas sejam iguais, devolvendo quase nada e sem erro;
- **d)** ela só funciona entre relações com o mesmo grau.

↩︎ *Aula 11, seção 6 — Produto cartesiano (×) e junção (⋈)*

---

### Q-A11-07

Um usuário pegou emprestadas **todas** as obras de uma área, e ainda outras três de áreas diferentes. Ele aparece no resultado de `R ÷ S`?

- **a)** Sim: pegar itens a mais não desclassifica — a divisão exige "todos os de S", não "exatamente os de S";
- **b)** não: a divisão exige que o conjunto seja exatamente igual a S;
- **c)** depende da quantidade de obras extras;
- **d)** não, porque a divisão só aceita relações de grau 2.

↩︎ *Aula 11, seção 7 — Divisão (÷)*

---

### Q-A11-08

O que **não** faz parte da álgebra relacional clássica?

- **a)** A junção externa à esquerda;
- **b)** a diferença entre relações;
- **c)** a renomeação;
- **d)** a agregação (`COUNT`, `SUM`), o agrupamento e a ordenação — são extensões que o SQL acrescentou por necessidade prática.

↩︎ *Aula 11, seção 8 — Montando sequências*

---

⬅️ [Voltar à Aula 11](../README.md) | ➡️ [Revisão da Aula 12](../../aula-12-normalizacao/revisao/README.md)
