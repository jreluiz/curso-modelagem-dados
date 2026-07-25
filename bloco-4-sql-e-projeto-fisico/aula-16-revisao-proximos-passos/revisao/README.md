# Aula 16 — Revisão: Múltipla Escolha

> 🎯 8 questões sobre a [Aula 16 — Revisão e Próximos Passos](../README.md), cobrindo os quatro blocos do curso. Só uma alternativa está correta em cada uma.

**Sem gabarito, de propósito.** Cada questão termina com a seção da aula onde a resposta está. Responda **tudo primeiro**, sem consultar — só depois volte às seções indicadas e corrija.

---

### Q-A16-01

Qual é a frase que resume a relação entre os quatro níveis do curso?

- **a)** Cada nível é uma tradução do anterior, e nenhuma tradução conserta um erro do nível de cima;
- **b)** cada nível é independente, e um erro pode ser corrigido em qualquer um deles;
- **c)** o nível físico é o mais importante, porque é o único que roda;
- **d)** os níveis podem ser percorridos em qualquer ordem, conforme a preferência da equipe.

↩︎ *Aula 16, seção 1 — O mapa do curso em uma tela*

---

### Q-A16-02

A frase do minimundo *"é o exemplar que é emprestado, nunca a obra"* atravessa o curso. Qual seria o custo de ter ligado `EMPRESTIMO` diretamente a `OBRA`?

- **a)** O banco ficaria mais lento nas consultas de empréstimo;
- **b)** o banco funcionaria perfeitamente e seria incapaz de dizer qual volume físico está com quem — e nenhuma consulta engenhosa recuperaria isso;
- **c)** o esquema violaria a segunda forma normal;
- **d)** o PostgreSQL recusaria a criação da chave estrangeira.

↩︎ *Aula 16, seção 2 — O mesmo minimundo, nas quatro fases*

---

### Q-A16-03

O que caracteriza a **modelagem dimensional** (esquema estrela) em relação ao que o curso ensinou?

- **a)** É a mesma coisa, com outro nome comercial;
- **b)** normaliza ainda mais, chegando à 5FN;
- **c)** elimina a necessidade de chaves estrangeiras;
- **d)** otimiza para leitura e agregação, com dimensões deliberadamente desnormalizadas — o oposto do OLTP, que otimiza escrita e integridade.

↩︎ *Aula 16, seção 3 — Modelagem dimensional: quando a pergunta é outra*

---

### Q-A16-04

Uma organização precisa escolher entre modelo normalizado e esquema estrela. O que a aula recomenda?

- **a)** Escolher o normalizado, porque o dimensional viola as formas normais;
- **b)** escolher o dimensional, porque é mais moderno;
- **c)** ter os dois: o sistema roda em OLTP, e os dados são copiados periodicamente para um *data warehouse* dimensional;
- **d)** escolher conforme o SGBD disponível.

↩︎ *Aula 16, seção 3 — Modelagem dimensional: quando a pergunta é outra*

---

### Q-A16-05

Num banco de documentos "sem esquema", o que acontece com a modelagem?

- **a)** Deixa de ser necessária, já que a estrutura é livre;
- **b)** passa a ser feita automaticamente pelo próprio banco;
- **c)** é substituída pela definição de índices;
- **d)** continua igual — mas o esquema deixa de ser verificado pelo banco e passa a ser mantido por acordo na aplicação, o que traz de volta os quatro pecados da Aula 01.

↩︎ *Aula 16, seção 4 — NoSQL: quando o relacional não é a resposta*

---

### Q-A16-06

Para qual caso o modelo de **grafo** é a escolha mais adequada?

- **a)** Folha de pagamento de uma empresa;
- **b)** carrinho de compras descartado em 30 minutos;
- **c)** rede social com sugestão de "amigos de amigos", em que a relação é o dado principal;
- **d)** coleta de leituras de 50 mil sensores por segundo.

↩︎ *Aula 16, seção 4 — NoSQL: quando o relacional não é a resposta*

---

### Q-A16-07

O que é a **impedância objeto-relacional**?

- **a)** A perda de desempenho causada por chaves estrangeiras em tabelas grandes;
- **b)** o descompasso entre o modelo de objetos (herança, referências, coleções) e o relacional (tabelas, chaves, junções), que um ORM tenta automatizar;
- **c)** a incompatibilidade entre dois SGBDs diferentes na mesma aplicação;
- **d)** o atraso entre a escrita e a confirmação de uma transação.

↩︎ *Aula 16, seção 5 — ORM e a impedância objeto-relacional*

---

### Q-A16-08

Por que a aula recomenda entender SQL **antes** de usar um ORM?

- **a)** Porque o ORM gera SQL, e quem não lê SQL não percebe quando o SQL gerado é ruim — o problema N+1 sendo o caso mais comum;
- **b)** porque os ORMs modernos exigem que se escreva o DDL manualmente;
- **c)** porque ORMs não funcionam com bancos normalizados;
- **d)** porque o ORM não suporta chaves compostas.

↩︎ *Aula 16, seção 5 — ORM e a impedância objeto-relacional*

---

⬅️ [Voltar à Aula 16](../README.md) | 🏠 [Início do curso](../../../README.md)
