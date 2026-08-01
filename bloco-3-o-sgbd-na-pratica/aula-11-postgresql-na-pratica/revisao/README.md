# Aula 11 — Revisão: Múltipla Escolha

> 🎯 8 questões sobre a [Aula 11 — PostgreSQL na Prática](../README.md). Só uma alternativa está correta em cada uma.

**Sem gabarito, de propósito.** Cada questão termina com a seção da aula onde a resposta está. Responda **tudo primeiro**, sem consultar — só depois volte às seções indicadas e corrija.

---

### Q-A11-01

Por que existe porta, usuário e senha para um PostgreSQL instalado no seu próprio computador?

- **a)** Porque servidor e cliente são programas diferentes que conversam por rede, mesmo na mesma máquina — e é essa separação que permite, amanhã, conectar num banco em outro continente;
- **b)** porque o PostgreSQL exige conexão com a internet para validar a licença;
- **c)** porque o `psql` guarda os dados num servidor remoto da comunidade;
- **d)** porque cada banco criado no servidor ocupa uma porta diferente.

↩︎ *Aula 11, seção 1 — O que você vai instalar*

---

### Q-A11-02

O que a opção `-v ON_ERROR_STOP=1` faz, e por que o curso pede que ela vire hábito?

- **a)** Mostra o erro em vermelho, facilitando a leitura da saída;
- **b)** grava um arquivo de log com todos os erros do script;
- **c)** ignora os erros e continua, para que o script rode até o fim;
- **d)** faz o `psql` parar no primeiro erro, em vez de rodar as outras 200 linhas em cima de um banco meio construído.

↩︎ *Aula 11, seção 2 — Criar o banco do curso*

---

### Q-A11-03

Qual é a diferença entre `\dt` e `\d livro`?

- **a)** `\dt` lista os bancos do servidor e `\d livro` lista as tabelas de um deles;
- **b)** os dois fazem a mesma coisa, e `\d` é apenas a forma abreviada;
- **c)** `\dt` lista as tabelas do banco atual e `\d livro` mostra a estrutura de uma tabela específica;
- **d)** `\dt` é um comando SQL enviado ao servidor e `\d livro` é um atalho do cliente.

↩︎ *Aula 11, seção 3 — `psql`: os comandos que valem decorar*

---

### Q-A11-04

O *prompt* virou `curso_bd-#` no meio do seu trabalho. O que aconteceu?

- **a)** A conexão com o servidor caiu e o `psql` entrou em modo desconectado;
- **b)** faltou o ponto e vírgula: o `psql` está esperando você terminar a frase;
- **c)** você entrou num banco diferente sem perceber;
- **d)** o comando anterior falhou e abriu uma transação com erro.

↩︎ *Aula 11, seção 3 — `psql`: os comandos que valem decorar*

---

### Q-A11-05

Por que as aulas mostram os comandos no `psql` mesmo existindo clientes gráficos?

- **a)** Porque os clientes gráficos não conseguem executar scripts `.sql`;
- **b)** porque o `psql` existe em qualquer servidor, inclusive naquele em que só há um terminal — e porque clicar não ensina a ler mensagem de erro;
- **c)** porque o pgAdmin e o DBeaver não funcionam com PostgreSQL 15;
- **d)** porque comandos digitados são executados mais rápido que os de interface gráfica.

↩︎ *Aula 11, seção 4 — Um cliente gráfico, se quiser*

---

### Q-A11-06

Na saída de `\d livro`, a linha `Referenced by` mostra o quê?

- **a)** As colunas da tabela que são chaves estrangeiras para outras tabelas;
- **b)** os índices criados automaticamente pelo PostgreSQL;
- **c)** as tabelas que apontam para esta — a chave estrangeira vista do outro lado;
- **d)** as restrições de domínio herdadas do tipo de cada coluna.

↩︎ *Aula 11, seção 5 — O catálogo por dentro*

---

### Q-A11-07

Por que valor monetário nunca deve ser `REAL` ou `FLOAT`?

- **a)** Porque esses tipos não aceitam casas decimais;
- **b)** porque eles ocupam mais espaço em disco que `NUMERIC`;
- **c)** porque o PostgreSQL os converte automaticamente para texto;
- **d)** porque eles guardam aproximações, e somar mil aproximações produz centavos que não existem.

↩︎ *Aula 11, seção 6 — Os tipos que você vai usar*

---

### Q-A11-08

Quando usar `VARCHAR(n)` em vez de `TEXT`, no PostgreSQL?

- **a)** Quando o limite significar alguma coisa no mundo real, como os 17 caracteres de um ISBN — o `n` é restrição de domínio, não otimização;
- **b)** sempre, porque `VARCHAR(n)` é mais rápido que `TEXT`;
- **c)** apenas em colunas que fazem parte da chave primária;
- **d)** nunca: `VARCHAR(n)` só existe por compatibilidade com bancos antigos.

↩︎ *Aula 11, seção 6 — Os tipos que você vai usar*

---

⬅️ [Voltar à Aula 11](../README.md) | ➡️ [Revisão da Aula 12](../../aula-12-o-que-o-sgbd-garante/revisao/README.md)
