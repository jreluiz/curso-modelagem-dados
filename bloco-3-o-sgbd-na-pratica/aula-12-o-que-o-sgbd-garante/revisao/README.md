# Aula 12 — Revisão: Múltipla Escolha

> 🎯 8 questões sobre a [Aula 12 — O Que o SGBD Garante](../README.md). Só uma alternativa está correta em cada uma.

**Sem gabarito, de propósito.** Cada questão termina com a seção da aula onde a resposta está. Responda **tudo primeiro**, sem consultar — só depois volte às seções indicadas e corrija.

---

### Q-A12-01

O que as outras pessoas enxergam entre o `BEGIN` e o `COMMIT` de uma transação sua?

- **a)** Cada comando assim que ele é executado, um a um;
- **b)** o resultado parcial, marcado como provisório;
- **c)** uma mensagem avisando que a tabela está em uso;
- **d)** nada: os dois passos passam a existir juntos, para todo mundo, no momento do `COMMIT`.

↩︎ *Aula 12, seção 1 — Duas operações que precisam acontecer juntas*

---

### Q-A12-02

Numa transação com dois `UPDATE`, o primeiro está correto e o segundo viola um `CHECK`. O que acontece com o primeiro?

- **a)** É desfeito junto: a transação é indivisível inclusive no fracasso;
- **b)** permanece gravado, porque estava correto;
- **c)** permanece gravado, mas marcado como pendente até nova confirmação;
- **d)** é reexecutado automaticamente depois que o segundo for corrigido.

↩︎ *Aula 12, seção 2 — `COMMIT` e `ROLLBACK`*

---

### Q-A12-03

Uma transação tenta gravar uma situação que não está entre os valores permitidos e é recusada. Qual letra do ACID agiu?

- **a)** Atomicidade;
- **b)** consistência: a transação precisa levar o banco de um estado válido a outro estado válido;
- **c)** isolamento;
- **d)** durabilidade.

↩︎ *Aula 12, seção 3 — ACID, em linguagem direta*

---

### Q-A12-04

O `COMMIT` respondeu "ok", faltou luz um segundo depois e, ao religar, o dado não estava lá. Que garantia falhou?

- **a)** Atomicidade, porque a transação ficou pela metade;
- **b)** consistência, porque o banco ficou num estado inválido;
- **c)** durabilidade: depois do `COMMIT`, o dado precisa sobreviver à queda;
- **d)** isolamento, porque outra transação apagou o dado.

↩︎ *Aula 12, seção 3 — ACID, em linguagem direta*

---

### Q-A12-05

Por que o isolamento "custa"?

- **a)** Porque exige licença paga na maioria dos SGBDs;
- **b)** porque consome espaço em disco proporcional ao número de transações;
- **c)** porque enquanto uma transação escreve, a outra espera — e quanto mais rígido o nível, mais gente esperando;
- **d)** porque obriga a reescrever as consultas com sintaxe especial.

↩︎ *Aula 12, seção 4 — Duas pessoas ao mesmo tempo*

---

### Q-A12-06

Do que o nível `READ COMMITTED`, padrão do PostgreSQL, **não** protege?

- **a)** De ler dados de uma transação ainda não confirmada;
- **b)** de dois processos decidirem a mesma coisa a partir da mesma leitura, que é a atualização perdida;
- **c)** de uma transação ficar pela metade após uma queda de energia;
- **d)** de um `INSERT` que viola chave estrangeira.

↩︎ *Aula 12, seção 4 — Duas pessoas ao mesmo tempo*

---

### Q-A12-07

Qual é a regra do curso sobre concessão de permissões?

- **a)** Conceder o mínimo necessário, e conceder por papel, não por pessoa;
- **b)** conceder tudo a todos e auditar depois quem usou o quê;
- **c)** criar uma identidade por tabela do banco;
- **d)** usar sempre o usuário administrador, e controlar o acesso na aplicação.

↩︎ *Aula 12, seção 5 — Usuários e permissões*

---

### Q-A12-08

Por que a aula diz que "backup que nunca foi restaurado não é backup — é esperança"?

- **a)** Porque o `pg_dump` gera arquivos que expiram depois de trinta dias;
- **b)** porque só a restauração converte o arquivo de texto em formato binário;
- **c)** porque backups precisam ser feitos em duplicata para serem confiáveis;
- **d)** porque a única forma de saber que o arquivo presta é restaurá-lo num banco vazio e conferir.

↩︎ *Aula 12, seção 6 — Backup e restauração*

---

⬅️ [Voltar à Aula 12](../README.md) | ➡️ [Revisão da Aula 13](../../../bloco-4-sql-basico/aula-13-sql-ddl/revisao/README.md)
