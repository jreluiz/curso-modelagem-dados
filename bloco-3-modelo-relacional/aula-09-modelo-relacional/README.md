# Aula 09 — O Modelo Relacional

> 🎯 Objetivos: descrever uma relação com o vocabulário formal, distinguir os tipos de restrição de integridade e escolher a ação referencial correta para cada situação.

## 1. Relação, tupla, atributo, domínio

O modelo relacional foi proposto por **E. F. Codd em 1970** e tem uma virtude que explica seu domínio até hoje: **uma única estrutura de dados** — a relação — e uma base matemática que permite provar propriedades das consultas.

```
                    ATRIBUTOS (colunas)
              ┌───────────┬─────────────┬──────┐
              │ matricula │    nome     │curso │
              ├───────────┼─────────────┼──────┤
   TUPLAS  ─► │  2023101  │ Ana Souza   │  SI  │
   (linhas)   │  2023102  │ Bruno Lima  │  SI  │
              │  2024007  │ Célia Reis  │ ADM  │
              └───────────┴─────────────┴──────┘
                    RELAÇÃO  ALUNO
```

O vocabulário formal, e o informal que você vai ouvir no trabalho:

| Formal | Informal (SQL) | Definição |
|---|---|---|
| Relação | Tabela | Conjunto de tuplas com o mesmo esquema |
| Tupla | Linha, registro | Uma ocorrência |
| Atributo | Coluna, campo | Uma propriedade |
| Domínio | Tipo de dado | Conjunto de valores possíveis |
| **Grau** | Número de colunas | `ALUNO` tem grau 3 |
| **Cardinalidade** | Número de linhas | `ALUNO` tem cardinalidade 3 hoje |

> ⚠️ **"Cardinalidade" tem dois sentidos neste curso, e eles não têm relação um com o outro.** No MER (Aula 05), é a razão 1:1 / 1:N / N:M. No modelo relacional, é a **quantidade de tuplas** de uma relação num instante. O contexto desfaz a ambiguidade — mas vale saber que ela existe.

**Esquema de relação** escreve-se com a chave primária sublinhada:

```
ALUNO(matricula, nome, curso)
      ‾‾‾‾‾‾‾‾‾
```

## 2. As propriedades de uma relação

Uma relação é, formalmente, um **conjunto** — e disso decorrem quatro propriedades que surpreendem quem pensa em planilha:

**1. Não há ordem entre as tuplas.** Uma relação é um conjunto; conjuntos não têm ordem. As linhas podem sair em qualquer sequência.

> ⚠️ Consequência prática: **um `SELECT` sem `ORDER BY` não tem ordem garantida.** Se o resultado parece ordenado, é coincidência do plano de execução — e ela muda quando o volume cresce ou quando alguém cria um índice.

**2. Não há tuplas duplicadas.** Todas as tuplas diferem em pelo menos um atributo, o que é garantido pela chave primária.

> ⚠️ O SQL **viola** esta propriedade: uma tabela sem chave declarada aceita linhas idênticas, e `SELECT` sem `DISTINCT` devolve repetidas. Por isso se diz que o SQL trabalha com *multiconjuntos*, não conjuntos. É uma das divergências entre a teoria e o produto.

**3. Não há ordem entre os atributos.** `ALUNO(matricula, nome)` e `ALUNO(nome, matricula)` são a mesma relação.

> 💡 É por isso que `SELECT *` é frágil e `INSERT` sem lista de colunas é perigoso: ambos dependem de uma ordem que o modelo diz não existir.

**4. Todo valor é atômico.** Uma célula contém **um** valor indivisível — nada de listas, nada de estruturas. É exatamente o que a **1FN** vai exigir na Aula 12.

## 3. Chaves, com o vocabulário completo

| Tipo | Definição | Exemplo em `EXEMPLAR(tombo, isbn, data_aquisicao, situacao)` |
|---|---|---|
| **Superchave** | Conjunto que identifica unicamente | `(tombo)`, `(tombo, isbn)` |
| **Chave candidata** | Superchave mínima | `(tombo)` |
| **Chave primária** | A candidata escolhida | `tombo` |
| **Chave alternativa** | Candidata não escolhida | — |
| **Chave estrangeira** | Atributo que referencia a chave de outra relação | `isbn` → `OBRA(isbn)` |

A **chave estrangeira** é a única forma de ligação do modelo relacional — e é uma ligação **por valor**, não por ponteiro. Se `EXEMPLAR.isbn` vale `'978-85-1234-567-8'`, o exemplar está ligado à obra de mesmo ISBN, esteja ela onde estiver no disco. É daí que vem a independência física da Aula 02.

Regras da FK:

