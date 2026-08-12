# Aula 15 — Aplicando a 1FN e a 2FN

> 🎯 Objetivos: executar a decomposição de uma tabela até a 2FN, conferir que nenhuma informação se perdeu e reconhecer a dependência transitiva que a 3FN proíbe.
> 🎬 Slides da aula: [apresentacao-15-aplicando-1fn-e-2fn.pdf](apresentacao/apresentacao-15-aplicando-1fn-e-2fn.pdf)

## 1. A tabela completa

A secretaria mandou a tabela de inscrições **inteira** — a da Aula 13 estava resumida. Duas colunas a mais, e as duas vão dar trabalho:

```
   INSCRICAO(cod_ev, matricula, nome_aluno, curso, titulo_evento,
             carga_horaria, sala, capacidade_sala, palestrantes,
             data_inscricao)

   CHAVE: (cod_ev, matricula)

   101 | 2023101 | Ana Souza  | ADS | Pesquisa em base | 4 | S-204 | 40 | Marta Dias; Carlos Reis | 12/03
   101 | 2023102 | Bruno Lima | ADS | Pesquisa em base | 4 | S-204 | 40 | Marta Dias; Carlos Reis | 12/03
   102 | 2023101 | Ana Souza  | ADS | Normas ABNT      | 2 | S-101 | 25 | Marta Dias              | 15/03
```

Duas coisas saltam aos olhos, e cada uma é uma forma normal: a coluna `palestrantes` guarda **uma lista**, e o nome da Ana está lá **duas vezes**.

## 2. Passo 1 — a 1FN

A regra é a da Aula 14: valor atômico em toda célula. A coluna `palestrantes` viola, e a cura é sempre a mesma — **atributo multivalorado vira tabela própria**:

```
   INSCRICAO(cod_ev, matricula, nome_aluno, curso, titulo_evento,
             carga_horaria, sala, capacidade_sala, data_inscricao)

   PALESTRANTE_EVENTO(cod_ev, nome_palestrante)
      chave: (cod_ev, nome_palestrante)
      101 | Marta Dias
      101 | Carlos Reis
      102 | Marta Dias
```

Repare no que a tabela nova ganhou de graça: agora dá para saber **em quantos eventos a Marta falou** — pergunta que a lista dentro da célula não respondia sem quebrar o texto no meio.

> ⚠️ **A chave da tabela nova é o par inteiro.** `cod_ev` sozinho não identifica (o evento 101 tem duas linhas), e `nome_palestrante` sozinho também não (a Marta aparece em dois eventos). Esquecer isso e pôr só `cod_ev` como chave é o tropeço mais comum deste passo.

## 3. Passo 2 — a 2FN

A lista de dependências da Aula 14, agora com a coluna nova:

```
   CHAVE: (cod_ev, matricula)

   (cod_ev, matricula) → data_inscricao                      ✅ chave inteira
    matricula          → nome_aluno, curso                   ⚠️ parcial
    cod_ev             → titulo_evento, carga_horaria,
                         sala, capacidade_sala               ⚠️ parcial
```

A 2FN manda eliminar as parciais, e o procedimento é mecânico:

```
   PARA CADA determinante que é PARTE da chave:
       1. crie uma tabela nova
       2. o determinante vira a chave dela
       3. leve para lá tudo o que ele determina
       4. o determinante FICA na tabela original, como chave estrangeira
```

Aplicando duas vezes:

```
   ALUNO(matricula, nome_aluno, curso)

   EVENTO(cod_ev, titulo_evento, carga_horaria, sala, capacidade_sala)

   INSCRICAO(matricula → ALUNO, cod_ev → EVENTO, data_inscricao)
      chave: (cod_ev, matricula)

   PALESTRANTE_EVENTO(cod_ev → EVENTO, nome_palestrante)
```

O passo 4 é o que mais gente esquece: **o determinante permanece** na tabela original. Se `matricula` sumisse de `INSCRICAO`, ninguém saberia mais quem se inscreveu — e aí a decomposição teria perdido informação, que é o pecado da seção 4.

> ⚠️ **Os dois passos podem ser feitos numa tacada só, e quase todo mundo faz.** Quem já enxerga as quatro tabelas não precisa passar pela 1FN intermediária. O que **não** se pode pular é a **justificativa**: cada tabela nova sai de uma dependência escrita, e é ela que você defende quando alguém perguntar por que o esquema ficou assim. O roteiro em dois passos existe para não deixar você enxergar demais e errar.

> 💡 Compare o resultado com o DER da Aula 09. São as mesmas quatro tabelas que sairiam de lá pela conversão da Aula 07. **A normalização chegou ao mesmo lugar por outro caminho** — e é assim que se ganha confiança nos dois métodos.

## 4. A conferência: não perder informação

Toda decomposição precisa ser **sem perda**: remontando as tabelas, você obtém exatamente as linhas de antes — nem menos, nem mais.

O teste, no nível deste curso, é uma pergunta: **a coluna pela qual você separou é chave em pelo menos uma das duas tabelas resultantes?**

```
   ALUNO ← separado por `matricula`

   `matricula` é chave em ALUNO?         SIM   ✅ decomposição sem perda
   `matricula` está em INSCRICAO?        SIM   ✅ dá para remontar
```

Se a resposta fosse não, você teria inventado linhas que nunca existiram — o erro "normalizar até quebrar" do catálogo. E há a conferência de sempre, que custa dois minutos:

1. **Some as informações.** Toda coluna da tabela original aparece em alguma das novas? Nenhuma sumiu?
2. **Remonte uma linha.** Pegue a inscrição `(101, 2023101)` e reconstrua a linha original juntando as quatro tabelas. Bateu?
3. **Teste as anomalias da Aula 13.** Dá para cadastrar evento sem inscrito? (Agora dá.) Corrigir o nome da Ana muda uma linha só? (Agora sim.)

