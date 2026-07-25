# Esquema relacional — Biblioteca Universitária

O [DER da Aula 08](../../../bloco-2-modelagem-conceitual/aula-08-estudo-de-caso-der/exemplos/der-completo.md) depois de aplicadas as sete regras. **Chave primária sublinhada**, chave estrangeira com seta.

## O esquema

```
USUARIO(matricula, nome, email, data_cadastro)                          — Regra 1
        ‾‾‾‾‾‾‾‾‾
        email UNIQUE

ALUNO(matricula, curso, semestre_ingresso)                              — Opção A
      ‾‾‾‾‾‾‾‾‾
      matricula → USUARIO(matricula)   ON DELETE CASCADE

PROFESSOR(matricula, departamento, titulacao)                           — Opção A
          ‾‾‾‾‾‾‾‾‾
          matricula → USUARIO(matricula)   ON DELETE CASCADE

SERVIDOR(matricula, setor)                                              — Opção A
         ‾‾‾‾‾‾‾‾‾
         matricula → USUARIO(matricula)   ON DELETE CASCADE

TELEFONE(matricula, numero, tipo)                                       — Regra 6
         ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾
         matricula → USUARIO(matricula)   ON DELETE CASCADE

OBRA(isbn, titulo, ano_publicacao, editora)                             — Regra 1
     ‾‾‾‾

AUTOR(id_autor, nome, nacionalidade)                                    — Regra 1
      ‾‾‾‾‾‾‾‾

AREA(codigo_area, nome)                                                 — Regra 1
     ‾‾‾‾‾‾‾‾‾‾‾
     nome UNIQUE

ESCRITA(isbn, id_autor, ordem)                                          — Regra 5
        ‾‾‾‾‾‾‾‾‾‾‾‾‾‾
        isbn     → OBRA(isbn)        ON DELETE CASCADE
        id_autor → AUTOR(id_autor)   ON DELETE RESTRICT
        (isbn, ordem) UNIQUE

CLASSIFICACAO(isbn, codigo_area)                                        — Regra 5
              ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾
              isbn        → OBRA(isbn)        ON DELETE CASCADE
              codigo_area → AREA(codigo_area) ON DELETE RESTRICT

EXEMPLAR(tombo, isbn, data_aquisicao, situacao)                         — Regra 3
         ‾‾‾‾‾
         isbn → OBRA(isbn)   NOT NULL   ON DELETE RESTRICT

FUNCIONARIO(matricula_func, nome, cargo)                                — Regra 1
            ‾‾‾‾‾‾‾‾‾‾‾‾‾‾

EMPRESTIMO(id_emprestimo, matricula, tombo, matricula_func,             — Regra 3 (×3)
           ‾‾‾‾‾‾‾‾‾‾‾‾‾
           data_retirada, data_prevista, data_devolucao)
           matricula      → USUARIO(matricula)            NOT NULL  RESTRICT
           tombo          → EXEMPLAR(tombo)               NOT NULL  RESTRICT
           matricula_func → FUNCIONARIO(matricula_func)   NOT NULL  RESTRICT

RENOVACAO(id_emprestimo, sequencia, data_renovacao, nova_data_prevista) — Regra 2
          ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾
          id_emprestimo → EMPRESTIMO(id_emprestimo)   ON DELETE CASCADE

RESERVA(id_reserva, matricula, isbn, data_solicitacao, situacao)        — Regra 3 (×2)
        ‾‾‾‾‾‾‾‾‾‾
        matricula → USUARIO(matricula)   NOT NULL  RESTRICT
        isbn      → OBRA(isbn)           NOT NULL  RESTRICT

MULTA(id_emprestimo, valor, data_pagamento,                             — Regra 4a
      ‾‾‾‾‾‾‾‾‾‾‾‾‾
      justificativa_perdao, matricula_func)
      id_emprestimo  → EMPRESTIMO(id_emprestimo)   ON DELETE CASCADE
      matricula_func → FUNCIONARIO(matricula_func) NULL permitido, ON DELETE SET NULL
```

**11 entidades + 3 subclasses → 16 relações.**

