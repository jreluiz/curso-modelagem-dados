# Aula 07 — Normalização até a 3FN

> 🎯 Objetivos: descrever uma dependência funcional em português, reconhecer as violações de 1FN, 2FN e 3FN numa tabela e decompor o esquema até a 3FN justificando cada separação.
> 🎬 Slides da aula: [apresentacao-07-normalizacao.pdf](apresentacao/apresentacao-07-normalizacao.pdf)

## 1. A redundância volta

Na Aula 01 você separou uma planilha em três tabelas e as anomalias sumiram. Elas voltam — e voltam disfarçadas, dentro de esquemas que parecem certos.

Esta tabela registra a saída de cada exemplar num empréstimo. A chave é o par `(id_emp, tombo)`:

```
   EMPRESTIMO_ITEM
   ┌────────┬───────┬────────────┬───────────┬────────────┬────────────────┬───────────┐
   │ id_emp │ tombo │ retirada   │ matricula │ nome_usu   │ titulo         │ categoria │
   ├────────┼───────┼────────────┼───────────┼────────────┼────────────────┼───────────┤
   │  1001  │ 4417  │ 2026-03-02 │  2023101  │ Ana Souza  │ Banco de Dados │ aluno     │
   │  1001  │ 4418  │ 2026-03-02 │  2023101  │ Ana Souza  │ Eng. Software  │ aluno     │
   │  1002  │ 4417  │ 2026-03-09 │  2023102  │ Bruno Lima │ Banco de Dados │ aluno     │
   │  1003  │ 4420  │ 2026-03-11 │  2023101  │ Ana Souza  │ Redes          │ aluno     │
   └────────┴───────┴────────────┴───────────┴────────────┴────────────────┴───────────┘
```

"Ana Souza" três vezes. "Banco de Dados" duas. A data de retirada do empréstimo 1001 duas vezes. E as mesmas três anomalias da Aula 01 estão todas de volta — só que agora não dá para resolver no olho, porque o esquema tem chave, tem FK e passou por todas as regras da Aula 06.

**Normalização é o método que encontra essas redundâncias por análise, e não por sorte.** Três etapas, cada uma cobrando uma coisa.

## 2. "Depende de": a dependência funcional, sem fórmula

O único conceito novo da aula, e ele cabe numa frase:

> **X determina Y** quando, sabendo o valor de X, você sabe o valor de Y — e sempre o mesmo.

`matricula` determina `nome_usu`: sabendo que a matrícula é 2023101, o nome é Ana Souza, hoje e em toda linha da tabela. O contrário não vale: sabendo o nome "Ana Souza", você não sabe a matrícula (podem existir duas Anas).

Escreve-se com uma seta, e lê-se em voz alta:

```
   matricula → nome_usu, categoria      "a matrícula determina o nome e a categoria"
   tombo     → titulo                   "o tombo determina o título"
   id_emp    → retirada, matricula      "o empréstimo determina a data e o usuário"
```

Isso se chama **dependência funcional**, e a pergunta que a encontra é sempre a mesma: *"sabendo isto, eu sei aquilo — sempre?"*

> ⚠️ **A dependência é uma regra do minimundo, não uma observação da tabela.** Nas quatro linhas acima, `categoria` é sempre "aluno" — mas isso é coincidência da instância, não regra. O que vale é: a matrícula determina a categoria, porque cada usuário tem a sua.

> 💡 As três formas normais são a mesma pergunta feita três vezes, cada vez mais estrita: **o que cada coluna depende?** A resposta certa, no fim, é sempre "da chave, da chave inteira, e de nada além dela".

## 3. 1FN — um valor por célula

**Uma tabela está na 1FN quando toda célula contém um único valor indivisível.**

Nada de listas, nada de "João / Maria", nada de coluna `telefone1`, `telefone2`, `telefone3`.

```
   ✗ Fora da 1FN                          ✅ Na 1FN
   ┌───────────┬──────────────────┐       USUARIO(matricula, nome)
   │ matricula │ telefones        │       TELEFONE(matricula, numero)
   ├───────────┼──────────────────┤                ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾
   │  2023101  │ 9999-1111 / 3232 │
   └───────────┴──────────────────┘
```

