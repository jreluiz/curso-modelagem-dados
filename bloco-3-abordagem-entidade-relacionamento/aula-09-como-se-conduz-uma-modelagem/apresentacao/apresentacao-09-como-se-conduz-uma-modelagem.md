---
marp: true
theme: trilha
paginate: true
lang: pt-BR
footer: '🗄️ Curso de Modelagem de Dados · Aula 09'
---

<!-- _class: capa -->

<div class="emoji">🗺️</div>

# Como se Conduz uma Modelagem

## Aula 09 · Bloco 3 — Abordagem Entidade-Relacionamento

<div class="meta">Trinta frases, dezoito substantivos, uma folha em branco</div>

---

## 🎯 Nesta aula

1. A **folha em branco**
2. As **quatro estratégias** de modelagem
3. O mesmo modelo em **dois níveis**
4. A **documentação**: dicionário, regras, decisões
5. O **roteiro** de uma sessão de modelagem

---

## Por onde se começa?

A biblioteca pede o sistema de **eventos**. A entrevista rendeu trinta frases e esta lista:

```
   OFICINA · PALESTRA · INSCRIÇÃO · CERTIFICADO · SALA · PALESTRANTE ·
   ALUNO · PROFESSOR · VAGA · LISTA DE ESPERA · CRACHÁ · MATERIAL ·
   CARGA HORÁRIA · PERÍODO · AVALIAÇÃO · PATROCÍNIO · COFFEE · FOTO
```

Quem tenta desenhar os dezoito de uma vez **trava na terceira caixa**.

---

<!-- _class: tabela-densa -->

## As quatro estratégias

| Estratégia | Como se conduz | O risco |
|---|---|---|
| **Top-down** | poucos conceitos amplos, depois refina | refinar de menos |
| **Bottom-up** | parte dos campos que já existem | copiar a bagunça antiga |
| **Inside-out** | uma entidade central, puxando vizinhos | perder o que está longe |
| **Mista** | divide, modela cada parte, integra | as partes não encaixarem |

---

## A inside-out, rodando

```
   PERGUNTA                          ENTRA NO DESENHO

   "O que é uma inscrição?"     →    INSCRICAO, no centro
   "Quem se inscreve?"          →    PESSOA
   "Em quê?"                    →    EVENTO
   "Quando?"                    →    data_inscricao — da ligação, não
                                     da pessoa nem do evento
   "O evento acontece onde?"    →    SALA
   "E o certificado?"           →    do par pessoa-evento: agregação
```

Nenhuma pergunta exigiu saber o modelo inteiro de antemão.

---

<!-- _class: lead -->

## ⚠️ Nenhuma das quatro é "a certa"

Elas se misturam na prática.

O nome importa para **você saber
o que está fazendo** — e para explicar
por que o modelo do colega começou diferente.

---

## O mesmo modelo em dois níveis

```
   ALTO NÍVEL — o que se leva ao cliente

     PESSOA ──N── INSCREVE_SE ──M── EVENTO ──N── OCORRE_EM ──1── SALA


   EXPANDIDA — o documento de trabalho

     + matricula, nome, data_inscricao, codigo, titulo,
       carga_horaria, cod_sala, participação, chaves
```

São **o mesmo modelo**. Nada foi decidido de novo entre um e outro.

---

<!-- _class: lead -->

## ⚠️ A ordem entre os dois não é livre

Alto nível **primeiro**, sempre.

Levar a versão expandida à primeira reunião
faz o cliente discutir o nome de um atributo
enquanto uma entidade inteira está faltando.

---

## O dicionário de dados

| Entidade | Atributo | Domínio | Obrig. | Descrição |
|---|---|---|:---:|---|
| `EVENTO` | `codigo` | inteiro | sim | identificador; é a chave |
| `EVENTO` | `titulo` | texto até 120 | sim | como aparece no cartaz |
| `EVENTO` | `carga_horaria` | 1 a 40 | sim | horas para o certificado |
| `INSCREVE_SE` | `data_inscricao` | data | sim | ordena a fila |

---

## O registro de decisões

```
   D-01  PESSOA é uma entidade só, não ALUNO e PROFESSOR separados.
         Alternativa descartada: duas entidades independentes.
         Por quê: os dois se inscrevem do mesmo jeito.
         Revisar se: aparecer regra que valha só para um deles.

   D-02  EVENTO tem participação total em OCORRE_EM.
         Alternativa descartada: evento sem sala definida.
         Por quê: o cliente confirmou que evento sem sala não é publicado.
```

---

<!-- _class: lead -->

## 💡 A decisão vale mais que o diagrama

O diagrama diz **o que** o modelo é.

A decisão diz **o que ele quase foi,
e por que não foi** — que é exatamente
a pergunta que alguém vai fazer.

---

## O roteiro de uma sessão

```
   1. ENTIDADES        candidatos + as três perguntas da Aula 03
   2. RELACIONAMENTOS  ligue, com verbo. Sem números ainda
   3. CARDINALIDADE    "quantos?" e "pode zero?", de cada lado
      E PARTICIPAÇÃO
   4. ATRIBUTOS        agora, e só agora. Chave primeiro
   5. LEITURA EM       cada linha, nas duas direções, em português
      VOZ ALTA
```

**Atributo por último** — quem começa por eles redesenha o formulário antigo.

---

<!-- _class: checkpoint -->

## 🏋️ Exercícios da aula

Na pasta `aula-09/`:

1. **`ex01.md`** — escolha a estratégia para quatro situações, justificando;
2. **`ex02.md`** — escreva a descrição em alto nível a partir da expandida;
3. **`ex03.md`** — dicionário, decisão `D-03` e o ponto do roteiro, para o palestrante externo.

---

<!-- _class: lead -->

## ➡️ Próxima aula

**Aula 10 — O mesmo caso em duas notações**

O mesmo modelo, escrito outra vez
em outra língua — e o que cada uma
assume sem dizer.
