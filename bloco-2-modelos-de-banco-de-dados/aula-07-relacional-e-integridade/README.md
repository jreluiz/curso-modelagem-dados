# Aula 07 — Do Relacional à Integridade Referencial

> 🎯 Objetivos: nomear os elementos do modelo relacional, escolher a chave primária entre as candidatas e converter um DER — inclusive um autorrelacionamento — em esquema lógico com integridade referencial.
> 🎬 Slides da aula: [apresentacao-07-relacional-e-integridade.pdf](apresentacao/apresentacao-07-relacional-e-integridade.pdf)

## 1. A tabela, agora com os nomes formais

O modelo relacional que Codd propôs em 1970, na Aula 02, tem uma ideia central: **tudo é tabela, e as ligações entre as tabelas são feitas por valor** — não por ponteiro, não por posição, não por ordem de gravação.

```
   ALUNO
   ┌───────────┬──────────────┬──────────────────────┐
   │ matricula │ nome         │ email                │
   ├───────────┼──────────────┼──────────────────────┤
   │  2023101  │ Ana Souza    │ ana@aluno.br         │   ← uma tupla
   │  2023102  │ Bruno Lima   │ bruno@aluno.br       │
   └───────────┴──────────────┴──────────────────────┘
        ↑
     atributo
```

Quatro nomes, três dos quais você já viu na Aula 03:

- **Relação** — a tabela inteira. `ALUNO` é uma relação;
- **Tupla** — uma linha. Uma ocorrência do mundo;
- **Atributo** — uma coluna, com o seu **domínio**: o conjunto de valores que ela aceita;
- **Esquema de relação** — a descrição da estrutura, sem os dados: `ALUNO(matricula, nome, email)`. É o que você entrega; as tuplas chegam depois.

> ⚠️ **A palavra "cardinalidade" aparece aqui com outro sentido.** No modelo relacional, a *cardinalidade de uma relação* é o número de tuplas que ela tem hoje, e o *grau* é o número de atributos. Nada a ver com o `1`, `N`, `M` do diagrama, que fala de quantas ocorrências participam de um relacionamento. Mesmo termo, dois assuntos — quando alguém disser "cardinalidade", pergunte de qual delas está falando.

> 📖 A definição formal de relação, tupla e esquema abre o capítulo de modelo relacional do Heuser, e é onde a diferença entre os dois sentidos de cardinalidade fica explícita.

## 2. Chaves: o que identifica uma tupla

Como as tuplas não têm ordem nem posição, **a única forma de apontar para uma linha específica é por valor**. Daí a importância das chaves.

Numa tabela de alunos com `matricula`, `nome`, `email` e `cpf`, quais colunas identificam sozinhas uma linha? A `matricula` identifica. O `cpf` também. O `email` institucional também, se for único. O `nome` não — existem duas Anas.

- **Chave candidata** — cada conjunto **mínimo** de atributos que identifica uma tupla. Aqui são três: `matricula`, `cpf`, `email`;
- **Chave primária** — a candidata que você **escolhe** como identificador oficial. É uma decisão sua, e ela vai ser copiada em toda tabela que precisar apontar para esta;
- **Chave alternativa** — as candidatas que sobraram. Continuam únicas, mas não são a referência.

Escolhe-se a chave primária por três critérios, nesta ordem: a que **nunca muda**, a que é **menor** e a que **nunca fica vazia**. Por isso `matricula` ganha do `cpf` na biblioteca — o CPF é maior, é dado pessoal desnecessário aqui, e o aluno estrangeiro pode não ter um.

**Chave composta** é a que precisa de mais de um atributo para identificar. É o caso do `EXEMPLAR` da Aula 06: nem `isbn` nem `numero_ex` identificam sozinhos; o par `(isbn, numero_ex)` identifica.

> ⚠️ **Chave é o conjunto mínimo, não o conjunto que descreve.** `PRODUTO(codigo, nome, fabricante)` como chave primária é o erro clássico do catálogo: se `codigo` já identifica, acrescentar qualquer coisa não cria uma chave melhor — cria uma chave grande, que será copiada inteira em toda referência.

