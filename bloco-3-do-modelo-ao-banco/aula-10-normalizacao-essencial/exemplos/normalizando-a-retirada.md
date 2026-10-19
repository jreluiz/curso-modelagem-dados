# Normalizando a retirada — do começo ao fim

Este arquivo mostra **o percurso da normalização**: uma tabela problemática entra, um esquema em 3FN sai, e cada decomposição tem a dependência que a motivou escrita ao lado. É a referência de formato dos exercícios da [Aula 10](../README.md).

---

## O ponto de partida

A planilha de retiradas, importada como uma tabela só:

```
   RETIRADA(isbn, numero_ex, data_retirada, titulo, autores, cnpj, editora,
            codigo_usuario, nome_usuario)
   chave: (isbn, numero_ex, data_retirada)
```

As regras do minimundo que importam aqui, todas já conhecidas:

- cada retirada é de um exemplar, numa data, por um usuário;
- cada livro tem um título, uma editora e um ou mais autores;
- cada editora tem um nome; cada usuário tem um nome.

## Passo 0 — as dependências funcionais

Escritas a partir das regras, nunca dos dados:

```
   D1  (isbn, numero_ex, data_retirada) → codigo_usuario
   D2  codigo_usuario → nome_usuario
   D3  isbn → titulo
   D4  isbn → cnpj
   D5  cnpj → editora
```

E o `autores`, que não aparece em nenhuma dependência: um livro tem **vários** autores, então nenhuma coluna determina "o" autor.

Classificando cada uma em relação à chave `(isbn, numero_ex, data_retirada)`:

| Dependência | Lado esquerdo | Tipo | Forma normal que ela viola |
|---|---|---|---|
| D1 | a chave inteira | da chave | nenhuma — é o que se quer |
| D3, D4 | `isbn`, **parte** da chave | parcial | 2FN |
| D5 | `cnpj`, que não é chave | transitiva (`isbn → cnpj → editora`) | 3FN |
| D2 | `codigo_usuario`, que não é chave | transitiva (chave → `codigo_usuario` → `nome_usuario`) | 3FN |

## Passo 1 — a 1FN: o `autores` sai

A célula `"Marta Ribeiro, João Pereira"` guarda dois valores. A lista vira tabela, com a chave do livro:

```
   RETIRADA(isbn, numero_ex, data_retirada, titulo, cnpj, editora,
            codigo_usuario, nome_usuario)
   LIVRO_AUTOR(isbn, autor)
```

`LIVRO_AUTOR` tem chave `(isbn, autor)`: o mesmo autor aparece em vários livros, e o mesmo livro tem vários autores.

## Passo 2 — a 2FN: o que depende só do `isbn` sai

D3 e D4 são parciais. Sai uma tabela com chave `isbn`, levando o `titulo` e o `cnpj` — e a `editora`, que vai junto porque depende do `cnpj`:

```
   LIVRO(isbn, titulo, cnpj, editora)
   RETIRADA(isbn, numero_ex, data_retirada, codigo_usuario, nome_usuario)
   LIVRO_AUTOR(isbn, autor)
```

## Passo 3 — a 3FN: as duas correntes se quebram

D5 dentro de `LIVRO` e D2 dentro de `RETIRADA` são transitivas. Cada uma sai para uma tabela cuja chave é o lado esquerdo dela:

```
   EDITORA(cnpj, nome)
   USUARIO(codigo, nome)
   LIVRO(isbn, titulo, cnpj → EDITORA)
   LIVRO_AUTOR(isbn → LIVRO, autor)
   RETIRADA(isbn, numero_ex, data_retirada, codigo_usuario → USUARIO)
```

As setas `→` apareceram agora porque cada decomposição deixou uma coluna em comum entre duas tabelas — e essa coluna é a chave de uma delas. É exatamente uma chave estrangeira.

## As três conferências

**1. Toda coluna original está em alguma tabela.** As nove: `isbn`, `numero_ex`, `data_retirada`, `codigo_usuario` em `RETIRADA`; `titulo` e `cnpj` em `LIVRO`; `autores` como `autor` em `LIVRO_AUTOR`; `editora` como `nome` em `EDITORA`; `nome_usuario` como `nome` em `USUARIO`. Nenhuma sobrou.

**2. Toda decomposição separou ao longo de uma dependência, e a coluna comum é chave de um dos lados.**

| Decomposição | Coluna em comum | Ela é chave de |
|---|---|---|
| `RETIRADA` × `LIVRO` | `isbn` | `LIVRO` |
| `LIVRO` × `LIVRO_AUTOR` | `isbn` | `LIVRO` — o autor é do livro, e não da retirada |
| `LIVRO` × `EDITORA` | `cnpj` | `EDITORA` |
| `RETIRADA` × `USUARIO` | `codigo_usuario` | `USUARIO` |

Com isso, juntar as tabelas de novo pela coluna em comum devolve exatamente as linhas da planilha.

**3. As três anomalias sumiram.**

| Anomalia | Antes | Depois |
|---|---|---|
| alteração | o nome da editora em toda retirada de todo livro dela | uma linha em `EDITORA` |
| inserção | livro sem retirada não cabia | o livro entra em `LIVRO`, sem retirada nenhuma |
| exclusão | apagar a última retirada apagava o livro | o livro continua em `LIVRO` |

## O roteiro, para qualquer tabela

Três perguntas, nesta ordem, e uma conferência depois de cada resposta:

```
   1. Alguma célula guarda mais de um valor?                    → 1FN
   2. A chave é composta? Alguma coluna depende de parte dela?  → 2FN
   3. Alguma coluna que não é chave determina outra?            → 3FN
      … e depois de cada decomposição: a coluna em comum
        é chave de um dos lados?                                → sem perda
```

---

⬅️ [Voltar à Aula 10](../README.md)
