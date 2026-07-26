# Aula 11 — Álgebra Relacional

> 🎯 Objetivos: ler e escrever expressões com os operadores da álgebra relacional, montar sequências de operações e reconhecer a mesma operação escrita em SQL.
> 🎬 Slides da aula: [apresentacao-11-algebra-relacional.pdf](apresentacao/apresentacao-11-algebra-relacional.pdf)

## 1. Por que estudar isto

A álgebra relacional é uma linguagem **formal** de consulta: operadores que recebem relações e devolvem relações. Ela não é usada para escrever software — e ainda assim é obrigatória por três motivos:

**É o que o SGBD executa.** Quando você escreve um `SELECT`, o otimizador o traduz para uma expressão da álgebra e depois **reescreve essa expressão** numa equivalente mais barata. Entender a álgebra é entender por que duas consultas com o mesmo resultado têm desempenhos diferentes (Aula 15).

**Ela é fechada.** Toda operação devolve uma relação, então a saída de uma é a entrada da outra. É o que permite compor consultas indefinidamente — e é a origem das subconsultas do SQL.

**Ela força a pensar em conjuntos.** Quem aprende SQL antes da álgebra tende a pensar linha a linha, como num laço de programação. A álgebra opera sobre **conjuntos inteiros de uma vez**, que é como o banco realmente trabalha.

Trabalharemos sobre este esquema:

```
USUARIO(matricula, nome, email, tipo)
EXEMPLAR(tombo, isbn, situacao)
OBRA(isbn, titulo, ano_publicacao)
EMPRESTIMO(id_emprestimo, matricula, tombo, data_retirada, data_devolucao)
```

## 2. Seleção (σ) — escolhe linhas

Devolve as tuplas que satisfazem uma condição. O resultado tem **as mesmas colunas** e menos (ou igual) linhas.

```
σ situacao = 'disponivel' (EXEMPLAR)
```

Condições combinam-se com `∧` (e), `∨` (ou), `¬` (não):

```
σ ano_publicacao > 2000 ∧ titulo LIKE 'Banco%' (OBRA)
```

```sql
SELECT * FROM exemplar WHERE situacao = 'disponivel';
```

## 3. Projeção (π) — escolhe colunas

Devolve apenas os atributos listados.

```
π nome, email (USUARIO)
```

```sql
SELECT DISTINCT nome, email FROM usuario;
```

> ⚠️ **A projeção elimina duplicatas, e o `SELECT` não.** Como o resultado da álgebra é um conjunto, `π tipo (USUARIO)` devolve **uma** linha por tipo distinto. Em SQL, `SELECT tipo FROM usuario` devolve uma linha por usuário — para obter o comportamento da álgebra é preciso `SELECT DISTINCT`. É a divergência da Aula 09, seção 2, aparecendo na prática.

Seleção e projeção compõem-se, e a **ordem importa para o custo**:

```
π nome (σ tipo = 'aluno' (USUARIO))        -- nomes dos alunos
```

> 💡 Selecionar **antes** de projetar é quase sempre mais barato: descarta linhas cedo, e tudo que vem depois trabalha sobre menos dados. Isso se chama *pushdown* de seleção, e é a primeira coisa que todo otimizador faz com a sua consulta.

## 4. Renomeação (ρ)

Renomeia uma relação ou seus atributos. Indispensável quando a mesma relação aparece duas vezes na consulta — o caso do autorrelacionamento.

```
ρ E1 (EMPRESTIMO)          -- a relação passa a se chamar E1
```

```sql
SELECT ... FROM emprestimo AS e1, emprestimo AS e2 WHERE ...
```

## 5. Operações de conjunto: ∪, ∩, −

Exigem **compatibilidade de união**: as duas relações precisam do mesmo número de atributos, na mesma ordem, com domínios compatíveis.

| Operação | Devolve | SQL |
|---|---|---|
| `R ∪ S` | Tuplas em R **ou** em S | `UNION` |
| `R ∩ S` | Tuplas em R **e** em S | `INTERSECT` |
| `R − S` | Tuplas em R que **não** estão em S | `EXCEPT` |

A diferença é a mais útil das três, porque expressa negação:

```
π matricula (USUARIO) − π matricula (EMPRESTIMO)
```

Matrículas de usuários que **nunca** pegaram nada emprestado.

```sql
SELECT matricula FROM usuario
EXCEPT
SELECT matricula FROM emprestimo;
```

> 💡 Guarde este padrão: **"todos os X que não fizeram Y"** é sempre uma diferença. Em SQL há três formas de escrevê-lo (`EXCEPT`, `NOT IN`, `NOT EXISTS`) e apenas duas funcionam corretamente com nulos (Aula 09, seção 5).

## 6. Produto cartesiano (×) e junção (⋈)

O **produto cartesiano** combina cada tupla de R com cada tupla de S. Se R tem 100 tuplas e S tem 50, o resultado tem 5.000 — quase todas sem sentido.

