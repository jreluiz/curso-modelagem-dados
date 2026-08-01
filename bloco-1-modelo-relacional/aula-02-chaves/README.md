# Aula 02 — Chaves: Como Identificar uma Linha

> 🎯 Objetivos: distinguir superchave, chave candidata e chave primária, reconhecer quando a chave precisa ser composta e escolher entre chave natural e chave artificial com justificativa escrita.
> 🎬 Slides da aula: [apresentacao-02-chaves.pdf](apresentacao/apresentacao-02-chaves.pdf)

## 1. Apontar para uma linha e não errar

A biblioteca tem esta tabela de exemplares — as cópias físicas que ficam na prateleira:

```
   EXEMPLAR
   ┌───────┬────────────────┬───────────────────────┬────────────┐
   │ tombo │ isbn           │ titulo                │ aquisicao  │
   ├───────┼────────────────┼───────────────────────┼────────────┤
   │ 4417  │ 978-85-111-1   │ Banco de Dados        │ 2019-04-10 │
   │ 4418  │ 978-85-222-2   │ Engenharia de Software│ 2019-04-10 │
   │ 4419  │ 978-85-111-1   │ Banco de Dados        │ 2021-08-03 │
   │ 4420  │ 978-85-333-3   │ Redes de Computadores │ 2022-02-17 │
   └───────┴────────────────┴───────────────────────┴────────────┘
```

Agora responda depressa: **como você aponta para o exemplar da terceira linha?**

Por `titulo` não dá — "Banco de Dados" pega duas linhas. Por `isbn` também não: o ISBN identifica a **obra**, e a biblioteca tem duas cópias dela. Por `aquisicao` menos ainda. Sobra `tombo`, que é o número colado na etiqueta justamente para isso.

Essa pergunta — *qual conjunto de colunas aponta para uma linha e só uma?* — é a pergunta que esta aula responde. E ela tem três respostas de tamanhos diferentes.

## 2. Superchave: qualquer conjunto que identifica

**Superchave** é qualquer conjunto de atributos que identifica unicamente uma tupla. Sem exigência de economia.

Em `EXEMPLAR`, são superchaves:

- `(tombo)` — funciona;
- `(tombo, titulo)` — também funciona, com uma coluna sobrando;
- `(tombo, isbn, titulo, aquisicao)` — a tabela inteira. Funciona, e é ridículo.

O padrão: **acrescentar colunas a uma superchave produz outra superchave**. Se `tombo` já identifica, `tombo` com qualquer companhia continua identificando — a companhia não atrapalha, só não ajuda.

> ⚠️ E `(isbn, aquisicao)`? Parece funcionar nesta instância: nenhuma dupla se repete nas quatro linhas. Mas identificação **não se decide olhando os dados de hoje** — decide-se perguntando ao mundo. A biblioteca pode comprar dois exemplares da mesma obra no mesmo dia, e no dia em que isso acontecer a dupla deixa de identificar. Chave é regra do minimundo, não coincidência da instância.

## 3. Chave candidata: a superchave sem gordura

**Chave candidata** é a superchave **mínima** — aquela de que você não consegue tirar nenhum atributo sem perder a capacidade de identificar.

Em `EXEMPLAR` só existe uma: `(tombo)`. As outras superchaves da seção anterior têm colunas removíveis, então não são candidatas.

O teste é mecânico: **tire uma coluna de cada vez e veja se ainda identifica.**

- De `(tombo, titulo)` tire `titulo` → `(tombo)` ainda identifica → não era mínima;
- De `(tombo)` tire `tombo` → sobra nada → é mínima. É candidata.

Uma tabela pode ter **várias** candidatas:

```
   ALUNO
   ┌───────────┬─────────────┬──────────────────┬────────────┐
   │ matricula │ cpf         │ email            │ nome       │
   ├───────────┼─────────────┼──────────────────┼────────────┤
   │  2023101  │ 111.111.111 │ ana@escola.br    │ Ana Souza  │
   │  2023102  │ 222.222.222 │ bruno@escola.br  │ Bruno Lima │
   └───────────┴─────────────┴──────────────────┴────────────┘
        ↑             ↑              ↑
        └─────────────┴──────────────┴── três candidatas: cada uma identifica sozinha
```

