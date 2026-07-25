# Aula 12 — Revisão: Múltipla Escolha

> 🎯 8 questões sobre a [Aula 12 — Normalização](../README.md). Só uma alternativa está correta em cada uma.

**Sem gabarito, de propósito.** Cada questão termina com a seção da aula onde a resposta está. Responda **tudo primeiro**, sem consultar — só depois volte às seções indicadas e corrija.

---

### Q-A12-01

Numa tabela "tudo em um", não é possível cadastrar uma obra que ainda não foi emprestada. Que anomalia é essa?

- **a)** Anomalia de inserção;
- **b)** anomalia de atualização;
- **c)** anomalia de exclusão;
- **d)** violação de integridade referencial.

↩︎ *Aula 12, seção 1 — As três anomalias*

---

### Q-A12-02

Qual é a **causa comum** das três anomalias de atualização?

- **a)** A ausência de chaves estrangeiras declaradas;
- **b)** o excesso de tabelas no esquema;
- **c)** a falta de índices nas colunas consultadas;
- **d)** a relação mistura fatos sobre coisas diferentes — fala de empréstimos, de usuários e de obras ao mesmo tempo.

↩︎ *Aula 12, seção 1 — As três anomalias*

---

### Q-A12-03

Hoje não existem dois usuários com o mesmo nome na base. Isso permite afirmar `nome → matricula`?

- **a)** Sim: a dependência funcional é verificada sobre os dados existentes;
- **b)** sim, desde que exista um índice `UNIQUE` sobre o nome;
- **c)** não: DF é uma afirmação sobre o mundo, não sobre os dados de hoje — a pergunta é se *pode* haver repetição;
- **d)** não, porque atributos de texto nunca determinam outros atributos.

↩︎ *Aula 12, seção 2 — Dependência funcional*

---

### Q-A12-04

Uma relação tem chave primária **simples** (um único atributo). O que se pode afirmar?

- **a)** Que ela está automaticamente em 3FN;
- **b)** que ela está automaticamente em 2FN, porque sem chave composta não existe dependência parcial;
- **c)** que ela está automaticamente em BCNF;
- **d)** nada: a forma normal independe do formato da chave.

↩︎ *Aula 12, seção 4 — 2FN — sem dependência parcial*

---

### Q-A12-05

Em `EMPRESTIMO(id, matricula, nome_usuario, email, tombo, data_retirada)`, com `id` como chave, qual é o problema?

- **a)** Uma dependência parcial: `nome_usuario` depende de parte da chave;
- **b)** uma violação de 1FN: há atributos não atômicos;
- **c)** uma dependência transitiva: `nome_usuario` depende de `matricula`, que não é chave — logo `id → nome_usuario` é indireta;
- **d)** nenhum problema: a relação está em BCNF.

↩︎ *Aula 12, seção 5 — 3FN — sem dependência transitiva*

---

### Q-A12-06

Qual é a exceção que a 3FN admite e a BCNF **não** admite?

- **a)** Atributos multivalorados, tolerados pela 3FN;
- **b)** a 3FN aceita `X → Y` quando `Y` é atributo primo; a BCNF exige que `X` seja superchave em toda DF não trivial;
- **c)** a 3FN aceita chaves compostas, e a BCNF exige chave simples;
- **d)** a 3FN aceita valores nulos, e a BCNF os proíbe.

↩︎ *Aula 12, seção 6 — BCNF — a 3FN levada a sério*

---

### Q-A12-07

Uma decomposição de `R` em `R1` e `R2` é **sem perda** quando:

- **a)** As duas relações resultantes têm o mesmo número de atributos;
- **b)** nenhum atributo aparece nas duas relações;
- **c)** todas as dependências funcionais são preservadas;
- **d)** os atributos comuns (`R1 ∩ R2`) formam chave de pelo menos uma das duas.

↩︎ *Aula 12, seção 7 — Decomposição sem perda*

---

### Q-A12-08

Quando é legítimo **desnormalizar** um esquema?

- **a)** Como decisão de projeto físico, tomada com medição na mão e acompanhada de um mecanismo que mantenha o dado duplicado sincronizado;
- **b)** sempre que a consulta exigir mais de duas junções;
- **c)** nunca: normalizar é uma regra absoluta;
- **d)** sempre que o esquema tiver mais de dez tabelas.

↩︎ *Aula 12, seção 8 — Além da 3FN, e o caminho de volta*

---

⬅️ [Voltar à Aula 12](../README.md) | ➡️ [Revisão da Aula 13](../../../bloco-4-sql-e-projeto-fisico/aula-13-sql-ddl/revisao/README.md)