## Regra por regra

| Regra | Onde foi aplicada | Resultado |
|---|---|---|
| 1 — Entidade forte | `USUARIO`, `OBRA`, `AUTOR`, `AREA`, `EXEMPLAR`, `FUNCIONARIO`, `EMPRESTIMO`, `RESERVA` | Uma relação cada |
| 2 — Entidade fraca | `RENOVACAO` | Chave = chave do dono + chave parcial; FK `CASCADE` |
| 3 — 1:N | `EXEMPLAR`→`OBRA`; `EMPRESTIMO`→ usuário, exemplar, funcionário; `RESERVA`→ usuário, obra | FK sempre no lado **N** |
| 4 — 1:1 | `MULTA`–`EMPRESTIMO` | Opção (a): FK do lado de participação total, virando a própria PK |
| 5 — N:M | `OBRA`–`AUTOR`; `OBRA`–`AREA` | `ESCRITA` (com `ordem`) e `CLASSIFICACAO` |
| 6 — Multivalorado | `telefone` | `TELEFONE`, mesma forma da Regra 2 |
| 7 — n-ário | — | Não há relacionamento ternário neste caso |
| Especialização | `USUARIO`→`ALUNO`/`PROFESSOR`/`SERVIDOR` | Opção A (tabela por subclasse + superclasse) |

## Duas decisões que merecem justificativa

### Por que a opção A na especialização

A especialização é **disjunta e total**, o que permitiria as opções A, B ou C. Escolhemos A por causa de `EMPRESTIMO`:

- **Opção B** (sem superclasse) obrigaria `EMPRESTIMO` a ter três FKs opcionais, ou três tabelas de empréstimo. "Todos os empréstimos do mês" viraria um `UNION` de três consultas;
- **Opção C** (tabela única com discriminador) funcionaria, mas deixaria `curso`, `semestre_ingresso`, `departamento`, `titulacao` e `setor` nulos na maior parte das linhas — cinco colunas, cada usuário preenchendo no máximo duas;
- **Opção A** mantém `EMPRESTIMO` ligado a uma única tabela `USUARIO` e não desperdiça coluna. O custo é uma junção quando se quer o atributo específico do tipo, o que é raro.

### O que a especialização perdeu no caminho

A restrição **disjunta e total** não é expressável em nenhuma das opções, sozinha. Nada no esquema impede que a mesma matrícula apareça em `ALUNO` **e** em `PROFESSOR`, nem obriga que apareça em alguma.

Solução adotada no [DDL](../../../bloco-4-sql-e-projeto-fisico/aula-13-sql-ddl/exemplos/01-ddl.sql): uma coluna discriminadora `usuario.tipo` com `CHECK (tipo IN ('aluno','professor','servidor'))`. Ela não vem das regras de mapeamento — é um acréscimo consciente para tornar **verificável** o que o mapeamento perdeu. A garantia completa (que o tipo bata com a tabela em que a linha está) exigiria gatilho.

## O que mais se perdeu na tradução

| No DER | No esquema | Como recuperar |
|---|---|---|
| "Toda obra tem pelo menos um exemplar" — se fosse `(1,N)` | **Não é expressável** | Gatilho ou verificação na aplicação |
| Nome do relacionamento `EMPRESTA` | Virou uma coluna sem nome | Comentário no DDL |
| Especialização disjunta/total | Nada | `CHECK` no discriminador + gatilho |
| "Máximo 3 exemplares por aluno" | **Não é expressável** | Gatilho ou aplicação |
| A distinção fraca × forte | Só sobrevive na chave composta | Esta documentação |

> ⚠️ **A perda que mais dói é a participação total do lado 1.** `NOT NULL` na FK de `EXEMPLAR` garante *"todo exemplar tem obra"*. O inverso — *"toda obra tem exemplar"* — não vira restrição nenhuma, porque a FK está do outro lado. Guardar essa assimetria evita horas de tentativa de declarar o indeclarável.

---

⬅️ [Voltar à Aula 10](../README.md) | 🏠 [Início do curso](../../../README.md)
