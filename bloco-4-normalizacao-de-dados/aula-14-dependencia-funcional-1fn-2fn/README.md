# Aula 14 — Dependência Funcional, 1FN e 2FN

> 🎯 Objetivos: identificar dependências funcionais a partir das regras do minimundo, reconhecer o que viola a 1FN e enunciar a 2FN sabendo quando ela é automática.
> 🎬 Slides da aula: [apresentacao-14-dependencia-funcional-1fn-2fn.pdf](apresentacao/apresentacao-14-dependencia-funcional-1fn-2fn.pdf)

## 1. "Se eu sei isto, eu sei aquilo"

Volte à tabela de inscrições da Aula 13 e faça uma pergunta simples: **se eu souber a matrícula, o que mais eu sei?**

```
   matricula = 2023101   ──▶   nome_aluno = Ana Souza
                         ──▶   curso      = ADS
```

Sei o nome e o curso. E o contrário? Sabendo que o nome é "Ana Souza", eu sei a matrícula? Não — pode haver outra Ana Souza.

Essa relação de mão única é a peça central do bloco inteiro, e tem nome: **dependência funcional**.

## 2. A dependência funcional

Diz-se que **`X` determina `Y`** — escreve-se `X → Y` — quando, para **cada** valor de `X`, existe **um único** valor de `Y`.

```
   matricula → nome_aluno        "cada matrícula tem um nome só"
   matricula → curso             "cada matrícula tem um curso só"
   cod_ev    → titulo_evento     "cada evento tem um título só"
   cod_ev    → carga_horaria
   cod_ev    → sala
```

O lado esquerdo se chama **determinante**. Ele pode ter mais de um atributo: `(cod_ev, matricula) → data_inscricao` lê-se *"o par evento-aluno determina a data em que a inscrição foi feita"*.

**Como se descobre uma dependência funcional?** Perguntando ao minimundo — nunca olhando os dados:

| A pergunta que se faz | O que a resposta decide |
|---|---|
| *"Um aluno pode ter dois nomes diferentes?"* | se `matricula → nome_aluno` vale |
| *"Um evento pode acontecer em duas salas?"* | se `cod_ev → sala` vale |
| *"Um aluno pode se inscrever duas vezes no mesmo evento?"* | se o par é chave |

> ⚠️ **Dados de exemplo não provam dependência.** Se nas suas quatro linhas cada matrícula aparece com um nome só, isso **não** prova que `matricula → nome_aluno`: prova apenas que ainda não apareceu contraexemplo. Já o contrário funciona — uma única linha com a mesma matrícula e dois nomes **derruba** a dependência na hora. Dado desmente; quem confirma é o cliente.

Três coisas que **parecem** dependência funcional e não são:

| Não é DF | Por quê |
|---|---|
| `nome_aluno → matricula` | dois alunos podem ter o mesmo nome — a mão única vale só no sentido contrário |
| `cod_ev → nome_palestrante` | um evento tem **vários** palestrantes; DF exige **um** valor, não um conjunto |
| `carga_horaria → sala` | os dados podem até bater hoje por acaso; nada no mundo liga uma coisa à outra |

O terceiro caso é o mais perigoso, e é o motivo do aviso abaixo: **coincidência nos dados não é dependência**. Se todos os eventos de 4 horas por acaso ocorreram na S-204, a tabela "confirma" `carga_horaria → sala` — e a primeira exceção derruba tudo o que você construiu em cima disso.

> 💡 **A chave determina tudo.** Por definição, a chave primária determina funcionalmente todos os outros atributos da tabela — é isso que "identificar uma linha" significa. Toda a normalização consiste em perguntar se existe **alguém além dela** determinando alguma coisa: se existe, aquele atributo está na tabela errada.

> 📖 Dependência funcional é o conceito que abre o capítulo de normalização em qualquer livro da área — Heuser, Date e Elmasri & Navathe começam todos por ela, com notação idêntica.

## 3. As dependências da tabela de inscrições

