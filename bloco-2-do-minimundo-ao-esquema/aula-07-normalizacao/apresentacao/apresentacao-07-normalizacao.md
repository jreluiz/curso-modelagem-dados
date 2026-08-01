---
marp: true
theme: trilha
paginate: true
lang: pt-BR
footer: '🗄️ Curso de Modelagem de Dados · Aula 07'
---

<!-- _class: capa -->

<div class="emoji">🧹</div>

# Normalização até a 3FN

## Aula 07 · Bloco 2 — Do Minimundo ao Esquema

<div class="meta">A mesma pergunta, feita três vezes, cada vez mais estrita</div>

---

## 🎯 Nesta aula

1. A **redundância volta**
2. **"Depende de"** — dependência funcional sem fórmula
3. **1FN** — um valor por célula
4. **2FN** — depende da chave inteira
5. **3FN** — depende só da chave
6. Quando **não** normalizar

---

## A redundância volta, disfarçada

```
EMPRESTIMO_ITEM        chave: (id_emp, tombo)
┌────────┬───────┬──────────┬───────────┬────────────┬───────────────┐
│ id_emp │ tombo │ retirada │ matricula │ nome_usu   │ titulo        │
├────────┼───────┼──────────┼───────────┼────────────┼───────────────┤
│  1001  │ 4417  │  02/03   │  2023101  │ Ana Souza  │ Banco de Dados│
│  1001  │ 4418  │  02/03   │  2023101  │ Ana Souza  │ Eng. Software │
│  1002  │ 4417  │  09/03   │  2023102  │ Bruno Lima │ Banco de Dados│
└────────┴───────┴──────────┴───────────┴────────────┴───────────────┘
```

"Ana Souza" três vezes. E o esquema **passou por todas as regras** da Aula 06.

---

<!-- _class: lead -->

## 💡 Dependência funcional, em uma frase

**X determina Y** quando,
sabendo o valor de X,
você sabe o valor de Y —

e **sempre o mesmo**.

---

## Escrevendo as dependências

```
matricula → nome_usu, categoria    "a matrícula determina o nome e a categoria"
tombo     → titulo                 "o tombo determina o título"
id_emp    → retirada, matricula    "o empréstimo determina a data e o usuário"
```

A pergunta que as encontra é sempre a mesma:
*"sabendo isto, eu sei aquilo — **sempre**?"*

> ⚠️ É regra do **minimundo**, não observação da tabela. Coincidência da instância não conta.

---

## 1FN — um valor por célula

```
✗ Fora da 1FN                        ✅ Na 1FN
┌───────────┬──────────────────┐     USUARIO(matricula, nome)
│ matricula │ telefones        │     TELEFONE(matricula, numero)
├───────────┼──────────────────┤              ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾
│  2023101  │ 9999-1111 / 3232 │
└───────────┴──────────────────┘
```

É a Regra 2 da Aula 06, chegando por outro caminho.

> ⚠️ `telefone1, telefone2, telefone3` é a violação **disfarçada**: uma lista com o índice no nome da coluna.

---

## 2FN — depende da chave inteira

Só faz sentido quando a chave é **composta**:

```
(id_emp, tombo) → tudo                                    ✅
 id_emp         → retirada, matricula, nome_usu           ✗ parte da chave
         tombo  → titulo                                  ✗ parte da chave
```

Cada dependência parcial vira a sua própria tabela.

---

<!-- _class: lead -->

## 💡 Chave simples? A 2FN vem de graça

Não existe "parte"
de uma chave de uma coluna só.

Logo, não existe dependência parcial.

Metade das tabelas de qualquer sistema
pula essa etapa sem fazer nada.

---

## 3FN — depende só da chave

Dentro da `EMPRESTIMO` que sobrou:

```
id_emp    → retirada, matricula     ✅ dependem da chave
matricula → nome_usu, categoria     ✗ dependem de uma coluna COMUM
```

**Dependência transitiva**: a coluna chega à chave dando um pulo no meio.

A cura: quem determina vira chave da própria tabela.

---

## O esquema final

```
USUARIO(matricula, nome_usu, categoria)
        ‾‾‾‾‾‾‾‾‾
EXEMPLAR(tombo, titulo)
         ‾‾‾‾‾
EMPRESTIMO(id_emp, retirada, matricula)
           ‾‾‾‾‾‾
EMPRESTIMO_ITEM(id_emp, tombo)
                ‾‾‾‾‾‾‾‾‾‾‾‾‾
```

Uma tabela virou quatro. "Ana Souza" está escrita **uma vez**.

---

<!-- _class: lead -->

## 📏 A regra inteira, numa frase

Toda coluna depende

**da chave,**

**da chave inteira,**

**e de nada além dela.**

1FN · 2FN · 3FN

---

<!-- _class: lista-limpa -->

## Quando **não** normalizar

- 💰 **O valor histórico** — o item do pedido guarda o preço **daquele dia**. Sem ele, mudar o preço **reescreve o passado**;
- 📊 **O desempenho medido** — repetir uma coluna para evitar junção é legítimo **depois** de medir, com o motivo escrito.

> ⚠️ "Assim eu não preciso de junção" **antes** de medir não é desnormalização: é a tabela mal normalizada da Aula 01, com nome bonito.

---

<!-- _class: checkpoint -->

## 🏋️ Exercícios da aula

Na pasta `aula-07/`:

1. **`ex01.md`** — anomalia e forma normal para quatro situações;
2. **`ex02.md`** — todas as dependências funcionais de `CONSULTA`, em português;
3. **`ex03.md`** — normalize até a 3FN, dizendo que redundância cada passo eliminou;
4. **`ex04.md`** — chave composta × chave simples: quais formas normais vêm de graça?
5. **Desafio 🌶️ `ex05.md`** — construa **você** uma tabela em 2FN e fora da 3FN.

---

<!-- _class: lead -->

## ➡️ Próxima aula

**Aula 08 — Estudo de caso**

O caso inteiro, de uma vez:
enunciado, diagrama, esquema —
e os cinco erros clássicos.
