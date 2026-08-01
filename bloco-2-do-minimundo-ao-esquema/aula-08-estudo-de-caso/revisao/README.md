# Aula 08 — Revisão: Múltipla Escolha

> 🎯 8 questões sobre a [Aula 08 — Estudo de Caso: do Minimundo ao Esquema Pronto](../README.md). Só uma alternativa está correta em cada uma.

**Sem gabarito, de propósito.** Cada questão termina com a seção da aula onde a resposta está. Responda **tudo primeiro**, sem consultar — só depois volte às seções indicadas e corrija.

---

### Q-A08-01

Qual é o passo do roteiro de seis que a aula aponta como "o que todo mundo pula"?

- **a)** Recortar o minimundo;
- **b)** grifar substantivos e verbos;
- **c)** desenhar o diagrama;
- **d)** perguntar ao cliente o que o texto não diz.

↩︎ *Aula 08, seção 2 — O roteiro em seis passos*

---

### Q-A08-02

Qual é o entregável do passo 6 do roteiro?

- **a)** A lista de exclusões justificadas;
- **b)** o DER em Mermaid com o parágrafo do que ele afirma;
- **c)** o esquema com PKs, FKs e a lista das regras que não couberam;
- **d)** as três listas de candidatos a entidade, relacionamento e atributo.

↩︎ *Aula 08, seção 2 — O roteiro em seis passos*

---

### Q-A08-03

Por que `RESERVA` aponta para `OBRA` enquanto `EMPRESTIMO` aponta para `EXEMPLAR`?

- **a)** Para reduzir o número de junções nas consultas de reserva;
- **b)** porque quem reserva quer o livro, e qualquer cópia serve — só na retirada é que um volume físico específico é escolhido;
- **c)** porque `EXEMPLAR` não tem chave primária própria;
- **d)** por engano do modelo original, corrigido no esquema final.

↩︎ *Aula 08, seção 3 — As três decisões que definiram este modelo*

---

### Q-A08-04

A decisão de manter `categoria` como atributo, e não como tabela, é apresentada como definitiva?

- **a)** Não: ela vale enquanto não houver nada a guardar dentro da categoria, e a decisão está escrita esperando o dia em que o limite de empréstimos precisar ser configurável;
- **b)** sim, porque atributos com domínio fechado nunca viram tabela;
- **c)** sim, porque o modelo já tem 13 tabelas e não comporta mais nenhuma;
- **d)** não, e por isso ela foi modelada das duas formas ao mesmo tempo.

↩︎ *Aula 08, seção 3 — As três decisões que definiram este modelo*

---

### Q-A08-05

`OBRA(isbn, titulo, matricula_reservou)` é um exemplo de qual erro clássico?

- **a)** O N:M que ninguém viu: funciona até a segunda pessoa reservar o mesmo livro;
- **b)** o atributo promovido a entidade;
- **c)** o dado repetido que sobrou;
- **d)** o ciclo redundante.

↩︎ *Aula 08, seção 5 — Os cinco erros clássicos*

---

### Q-A08-06

`EMPRESTIMO(id, matricula, nome_usuario, tombo, retirada)` foi escrito assim "para não precisar de junção". Qual é o efeito prático desse erro?

- **a)** As consultas ficam mais lentas, porque a tabela ocupa mais espaço;
- **b)** o nome do mesmo usuário pode ficar diferente em duas linhas, sem que nada acuse — é a dependência transitiva da Aula 07;
- **c)** o banco recusa a inserção por violar a integridade referencial;
- **d)** a chave primária deixa de identificar as linhas.

↩︎ *Aula 08, seção 5 — Os cinco erros clássicos*

---

### Q-A08-07

`EMPRESTIMO(id, tombo, isbn, ...)` aponta ao mesmo tempo para `EXEMPLAR` e para `OBRA`. Todo ciclo desse tipo é erro?

- **a)** Sim: duas chaves estrangeiras saindo da mesma tabela sempre indicam modelagem errada;
- **b)** sim, porque o banco não consegue verificar as duas FKs simultaneamente;
- **c)** não: o erro é o ciclo em que um caminho é derivável do outro — aqui o exemplar já determina a obra, o que permite um `isbn` contradizer o `tombo`;
- **d)** não, e neste caso específico o ciclo é desejável porque acelera as consultas.

↩︎ *Aula 08, seção 5 — Os cinco erros clássicos*

---

### Q-A08-08

Como conduzir a validação do modelo com alguém que entende do negócio e não entende de banco?

- **a)** Mostrando o diagrama e pedindo que aponte os losangos errados;
- **b)** entregando o esquema com as chaves sublinhadas para conferência linha a linha;
- **c)** pedindo que a pessoa aprenda a notação antes da reunião;
- **d)** lendo frases em voz alta e trazendo casos concretos, de preferência estranhos — é nos casos raros que os modelos quebram.

↩︎ *Aula 08, seção 6 — Validar com o cliente*

---

⬅️ [Voltar à Aula 08](../README.md) | ➡️ [Revisão da Aula 09](../../../bloco-3-o-sgbd-na-pratica/aula-09-por-que-um-sgbd-existe/revisao/README.md)
