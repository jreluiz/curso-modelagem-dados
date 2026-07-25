# Aula 05 — Revisão: Múltipla Escolha

> 🎯 8 questões sobre a [Aula 05 — Relacionamentos, Grau e Cardinalidade](../README.md). Só uma alternativa está correta em cada uma.

**Sem gabarito, de propósito.** Cada questão termina com a seção da aula onde a resposta está. Responda **tudo primeiro**, sem consultar — só depois volte às seções indicadas e corrija.

---

### Q-A05-01

Qual destes é um relacionamento no sentido do MER?

- **a)** A ligação entre `USUARIO` e o atributo `nome`;
- **b)** a ligação entre a tela de cadastro e a tela de consulta do sistema;
- **c)** a associação entre `USUARIO` e `EXEMPLAR` quando alguém pega um livro emprestado;
- **d)** a ligação entre a tabela e o índice criado sobre ela.

↩︎ *Aula 05, seção 1 — O que é um relacionamento*

---

### Q-A05-02

Num autorrelacionamento `FUNCIONARIO chefia FUNCIONARIO`, por que os **papéis** são obrigatórios?

- **a)** Porque sem eles não há como saber qual ponta é o chefe e qual é o subordinado — e, no projeto lógico, como nomear as duas chaves que apontam para a mesma tabela;
- **b)** porque o Mermaid recusa autorrelacionamentos sem rótulo;
- **c)** porque a cardinalidade de um autorrelacionamento é sempre N:M;
- **d)** porque papéis substituem a chave primária nesse tipo de relacionamento.

↩︎ *Aula 05, seção 2 — Grau: quantas entidades participam*

---

### Q-A05-03

O relacionamento ternário `PRESCREVE(MEDICO, PACIENTE, MEDICAMENTO)` é decomposto em três binários. O que se perde?

- **a)** Nada: três binários carregam a mesma informação com mais clareza;
- **b)** perde-se apenas desempenho, porque passa a exigir mais junções;
- **c)** perdem-se os atributos do relacionamento, que não têm onde ficar;
- **d)** perde-se a associação tripla: sabe-se que o médico atende o paciente, que prescreve o remédio e que o paciente usa o remédio — sem nunca saber se foi aquele médico quem prescreveu aquele remédio àquele paciente.

↩︎ *Aula 05, seção 2 — Grau: quantas entidades participam*

---

### Q-A05-04

"Um pedido tem um produto." O modelador conclui que o relacionamento é 1:N. Qual foi o erro?

- **a)** Confundiu cardinalidade com participação;
- **b)** respondeu uma pergunta só — faltou perguntar se um produto aparece em vários pedidos, o que revelaria um N:M;
- **c)** usou o singular em vez do plural na frase;
- **d)** nenhum erro: a conclusão está correta.

↩︎ *Aula 05, seção 3 — Razão de cardinalidade*

---

### Q-A05-05

Num relacionamento 1:N, onde vai a chave estrangeira no projeto lógico?

- **a)** Sempre no lado N, porque colocá-la do lado 1 obrigaria a repetir a linha uma vez por ocorrência;
- **b)** sempre no lado 1, que é o lado "dono" do relacionamento;
- **c)** em ambos os lados, para permitir navegação nos dois sentidos;
- **d)** numa terceira tabela, criada especialmente para a ligação.

↩︎ *Aula 05, seção 3 — Razão de cardinalidade*

---

### Q-A05-06

Um aluno afirma: "esse relacionamento é 1:N total". O que está faltando na afirmação?

- **a)** Nada: a frase está completa e correta;
- **b)** falta dizer se o relacionamento é identificador;
- **c)** falta o grau do relacionamento;
- **d)** falta indicar de que lado a participação é total — participação é sempre de um lado específico.

↩︎ *Aula 05, seção 4 — Participação: total ou parcial*

---

### Q-A05-07

O par `(1,N)` na notação (min,max) significa:

- **a)** Cardinalidade 1, participação parcial;
- **b)** cardinalidade N, participação total;
- **c)** cardinalidade N, participação parcial;
- **d)** cardinalidade 1, participação total.

↩︎ *Aula 05, seção 5 — A notação (min,max)*

---

### Q-A05-08

O atributo `ordem`, que registra a posição de um autor na capa de uma obra, pertence a quê?

- **a)** À entidade `AUTOR`, já que descreve o autor;
- **b)** à entidade `OBRA`, já que descreve a capa;
- **c)** ao relacionamento entre os dois: o mesmo autor é 1º numa obra e 3º noutra, então o valor muda conforme o par;
- **d)** a nenhum dos três: é uma regra de negócio, não um atributo.

↩︎ *Aula 05, seção 6 — Atributos de relacionamento*

---

⬅️ [Voltar à Aula 05](../README.md) | ➡️ [Revisão da Aula 06](../../aula-06-entidades-fracas-chaves/revisao/README.md)
