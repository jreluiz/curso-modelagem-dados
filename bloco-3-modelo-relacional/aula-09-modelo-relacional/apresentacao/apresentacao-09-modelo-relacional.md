---
marp: true
theme: trilha
paginate: true
lang: pt-BR
footer: '🗄️ Curso de Modelagem de Dados · Aula 09'
---

<!-- _class: capa -->

<div class="emoji">📊</div>

# O Modelo Relacional

## Aula 09 · Bloco 3 — Modelo Relacional

<div class="meta">O vocabulário formal — e as regras que o banco cobra</div>

---

## 🎯 Nesta aula

1. **Relação, tupla, atributo, domínio**
2. As **propriedades** de uma relação
3. Chaves, com o **vocabulário completo**
4. As **quatro restrições de integridade**
5. O **valor nulo** e as **ações referenciais**

---

## O vocabulário formal

| Formal | No dia a dia | Formal | No dia a dia |
|---|---|---|---|
| **Relação** | tabela | **Domínio** | tipo + regras |
| **Tupla** | linha | **Grau** | nº de colunas |
| **Atributo** | coluna | **Cardinalidade** | nº de linhas |

> 💡 Vale conhecer os dois vocabulários. O formal aparece na literatura e em prova; o informal, em toda conversa de trabalho.

---

<!-- _class: lista-limpa -->

## As propriedades de uma relação

Uma relação **não é** uma planilha. Ela tem três propriedades que a planilha não tem:

- 🔀 **Não há ordem entre as linhas** — a "primeira linha" não existe;
- 🔀 **Não há ordem entre as colunas** — a "quarta coluna" não existe;
- 🚫 **Não há linhas duplicadas** — toda tupla é distinta;
- ⚛️ **Todo valor é atômico** — nada de lista dentro da célula.

---

<!-- _class: lead -->

## 💡 Por que isso importa

Se a ordem das colunas não existe,

`SELECT * FROM aluno` **não tem garantia**
de trazer as colunas na ordem que você espera.

Essa é a base formal da regra prática
da aula 02: **sempre liste as colunas**.

---

## Chaves, com todos os nomes

**Superchave** — qualquer conjunto que identifica unicamente. Pode ter atributos sobrando.

**Chave candidata** — superchave **mínima**: tire um atributo e ela deixa de identificar.

**Chave primária** — a candidata escolhida.

**Chave alternativa** — as candidatas que sobraram.

**Chave estrangeira** — atributo que **referencia** a chave primária de outra relação.

---

<!-- _class: tabela-densa -->

## As quatro restrições de integridade

| Restrição | O que garante |
|---|---|
| **De domínio** | todo valor pertence ao domínio da coluna |
| **De chave** | não há duas tuplas com a mesma chave |
| **De entidade** | a chave primária **nunca** é nula |
| **Referencial** | toda FK aponta para uma PK que **existe** — ou é nula |

As quatro são declaradas na aula 13 e cobradas pelo SGBD, não pelo programador.

---

## O nulo e seus três significados

`NULL` **não é** zero, nem string vazia. Significa **ausência de valor** — e pelo menos três coisas diferentes:

1. **Não se aplica** — `data_devolucao` de um empréstimo em aberto;
2. **Desconhecido** — o telefone existe, mas ninguém informou;
3. **Não informado ainda** — vai ser preenchido depois.

O banco não distingue os três. **Você** precisa.

---

<!-- _class: lead -->

## 📏 A regra do curso sobre nulos

Declare **`NOT NULL` em tudo**
que não tenha um motivo **escrito** para ser opcional.

E **documente o significado** de cada nulo que sobrar.

Na Biblioteca, `data_devolucao` nula significa
exatamente uma coisa: **empréstimo em aberto**.

---

<!-- _class: tabela-densa -->

## Ações referenciais: o que fazer ao apagar o pai

| Ação | O que acontece com os filhos |
|---|---|
| `RESTRICT` / `NO ACTION` | **impede** apagar o pai. O padrão seguro |
| `CASCADE` | apaga os filhos junto |
| `SET NULL` | a FK vira nula (a coluna precisa aceitar) |
| `SET DEFAULT` | a FK vira o valor padrão |

---

<!-- _class: lead -->

## ⚠️ `CASCADE` é conveniente e perigoso

Apagar uma obra apagando os exemplares junto
soa razoável.

Apagar uma obra apagando os exemplares,
que apagam os empréstimos,
que apagam o histórico de multas —

**não soa.**

Escolha a ação **por relacionamento**, com a pergunta:
*"o filho faz sentido sem o pai?"*

---

<!-- _class: checkpoint -->

## 🏋️ Exercícios da aula

Na pasta `aula-09/`:

1. **`ex01.md`** — traduza um esquema do formal para o informal e vice-versa;
2. **`ex02.md`** — mostre uma consulta que quebra por confiar na ordem das colunas;
3. **`ex03.md`** — liste super, candidata, primária, alternativa e estrangeira de um esquema;
4. **`ex04.md`** — para cada FK do seu modelo, escolha a ação referencial **e justifique**;
5. **Desafio 🌶️ `ex05.md`** — três nulos do seu modelo, cada um com o significado documentado.

---

<!-- _class: lead -->

## ➡️ Próxima aula

**Aula 10 — Mapeamento ER → Relacional**

As sete regras que traduzem
o seu diagrama em tabelas.
