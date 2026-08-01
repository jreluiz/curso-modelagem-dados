# Aula 07 — Revisão: Múltipla Escolha

> 🎯 8 questões sobre a [Aula 07 — Normalização até a 3FN](../README.md). Só uma alternativa está correta em cada uma.

**Sem gabarito, de propósito.** Cada questão termina com a seção da aula onde a resposta está. Responda **tudo primeiro**, sem consultar — só depois volte às seções indicadas e corrija.

---

### Q-A07-01

Por que a redundância volta a aparecer num esquema que já passou pelas cinco regras de mapeamento da Aula 06?

- **a)** Porque as regras de mapeamento produzem tabelas com chave e FK corretas, mas não olham para o que cada coluna depende;
- **b)** porque as regras de mapeamento foram aplicadas fora de ordem;
- **c)** porque o diagrama original estava errado, e nenhum esquema mapeado corretamente tem redundância;
- **d)** porque o banco de dados duplica linhas automaticamente ao criar chaves estrangeiras.

↩︎ *Aula 07, seção 1 — A redundância volta*

---

### Q-A07-02

O que significa dizer que "X determina Y"?

- **a)** Que X e Y sempre aparecem na mesma tabela;
- **b)** que, sabendo o valor de X, você sabe o valor de Y — e sempre o mesmo;
- **c)** que X é a chave primária e Y é a chave estrangeira;
- **d)** que Y é calculado a partir de X por uma fórmula matemática.

↩︎ *Aula 07, seção 2 — "Depende de": a dependência funcional, sem fórmula*

---

### Q-A07-03

Nas quatro linhas de exemplo da aula, a coluna `categoria` vale "aluno" em todas. Isso prova que `id_emp → categoria`?

- **a)** Sim, porque a tabela mostra o valor sempre igual;
- **b)** sim, desde que a tabela tenha mais de três linhas;
- **c)** não, porque `categoria` é texto, e dependência só vale entre números;
- **d)** não: a dependência é uma regra do minimundo, não uma observação da instância — o que vale é que a matrícula determina a categoria.

↩︎ *Aula 07, seção 2 — "Depende de": a dependência funcional, sem fórmula*

---

### Q-A07-04

Uma tabela tem as colunas `telefone1`, `telefone2` e `telefone3`. Em que forma normal está a violação?

- **a)** Na 3FN, porque as três colunas dependem umas das outras;
- **b)** em nenhuma: cada célula tem um valor só, então está tudo certo;
- **c)** na 1FN: é uma lista com o índice no nome da coluna, e ela quebra no dia em que aparece um quarto número;
- **d)** na 2FN, porque a chave é composta.

↩︎ *Aula 07, seção 3 — 1FN — um valor por célula*

---

### Q-A07-05

Em `EMPRESTIMO_ITEM(id_emp, tombo, retirada, titulo)` com chave `(id_emp, tombo)`, o fato de `titulo` depender só de `tombo` é uma:

- **a)** Dependência transitiva, que quebra a 3FN;
- **b)** dependência multivalorada, que quebra a 1FN;
- **c)** dependência parcial, que quebra a 2FN;
- **d)** dependência trivial, que não quebra nada.

↩︎ *Aula 07, seção 4 — 2FN — depende da chave inteira*

---

### Q-A07-06

Uma tabela tem chave primária de uma única coluna. O que se pode afirmar de imediato?

- **a)** Que ela está na 3FN, porque chave simples elimina dependências transitivas;
- **b)** que ela viola a 1FN até prova em contrário;
- **c)** que ela precisa ser decomposta antes de qualquer análise;
- **d)** que ela já está na 2FN, porque não existe "parte" de uma chave simples e, portanto, não existe dependência parcial.

↩︎ *Aula 07, seção 5 — 3FN — depende só da chave*

---

### Q-A07-07

Qual é a frase que resume as três formas normais desta aula?

- **a)** Toda tabela depende de uma chave estrangeira e de nada mais;
- **b)** toda coluna depende da chave, da chave inteira, e de nada além dela;
- **c)** toda chave primária precisa ser simples, curta e artificial;
- **d)** toda tabela precisa ser decomposta até restar uma coluna por tabela.

↩︎ *Aula 07, seção 5 — 3FN — depende só da chave*

---

### Q-A07-08

O item de um pedido guarda o `preco_unitario` da data da compra, embora o produto já tenha preço no cadastro. Isso é redundância?

- **a)** Não: são dois fatos diferentes — o preço de hoje e o daquele dia —, e sem essa coluna mudar o preço do produto reescreveria o passado;
- **b)** sim, e a coluna deve ser removida por violar a 3FN;
- **c)** sim, mas é aceitável porque melhora o desempenho das consultas;
- **d)** não, porque valores monetários nunca entram na análise de normalização.

↩︎ *Aula 07, seção 6 — Quando não normalizar*

---

⬅️ [Voltar à Aula 07](../README.md) | ➡️ [Revisão da Aula 08](../../aula-08-estudo-de-caso/revisao/README.md)