Se você aplicou a Regra 2 da Aula 06, já está na 1FN — é a mesma solução, chegando por outro caminho. E é por isso que a 1FN quase nunca é violada por quem desenhou o diagrama antes: ela é violada por quem foi direto para a tabela.

> ⚠️ A coluna `telefone1, telefone2, telefone3` é a violação disfarçada. Ela parece atômica, mas é uma lista com o índice no nome da coluna — e revela-se no dia em que alguém precisa de um quarto número.

## 4. 2FN — depende da chave inteira

**Uma tabela está na 2FN quando está na 1FN e nenhuma coluna depende de apenas uma parte da chave.**

Ela só faz sentido quando a chave é **composta**. Volte à `EMPRESTIMO_ITEM`, cuja chave é `(id_emp, tombo)`:

```
   (id_emp, tombo) → tudo            ✅ a chave inteira determina a linha
    id_emp         → retirada, matricula, nome_usu, categoria    ✗ parte da chave
            tombo  → titulo                                      ✗ parte da chave
```

`titulo` depende só de `tombo`. `retirada` depende só de `id_emp`. São **dependências parciais**, e cada uma delas é uma coluna sendo repetida sem necessidade.

A cura é separar cada dependência parcial na sua própria tabela:

```
EMPRESTIMO(id_emp, retirada, matricula, nome_usu, categoria)
           ‾‾‾‾‾‾
EXEMPLAR(tombo, titulo)
         ‾‾‾‾‾
EMPRESTIMO_ITEM(id_emp, tombo)
                ‾‾‾‾‾‾‾‾‾‾‾‾‾
```

> 💡 **Se a chave primária é uma coluna só, a tabela já está automaticamente na 2FN.** Não existe "parte" de uma chave simples, então não existe dependência parcial. Vale a pena guardar isso: metade das tabelas de qualquer sistema pula essa etapa de graça.

## 5. 3FN — depende só da chave

**Uma tabela está na 3FN quando está na 2FN e nenhuma coluna depende de outra coluna que não seja chave.**

Olhe a `EMPRESTIMO` que sobrou da etapa anterior:

```
   id_emp    → retirada, matricula     ✅ dependem da chave
   matricula → nome_usu, categoria     ✗ dependem de uma coluna comum
```

`nome_usu` depende de `matricula`, que depende de `id_emp`. É uma **dependência transitiva**: a coluna chega até a chave, mas dando um pulo no meio do caminho. E o efeito é o de sempre — o nome da Ana repetido em toda linha de empréstimo dela.

A cura é a mesma: quem determina vira chave da sua própria tabela.

```
USUARIO(matricula, nome_usu, categoria)
        ‾‾‾‾‾‾‾‾‾
EMPRESTIMO(id_emp, retirada, matricula)
           ‾‾‾‾‾‾                 ↑ FK
```

E o esquema final, em 3FN, com a redundância toda eliminada:

```
USUARIO(matricula, nome_usu, categoria)
EXEMPLAR(tombo, titulo)
EMPRESTIMO(id_emp, retirada, matricula)
EMPRESTIMO_ITEM(id_emp, tombo)
```

> 📏 **A regra inteira em uma frase, e é a que vale levar para a prova e para o trabalho:** *toda coluna depende da chave, da chave inteira, e de nada além dela.* A primeira parte é a 1FN, a segunda é a 2FN, a terceira é a 3FN.

## 6. Quando não normalizar

Normalizar não é sempre. Dois casos legítimos:

**O valor histórico.** O item de um pedido guarda o `preco_unitario` praticado na data da compra, mesmo que o produto tenha o preço no cadastro. Isso **parece** redundância e não é: o preço do cadastro é o de hoje; o do item é o daquele dia. São dois fatos diferentes que por acaso coincidiam quando o pedido foi feito.

> ⚠️ Sem essa coluna, mudar o preço de um produto **reescreve o passado** — todos os pedidos antigos passam a valer o preço novo. É um dos erros mais caros que um modelo pode conter, e ele se disfarça de boa prática.

