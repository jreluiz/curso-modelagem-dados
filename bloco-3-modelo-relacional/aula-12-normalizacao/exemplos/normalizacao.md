# Normalização — Biblioteca Universitária

Duas partes: a **análise** do [esquema da Aula 10](../../aula-10-mapeamento-er-relacional/exemplos/esquema-relacional.md), relação por relação, e uma **normalização completa** feita do zero sobre uma tabela "tudo em um".

---

# Parte 1 — Análise do esquema do caso

| Relação | Chave | 1FN | 2FN | 3FN | BCNF | Observação |
|---|---|:---:|:---:|:---:|:---:|---|
| `USUARIO(matricula, nome, email, data_cadastro)` | `matricula` | ✅ | ✅ | ✅ | ✅ | PK simples: 2FN automática. `email` é candidata; `email → matricula` também vale, e determinante candidato **não** viola BCNF |
| `ALUNO(matricula, curso, semestre_ingresso)` | `matricula` | ✅ | ✅ | ✅ | ✅ | — |
| `PROFESSOR(matricula, departamento, titulacao)` | `matricula` | ✅ | ✅ | ✅ | ✅ | — |
| `SERVIDOR(matricula, setor)` | `matricula` | ✅ | ✅ | ✅ | ✅ | — |
| `TELEFONE(matricula, numero, tipo)` | `(matricula, numero)` | ✅ | ✅ | ✅ | ✅ | `tipo` depende dos **dois**: o mesmo número pode ser "celular" para um usuário e "recado" para outro |
| `OBRA(isbn, titulo, ano_publicacao, editora)` | `isbn` | ✅ | ✅ | ✅ | ✅ | Ver a nota sobre `editora` abaixo |
| `AUTOR(id_autor, nome, nacionalidade)` | `id_autor` | ✅ | ✅ | ✅ | ✅ | — |
| `AREA(codigo_area, nome)` | `codigo_area` | ✅ | ✅ | ✅ | ✅ | `nome` é candidata (`UNIQUE`) |
| `ESCRITA(isbn, id_autor, ordem)` | `(isbn, id_autor)` | ✅ | ✅ | ✅ | ✅ | `ordem` depende **totalmente** da chave: é a posição daquele autor naquela obra |
| `CLASSIFICACAO(isbn, codigo_area)` | ambos | ✅ | ✅ | ✅ | ✅ | Só chave, nada a violar |
| `EXEMPLAR(tombo, isbn, data_aquisicao, situacao)` | `tombo` | ✅ | ✅ | ✅ | ✅ | `tombo → isbn`, e `isbn → titulo` está em **outra** relação: não é transitividade dentro desta |
| `FUNCIONARIO(matricula_func, nome, cargo)` | `matricula_func` | ✅ | ✅ | ✅ | ✅ | — |
| `EMPRESTIMO(id_emprestimo, matricula, tombo, matricula_func, datas)` | `id_emprestimo` | ✅ | ✅ | ✅ | ✅ | Todos os não primos dependem só da PK |
| `RENOVACAO(id_emprestimo, sequencia, data_renovacao, nova_data_prevista)` | `(id_emprestimo, sequencia)` | ✅ | ✅ | ✅ | ✅ | As duas datas dependem do par: a 2ª renovação tem data diferente da 1ª |
| `RESERVA(id_reserva, matricula, isbn, data_solicitacao, situacao)` | `id_reserva` | ✅ | ✅ | ✅ | ✅ | — |
| `MULTA(id_emprestimo, valor, data_pagamento, justificativa_perdao, matricula_func)` | `id_emprestimo` | ✅ | ✅ | ✅ | ✅ | — |

**O esquema inteiro está em BCNF.** E isso não é sorte:

> 💡 **Um esquema mapeado a partir de um DER bem feito já nasce quase normalizado.** Os multivalorados viraram tabelas (1FN), cada entidade virou uma relação com fatos sobre uma coisa só (2FN e 3FN), e as chaves saíram da análise de identidade da Aula 06. A normalização é a **verificação** de um trabalho feito antes, não o conserto de um trabalho mal feito.

## Três verificações que merecem atenção

### `editora` em `OBRA` — 3FN, mas quase não

```
isbn → titulo, ano_publicacao, editora
```

Está em 3FN porque `editora` é apenas um **nome** — não há `editora → cidade_editora` nesta relação. Mas se o minimundo passasse a exigir endereço e contato da editora, apareceria `editora → endereco_editora`, uma **dependência transitiva**, e `EDITORA` teria que virar entidade própria.

