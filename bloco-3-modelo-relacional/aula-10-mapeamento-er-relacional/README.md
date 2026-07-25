# Aula 10 — Mapeamento ER → Relacional

> 🎯 Objetivos: aplicar as sete regras de mapeamento, escolher entre as quatro opções de especialização e reconhecer o que se perde na tradução.

## 1. Por que traduzir

O DER descreve o mundo; o modelo relacional descreve tabelas. A tradução entre os dois é **mecânica e conhecida** — sete regras, aplicáveis na ordem, sem improviso.

Isso tem uma implicação importante: se o mapeamento é mecânico, **todo defeito do esquema final já estava no DER**. Não existe salvar um modelo conceitual ruim na hora de gerar as tabelas. É por isso que os Blocos 1 e 2 tomaram metade do curso.

**Convenção do curso:** chave primária <ins>sublinhada</ins>, chave estrangeira marcada com *itálico* e uma seta indicando o destino.

## 2. Regra 1 — Entidade forte

Toda entidade forte vira uma **relação**. Os atributos simples viram colunas; a chave primária vira a chave primária.

```
   OBRA(isbn, titulo, ano_publicacao, editora)
        ‾‾‾‾
```

Atributos **compostos** são achatados: só as folhas viram colunas. `endereco(logradouro, numero, cidade)` vira três colunas `end_logradouro`, `end_numero`, `end_cidade` — a coluna `endereco` não existe.

Atributos **derivados** simplesmente não viram coluna.

## 3. Regra 2 — Entidade fraca

Vira uma relação que inclui, como parte da chave primária, a **chave da entidade proprietária**. A chave completa é `chave da proprietária + chave parcial`, e a parte herdada é também uma FK.

```
   RENOVACAO(id_emprestimo, sequencia, data_renovacao, nova_data_prevista)
             ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾
             id_emprestimo → EMPRESTIMO(id_emprestimo)   ON DELETE CASCADE
```

A FK de uma entidade fraca é sempre `NOT NULL` (a participação é total) e quase sempre `ON DELETE CASCADE` — foi o que a Aula 09 concluiu.

## 4. Regra 3 — Relacionamento 1:N

A chave da entidade do lado **1** vai como FK para a relação do lado **N**. Sem tabela nova.

```
   EXEMPLAR(tombo, isbn, data_aquisicao, situacao)
            ‾‾‾‾‾
            isbn → OBRA(isbn)   NOT NULL
```

> ⚠️ **A FK vai sempre para o lado N — nunca o contrário.** Colocar `tombo` dentro de `OBRA` obrigaria a repetir a linha da obra uma vez por exemplar, que é exatamente a redundância que o modelo existe para eliminar. Quando estiver na dúvida sobre qual lado, pergunte: *"de que lado eu teria que repetir a linha?"* É o lado errado.

Se a participação do lado N for **total**, a FK é `NOT NULL`. Se parcial, aceita nulo.

Atributos do relacionamento 1:N acompanham a FK para o lado N.

## 5. Regra 4 — Relacionamento 1:1

Três opções, em ordem de preferência:

**(a) FK do lado de participação total.** É a melhor: evita nulos.

```
   Se todo empréstimo com atraso gera multa, mas nem todo empréstimo tem multa:
   MULTA(id_emprestimo, valor, data_pagamento)
         ‾‾‾‾‾‾‾‾‾‾‾‾‾
         id_emprestimo → EMPRESTIMO(id_emprestimo)
```

`MULTA` tem participação total (toda multa tem empréstimo), então a FK fica nela — e vira a própria chave primária, o que garante o 1:1.

**(b) Fundir as duas relações em uma.** Válido quando **ambas** as participações são totais e as entidades são sempre consultadas juntas. Custo: perde-se a distinção conceitual.

**(c) FK em qualquer um dos lados, com `UNIQUE`.** Última opção, quando as duas participações são parciais. Gera nulos.

> 💡 **Num 1:1 a FK precisa ser `UNIQUE`.** Sem isso, o banco aceita dois registros apontando para o mesmo — e o 1:1 vira 1:N sem que ninguém perceba. Quando a FK é também a PK, o `UNIQUE` vem de graça.

