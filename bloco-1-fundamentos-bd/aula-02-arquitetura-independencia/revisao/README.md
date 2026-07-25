# Aula 02 — Revisão: Múltipla Escolha

> 🎯 8 questões sobre a [Aula 02 — Arquitetura de SGBD e Independência de Dados](../README.md). Só uma alternativa está correta em cada uma.

**Sem gabarito, de propósito.** Cada questão termina com a seção da aula onde a resposta está. Responda **tudo primeiro**, sem consultar — só depois volte às seções indicadas e corrija.

---

### Q-A02-01

"A tabela `LIVRO` tem uma coluna `ano_publicacao` do tipo inteiro." Esta afirmação descreve:

- **a)** A instância, porque menciona um tipo de dado concreto;
- **b)** o esquema, porque descreve a estrutura, e não os dados guardados;
- **c)** ambos, já que tipo e valor são inseparáveis;
- **d)** nenhum dos dois: é uma restrição de integridade, categoria à parte.

↩︎ *Aula 02, seção 1 — Esquema × instância*

---

### Q-A02-02

Por que um erro de esquema é muito mais caro que um erro de instância?

- **a)** Porque corrigi-lo exige migrar todos os dados existentes e reescrever todo programa que o usa, enquanto um dado errado se corrige com um `UPDATE`;
- **b)** porque o esquema ocupa mais espaço em disco que os dados;
- **c)** porque o SGBD não permite alterar o esquema depois da criação;
- **d)** porque erros de instância são detectados automaticamente e os de esquema não.

↩︎ *Aula 02, seção 1 — Esquema × instância*

---

### Q-A02-03

Na arquitetura em três níveis, qual nível descreve **todas** as entidades, atributos e relacionamentos da organização, sem falar de armazenamento?

- **a)** Externo;
- **b)** interno;
- **c)** físico;
- **d)** conceitual.

↩︎ *Aula 02, seção 2 — A arquitetura em três níveis*

---

### Q-A02-04

Criar um índice em `data_prevista` para acelerar consultas, sem que nenhum programa precise ser alterado, é possível graças a qual independência?

- **a)** Independência lógica, porque o esquema conceitual permaneceu intacto;
- **b)** independência referencial, garantida pelas chaves estrangeiras;
- **c)** independência física, porque a mudança ficou contida no nível interno;
- **d)** independência semântica, porque o significado dos dados não mudou.

↩︎ *Aula 02, seção 3 — Independência de dados*

---

### Q-A02-05

Por que escrever `SELECT matricula, nome FROM aluno` em vez de `SELECT * FROM aluno` é uma decisão de arquitetura, e não apenas de estilo?

- **a)** Porque `SELECT *` é mais lento em qualquer situação;
- **b)** porque nomear as colunas preserva a independência lógica: o programa continua funcionando quando uma coluna é acrescentada ao esquema;
- **c)** porque `SELECT *` não funciona em tabelas com chave composta;
- **d)** porque o padrão SQL desaconselha o uso do asterisco.

↩︎ *Aula 02, seção 3 — Independência de dados*

---

### Q-A02-06

Classifique corretamente: `CREATE INDEX`, `UPDATE` e `REVOKE`.

- **a)** DDL, DDL, DCL;
- **b)** DML, DML, DDL;
- **c)** DDL, DDL, DML;
- **d)** DDL, DML, DCL.

↩︎ *Aula 02, seção 4 — As três famílias de comandos*

---

### Q-A02-07

Qual é a diferença entre `DELETE FROM aluno;` e `DROP TABLE aluno;`?

- **a)** `DELETE` apaga todas as linhas e mantém a tabela de pé (é DML); `DROP` apaga a tabela inteira — estrutura, índices e restrições (é DDL);
- **b)** `DELETE` apaga a estrutura e `DROP` apaga apenas as linhas;
- **c)** nenhuma: os dois apagam todos os dados da tabela;
- **d)** `DELETE` só funciona com `WHERE`, e `DROP` funciona sem condição.

↩︎ *Aula 02, seção 4 — As três famílias de comandos*

---

### Q-A02-08

O que caracteriza o modelo **relacional** e explica a independência de dados que ele proporciona?

- **a)** O uso de ponteiros diretos entre registros, que tornam a navegação mais rápida;
- **b)** a organização dos dados em árvore, com um pai por registro;
- **c)** as ligações feitas por valor de chave, e não por endereço físico — o que torna o dado independente de onde está guardado;
- **d)** a ausência de restrições de integridade, que dá liberdade ao projetista.

↩︎ *Aula 02, seção 6 — Panorama dos modelos de dados*

---

⬅️ [Voltar à Aula 02](../README.md) | ➡️ [Revisão da Aula 03](../../aula-03-projeto-de-bd-e-minimundo/revisao/README.md)