> ⚠️ É o mesmo raciocínio da decisão entidade × atributo da Aula 03. **Normalização e modelagem conceitual apontam para a mesma resposta** — o que é esperado: são duas formas de perguntar "isto é um fato sobre outra coisa?"

### `EXEMPLAR` — a transitividade que não é

```
tombo → isbn
isbn  → titulo        ← mas 'titulo' NÃO está em EXEMPLAR
```

Não há violação: a 3FN fala de dependências **dentro da mesma relação**. Se `titulo` tivesse sido copiado para `EXEMPLAR`, aí sim haveria `tombo → isbn → titulo`, e a decomposição seria obrigatória.

### `USUARIO` — determinante que é chave candidata

```
matricula → nome, email
email     → matricula, nome        ← 'email' é UNIQUE!
```

A segunda DF tem `email` como determinante, e `email` **não é a chave primária**. Isso viola a BCNF? **Não** — a BCNF exige que o determinante seja **superchave**, e `email` é chave candidata, portanto superchave. Está tudo certo.

---

# Parte 2 — Normalizando do zero

O caso didático: a mesma informação numa tabela só, como uma planilha faria.

```
EMPRESTIMO_TUDO(id, matricula, nome_usuario, email, tipo_usuario, limite_dias,
                tombo, isbn, titulo, editora, areas,
                data_retirada, data_prevista)
```

```
┌────┬───────────┬────────────┬──────────┬───────┬──────┬────────┬──────────────┬──────────┐
│ id │ matricula │ nome_usua. │ tipo     │limite │ tombo│  isbn  │   titulo     │  areas   │
├────┼───────────┼────────────┼──────────┼───────┼──────┼────────┼──────────────┼──────────┤
│ 1  │  2023101  │ Ana Souza  │ aluno    │  14   │ 4417 │ 978-01 │ Bancos Dados │ BD, ES   │
│ 2  │  2023101  │ Ana Souza  │ aluno    │  14   │ 4420 │ 978-02 │ Algoritmos   │ ALG      │
│ 3  │  2023102  │ Bruno Lima │ aluno    │  14   │ 4418 │ 978-01 │ Bancos Dados │ BD, ES   │
│ 4  │  1998044  │ Daniel M.  │ professor│  60   │ 4419 │ 978-01 │ Bancos Dados │ BD, ES   │
└────┴───────────┴────────────┴──────────┴───────┴──────┴────────┴──────────────┴──────────┘
```

## As três anomalias, concretas

**Inserção.** Cadastrar a obra `978-06 Inteligência Artificial`, que ainda não foi emprestada: **impossível** sem inventar um empréstimo falso, porque `id` é a chave e não pode ser nulo.

**Atualização.** Corrigir o título para *Fundamentos de Bancos de Dados*: são **3 linhas** (1, 3 e 4). Esqueça a linha 4 e o banco passa a afirmar dois títulos para o mesmo ISBN — sem que nada acuse.

**Exclusão.** Apagar o empréstimo 2 (devolvido há dois anos, limpeza de rotina) faz a obra **Algoritmos desaparecer do sistema**. O único registro de que ela existia era esse empréstimo.

## As dependências funcionais

```
id         → matricula, tombo, data_retirada, data_prevista
matricula  → nome_usuario, email, tipo_usuario
tipo_usuario → limite_dias
tombo      → isbn
isbn       → titulo, editora, areas
```

Chave primária: `id`. Atributos primos: só `id`.

## Passo 1 → 1FN

**Violação:** `areas` contém `'BD, ES'` — vários valores numa célula.

**Cura:** o multivalorado vira relação própria.

```
EMPRESTIMO_1FN(id, matricula, nome_usuario, email, tipo_usuario, limite_dias,
               tombo, isbn, titulo, editora, data_retirada, data_prevista)
AREA_OBRA(isbn, codigo_area)
```

> ⚠️ Note que a "solução" `area1, area2, area3` **também** violaria a 1FN — é um grupo repetido, e ainda decide arbitrariamente que nenhuma obra tem quatro áreas.

## Passo 2 → 2FN

A chave é **simples** (`id`), e sem chave composta **não existe dependência parcial**.

> 💡 `EMPRESTIMO_1FN` já está em 2FN, automaticamente. É um resultado que surpreende, e é a razão de a 2FN quase nunca aparecer em esquemas com chave artificial. Ela importa em tabelas associativas, onde a chave é composta.

Para ver a 2FN sendo violada de verdade, use a tabela de itens de pedido:

```
❌ ITEM_PEDIDO(num_pedido, cod_produto, quantidade, nome_produto, preco_tabela)
   (num_pedido, cod_produto) → quantidade          ✅ total
   cod_produto → nome_produto, preco_tabela        ❌ PARCIAL

✅ ITEM_PEDIDO(num_pedido, cod_produto, quantidade)
   PRODUTO(cod_produto, nome_produto, preco_tabela)
```

## Passo 3 → 3FN

**Violações — quatro dependências transitivas:**

```
id → matricula → nome_usuario, email, tipo_usuario
id → matricula → tipo_usuario → limite_dias          (transitividade dupla!)
id → tombo → isbn
id → tombo → isbn → titulo, editora
```

**Decomposição:**

```
EMPRESTIMO(id, matricula, tombo, data_retirada, data_prevista)
           matricula → USUARIO ;  tombo → EXEMPLAR
USUARIO(matricula, nome_usuario, email, tipo_usuario)
        tipo_usuario → CATEGORIA
CATEGORIA(tipo_usuario, limite_dias)
EXEMPLAR(tombo, isbn)
         isbn → OBRA
OBRA(isbn, titulo, editora)
AREA_OBRA(isbn, codigo_area)
```

Sete relações, todas em 3FN — e **muito parecidas com o esquema que a Aula 10 produziu diretamente do DER**. Dois caminhos, o mesmo destino.

## Verificação de perda

| Decomposição | Atributos comuns | É chave de? | Sem perda? |
|---|---|---|:---:|
| `EMPRESTIMO` + `USUARIO` | `{matricula}` | `USUARIO` | ✅ |
| `USUARIO` + `CATEGORIA` | `{tipo_usuario}` | `CATEGORIA` | ✅ |
| `EMPRESTIMO` + `EXEMPLAR` | `{tombo}` | `EXEMPLAR` | ✅ |
| `EXEMPLAR` + `OBRA` | `{isbn}` | `OBRA` | ✅ |
| `OBRA` + `AREA_OBRA` | `{isbn}` | `OBRA` | ✅ |

Todas sem perda. Um contraexemplo, para fixar o que daria errado:

```
❌ EMPRESTIMO_TUDO → E1(matricula, titulo) + E2(matricula, data_retirada)
   Comum: {matricula}, que NÃO é chave de nenhuma das duas.

   Ana pegou "Bancos de Dados" em 01/06 e "Algoritmos" em 01/07:
   E1: (Ana, Bancos) (Ana, Algoritmos)
   E2: (Ana, 01/06)  (Ana, 01/07)

   E1 ⋈ E2 devolve QUATRO linhas:
     (Ana, Bancos,     01/06)  ✅ existia
     (Ana, Bancos,     01/07)  ❌ INVENTADA
     (Ana, Algoritmos, 01/06)  ❌ INVENTADA
     (Ana, Algoritmos, 01/07)  ✅ existia
```

Duas linhas de informação **falsa**, e nada indica quais. **Decomposição com perda é pior que a tabela não normalizada** — troca redundância por mentira.

## E a BCNF?

Todas as sete estão em BCNF: em cada uma, todo determinante é a chave primária.

Para ver 3FN sem BCNF, é preciso o caso de **chaves candidatas compostas e sobrepostas**:

```
ORIENTACAO(aluno, materia, professor)
   • cada professor ensina uma única matéria
   • um aluno, numa matéria, tem um único professor

   DFs:  (aluno, materia) → professor     ← chave candidata
         professor → materia              ← determinante NÃO é superchave

   3FN?  ✅ — 'materia' é atributo primo, e a 3FN abre essa exceção
   BCNF? ❌ — a BCNF não abre exceção nenhuma
```

**A anomalia:** não é possível registrar que o professor Silva ensina Banco de Dados **antes** de ele ter um aluno. Anomalia de inserção, exatamente o que a normalização deveria eliminar.

**A decomposição:** `ENSINA(professor, materia)` + `CURSA(aluno, professor)`.

> ⚠️ **E o preço:** a DF `(aluno, materia) → professor` deixa de ser verificável numa tabela só — garanti-la passa a exigir uma junção. A decomposição em BCNF **não preserva as dependências**. Quando 3FN e BCNF conflitam assim, **é legítimo parar na 3FN** e documentar a decisão. Formas normais são ferramentas, não mandamentos.

---

⬅️ [Voltar à Aula 12](../README.md) | 🏠 [Início do curso](../../../README.md)