## 6. Regra 5 — Relacionamento N:M

Vira **sempre** uma relação nova (tabela associativa). A chave primária é a **combinação** das chaves das duas entidades. Os atributos do relacionamento vão para essa tabela.

```
   ESCRITA(isbn, id_autor, ordem)
           ‾‾‾‾‾‾‾‾‾‾‾‾‾
           isbn     → OBRA(isbn)
           id_autor → AUTOR(id_autor)
```

`ordem` é o atributo do relacionamento (a posição do autor na capa) e não tem outro lugar onde morar: não é da obra nem do autor, é do par.

> ⚠️ **Não existe N:M sem tabela associativa.** Qualquer tentativa de resolver com colunas repetidas (`autor1`, `autor2`, `autor3`) ou com texto separado por vírgula viola a 1FN e destrói a capacidade de consultar. Se o modelo lógico tem N:M sem tabela no meio, o mapeamento não foi feito.

**Nome da tabela associativa:** prefira o **verbo do relacionamento** (`ESCRITA`, `MATRICULA`, `PARTICIPACAO`) a concatenar os nomes (`OBRA_AUTOR`). O verbo carrega o significado; a concatenação só carrega a origem.

A chave composta é a natural — mas se a tabela associativa for referenciada por outras, ou se o mesmo par puder ocorrer mais de uma vez (mesmo aluno, mesma disciplina, semestres diferentes), a chave precisa de um atributo a mais, ou de uma chave artificial.

## 7. Regra 6 — Atributo multivalorado

Vira uma **relação própria**, com a chave da entidade original mais o próprio valor formando a chave.

```
   TELEFONE(matricula, numero, tipo)
            ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾
            matricula → USUARIO(matricula)   ON DELETE CASCADE
```

É a mesma forma da Regra 2 — o que confirma o que a Aula 06 dizia: **atributo multivalorado é uma entidade fraca disfarçada**.

## 8. Regra 7 — Relacionamento n-ário

Um relacionamento de grau *n* vira uma relação com as chaves das *n* entidades participantes. A chave primária é a combinação de todas (ou de um subconjunto, se a cardinalidade permitir).

```
   PRESCRICAO(crm, prontuario, cod_medicamento, data, dosagem)
              ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾
```

Se o mesmo médico puder prescrever o mesmo medicamento ao mesmo paciente em datas diferentes, `data` entra na chave — caso contrário, o modelo só guarda a última prescrição.

> 💡 Determinar a chave de um n-ário é onde se erra. Método: **liste os fatos que precisam coexistir** e verifique se a chave proposta permite guardá-los todos. Se dois fatos legítimos colidem na mesma chave, falta atributo.

## 9. Especialização: as quatro opções

Não há regra única — há quatro estratégias, e a escolha depende das restrições de disjunção e completude da Aula 07.

### Opção A — Uma tabela por subclasse, mais a superclasse

```
   USUARIO(matricula, nome, email, data_cadastro)
   ALUNO(matricula, curso, semestre_ingresso)        matricula → USUARIO
   PROFESSOR(matricula, departamento, titulacao)     matricula → USUARIO
   SERVIDOR(matricula, setor)                        matricula → USUARIO
```

✅ Funciona para **qualquer** combinação de disjunção e completude, sem desperdício de espaço.
❌ Toda consulta que precise dos dois níveis exige junção.
**É a opção padrão do curso** e a escolhida para a Biblioteca.

### Opção B — Uma tabela por subclasse, **sem** a superclasse

```
   ALUNO(matricula, nome, email, data_cadastro, curso, semestre_ingresso)
   PROFESSOR(matricula, nome, email, data_cadastro, departamento, titulacao)
   SERVIDOR(matricula, nome, email, data_cadastro, setor)
```

✅ Sem junção para acessar um tipo.
❌ Só vale se a especialização for **total** (senão não há onde guardar quem não é de nenhum tipo) **e disjunta** (senão duplica dados).
❌ E aqui está o problema fatal para a Biblioteca: `EMPRESTIMO` teria que ter **três** FKs opcionais, ou três tabelas de empréstimo. Consultar "todos os empréstimos" viraria `UNION`.