**O desempenho medido.** Repetir uma coluna para evitar uma junção é decisão legítima **depois** de medir, com o motivo escrito e alguém responsável por manter as cópias em dia.

> ⚠️ "Assim eu não preciso de junção" **antes** de qualquer medição não é desnormalização: é a tabela mal normalizada da Aula 01, com um nome bonito. A diferença entre as duas coisas é a medição e o registro da decisão.

> 📖 O livro-base vai além da 3FN — apresenta a forma normal de Boyce-Codd, a 4FN e a prova de que uma decomposição não perde informação. Nada disso é cobrado aqui; se você gostou do assunto, é exatamente por ali que ele continua.

> 💻 **Modelos desta aula:** [`normalizacao.md`](exemplos/normalizacao.md) — a decomposição completa, passo a passo.

## 🏋️ Exercícios da aula

Na pasta `aula-07/` do seu repositório:

1. **`ex01.md`** — para cada situação, diga qual das três anomalias da Aula 01 está acontecendo e qual forma normal, se respeitada, teria evitado: (a) o telefone do fornecedor está diferente em duas linhas; (b) não há como cadastrar um curso sem alunos; (c) apagar o último empréstimo de um exemplar apaga o título dele; (d) a coluna `autores` guarda "Silva; Souza; Lima". *Confira assim: cada letra tem uma anomalia e uma forma normal, e as três formas normais aparecem.*
2. **`ex02.md`** — dada `CONSULTA(n_consulta, crm, data, hora, nome_medico, especialidade, cpf_paciente, nome_paciente, convenio)`, com chave `n_consulta`: escreva **todas as dependências funcionais** em português, uma por linha, no formato `X → Y` seguido da frase que a justifica. *Confira assim: toda coluna que não é chave precisa aparecer do lado direito de pelo menos uma seta.*
3. **`ex03.md`** — normalize a `CONSULTA` do exercício anterior até a 3FN. Entregue: a tabela original, a violação encontrada em cada etapa (com a dependência culpada), e o esquema final com PKs e FKs. Escreva uma linha por decomposição dizendo **qual redundância ela eliminou**. *Confira assim: no esquema final, escolha um nome de médico e confirme que ele está escrito em um lugar só.*
4. **`ex04.md`** — a tabela `MATRICULA(matricula_aluno, cod_turma, data_inscricao, nota)` tem chave composta `(matricula_aluno, cod_turma)`. (a) Ela está na 2FN? Prove analisando cada coluna; (b) agora a tabela `ALUNO(matricula, nome, cod_curso, nome_curso)` tem chave simples — ela está automaticamente na 2FN? E na 3FN? Justifique as duas respostas. *Confira assim: a resposta de (b) é "sim" para uma das formas normais e "não" para a outra, e o motivo de cada uma é diferente.*
5. **Desafio 🌶️ `ex05.md`** — construa **você** uma tabela que esteja na 2FN e **não** esteja na 3FN, num domínio que você conheça e que não seja nenhum dos usados nesta aula. Entregue: a tabela com pelo menos 4 linhas de exemplo, a prova de que está na 2FN, a dependência transitiva que quebra a 3FN, um exemplo concreto de anomalia que ela permite, e a decomposição corrigida. *Confira assim: se a sua tabela tem chave composta, você tornou o exercício mais difícil do que precisava — com chave simples a 2FN vem de graça e sobra só a transitiva.*

## 🧠 Revisão

[8 questões de múltipla escolha](revisao/README.md) para conferir se os conceitos ficaram sólidos. Responda sem consultar a aula — depois volte e corrija.

## ✅ Entrega

```bash
git add aula-07/
git commit -m "Resolve exercícios da aula 07 (normalização até a 3FN)"
git push
```

---

⬅️ [Aula 06](../aula-06-do-der-as-tabelas/README.md) | ➡️ [Aula 08 — Estudo de caso: do minimundo ao esquema pronto](../aula-08-estudo-de-caso/README.md)
