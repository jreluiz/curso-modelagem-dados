# Aula 10 — Revisão: Múltipla Escolha

> 🎯 8 questões sobre a [Aula 10 — Mapeamento ER → Relacional](../README.md). Só uma alternativa está correta em cada uma.

**Sem gabarito, de propósito.** Cada questão termina com a seção da aula onde a resposta está. Responda **tudo primeiro**, sem consultar — só depois volte às seções indicadas e corrija.

---

### Q-A10-01

Se o mapeamento ER → relacional é mecânico, qual é a consequência para o projeto?

- **a)** Que a fase conceitual pode ser abreviada, já que a tradução corrige eventuais falhas;
- **b)** que todo defeito do esquema final já estava no DER — não existe salvar um modelo conceitual ruim na hora de gerar as tabelas;
- **c)** que ferramentas automáticas dispensam o projetista nessa etapa;
- **d)** que o modelo lógico pode ser escrito antes do conceitual, sem prejuízo.

↩︎ *Aula 10, seção 1 — Por que traduzir*

---

### Q-A10-02

Como se mapeia um atributo **composto** como `endereco(logradouro, numero, cidade)`?

- **a)** Vira uma tabela própria, com a chave da entidade original;
- **b)** vira uma única coluna de texto contendo as três partes;
- **c)** é achatado: só as folhas viram colunas (`end_logradouro`, `end_numero`, `end_cidade`), e a coluna `endereco` não existe;
- **d)** vira uma coluna do tipo composto, recurso presente em todo SGBD relacional.

↩︎ *Aula 10, seção 2 — Regra 1 — Entidade forte*

---

### Q-A10-03

Ao mapear a entidade fraca `RENOVACAO`, qual é a chave primária resultante?

- **a)** `(id_emprestimo, sequencia)` — a chave da proprietária mais a chave parcial;
- **b)** apenas `sequencia`, que é o discriminador da entidade fraca;
- **c)** apenas `id_emprestimo`, herdado da proprietária;
- **d)** uma chave artificial nova, já que entidades fracas não têm chave própria.

↩︎ *Aula 10, seção 3 — Regra 2 — Entidade fraca*

---

### Q-A10-04

Num relacionamento 1:N entre `OBRA` e `EXEMPLAR`, por que a FK não pode ficar em `OBRA`?

- **a)** Porque o SGBD proíbe chaves estrangeiras em tabelas referenciadas por outras;
- **b)** porque `OBRA` já tem chave primária, e uma tabela não pode ter PK e FK;
- **c)** porque a FK precisa sempre apontar para a tabela de menor cardinalidade;
- **d)** porque isso obrigaria a repetir a linha da obra uma vez por exemplar — exatamente a redundância que o modelo existe para eliminar.

↩︎ *Aula 10, seção 4 — Regra 3 — Relacionamento 1:N*

---

### Q-A10-05

Num relacionamento 1:1 mapeado com FK em um dos lados, o que é indispensável declarar?

- **a)** `UNIQUE` na chave estrangeira — sem isso, o banco aceita dois registros apontando para o mesmo e o 1:1 vira 1:N sem que ninguém perceba;
- **b)** `ON DELETE CASCADE`, para manter os dois lados sincronizados;
- **c)** um índice composto sobre as duas chaves primárias;
- **d)** um gatilho que verifique a cardinalidade a cada inserção.

↩︎ *Aula 10, seção 5 — Regra 4 — Relacionamento 1:1*

---

### Q-A10-06

O que acontece com os **atributos do relacionamento** ao mapear um N:M?

- **a)** São distribuídos entre as duas entidades participantes;
- **b)** são descartados, porque não pertencem a nenhuma entidade;
- **c)** viram uma terceira tabela, separada da associativa;
- **d)** vão para a tabela associativa, que é o único lugar onde eles têm sentido.

↩︎ *Aula 10, seção 6 — Regra 5 — Relacionamento N:M*

---

### Q-A10-07

Qual opção de mapeamento de especialização funciona para **qualquer** combinação de disjunção e completude?

- **a)** Opção B — uma tabela por subclasse, sem a superclasse;
- **b)** opção C — tabela única com discriminador;
- **c)** opção A — uma tabela por subclasse mais a superclasse;
- **d)** nenhuma: cada combinação exige uma estratégia exclusiva.

↩︎ *Aula 10, seção 9 — Especialização: as quatro opções*

---

### Q-A10-08

"Toda obra tem pelo menos um exemplar" (participação total do lado 1). O que acontece com essa restrição no esquema relacional?

- **a)** Vira `NOT NULL` na chave estrangeira de `EXEMPLAR`;
- **b)** não é expressável como restrição declarativa — exige gatilho ou verificação na aplicação;
- **c)** vira uma restrição `CHECK` na tabela `OBRA`;
- **d)** é garantida automaticamente pela integridade referencial.

↩︎ *Aula 10, seção 11 — O que se perde na tradução*

---

⬅️ [Voltar à Aula 10](../README.md) | ➡️ [Revisão da Aula 11](../../aula-11-algebra-relacional/revisao/README.md)