### ✏️ Tente você

A biblioteca vai cadastrar as **editoras** com estas colunas: `cnpj`, `razao_social`, `nome_fantasia`, `site` e `email_comercial`. O CNPJ é único; a razão social também, por exigência legal; o site pode estar vazio, e o e-mail comercial pode ser compartilhado por duas editoras do mesmo grupo.

Quais são as chaves candidatas, e qual você escolhe como primária?

<details>
<summary>Resposta</summary>

Candidatas: **`cnpj`** e **`razao_social`**. O `email_comercial` não é candidata porque não é único; o `site` não é porque pode ficar vazio.

Primária: **`cnpj`**, pelos três critérios — nunca muda (razão social muda em reestruturação societária), é menor, e nunca fica vazio.

A `razao_social` fica como chave **alternativa**: continua única, mas não é a referência que as outras tabelas copiam.
</details>

## 3. Do losango para a coluna

Agora a tradução que a Aula 05 prometeu. **Chave estrangeira** é uma coluna que guarda o valor da chave primária de outra tabela — é assim que a ligação por valor acontece.

**Relacionamento 1:N.** A chave estrangeira vai para **o lado N**:

```
   EDITORA(cnpj, nome, cidade)
   LIVRO(isbn, titulo, ano, cnpj → EDITORA)
```

**Relacionamento N:M.** Não cabe coluna em nenhum dos dois lados — nasce uma **tabela associativa**, cuja chave primária é a combinação das duas chaves. Os atributos do losango vão para dentro dela:

```
   AUTOR(cpf, nome)
   LIVRO(isbn, titulo, ano, cnpj → EDITORA)
   ESCREVE(cpf → AUTOR, isbn → LIVRO, ordem_assinatura)
              └──────── chave primária composta ────────┘
```

**Entidade fraca.** A chave da dona entra na chave da fraca, e as duas juntas identificam:

```
   EXEMPLAR(isbn → LIVRO, numero_ex, situacao)
             └──── chave primária composta ────┘
```

**Relacionamento 1:1.** A chave estrangeira pode ir para qualquer um dos dois lados — escolha o lado de participação total, para não ficar com coluna vazia na maioria das linhas.

**Autorrelacionamento.** A chave estrangeira aponta para a **própria tabela** — e é aqui que o papel da Aula 06 vira coluna:

```
   FUNCIONARIO(matricula, nome, ramal,
               matricula_supervisor → FUNCIONARIO)
```

Repare no nome da coluna. Ela **não pode** se chamar `matricula`, porque esse nome já está ocupado pela chave da própria tabela — e quem dá o nome novo é o **papel**. Sem os papéis nomeados lá no diagrama, esta coluna não teria como se chamar.

No N:M autorrelacionado, a tabela associativa recebe **duas** colunas apontando para a mesma tabela, uma por papel:

```
   CITA(isbn_citante → OBRA, isbn_citada → OBRA)
        └──── chave primária composta ────┘
```

> 💡 Repare que **nenhum losango sobreviveu**. No modelo lógico existem só tabelas e colunas; o relacionamento continua lá, mas escrito como valor repetido em duas tabelas. É por isso que o diagrama continua sendo necessário: ele é o único documento onde a ligação é visível de longe.

### ✏️ Tente você

Converta para esquema lógico o autorrelacionamento da Aula 06 — a obra que **continua** outra obra, com os papéis `anterior` e `posterior`. Lembre que uma obra continua no máximo uma outra, e é continuada por no máximo uma.

<details>
<summary>Resposta</summary>

É 1:1, então **não nasce tabela associativa**: a chave estrangeira vai para dentro da própria `OBRA`.

```
   OBRA(isbn, titulo, isbn_anterior → OBRA)
```

Uma coluna só resolve as duas direções. Se a obra A tem `isbn_anterior` apontando para B, então B é continuada por A — a outra leitura se obtém percorrendo a tabela ao contrário, sem coluna nova.

