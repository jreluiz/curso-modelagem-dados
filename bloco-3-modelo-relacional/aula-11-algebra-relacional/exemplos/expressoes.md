# Aula 11 — Expressões em álgebra relacional

Cada expressão vem com a pergunta em português e o SQL equivalente. Confira as suas no [Relational Algebra Calculator](https://dbis-uibk.github.io/relax/).

**Esquema usado** (versão simplificada do caso, com `tipo` em `USUARIO`):

```
USUARIO(matricula, nome, email, tipo)
EXEMPLAR(tombo, isbn, situacao)
OBRA(isbn, titulo, ano_publicacao)
EMPRESTIMO(id_emprestimo, matricula, tombo, data_retirada, data_devolucao)
```

## Operadores unários

| # | Pergunta | Álgebra | SQL |
|:--:|---|---|---|
| 1 | Exemplares disponíveis | `σ situacao = 'disponivel' (EXEMPLAR)` | `SELECT * FROM exemplar WHERE situacao = 'disponivel';` |
| 2 | Nome e e-mail de todos | `π nome, email (USUARIO)` | `SELECT DISTINCT nome, email FROM usuario;` |
| 3 | Quais tipos de usuário existem | `π tipo (USUARIO)` | `SELECT DISTINCT tipo FROM usuario;` |
| 4 | Nome dos professores | `π nome (σ tipo = 'professor' (USUARIO))` | `SELECT DISTINCT nome FROM usuario WHERE tipo = 'professor';` |

> ⚠️ O `DISTINCT` aparece em toda tradução de `π` porque a projeção da álgebra **elimina duplicatas** e o `SELECT` não. É a divergência entre conjunto e multiconjunto (Aula 09, §2).

> 💡 **Selecione antes de projetar.** `π nome (σ tipo='professor' (USUARIO))` descarta linhas cedo; o inverso não seria nem possível, já que `tipo` teria sumido na projeção. Essa reescrita é a primeira coisa que todo otimizador faz.

## Operações de conjunto

Exigem **compatibilidade de união**: mesmo número de atributos, mesma ordem, domínios compatíveis.

| # | Pergunta | Álgebra | SQL |
|:--:|---|---|---|
| 5 | Quem nunca pegou nada | `π matricula (USUARIO) − π matricula (EMPRESTIMO)` | `SELECT matricula FROM usuario EXCEPT SELECT matricula FROM emprestimo;` |
| 6 | Obras nunca emprestadas | `π isbn (OBRA) − π isbn (EXEMPLAR ⋈ EMPRESTIMO)` | `SELECT isbn FROM obra EXCEPT SELECT x.isbn FROM exemplar x JOIN emprestimo e ON x.tombo = e.tombo;` |
| 7 | Quem pegou **e** reservou | `π matricula (EMPRESTIMO) ∩ π matricula (RESERVA)` | `... INTERSECT ...` |

> 💡 **Guarde o padrão:** *"todos os X que não fizeram Y"* é **sempre** uma diferença. Em SQL há três escritas (`EXCEPT`, `NOT IN`, `NOT EXISTS`) e apenas duas funcionam corretamente com nulos.

## Junções

| # | Pergunta | Álgebra |
|:--:|---|---|
| 8 | Empréstimos com dados do exemplar | `EMPRESTIMO ⋈ EXEMPLAR` |
| 9 | Título das obras em aberto do usuário 2023101 | `π titulo ( ( σ matricula=2023101 ∧ data_devolucao IS NULL (EMPRESTIMO) ⋈ EXEMPLAR ) ⋈ OBRA )` |
| 10 | Todos os usuários, com ou sem empréstimo | `USUARIO ⟕ EMPRESTIMO` |

A #9, decomposta em passos:

```
1.  T1 ← σ matricula = 2023101 ∧ data_devolucao IS NULL (EMPRESTIMO)
2.  T2 ← T1 ⋈ EXEMPLAR              -- liga por tombo
3.  T3 ← T2 ⋈ OBRA                  -- liga por isbn
4.  resultado ← π titulo (T3)
```

```sql
SELECT DISTINCT o.titulo
FROM emprestimo e
JOIN exemplar x ON e.tombo = x.tombo
JOIN obra     o ON x.isbn  = o.isbn
WHERE e.matricula = 2023101 AND e.data_devolucao IS NULL;
```

> ⚠️ **A junção natural (`⋈` sem condição) usa TODOS os atributos de mesmo nome nas duas relações.** Se `EXEMPLAR` e `EMPRESTIMO` tivessem, além de `tombo`, uma coluna `situacao` cada, a junção exigiria que as duas situações fossem iguais — devolvendo quase nada, sem erro. Em SQL, use sempre `JOIN ... ON` explícito.

## A correspondência, termo a termo

| Álgebra | SQL |
|---|---|
| `σ` (seleção) | `WHERE` |
| `π` (projeção) | a lista do `SELECT` (+ `DISTINCT`) |
| `ρ` (renomeação) | `AS` |
| `⋈` (junção) | `JOIN ... ON` |
| `⟕` (externa à esquerda) | `LEFT JOIN` |
| `×` (produto cartesiano) | `CROSS JOIN`, ou `FROM a, b` sem condição |
| `∪ ∩ −` | `UNION` / `INTERSECT` / `EXCEPT` |
| `÷` (divisão) | **não existe** — `NOT EXISTS` dentro de `NOT EXISTS` |
| — | `GROUP BY`, `COUNT`, `ORDER BY` — **não existem na álgebra clássica** |

## A divisão, passo a passo

**Pergunta:** *"quais usuários pegaram emprestado exemplares de **todas** as obras publicadas em 2020?"*

```
R ← π matricula, isbn (EMPRESTIMO ⋈ EXEMPLAR)      -- quem pegou o quê
S ← π isbn (σ ano_publicacao = 2020 (OBRA))        -- as obras exigidas
resultado ← R ÷ S
```

Com dados concretos:

```
   R (quem pegou o quê)        S (obras de 2020)     R ÷ S
   ┌───────────┬──────┐        ┌──────┐              ┌───────────┐
   │ 2023101   │ BD-1 │        │ RED  │              │ 2023102   │
   │ 2023101   │ BD-2 │        │ SO   │              └───────────┘
   │ 2023101   │ ALG  │        └──────┘
   │ 2023101   │ RED  │
   │ 2023102   │ RED  │
   │ 2023102   │ SO   │
   │ 2023102   │ BD-1 │
   └───────────┴──────┘

   2023101 → pegou RED, faltou SO ............. ❌ (mesmo tendo pego 4 obras!)
   2023102 → pegou RED e SO ................... ✅
```

**Duas lições no mesmo exemplo:** a divisão não premia quantidade, exige **cobertura**; e pegar coisas **a mais** (`2023102` pegou `BD-1` também) não desclassifica.

Em SQL, por dupla negação — *"usuários para os quais não existe obra de 2020 que eles não tenham pego"*:

```sql
SELECT u.nome
FROM usuario u
WHERE NOT EXISTS (
    SELECT 1 FROM obra o
    WHERE o.ano_publicacao = 2020
      AND NOT EXISTS (
          SELECT 1 FROM emprestimo e JOIN exemplar x ON e.tombo = x.tombo
          WHERE e.matricula = u.matricula AND x.isbn = o.isbn
      )
);
```

Rode-a de verdade em [`03-consultas.sql`](../../../bloco-4-sql-e-projeto-fisico/aula-14-sql-dml-consultas/exemplos/03-consultas.sql), consulta 14.

## Cinco expressões com erro, para treinar o olho

| Expressão | Erro |
|---|---|
| `π nome (σ nota > 7 (ALUNO))` | `nota` não é atributo de `ALUNO` — está na relação de matrículas |
| `ALUNO ∪ MATRICULA` | Sem compatibilidade de união: esquemas diferentes |
| `π nome, curso (ALUNO) ∩ π nome (ALUNO)` | Idem: 2 atributos contra 1 |
| `σ curso = SI (ALUNO)` | Falta aspas: `SI` seria lido como nome de atributo |
| `π matricula (EMPRESTIMO) − π matricula (USUARIO)` | Sintaticamente válida, semanticamente inútil: pela integridade referencial, o resultado é **sempre vazio**. A diferença estava invertida |

---

⬅️ [Voltar à Aula 11](../README.md) | 🏠 [Início do curso](../../../README.md)
