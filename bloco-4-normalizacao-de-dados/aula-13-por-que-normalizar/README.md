# Aula 13 — Por que Normalizar

> 🎯 Objetivos: reconhecer a redundância que sobrevive a um modelo bem desenhado, dizer o que a normalização promete e situar as formas normais numa escada com começo e fim.
> 🎬 Slides da aula: [apresentacao-13-por-que-normalizar.pdf](apresentacao/apresentacao-13-por-que-normalizar.pdf)

## 1. A planilha volta, disfarçada de tabela

A secretaria de eventos entregou o controle de inscrições. É uma tabela de banco de dados, bem-comportada, com chave e tudo:

```
   INSCRICAO
   ┌────────┬───────────┬────────────┬─────────┬──────────────────┬──────┬──────────┐
   │ cod_ev │ matricula │ nome_aluno │ curso   │ titulo_evento    │ c.h. │ sala     │
   ├────────┼───────────┼────────────┼─────────┼──────────────────┼──────┼──────────┤
   │  101   │  2023101  │ Ana Souza  │ ADS     │ Pesquisa em base │  4   │ S-204    │
   │  101   │  2023102  │ Bruno Lima │ ADS     │ Pesquisa em base │  4   │ S-204    │
   │  102   │  2023101  │ Ana Souza  │ ADS     │ Normas ABNT      │  2   │ S-101    │
   │  103   │  2023101  │ Ana Sousa  │ ADS     │ Escrita técnica  │  3   │ S-204    │
   └────────┴───────────┴────────────┴─────────┴──────────────────┴──────┴──────────┘
```

Você já viu esse filme na Aula 01, e o desfecho é o mesmo: **"Ana Sousa"** na última linha, e a base passa a afirmar duas coisas sobre a matrícula 2023101.

A diferença é que agora você sabe nomear o que está acontecendo, e as três anomalias voltam com nome e sobrenome:

- **Alteração:** o título do evento 101 mudou? Duas linhas para corrigir, e nada garante que as duas mudem;
- **Inserção:** um evento novo, ainda sem inscritos, **não cabe** — não há linha sem aluno;
- **Exclusão:** cancelou a última inscrição do evento 102? Some o evento junto.

**Como um curso inteiro de modelagem termina numa tabela dessas?** Três caminhos, e nenhum deles é burrice:

- **A pressa.** *"É só para um relatório rápido"* — e o rápido fica cinco anos;
- **A tela.** Alguém quis ver tudo de uma vez e desenhou a tabela igual à tela do sistema. É o argumento do `ex03`, e ele tem uma resposta boa que não é desnormalizar;
- **A conversão não revisada.** A ferramenta da Aula 12 gerou o esquema, ninguém aplicou o checklist, e o que era um DER correto virou isto.

> ⚠️ **Isto pode acontecer com um DER bem-feito.** O modelo conceitual acerta as entidades e ainda assim alguém pode espremer tudo numa tabela só — por pressa, por "assim é mais fácil de consultar", ou porque a conversão automática da Aula 12 saiu assim e ninguém revisou. A normalização é a régua que **prova** que a tabela está errada, em vez de discutir gosto.

## 2. O que é normalização

**Normalização** é o processo de decompor esquemas de tabela em esquemas menores, eliminando a redundância que causa anomalia — **sem perder informação**.

Três palavras dessa frase carregam o peso:

- **Decompor** — a operação é sempre a mesma: uma tabela vira duas ou mais, ligadas por chave;
- **Redundância que causa anomalia** — não é toda repetição. A matrícula 2023101 aparecer em três linhas de inscrição é *referência*, e é assim que tem de ser (Aula 01). O que incomoda é o **nome da Ana** repetido junto;
- **Sem perder informação** — remontando as tabelas decompostas, você tem de obter exatamente as linhas de antes. Nem mais, nem menos.

E três coisas que ela **não** é:

- **Não é apagar dado.** Nenhuma informação sai do banco; ela muda de endereço;
- **Não é fazer tabelas pequenas por gosto.** Tabela pequena não é virtude — o critério é a anomalia, não a contagem de colunas;
- **Não é otimização.** Quem normaliza atrás de velocidade se decepciona: o ganho é de **consistência**. Velocidade é assunto do modelo físico, que este curso não cobre.

> 💡 A normalização não inventa conhecimento novo: ela **torna explícito** o que o minimundo já dizia. Quando você separa `ALUNO` de `INSCRICAO`, está afirmando que nome é característica do aluno, não da inscrição — a mesma coisa que o DER da Aula 06 já afirmava. Por isso um modelo conceitual bem-feito costuma nascer quase normalizado.

