---
marp: true
theme: trilha
paginate: true
lang: pt-BR
footer: '🗄️ Curso de Modelagem de Dados · Aula 11'
---

<!-- _class: capa -->

<div class="emoji">🌳</div>

# Especialização, Generalização e as Ferramentas

## Aula 11 · Bloco 3 — Abordagem Entidade-Relacionamento

<div class="meta">Metade da tabela é traço — e isso é um sintoma</div>

---

## 🎯 Nesta aula

1. A entidade que **não cabe em si mesma**
2. **Especialização** e **generalização**
3. As **duas perguntas** obrigatórias
4. Quando **não** especializar
5. O mesmo modelo em Chen e em UML
6. O que é uma **ferramenta CASE**

---

## O cadastro que virou colcha de retalhos

```
   USUARIO
   ┌───────────┬────────────┬────────┬─────────┬──────────────┬─────────┐
   │ matricula │ nome       │ curso  │ periodo │ departamento │ turno   │
   ├───────────┼────────────┼────────┼─────────┼──────────────┼─────────┤
   │  2023101  │ Ana Souza  │ ADS    │    3    │      —       │    —    │
   │  1099     │ Carlos Reis│   —    │    —    │ Computação   │    —    │
   │  7712     │ Marta Dias │   —    │    —    │      —       │ noturno │
   └───────────┴────────────┴────────┴─────────┴──────────────┴─────────┘
```

Metade é traço. E nada impede preencher `curso` **e** `departamento` na mesma linha.

---

## Especialização e generalização

**Especialização** — de `USUARIO` saem `ALUNO`, `PROFESSOR`, `FUNCIONARIO`.
De cima para baixo.

**Generalização** — você já tem os três e cria `USUARIO` com o que é comum.
De baixo para cima.

> 💡 O **desenho resultante é o mesmo**. O que muda é por onde você chegou nele.

---

## Como se desenha em Chen

```
                    ┌───────────┐
                    │  USUARIO  │   (matricula, nome, email)
                    └─────╥─────┘
                          ║           ═══ linha dupla: TOTAL
                        ( d )         ( d ) disjunta
              ┌───────────┼───────────┐  ( o ) sobreposta
        ┌─────┴─────┐ ┌───┴───┐ ┌─────┴───────┐
        │   ALUNO   │ │ PROF  │ │ FUNCIONARIO │
        └───────────┘ └───────┘ └─────────────┘
```

Os atributos comuns aparecem **uma vez só**, na superclasse.

---

## As duas perguntas obrigatórias

**Toda ocorrência da superclasse está em alguma subclasse?**
→ **total** (sim) ou **parcial** (não)

**Uma ocorrência pode estar em mais de uma subclasse?**
→ **disjunta** (não) ou **sobreposta** (sim)

|  | Disjunta | Sobreposta |
|---|---|---|
| **Total** | exatamente um dos três | pelo menos um dos três |
| **Parcial** | nenhum, ou só um | nenhum, ou vários |

---

<!-- _class: lead -->

## ⚠️ Diagrama que não diz qual das quatro é está incompleto

É essa classificação que decide
se a coluna aceita vazio e se o sistema
pode recusar o segundo cadastro.

O professor que faz mestrado
derruba a especialização "disjunta".

---

## Quando **não** especializar: três testes

**Atributo próprio** — `CLIENTE_ATIVO` e `CLIENTE_INATIVO`, cuja única diferença é estar ativo, são um **atributo** `situacao`.

**Tempo** — *"isso pode mudar durante a vida do registro?"* Se pode, é **papel**, não tipo. `ALUNO` e `EX_ALUNO` quebram no dia da formatura.

**Tamanho** — uma subclasse com um atributo próprio só raramente paga o custo de existir.

---

## O mesmo modelo, em UML

```
   ┌────────────┐              O empréstimo se liga à SUPERCLASSE:
   │  Usuario   │◁──┬── Aluno      qualquer usuário pega livro.
   └─────┬──────┘   │
         │ 1        └── Professor  Só o professor propõe evento.
         │ 0..*
   ┌─────┴──────┐
   │ Emprestimo │   A UML não tem símbolo para disjunta ou total:
   └────────────┘   escreve-se {disjoint, complete} ao lado.
```

Mais uma informação que só sobrevive **se alguém escrever**.

---

## E como isso vira tabela?

| Estratégia | O esquema fica | Boa quando |
|---|---|---|
| **Uma tabela só** | `USUARIO(…, tipo, curso, departamento)` | poucos atributos próprios |
| **Uma por subclasse** | `ALUNO(…)` e `PROFESSOR(…)` | total e disjunta |
| **Super + subclasses** | `USUARIO(…)` + `ALUNO(matricula → USUARIO, …)` | o caso geral |

A terceira é a única que funciona bem com **parcial ou sobreposta**.

---

## O que é uma ferramenta CASE

*Computer-Aided Software Engineering.* Ela **faz**:

- desenha e mantém o diagrama; **verifica consistência**;
- **converte** o conceitual em lógico; gera o esquema físico.

E **não faz**: decidir se `SITUACAO` é entidade, conversar com o cliente, revisar a própria conversão.

> ⚠️ Ferramenta boa **acelera quem sabe modelar e esconde o erro de quem não sabe**.

---

<!-- _class: checkpoint -->

## 🏋️ Exercícios da aula

Na pasta `aula-11/`:

1. **`ex01.md`** — quatro especializações: justificam-se? aplique um dos três testes;
2. **`ex02.md`** — classifique três casos nos dois eixos, justificando cada eixo;
3. **`ex03.md`** — desenhe `EVENTO` → `OFICINA`/`PALESTRA` em Chen e em UML.

---

<!-- _class: lead -->

## ➡️ Próxima aula

**Aula 12 — Ferramentas CASE na prática**

A ferramenta faz o desenho em minutos
e a conversão em um clique.
O trabalho é **decidir**.