### Opção C — Tabela única com discriminador

```
   USUARIO(matricula, nome, email, data_cadastro, tipo,
           curso, semestre_ingresso, departamento, titulacao, setor)
```

✅ Nenhuma junção. Simples de consultar.
❌ Só vale se a especialização for **disjunta** — um campo `tipo` não guarda dois valores.
❌ Muitos nulos: um aluno tem `departamento`, `titulacao` e `setor` sempre vazios.
👉 Aceitável quando as subclasses têm **poucos** atributos exclusivos e o volume é pequeno.

### Opção D — Tabela única com flags

```
   PESSOA(id, nome, e_autor, e_revisor, instituicao, areas_interesse)
```

Para especialização **sobreposta**: um booleano por subclasse, em vez de um discriminador.
❌ Nulos e a impossibilidade de restringir bem os atributos por tipo.

| Restrição da especialização | Opções viáveis |
|---|---|
| Disjunta e total | A, B, C |
| Disjunta e parcial | A, C |
| Sobreposta e total | A, D |
| Sobreposta e parcial | A, D |

> 💡 Repare que a **opção A serve sempre**. Quando a decisão estiver difícil, ela é a escolha segura — e a única que não força você a acertar a classificação da Aula 07 de primeira.

## 10. O esquema completo da Biblioteca

Aplicando as regras ao DER da Aula 08:

```
USUARIO(matricula, nome, email, data_cadastro)                          — Regra 1
ALUNO(matricula, curso, semestre_ingresso)                              — Opção A
    matricula → USUARIO(matricula)   ON DELETE CASCADE
PROFESSOR(matricula, departamento, titulacao)                           — Opção A
    matricula → USUARIO(matricula)   ON DELETE CASCADE
SERVIDOR(matricula, setor)                                              — Opção A
    matricula → USUARIO(matricula)   ON DELETE CASCADE
TELEFONE(matricula, numero, tipo)                                       — Regra 6
    matricula → USUARIO(matricula)   ON DELETE CASCADE
OBRA(isbn, titulo, ano_publicacao, editora)                             — Regra 1
AUTOR(id_autor, nome, nacionalidade)                                    — Regra 1
AREA(codigo_area, nome)                                                 — Regra 1
ESCRITA(isbn, id_autor, ordem)                                          — Regra 5
    isbn → OBRA(isbn) · id_autor → AUTOR(id_autor)
CLASSIFICACAO(isbn, codigo_area)                                        — Regra 5
    isbn → OBRA(isbn) · codigo_area → AREA(codigo_area)
EXEMPLAR(tombo, isbn, data_aquisicao, situacao)                         — Regra 3
    isbn → OBRA(isbn)   NOT NULL
FUNCIONARIO(matricula_func, nome, cargo)                                — Regra 1
EMPRESTIMO(id_emprestimo, matricula, tombo, matricula_func,             — Regra 3 (×3)
           data_retirada, data_prevista, data_devolucao)
    matricula → USUARIO · tombo → EXEMPLAR · matricula_func → FUNCIONARIO
RENOVACAO(id_emprestimo, sequencia, data_renovacao, nova_data_prevista) — Regra 2
    id_emprestimo → EMPRESTIMO   ON DELETE CASCADE
RESERVA(id_reserva, matricula, isbn, data_solicitacao, situacao)        — Regra 3 (×2)
    matricula → USUARIO · isbn → OBRA
MULTA(id_emprestimo, valor, data_pagamento, justificativa_perdao, matricula_func)
    id_emprestimo → EMPRESTIMO   — Regra 4, opção (a)
    matricula_func → FUNCIONARIO   NULL permitido   ON DELETE SET NULL
```

Onze entidades e três subclasses viraram **16 relações**. Repare que `EMPRESTIMO` recebeu **três** FKs — uma por relacionamento 1:N em que está do lado N.

## 11. O que se perde na tradução

O esquema relacional é mais pobre que o DER, e é útil saber exatamente onde:

| No DER | No relacional | Como recuperar |
|---|---|---|
| O nome do relacionamento (`EMPRESTA`) | Vira uma coluna sem nome próprio | Comentário no DDL, ou nome da tabela associativa |
| Participação total do lado 1 | **Não é expressável** | Gatilho ou verificação na aplicação |
| Especialização disjunta | Vira nada, se opção A | `CHECK` complexo ou gatilho |
| Restrição de cardinalidade máxima (`no máximo 5`) | **Não é expressável** | Gatilho |
| Atributo derivado | Some | `VIEW` ou coluna calculada |
| A distinção entidade fraca × forte | Só sobrevive na chave composta | Documentação |

> ⚠️ **A participação total do lado 1 é a perda que mais dói.** "Toda obra tem pelo menos um exemplar" não vira restrição nenhuma: a FK está em `EXEMPLAR`, e nada obriga a existir uma linha lá. `NOT NULL` na FK garante o inverso ("todo exemplar tem obra"). Guardar essa assimetria evita horas de tentativa de declarar o indeclarável.

> 📖 As regras de mapeamento ER→relacional são o núcleo do projeto lógico no livro-base. A quantidade de regras varia entre autores (sete, oito, nove) porque alguns separam casos que outros agrupam — o conteúdo é o mesmo.

> 💻 **Modelos desta aula:** [`esquema-relacional.md`](exemplos/esquema-relacional.md)

## 🏋️ Exercícios da aula

Na pasta `aula-10/` do seu repositório:

1. **`ex01.md`** — mapeie o DER abaixo para o esquema relacional, indicando **qual regra** aplicou em cada passo e marcando PKs e FKs:

   ```mermaid
   erDiagram
       CLIENTE ||--o{ PEDIDO : "faz"
       PEDIDO ||--|{ ITEM_PEDIDO : "contém"
       PRODUTO ||--o{ ITEM_PEDIDO : "aparece em"
       CATEGORIA ||--o{ PRODUTO : "classifica"
       CLIENTE ||--o{ ENDERECO : "tem"
   ```

2. **`ex02.md`** — mapeie o N:M `ALUNO`–`DISCIPLINA` de uma escola em que **o aluno pode cursar a mesma disciplina em semestres diferentes**, guardando nota e frequência. Mostre por que a chave `(matricula, cod_disciplina)` **não serve** — com um exemplo concreto de dois fatos que colidiriam — e proponha a chave correta;
3. **`ex03.md`** — mapeie o atributo multivalorado `palavras_chave` de `ARTIGO`, e depois responda: (a) qual a chave da nova relação; (b) como fica a consulta "artigos com a palavra-chave 'banco de dados'"; (c) o que aconteceria se a solução escolhida fosse um único campo de texto com as palavras separadas por vírgula — escreva a consulta que passaria a ser necessária e diga por que ela é ruim;
4. **`ex04.md`** — para a especialização `PROFISSIONAL` → `MEDICO`/`ENFERMEIRO`/`TECNICO` (disjunta e total) de um hospital, escreva o esquema resultante nas **opções A, B e C**. Para cada uma, escreva a consulta "liste o nome de todos os profissionais do hospital" e compare. Recomende uma, justificando com base em como o hospital consulta os dados;
5. **Desafio 🌶️ `ex05.md`** — mapeie o ternário `FORNECEDOR`–`PECA`–`PROJETO` (*um fornecedor fornece uma peça para um projeto, em certa quantidade e por certo preço*). Depois responda: (a) qual a chave primária, e por quê; (b) se a mesma combinação puder ocorrer em datas diferentes, o que muda; (c) mostre um fato que este esquema **consegue** registrar e que a decomposição em três binários (`FORNECEDOR`–`PECA`, `PECA`–`PROJETO`, `FORNECEDOR`–`PROJETO`) **perderia**, com dados concretos nas duas versões.

## 🧠 Revisão

[8 questões de múltipla escolha](revisao/README.md) para conferir se os conceitos ficaram sólidos. Responda sem consultar a aula — depois volte e corrija.

## ✅ Entrega

```bash
git add aula-10/
git commit -m "Resolve exercícios da aula 10 (mapeamento ER-relacional)"
git push
```

---

⬅️ [Aula 09](../aula-09-modelo-relacional/README.md) | ➡️ [Aula 11 — Álgebra relacional](../aula-11-algebra-relacional/README.md)