`matricula`, `cpf` e `email` identificam individualmente, e nenhuma delas tem coluna sobrando. São **três chaves candidatas** — e, do ponto de vista da definição, nenhuma é melhor que as outras. A diferença entre elas não é lógica; é prática, e é a próxima seção.

## 4. Chave primária e chave alternativa

Quando há mais de uma candidata, alguém escolhe. A escolhida é a **chave primária** (PK); as que ficaram de fora são **chaves alternativas**.

```
ALUNO(matricula, cpf, email, nome)
      ‾‾‾‾‾‾‾‾‾
      PK          ↑      ↑
                  chaves alternativas
```

A escolha não é sorteio. Três critérios, nesta ordem:

1. **Estabilidade.** O valor nunca muda? E-mail muda. Nome muda. Matrícula, não;
2. **Obrigatoriedade.** Todo mundo tem? O aluno estrangeiro pode não ter CPF no dia da matrícula;
3. **Simplicidade.** É curto e de tipo simples? A PK vai ser copiada em toda tabela que referenciar esta (Aula 03), então o tamanho dela se multiplica.

> ⚠️ **CPF e e-mail são as duas piores escolhas clássicas de chave primária**, e pelos dois primeiros critérios: o e-mail muda quando a pessoa troca de provedor, e o CPF nem sempre existe no momento do cadastro. Isso não os desqualifica como chaves **alternativas** — continuam sendo únicos, e o banco deve garantir isso.

> 💡 "Ser alternativa" não é castigo. É uma promessa que o banco vai cumprir: *este valor também não se repete*. Na Aula 13 isso vira uma palavra — `UNIQUE`.

## 5. Quando a chave precisa de duas colunas

Nem toda linha é identificada por um atributo só. Veja a tabela que registra quais alunos estão matriculados em quais turmas:

```
   MATRICULA_TURMA
   ┌───────────┬──────────┬────────────┐
   │ matricula │ cod_turma│ data_insc  │
   ├───────────┼──────────┼────────────┤
   │  2023101  │ BD-2026A │ 2026-02-14 │
   │  2023101  │ ES-2026A │ 2026-02-14 │
   │  2023102  │ BD-2026A │ 2026-02-16 │
   └───────────┴──────────┴────────────┘
```

`matricula` sozinha não serve: a Ana aparece duas vezes. `cod_turma` sozinha também não: a turma de BD tem dois alunos. Mas o par `(matricula, cod_turma)` identifica — e é mínimo, porque tirando qualquer um dos dois a identificação se perde.

Isso é uma **chave composta**: uma chave candidata formada por mais de um atributo.

> ⚠️ **Composta é diferente de longa.** `PRODUTO(codigo, nome, fabricante)` com os três sublinhados não é chave composta — é erro. Se `codigo` já identifica, o resto é excesso, e esse excesso vai ser copiado em toda tabela que referenciar `PRODUTO`. Chave composta se usa quando é **necessária**, não quando dá vontade de descrever a linha.

## 6. Chave natural × chave artificial

A `matricula` do aluno e o `tombo` do exemplar são **chaves naturais**: existem no mundo real, estão impressas na carteirinha e na etiqueta, e as pessoas as usam para conversar.

A alternativa é inventar uma: uma coluna `id` que o próprio banco preenche com 1, 2, 3… Ela se chama **chave artificial** (ou *surrogate*), não significa nada fora do sistema e é sempre estável, porque nada no mundo pode mudá-la.

| | Natural | Artificial |
|---|---|---|
| **A favor** | Legível; já existe; permite conferir com o papel | Nunca muda; sempre existe; curta e do mesmo tipo em toda tabela |
| **Contra** | Pode mudar; pode faltar; pode ser longa | Não diz nada; exige uma junção para exibir qualquer coisa; permite duas linhas idênticas com `id` diferente |

> ⚠️ **A armadilha da chave artificial** é achar que ela dispensa pensar:

```
   PESSOA — com id artificial e nenhuma garantia sobre o CPF
   ┌────┬─────────────┬──────────────┐
   │ id │ cpf         │ nome         │
   ├────┼─────────────┼──────────────┤
   │  1 │ 111.111.111 │ Ana Souza    │
   │  2 │ 111.111.111 │ Ana M. Souza │  ← o banco aceitou: os id são diferentes
   └────┴─────────────┴──────────────┘
```

São duas linhas para uma pessoa só, e o banco não viu problema nenhum — a chave primária dele está intacta. A chave artificial é a PK; **a chave natural continua existindo e continua precisando ser garantida**, agora como chave alternativa. Quem esquece essa segunda metade troca um problema por outro pior, porque o duplicado entra em silêncio.

> 📏 **Regra do curso:** use a chave natural quando ela for estável, obrigatória e curta — `tombo`, `matricula`, `placa`, `ISBN` são bons casos. Use artificial quando nenhuma candidata natural passar nos três critérios da seção 4. E **escreva a decisão** ao lado do modelo, em uma linha.

> 📖 Superchave, chave candidata, primária e alternativa aparecem no livro-base junto com a definição de relação. A discussão natural × artificial é mais de prática que de teoria — o livro trata de leve, e a experiência trata o resto.

## 🏋️ Exercícios da aula

Na pasta `aula-02/` do seu repositório:

1. **`ex01.md`** — dada a relação `FUNCIONARIO(matricula, cpf, nome, email_corporativo, ramal, setor)`, em que o e-mail corporativo é gerado a partir do nome e o ramal é reaproveitado quando alguém sai: liste **todas as chaves candidatas** e explique, em uma linha cada, por que as demais colunas não formam candidata. *Confira assim: para cada candidata que você listou, tire uma coluna e mostre que a identificação se perde. Se não perder, não era candidata.*
2. **`ex02.md`** — escolha a **chave primária** de `FUNCIONARIO` e justifique com os três critérios da seção 4, um parágrafo por critério. Depois diga quais ficaram como chaves alternativas e o que o banco precisa garantir sobre elas. *Confira assim: a sua justificativa tem que sobreviver à pergunta "e se a pessoa mudar de setor, de ramal e de e-mail no mesmo dia?".*
3. **`ex03.md`** — três equipes escolheram PKs diferentes para uma tabela de clientes: a primeira usou `cpf`, a segunda `email`, a terceira um `id` artificial. Para **cada uma**, descreva um evento concreto do mundo real que quebra ou incomoda aquela escolha, e diga o que acontece com os dados quando ele ocorre. *Confira assim: as três têm problema — inclusive a artificial. Se você achou que uma é perfeita, procure de novo.*
4. **`ex04.md`** — modele a tabela que registra **quais professores lecionam quais disciplinas em quais semestres**, sabendo que o mesmo professor pode dar a mesma disciplina em semestres diferentes, e que dois professores podem dividir a mesma disciplina no mesmo semestre. Escreva o esquema, sublinhe a chave e prove que ela é mínima. *Confira assim: teste a sua chave contra as duas frases do enunciado — ela precisa permitir as duas.*
5. **Desafio 🌶️ `ex05.md`** — o time decidiu que **toda** tabela do sistema terá uma coluna `id` artificial, sem exceção, "para padronizar". Escreva o argumento contrário: escolha **duas** tabelas em que a chave natural seria melhor e defenda cada uma com um caso concreto de uso — uma consulta, uma conferência com papel, uma importação de arquivo — que fica pior com a chave artificial. Depois, honestamente: descreva **um** caso em que a padronização do time está certa. *Confira assim: se você não conseguiu escrever o terceiro parágrafo, provavelmente não entendeu o argumento do outro lado.*

## 🧠 Revisão

[8 questões de múltipla escolha](revisao/README.md) para conferir se os conceitos ficaram sólidos. Responda sem consultar a aula — depois volte e corrija.

## ✅ Entrega

```bash
git add aula-02/
git commit -m "Resolve exercícios da aula 02 (chaves)"
git push
```

---

⬅️ [Aula 01](../aula-01-da-planilha-a-tabela/README.md) | ➡️ [Aula 03 — Relacionamentos e chave estrangeira](../aula-03-relacionamentos-chave-estrangeira/README.md)