Ele quase nunca é o que você quer sozinho. O que se quer é o produto **filtrado pela condição de ligação**, e isso é a **junção**:

```
EMPRESTIMO ⋈ EMPRESTIMO.tombo = EXEMPLAR.tombo EXEMPLAR
```

### Junção natural (⋈)

Quando os atributos de ligação têm **o mesmo nome** nas duas relações, a junção natural liga por eles automaticamente e mantém **uma só** cópia da coluna comum:

```
EMPRESTIMO ⋈ EXEMPLAR       -- liga por 'tombo', que existe nas duas
```

> ⚠️ **A junção natural é elegante e traiçoeira.** Ela usa **todos** os atributos de mesmo nome. Se as duas relações tiverem, além de `tombo`, uma coluna `situacao` cada, a junção vai exigir que as duas situações sejam iguais — e devolver quase nada, sem erro. Em SQL, prefira sempre o `JOIN ... ON` explícito, que diz exatamente por onde liga.

### Junções externas

A junção comum descarta tuplas sem par. As **externas** preservam:

| Operação | Preserva | SQL |
|---|---|---|
| Externa à esquerda | Todas as tuplas de R, com nulos onde falta par | `LEFT JOIN` |
| Externa à direita | Todas as de S | `RIGHT JOIN` |
| Externa completa | Todas as duas | `FULL JOIN` |

```
USUARIO ⟕ EMPRESTIMO        -- todos os usuários, tenham ou não empréstimos
```

É como se listam usuários **e** a informação de que alguns não pegaram nada — coisa que a junção comum apagaria silenciosamente.

## 7. Divisão (÷) — o "para todos"

O operador mais difícil, e o único que expressa **quantificação universal**: *"os X que se relacionam com **todos** os Y"*.

`R ÷ S` devolve os valores de R que aparecem associados a **todas** as tuplas de S.

Exemplo: *"quais usuários pegaram emprestado exemplares de **todas** as obras da área de Banco de Dados?"*

```
R = π matricula, isbn (EMPRESTIMO ⋈ EXEMPLAR)     -- quem pegou o quê
S = π isbn (σ codigo_area = 'BD' (CLASSIFICACAO)) -- as obras da área

R ÷ S
```

Concretamente:

```
   R (quem pegou o quê)        S (obras exigidas)      R ÷ S
   ┌───────────┬──────┐        ┌──────┐                ┌───────────┐
   │ 2023101   │ BD-1 │        │ BD-1 │                │ 2023101   │
   │ 2023101   │ BD-2 │        │ BD-2 │                │ 2023103   │
   │ 2023102   │ BD-1 │        └──────┘                └───────────┘
   │ 2023103   │ BD-1 │
   │ 2023103   │ BD-2 │
   │ 2023103   │ AL-1 │
   └───────────┴──────┘

   2023101 → pegou BD-1 e BD-2 ......................... ✅ entra
   2023102 → pegou só BD-1, faltou BD-2 ................ ❌ fica de fora
   2023103 → pegou BD-1, BD-2 e ainda AL-1 ............. ✅ entra
```

Repare no caso de `2023103`: pegar coisas **a mais** não desclassifica. A divisão exige "**todos** os de S", não "exatamente os de S".

> ⚠️ **Não existe operador de divisão em SQL.** A divisão se escreve com dupla negação: *"os usuários para os quais **não existe** obra da área BD que eles **não tenham** pego"*. É `NOT EXISTS` dentro de `NOT EXISTS`, e é a consulta mais difícil da Aula 14. Ela aparece com frequência disfarçada: "clientes que compraram todos os produtos da promoção", "alunos aprovados em todas as obrigatórias".

## 8. Montando sequências

Consultas reais encadeiam operadores. *"Título das obras emprestadas ao usuário 2023101 que ainda não foram devolvidas"*:

```
1.  σ matricula = 2023101 ∧ data_devolucao IS NULL (EMPRESTIMO)
2.  resultado_1 ⋈ EXEMPLAR                          -- liga por tombo
3.  resultado_2 ⋈ OBRA                              -- liga por isbn
4.  π titulo (resultado_3)
```

Ou tudo numa expressão, lida **de dentro para fora**:

```
π titulo ( ( σ matricula = 2023101 ∧ data_devolucao IS NULL (EMPRESTIMO) ⋈ EXEMPLAR ) ⋈ OBRA )
```

```sql
SELECT o.titulo
FROM emprestimo e
JOIN exemplar x ON e.tombo = x.tombo
JOIN obra o ON x.isbn = o.isbn
WHERE e.matricula = 2023101 AND e.data_devolucao IS NULL;
```

> 💡 **A correspondência é quase termo a termo:** `σ` é o `WHERE`, `π` é a lista do `SELECT`, `⋈` é o `JOIN ... ON`, `ρ` é o `AS`. Quem entende a expressão da álgebra escreve o SQL sem pensar — e, mais importante, **lê** o SQL alheio sabendo o que ele faz.

