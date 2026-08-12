# 🧯 Erros Comuns

Num curso de modelagem não existe compilador: o modelo errado não reclama, não fica vermelho, não avisa. Ele só custa caro depois. Este catálogo é o substituto — a lista das concepções erradas que aparecem todo semestre, com o sintoma, a causa e a cura.

Duas metades: os erros de **modelagem** (Blocos 1 e 2) e os erros de **abstração e normalização** (Blocos 3 e 4).

---

## Parte 1 — Erros de modelagem

### Promover um atributo a entidade sem necessidade

**Sintoma:** o modelo tem uma entidade `SEXO`, com duas ocorrências: "M" e "F". Ou uma `ESTADO_CIVIL` com quatro.

**Causa:** confundir "é um valor de domínio limitado" com "é uma coisa do mundo com identidade própria".

**Cura:** uma entidade precisa ter **atributos próprios** ou **relacionamentos próprios**. Se a tal entidade só tem código e descrição, e ninguém nunca vai pendurar nada nela, ela é um atributo com domínio restrito. Pergunte: *"o cliente algum dia vai querer guardar mais alguma coisa sobre isso?"* Se sim, entidade. Se não, atributo.

> 💡 O contrário também acontece e é pior: `TELEFONE` tratado como atributo quando o cliente precisa saber o tipo, o horário de contato e quem atendeu. Aí é entidade.

---

### O N:M que ninguém viu

**Sintoma:** o modelo diz que um `PEDIDO` se liga a um `PRODUTO` só. Aí chega o primeiro pedido com dois produtos.

**Causa:** ler o relacionamento em uma direção só. "Um pedido tem um produto" parece verdade quando você imagina o pedido mais simples possível.

**Cura:** leia **sempre nas duas direções**, e sempre no plural: *"Um pedido pode conter **vários** produtos?"* e *"Um produto pode aparecer em **vários** pedidos?"* Dois "sim" = N:M. E repare que os atributos do relacionamento (quantidade, preço da vez) só têm onde morar **no losango** — não cabem em nenhuma das duas entidades.

---

### A chave estrangeira do lado errado

**Sintoma:** num 1:N entre `DEPARTAMENTO` e `FUNCIONARIO`, a chave estrangeira foi parar em `DEPARTAMENTO`. Aí o primeiro departamento com dois funcionários obriga a repetir a linha inteira do departamento.

**Causa:** copiar a direção da seta do diagrama em vez de perguntar de que lado cabe um valor só.

**Cura:** **a chave estrangeira mora sempre do lado N** — do lado que tem um só do outro. Um funcionário tem um departamento: a coluna cabe na linha do funcionário. Um departamento tem muitos funcionários: não cabe uma coluna com muitos valores, porque a célula guarda um valor só.

> ⚠️ Teste de uma linha: *"desse lado, quantos do outro cabem?"* Se a resposta for "vários", a chave estrangeira **não** é aqui.

---

### "Quantos" e "é obrigatório" são duas perguntas

**Sintoma:** o aluno escreve "1:N obrigatório" achando que disse duas coisas sobre o mesmo lado.

**Causa:** são eixos **independentes**. O primeiro responde *"quantos, no máximo?"*; o segundo responde *"pode zero?"*.

**Cura:** todo lado de todo relacionamento tem **duas** respostas. Um departamento tem no máximo 1 gerente (quantos) e obrigatoriamente 1 gerente (não pode zero). São afirmações diferentes sobre o mundo: a primeira decide onde a chave estrangeira mora, a segunda decide se ela aceita valor nulo — e é ela que vira a **linha dupla** da participação total no diagrama.

---

### Entidade dependente × entidade com vínculo obrigatório

**Sintoma:** tudo que tem vínculo obrigatório é tratado como parte da outra entidade, e some junto quando ela some.

**Causa:** confundir *dependência de existência* com *dependência de identificação*.

**Cura:** a entidade dependente é a que **não consegue se identificar sozinha** — a chave dela inclui a chave da dona. `DEPENDENTE` de um funcionário é dependente: existem dois "João" e só o par (funcionário, nome) distingue. Já `PEDIDO` tem número próprio e único: mesmo que exija cliente, se identifica sozinho.

> ⚠️ Teste decisivo: **tire a entidade dona e pergunte se a chave ainda identifica.** Se a resposta for não, é dependente — e só aí apagar em cascata é o comportamento certo.

---

### Chave estrangeira apontando para o que não é chave

**Sintoma:** um pedido que guarda o **nome** do cliente para referenciá-lo.

**Causa:** referenciar o que é legível em vez do que é identificador.

**Cura:** chave estrangeira referencia **chave primária ou candidata** — nada mais. Nome não é único, e se fosse, mudaria. O nome legível você busca seguindo a ligação.

