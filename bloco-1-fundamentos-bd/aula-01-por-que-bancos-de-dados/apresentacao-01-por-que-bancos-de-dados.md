---
marp: true
theme: trilha
paginate: true
lang: pt-BR
footer: '🗄️ Curso de Modelagem de Dados · Aula 01'
---

<!-- _class: capa -->

<div class="emoji">🗄️</div>

# Por Que Bancos de Dados Existem

## Aula 01 · Bloco 1 — Fundamentos

<div class="meta">A planilha que deu certo até dar errado</div>

---

## 🎯 Nesta aula

1. A planilha que funciona **até parar de funcionar**
2. Os **quatro pecados** do arquivo solto
3. O que um **SGBD** acrescenta
4. Quando **não** usar um SGBD
5. Quem é quem num banco de dados

---

## Toda organização começa igual

Alguém abre uma planilha para controlar os empréstimos:

| aluno | curso | telefone | livro |
|---|---|---|---|
| Ana Souza | Sistemas de Informação | 3399-1111 | Banco de Dados |
| Ana Souza | Sistemas de Informação | 3399-1111 | Algoritmos |
| Bruno Lima | Sistemas de Informacao | 3399-2222 | Banco de Dados |

Funciona. Funciona por meses.

---

<!-- _class: lead -->

## E então a Ana troca de telefone

Você tem **duas linhas** para atualizar.

Encontra uma.

Agora existem dois telefones diferentes
para a mesma pessoa —

e **nenhum critério** para saber qual é o certo.

---

<!-- _class: lista-limpa -->

## E os outros defeitos vieram de graça

- ❌ *"Sistemas de Informação"* e *"Sistemas de Informacao"* são **cursos diferentes** para o computador;
- ❌ *"Guimarães"* e *"C. Guimarães"* são **dois autores**;
- ❌ O mesmo ISBN aparece duas vezes, e nada impede que na terceira o título venha escrito diferente.

---

## Os quatro pecados do arquivo solto

**Redundância** — o mesmo dado em vários lugares. Hoje são duas linhas; no ano que vem, quinze.

**Inconsistência** — a consequência inevitável. Duas cópias só ficam iguais enquanto **todo mundo lembra** de atualizar as duas. Ninguém lembra sempre.

**Dependência programa–dado** — o programa sabe que o telefone é a quarta coluna. Insira uma coluna no meio e tudo quebra.

**Isolamento** — cada coisa numa planilha, em formatos diferentes. Cruzar vira trabalho manual.

---

<!-- _class: lead -->

## 💡 A raiz de tudo é uma só

O dado não tem **um lugar único** onde mora.

Guarde o telefone da Ana em exatamente
um lugar do mundo, e **três dos quatro pecados
desaparecem sozinhos**.

É por isso que a ferramenta se chama
**modelagem**, e não programação.

---

<!-- _class: tabela-densa -->

## O que um SGBD acrescenta

| Garantia | Na prática |
|---|---|
| **Controle de redundância** | cada dado tem um lugar |
| **Integridade** | o banco **recusa** empréstimo para aluno inexistente |
| **Concorrência** | dois atendentes, um exemplar: um consegue, o outro é recusado |
| **Segurança** | o atendente vê empréstimos, não vê salários |
| **Recuperação** | faltou luz no meio? Ao voltar, estado coerente |
| **Independência** | acrescentar coluna não quebra quem não a usa |

---

<!-- _class: lead -->

## ⚠️ Mas o SGBD **não conserta** um modelo ruim

Ele garante que as regras **que você declarou**
sejam cumpridas. E só isso.

Se você declarou que um empréstimo pode existir
sem exemplar, o banco vai defender essa bobagem
com todo o rigor.

**Qualidade do dado é decisão de projeto.**

---

## Atualização perdida, num exemplo

```
Atendente A                    Atendente B
──────────────────────────────────────────────
lê tombo 4417: LIVRE
                               lê tombo 4417: LIVRE
grava: EMPRESTADO para Ana
                               grava: EMPRESTADO para Bruno
──────────────────────────────────────────────
O exemplar está com a Ana. O sistema diz que está com o Bruno.
```

É a razão mais simples para **não** implementar seu próprio banco com arquivos.

---

<!-- _class: lista-limpa -->

## Quando **não** usar um SGBD

Boa engenharia é saber o custo. Não compensa quando:

- 📄 Os dados são **pequenos, estáveis e de um usuário só**;
- 📤 Você precisa **entregar o arquivo** para alguém abrir e mexer;
- 🗑️ O dado é **descartável** — log, cache, resultado intermediário;
- 📖 O acesso é **sequencial e completo**, sem consulta.

---

<!-- _class: lead -->

## 💡 A pergunta que decide

Os dados vão ser
**compartilhados**, **relacionados**
e **viver mais que o programa** que os criou?

Três sins → você precisa de um banco.

Três nãos → um arquivo resolve.

---

## Quem é quem

- **DBA** — cuida do servidor: instalação, desempenho, backup, permissões;
- **Projetista de dados** — decide **quais dados existem e como se relacionam**. É o papel deste curso;
- **Desenvolvedor** — escreve os programas que consultam e alteram;
- **Usuário final** — usa sem saber que existe um banco embaixo.

---

<!-- _class: lead -->

## ⚠️ Por que o modelador erra caro

Erro de DBA aparece **no mesmo dia**:
o servidor cai, alguém liga.

**Erro de modelagem aparece dois anos depois** —
quando descobrem que o sistema não responde
a uma pergunta simples porque a informação
nunca foi guardada de forma que permitisse.

Não há *hotfix* para isso.

---

<!-- _class: checkpoint -->

## 🏋️ Exercícios da aula

Na pasta `aula-01/`:

1. **`ex01.md`** — uma planilha real, e **cada um dos quatro pecados** que ela comete;
2. **`ex02.md`** — três situações concretas de perda de informação, como histórias;
3. **`ex03.md`** — a resposta ao cliente que diz *"a planilha na nuvem já resolve"*, em 15 linhas;
4. **`ex04.md`** — quem seria cada ator numa biblioteca universitária;
5. **Desafio 🌶️ `ex05.md`** — um caso em que a planilha é a escolha **certa**.

---

<!-- _class: lead -->

## ➡️ Próxima aula

**Aula 02 — Arquitetura e Independência de Dados**

Esquema × instância, os três níveis
e o que eles protegem.
