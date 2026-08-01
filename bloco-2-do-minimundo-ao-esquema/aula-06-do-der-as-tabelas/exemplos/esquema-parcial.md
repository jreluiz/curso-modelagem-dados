# Esquema parcial — Biblioteca Universitária

> Os fragmentos do [DER da Aula 05](../../aula-05-minimundo-e-der/exemplos/der-parcial.md) depois das cinco regras. O esquema **completo** só aparece na [Aula 08](../../aula-08-estudo-de-caso/exemplos/der-completo.md).
>
> Notação: chave primária sublinhada, chave estrangeira com seta.

## O esquema

```
USUARIO(matricula, nome, email, categoria, data_cadastro)          — Regra 1
        ‾‾‾‾‾‾‾‾‾
        email UNIQUE
        categoria: uma de {aluno, professor, servidor}

TELEFONE(matricula, numero, tipo)                                  — Regra 2
         ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾
         matricula → USUARIO(matricula)   obrigatória, em cascata

OBRA(isbn, titulo, ano_publicacao, editora)                        — Regra 1
     ‾‾‾‾
     ano_publicacao: inteiro entre 1450 e o ano corrente

AUTOR(id_autor, nome, nacionalidade)                               — Regra 1
      ‾‾‾‾‾‾‾‾

ESCRITA(isbn, id_autor, ordem)                                     — Regra 4
        ‾‾‾‾‾‾‾‾‾‾‾‾‾‾
        isbn     → OBRA(isbn)        obrigatória, em cascata
        id_autor → AUTOR(id_autor)   obrigatória, recusar
        (isbn, ordem) UNIQUE

EXEMPLAR(tombo, isbn, data_aquisicao, situacao)                    — Regra 3
         ‾‾‾‾‾
         isbn → OBRA(isbn)   obrigatória, recusar
         situacao: uma de {disponivel, emprestado, manutencao, extraviado}
```

**5 entidades + 1 atributo multivalorado + 1 relacionamento N:M → 6 tabelas.**

## Regra por regra

| Regra | Onde foi aplicada | Resultado |
|---|---|---|
| 1 — Entidade vira tabela | `USUARIO`, `OBRA`, `AUTOR`, `EXEMPLAR` | Uma tabela cada |
| 2 — Multivalorado vira tabela | `telefone` | `TELEFONE`, chave `(matricula, numero)` |
| 3 — 1:N vira FK do lado N | `EXEMPLAR` → `OBRA` | Coluna `isbn` em `EXEMPLAR` |
| 4 — N:M vira associativa | `OBRA` – `AUTOR` | `ESCRITA`, com o atributo `ordem` |
| 5 — 1:1 | — | Não há 1:1 neste fragmento; ele aparece na Aula 08, entre `MULTA` e `EMPRESTIMO` |

## Três decisões que precisam de justificativa escrita

**Por que `ESCRITA` tem `(isbn, ordem)` como restrição única.** A chave primária é o par `(isbn, id_autor)`, que impede o mesmo autor aparecer duas vezes na mesma obra. Mas nada nela impede que dois autores diferentes sejam ambos "o segundo autor". A restrição extra fecha esse buraco — e ela **não vem das regras de mapeamento**: é um acréscimo consciente, a partir da leitura do enunciado.

**Por que `EXEMPLAR → OBRA` recusa a exclusão e `TELEFONE → USUARIO` apaga em cascata.** O exemplar é um objeto físico que existe na prateleira: apagar a obra não faz o volume sumir do mundo, então o banco deve recusar. O telefone só existe como propriedade do usuário; sem o dono, é um número solto. É o teste da Aula 04 — *tire a tabela dona e pergunte se a linha ainda significa alguma coisa*.

**Por que `categoria` não virou tabela.** Ela tem três valores fixos e nada mais a guardar. Uma tabela `CATEGORIA(codigo, nome)` com três linhas acrescentaria uma junção a toda consulta e não responderia nenhuma pergunta nova. No dia em que o limite de empréstimos precisar ser configurado sem mexer no código, ela vira tabela — e nesse dia haverá o que guardar dentro dela.

## O que este esquema já não diz mais

Comparando com o diagrama de origem:

| Estava no DER | Sumiu no esquema |
|---|---|
| "Uma obra é escrita por **pelo menos um** autor" | Nada garante isso — o esquema aceita obra sem nenhuma linha em `ESCRITA` |
| O rótulo `"assina"` do relacionamento | Virou uma coluna sem nome em `ESCRITA` |
| "Uma obra pode existir sem exemplar" | Continua verdade, mas por omissão — ninguém declara isso |

---

⬅️ [Voltar à Aula 06](../README.md) | 🏠 [Início do curso](../../../README.md)