Um contraexemplo, para ver o teste reprovando: separar `ALUNO(matricula, nome, curso)` em `ALUNO(matricula, nome)` e `CURSO(curso)` **perde informação** — `curso` não é chave em nenhuma das duas de forma que ligue de volta à matrícula, e depois da separação ninguém sabe mais em que curso a Ana está. Sobrou a lista de cursos existentes, que não era a pergunta.

## 5. Uma dependência que não é parcial — e ainda incomoda

O esquema está em 2FN. Olhe a tabela `EVENTO`:

```
   EVENTO(cod_ev, titulo_evento, carga_horaria, sala, capacidade_sala)

   101 | Pesquisa em base | 4 | S-204 | 40
   102 | Normas ABNT      | 2 | S-101 | 25
   103 | Escrita técnica  | 3 | S-204 | 40      ← 40 de novo
```

A capacidade da sala S-204 está escrita duas vezes. E não é dependência parcial — a chave `cod_ev` tem **uma coluna só**, então não há metade de que depender.

O que acontece é outra coisa:

```
   cod_ev → sala            a sala depende do evento
   sala   → capacidade_sala a capacidade depende da SALA
   ───────────────────────────────────────────────────
   cod_ev → capacidade_sala ... mas por tabela interposta
```

Isso se chama **dependência transitiva**: um atributo não-chave (`capacidade_sala`) depende de **outro atributo não-chave** (`sala`), que por sua vez depende da chave.

E as anomalias voltam pela terceira vez: mudou a capacidade da S-204? Duas linhas para corrigir. Sala nova ainda sem evento marcado? Não cabe.

## 6. A 3FN

Um esquema está na **terceira forma normal** quando:

1. está na **2FN**; e
2. **nenhum atributo não-chave depende de outro atributo não-chave** — ou seja, não há dependência transitiva.

A diferença entre as duas formas cabe em duas linhas, e vale decorar exatamente assim:

| | O atributo depende de… | Só existe quando… |
|---|---|---|
| **2FN** | **parte da chave** | a chave é **composta** |
| **3FN** | **outro atributo não-chave** | sempre — chave simples ou composta |

> ⚠️ **Chamar de 2FN o que era 3FN é o erro mais frequente do bloco**, e o mais fácil de evitar: **olhe a chave primeiro**. Chave de uma coluna só? Então não é 2FN, ponto final — o que você encontrou é transitiva. O aluno que decompõe certo mas justifica errado perde a parte que importa, porque a justificativa é o que prova que ele entendeu.

A frase que resume as três primeiras formas normais, e que vale levar para qualquer projeto:

> **Todo atributo depende da chave, da chave inteira, e de nada além da chave.**

"Da chave" é a 1FN — existe chave e cada célula tem um valor. "Da chave inteira" é a 2FN. "De nada além da chave" é a 3FN.

Aplicar a 3FN a esta tabela — e depois olhar a 4FN — é a Aula 16.

> 💻 **Modelos desta aula:** [`normalizacao-passo-a-passo.md`](exemplos/normalizacao-passo-a-passo.md) — a decomposição inteira, com a conferência de cada passo.

## 🏋️ Exercícios da aula

Na pasta `aula-15/` do seu repositório:

1. **`ex01.md`** — a biblioteca guarda os empréstimos assim: `EMPRESTIMO(matricula, isbn, data_retirada, nome_aluno, curso, titulo_livro, editora, generos)`, com chave `(matricula, isbn)` e `generos` guardando valores como `"ficção; brasileira"`. Leve o esquema até a **2FN**, mostrando os dois passos separados: primeiro a 1FN, depois a 2FN. *Confere assim: saem quatro tabelas, e a que resolveu a 1FN tem chave de duas colunas. Se você chegou em três tabelas, provavelmente resolveu a lista de gêneros com colunas numeradas.*

2. **`ex02.md`** — para cada decomposição abaixo, diga se ela é **sem perda**, aplicando o teste da seção 4: (a) `ALUNO(matricula, nome, curso)` separada em `ALUNO(matricula, nome)` e `CURSO_ALUNO(matricula, curso)`; (b) a mesma separada em `ALUNO(matricula, nome)` e `CURSO(curso)`; (c) `EVENTO(cod_ev, titulo, sala, capacidade)` separada em `EVENTO(cod_ev, titulo, sala)` e `SALA(sala, capacidade)`. *Confere assim: uma das três perde informação, e o teste de remontar mostra exatamente qual — tente reconstruir a linha original e veja o que não volta.*

3. **`ex03.md`** — no esquema `FUNCIONARIO(matricula_func, nome, cod_setor, nome_setor, ramal_setor)`, com chave `matricula_func`: liste as dependências funcionais, classifique o problema como **parcial ou transitivo** justificando pela chave, e diga em qual forma normal o esquema está. *Confere assim: a chave tem uma coluna só, e isso já responde metade da questão antes de você olhar qualquer atributo.*

## 🧠 Revisão

[8 questões de múltipla escolha](revisao/README.md) para conferir se os conceitos ficaram sólidos. Responda sem consultar a aula — depois volte e corrija.

## ✅ Entrega

```bash
git add aula-15/
git commit -m "Resolve exercícios da aula 15 (aplicando a 1FN e a 2FN)"
git push
```

---

⬅️ [Aula 14 — Dependência Funcional, 1FN e 2FN](../aula-14-dependencia-funcional-1fn-2fn/README.md) | ➡️ [Aula 16 — 3FN e 4FN](../aula-16-3fn-e-4fn/README.md)