## 3. Os objetivos, e o preço

O que se ganha:

| Objetivo | O que isso significa na prática |
|---|---|
| **Eliminar anomalias** | inserir, alterar e apagar deixam de produzir contradição |
| **Guardar cada fato uma vez** | não existe "qual das duas cópias é a verdadeira" |
| **Tornar o esquema estável** | mudança de regra mexe numa tabela, não em cinco |
| **Deixar a estrutura explícita** | o esquema passa a documentar as dependências do mundo |

E o preço, que é real e precisa ser dito:

- **Mais tabelas.** O que era uma vira quatro ou cinco;
- **Para montar a visão completa, é preciso juntar tabelas de novo.** A informação continua toda lá, mas espalhada;
- **Mais trabalho de projeto.** Decompor exige entender as dependências, e isso leva tempo.

> ⚠️ **O preço é pago uma vez; a anomalia cobra para sempre.** Juntar tabelas é trabalho previsível, que o SGBD faz bem. Descobrir qual das duas grafias do nome é a certa, dois anos depois, com trinta mil linhas, é trabalho imprevisível — e às vezes impossível.

## 4. O panorama: a escada das formas normais

**Forma normal** é um selo: um conjunto de condições que um esquema atende ou não atende. Elas são **cumulativas** — para estar na 3FN, o esquema precisa já estar na 2FN, e assim por diante.

```
   1FN  ──▶  2FN  ──▶  3FN  ──▶  BCNF  ──▶  4FN  ──▶  5FN
    │         │         │         │          │
    │         │         │         │          └─ duas listas independentes
    │         │         │         └─ refinamento da 3FN (fora deste curso)
    │         │         └─ atributo que depende de outro não-chave
    │         └─ atributo que depende de parte da chave
    └─ valor que não é atômico
```

Uma linha para cada uma, e é o mapa do bloco inteiro:

| Forma | Proíbe | Aula |
|---|---|:---:|
| **1FN** | valor não atômico: lista dentro da célula, grupo repetido | 14 |
| **2FN** | atributo que depende de **parte** da chave composta | 14 e 15 |
| **3FN** | atributo que depende de **outro atributo não-chave** | 15 e 16 |
| **BCNF** | um caso raro que a 3FN deixa passar | fora do curso |
| **4FN** | duas dependências multivaloradas **independentes** na mesma tabela | 16 |
| **5FN** | um caso ainda mais raro, de decomposição em três ou mais | fora do curso |

> 💡 Na prática do dia a dia, **a 3FN resolve a quase totalidade dos casos**. A 4FN aparece de vez em quando; BCNF e 5FN são assunto de quem projeta banco por profissão. É por isso que este curso vai até a 4FN e nomeia as outras duas sem entrar nelas.

## 5. Os três sintomas que se veem a olho nu

Antes de qualquer análise formal, três coisas denunciam uma tabela que vai dar trabalho. Você as reconhece olhando a tela por dez segundos:

```
   1. CÉLULA COM LISTA          "Marta Dias; Carlos Reis" numa coluna só
                                → é a 1FN, e é a mais fácil de ver

   2. BLOCO QUE SE REPETE       o mesmo trio (título, carga, sala) idêntico
                                em várias linhas
                                → é a 2FN ou a 3FN, e a chave decide qual

   3. COLUNA VAZIA EM MASSA     metade da tabela com traço na mesma coluna
                                → costuma ser especialização mal resolvida
                                  (Aula 11), não forma normal
```

O terceiro sintoma é o mais interessante, porque **a cura não é normalizar**: coluna preenchida só para um subgrupo é a tabela `USUARIO` da Aula 11, pedindo subclasses. Reconhecer isso poupa uma decomposição que não resolveria nada.

> 💡 Os sintomas servem para **começar a conversa**, não para concluir. Depois de vê-los, o trabalho é o das próximas três aulas: escrever as dependências e decidir com regra, não com impressão.

## 6. Até onde normalizar

A pergunta não é *"qual é a forma normal mais alta?"* — é *"que anomalia ainda existe?"*.

**Normalizar não é esporte.** O objetivo é eliminar redundância que causa contradição, não atingir o número mais alto. Um esquema em 3FN, com as anomalias resolvidas, está pronto.

E há um caso legítimo de andar para trás: a **desnormalização** da Aula 04 — repetir dado de propósito num banco analítico, onde ninguém altera e a leitura pesada compensa. Ela é decisão consciente, com três exigências:

