# Aula 04 — Integridade e o Valor Nulo

> 🎯 Objetivos: classificar as quatro restrições de integridade, explicar o que o valor nulo significa e não significa, e escolher a ação referencial correta para cada chave estrangeira.
> 🎬 Slides da aula: [apresentacao-04-integridade-e-nulo.pdf](apresentacao/apresentacao-04-integridade-e-nulo.pdf)

## 1. O que o banco recusa

Um modelo não serve só para guardar dado certo. Serve, principalmente, para **recusar dado errado** — e recusar sozinho, milhões de vezes por dia, sem depender de ninguém lembrar da regra.

Veja quatro tentativas de escrever na biblioteca. Todas fracassam, e por motivos diferentes:

```
   ┌───────────────────────────────────────────────┬─────────────────────────────┐
   │ Tentativa                                     │ Por que o banco recusa      │
   ├───────────────────────────────────────────────┼─────────────────────────────┤
   │ ano_publicacao = 'mil e quinhentos'           │ não é um ano                │
   │ exemplar com tombo vazio                      │ sem identificação           │
   │ empréstimo para a matrícula 9999999           │ esse aluno não existe       │
   │ devolução anterior à retirada                 │ o tempo não anda para trás  │
   └───────────────────────────────────────────────┴─────────────────────────────┘
```

São as **quatro restrições de integridade**, e as próximas quatro seções são uma para cada.

> 💡 A diferença prática entre "o sistema não deixa" e "combinamos que ninguém faz isso" é enorme: a primeira é verificada em toda escrita, sem falhar; a segunda dura até a primeira pressa de alguém.

## 2. Integridade de domínio

**Todo valor pertence ao domínio do seu atributo.** `ano_publicacao` recebe inteiros entre 1450 e o ano corrente; `situacao` recebe uma de quatro palavras; `email` tem uma arroba.

O domínio tem duas metades, e você declara as duas:

- **O tipo** — inteiro, data, texto. É o que impede `'mil e quinhentos'`;
- **A faixa de valores válidos dentro do tipo** — porque `-3` é um inteiro perfeitamente válido e um ano de publicação impossível.

Na Aula 13 as duas viram uma linha de SQL cada. Por enquanto, escreva o domínio ao lado do esquema, em português:

```
OBRA(isbn, titulo, ano_publicacao, editora)
     ‾‾‾‾
     ano_publicacao: inteiro, entre 1450 e o ano atual
     situacao: uma de {disponivel, emprestado, manutencao, extraviado}
```

## 3. Integridade de entidade

**A chave primária nunca é nula e nunca se repete.**

É a regra que dá sentido ao verbo "identificar": um identificador vazio não identifica coisa nenhuma, e um identificador repetido identifica duas coisas ao mesmo tempo — que é o mesmo que não identificar.

Ela vale para chave composta também, e aí pega mais gente: numa PK `(matricula, cod_disciplina)`, **nenhuma das duas** partes pode ser nula. Não existe "meia chave".

## 4. Integridade referencial

**Todo valor de chave estrangeira ou existe na tabela referenciada, ou é nulo.** Nunca um valor inventado.

```
   ALUNO                          EMPRESTIMO
   ┌───────────┬────────────┐     ┌───────────┬───────────┬────────────┐
   │ matricula │ nome       │     │ n_emprest │ matricula │ retirada   │
   ├───────────┼────────────┤     ├───────────┼───────────┼────────────┤
   │  2023101  │ Ana Souza  │◄────┤   1001    │  2023101  │ 2026-03-02 │  ✅ existe
   │  2023102  │ Bruno Lima │◄────┤   1002    │  2023102  │ 2026-03-09 │  ✅ existe
   └───────────┴────────────┘  ✗──┤   1003    │  9999999  │ 2026-03-11 │  ❌ VIOLA
                                  └───────────┴───────────┴────────────┘
```

É a restrição que impede um empréstimo apontar para um aluno que não existe — o famoso *registro órfão*, que some dos relatórios e reaparece na auditoria.

> ⚠️ Ela também vale **na saída**: se alguém apagar a Ana enquanto o empréstimo 1001 existe, a linha 1001 fica órfã. O que o banco faz nesse momento é você quem decide — é a seção 7.

## 5. Integridade semântica

Tudo o mais que precisa ser verdade no seu minimundo, e que as três anteriores não cobrem:

- `data_devolucao >= data_retirada`;
- um exemplar em manutenção não pode ser emprestado;
- o aluno não pode ter mais empréstimos em aberto que o limite da categoria dele.

Parte disso o banco garante (a primeira vira uma regra de uma linha na Aula 13). Parte não cabe em regra declarada e fica na aplicação. E parte fica só escrita — mas **escrita**, ao lado do modelo, para que alguém possa cobrar.

> 📏 **Regra do curso:** toda regra de negócio que o diagrama não consegue dizer vai numa lista em português abaixo dele. Regra que não está escrita em lugar nenhum não é regra: é lembrança.

## 6. O valor nulo e seus três significados

Nulo **não é zero**. Nulo **não é string vazia**. Nulo é a **ausência de valor** — e carrega três significados bem diferentes sob o mesmo símbolo:

| Significado | Exemplo |
|---|---|
| **Não se aplica** | `data_devolucao` de um empréstimo em aberto — ele ainda não foi devolvido |
| **Desconhecido** | O aluno tem telefone, mas ninguém anotou |
| **Não informado** | O aluno se recusou a dar o telefone |

Os três são "vazio" para o banco, e significam coisas incompatíveis para você. Daí a regra:

> 📏 **Regra do curso:** declare obrigatório tudo que não tenha um motivo escrito para ser opcional, e **documente o significado** de cada nulo que sobrar. Na Biblioteca, `data_devolucao` nula significa exatamente uma coisa: empréstimo em aberto.

E a consequência que atrapalha o resto do curso: **nulo não é igual a nada, nem a si mesmo.** Comparar qualquer coisa com nulo não dá verdadeiro nem falso — dá *desconhecido*:

| `A` | `B` | `A = B` |
|:---:|:---:|:---:|
| 5 | 5 | verdadeiro |
| 5 | 3 | falso |
| 5 | nulo | **desconhecido** |
| nulo | nulo | **desconhecido** |

> ⚠️ Por isso, na Aula 14, procurar empréstimos em aberto com `data_devolucao = vazio` devolve **zero linhas, sempre** — e sem erro nenhum, que é a parte cruel. Existe uma forma própria de perguntar "está vazio?", e ela não é o sinal de igual.

## 7. Ações referenciais: o que acontece ao apagar

Alguém pede para apagar um aluno que tem empréstimos. O banco não pode simplesmente obedecer — a integridade referencial da seção 4 seria violada. Então ele faz o que **você** decidiu, no momento em que declarou a FK:

| Ação | Ao apagar a linha referenciada… |
|---|---|
| **Recusar** | A operação falha e nada acontece. É o padrão, e a escolha certa na dúvida |
| **Em cascata** | Apaga junto todas as linhas que apontavam para ela |
| **Esvaziar** | Põe nulo na FK das linhas dependentes (exige que a FK seja opcional) |

Como escolher, na Biblioteca:

| Relacionamento | Ação | Por quê |
|---|---|---|
| `EMPRESTIMO` → `ALUNO` | Recusar | Apagar o aluno apagaria o histórico. Aluno que sai é **inativado**, não excluído |
| `TELEFONE` → `ALUNO` | Em cascata | O telefone é parte do aluno; sem ele, não significa nada |
| `RENOVACAO` → `EMPRESTIMO` | Em cascata | Idem: só existe dentro do empréstimo |
| `EXEMPLAR` → `OBRA` | Recusar | Apagar a obra apagaria exemplares que existem na prateleira |
| `MULTA` → `FUNCIONARIO` (quem perdoou) | Esvaziar | O funcionário pode sair; a multa continua perdoada, só se perde quem autorizou |

> ⚠️ **Cascata é a resposta certa para o dependente e perigosa para todo o resto.** Um comando de uma linha apagando uma obra pode levar junto exemplares, empréstimos, renovações e multas — em silêncio, sem aviso, sem pergunta. Regra prática: cascata **só** onde a linha dependente não faz sentido sozinha. Nos demais, recusar, e que o banco reclame.

> 💡 Como saber se é "dependente"? Tire a tabela dona e pergunte se a linha ainda se identifica e ainda significa alguma coisa. Um telefone sem dono é um número solto; um empréstimo sem aluno é um buraco no histórico — mas o histórico existia.

> 📖 As restrições de integridade e o tratamento do valor nulo estão no capítulo do modelo relacional, no livro-base. A lógica de três valores é curta lá e vale reler antes das aulas de consulta.

## 🏋️ Exercícios da aula

Na pasta `aula-04/` do seu repositório:

1. **`ex01.md`** — para cada situação, diga qual das quatro restrições de integridade é violada — uma palavra por letra: (a) inserir um empréstimo para a matrícula 9999999, que não existe; (b) inserir uma obra com `ano_publicacao = 'antigo'`; (c) inserir dois exemplares com o mesmo tombo; (d) inserir um exemplar sem tombo; (e) registrar uma devolução anterior à retirada. *Confira assim: as quatro restrições aparecem, e a de entidade aparece duas vezes.*
2. **`ex02.md`** — na Biblioteca, `EMPRESTIMO(n_emprest, matricula, tombo, retirada, devolucao)` tem `devolucao` vazia em todo empréstimo ainda não devolvido. Responda em uma linha cada: (a) qual dos três significados de nulo da seção 6 é esse? (b) qual é a frase que documenta esse nulo no modelo? (c) o atendente pediu os empréstimos em aberto perguntando por `devolucao = vazio` e recebeu zero linhas — por quê? *Confira assim: a resposta de (c) está na tabela de verdade do fim da seção 6, e não é "o banco está com defeito".*
3. **`ex03.md`** — o modelo da Biblioteca tem estas quatro chaves estrangeiras: `EMPRESTIMO→ALUNO`, `EXEMPLAR→OBRA`, `TELEFONE→ALUNO`, `MULTA→EMPRESTIMO`. Escolha a **ação referencial** de cada uma entre as três da seção 7 e justifique em uma linha. *Confira assim: em toda cascata que você escolher, a linha dependente precisa ser incapaz de significar alguma coisa sozinha — um telefone sem dono não é telefone de ninguém.*

## 🧠 Revisão

[8 questões de múltipla escolha](revisao/README.md) para conferir se os conceitos ficaram sólidos. Responda sem consultar a aula — depois volte e corrija.

## ✅ Entrega

```bash
git add aula-04/
git commit -m "Resolve exercícios da aula 04 (integridade e nulo)"
git push
```

---

⬅️ [Aula 03](../aula-03-relacionamentos-chave-estrangeira/README.md) | ➡️ [Aula 05 — O minimundo e o DER](../../bloco-2-do-minimundo-ao-esquema/aula-05-minimundo-e-der/README.md)