E essa coluna **aceita vazio**: a primeira obra de uma série não continua nada.
</details>

## 4. As três integridades

Traduzir não basta: o esquema precisa dizer **o que o banco deve recusar**. São três regras, e as três são declaradas no modelo lógico.

| Integridade | O que ela garante | O que o banco recusa |
|---|---|---|
| **De domínio** | todo valor pertence ao conjunto de valores da coluna | `mil novecentos` numa coluna de ano |
| **De entidade** | nenhuma parte da chave primária fica vazia | um empréstimo sem número |
| **Referencial** | toda chave estrangeira aponta para uma linha que existe | um livro cuja editora não está cadastrada |

A **integridade referencial** é a mais importante das três para este curso, porque é a que amarra o modelo inteiro: ela impede a *referência órfã* — a linha que aponta para o nada.

```
   LIVRO                              EDITORA
   ┌───────────┬─────────┐            ┌────────────┬──────────┐
   │ isbn      │ cnpj    │            │ cnpj       │ nome     │
   ├───────────┼─────────┤            ├────────────┼──────────┤
   │ 978-85352 │ 111...  │ ─────────▶ │ 111...     │ Bookman  │  ✅ existe
   │ 978-85216 │ 999...  │ ─────────▶ │     ???    │          │  ❌ recusado
   └───────────┴─────────┘            └────────────┴──────────┘
```

Quatro tentativas de gravação, e o que o banco faz com cada uma:

| O que se tenta gravar | Resultado | Qual regra agiu |
|---|---|---|
| exemplar com `situacao` = `"disponivel?"` | recusado | domínio — o valor não está no conjunto aceito |
| empréstimo sem `numero` | recusado | entidade — falta parte da chave primária |
| empréstimo com `matricula` de aluno inexistente | recusado | referencial — a linha apontada não existe |
| empréstimo com `data_devolucao` vazia | **aceito** | nenhuma — é empréstimo em aberto, e isso é legítimo |

A última linha é a que ensina mais: **integridade não é "recusar o que parece estranho"**. Coluna vazia só é erro onde o modelo disse que era obrigatória, e quem disse isso foi a participação total desenhada no DER.

> ⚠️ **Chave estrangeira aponta para chave primária ou candidata — nunca para outra coluna.** Guardar o *nome* da editora dentro de `LIVRO` para "referenciá-la" é o erro do catálogo: nome não é único e muda. O que é legível você busca seguindo a ligação.

### ✏️ Tente você

Quatro tentativas de gravação no esquema da biblioteca. Qual regra recusa cada uma — e qual delas **não é recusada por nenhuma**?

1. um exemplar com `situacao` = `"sumido?"`, num domínio de quatro valores fixos;
2. um empréstimo cuja `matricula` não existe em `ALUNO`;
3. um exemplar sem `numero_ex`;
4. um empréstimo com `data_devolucao` vazia.

<details>
<summary>Resposta</summary>

1. **domínio** — o valor não está no conjunto aceito;
2. **referencial** — a linha apontada não existe;
3. **entidade** — falta parte da chave primária composta;
4. **nenhuma.** É um empréstimo em aberto, e isso é legítimo.

A quarta é a que ensina: integridade não é *"recusar o que parece estranho"*. Coluna vazia só é erro onde o modelo disse que era obrigatória — e quem disse isso foi a participação total desenhada no DER.
</details>

## 5. E quando alguém apaga o outro lado?

A integridade referencial tem um segundo capítulo, que é onde ela deixa de ser teoria: **o que fazer quando a linha referenciada é apagada ou tem a chave alterada?** Três políticas, e a escolha é do modelo, não do SGBD:

- **Recusar** — não deixa apagar a editora enquanto houver livros dela no acervo. É o padrão prudente, e o certo na maioria dos casos;
- **Propagar** — apaga junto. Só faz sentido quando o outro lado **não existe sem este**: apagar uma obra apaga os exemplares dela, porque exemplar de obra nenhuma não é coisa;
- **Anular** — deixa a coluna vazia. Serve quando a ligação é opcional: se a editora sair do cadastro, o livro continua no acervo sem editora conhecida.

> 💡 A escolha entre as três se decide olhando a **participação** que você desenhou na Aula 06. Participação total do lado N pede recusar ou propagar — nunca anular, porque anular criaria justamente a ocorrência que o desenho diz ser impossível. É o diagrama pagando dividendo duas aulas depois.

> ⚠️ **Propagar é a política que apaga dado sem perguntar.** Antes de escolhê-la, aplique o teste da entidade fraca da Aula 06: se a entidade se identifica sozinha, ela sobrevive à dona, e propagar vai destruir histórico que ninguém mandou destruir.

### ✏️ Tente você

Duas exclusões chegam ao balcão. Para cada uma, escolha entre **recusar**, **propagar** e **anular**, e diga qual linha do DER decidiu:

1. apagar uma obra que tem três exemplares na estante;
2. apagar uma editora que publicou 40 obras do acervo.

<details>
<summary>Resposta</summary>

1. **Propagar.** `EXEMPLAR` é entidade fraca de `LIVRO` e tem participação total — exemplar de obra nenhuma não é coisa. Apagar a obra apaga os exemplares.
2. **Recusar.** A obra se identifica sozinha pelo ISBN e sobrevive à editora, mas o acervo não pode ficar com 40 linhas apontando para o nada. *Anular* seria defensável se a biblioteca admitisse obra sem editora conhecida; **recusar** é a escolha prudente — e, como toda escolha, vai por escrito.

As duas respostas saem da **mesma** pergunta: a entidade do outro lado existe sem esta?
</details>

## 6. O esquema lógico da biblioteca

O DER da Aula 06, convertido inteiro:

```
   ALUNO(matricula, nome, email)
   EDITORA(cnpj, nome, cidade)
   LIVRO(isbn, titulo, ano, cnpj → EDITORA)
   EXEMPLAR(isbn → LIVRO, numero_ex, situacao)
   EMPRESTIMO(numero, data_retirada, data_devolucao,
              matricula → ALUNO,
              isbn + numero_ex → EXEMPLAR)
```

Quatro decisões visíveis aí, e cada uma vem de uma linha do diagrama:

1. `EMPRESTIMO` carrega `matricula` porque o lado dele era o **N** — um aluno faz vários;
2. Essa coluna **não aceita vazio**, porque a participação era total: empréstimo sem aluno não existe;
3. `EXEMPLAR` tem chave composta porque é **entidade fraca**, e a chave da obra entrou na dela;
4. `EMPRESTIMO` referencia o exemplar com **duas colunas** — a chave estrangeira tem o mesmo formato da chave que ela aponta. Chave composta se propaga.

> ⚠️ O esquema acima **ainda permite** dois empréstimos em aberto do mesmo exemplar — o mesmo furo da Aula 06. Nenhuma das três integridades pega isso: é regra de negócio com tempo dentro, e vive na lista de regras, para ser verificada pela aplicação.

> 💻 **Modelos desta aula:** [`esquema-logico-biblioteca.md`](exemplos/esquema-logico-biblioteca.md) — o esquema completo da biblioteca, com o motivo de cada coluna e as políticas de exclusão escolhidas. E [`convertendo-um-der.md`](exemplos/convertendo-um-der.md) — **um DER convertido do começo ao fim**, nos cinco passos, incluindo a entidade fraca e o autorrelacionamento. Ele continua o caso que a Aula 06 modelou; leia antes dos exercícios.

## 🏋️ Exercícios da aula

Use o **modelo entidade-relacionamento** para o projeto conceitual das bases de dados abaixo. Em todos os exercícios:

- para cada **entidade**, especifique os atributos relevantes — simples, compostos ou multivalorados — incluindo o **atributo identificador**;
- para cada **relacionamento**, dê a **cardinalidade** dos dois lados, diga se a **participação** de cada entidade é total ou parcial e inclua os atributos do relacionamento, se houver;
- nos **autorrelacionamentos**, diga também o **papel** de cada ponta;
- entregue também o **esquema lógico**, marcando as chaves primárias e indicando com `→` cada chave estrangeira e a tabela que ela aponta.

Cada enunciado diz **o que se deseja registrar**. Ele não diz o que é entidade, o que é atributo e o que é relacionamento — essa decisão é sua, e é o exercício.

> 💡 O percurso inteiro de uma conversão como estas, nos cinco passos, está em [`convertendo-um-der.md`](exemplos/convertendo-um-der.md). Leia antes de começar.

Na pasta `aula-07/` do seu repositório, um arquivo `.md` por exercício:

1. **`ex01.md`** — A biblioteca participa de uma rede de **empréstimo entre instituições**. Quando uma obra é pedida a outra biblioteca, registram-se o número do pedido — sequencial e único no sistema —, a data do pedido, a data de chegada e qual obra foi pedida. De cada instituição parceira guardam-se o CNPJ, a sigla pela qual ela é conhecida na rede, o nome por extenso e a cidade; tanto o CNPJ quanto a sigla são únicos, e o nome por extenso pode se repetir entre campi de uma mesma universidade. Uma instituição atende vários pedidos, cada pedido vai a uma instituição só, e nenhum pedido existe sem instituição.

   *Confere assim: uma das entidades tem **duas** chaves candidatas, e a sua escolha entre elas precisa citar qual dos três critérios da seção 2 desempatou. Saem duas tabelas — se saíram três, você promoveu a entidade alguma coisa que é atributo.*

2. **`ex02.md`** — O acervo passou a registrar as **referências bibliográficas**: uma obra cita outras obras e é citada por outras. De cada obra interessam o ISBN, o título e o ano; de cada citação, a página em que ela aparece na obra que cita. Uma obra pode não citar nenhuma, e pode não ser citada por nenhuma.

   *Confere assim: além de `OBRA`, sai uma tabela só — e as duas colunas dela apontam para o mesmo lugar. Se as duas ficaram com o mesmo nome, faltou o papel. E a página tem um lugar certo, que não é dentro de `OBRA`.*

3. **`ex03.md`** — A biblioteca vai implantar o **descarte de acervo**. Sobre o esquema da seção 6 — `ALUNO`, `EDITORA`, `LIVRO`, `EXEMPLAR`, `EMPRESTIMO` —, a coordenação pediu para apagar do sistema uma obra que tem quatro exemplares na estante, aparece em 62 empréstimos do histórico e é citada por três outras obras do acervo. Diga, para **cada uma** das três ligações que apontam para essa obra, qual política você adotaria — recusar, propagar ou anular — e que linha do DER decidiu. Depois escreva, em até cinco linhas, o que você proporia à coordenação **em vez** do apagamento.

   *Confere assim: as três ligações recebem respostas diferentes umas das outras. E a sua proposta final não é uma política de exclusão — é uma coluna.*

### 📤 Entrega

Estes exercícios são feitos em sala e vão para o **seu repositório** `exercicios-modelagem-dados`:

```bash
cd ..                 # da pasta da aula para a raiz do repositório
git add aula-07/
git commit -m "Resolve exercícios da aula 07"
git push
```

Confira no navegador que a pasta apareceu em `github.com/SEU-USUARIO/exercicios-modelagem-dados`.

## 🧠 Revisão

[8 questões de múltipla escolha](revisao/README.md) para conferir se os conceitos ficaram sólidos. Responda sem consultar a aula — depois volte e corrija.

---

⬅️ [Aula 06 — A Notação Gráfica e os Tipos de Entidade](../aula-06-notacao-e-tipos-de-entidade/README.md) | ➡️ [Aula 08 — Agregação e Estudo de Caso](../aula-08-agregacao-e-estudo-de-caso/README.md)