Aplicando as perguntas ao caso da Aula 13, a secretaria confirmou:

```
   CHAVE:  (cod_ev, matricula)     um aluno se inscreve uma vez em cada evento

   DF-01   matricula → nome_aluno, curso
   DF-02   cod_ev    → titulo_evento, carga_horaria, sala
   DF-03   (cod_ev, matricula) → data_inscricao
```

Três linhas, e elas já contam a história inteira do bloco: **a DF-03 usa a chave toda; as DF-01 e DF-02 usam só um pedaço dela.** Guarde isso — é o assunto da seção 5.

> 💡 Escrever as dependências antes de decompor é o equivalente, na normalização, a escrever as regras numeradas antes de desenhar o DER. Sem essa lista, decompor vira palpite; com ela, cada tabela nova tem uma justificativa de uma linha.

## 4. A 1FN: cada célula guarda um valor

A **primeira forma normal** exige que **todo valor seja atômico** — indivisível para o propósito do banco. Nada de lista dentro da célula, nada de grupo repetido.

Três violações, e a mesma cura para as três:

```
   ❌ LISTA NA CÉLULA
   ┌───────────┬──────────────────────────┐
   │ matricula │ telefones                │
   │  2023101  │ 9999-1111, 9999-2222     │   ← dois valores numa célula
   └───────────┴──────────────────────────┘

   ❌ COLUNAS NUMERADAS
   ┌───────────┬────────────┬────────────┬────────────┐
   │ matricula │ telefone1  │ telefone2  │ telefone3  │
   └───────────┴────────────┴────────────┴────────────┘

   ✅ EM 1FN
   ┌───────────┬────────────┐
   │ matricula │ telefone   │      TELEFONE_ALUNO
   │  2023101  │ 9999-1111  │      chave: (matricula, telefone)
   │  2023101  │ 9999-2222  │
   └───────────┴────────────┘
```

> ⚠️ **`telefone1`, `telefone2`, `telefone3` não está em 1FN** — é o erro mais teimoso do catálogo. Ele parece resolver, porque cada célula tem um valor só, mas cria três problemas: quem tem quatro telefones não cabe, quem tem um desperdiça duas colunas, e procurar um número exige olhar em três lugares. **Atributo multivalorado vira entidade própria, com relacionamento 1:N.** Sempre.

Repare que isso não é novidade: é o atributo multivalorado da Aula 03, a elipse dupla, chegando ao modelo lógico. O DER já sabia; a 1FN é a regra que obriga a respeitar.

> 💡 "Atômico **para o seu propósito**" é a parte que se esquece. `endereco` numa única coluna está em 1FN se a biblioteca nunca precisa filtrar por cidade. Se precisa, aquele valor não é atômico para ela, e vira `rua`, `numero`, `cidade` — o atributo composto da Aula 03.

## 5. Dependência parcial

Com a tabela em 1FN e a chave sendo o par `(cod_ev, matricula)`, olhe de novo para a lista da seção 3:

```
   (cod_ev, matricula) → data_inscricao      ✅ depende da chave INTEIRA
    matricula          → nome_aluno          ⚠️ depende de METADE da chave
    cod_ev             → titulo_evento       ⚠️ depende da outra METADE
```

**Dependência parcial** é isso: um atributo que depende de **parte** da chave composta, e não dela toda.

É a causa direta das anomalias da Aula 13. O nome da Ana depende só da matrícula — então ele se repete em toda linha em que a matrícula aparece, e é aí que a segunda grafia entra.

> ⚠️ **Dependência parcial só existe com chave composta.** Se a chave tem uma coluna só, não há "parte" dela — não há como depender de metade de uma coisa indivisível.

## 6. A 2FN

Um esquema está na **segunda forma normal** quando:

1. está na **1FN**; e
2. **nenhum atributo não-chave depende de parte da chave** — ou seja, não há dependência parcial.

A tabela `INSCRICAO` da Aula 13 **não está em 2FN**: as DF-01 e DF-02 são parciais, e é por isso que ela repete nome de aluno e título de evento em cada linha.

