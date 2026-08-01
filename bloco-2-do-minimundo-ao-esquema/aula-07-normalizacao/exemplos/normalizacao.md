# Normalização passo a passo — a ficha de empréstimo

> A decomposição completa da tabela `EMPRESTIMO_ITEM` da Aula 07, com as dependências, a violação de cada etapa e o esquema final.

## Ponto de partida

Uma tabela só, com chave composta `(id_emp, tombo)`:

```
   EMPRESTIMO_ITEM
   ┌────────┬───────┬────────────┬───────────┬────────────┬────────────────┬───────────┐
   │ id_emp │ tombo │ retirada   │ matricula │ nome_usu   │ titulo         │ categoria │
   ├────────┼───────┼────────────┼───────────┼────────────┼────────────────┼───────────┤
   │  1001  │ 4417  │ 2026-03-02 │  2023101  │ Ana Souza  │ Banco de Dados │ aluno     │
   │  1001  │ 4418  │ 2026-03-02 │  2023101  │ Ana Souza  │ Eng. Software  │ aluno     │
   │  1002  │ 4417  │ 2026-03-09 │  2023102  │ Bruno Lima │ Banco de Dados │ aluno     │
   │  1003  │ 4420  │ 2026-03-11 │  2023101  │ Ana Souza  │ Redes          │ aluno     │
   └────────┴───────┴────────────┴───────────┴────────────┴────────────────┴───────────┘
```

## As dependências funcionais

Lidas do minimundo, não da instância:

| Dependência | Lê-se |
|---|---|
| `(id_emp, tombo) → todas` | o par identifica a linha |
| `id_emp → retirada, matricula` | o empréstimo determina quando saiu e para quem |
| `tombo → titulo` | o exemplar determina o título da obra |
| `matricula → nome_usu, categoria` | o usuário determina seu nome e sua categoria |

## Etapa 1 — 1FN

**Já está.** Toda célula tem um valor indivisível: nenhuma lista, nenhuma coluna numerada. Nada a fazer.

## Etapa 2 — 2FN: remover as dependências parciais

**Violações encontradas:** duas.

- `id_emp → retirada, matricula` — depende de **parte** da chave;
- `tombo → titulo` — depende da **outra parte** da chave.

Cada uma vira a sua própria tabela, com o determinante como chave:

```
EMPRESTIMO(id_emp, retirada, matricula, nome_usu, categoria)
           ‾‾‾‾‾‾
EXEMPLAR(tombo, titulo)
         ‾‾‾‾‾
EMPRESTIMO_ITEM(id_emp, tombo)
                ‾‾‾‾‾‾‾‾‾‾‾‾‾
                id_emp → EMPRESTIMO(id_emp)
                tombo  → EXEMPLAR(tombo)
```

**Redundância eliminada:** o título "Banco de Dados" estava escrito duas vezes e passa a estar em uma; a data de retirada do empréstimo 1001 estava duas vezes e passa a estar em uma.

## Etapa 3 — 3FN: remover a dependência transitiva

**Violação encontrada:** uma, dentro de `EMPRESTIMO`.

`matricula → nome_usu, categoria`, e `matricula` não é chave da tabela — é uma coluna comum. As duas colunas chegam até a chave dando um pulo pela matrícula.

```
USUARIO(matricula, nome_usu, categoria)
        ‾‾‾‾‾‾‾‾‾
EMPRESTIMO(id_emp, retirada, matricula)
           ‾‾‾‾‾‾
           matricula → USUARIO(matricula)
```

**Redundância eliminada:** "Ana Souza" estava escrita três vezes e passa a estar em uma.

## Esquema final, em 3FN

```
USUARIO(matricula, nome_usu, categoria)
        ‾‾‾‾‾‾‾‾‾

EXEMPLAR(tombo, titulo)
         ‾‾‾‾‾

EMPRESTIMO(id_emp, retirada, matricula)
           ‾‾‾‾‾‾
           matricula → USUARIO(matricula)

EMPRESTIMO_ITEM(id_emp, tombo)
                ‾‾‾‾‾‾‾‾‾‾‾‾‾
                id_emp → EMPRESTIMO(id_emp)
                tombo  → EXEMPLAR(tombo)
```

Uma tabela virou quatro. Confira o resultado contra as três anomalias da Aula 01:

| Antes | Agora |
|---|---|
| Corrigir o nome da Ana exigia alterar 3 linhas | Uma alteração, em `USUARIO` |
| Não havia onde cadastrar um exemplar nunca emprestado | `EXEMPLAR` existe sozinha |
| Apagar o empréstimo 1003 levava junto a única menção ao exemplar 4420 | Apagar o empréstimo apaga só o empréstimo |

## Duas observações que valem para qualquer decomposição

**A normalização não inventou nada.** Compare o esquema final com o que sairia do diagrama da Aula 05 mapeado pelas regras da Aula 06: são o mesmo esquema. Quem modela o conceitual antes chega lá pelo caminho curto; a normalização é a rede de segurança para quando não houve diagrama — ou quando ele estava errado.

**A decomposição precisa poder ser desfeita.** As quatro tabelas juntas, ligadas pelas chaves, reproduzem exatamente a tabela original — nenhuma linha a mais, nenhuma a menos. Uma decomposição que não permite isso perdeu informação, e a prova formal desse "não perdeu" é assunto do livro-base, não deste curso. Na prática, o critério que basta aqui é: **separe sempre pelo determinante**, deixando uma cópia dele nas duas tabelas.

---

⬅️ [Voltar à Aula 07](../README.md) | 🏠 [Início do curso](../../../README.md)
