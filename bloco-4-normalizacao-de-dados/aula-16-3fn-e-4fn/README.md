# Aula 16 — 3FN e 4FN

> 🎯 Objetivos: aplicar a 3FN ao esquema em 2FN, reconhecer o produto cartesiano acidental que a 4FN resolve e fechar o curso sabendo o que ficou de fora.
> 🎬 Slides da aula: [apresentacao-16-3fn-e-4fn.pdf](apresentacao/apresentacao-16-3fn-e-4fn.pdf)

## 1. Aplicando a 3FN

A Aula 15 parou com a `EVENTO` assim, em 2FN e ainda incomodando:

```
   EVENTO(cod_ev, titulo_evento, carga_horaria, sala, capacidade_sala)

   cod_ev → sala            e        sala → capacidade_sala
```

O procedimento é o mesmo da 2FN, trocando "parte da chave" por "atributo não-chave":

```
   PARA CADA atributo não-chave que determina outro:
       1. crie uma tabela nova
       2. o determinante vira a chave dela
       3. leve para lá tudo o que ele determina
       4. o determinante FICA na tabela original, como chave estrangeira
```

Resultado:

```
   EVENTO(cod_ev, titulo_evento, carga_horaria, sala → SALA)

   SALA(sala, capacidade_sala)
      S-204 | 40
      S-101 | 25
```

A capacidade da S-204 passou a existir em **um lugar só**. E a sala nova, ainda sem evento marcado, agora cabe no cadastro — a anomalia de inserção morreu junto.

O esquema completo, em 3FN:

```
   ALUNO(matricula, nome_aluno, curso)
   SALA(sala, capacidade_sala)
   EVENTO(cod_ev, titulo_evento, carga_horaria, sala → SALA)
   INSCRICAO(matricula → ALUNO, cod_ev → EVENTO, data_inscricao)
   PALESTRANTE_EVENTO(cod_ev → EVENTO, nome_palestrante)
```

> 💡 **Para 95% dos esquemas, acabou aqui.** A 3FN elimina as três anomalias da Aula 13 na quase totalidade dos casos reais, e é o alvo prático de qualquer projeto. O que vem a seguir trata de um problema mais raro — e que, quando aparece, é inconfundível.

## 2. Uma tabela que multiplica linhas sozinha

A secretaria quer registrar duas coisas sobre cada palestrante: **em que eventos ele fala** e **quais são as áreas de atuação dele**. Alguém pôs as duas na mesma tabela:

```
   PALESTRANTE_INFO
   ┌────────────────┬──────────┬──────────────────┐
   │ nome_palestr.  │ cod_ev   │ area             │
   ├────────────────┼──────────┼──────────────────┤
   │ Marta Dias     │   101    │ Metodologia      │
   │ Marta Dias     │   101    │ Redação técnica  │
   │ Marta Dias     │   102    │ Metodologia      │
   │ Marta Dias     │   102    │ Redação técnica  │
   └────────────────┴──────────┴──────────────────┘
```

Quatro linhas para dizer duas coisas: *a Marta fala nos eventos 101 e 102* e *a Marta atua em metodologia e redação técnica*. Dois eventos × duas áreas = **quatro linhas que ninguém escreveu de propósito**.

E o absurdo aparece na leitura: a terceira linha afirma que *"a Marta atua em metodologia no evento 102"* — uma frase que **não significa nada**, porque a área dela não tem relação com o evento. Se ela ganhar uma terceira área, é preciso inserir mais **duas** linhas para manter a tabela coerente. Esquecer uma delas produz uma base que afirma bobagem.

## 3. Dependência multivalorada

O nome do que está acontecendo: **dependência multivalorada**. Um atributo determina um **conjunto** de valores, e não um valor só.

```
   nome_palestrante ↠ cod_ev        "a Marta tem um conjunto de eventos"
   nome_palestrante ↠ area          "a Marta tem um conjunto de áreas"
```

O problema não é ter uma dessas. É ter **duas, independentes, na mesma tabela** — porque aí o banco é obrigado a guardar todas as combinações possíveis entre os dois conjuntos, e nenhuma dessas combinações carrega informação.

> ⚠️ **"Independentes" é a palavra que decide tudo.** Se a área dependesse do evento — *"nesta palestra a Marta falou de metodologia"* —, a tabela estaria certa e as quatro linhas significariam quatro fatos. O que torna a estrutura absurda é que os dois conjuntos **não se conhecem**.

## 4. A 4FN

Um esquema está na **quarta forma normal** quando:

1. está na **3FN**; e
2. **não há duas dependências multivaloradas independentes na mesma tabela**.

A transformação é a mais simples do bloco — **uma tabela para cada conjunto**:

```
   PALESTRANTE_EVENTO(nome_palestrante, cod_ev)
      Marta Dias | 101
      Marta Dias | 102

   PALESTRANTE_AREA(nome_palestrante, area)
      Marta Dias | Metodologia
      Marta Dias | Redação técnica
```

Quatro linhas viraram quatro linhas — mas agora **cada uma afirma um fato**, e a terceira área custa **uma** linha, não duas. A conferência da Aula 15 continua valendo: separou por `nome_palestrante`, que está nas duas tabelas; remontando, você recupera as combinações originais sem inventar nenhuma.

> ⚠️ **Não dispare a 4FN ao ver um multivalorado.** Com **um** conjunto só, não há independência para separar, e a 1FN já resolveu — decompor ali produz uma tabela de coluna única e nenhum ganho. É o erro "aplicar a 4FN onde só existe uma dependência multivalorada", do catálogo. A 4FN precisa de **duas**.

## 5. O quadro completo

