# Aula 06 — Do DER às Tabelas

> 🎯 Objetivos: aplicar as cinco regras de mapeamento que transformam um diagrama em esquema relacional, justificar a posição de cada chave estrangeira e identificar o que a tradução perde pelo caminho.
> 🎬 Slides da aula: [apresentacao-06-do-der-as-tabelas.pdf](apresentacao/apresentacao-06-do-der-as-tabelas.pdf)

## 1. Por que traduzir

O diagrama da Aula 05 é bom para conversar com gente. Ele não serve para conversar com banco nenhum: banco de dados não conhece losango, seta nem retângulo. Conhece tabela, coluna e chave.

A boa notícia é que a tradução é **mecânica**. São cinco regras, aplicadas na ordem, e ao fim delas você tem o esquema. As decisões difíceis já foram tomadas quando você desenhou; aqui é execução.

> 💡 Mecânica não quer dizer automática. Duas das cinco regras têm mais de uma saída válida, e a escolha entre elas é sua — com justificativa escrita, como sempre.

**Aplique na ordem, e sem pular:**

| Ordem | Regra | O que ela consome |
|:---:|---|---|
| 1ª | Toda entidade vira tabela | Os retângulos |
| 2ª | Atributo multivalorado vira tabela | Os atributos que aceitam mais de um valor |
| 3ª | 1:N vira FK do lado N | As linhas `\|\|--o{` |
| 4ª | N:M vira tabela associativa | As linhas `}o--o{` |
| 5ª | 1:1 vira FK do lado obrigatório | As linhas `\|\|--o\|` |

Ao terminar, **todo elemento do diagrama foi consumido por exatamente uma regra**. Se sobrou coisa no desenho sem correspondente no esquema, você pulou uma. Se apareceu tabela que não veio de regra nenhuma, você inventou — e inventar aqui costuma ser sinal de que o diagrama estava incompleto.

## 2. Regra 1 — Toda entidade vira uma tabela

Cada retângulo do diagrama vira uma tabela. Os atributos viram colunas, e a chave primária do diagrama vira a chave primária da tabela.

```
   No diagrama                        No esquema
   OBRA {                             OBRA(isbn, titulo, ano_publicacao, editora)
     varchar isbn PK          ───►         ‾‾‾‾
     varchar titulo
     int ano_publicacao
     varchar editora
   }
```

É a regra mais simples e a que produz mais tabela. Aplique-a primeiro, em todas as entidades, antes de tocar em qualquer relacionamento.

## 3. Regra 2 — Atributo multivalorado vira tabela

Um usuário tem vários telefones. Não existe célula com vários valores (Aula 01), então o atributo vira uma tabela própria, com uma chave estrangeira apontando para o dono:

```
TELEFONE(matricula, numero, tipo)
         ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾
         matricula → USUARIO(matricula)
```

A chave primária é o par: **chave do dono + o que distingue os valores entre si**. Só `matricula` não serve (a pessoa tem três telefones); só `numero` não serve (duas pessoas podem informar o mesmo número do departamento).

> 💡 Esta é a **tabela dependente** da Aula 04 — a que não se identifica sozinha, e a única em que "em cascata" é a ação referencial certa. Telefone sem dono é um número solto.

## 4. Regra 3 — 1:N vira chave estrangeira do lado N

A regra que você já conhece da Aula 03, agora com nome e número:

```
   OBRA ||--o{ EXEMPLAR          EXEMPLAR(tombo, isbn, data_aquisicao, situacao)
                          ───►            ‾‾‾‾‾
                                          isbn → OBRA(isbn)   obrigatório
```

**A FK vai para o lado N**, porque é o lado em que cabe um valor só. E o mínimo do símbolo decide se ela é obrigatória: `||--o{` diz que todo exemplar tem exatamente uma obra, então `isbn` não pode ficar vazio.

