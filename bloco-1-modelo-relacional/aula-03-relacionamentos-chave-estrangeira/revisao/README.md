# Aula 03 — Revisão: Múltipla Escolha

> 🎯 8 questões sobre a [Aula 03 — Relacionamentos e Chave Estrangeira](../README.md). Só uma alternativa está correta em cada uma.

**Sem gabarito, de propósito.** Cada questão termina com a seção da aula onde a resposta está. Responda **tudo primeiro**, sem consultar — só depois volte às seções indicadas e corrija.

---

### Q-A03-01

O que significa dizer que, no modelo relacional, a ligação entre duas tabelas é feita **por valor**?

- **a)** Que a linha ligada é encontrada porque o valor da FK aparece na chave primária da outra tabela, esteja essa linha onde estiver;
- **b)** que o banco guarda a posição física da linha referenciada, para achá-la mais rápido;
- **c)** que as duas tabelas precisam estar gravadas no mesmo arquivo em disco;
- **d)** que o valor da FK é recalculado toda vez que o banco reorganiza o disco.

↩︎ *Aula 03, seção 2 — Chave estrangeira: ligação por valor*

---

### Q-A03-02

Alguém declarou `EMPRESTIMO.nome_aluno` como chave estrangeira apontando para `ALUNO.nome`. Qual é o problema?

- **a)** Nenhum, desde que os dois atributos sejam texto;
- **b)** o problema é só de desempenho: comparar textos é mais lento que comparar números;
- **c)** a FK precisa referenciar uma chave primária ou candidata, e `nome` não identifica — dois alunos homônimos tornam a ligação ambígua;
- **d)** o problema é que a FK ficou com nome diferente da coluna referenciada.

↩︎ *Aula 03, seção 2 — Chave estrangeira: ligação por valor*

---

### Q-A03-03

Um departamento tem vários funcionários; um funcionário pertence a um departamento só. Onde mora a chave estrangeira?

- **a)** Em `DEPARTAMENTO`, porque é a tabela principal;
- **b)** em `FUNCIONARIO`, porque é o lado que tem um só do outro e a coluna cabe numa célula;
- **c)** nas duas tabelas, uma apontando para a outra;
- **d)** em nenhuma das duas: relacionamentos 1:N exigem uma terceira tabela.

↩︎ *Aula 03, seção 3 — 1:N — o caso mais comum de todos*

---

### Q-A03-04

Numa clínica, toda consulta tem obrigatoriamente um médico, e um médico pode ficar meses sem consulta marcada. O que essa segunda informação decide?

- **a)** Que a FK muda de lado, indo para `MEDICO`;
- **b)** que o relacionamento deixa de ser 1:N e passa a ser 1:1;
- **c)** que `CONSULTA` precisa de uma chave primária composta;
- **d)** nada sobre onde a FK mora: "pode zero" decide apenas se a coluna é obrigatória, e nesse caso não exige declaração nenhuma no lado do médico.

↩︎ *Aula 03, seção 3 — 1:N — o caso mais comum de todos*

---

### Q-A03-05

Você modelou `UNIDADE` e `FUNCIONARIO` num relacionamento 1:1 e colocou `matricula_chefe` em `UNIDADE`. O que falta para que o 1:1 realmente se sustente?

- **a)** Nada: por ser 1:1, a unicidade é automática;
- **b)** falta repetir a FK também em `FUNCIONARIO`, para fechar os dois lados;
- **c)** falta transformar `matricula_chefe` em parte da chave primária de `UNIDADE`;
- **d)** falta declarar `matricula_chefe` como única, senão duas unidades apontam para o mesmo chefe e o relacionamento vira 1:N sem ninguém perceber.

↩︎ *Aula 03, seção 4 — 1:1 — e por que ele costuma ser suspeito*

---

### Q-A03-06

Um aluno cursa várias disciplinas e uma disciplina é cursada por vários alunos. Por que a nota do aluno na disciplina não pode ficar em `ALUNO` nem em `DISCIPLINA`?

- **a)** Porque nota é um número decimal, e chaves não aceitam decimais;
- **b)** porque a nota pertence ao par aluno-disciplina: em `ALUNO` seriam várias notas numa célula, e em `DISCIPLINA` também;
- **c)** porque a nota muda com o tempo, e atributos que mudam ficam sempre em tabela separada;
- **d)** porque `ALUNO` e `DISCIPLINA` já têm chave primária, e uma tabela com chave não aceita atributos novos.

↩︎ *Aula 03, seção 5 — N:M e a tabela associativa*

---

### Q-A03-07

Qual é a chave primária habitual de uma tabela associativa que resolve um N:M entre `ALUNO` e `DISCIPLINA`?

- **a)** Apenas `matricula`, porque o aluno é quem se matricula;
- **b)** um `id` sequencial, obrigatoriamente, porque tabelas associativas não podem ter chave composta;
- **c)** o par formado pelas duas chaves estrangeiras, `(matricula, cod_disciplina)`;
- **d)** todas as colunas da tabela, incluindo a nota, para garantir que nenhuma linha se repita.

↩︎ *Aula 03, seção 5 — N:M e a tabela associativa*

---

### Q-A03-08

Em `FUNCIONARIO(matricula, nome, matricula_chefe)`, a diretora tem `matricula_chefe` vazio. Isso viola a integridade referencial?

- **a)** Não: o valor de uma FK pode ser vazio, e é assim que se representa o topo da hierarquia;
- **b)** sim, porque toda FK precisa apontar para uma linha existente, sem exceção;
- **c)** sim, porque uma tabela não pode ter chave estrangeira para si mesma;
- **d)** não, porque autorrelacionamento não é chave estrangeira de verdade e o banco não verifica nada ali.

↩︎ *Aula 03, seção 6 — Autorrelacionamento: a tabela que aponta para si mesma*

---

⬅️ [Voltar à Aula 03](../README.md) | ➡️ [Revisão da Aula 04](../../aula-04-integridade-e-nulo/revisao/README.md)
