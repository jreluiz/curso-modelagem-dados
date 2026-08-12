# O esquema lógico da biblioteca

A conversão completa do [DER da Aula 06](../../aula-06-notacao-e-tipos-de-entidade/exemplos/der-biblioteca-parcial.md) para o modelo relacional. Use este arquivo como referência de formato no `ex02`.

## O esquema

```
   ALUNO(matricula, nome, email)

   EDITORA(cnpj, nome, cidade)

   LIVRO(isbn, titulo, ano, cnpj → EDITORA)

   EXEMPLAR(isbn → LIVRO, numero_ex, situacao)

   EMPRESTIMO(numero, data_retirada, data_devolucao,
              matricula → ALUNO,
              isbn + numero_ex → EXEMPLAR)
```

A chave primária vem primeiro em cada linha; `→` marca a chave estrangeira e a tabela para onde ela aponta.

## De onde veio cada coluna

| Coluna | Veio de | Por quê |
|---|---|---|
| `LIVRO.cnpj` | `PUBLICADO_POR`, 1:N | a chave estrangeira mora no lado N — um livro tem uma editora |
| `EXEMPLAR.isbn` | `VOLUME_DE`, identificador | entidade fraca: a chave da dona entra na chave da fraca |
| `EMPRESTIMO.matricula` | `FAZ`, 1:N | um empréstimo tem um aluno; um aluno tem vários empréstimos |
| `EMPRESTIMO.isbn + numero_ex` | `REFERE_SE`, 1:N | chave composta se propaga inteira para quem a referencia |

## O que não aceita vazio

Vem direto da participação desenhada no DER:

- `EMPRESTIMO.matricula` — **obrigatório**. A linha era dupla do lado do empréstimo: empréstimo sem aluno não existe;
- `EMPRESTIMO.isbn + numero_ex` — **obrigatório**, pela mesma razão;
- `EMPRESTIMO.data_devolucao` — **aceita vazio**, e é o único aqui que aceita: empréstimo em aberto ainda não foi devolvido;
- `LIVRO.cnpj` — **obrigatório** se toda obra do acervo tiver editora conhecida. Doação sem ficha completa é o caso que faria essa coluna aceitar vazio — decisão a confirmar com o bibliotecário.

## As políticas de exclusão

| Ao apagar… | Política | Por quê |
|---|---|---|
| uma `EDITORA` com livros | **recusar** | o livro continua no acervo; perder a editora não é consequência de nada |
| um `LIVRO` com exemplares | **propagar** | exemplar é entidade fraca — exemplar de obra nenhuma não é coisa |
| um `ALUNO` com empréstimos | **recusar** | o histórico de empréstimo é o registro da biblioteca, não do aluno |

> ⚠️ Repare que **as três decisões saíram do diagrama**, não do gosto de quem programa: onde a participação era total, anular estava proibido de saída; onde a entidade era fraca, propagar é o comportamento correto. Um modelo conceitual bem-feito responde perguntas que só apareceriam meses depois.

## O que este esquema ainda não garante

Que um exemplar não esteja em dois empréstimos em aberto ao mesmo tempo. Nenhuma das três integridades pega isso — é regra com tempo dentro, e fica na lista de regras de negócio para a aplicação verificar.

---

⬅️ [Voltar à Aula 07](../README.md)
