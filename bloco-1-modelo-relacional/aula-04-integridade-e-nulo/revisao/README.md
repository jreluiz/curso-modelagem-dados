# Aula 04 — Revisão: Múltipla Escolha

> 🎯 8 questões sobre a [Aula 04 — Integridade e o Valor Nulo](../README.md). Só uma alternativa está correta em cada uma.

**Sem gabarito, de propósito.** Cada questão termina com a seção da aula onde a resposta está. Responda **tudo primeiro**, sem consultar — só depois volte às seções indicadas e corrija.

---

### Q-A04-01

Uma tentativa de gravar `ano_publicacao = 'mil e quinhentos'` é recusada pelo banco. Que restrição de integridade agiu?

- **a)** Integridade de entidade;
- **b)** integridade referencial;
- **c)** integridade semântica;
- **d)** integridade de domínio.

↩︎ *Aula 04, seção 2 — Integridade de domínio*

---

### Q-A04-02

Declarar `ano_publicacao INTEGER` já basta para garantir o domínio desse atributo?

- **a)** Sim: o tipo é a definição completa do domínio;
- **b)** não: o tipo impede `'mil e quinhentos'`, mas aceita `-3`, que é um inteiro válido e um ano impossível — falta declarar a faixa;
- **c)** não, porque anos devem ser guardados como texto para preservar zeros à esquerda;
- **d)** sim, desde que a coluna também seja declarada obrigatória.

↩︎ *Aula 04, seção 2 — Integridade de domínio*

---

### Q-A04-03

Numa tabela com chave primária composta `(matricula, cod_disciplina)`, a integridade de entidade exige que:

- **a)** Apenas a primeira coluna da chave seja preenchida;
- **b)** ao menos uma das duas colunas seja preenchida;
- **c)** nenhuma das duas partes seja nula — não existe meia chave — e o par não se repita;
- **d)** as duas colunas sejam do mesmo tipo de dado.

↩︎ *Aula 04, seção 3 — Integridade de entidade*

---

### Q-A04-04

Uma linha de `EMPRESTIMO` com `matricula = 9999999`, valor que não existe em `ALUNO`, produz o quê?

- **a)** Um registro órfão, que viola a integridade referencial e some dos relatórios feitos por junção;
- **b)** uma violação de domínio, porque o número tem sete dígitos;
- **c)** uma violação de integridade de entidade, porque a matrícula é chave;
- **d)** nada de errado, desde que a matrícula seja cadastrada depois.

↩︎ *Aula 04, seção 4 — Integridade referencial*

---

### Q-A04-05

"Um exemplar em manutenção não pode ser emprestado" é um exemplo de qual restrição?

- **a)** Semântica, porque é uma regra do minimundo que as outras três não cobrem;
- **b)** de domínio, porque envolve o atributo `situacao`;
- **c)** referencial, porque envolve duas tabelas;
- **d)** de entidade, porque impede a criação de uma linha.

↩︎ *Aula 04, seção 5 — Integridade semântica*

---

### Q-A04-06

Um empréstimo em aberto tem `data_devolucao` vazia. Qual dos três significados de nulo é esse?

- **a)** Desconhecido: alguém devolveu e ninguém anotou;
- **b)** não informado: o aluno se recusou a dizer;
- **c)** não se aplica: a devolução ainda não aconteceu, então não há valor a registrar;
- **d)** nenhum deles: nulo aqui equivale a zero.

↩︎ *Aula 04, seção 6 — O valor nulo e seus três significados*

---

### Q-A04-07

Comparar duas colunas nulas com o sinal de igual resulta em:

- **a)** Verdadeiro, porque as duas ausências são iguais;
- **b)** desconhecido, porque nulo não é igual a nada — nem a si mesmo;
- **c)** falso, e por isso a linha nunca aparece;
- **d)** erro de execução, que interrompe a consulta.

↩︎ *Aula 04, seção 6 — O valor nulo e seus três significados*

---

### Q-A04-08

Para a chave estrangeira `EMPRESTIMO → ALUNO`, qual ação referencial é a correta e por quê?

- **a)** Em cascata, porque o empréstimo pertence ao aluno e não faz sentido sem ele;
- **b)** esvaziar, porque assim o histórico é preservado sem apontar para ninguém;
- **c)** em cascata, porque é o padrão do banco e evita erros de exclusão;
- **d)** recusar, porque apagar o aluno apagaria o histórico de empréstimos: aluno que sai é inativado, não excluído.

↩︎ *Aula 04, seção 7 — Ações referenciais: o que acontece ao apagar*

---

⬅️ [Voltar à Aula 04](../README.md) | ➡️ [Revisão da Aula 05](../../../bloco-2-do-minimundo-ao-esquema/aula-05-minimundo-e-der/revisao/README.md)