> ⚠️ Um diagrama com quatro relacionamentos 1:N produz quatro colunas de FK, e todas do mesmo lado do desenho. Se as suas FKs ficaram espalhadas dos dois lados, releia o teste da Aula 03: *"deste lado, quantos do outro cabem?"*

## 5. Regra 4 — N:M vira tabela associativa

Um N:M não tem lado onde a FK caiba, então nasce uma tabela nova com **duas** chaves estrangeiras, uma para cada lado:

```
   OBRA }o--o{ AUTOR             ESCRITA(isbn, id_autor, ordem)
                          ───►           ‾‾‾‾‾‾‾‾‾‾‾‾‾‾
                                         isbn     → OBRA(isbn)
                                         id_autor → AUTOR(id_autor)
```

A chave primária é o **par de FKs**, e os atributos do relacionamento — aqui, `ordem` — viram colunas dela:

```
   ESCRITA
   ┌────────────────┬──────────┬───────┐
   │ isbn           │ id_autor │ ordem │
   ├────────────────┼──────────┼───────┤
   │ 978-85-111-1   │    7     │   1   │  ← Silva é a primeira autora desta obra
   │ 978-85-111-1   │   12     │   2   │  ← Souza é o segundo
   │ 978-85-222-2   │   12     │   1   │  ← e o primeiro na outra obra
   └────────────────┴──────────┴───────┘
          ↑              ↑
          └── as duas colunas juntas são a chave, e cada uma é uma FK
```

Repare que `ordem` não caberia em `AUTOR` (o mesmo autor é primeiro numa obra e segundo em outra) nem em `OBRA` (ela tem várias posições). É do **par** — e a associativa é o único lugar do esquema onde um dado do par pode morar.

> ⚠️ **Quando o par não basta como chave.** Se a mesma combinação puder acontecer duas vezes, o par deixa de identificar. Um usuário que reserva uma obra, desiste, e reserva de novo seis meses depois produz duas linhas com o mesmo par — e aí a tabela precisa de uma chave própria (um `id`) ou de mais uma coluna na chave (a data). Pergunte sempre: *"esta combinação pode se repetir ao longo do tempo?"*

## 6. Regra 5 — 1:1, e a escolha do lado

Num 1:1 a FK pode ir para qualquer um dos dois lados, e você escolhe — de preferência **o lado obrigatório**, para não criar coluna vazia:

```
   EMPRESTIMO ||--o| MULTA       MULTA(id_emprestimo, valor, data_pagamento)
                          ───►         ‾‾‾‾‾‾‾‾‾‾‾‾‾
                                       id_emprestimo → EMPRESTIMO(id_emprestimo)
```

Toda multa vem de um empréstimo (obrigatório); nem todo empréstimo gera multa (opcional). Se a FK fosse para o lado de `EMPRESTIMO`, a coluna ficaria vazia na maioria esmagadora das linhas. Do lado da multa, ela é sempre preenchida — e ainda serve de chave primária, porque só existe uma multa por empréstimo.

> ⚠️ Num 1:1 a FK precisa ser **única**, senão duas multas apontam para o mesmo empréstimo e o relacionamento vira 1:N sem ninguém notar. Quando ela é a própria chave primária, como acima, a unicidade já vem de graça.

## 7. O que se perde na tradução

O esquema não carrega tudo que o diagrama dizia. Vale saber o que ficou para trás, para não passar a tarde tentando declarar o indeclarável:

| No diagrama | No esquema | O que fazer |
|---|---|---|
| "Toda obra tem **pelo menos um** exemplar" | **Não é expressável** | Fica na lista de regras de negócio; a aplicação verifica |
| O nome do relacionamento (`"assina"`) | Vira uma coluna sem nome | Comentário no script |
| "Máximo 3 empréstimos por aluno" | **Não é expressável** | Idem: regra escrita |
| A distinção entre tabela dependente e independente | Só sobrevive na chave composta | Esta documentação |

