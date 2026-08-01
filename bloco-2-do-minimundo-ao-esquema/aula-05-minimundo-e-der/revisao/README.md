# Aula 05 — Revisão: Múltipla Escolha

> 🎯 8 questões sobre a [Aula 05 — O Minimundo e o DER](../README.md). Só uma alternativa está correta em cada uma.

**Sem gabarito, de propósito.** Cada questão termina com a seção da aula onde a resposta está. Responda **tudo primeiro**, sem consultar — só depois volte às seções indicadas e corrija.

---

### Q-A05-01

Por que a aula insiste em escrever a lista do que **ficou de fora** do minimundo?

- **a)** Porque o professor precisa dessa lista para corrigir o trabalho;
- **b)** porque assim fica registrado que a exclusão foi decisão, e não esquecimento — na reunião em que alguém perguntar "e o endereço?", a resposta existe;
- **c)** porque tudo que ficou de fora precisa ser modelado numa segunda etapa do projeto;
- **d)** porque o banco de dados exige a declaração explícita dos dados que não serão guardados.

↩︎ *Aula 05, seção 1 — O minimundo: a parte da realidade que entra*

---

### Q-A05-02

Segundo o truque gramatical da primeira leitura, os **verbos** que ligam dois substantivos são candidatos a:

- **a)** Relacionamento;
- **b)** entidade;
- **c)** atributo;
- **d)** chave primária.

↩︎ *Aula 05, seção 2 — Substantivos e verbos: a primeira leitura*

---

### Q-A05-03

`TELEFONE` foi classificado como entidade, e não como coluna de `USUARIO`. Qual das razões abaixo, sozinha, já resolve a classificação?

- **a)** O telefone é um dado sensível e precisa de tabela separada;
- **b)** o telefone é um texto, e textos longos não cabem como coluna;
- **c)** um usuário guarda mais de um telefone, e uma célula guarda um valor só;
- **d)** o telefone tem um `tipo`, e todo atributo com tipo vira entidade.

↩︎ *Aula 05, seção 3 — Entidade ou atributo? O teste que decide*

---

### Q-A05-04

Alguém criou uma tabela `CATEGORIA` com três linhas — aluno, professor, servidor — contendo apenas código e nome. Qual é o diagnóstico da aula?

- **a)** Está correto: valores repetidos sempre pedem tabela própria;
- **b)** está errado, porque toda tabela precisa de pelo menos três colunas;
- **c)** está correto, e ainda deveria virar um relacionamento N:M com `USUARIO`;
- **d)** está errado: isso é um atributo com domínio restrito, e só viraria entidade se houvesse algo a guardar sobre a categoria, como o limite de empréstimos.

↩︎ *Aula 05, seção 3 — Entidade ou atributo? O teste que decide*

---

### Q-A05-05

Qual destas afirmações sobre o `erDiagram` do Mermaid é verdadeira?

- **a)** Os nomes de entidade podem ter espaço, desde que estejam entre aspas;
- **b)** `PK` e `FK` são opcionais e servem apenas para colorir o diagrama;
- **c)** uma entidade não pode ter chave composta na notação;
- **d)** o rótulo do relacionamento é obrigatório: sem os dois-pontos e o texto entre aspas, o diagrama não renderiza.

↩︎ *Aula 05, seção 4 — O diagrama em Mermaid*

---

### Q-A05-06

Na linha `OBRA ||--o{ EXEMPLAR`, o que a peça `o{` afirma sobre o lado do exemplar?

- **a)** Que todo exemplar pertence a exatamente uma obra;
- **b)** que uma obra tem no mínimo um exemplar;
- **c)** que uma obra tem de zero a muitos exemplares;
- **d)** que a relação é N:M e vai precisar de tabela associativa.

↩︎ *Aula 05, seção 5 — Dizendo "quantos" e "pode zero" no diagrama*

---

### Q-A05-07

No trecho `ESCRITA(isbn, id_autor, ordem)`, por que a `ordem` mora ali e não em `AUTOR` nem em `OBRA`?

- **a)** Porque a posição é do par: o mesmo autor é primeiro numa obra e terceiro em outra, e a mesma obra tem várias posições;
- **b)** porque `ordem` é um número inteiro, e as duas outras tabelas guardam texto;
- **c)** porque toda tabela associativa precisa ter pelo menos três colunas;
- **d)** porque a `ordem` é a chave primária de `ESCRITA`.

↩︎ *Aula 05, seção 5 — Dizendo "quantos" e "pode zero" no diagrama*

---

### Q-A05-08

Qual das perguntas ao cliente é descrita como "a que mais destrói modelos quando é feita tarde"?

- **a)** "Pode ter mais de um?";
- **b)** "Isso muda com o tempo? Vocês precisam do histórico?";
- **c)** "Pode não ter nenhum?";
- **d)** "Qual é o volume de dados esperado?".

↩︎ *Aula 05, seção 6 — As perguntas que faltam ao cliente*

---

⬅️ [Voltar à Aula 05](../README.md) | ➡️ [Revisão da Aula 06](../../aula-06-do-der-as-tabelas/revisao/README.md)
