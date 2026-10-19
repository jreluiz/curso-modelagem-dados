# Aula 08 — Agregação e Estudo de Caso

> 🎯 Objetivos: reconhecer quando um relacionamento precisa virar unidade, desenhar a agregação em Chen e conduzir um projeto conceitual completo do minimundo ao esquema lógico.
> 🎬 Slides da aula: [apresentacao-08-agregacao-e-estudo-de-caso.pdf](apresentacao/apresentacao-08-agregacao-e-estudo-de-caso.pdf)

## 1. O relacionamento que precisa se relacionar

A biblioteca também empresta **salas de estudo**. O aluno reserva a sala para uma data e um horário — um N:M com atributo, exatamente como a Aula 06 ensinou:

```
   ALUNO ---|N| RESERVA{RESERVA} ---|M| SALA
   RESERVA tem o atributo: data_hora
```

Até aqui, nada novo. Aí chega uma regra nova do balcão: *"o aluno pode requisitar um projetor ou um notebook **para aquela reserva** — o equipamento fica na sala durante o período reservado e volta no fim."*

Onde entra o equipamento nesse modelo? Tente as três saídas óbvias e veja as três falharem:

- **Ligar o equipamento ao `ALUNO`?** Aí o modelo diz que o aluno pegou um projetor, sem dizer para qual reserva. Ele reserva quatro salas por semana;
- **Ligar ao `SALA`?** Diz que a sala tem um projetor, o que é outra coisa: o projetor não é da sala, ele é levado até ela;
- **Ligar aos dois, com dois relacionamentos separados?** Aí o modelo permite a combinação impossível — o equipamento ligado a um aluno e a uma sala que não formam uma reserva.

A terceira saída merece ser desenhada, porque é a que parece funcionar:

```mermaid
flowchart LR
    EQP_X[EQUIPAMENTO] ---|N| USA{USA}
    USA ---|1| ALUNO_X[ALUNO]
    EQP_X ---|N| EM{EM}
    EM ---|1| SALA_X[SALA]
    ALUNO_X ---|N| RES_X{RESERVA}
    RES_X ---|M| SALA_X
```

Leia o que ele permite: o projetor está ligado à Ana **e** à sala 204, sem que exista reserva nenhuma da Ana para a 204. Os três relacionamentos são independentes, e nada obriga que as pontas se encontrem. O modelo aceita uma combinação que o mundo não tem.

O equipamento não se liga ao aluno nem à sala: liga-se **ao par**, àquela reserva específica. É precisamente o problema que a agregação resolve.

### ✏️ Tente você

Os alunos se inscrevem nas **oficinas** de pesquisa bibliográfica — um N:M entre `ALUNO` e `OFICINA`. Chegaram duas informações novas. Para cada uma, diga se ela é **atributo do losango** ou se é **uma coisa que se liga ao encontro** do aluno com a oficina:

1. a **nota de participação** que o instrutor dá a cada aluno em cada oficina;
2. o **material impresso** entregue ao aluno naquela oficina — cada material tem número de patrimônio e volta a ser entregue em outras oficinas.

<details>
<summary>Resposta</summary>

1. **Atributo do losango.** A nota é **um valor** por par aluno-oficina, e cabe dentro do relacionamento, como a `ordem` do `ESCREVE` na Aula 06. Nada se liga ao par: o par só **tem** um valor.
2. **Uma coisa que se liga ao encontro.** O material tem identidade própria — o patrimônio — e se liga àquela participação específica, exatamente como o projetor se liga à reserva.

A pergunta que separa os dois: o que está do outro lado é **um valor** do par, ou **uma coisa** com identidade própria?
</details>

## 2. Agregação: tratar um relacionamento como uma coisa

**Agregação** é o recurso do modelo entidade-relacionamento que trata **um relacionamento inteiro como se fosse uma entidade**, para que ele possa participar de outro relacionamento.

Desenha-se com um **retângulo em volta** do relacionamento e das entidades que ele liga:

```mermaid
flowchart LR
    subgraph USO[USO_DA_SALA]
        ALUNO[ALUNO] ---|N| RES{RESERVA}
        RES ---|M| SALA[SALA]
        RES --- dh((data_hora))
    end
    USO ---|N| REQ{REQUISITA}
    REQ ---|M| EQP[EQUIPAMENTO]
    EQP --- pat(("<u>patrimonio</u>"))
```

Lendo o desenho: o que está dentro da caixa é uma unidade chamada `USO_DA_SALA` — *este aluno, nesta sala, neste horário*. É **essa unidade** que requisita equipamentos, e cada equipamento pode ser requisitado em vários usos diferentes, em datas diferentes.

> 💡 O teste que identifica uma agregação é sempre o mesmo: **"o que está do outro lado se liga a uma das entidades, ou ao encontro delas?"** Se for ao encontro, é agregação. A prescrição que sai de uma consulta médica, o pagamento que se registra para a matrícula de um aluno num curso, o equipamento que sai de uma reserva — os três são o mesmo padrão.

> ⚠️ **Nem todo relacionamento a mais é agregação.** Se o equipamento fosse simplesmente *do aluno* — ele leva o projetor para onde quiser —, bastava um relacionamento comum entre `ALUNO` e `EQUIPAMENTO`. A agregação só se justifica quando a coisa de fora **depende do par**, e não de cada um separadamente.

> 📖 O Heuser trata a agregação junto com as construções avançadas do modelo ER, com a mesma notação de caixa em volta.

### ✏️ Tente você

Desenhe em Mermaid o item 2 do Tente você anterior: a inscrição do aluno na oficina como agregação, e o `MATERIAL` ligado a ela. Cada participação recebe vários materiais, e cada material é entregue em várias participações ao longo do ano.

<details>
<summary>Resposta</summary>

```mermaid
flowchart LR
    subgraph PART[PARTICIPACAO]
        ALUNO[ALUNO] ---|N| INS{INSCREVE_SE}
        INS ---|M| OFI[OFICINA]
    end
    PART ---|N| REC{RECEBE}
    REC ---|M| MAT[MATERIAL]
    MAT --- pat(("<u>patrimonio</u>"))
```

A aresta do `RECEBE` sai **da caixa**, e não de `ALUNO` nem de `OFICINA`: é isso que o desenho afirma. E as duas pontas do `RECEBE` têm letra de muitos, porque a ligação nova também é N:M.
</details>

## 3. A alternativa: promover o relacionamento a entidade

Existe uma segunda saída para o mesmo problema, e você vai encontrá-la em muitos modelos por aí: transformar a reserva em uma **entidade associativa** — uma entidade de verdade, com chave própria.

```
   RESERVA(codigo, data_hora, matricula → ALUNO, cod_sala → SALA)
   REQUISICAO(codigo → RESERVA, patrimonio → EQUIPAMENTO)
```

Qual usar? A diferença é de **momento**, não de gosto:

| | Agregação | Entidade associativa |
|---|---|---|
| Onde vive | modelo conceitual | modelo lógico |
| O que preserva | que aquilo **é** uma ligação, não uma coisa | a facilidade de referenciar |
| Quando escolher | ao desenhar o DER com o cliente | ao converter para tabelas |

E é isso que acontece na conversão: **toda agregação vira uma tabela associativa** no modelo lógico, e quem se liga a ela referencia a chave dessa tabela. O `REQUISITA` do diagrama acima virou a tabela `REQUISICAO`, que aponta para a reserva inteira — não para o aluno, não para a sala.

### ✏️ Tente você

Converta para esquema lógico a agregação que você desenhou no Tente você anterior — participação na oficina e material recebido.

<details>
<summary>Resposta</summary>

```
   ALUNO(matricula, nome)
   OFICINA(codigo, tema, data)
   MATERIAL(patrimonio, descricao)
   PARTICIPACAO(matricula → ALUNO, cod_oficina → OFICINA)
   RECEBE(matricula + cod_oficina → PARTICIPACAO,
          patrimonio → MATERIAL)
```