### O que a álgebra **não** tem

Agregação (`COUNT`, `SUM`, `AVG`), agrupamento (`GROUP BY`) e ordenação (`ORDER BY`) **não fazem parte** da álgebra relacional clássica. São extensões que o SQL acrescentou por necessidade prática. Ordenação, aliás, seria impossível na teoria: relação é conjunto, e conjunto não tem ordem (Aula 09).

> 📖 A álgebra relacional é apresentada no livro-base como fundamento da linguagem de consulta, antes do SQL — e essa ordem é deliberada. Há também o **cálculo relacional**, uma formulação declarativa equivalente em poder expressivo (o que se chama *completude relacional*): a álgebra diz *como* obter, o cálculo diz *o que* se quer. O SQL herdou a cara do cálculo e o motor da álgebra.

> 💻 **Modelos desta aula:** [`expressoes.md`](exemplos/expressoes.md)

## 🏋️ Exercícios da aula

Na pasta `aula-11/` do seu repositório. Use o [Relational Algebra Calculator](https://dbis-uibk.github.io/relax/) para conferir suas expressões.

1. **`ex01.md`** — dadas as relações abaixo, escreva **o resultado** (as tuplas exatas) de cada expressão:

   ```
   ALUNO                          MATRICULA
   ┌──────┬───────┬──────┐        ┌──────┬─────────┬──────┐
   │ mat  │ nome  │curso │        │ mat  │ disc    │ nota │
   ├──────┼───────┼──────┤        ├──────┼─────────┼──────┤
   │ 101  │ Ana   │ SI   │        │ 101  │ BD      │  9   │
   │ 102  │ Bruno │ SI   │        │ 101  │ ALG     │  7   │
   │ 103  │ Célia │ ADM  │        │ 102  │ BD      │  5   │
   └──────┴───────┴──────┘        └──────┴─────────┴──────┘
   ```

   (a) `σ curso = 'SI' (ALUNO)`; (b) `π curso (ALUNO)`; (c) `σ nota >= 7 (MATRICULA)`; (d) `ALUNO ⋈ MATRICULA`; (e) `π mat (ALUNO) − π mat (MATRICULA)`; (f) `π nome (ALUNO ⋈ σ nota >= 7 (MATRICULA))`; (g) `ALUNO ⟕ MATRICULA`;

2. **`ex02.md`** — escreva em **álgebra relacional** (esquema da seção 1): (a) título de todas as obras publicadas depois de 2010; (b) nome dos usuários do tipo 'professor'; (c) tombo dos exemplares disponíveis da obra de ISBN '978-85-1234-567-8'; (d) nome dos usuários que têm empréstimo em aberto; (e) título das obras que **nunca** foram emprestadas; (f) nome dos usuários que pegaram emprestada a obra 'Fundamentos de Bancos de Dados';
3. **`ex03.md`** — traduza cada expressão para **português** e depois para **SQL**:

   ```
   (a) π nome (σ tipo = 'aluno' (USUARIO))
   (b) π titulo (OBRA) − π titulo (OBRA ⋈ EXEMPLAR)
   (c) π nome, titulo (USUARIO ⋈ EMPRESTIMO ⋈ EXEMPLAR ⋈ OBRA)
   (d) σ data_devolucao IS NULL (EMPRESTIMO ⟕ USUARIO)
   ```

4. **`ex04.md`** — cada expressão abaixo tem **um erro**. Aponte, explique e corrija: (a) `π nome (σ nota > 7 (ALUNO))` — `nota` não está em `ALUNO`; (b) `ALUNO ∪ MATRICULA`; (c) `π nome, curso (ALUNO) ∩ π nome (ALUNO)`; (d) `σ curso = SI (ALUNO)`; (e) `π mat, nome (ALUNO ⋈ MATRICULA)` sabendo que se quer alunos **sem** matrícula;
5. **Desafio 🌶️ `ex05.md`** — escreva em álgebra relacional: *"nome dos usuários que pegaram emprestado exemplares de **todas** as obras publicadas em 2020"*. (a) Monte a divisão passo a passo, mostrando o conteúdo de R e de S; (b) invente um conjunto pequeno de dados (4 usuários, 3 obras) e calcule o resultado à mão; (c) explique por que `NOT IN` sozinho **não** resolve este problema, e qual é a estrutura lógica que resolve.

## 🧠 Revisão

[8 questões de múltipla escolha](revisao/README.md) para conferir se os conceitos ficaram sólidos. Responda sem consultar a aula — depois volte e corrija.

## ✅ Entrega

```bash
git add aula-11/
git commit -m "Resolve exercícios da aula 11 (álgebra relacional)"
git push
```

---

⬅️ [Aula 10](../aula-10-mapeamento-er-relacional/README.md) | ➡️ [Aula 12 — Normalização](../aula-12-normalizacao/README.md)
