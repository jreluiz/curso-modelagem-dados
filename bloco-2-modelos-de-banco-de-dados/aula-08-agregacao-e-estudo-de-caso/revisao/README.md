# Aula 08 — Revisão: Múltipla Escolha

> 🎯 8 questões sobre a [Aula 08 — Agregação e Estudo de Caso](../README.md). Só uma alternativa está correta em cada uma.

**Sem gabarito, de propósito.** Cada questão termina com a seção da aula onde a resposta está. Responda **tudo primeiro**, sem consultar — só depois volte às seções indicadas e corrija.

📝 **As respostas vão pelo formulário:** [responder a revisão da Aula 08](https://docs.google.com/forms/d/e/1FAIpQLScfFdnDCUtDIaRji8FKCYhZzV_xGyCTi5jWys2YisployVzpA/viewform)

Leia as 8 questões aqui e decida suas respostas antes de abrir o formulário: é **uma resposta por aluno**, com conta Google, e não dá para editar depois de enviar. Ele também pede seu usuário do GitHub. Se o seu nome não estiver na lista da turma, marque a última opção e escreva o nome completo no campo seguinte.

As três últimas são marcadas **[ENADE]**: trazem um **texto-base** com uma situação concreta, seguido do comando. São mais longas de ler e cobram interpretação, não memória — as alternativas continuam simples, como nas demais.

---

### Q-A08-01

A **agregação** é usada quando:

- **a)** um relacionamento inteiro precisa participar de outro relacionamento;
- **b)** uma entidade tem atributos demais para caber num só retângulo;
- **c)** duas entidades diferentes compartilham a mesma chave primária;
- **d)** um relacionamento liga três entidades ao mesmo tempo.

↩︎ *Aula 08, seção 2 — Agregação: tratar um relacionamento como uma coisa*

---

### Q-A08-02

Na notação de Chen, como se desenha uma agregação?

- **a)** com um losango duplo ligando as entidades envolvidas;
- **b)** com uma linha tracejada entre os dois relacionamentos;
- **c)** com um retângulo em volta do relacionamento e das entidades que ele liga;
- **d)** com uma elipse dupla pendurada no relacionamento agregado.

↩︎ *Aula 08, seção 2 — Agregação: tratar um relacionamento como uma coisa*

---

### Q-A08-03

Ao converter uma agregação para o modelo lógico, o que ela se torna?

- **a)** uma coluna a mais em cada tabela envolvida;
- **b)** uma tabela associativa, referenciada por quem se liga à agregação;
- **c)** uma entidade fraca dependente das duas entidades agregadas;
- **d)** nada: agregação existe apenas no desenho e desaparece na conversão.

↩︎ *Aula 08, seção 3 — A alternativa: promover o relacionamento a entidade*

---

### Q-A08-04

No estudo de caso, a regra *"o prazo padrão é de quinze dias"* não aparece no diagrama. Por quê?

- **a)** porque ela foi considerada pouco importante para o projeto;
- **b)** porque ela pertence ao modelo físico, e não ao conceitual;
- **c)** porque ela será descoberta apenas na etapa de implementação;
- **d)** porque regras sem símbolo em Chen ficam na lista de regras, em texto.

↩︎ *Aula 08, seção 4 — Estudo de caso — o projeto, parte 1: o minimundo*

---

### Q-A08-05

No ritual de leitura do modelo, qual das perguntas revelaria que uma obra doada, **sem editora conhecida**, não cabe no modelo da biblioteca?

- **a)** ler cada linha do diagrama nas duas direções;
- **b)** inventar ocorrências reais e tentar guardá-las no modelo;
- **c)** procurar o mesmo dado escrito em dois lugares diferentes;
- **d)** verificar se a chave primária escolhida é a menor possível.

↩︎ *Aula 08, seção 6 — O ritual de leitura: o modelo em voz alta*

---

### Q-A08-06

**[ENADE]**

Uma biblioteca universitária oferece oficinas de pesquisa bibliográfica. Um aluno pode se inscrever em várias oficinas, e cada oficina recebe vários alunos — no modelo, um relacionamento N:M entre `ALUNO` e `OFICINA`.

A coordenação pediu para registrar os certificados de conclusão. Cada certificado tem número e data de emissão e corresponde a uma participação específica: o aluno que conclui duas oficinas recebe dois certificados, e quem não conclui não recebe nenhum.

Considerando a situação apresentada, a representação mais adequada para o certificado é:

- **a)** ligar `CERTIFICADO` a `ALUNO`, porque é o aluno quem recebe o documento;
- **b)** ligar `CERTIFICADO` a `OFICINA`, porque é a oficina que emite o documento;
- **c)** tratar a inscrição como agregação e ligar `CERTIFICADO` a essa unidade;
- **d)** criar dois relacionamentos independentes, de `CERTIFICADO` para `ALUNO` e para `OFICINA`.

↩︎ *Aula 08, seção 2 — Agregação: tratar um relacionamento como uma coisa*

---

### Q-A08-07

**[ENADE]**

Numa biblioteca, os alunos reservam salas de estudo para uma data e um horário, e o modelo trata a reserva como agregação. Os monitores bolsistas passaram a ter duas funções: cada sala tem um monitor responsável, fixo durante o ano inteiro, e, nas semanas de entrega de trabalhos, um monitor pode ser escalado para acompanhar uma reserva específica.

O analista propôs ligar `MONITOR` à caixa da agregação nas duas funções, argumentando que assim todas as ligações do monitor ficam no mesmo lugar do diagrama.

Considerando a situação apresentada, a avaliação mais adequada da proposta é:

- **a)** a escala depende da reserva e deve sair da agregação, mas a responsabilidade é da sala o ano todo e deve sair de `SALA`;
- **b)** a proposta está correta, porque um mesmo elemento não deve se ligar a partes diferentes do diagrama;
- **c)** as duas funções devem sair de `SALA`, porque tanto o responsável quanto o escalado ficam na sala;
- **d)** as duas funções devem virar atributos do losango `RESERVA`, porque as duas dizem respeito à sala reservada.

↩︎ *Aula 08, seção 2 — Agregação: tratar um relacionamento como uma coisa*

---

### Q-A08-08

**[ENADE]**

No modelo das oficinas de uma biblioteca, a inscrição do aluno na oficina é uma agregação, e o certificado de conclusão se liga a ela. Ao converter o modelo, um estagiário criou a tabela `INSCRICAO(matricula → ALUNO, cod_oficina → OFICINA)` e a tabela `CERTIFICADO(numero, data_emissao, matricula → ALUNO, cod_oficina → OFICINA)`.

Na revisão do esquema, apontou-se que ele aceita um certificado para uma combinação de aluno e oficina que não existe em `INSCRICAO`.

Considerando a situação apresentada, a correção adequada é:

- **a)** acrescentar a `CERTIFICADO` uma coluna com o tema da oficina, para conferência;
- **b)** eliminar a tabela `INSCRICAO`, que ficou desnecessária com a criação do certificado;
- **c)** trocar a chave primária de `CERTIFICADO` pelo par formado por `matricula` e `cod_oficina`;
- **d)** fazer `matricula` e `cod_oficina`, em `CERTIFICADO`, formarem uma única chave estrangeira que aponte para `INSCRICAO`.

↩︎ *Aula 08, seção 3 — A alternativa: promover o relacionamento a entidade*

---

⬅️ [Voltar à Aula 08](../README.md) | 🏠 [Início](../../../README.md)