A agregação virou a tabela `PARTICIPACAO`, e o `RECEBE` aponta para ela com **uma chave estrangeira de duas colunas** — o par inteiro. Se `RECEBE` tivesse `matricula → ALUNO` e `cod_oficina → OFICINA` como duas ligações independentes, aceitaria material entregue numa oficina que o aluno nunca fez: a combinação impossível da seção 1, voltando pela tradução.
</details>

> ⚠️ **Não desenhe o retângulo da agregação em volta de qualquer coisa "para dar destaque".** A caixa tem significado: ela diz *"isto aqui é a unidade que participa da próxima ligação"*. Caixa sem relacionamento saindo dela não é agregação, é enfeite — e confunde quem lê.

## 4. Estudo de caso — o projeto, parte 1: o minimundo

Chega de fragmentos. Agora o projeto inteiro, do texto ao esquema, na ordem em que se faz de verdade.

> 📋 **Minimundo — Biblioteca Universitária**
>
> A biblioteca controla o acervo e os empréstimos. O acervo é formado por **obras**, e de cada obra a biblioteca possui um ou mais **exemplares** físicos, numerados de 1 em diante dentro da obra. Cada obra tem ISBN, título, ano e uma editora; uma obra é escrita por um ou mais autores, e a ordem de assinatura importa para a ficha catalográfica. Os alunos, identificados pela matrícula, retiram exemplares por quinze dias. Cada empréstimo tem número próprio, registra a data de retirada e, quando o exemplar volta, a data de devolução. O histórico é mantido para sempre — empréstimo devolvido não é apagado.

Dessa descrição saem as regras numeradas da Aula 04. Nove bastam:

```
   RN-01  Uma obra é publicada por exatamente uma editora.
   RN-02  Uma obra tem um ou mais autores, com ordem de assinatura.
   RN-03  Uma obra tem zero ou mais exemplares no acervo.
   RN-04  Um exemplar pertence a exatamente uma obra e é numerado dentro dela.
   RN-05  Um empréstimo refere-se a exatamente um exemplar.
   RN-06  Um empréstimo pertence a exatamente um aluno.
   RN-07  Um aluno pode ter vários empréstimos, simultâneos ou não.
   RN-08  O prazo padrão é de quinze dias, contados da retirada.
   RN-09  Empréstimo devolvido é mantido no histórico.
```

> 💡 Repare que a **RN-08 e a RN-09 não vão virar desenho nenhum** — prazo e política de guarda não têm símbolo em Chen. Elas ficam na lista, em texto, e é assim que se evita perder informação por falta de notação. Um modelo é o diagrama **mais** a lista.

### ✏️ Tente você

O balcão mandou mais uma frase: *"Um aluno pode reservar um exemplar que está emprestado. Cada exemplar tem no máximo uma reserva ativa, e a reserva vale por 48 horas depois da devolução — passado o prazo, o exemplar volta para a estante."*

Escreva as regras numeradas que saem dela, continuando a partir de RN-10, e diga quais viram desenho e quais ficam só em texto.

<details>
<summary>Resposta</summary>

```
   RN-10  Um aluno pode reservar exemplares que estão emprestados.
   RN-11  Um exemplar tem no máximo uma reserva ativa.
   RN-12  A reserva vale 48 horas depois da devolução.
```

Só a **RN-10** vira desenho: um relacionamento `RESERVA` entre `ALUNO` e `EXEMPLAR`. A **RN-11** e a **RN-12** ficam em texto, pela mesma razão da RN-08: elas têm **tempo dentro**. "Ativa" e "48 horas" dependem do relógio, e o diagrama de Chen não tem símbolo para relógio. Ao longo da história um exemplar tem muitas reservas; o que a RN-11 limita é quantas valem **ao mesmo tempo**.
</details>

## 5. Estudo de caso — o projeto, parte 2: o diagrama e o esquema

Cada regra vira uma parte do desenho, e cada parte do desenho aponta para uma regra:

```mermaid
flowchart LR
    AUTOR[AUTOR] ---|N| ESC{ESCREVE}
    ESC ---|M| LIVRO[LIVRO]
    ESC --- ord((ordem))
    EDITORA[EDITORA] ---|1| PUB{PUBLICADO_POR}
    PUB ===|N| LIVRO
    LIVRO ---|1| VOL{{VOLUME_DE}}
    VOL ===|N| EXEMPLAR[[EXEMPLAR]]
    EXEMPLAR ---|1| REF{REFERE_SE}
    REF ---|N| EMP[EMPRESTIMO]
    ALUNO[ALUNO] ---|1| FAZ{FAZ}
    FAZ ===|N| EMP
```

| Trecho do diagrama | Regra | Decisão tomada |
|---|:---:|---|
| `ESCREVE` é N:M com `ordem` no losango | RN-02 | a ordem é do par autor-obra; não cabe em nenhum dos dois |
| linha dupla em `LIVRO` no `PUBLICADO_POR` | RN-01 | toda obra tem editora — participação total |
| `EXEMPLAR` com retângulo duplo | RN-04 | entidade fraca: numeração só distingue dentro da obra |
| linha simples em `LIVRO` no `VOLUME_DE` | RN-03 | obra pode existir sem exemplar comprado |
| linha dupla em `EMPRESTIMO` nos dois lados | RN-05, RN-06 | empréstimo não existe sem aluno nem sem exemplar |

E o esquema lógico, pelas regras da Aula 07:

```
   ALUNO(matricula, nome, email)
   EDITORA(cnpj, nome, cidade)
   AUTOR(cpf, nome, nacionalidade)
   LIVRO(isbn, titulo, ano, cnpj → EDITORA)
   ESCREVE(cpf → AUTOR, isbn → LIVRO, ordem)
   EXEMPLAR(isbn → LIVRO, numero_ex, situacao)
   EMPRESTIMO(numero, data_retirada, data_devolucao,
              matricula → ALUNO, isbn + numero_ex → EXEMPLAR)
```

> 💻 **Modelos desta aula:** [`estudo-de-caso-biblioteca.md`](exemplos/estudo-de-caso-biblioteca.md) — o caso completo, com as políticas de exclusão e o que ficou de fora do desenho. E [`agregacao-sala-equipamento.md`](exemplos/agregacao-sala-equipamento.md), com a agregação da seção 2 convertida.

## 6. O ritual de leitura: o modelo em voz alta

Um modelo entregue sem esta última etapa é um modelo não conferido. São quatro perguntas, e elas encontram mais defeito em cinco minutos do que uma hora olhando o desenho:

1. **Leia cada linha nas duas direções.** *"Todo empréstimo tem um aluno"* — verdade. *"Todo aluno tem um empréstimo"* — falso, e por isso aquele lado tem linha simples;
2. **Invente três ocorrências reais e tente guardá-las.** A obra doada, sem editora conhecida, cabe? Se não cabe, ou a RN-01 está errada ou falta uma editora "não informada" — decida **com o cliente**;
3. **Tente inserir e apagar.** Dá para cadastrar uma obra nova antes de comprar exemplar? (Sim — foi para isso que a participação ficou parcial.) Apagar um aluno formado apaga o histórico?
4. **Procure o mesmo dado em dois lugares.** Se `nome_editora` aparecesse dentro de `LIVRO`, seria a redundância da Aula 01 voltando pela porta dos fundos.

> ⚠️ Este modelo **passa nas quatro perguntas e ainda assim tem um furo conhecido**: nada impede dois empréstimos em aberto do mesmo exemplar. Ele está registrado, em texto, e é responsabilidade da aplicação. Modelo bom não é o sem furo — é o que **sabe onde estão os seus furos**.

## 🏋️ Exercícios da aula

Use o **modelo entidade-relacionamento** para o projeto conceitual das bases de dados abaixo. Em todos os exercícios:

- para cada **entidade**, especifique os atributos relevantes — simples, compostos ou multivalorados — incluindo o **atributo identificador**;
- para cada **relacionamento**, dê a **cardinalidade** dos dois lados, diga se a **participação** de cada entidade é total ou parcial e inclua os atributos do relacionamento, se houver;
- nas **agregações**, diga qual relacionamento virou unidade e o que se liga a ela;
- entregue também o **esquema lógico**, marcando as chaves primárias e indicando com `→` cada chave estrangeira e a tabela que ela aponta.

