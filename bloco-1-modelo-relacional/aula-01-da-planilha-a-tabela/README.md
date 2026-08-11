# Aula 01 — Da Planilha à Tabela

> 🎯 Objetivos: reconhecer as três anomalias que uma planilha única produz, nomear as partes de uma tabela com o vocabulário do modelo relacional e escrever o esquema de uma relação.
> 🎬 Slides da aula: [apresentacao-01-da-planilha-a-tabela.pdf](apresentacao/apresentacao-01-da-planilha-a-tabela.pdf)

## 1. A planilha que não aguenta mais

A biblioteca da faculdade controla os empréstimos numa planilha. Uma linha por empréstimo, e todo mundo entende:

```
┌──────────┬───────────┬────────────┬───────┬──────────────────────┬────────────┐
│ n_emprest│ matricula │ nome_aluno │ tombo │ titulo_livro         │ retirada   │
├──────────┼───────────┼────────────┼───────┼──────────────────────┼────────────┤
│   1001   │  2023101  │ Ana Souza  │ 4417  │ Banco de Dados       │ 2026-03-02 │
│   1002   │  2023101  │ Ana Souza  │ 4418  │ Engenharia de Soft.  │ 2026-03-02 │
│   1003   │  2023102  │ Bruno Lima │ 4417  │ Banco de Dados       │ 2026-03-09 │
│   1004   │  2023101  │ Ana Sousa  │ 4420  │ Redes de Computadores│ 2026-03-11 │
└──────────┴───────────┴────────────┴───────┴──────────────────────┴────────────┘
```

Funciona — até a linha 1004, onde alguém digitou **Ana Sousa** com S. Agora a planilha afirma duas coisas diferentes sobre a mesma matrícula, e nenhum programa do mundo sabe qual delas é a verdade.

O erro de digitação não é o problema. O problema é que **o nome da Ana está escrito três vezes**. Todo dado repetido é uma oportunidade de discordar de si mesmo, e alguém sempre aproveita.

> 💡 Conte quantas vezes "Banco de Dados" aparece nessas quatro linhas. Agora imagine mil empréstimos — e imagine que o título foi cadastrado errado desde o começo.

## 2. As três anomalias

Repetir dado não é só desperdiçar espaço. A repetição produz três problemas com nome próprio, e você vai reencontrar os três na Aula 07, quando eles ganharem uma cura com regra escrita.

**Anomalia de alteração.** A Ana mudou de nome. Quantas linhas você precisa alterar? Todas as dela. Se esquecer uma, a planilha passa a ter duas Anas — que é exatamente o estado em que ela já está.

**Anomalia de inserção.** Chegou um livro novo, ainda não emprestado por ninguém. Onde você guarda o título dele? Não há linha para isso: a planilha só sabe falar de empréstimos. Para cadastrar o livro, você teria que inventar um empréstimo falso.

**Anomalia de exclusão.** O empréstimo 1004 foi cancelado e você apaga a linha. Junto com ela some a única menção ao livro 4420. O livro continua na prateleira; o registro dele, não.

> ⚠️ Repare no padrão: os três problemas têm a mesma causa. **A planilha guarda coisas de naturezas diferentes na mesma linha.** Aluno, livro e empréstimo são três assuntos, amontoados em um.

## 3. Uma tabela por assunto

A saída é separar. Cada assunto ganha a sua tabela, e elas se ligam por um valor que aparece nas duas:

```
   ALUNO                              LIVRO
   ┌───────────┬────────────┐         ┌───────┬───────────────────────┐
   │ matricula │ nome       │         │ tombo │ titulo                │
   ├───────────┼────────────┤         ├───────┼───────────────────────┤
   │  2023101  │ Ana Souza  │         │ 4417  │ Banco de Dados        │
   │  2023102  │ Bruno Lima │         │ 4418  │ Engenharia de Software│
   └───────────┴────────────┘         │ 4420  │ Redes de Computadores │
                                      └───────┴───────────────────────┘
   EMPRESTIMO
   ┌───────────┬───────────┬───────┬────────────┐
   │ n_emprest │ matricula │ tombo │ retirada   │
   ├───────────┼───────────┼───────┼────────────┤
   │   1001    │  2023101  │ 4417  │ 2026-03-02 │
   │   1002    │  2023101  │ 4418  │ 2026-03-02 │
   │   1003    │  2023102  │ 4417  │ 2026-03-09 │
   │   1004    │  2023101  │ 4420  │ 2026-03-11 │
   └───────────┴───────────┴───────┴────────────┘
```