---

### Chave primária composta desnecessária

**Sintoma:** `PRODUTO` com chave `(codigo, nome, fabricante)`.

**Causa:** achar que a chave precisa "descrever" a linha.

**Cura:** a chave é o **conjunto mínimo** que identifica. Se `codigo` já identifica, acrescentar qualquer coisa não é chave candidata — é desperdício que se propaga para toda referência que apontar para ela.

---

### A entidade que não foi normalizada por preguiça

**Sintoma:** `PEDIDO(numero, data, cliente_id, cliente_nome, cliente_cidade, …)` — "é que assim eu não preciso ir buscar em outro lugar".

**Causa:** otimizar antes de existir problema, e pagar com o dado errado em dois lugares.

**Cura:** o nome do cliente depende do **cliente**, não do pedido — é 3FN, e a regra é uma frase: *todo atributo depende da chave, e de nada além dela*. Quando o cliente muda de cidade, a versão duplicada não muda junto, e aí ninguém sabe qual é a verdadeira.

> 💡 Desnormalizar é decisão legítima — **depois** de medir, com o motivo escrito e alguém responsável por manter as cópias em dia. Antes disso é só erro com nome bonito.

---

### O ciclo redundante

**Sintoma:** `ALUNO` → `TURMA` → `CURSO`, e também `ALUNO` → `CURSO` direto.

**Causa:** modelar cada frase do enunciado como um relacionamento independente.

**Cura:** nem todo ciclo é erro — o erro é o ciclo em que **um caminho é derivável do outro**. Se o curso do aluno é sempre o curso da turma dele, o relacionamento direto é redundante e vai permitir contradição. Se o aluno pode se matricular em curso diferente do da turma, os dois caminhos significam coisas diferentes e ambos ficam. Decida com o cliente, e **escreva a decisão**.

---

### O modelo que não foi lido em voz alta

**Sintoma:** o diagrama está bonito e ninguém percebeu que ele afirma que um empréstimo pode existir sem exemplar.

**Cura:** o ritual final de todo modelo — leia **cada** linha do diagrama como uma frase em português e pergunte se é verdade no minimundo. Cinco minutos de leitura em voz alta encontram mais defeitos que uma hora olhando o desenho.

---

## Parte 2 — Erros de abstração e normalização

### Especialização que não precisava existir

**Sintoma:** `CLIENTE` especializado em `CLIENTE_ATIVO` e `CLIENTE_INATIVO`, e a única diferença entre as duas é… ser ativo.

**Causa:** confundir *estado* com *tipo*.

**Cura:** especialização se justifica quando a subclasse tem **atributos próprios ou relacionamentos próprios** que as outras não têm. Se a única diferença cabe num atributo `situacao`, use o atributo. Pergunte: *"o que eu guardo sobre esta subclasse que não faz sentido guardar sobre a outra?"* Se a resposta for "nada", não há especialização.

---

### Herança usada para papel temporário

**Sintoma:** `PESSOA` especializada em `ALUNO` e `EX_ALUNO`. Aí o aluno se forma.

**Causa:** modelar como tipo aquilo que é **papel** — e papel muda com o tempo, tipo não.

**Cura:** herança é para o que a coisa **é** e não deixa de ser. Um aluno que se forma continua sendo pessoa e passa a ter outro papel; se ele "trocasse de classe", todo o histórico ligado a ele teria de migrar junto. Papel que muda vira **relacionamento com período**, não subclasse.

> ⚠️ Teste: *"isso pode mudar durante a vida do registro?"* Se pode, não é especialização.

---

### Subclasses que se sobrepõem, tratadas como disjuntas

**Sintoma:** `FUNCIONARIO` especializado em `PROFESSOR` e `PESQUISADOR`, e chega alguém que é os dois.

**Causa:** assumir disjunção sem perguntar.

**Cura:** toda especialização responde a **duas** perguntas independentes — *"uma ocorrência pode estar em mais de uma subclasse?"* (disjunta × sobreposta) e *"toda ocorrência precisa estar em alguma?"* (total × parcial). São quatro combinações possíveis, e você **escolhe uma e escreve qual**. O diagrama que não diz qual é está incompleto.

---

### Agregação confundida com relacionamento comum

**Sintoma:** um relacionamento ligado diretamente a outro relacionamento, sem nada em volta.

**Causa:** perceber que "isso precisa se relacionar com aquilo" e ligar as duas coisas sem se perguntar o que está sendo tratado como unidade.