Cada enunciado diz **o que se deseja registrar**. Ele não diz o que é entidade, o que é atributo, o que é relacionamento e o que é agregação — essa decisão é sua, e é o exercício.

> 💡 O percurso de um projeto inteiro, do texto ao esquema, está em [`estudo-de-caso-biblioteca.md`](exemplos/estudo-de-caso-biblioteca.md); a agregação da seção 2, desenhada e convertida, em [`agregacao-sala-equipamento.md`](exemplos/agregacao-sala-equipamento.md). Leia antes de começar.

Na pasta `aula-08/` do seu repositório, um arquivo `.md` por exercício:

1. **`ex01.md`** — A biblioteca oferece **oficinas de pesquisa bibliográfica**. De cada oficina guardam-se um código, o tema e a data; de cada aluno, a matrícula e o nome. Um aluno pode se inscrever em várias oficinas, e uma oficina recebe vários alunos. Quem conclui uma oficina recebe um **certificado**, com número único e data de emissão. O certificado é **daquela participação**: o aluno que conclui duas oficinas recebe dois certificados, e quem se inscreve e não conclui não recebe nenhum.

   *Confere assim: o certificado não se liga ao aluno nem à oficina — se ligou, o seu modelo não sabe dizer de qual oficina é o certificado. A ligação dele é 1:1, com participação total de um lado só. E, no esquema lógico, a chave estrangeira do certificado tem duas colunas.*

2. **`ex02.md`** — A biblioteca tem **salas de estudo**, cada uma com número e capacidade, que os alunos reservam para uma data e um horário. Ela também tem **monitores** — estudantes bolsistas, com matrícula e nome. Cada sala tem um monitor **responsável**, que cuida dela o ano inteiro; um monitor pode ser responsável por mais de uma sala, e há monitores que não são responsáveis por nenhuma. Nas semanas de entrega de trabalhos, um monitor pode ainda ser **escalado** para acompanhar uma reserva específica — aquele aluno, naquela sala, naquele horário —, e cada reserva tem no máximo um monitor escalado.

   *Confere assim: `MONITOR` aparece em dois relacionamentos, e eles saem de lugares diferentes do desenho — um de `SALA`, o outro da caixa da agregação. Se os dois saem de `SALA`, o modelo perdeu a qual reserva o monitor foi escalado; se os dois saem da caixa, o responsável passou a mudar a cada reserva.*

3. **`ex03.md`** — **exercício autoral.** Escolha um minimundo de dificuldade ⭐⭐ do [catálogo](../../recursos/minimundos.md) — Academia, Oficina mecânica, Hotel ou Escola de idiomas — e entregue o projeto conceitual completo, na ordem da seção 4: (i) a lista de **regras numeradas** que você extraiu do enunciado, com no mínimo oito; (ii) o **DER em Mermaid**, com cardinalidade e participação nos dois lados de cada relacionamento; (iii) o **esquema lógico**; (iv) o resultado das **quatro perguntas** da seção 6, escrito. *Confere assim: cada relacionamento do seu DER tem que apontar para pelo menos uma regra da sua lista — o que não aponta para regra nenhuma é invenção sua e deve sair, e a regra que não virou desenho precisa aparecer na lista em texto.*

### 📤 Entrega

Estes exercícios são feitos em sala e vão para o **seu repositório** `exercicios-modelagem-dados`:

```bash
cd ..                 # da pasta da aula para a raiz do repositório
git add aula-08/
git commit -m "Resolve exercícios da aula 08"
git push
```

Confira no navegador que a pasta apareceu em `github.com/SEU-USUARIO/exercicios-modelagem-dados`.

## 🧠 Revisão

[8 questões de múltipla escolha](revisao/README.md) para conferir se os conceitos ficaram sólidos. Responda sem consultar a aula — depois volte e corrija.

---

⬅️ [Aula 07 — Do Relacional à Integridade Referencial](../aula-07-relacional-e-integridade/README.md) | ➡️ [Aula 09 — Especialização e o Esquema Completo](../../bloco-3-do-modelo-ao-banco/aula-09-especializacao-e-o-esquema-completo/README.md)