Confira o que mudou, anomalia por anomalia:

- O nome da Ana está escrito **uma vez**. Corrigir "Sousa" para "Souza" é uma alteração, em um lugar;
- O livro 4420 **existe mesmo sem empréstimo** — ele tem linha própria;
- Apagar o empréstimo 1004 não apaga mais nada além do empréstimo.

Repare que `matricula` e `tombo` continuam aparecendo em `EMPRESTIMO` — mas agora como **referência**: um valor que aponta para uma linha de outra tabela. É assim que o modelo relacional liga coisas, e é o assunto inteiro da Aula 03.

## 4. O vocabulário do modelo relacional

O que você acabou de desenhar tem nome, e o nome vem de longe. O **modelo relacional** foi proposto por E. F. Codd em 1970, e tem uma virtude que explica o domínio dele até hoje: **uma única estrutura de dados**. Não há listas, árvores nem ponteiros — há tabelas, e só.

```
                      ATRIBUTOS (colunas)
                ┌───────────┬─────────────┬────────┐
                │ matricula │    nome     │ curso  │
                ├───────────┼─────────────┼────────┤
     TUPLAS ──► │  2023101  │ Ana Souza   │  ADS   │
    (linhas)    │  2023102  │ Bruno Lima  │  ADS   │
                │  2024007  │ Célia Reis  │  ADM   │
                └───────────┴─────────────┴────────┘
                     RELAÇÃO  ALUNO
```

| Termo formal | Como se fala no trabalho | O que é |
|---|---|---|
| **Relação** | Tabela | O conjunto inteiro de linhas com o mesmo formato |
| **Tupla** | Linha, registro | Uma ocorrência — um aluno, um empréstimo |
| **Atributo** | Coluna, campo | Uma propriedade da coisa |
| **Domínio** | Tipo de dado | O conjunto de valores que aquela coluna aceita |

> 💡 As duas colunas valem. Os termos formais aparecem em livro, em documentação e em prova; os informais, em toda conversa de equipe. Saiba traduzir nos dois sentidos e você conversa com os dois mundos.

Formalmente, uma relação é um **conjunto** — e disso vêm duas consequências que surpreendem quem pensa em planilha:

> ⚠️ **Não existem duas tuplas iguais.** Toda linha difere de todas as outras em pelo menos um atributo. Numa planilha você copia e cola a mesma linha duas vezes sem que nada reclame; numa relação, isso não é permitido.

> ⚠️ **A ordem das tuplas não significa nada.** Não existe "primeira linha" nem "última linha" de uma tabela. Quando você precisar de ordem, ela é pedida na hora da consulta — é o que faz o `ORDER BY` da Aula 14 existir.

## 5. Grau e cardinalidade: as duas contagens

Duas perguntas diferentes, dois números diferentes:

- **Grau** é o número de **atributos**. A relação `ALUNO` acima tem grau 3. É uma característica do formato: só muda se alguém alterar o desenho da tabela;
- **Cardinalidade** é o número de **tuplas**. A relação `ALUNO` acima tem cardinalidade 3 — hoje. Amanhã, com uma matrícula nova, tem 4.

> ⚠️ **A palavra "cardinalidade" vai voltar na Aula 03 com outro sentido**: lá ela é a razão 1:1, 1:N ou N:M entre duas tabelas. São dois usos consagrados da mesma palavra, sem parentesco entre si. O contexto desfaz — mas vale saber que a armadilha existe.

## 6. Como se escreve um esquema

Nem sempre você vai desenhar a tabela. Para escrever depressa — num caderno, num e-mail, na resposta de um exercício — existe uma notação de uma linha: o **esquema da relação**.

