# Aula 10 — Revisão: Múltipla Escolha

> 🎯 8 questões sobre a [Aula 10 — Arquitetura e Independência de Dados](../README.md). Só uma alternativa está correta em cada uma.

**Sem gabarito, de propósito.** Cada questão termina com a seção da aula onde a resposta está. Responda **tudo primeiro**, sem consultar — só depois volte às seções indicadas e corrija.

---

### Q-A10-01

Qual das afirmações abaixo descreve o **esquema**, e não a instância?

- **a)** Existem 4.317 obras cadastradas;
- **b)** hoje há 12 empréstimos em atraso;
- **c)** nenhuma obra pode ter ISBN repetido;
- **d)** a obra 978-85-1234-567-8 chama-se *Fundamentos de Bancos de Dados*.

↩︎ *Aula 10, seção 1 — Esquema × instância, e por que a diferença é cara*

---

### Q-A10-02

Por que um erro de esquema é incomparavelmente mais caro que um erro de instância?

- **a)** Porque o banco não permite corrigir esquemas depois de criados;
- **b)** porque corrigi-lo exige migrar os dados existentes, reescrever os programas que o usam e derrubar o sistema — enquanto dado errado se corrige com um comando;
- **c)** porque erros de esquema só aparecem em produção;
- **d)** porque a instância é copiada no backup e o esquema não.

↩︎ *Aula 10, seção 1 — Esquema × instância, e por que a diferença é cara*

---

### Q-A10-03

O que caracteriza o **nível externo** da arquitetura em três níveis?

- **a)** A organização física dos arquivos e dos índices em disco;
- **b)** o conjunto de todas as tabelas, chaves e restrições da organização;
- **c)** o servidor que roda o SGBD, separado das máquinas dos clientes;
- **d)** o recorte que cada grupo de usuários enxerga, que no SQL vira uma `VIEW`.

↩︎ *Aula 10, seção 2 — A arquitetura em três níveis*

---

### Q-A10-04

Criar um índice em `data_prevista` não obriga a reescrever consulta nenhuma. Qual independência age aí?

- **a)** Física, porque a mudança ficou contida no nível interno;
- **b)** lógica, porque o esquema conceitual foi alterado;
- **c)** nenhuma: criar índice sempre exige revisar as consultas;
- **d)** as duas ao mesmo tempo, porque o índice atravessa os três níveis.

↩︎ *Aula 10, seção 3 — Independência física*

---

### Q-A10-05

Por que a aula diz que a independência lógica "não é automática — é conquistada"?

- **a)** Porque o programa que pede todas as colunas e confia na ordem delas a perde na primeira alteração, enquanto o que pede as colunas pelo nome sobrevive;
- **b)** porque ela precisa ser ativada por um comando de configuração do SGBD;
- **c)** porque só bancos comerciais a implementam;
- **d)** porque ela depende de o disco ser reorganizado periodicamente.

↩︎ *Aula 10, seção 4 — Independência lógica*

---

### Q-A10-06

`GRANT SELECT ON usuario TO atendente;` pertence a qual família de comandos?

- **a)** DDL, porque altera a definição da tabela;
- **b)** DML, porque envolve um `SELECT`;
- **c)** DDL, porque cria um objeto novo no banco;
- **d)** DCL, porque controla quem pode fazer o quê.

↩︎ *Aula 10, seção 5 — As três famílias de comandos*

---

### Q-A10-07

Qual é a diferença prática entre `DELETE FROM usuario;` e `DROP TABLE usuario;`?

- **a)** Nenhuma: os dois removem a tabela e os dados;
- **b)** o primeiro apaga as linhas e deixa a tabela de pé, e é DML; o segundo apaga estrutura, chaves, restrições e dados, e é DDL;
- **c)** o primeiro é DDL e o segundo é DML;
- **d)** o primeiro exige permissão de administrador e o segundo não.

↩︎ *Aula 10, seção 5 — As três famílias de comandos*

---

### Q-A10-08

O que significa dizer que um SGBD é **autodescritivo**?

- **a)** Que ele gera automaticamente a documentação do modelo em formato legível;
- **b)** que ele sugere nomes de tabela e de coluna a partir do enunciado;
- **c)** que ele guarda a própria descrição em tabelas que ele mesmo gerencia — o catálogo —, e pode agir sobre ela recusando o que não couber;
- **d)** que ele dispensa a documentação escrita do projeto.

↩︎ *Aula 10, seção 6 — O catálogo: o banco que descreve o banco*

---

⬅️ [Voltar à Aula 10](../README.md) | ➡️ [Revisão da Aula 11](../../aula-11-postgresql-na-pratica/revisao/README.md)
