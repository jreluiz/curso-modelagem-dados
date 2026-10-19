# Aula 10 — Revisão: Múltipla Escolha

> 🎯 8 questões sobre a [Aula 10 — Normalização Essencial](../README.md). Só uma alternativa está correta em cada uma.

**Sem gabarito, de propósito.** Cada questão termina com a seção da aula onde a resposta está. Responda **tudo primeiro**, sem consultar — só depois volte às seções indicadas e corrija.

As três últimas são marcadas **[ENADE]**: trazem um **texto-base** com uma situação concreta, seguido do comando. São mais longas de ler e cobram interpretação, não memória — as alternativas continuam simples, como nas demais.

---

### Q-A10-01

Na tabela `RETIRADA(isbn, numero_ex, data_retirada, titulo, codigo_usuario)`, com chave `(isbn, numero_ex, data_retirada)`, um livro recém-comprado, que ainda não foi retirado nenhuma vez, não pode ser cadastrado. Essa situação é uma anomalia de:

- **a)** alteração;
- **b)** exclusão;
- **c)** consulta;
- **d)** inserção.

↩︎ *Aula 10, seção 1 — A planilha volta, disfarçada de tabela*

---

### Q-A10-02

A dependência funcional `isbn → titulo` significa que:

- **a)** para cada ISBN existe um único título;
- **b)** para cada título existe um único ISBN;
- **c)** o título é a chave primária da tabela de livros;
- **d)** o ISBN e o título aparecem sempre juntos na mesma tabela.

↩︎ *Aula 10, seção 2 — Dependência funcional: "se eu sei isto, eu sei aquilo"*

---

### Q-A10-03

Qual destas tabelas viola a primeira forma normal?

- **a)** `LIVRO(isbn, titulo, ano)`, com um único valor em cada célula;
- **b)** `EXEMPLAR(isbn, numero_ex, situacao)`, com chave composta;
- **c)** `EDITORA(cnpj, nome, telefones)`, em que `telefones` guarda vários números separados por vírgula;
- **d)** `USUARIO(codigo, nome, email)`, em que dois usuários têm o mesmo nome.

↩︎ *Aula 10, seção 3 — A primeira forma normal: cada célula, um valor*

---

### Q-A10-04

Segundo a aula, quando a chave primária de uma tabela tem uma coluna só:

- **a)** a tabela viola a 2FN, porque a 2FN exige chave composta;
- **b)** a tabela, se estiver na 1FN, está automaticamente na 2FN, porque não existe parte da chave;
- **c)** a tabela está automaticamente na 3FN, porque não pode haver dependência transitiva;
- **d)** a tabela não pode ter dependência funcional nenhuma.

↩︎ *Aula 10, seção 4 — A segunda forma normal: nada depende de parte da chave*

---

### Q-A10-05

Na tabela `LIVRO(isbn, titulo, cnpj, nome_editora)`, com chave `isbn`, a dependência `cnpj → nome_editora` é:

- **a)** parcial, porque o `cnpj` é parte da chave;
- **b)** da chave, porque o `cnpj` identifica o livro;
- **c)** transitiva, porque uma coluna que não é chave determina outra — e a tabela não está na 3FN;
- **d)** inexistente, porque duas editoras não podem ter o mesmo nome.

↩︎ *Aula 10, seção 5 — A terceira forma normal: nada depende de quem não é chave*

---

### Q-A10-06

**[ENADE]**

Ao normalizar a tabela de turmas de uma escola, um analista examinou as 40 linhas da planilha e notou que cada curso aparecia sempre com o mesmo coordenador. Concluiu que `curso → coordenador` e criou a tabela `CURSO(curso, coordenador)`.

Ao apresentar o esquema, a secretaria explicou que os cursos com turmas diurnas e noturnas têm um coordenador para cada turno, e que isso só não aparecia na planilha porque o turno noturno começou neste ano.

Considerando a situação apresentada, a interpretação mais adequada é:

- **a)** o analista acertou, porque 40 linhas são uma amostra suficiente para provar a dependência;
- **b)** dependências funcionais saem das regras do minimundo, e os dados só mostram quando uma não vale — a regra do turno desfaz `curso → coordenador`;
- **c)** a planilha está errada e deve ser corrigida para manter um coordenador por curso;
- **d)** a dependência continua valendo, e o turno deve virar um atributo multivalorado do coordenador.

↩︎ *Aula 10, seção 2 — Dependência funcional: "se eu sei isto, eu sei aquilo"*

---

### Q-A10-07

**[ENADE]**

As reservas de salas de uma biblioteca estão na tabela `RESERVA(numero_sala, data, horario, andar, capacidade, codigo_usuario)`, com chave `(numero_sala, data, horario)`. Cada sala fica num andar e tem uma capacidade.

Quando uma sala mudou de andar, foi preciso corrigir 230 linhas, e uma sala nova, ainda sem nenhuma reserva, não pôde ser cadastrada.

Considerando a situação apresentada, a correção adequada é:

- **a)** mover `andar` e `capacidade` para uma tabela `SALA(numero_sala, andar, capacidade)`, porque eles dependem só de parte da chave;
- **b)** acrescentar o `andar` à chave primária, para que a mudança de andar gere linhas novas;
- **c)** mover o `codigo_usuario` para uma tabela própria, porque ele não faz parte da chave;
- **d)** manter a tabela e corrigir as linhas por um procedimento automático sempre que uma sala mudar de andar.

↩︎ *Aula 10, seção 4 — A segunda forma normal: nada depende de parte da chave*

---

### Q-A10-08

**[ENADE]**

Para a tela de empréstimos de uma biblioteca abrir mais rápido, um desenvolvedor acrescentou à tabela `EMPRESTIMO` as colunas `titulo` e `nome_usuario`, copiadas de `LIVRO` e de `USUARIO` no momento do empréstimo. Ninguém mediu o tempo da tela antes da mudança, e nenhum processo atualiza as cópias.

Meses depois, uma usuária mudou de nome, e o histórico de empréstimos passou a mostrar dois nomes diferentes para a mesma pessoa.

Considerando a situação apresentada, a avaliação mais adequada é:

- **a)** a mudança foi correta, porque desnormalizar sempre melhora o desempenho de uma tela;
- **b)** o problema é do cadastro de usuários, que não deveria permitir mudança de nome;
- **c)** a cópia deveria ter sido feita também na tabela de exemplares, para manter a consistência;
- **d)** a duplicação foi feita sem as três exigências — medida, escrita e com dono — e trouxe de volta a anomalia de alteração.

↩︎ *Aula 10, seção 6 — A conferência, e até onde ir*

---

⬅️ [Voltar à Aula 10](../README.md) | 🏠 [Início](../../../README.md)