```
ALUNO(matricula, nome, curso)
      ‾‾‾‾‾‾‾‾‾
```

O nome da relação, os atributos entre parênteses, e um sublinhado no atributo que identifica a linha. O modelo inteiro da seção 3 cabe em três linhas:

```
ALUNO(matricula, nome)
      ‾‾‾‾‾‾‾‾‾
LIVRO(tombo, titulo)
      ‾‾‾‾‾
EMPRESTIMO(n_emprest, matricula, tombo, retirada)
           ‾‾‾‾‾‾‾‾‾
```

Isto é um **esquema**: o desenho, o formato, o que não muda de um dia para o outro. As linhas que estão lá dentro num momento qualquer são a **instância**. O esquema você projeta uma vez; a instância muda o tempo todo, e não é assunto seu.

> 💡 Escrever o esquema é o gesto mais barato do curso e o que mais economiza discussão. Antes de desenhar qualquer diagrama, escreva as relações em uma linha cada e leia em voz alta.

## 🏋️ Exercícios da aula

Na pasta `aula-01/` do seu repositório:

1. **`ex01.md`** — encontre uma planilha real (a sua, a de alguém, ou uma que você invente com fidelidade: controle de gastos, escala de plantão, lista de contatos). Cole ou descreva a estrutura dela e responda: **qual dado está escrito mais de uma vez?** Liste todos. *Confira assim: se você não achou nenhum, a planilha ou é muito pequena ou tem só um assunto — procure outra.*
2. **`ex02.md`** — para cada situação abaixo, diga **qual das três anomalias** está acontecendo e por quê, em uma linha: (a) a editora mudou de nome e 340 linhas precisam ser alteradas; (b) não há onde cadastrar um curso que ainda não tem alunos matriculados; (c) o último aluno de uma turma trancou a matrícula e a turma sumiu do sistema; (d) o telefone do fornecedor aparece diferente em duas notas fiscais. *Confira assim: cada letra tem exatamente uma resposta, e as três anomalias aparecem — uma delas duas vezes.*
3. **`ex03.md`** — a planilha abaixo controla consultas de uma clínica. Separe-a em tabelas, uma por assunto, e desenhe as tabelas resultantes com pelo menos duas linhas cada:
   `n_consulta, data, hora, nome_paciente, cpf_paciente, telefone_paciente, nome_medico, crm_medico, especialidade_medico, valor`
   Depois escreva, em duas linhas, **qual anomalia cada tabela nova resolveu**. *Confira assim: nenhum dado pode aparecer em duas tabelas, exceto os que servem de referência entre elas.*
4. **`ex04.md`** — para as tabelas que você criou no `ex03`, escreva o **esquema** de cada uma na notação de uma linha, com o identificador sublinhado, e informe o **grau** e a **cardinalidade** de cada uma. Em seguida responda: qual dos dois números muda quando a clínica atende mais um paciente? E qual muda se alguém decidir guardar também o convênio do paciente? *Confira assim: os dois números respondem a perguntas diferentes, e cada evento mexe em exatamente um deles.*
5. **Desafio 🌶️ `ex05.md`** — separar em tabelas resolve três problemas e cria um custo. Descreva uma situação real em que **a planilha única é a escolha certa** e o banco de dados seria exagero. Depois defenda a decisão contrária: descreva o momento exato em que essa mesma situação passa a exigir tabelas separadas. Sua resposta precisa dizer **o que aconteceu** para virar o jogo — "ficou grande" não é resposta. *Confira assim: leia a sua justificativa para alguém que não fez esta aula. Se a pessoa entender por que o jogo virou, está boa.*

## 🧠 Revisão

[8 questões de múltipla escolha](revisao/README.md) para conferir se os conceitos ficaram sólidos. Responda sem consultar a aula — depois volte e corrija.

## ✅ Entrega

```bash
git add aula-01/
git commit -m "Resolve exercícios da aula 01 (da planilha à tabela)"
git push
```

---

🏠 [Início do curso](../../README.md) | ➡️ [Aula 02 — Chaves: como identificar uma linha](../aula-02-chaves/README.md)