- Referencia **chave primária ou candidata** (`UNIQUE`) da relação referenciada — nunca um atributo qualquer;
- Tem o **mesmo domínio** do atributo referenciado;
- Pode referenciar a **própria** relação (autorrelacionamento: `FUNCIONARIO.matricula_chefe` → `FUNCIONARIO.matricula`);
- Seu valor é **ou** um valor existente na relação referenciada **ou** nulo — nunca um valor inventado.

## 4. As quatro restrições de integridade

**Integridade de domínio.** Todo valor pertence ao domínio do atributo. `ano_publicacao` recebe inteiros entre 1450 e o ano corrente, não `'mil e quinhentos'`. Vira `CHECK` e a escolha de tipo na Aula 13.

**Integridade de entidade.** A chave primária **nunca é nula** e nunca repete. É a regra que dá sentido a "identificar": um identificador vazio não identifica, e um repetido identifica duas coisas.

**Integridade referencial.** Todo valor de FK ou existe na relação referenciada, ou é nulo. É a restrição que impede um empréstimo apontar para um usuário que não existe.

**Integridade semântica** (ou de negócio). Tudo o mais que precisa ser verdade: `data_devolucao >= data_retirada`, `valor > 0`, "um exemplar em manutenção não pode ser emprestado". Parte vira `CHECK`, parte vira gatilho, parte fica na aplicação.

```
   USUARIO                          EMPRESTIMO
   ┌───────────┬──────────┐         ┌────┬───────────┬───────┐
   │ matricula │  nome    │         │ id │ matricula │ tombo │
   ├───────────┼──────────┤         ├────┼───────────┼───────┤
   │  2023101  │ Ana      │◄────────┤ 1  │  2023101  │ 4417  │  ✅ existe
   │  2023102  │ Bruno    │◄────────┤ 2  │  2023102  │ 4418  │  ✅ existe
   └───────────┴──────────┘    ✗────┤ 3  │  9999999  │ 4419  │  ❌ VIOLA
                                    └────┴───────────┴───────┘
```

> 💡 As três primeiras restrições o SGBD garante **sozinho**, desde que você as declare. É a diferença prática entre "o sistema não deixa" e "combinamos que ninguém faz isso": a primeira é verificada milhões de vezes por dia sem falhar, a segunda dura até a primeira pressa.

## 5. O valor nulo e seus três significados

Nulo **não é zero** e **não é string vazia** — é a ausência de valor. E carrega três significados diferentes sob o mesmo símbolo (Aula 04, seção 2): *não se aplica*, *desconhecido*, *não informado*.

Isso tem consequências que atrapalham consultas pelo resto do curso.

**Nulo não é igual a nada, nem a si mesmo:**

```sql
SELECT * FROM emprestimo WHERE data_devolucao = NULL;   -- devolve ZERO linhas, sempre
SELECT * FROM emprestimo WHERE data_devolucao IS NULL;  -- ✅ a forma correta
```

**Lógica de três valores.** Toda comparação com nulo resulta em `UNKNOWN`, não em verdadeiro ou falso:

| `A` | `B` | `A = B` |
|---|---|---|
| 5 | 5 | verdadeiro |
| 5 | 3 | falso |
| 5 | nulo | **desconhecido** |
| nulo | nulo | **desconhecido** |

E o `WHERE` só aceita linhas cujo resultado seja **verdadeiro** — `desconhecido` é descartado junto com `falso`.

**As funções de agregação ignoram nulos:**

```sql
SELECT COUNT(*), COUNT(data_devolucao) FROM emprestimo;   -- 100, 73
```

`COUNT(*)` conta linhas; `COUNT(coluna)` conta valores não nulos. A diferença entre os dois números é a quantidade de empréstimos em aberto — um truque útil, e uma armadilha para quem não sabe.

> ⚠️ **A armadilha mais cara é o `NOT IN`.** Se a subconsulta devolver um único nulo, o resultado é **vazio**, sem erro e sem aviso. Detalhes e a cura (`NOT EXISTS`) em [erros comuns](../../recursos/erros-comuns.md).

> 📏 **Regra do curso:** declare `NOT NULL` em tudo que não tenha um motivo escrito para ser opcional, e **documente o significado** de cada nulo que sobrar. No caso da Biblioteca (Aula 08), `data_devolucao` nula significa exatamente uma coisa: empréstimo em aberto.

## 6. Ações referenciais

O que acontece quando alguém apaga um usuário que tem empréstimos? Você **escolhe**, e escolhe por relacionamento:

| Ação | Ao apagar/alterar a linha referenciada… |
|---|---|
| `NO ACTION` / `RESTRICT` | **Recusa** a operação. É o padrão, e a escolha certa na dúvida |
| `CASCADE` | Apaga/altera **em cascata** os dependentes |
| `SET NULL` | Põe nulo na FK dos dependentes (exige FK opcional) |
| `SET DEFAULT` | Põe o valor padrão na FK |

Como escolher, no caso da Biblioteca:

| Relacionamento | `ON DELETE` | Por quê |
|---|---|---|
| `EMPRESTIMO` → `USUARIO` | `RESTRICT` | Apagar um usuário com histórico apagaria o histórico. Usuário que sai é **inativado**, não excluído |
| `TELEFONE` → `USUARIO` | `CASCADE` | O telefone é parte do usuário; sem ele, não tem sentido. É a marca da **entidade fraca** |
| `RENOVACAO` → `EMPRESTIMO` | `CASCADE` | Idem: fraca |
| `EXEMPLAR` → `OBRA` | `RESTRICT` | Apagar a obra apagaria exemplares físicos que existem na prateleira |
| `MULTA` → `FUNCIONARIO` (quem perdoou) | `SET NULL` | O funcionário pode sair; a multa continua perdoada, só se perde quem autorizou |

> ⚠️ **`CASCADE` é a resposta certa para entidade fraca e perigosa para todo o resto.** Um `DELETE` numa obra pode apagar exemplares, empréstimos, renovações e multas em silêncio, e o `DELETE` que causou isso tinha uma linha. Regra prática: `CASCADE` só onde a entidade dependente **não faz sentido sozinha**. Nos demais, `RESTRICT` — e que o banco reclame.

> 📖 O modelo relacional, suas restrições de integridade e a álgebra que o acompanha formam o núcleo teórico do livro-base. Vale ler o artigo original de Codd de 1970 ([link](../../recursos/links-uteis.md)): são sete páginas que explicam por que "ligação por valor" foi uma ideia revolucionária.

> 💻 **Modelos desta aula:** [`integridade.md`](exemplos/integridade.md)

## 🏋️ Exercícios da aula

Na pasta `aula-09/` do seu repositório:

1. **`ex01.md`** — dada a relação `EXEMPLAR(tombo, isbn, data_aquisicao, situacao)` com 4 tuplas, responda: qual o grau? Qual a cardinalidade? Liste todas as superchaves possíveis e diga quais são candidatas. Depois responda: se a biblioteca passasse a numerar exemplares por obra, o que mudaria nessa lista?
2. **`ex02.md`** — para cada situação, diga **qual restrição de integridade** é violada (domínio, entidade, referencial ou semântica): (a) inserir um empréstimo com `matricula = 9999999`, que não existe; (b) inserir uma obra com `ano_publicacao = 'antigo'`; (c) inserir dois exemplares com o mesmo tombo; (d) inserir um exemplar com `tombo` nulo; (e) registrar `data_devolucao` anterior a `data_retirada`; (f) registrar um empréstimo de exemplar em situação `extraviado`;
3. **`ex03.md`** — para cada FK do modelo da Aula 08, escolha a **ação referencial** de `ON DELETE` e justifique em uma linha, usando o critério da seção 6. São 9 chaves estrangeiras. Em seguida, aponte qual delas seria mais destrutiva se declarada `CASCADE` por engano, e descreva o estrago em uma frase;
4. **`ex04.md`** — a consulta `SELECT * FROM usuario WHERE matricula NOT IN (SELECT matricula FROM emprestimo)` deveria listar quem nunca pegou livro, e devolve zero linhas. (a) Explique a causa; (b) reescreva com `NOT EXISTS`; (c) escreva a consulta que **prova** a causa, mostrando o nulo culpado; (d) diga que restrição no esquema teria evitado o problema desde o início;
5. **Desafio 🌶️ `ex05.md`** — projete um esquema relacional pequeno (4 relações) em que uma exclusão em cascata mal declarada apague dados que ninguém queria perder. Mostre: o esquema com as FKs e suas ações, o `DELETE` de uma linha só, a lista do que desaparece junto, e o esquema corrigido. Depois escreva as três perguntas que você fará daqui em diante, sempre, antes de declarar um `CASCADE`.

## 🧠 Revisão

[8 questões de múltipla escolha](revisao/README.md) para conferir se os conceitos ficaram sólidos. Responda sem consultar a aula — depois volte e corrija.

## ✅ Entrega

```bash
git add aula-09/
git commit -m "Resolve exercícios da aula 09 (modelo relacional)"
git push
```

---

⬅️ [Aula 08](../../bloco-2-modelagem-conceitual/aula-08-estudo-de-caso-der/README.md) | ➡️ [Aula 10 — Mapeamento ER → relacional](../aula-10-mapeamento-er-relacional/README.md)