> ⚠️ **A perda que mais dói é a participação total do lado 1.** Marcar a FK como obrigatória garante *"todo exemplar tem obra"*. O contrário — *"toda obra tem exemplar"* — não vira restrição nenhuma, porque a FK está do outro lado da relação. Guardar essa assimetria na cabeça economiza horas.

> 💻 **Modelos desta aula:** [`esquema-parcial.md`](exemplos/esquema-parcial.md) — os fragmentos da Aula 05 mapeados, regra por regra.

> 📖 O livro-base apresenta o mapeamento em sete regras, porque cobre também especialização e relacionamento ternário — dois assuntos que este curso não trata. As cinco daqui são as mesmas, com os dois casos avançados removidos.

## 🏋️ Exercícios da aula

Na pasta `aula-06/` do seu repositório:

1. **`ex01.md`** — mapeie o diagrama abaixo aplicando as regras **na ordem**, e diga ao lado de cada tabela qual regra a produziu:
   `CLIENTE ||--o{ PEDIDO` · `PEDIDO ||--|{ ITEM` · `PRODUTO ||--o{ ITEM` · `CLIENTE ||--o{ TELEFONE`
   Escreva os esquemas com chaves sublinhadas e FKs indicadas. *Confira assim: o número de tabelas do esquema tem que ser maior ou igual ao número de entidades do diagrama — se for menor, você fundiu alguma coisa que não devia.*
2. **`ex02.md`** — a escola precisa registrar quais professores lecionam quais disciplinas, com o semestre e a carga horária de cada atribuição. Desenhe o trecho do diagrama e mapeie. Depois responda: a chave da associativa é o par `(professor, disciplina)`? Justifique com uma frase do enunciado. *Confira assim: teste a sua chave contra a frase "o mesmo professor deu a mesma disciplina em 2025-2 e em 2026-1".*
3. **`ex03.md`** — um cadastro de fornecedores guarda, para cada fornecedor, **vários e-mails** e **vários endereços de entrega**, cada endereço com um apelido. Mapeie os dois atributos multivalorados e escreva a chave primária de cada tabela resultante, justificando por que a chave do dono sozinha não basta. *Confira assim: as duas tabelas novas têm chave composta, e as duas justificativas são diferentes entre si.*
4. **`ex04.md`** — mapeie **o seu DER inteiro** do `ex03` da Aula 05. Entregue o esquema completo, com todas as PKs, todas as FKs e a indicação de quais FKs são obrigatórias. Ao final, escreva a lista das regras de negócio que **não couberam** no esquema. *Confira assim: toda entidade do diagrama virou tabela, todo N:M virou tabela associativa, e a lista de regras perdidas tem pelo menos duas linhas — se estiver vazia, você não olhou direito.*
5. **Desafio 🌶️ `ex05.md`** — mapeie este diagrama e explique o que há de estranho nele:
   `PESSOA ||--o| PESSOA : "é cônjuge de"` · `PESSOA ||--o{ PESSOA : "é filho de"`
   Entregue o esquema, diga onde cada FK mora e por quê, e descreva **duas** regras que o esquema não consegue impedir e que o mundo real impede (pense em quem pode ser cônjuge ou pai de quem). *Confira assim: as duas FKs apontam para a mesma tabela e precisam de nomes de coluna diferentes; e pelo menos uma das regras que você listou tem a ver com a linha apontar para ela mesma.*

## 🧠 Revisão

[8 questões de múltipla escolha](revisao/README.md) para conferir se os conceitos ficaram sólidos. Responda sem consultar a aula — depois volte e corrija.

## ✅ Entrega

```bash
git add aula-06/
git commit -m "Resolve exercícios da aula 06 (do DER às tabelas)"
git push
```

---

⬅️ [Aula 05](../aula-05-minimundo-e-der/README.md) | ➡️ [Aula 07 — Normalização até a 3FN](../aula-07-normalizacao/README.md)