E o corolário que economiza páginas de análise:

> ⚠️ **Toda tabela em 1FN com chave simples já está em 2FN**, sem fazer nada. A análise da 2FN só tem trabalho quando a chave é composta — e quem não olha a chave antes de começar gasta meia hora provando o óbvio. É o erro "aplicar a 2FN onde ela é automática", do catálogo.

Um segundo caso, para fixar o teste da chave. Na biblioteca:

```
   EMPRESTIMO_ITEM(num_emprestimo, isbn, numero_ex, titulo_livro)
      chave: (num_emprestimo, isbn, numero_ex)

   isbn → titulo_livro          ⚠️ o título depende de PARTE da chave
```

Não está em 2FN, e o sintoma aparece nos dados: o título do livro se repete em todo empréstimo daquela obra. Já `EMPRESTIMO(numero, data_retirada, matricula)`, com chave `numero`, está em 2FN sem que ninguém faça nada — chave de uma coluna, análise encerrada.

A transformação — como sair da 1FN e chegar à 2FN, tabela por tabela — é a próxima aula.

> 💻 **Modelos desta aula:** [`dependencias-inscricao.md`](exemplos/dependencias-inscricao.md) — a lista completa de dependências do caso, com a pergunta feita à secretaria em cada uma.

## 🏋️ Exercícios da aula

Na pasta `aula-14/` do seu repositório:

1. **`ex01.md`** — para cada par abaixo, diga se a dependência funcional **vale** no minimundo da biblioteca e escreva a **pergunta** que você faria à bibliotecária para confirmar: (a) `isbn → titulo`; (b) `titulo → isbn`; (c) `cod_sala → capacidade`; (d) `matricula → curso`; (e) `(isbn, numero_ex) → situacao`; (f) `situacao → isbn`. *Confere assim: duas das seis não valem — e uma delas não vale por um motivo que só aparece quando você pensa em duas obras diferentes com o mesmo nome.*

2. **`ex02.md`** — a tabela abaixo guarda os eventos e seus palestrantes. Diga se ela está em **1FN**, justificando, e reescreva o que for preciso:

   ```
   EVENTO(cod_ev, titulo, palestrantes, sala)
     101 | Pesquisa em base | Marta Dias; Carlos Reis | S-204
     102 | Normas ABNT      | Marta Dias             | S-101
   ```

   *Confere assim: a sua correção precisa produzir uma tabela nova, e a chave dela tem duas colunas. Se você criou `palestrante1` e `palestrante2`, releia o `> ⚠️` da seção 4.*

3. **`ex03.md`** — dada a tabela `EMPRESTIMO_DETALHE(matricula, isbn, data_retirada, nome_aluno, titulo_livro)`, com chave `(matricula, isbn)`: liste todas as **dependências funcionais** no formato da seção 3, marque quais são **parciais** e responda se a tabela está em **2FN**, justificando em duas linhas. *Confere assim: são quatro dependências, duas delas parciais — e a resposta sobre a 2FN não é "sim" nem "não" sem citar qual dependência decide.*

### 📤 Entrega

Estes exercícios são feitos em sala e vão para o **seu repositório** `exercicios-modelagem-dados`:

```bash
cd ..                 # da pasta da aula para a raiz do repositório
git add aula-14/
git commit -m "Resolve exercícios da aula 14"
git push
```

Confira no navegador que a pasta apareceu em `github.com/SEU-USUARIO/exercicios-modelagem-dados`.

## 🧠 Revisão

[8 questões de múltipla escolha](revisao/README.md) para conferir se os conceitos ficaram sólidos. Responda sem consultar a aula — depois volte e corrija.

---

⬅️ [Aula 13 — Por que Normalizar](../aula-13-por-que-normalizar/README.md) | ➡️ [Aula 15 — Aplicando a 1FN e a 2FN](../aula-15-aplicando-1fn-e-2fn/README.md)