1. **Medida** — só depois de existir um problema de desempenho de verdade;
2. **Escrita** — o motivo registrado, como qualquer decisão da Aula 09;
3. **Com dono** — alguém responsável por manter as cópias em dia.

O banco de eventos da secretaria é OLTP: registra inscrição enquanto o aluno espera, e é o lugar onde a contradição custa caro. Já o painel que a diretoria pede uma vez por mês — quantos alunos por curso e por período do ano, nos últimos cinco anos — é OLAP, e ali repetir o nome do curso em cada linha é escolha razoável. **A mesma instituição, duas respostas diferentes**, porque as cargas são diferentes.

> ⚠️ **Sem as três, desnormalizar é só o erro da Aula 01 com nome bonito.** A diferença entre "otimização" e "descuido" não está no esquema resultante — os dois são idênticos. Está no que foi decidido antes.

## 7. O caminho das próximas três aulas

```
   AULA 14   a ferramenta: dependência funcional
             + 1FN (valor atômico) e a definição da 2FN

   AULA 15   a prática: 1FN → 2FN passo a passo no caso de eventos
             + a definição da 3FN

   AULA 16   3FN aplicada, a 4FN, e o fechamento do curso
```

O caso de eventos atravessa as três, sempre o mesmo, crescendo — como a Biblioteca atravessou os Blocos 1 a 3. Ao fim da Aula 16 ele estará em 4FN, e o esquema final terá saído de uma tabela só.

Uma observação de método que vale para as três: **normalização se faz sobre o esquema e as regras do minimundo, nunca olhando os dados de exemplo**. Quatro linhas de uma tabela nunca provam que uma dependência existe — elas só podem mostrar que ela **não** existe. Quem decide é o mundo, e o mundo você descobre perguntando, como na Aula 04.

## 🏋️ Exercícios da aula

Na pasta `aula-13/` do seu repositório:

1. **`ex01.md`** — na tabela `INSCRICAO` da seção 1, aponte **todos os grupos de dado redundante** (diga quais colunas andam juntas e por quê) e escreva **uma linha para cada uma das três anomalias**, com um exemplo concreto usando os códigos e as matrículas da tabela. *Confere assim: são dois grupos de colunas redundantes, um vindo do aluno e outro do evento — e a anomalia de inserção precisa citar um caso que **não cabe** na tabela, não um caso que dá trabalho.*

2. **`ex02.md`** — para cada afirmação, diga se é **verdadeira ou falsa** e justifique em uma linha: (a) toda repetição de valor numa tabela é redundância; (b) um esquema em 3FN está necessariamente em 2FN; (c) normalizar sempre melhora o desempenho do banco; (d) desnormalizar é sempre um erro; (e) a normalização pode ser feita olhando apenas os dados já cadastrados. *Confere assim: são duas verdadeiras e três falsas — e a (e) é a que mais gente erra, porque parece razoável.*

3. **`ex03.md`** — a secretaria quer manter a tabela como está, e argumenta: *"assim a gente vê tudo numa tela só, sem precisar juntar nada"*. Escreva a resposta que você daria, em no máximo **oito linhas**, contendo: o que você concorda no argumento dela, qual problema concreto a tabela vai causar (com um exemplo da própria secretaria) e o que você propõe. *Confere assim: se a sua resposta não tem nenhuma frase concordando com ela, você não respondeu ao argumento — e o argumento da tela única é legítimo, tem inclusive uma solução técnica que não exige desnormalizar.*

### 📤 Entrega

Estes exercícios são feitos em sala e vão para o **seu repositório** `exercicios-modelagem-dados`:

```bash
cd ..                 # da pasta da aula para a raiz do repositório
git add aula-13/
git commit -m "Resolve exercícios da aula 13"
git push
```

Confira no navegador que a pasta apareceu em `github.com/SEU-USUARIO/exercicios-modelagem-dados`.

## 🧠 Revisão

[8 questões de múltipla escolha](revisao/README.md) para conferir se os conceitos ficaram sólidos. Responda sem consultar a aula — depois volte e corrija.

---

⬅️ [Aula 12 — Ferramentas CASE na Prática](../../bloco-3-abordagem-entidade-relacionamento/aula-12-ferramentas-case-na-pratica/README.md) | ➡️ [Aula 14 — Dependência Funcional, 1FN e 2FN](../aula-14-dependencia-funcional-1fn-2fn/README.md)
