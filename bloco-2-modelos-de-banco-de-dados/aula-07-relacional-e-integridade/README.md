# Aula 07 — Do Relacional à Integridade Referencial

> 🎯 Objetivos: nomear os elementos do modelo relacional, escolher a chave primária entre as candidatas e converter um DER em esquema lógico com integridade referencial.
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

> 💡 Repare que **nenhum losango sobreviveu**. No modelo lógico existem só tabelas e colunas; o relacionamento continua lá, mas escrito como valor repetido em duas tabelas. É por isso que o diagrama continua sendo necessário: ele é o único documento onde a ligação é visível de longe.

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

## 5. E quando alguém apaga o outro lado?

A integridade referencial tem um segundo capítulo, que é onde ela deixa de ser teoria: **o que fazer quando a linha referenciada é apagada ou tem a chave alterada?** Três políticas, e a escolha é do modelo, não do SGBD:

- **Recusar** — não deixa apagar a editora enquanto houver livros dela no acervo. É o padrão prudente, e o certo na maioria dos casos;
- **Propagar** — apaga junto. Só faz sentido quando o outro lado **não existe sem este**: apagar uma obra apaga os exemplares dela, porque exemplar de obra nenhuma não é coisa;
- **Anular** — deixa a coluna vazia. Serve quando a ligação é opcional: se a editora sair do cadastro, o livro continua no acervo sem editora conhecida.

> 💡 A escolha entre as três se decide olhando a **participação** que você desenhou na Aula 06. Participação total do lado N pede recusar ou propagar — nunca anular, porque anular criaria justamente a ocorrência que o desenho diz ser impossível. É o diagrama pagando dividendo duas aulas depois.

> ⚠️ **Propagar é a política que apaga dado sem perguntar.** Antes de escolhê-la, aplique o teste da entidade fraca da Aula 06: se a entidade se identifica sozinha, ela sobrevive à dona, e propagar vai destruir histórico que ninguém mandou destruir.

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

> 💻 **Modelos desta aula:** [`esquema-logico-biblioteca.md`](exemplos/esquema-logico-biblioteca.md) — o esquema completo, com o motivo de cada coluna e as políticas de exclusão escolhidas.

## 🏋️ Exercícios da aula

Na pasta `aula-07/` do seu repositório:

1. **`ex01.md`** — a tabela `FUNCIONARIO` da biblioteca tem as colunas `matricula_func`, `cpf`, `nome`, `email_pessoal`, `ramal` e `data_admissao`. Sabendo que dois funcionários podem dividir o mesmo ramal e que o e-mail pessoal é único mas opcional, liste todas as **chaves candidatas**, escolha a **chave primária** justificando pelos três critérios da seção 2 e diga quais ficaram como **alternativas**. *Confere assim: são duas candidatas, e o `email_pessoal` não é uma delas — a razão está num dos três critérios.*

2. **`ex02.md`** — converta em esquema lógico o fragmento abaixo, no formato da seção 6, marcando as chaves primárias e as estrangeiras com `→`:

   ```
   AUTOR ---|N| ESCREVE{ESCREVE} ---|M| LIVRO
   ESCREVE tem o atributo: ordem_assinatura
   AUTOR: cpf (identifica), nome, nacionalidade
   LIVRO: isbn (identifica), titulo
   ```

   *Confere assim: saem **três** tabelas, e a do meio tem chave primária composta por duas colunas. Se `ordem_assinatura` foi parar dentro de `LIVRO` ou de `AUTOR`, releia a seção 3.*

3. **`ex03.md`** — para cada operação abaixo sobre o esquema da seção 6, diga **qual integridade** ela viola (domínio, entidade ou referencial) ou, se não viola nenhuma, **qual política de exclusão** você adotaria e por quê: (a) cadastrar um empréstimo com `matricula` de um aluno inexistente; (b) cadastrar um exemplar sem `numero_ex`; (c) gravar `disponivel?` na coluna `situacao`, cujo domínio tem quatro valores fixos; (d) apagar uma editora que publicou 40 livros do acervo; (e) apagar uma obra que tem três exemplares na estante. *Confere assim: três violam integridade e duas são decisão de política — e as duas de política recebem respostas **diferentes**, por causa da participação que o DER da Aula 06 mostra.*

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
