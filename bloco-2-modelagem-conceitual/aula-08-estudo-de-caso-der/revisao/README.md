# Aula 08 — Revisão: Múltipla Escolha

> 🎯 8 questões sobre a [Aula 08 — Estudo de Caso: do Minimundo ao DER](../README.md). Só uma alternativa está correta em cada uma.

**Sem gabarito, de propósito.** Cada questão termina com a seção da aula onde a resposta está. Responda **tudo primeiro**, sem consultar — só depois volte às seções indicadas e corrija.

---

### Q-A08-01

No minimundo da Biblioteca, por que `AUTOR` virou entidade e `editora` continuou atributo?

- **a)** Porque o autor tem características próprias (nacionalidade) e é compartilhado entre obras, enquanto do enunciado não se pede nada além do nome da editora;
- **b)** porque autores são mais numerosos que editoras;
- **c)** porque o relacionamento com autor é N:M e com editora seria 1:N;
- **d)** porque o nome da editora já está impresso no livro e o do autor não.

↩︎ *Aula 08, seção 2 — O roteiro em seis passos*

---

### Q-A08-02

No passo 3, por que `EMPRESTIMO` recebeu chave artificial em vez da chave natural `(tombo, data_retirada)`?

- **a)** Porque chaves compostas não podem ser usadas em tabelas com três chaves estrangeiras;
- **b)** porque `tombo` já é chave primária de `EXEMPLAR` e não pode aparecer em outra chave;
- **c)** porque a chave natural falharia se o mesmo exemplar fosse emprestado duas vezes no mesmo dia;
- **d)** porque chaves artificiais são sempre preferíveis às naturais.

↩︎ *Aula 08, seção 2 — O roteiro em seis passos*

---

### Q-A08-03

No passo 4, o par de `OBRA` no relacionamento com `EXEMPLAR` é `(0,N)`. O que essa decisão afirma sobre o mundo?

- **a)** Que uma obra tem no máximo N exemplares, sendo N um limite a definir;
- **b)** que nem toda obra precisa ter exemplar — ela pode estar catalogada antes da chegada física;
- **c)** que um exemplar pode pertencer a zero ou várias obras;
- **d)** que a biblioteca não controla a quantidade de exemplares.

↩︎ *Aula 08, seção 2 — O roteiro em seis passos*

---

### Q-A08-04

Modelar `USUARIO` ligado diretamente a `OBRA` no empréstimo é o erro central do caso. Por quê?

- **a)** Porque o relacionamento ficaria N:M, o que exige tabela associativa;
- **b)** porque o ISBN é um identificador internacional e não deve ser referenciado;
- **c)** porque obras não têm data de retirada;
- **d)** porque o modelo deixa de saber qual volume físico saiu, não consegue ter dois exemplares emprestados a pessoas diferentes e perde o controle do acervo.

↩︎ *Aula 08, seção 3 — Os sete erros clássicos*

---

### Q-A08-05

Substituir a entidade `RENOVACAO` por um campo `qtd_renovacoes` em `EMPRESTIMO` causa qual perda?

- **a)** Perde-se a integridade referencial entre as duas tabelas;
- **b)** perde-se apenas desempenho nas consultas de renovação;
- **c)** perde-se quando cada renovação foi feita — e nenhuma consulta futura recupera uma data que nunca foi guardada;
- **d)** perda nenhuma: o contador é uma simplificação legítima.

↩︎ *Aula 08, seção 3 — Os sete erros clássicos*

---

### Q-A08-06

Criar uma entidade `SITUACAO` com quatro linhas (disponível, emprestado, manutenção, extraviado) e nada mais é:

- **a)** Correto, porque separa os valores possíveis numa tabela própria;
- **b)** um erro clássico: quatro valores fixos sem características próprias formam um domínio, não uma entidade;
- **c)** obrigatório, para garantir a integridade referencial do campo;
- **d)** indiferente: as duas formas produzem o mesmo esquema final.

↩︎ *Aula 08, seção 3 — Os sete erros clássicos*

---

### Q-A08-07

Na leitura em voz alta, a frase "um empréstimo pode existir sem funcionário que o registrou" recebe ❌. O que isso indica no modelo?

- **a)** Que o relacionamento deveria ser N:M;
- **b)** que `FUNCIONARIO` deveria ser entidade fraca;
- **c)** que o relacionamento é redundante e deve ser removido;
- **d)** que a participação de `EMPRESTIMO` é total, e portanto a chave estrangeira precisa ser `NOT NULL`.

↩︎ *Aula 08, seção 4 — Validando o modelo: a leitura em voz alta*

---

### Q-A08-08

Por que a leitura em voz alta é apresentada como a validação mais eficaz?

- **a)** Porque transforma cada linha do diagrama numa frase que pode ser confirmada ou negada por quem entende do negócio — e isso encontra mais defeitos em cinco minutos que uma hora olhando o desenho;
- **b)** porque é a única forma de verificar a normalização do modelo;
- **c)** porque substitui a necessidade de escrever as regras de negócio;
- **d)** porque garante que o diagrama vai renderizar corretamente no GitHub.

↩︎ *Aula 08, seção 4 — Validando o modelo: a leitura em voz alta*

---

⬅️ [Voltar à Aula 08](../README.md) | ➡️ [Revisão da Aula 09](../../../bloco-3-modelo-relacional/aula-09-modelo-relacional/revisao/README.md)