**Cura:** agregação existe quando **um relacionamento inteiro passa a se comportar como uma entidade** para poder participar de outro relacionamento. O caso clássico: `MEDICO` **atende** `PACIENTE` — e é *esse atendimento* que gera uma prescrição. A prescrição não se liga ao médico nem ao paciente separadamente: liga-se ao par. Desenhe o retângulo em volta do losango e diga por escrito qual é a unidade agregada.

---

### Classe UML com atributo que é entidade

**Sintoma:** a classe `Pedido` tem um atributo `cliente: String`.

**Causa:** traduzir o DER para UML atributo por atributo, sem notar que aquele "atributo" era uma entidade do outro lado de um relacionamento.

**Cura:** o que era **entidade** no DER vira **classe** na UML, e o relacionamento vira **associação** — uma linha entre as duas classes, com multiplicidade nas pontas. Atributo de classe guarda valor; ligação entre coisas do mundo é associação. Se o tipo do atributo é o nome de outra classe do seu diagrama, ele deveria ser uma associação.

---

### A 1FN "resolvida" com `telefone1`, `telefone2`, `telefone3`

**Sintoma:** o atributo multivalorado virou três colunas numeradas.

**Causa:** entender a 1FN como "não pode ter lista na célula" e parar aí.

**Cura:** três colunas numeradas **não estão em 1FN de verdade** — só escondem o problema e criam três novos: o cliente com quatro telefones não cabe, o cliente com um telefone desperdiça duas colunas, e procurar um número exige olhar em três lugares. Atributo multivalorado vira **entidade própria**, com um relacionamento 1:N. Sempre.

---

### Aplicar a 2FN onde ela é automática

**Sintoma:** páginas de análise de dependência parcial numa tabela cuja chave tem **uma coluna só**.

**Causa:** seguir o roteiro sem olhar a chave.

**Cura:** a 2FN trata de **dependência parcial** — atributo que depende de *parte* da chave. Se a chave tem uma coluna só, não existe "parte" dela, e toda tabela em 1FN com chave simples **já está em 2FN**, sem fazer nada. A análise da 2FN só tem trabalho quando a chave é composta.

---

### Confundir a 2FN com a 3FN

**Sintoma:** o aluno decompõe corretamente, mas chama de 2FN o que era 3FN, e a justificativa escrita não bate com o que ele fez.

**Causa:** as duas tratam de "atributo no lugar errado", e a diferença está em **de quem** ele depende.

**Cura:** duas frases, e vale decorar:

- **2FN** — o atributo depende de **parte da chave**. Só existe com chave composta. É *dependência parcial*;
- **3FN** — o atributo depende de **outro atributo não-chave**, que por sua vez depende da chave. É *dependência transitiva*.

Em `ALUNO(matricula, nome, cod_curso, nome_curso)`, o `nome_curso` depende de `cod_curso`, que depende de `matricula`. Chave simples, então nada de 2FN — é 3FN.

---

### Aplicar a 4FN onde só existe uma dependência multivalorada

**Sintoma:** uma tabela com uma única lista independente é "decomposta" em duas, e uma delas fica com uma coluna só.

**Causa:** ver multivalorado e disparar o procedimento.

**Cura:** a 4FN resolve o problema de **duas ou mais** dependências multivaloradas independentes na mesma tabela — o produto cartesiano acidental, em que 3 telefones e 2 cursos viram 6 linhas que não significam nada. Com **uma** só, não há independência para separar e não há o que decompor: a 1FN já resolveu.

---

### Normalizar até quebrar

**Sintoma:** o esquema chegou à 4FN, e agora existe uma informação que o modelo não consegue mais representar.

**Causa:** decompor sem verificar se a junção das partes reconstrói o original.

**Cura:** toda decomposição precisa ser **sem perda** — remontando as tabelas, você tem de obter exatamente as linhas de antes, nem mais nem menos. Na prática, no nível deste curso: a coluna pela qual você separou precisa ser **chave em pelo menos uma** das duas tabelas resultantes. Se não for, você acabou de inventar linhas que nunca existiram.

> 💡 Normalizar não é esporte. O objetivo é eliminar redundância que causa contradição — não atingir o número mais alto de forma normal.

---

## Método universal de depuração de um modelo

Quando o modelo "parece certo" mas alguma coisa incomoda, rode estas quatro perguntas:

1. **Leia cada relacionamento em voz alta, nas duas direções.** A frase é verdade no minimundo?
2. **Invente três instâncias reais** e tente guardá-las no modelo. Alguma não cabe? Alguma exige repetir informação?
3. **Tente inserir e apagar.** Existe alguma informação que você só consegue guardar inventando uma linha falsa? (anomalia de inserção) Existe alguma que some sem querer? (anomalia de exclusão)
4. **Procure o mesmo dado escrito em dois lugares.** Se existe, quem garante que eles concordam?

---

🏠 [Voltar ao início](../README.md)