| Forma | Proíbe | Como se reconhece |
|---|---|---|
| **1FN** | valor não atômico | lista na célula, colunas numeradas |
| **2FN** | dependência parcial | atributo que depende de metade da chave composta |
| **3FN** | dependência transitiva | atributo não-chave determinando outro |
| **4FN** | duas multivaloradas independentes | linhas que se multiplicam sem significar nada |

E o roteiro de normalização inteiro, em cinco perguntas:

```
   1. Alguma célula guarda mais de um valor?          → 1FN
   2. A chave é composta? Algum atributo depende
      só de uma parte dela?                           → 2FN
   3. Algum atributo não-chave determina outro?       → 3FN
   4. Há duas listas independentes na mesma tabela?   → 4FN
   5. Cada decomposição é sem perda?                  → sempre
```

> 💡 **A pergunta 5 não é uma etapa: é a que se faz depois de cada uma das outras.** Decompor errado é o único jeito de piorar um esquema normalizando — e o teste custa dez segundos.

## 6. O que você aprendeu, e o que ficou de fora

```
   BLOCO 1   por que um banco existe: redundância, anomalias, SGBD,
             requisitos, OLTP e OLAP

   BLOCO 2   do minimundo ao esquema: os três modelos, a notação de
             Chen, chaves, integridade, agregação

   BLOCO 3   como se conduz: estratégias, documentação, UML,
             especialização, ferramentas CASE

   BLOCO 4   normalização: dependência funcional, 1FN, 2FN, 3FN, 4FN
```

**O que ficou deliberadamente de fora, e por onde continuar:**

| Assunto | Por que ficou fora | Onde continuar |
|---|---|---|
| **SQL** — criar tabelas, consultar, alterar | é uma linguagem, e exige um curso próprio | qualquer curso de SQL: você já sabe **o que** pedir |
| **Álgebra relacional** | a base formal das consultas | Date, capítulo de álgebra |
| **BCNF e 5FN** | casos raros, com prova formal | Elmasri & Navathe, capítulo de normalização |
| **Projeto físico** — índices, desempenho | depende do SGBD e de carga real | Silberschatz, parte de armazenamento |
| **Relacionamento ternário** | quase sempre é agregação disfarçada | Heuser, construções avançadas |

> 💡 **O que você leva daqui não é uma notação.** Notação se aprende em uma tarde e muda com a ferramenta. O que fica é o hábito de perguntar *"quantos?"*, *"pode zero?"*, *"se isto mudar, quantos lugares eu altero?"* — e o de **escrever a justificativa** ao lado do desenho. Modelo sem argumento é chute bem desenhado, e é a primeira coisa que cai na primeira pergunta do cliente.

> 💻 **Modelos desta aula:** [`quadro-formas-normais.md`](exemplos/quadro-formas-normais.md) — o quadro e o roteiro numa página só, para consultar em qualquer projeto.

## 🏋️ Exercícios da aula

Na pasta `aula-16/` do seu repositório:

1. **`ex01.md`** — leve à **3FN** o esquema `EMPRESTIMO(numero, data_retirada, matricula, nome_aluno, cod_curso, nome_curso, coord_curso)`, com chave `numero`. Mostre as dependências, diga qual é transitiva e entregue o esquema final. *Confere assim: a chave tem uma coluna só, então nenhum passo seu pode citar a 2FN — e saem três tabelas, com uma cadeia de duas dependências transitivas encadeadas.*

2. **`ex02.md`** — para cada tabela, diga se ela **precisa da 4FN** e justifique: (a) `ALUNO_TELEFONE(matricula, telefone)`; (b) `PROFESSOR_INFO(matricula, oficina_ministrada, idioma_falado)`; (c) `EXEMPLAR_EMPRESTIMO(isbn, numero_ex, num_emprestimo)`; (d) `EVENTO_RECURSO(cod_ev, equipamento, dia_da_semana)`, sabendo que o evento se repete em vários dias e usa vários equipamentos, independentemente do dia. *Confere assim: duas precisam e duas não — e nas que não precisam, ou só há **um** conjunto, ou os dois valores estão relacionados entre si.*

3. **`ex03.md`** — **exercício autoral.** Escolha um minimundo do [catálogo](../../recursos/minimundos.md) que você **ainda não usou** e entregue: (i) uma tabela única e desnormalizada que represente o minimundo, com ao menos **oito colunas** e um problema de cada tipo — não atômico, parcial e transitivo; (ii) a normalização até a **3FN**, passo a passo, no formato da Aula 15; (iii) a **conferência** de cada decomposição; (iv) um parágrafo dizendo se o esquema final coincide com o DER que você desenharia para o mesmo minimundo — e, se não coincidir, qual dos dois você revisaria. *Confere assim: o item (iv) é o que mais ensina. Se os dois caminhos deram esquemas diferentes, um deles tem um erro, e encontrá-lo vale mais que o exercício inteiro.*

### 📤 Entrega

Estes exercícios são feitos em sala e vão para o **seu repositório** `exercicios-modelagem-dados`:

```bash
cd ..                 # da pasta da aula para a raiz do repositório
git add aula-16/
git commit -m "Resolve exercícios da aula 16"
git push
```

Confira no navegador que a pasta apareceu em `github.com/SEU-USUARIO/exercicios-modelagem-dados`.

## 🧠 Revisão

[8 questões de múltipla escolha](revisao/README.md) para conferir se os conceitos ficaram sólidos. Responda sem consultar a aula — depois volte e corrija.

---

⬅️ [Aula 15 — Aplicando a 1FN e a 2FN](../aula-15-aplicando-1fn-e-2fn/README.md) | 🏠 [Início](../../README.md)
