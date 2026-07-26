# Aula 12 — Normalização

> 🎯 Objetivos: identificar anomalias de atualização, escrever as dependências funcionais de um esquema e decompor uma relação até a 3FN/BCNF justificando cada passo.
> 🎬 Slides da aula: [apresentacao-12-normalizacao.pdf](apresentacao/apresentacao-12-normalizacao.pdf)

## 1. As três anomalias

Considere esta relação, que guarda empréstimos "tudo em um":

```
EMPRESTIMO_TUDO(id, matricula, nome_usuario, email, tombo, isbn, titulo, editora, data_retirada)

┌────┬───────────┬───────────┬──────┬────────┬─────────────────┬────────────┐
│ id │ matricula │nome_usuar.│ tombo│  isbn  │     titulo      │  editora   │
├────┼───────────┼───────────┼──────┼────────┼─────────────────┼────────────┤
│ 1  │  2023101  │ Ana Souza │ 4417 │ 978-01 │ Bancos de Dados │  Unicamp   │
│ 2  │  2023101  │ Ana Souza │ 4418 │ 978-02 │ Algoritmos      │  Campus    │
│ 3  │  2023102  │ Bruno Lima│ 4419 │ 978-01 │ Bancos de Dados │  Unicamp   │
└────┴───────────┴───────────┴──────┴────────┴─────────────────┴────────────┘
```

**Anomalia de inserção.** Como cadastrar uma obra nova que ainda não foi emprestada? Não dá — seria preciso inventar um empréstimo falso. A informação sobre obras só existe *acoplada* a um empréstimo.

**Anomalia de atualização.** A editora do ISBN `978-01` mudou. É preciso alterar **todas** as linhas onde ele aparece. Esqueça uma e o banco passa a afirmar duas editoras para a mesma obra — sem que nada acuse o erro.

**Anomalia de exclusão.** Apague o empréstimo 2 e a obra "Algoritmos" **desaparece do sistema**. O único registro da existência dela era um empréstimo.

> 💡 As três têm a mesma causa: **a relação mistura fatos sobre coisas diferentes.** `EMPRESTIMO_TUDO` fala sobre empréstimos, sobre usuários e sobre obras ao mesmo tempo. Normalizar é separar os fatos, um assunto por relação.

**Normalização** é o processo de decompor relações para eliminar essas anomalias, sem perder informação. Cada **forma normal** é um nível de garantia.

## 2. Dependência funcional

`X → Y` (lê-se *X determina Y*) significa: **para cada valor de X existe um único valor de Y**.

```
matricula → nome, email          um valor de matrícula, um nome e um e-mail
isbn      → titulo, editora      um ISBN, um título e uma editora
tombo     → isbn                 um tombo pertence a uma obra
```

O que **não** é DF: `isbn → tombo`. Um ISBN tem vários exemplares, portanto vários tombos.

> ⚠️ **DF é uma afirmação sobre o mundo, não sobre os dados de hoje.** Se hoje não há dois usuários com o mesmo nome, isso **não** significa `nome → matricula`. A pergunta é se pode haver. Ler DFs a partir de uma amostra de dados é o erro que leva a modelos que quebram no primeiro caso repetido.

### Os três tipos que interessam

Seja `K` a chave primária:

**Dependência total** — `Y` depende de **toda** a chave. Numa chave `(isbn, id_autor)`, o atributo `ordem` depende dos dois: mudar qualquer um muda a ordem. É o que se quer.

**Dependência parcial** — `Y` depende de **parte** da chave composta. Em `ITEM_PEDIDO(num_pedido, cod_produto, quantidade, nome_produto)`, temos `cod_produto → nome_produto`: o nome do produto depende de **metade** da chave. É o que a 2FN elimina.

**Dependência transitiva** — `Y` depende de um atributo **não chave**, que por sua vez depende da chave: `K → A` e `A → Y`, logo `K → Y` indiretamente. Em `EXEMPLAR(tombo, isbn, titulo)`, `tombo → isbn → titulo`. É o que a 3FN elimina.

Um atributo é **primo** se pertence a alguma chave candidata. Não primo, se não pertence a nenhuma. O vocabulário é necessário para enunciar as formas normais com precisão.

## 3. 1FN — valores atômicos

Uma relação está na **primeira forma normal** quando todos os seus atributos são **atômicos**: nada de listas, nada de grupos repetidos, nada de campos multivalorados.

```
❌ NÃO está em 1FN                        ✅ Está em 1FN
┌───────────┬─────────────────────┐       USUARIO(matricula, nome)
│ matricula │     telefones       │       TELEFONE(matricula, numero)
├───────────┼─────────────────────┤                ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾
│  2023101  │ 3399-1111, 99999-01 │
└───────────┴─────────────────────┘
```

E a "solução" com colunas numeradas **também** viola o espírito da 1FN, criando um **grupo repetido**:

```
❌ USUARIO(matricula, nome, telefone1, telefone2, telefone3)
```

**Como normalizar:** o atributo multivalorado vira relação própria — exatamente a Regra 6 da Aula 10. Repare que **um modelo bem mapeado a partir de um bom DER já nasce em 1FN**: multivalorados já viraram tabelas no caminho.

> ⚠️ **A violação de 1FN mais comum hoje é o campo de texto com valores separados por vírgula.** Ele parece prático até você precisar de "quantos usuários têm telefone com DDD 19?" — que passa a ser uma busca de substring, incapaz de usar índice e cheia de falsos positivos.

## 4. 2FN — sem dependência parcial

Uma relação está na **segunda forma normal** quando está em 1FN **e** todo atributo não primo depende **totalmente** da chave primária.

Só é violável quando a chave é **composta**. Se a chave tem um atributo só, não há "parte da chave", e a relação está automaticamente em 2FN.

```
❌ ITEM_PEDIDO(num_pedido, cod_produto, quantidade, nome_produto, preco_tabela)
               ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾

   DFs:  (num_pedido, cod_produto) → quantidade      ✅ total
         cod_produto → nome_produto, preco_tabela    ❌ PARCIAL
```

O nome do produto não tem nada a ver com o pedido. Consequência: o nome se repete em toda linha de todo pedido daquele produto, e alterá-lo exige varrer tudo.

```
✅ ITEM_PEDIDO(num_pedido, cod_produto, quantidade)
   PRODUTO(cod_produto, nome_produto, preco_tabela)
```

> ⚠️ **Atenção ao caso `preco`.** Se o que se quer guardar é o **preço praticado na venda**, ele é do item e deve **ficar** em `ITEM_PEDIDO` — porque depende do par (pedido, produto), não só do produto. Retirá-lo faz o sistema reescrever o passado toda vez que o preço mudar. A 2FN não está sendo violada aqui: `preco_praticado` depende **totalmente** da chave. Distinguir `preco_tabela` de `preco_praticado` é uma decisão de modelagem, e a normalização não a toma por você.

## 5. 3FN — sem dependência transitiva

Uma relação está na **terceira forma normal** quando está em 2FN **e** nenhum atributo não primo depende de outro atributo não primo.

```
❌ EMPRESTIMO(id, matricula, nome_usuario, email, tombo, data_retirada)
              ‾‾

   DFs:  id → matricula, tombo, data_retirada       ✅
         matricula → nome_usuario, email            ❌ TRANSITIVA
```

`nome_usuario` depende de `matricula`, que não é chave. Logo `id → nome_usuario` é indireta. Consequência: o nome do usuário repete a cada empréstimo dele, e uma correção de grafia precisa alcançar todas as linhas.

```
✅ EMPRESTIMO(id, matricula, tombo, data_retirada)
   USUARIO(matricula, nome_usuario, email)
```

> 💡 **A regra mnemônica clássica:** *cada atributo não chave depende da chave (1FN e 2FN), da chave toda (2FN), e de nada além da chave (3FN).* Ela vale como lembrete rápido, não como definição — os enunciados formais acima é que valem em prova e em discussão.

**A 3FN é o alvo prático.** É a forma normal em que a maioria dos esquemas de produção fica, e ela já elimina praticamente todas as anomalias que aparecem no dia a dia.

## 6. BCNF — a 3FN levada a sério

A **forma normal de Boyce-Codd** exige que, em **toda** dependência funcional `X → Y` não trivial, `X` seja uma **superchave**.

É mais rigorosa que a 3FN, que permite uma exceção: a 3FN aceita `X → Y` quando `Y` é atributo **primo**. A BCNF não aceita.

A diferença só aparece num caso específico — quando há **múltiplas chaves candidatas compostas e sobrepostas**:

```
   ORIENTACAO(aluno, materia, professor)

   Regras do mundo:
     • cada professor ensina uma única matéria
     • um aluno, numa matéria, tem um único professor
     • uma matéria pode ter vários professores

   DFs:  (aluno, materia) → professor      ← chave candidata
         professor → materia               ← professor NÃO é superchave!
```

Está em 3FN (`materia` é atributo primo, pertence à chave `(aluno, materia)`). **Não** está em BCNF, porque `professor → materia` tem determinante que não é superchave.

O estrago prático: não é possível registrar que o professor Silva ensina Banco de Dados **antes** de ele ter um aluno. Anomalia de inserção, exatamente o que a normalização deveria ter eliminado.

```
✅ ENSINA(professor, materia)              professor é a chave
   CURSA(aluno, professor)                 (aluno, professor) é a chave
```

> ⚠️ **A BCNF tem um preço, e é preciso conhecê-lo:** a decomposição em BCNF nem sempre **preserva as dependências**. No exemplo acima, a DF `(aluno, materia) → professor` deixa de ser verificável numa tabela só — para garanti-la é preciso uma junção. Por isso, quando 3FN e BCNF conflitam, **é legítimo parar na 3FN** e documentar a decisão. Formas normais são ferramentas, não mandamentos.

## 7. Decomposição sem perda

Toda decomposição precisa satisfazer uma condição inegociável: **ao juntar as partes de volta, obtém-se exatamente a relação original** — nem mais, nem menos.

Uma decomposição de `R` em `R1` e `R2` é **sem perda** se os atributos comuns (`R1 ∩ R2`) formam **chave** de pelo menos uma das duas.

```
✅ SEM PERDA
   R(id, matricula, nome, tombo)
   → R1(id, matricula, tombo)  +  R2(matricula, nome)
   Comum: {matricula}, que é chave de R2. ✅

❌ COM PERDA
   R(aluno, disciplina, professor)
   → R1(aluno, disciplina)  +  R2(aluno, professor)
   Comum: {aluno}, que não é chave de nenhuma das duas. ❌
```

A decomposição com perda gera **tuplas espúrias** — combinações que não existiam:

```
   Original                   R1                    R2
   Ana | BD  | Silva          Ana | BD              Ana | Silva
   Ana | ALG | Costa          Ana | ALG             Ana | Costa

   R1 ⋈ R2 devolve QUATRO linhas:
      Ana | BD  | Silva   ✅ existia
      Ana | BD  | Costa   ❌ INVENTADA
      Ana | ALG | Silva   ❌ INVENTADA
      Ana | ALG | Costa   ✅ existia
```

Duas linhas de informação **falsa**, e nada no banco indica quais são as inventadas.

> 📏 **Regra do curso:** toda decomposição entregue vem com a verificação de perda escrita — quais são os atributos comuns e de qual relação eles são chave. Uma decomposição com perda é pior que a relação não normalizada, porque troca redundância por mentira.

## 8. Além da 3FN, e o caminho de volta

**4FN — dependência multivalorada.** Ocorre quando dois atributos multivalorados **independentes** convivem na mesma relação:

```
❌ PROFESSOR_INFO(professor, disciplina, telefone)
```

Se um professor tem 3 disciplinas e 2 telefones, a relação precisa de **6 linhas** para representar dois fatos independentes — e acrescentar um telefone obriga a acrescentar 3 linhas. A cura é separar em `LECIONA(professor, disciplina)` e `TELEFONE(professor, numero)`. A 4FN raramente é violada quando o modelo veio de um DER bem feito, porque cada multivalorado já virou tabela própria.

**5FN** existe, trata de dependências de junção, e é uma curiosidade acadêmica na prática.

**Desnormalização** é o caminho de volta: introduzir redundância **de propósito** para acelerar consultas. Guardar `total_do_pedido` em vez de somar os itens toda vez; guardar `nome_usuario` em `EMPRESTIMO` para evitar uma junção.

> ⚠️ **Desnormalizar é uma decisão de projeto físico (Aula 15), tomada com medição na mão, nunca por comodidade.** Ela custa: cada dado duplicado precisa de um mecanismo que o mantenha sincronizado — gatilho, rotina, ou disciplina da aplicação. Quem desnormaliza sem esse mecanismo não otimizou nada: apenas trocou lentidão por dado errado. **Normalize primeiro; desnormalize depois, se medir e provar.**

> 📖 A normalização e a teoria das dependências funcionais ocupam um capítulo próprio no livro-base, com o tratamento formal (fechamento de atributos, cobertura mínima, algoritmos de decomposição) que esta aula apresenta em nível operacional.

> 💻 **Modelos desta aula:** [`normalizacao.md`](exemplos/normalizacao.md)

## 🏋️ Exercícios da aula

Na pasta `aula-12/` do seu repositório:

1. **`ex01.md`** — para a relação abaixo, descreva as **três anomalias** com dados concretos: mostre um `INSERT` que não pode ser feito, um `UPDATE` que precisa alterar N linhas, e um `DELETE` que apaga informação não relacionada:

   ```
   CONSULTA(id_consulta, crm, nome_medico, especialidade, prontuario,
            nome_paciente, convenio, data, diagnostico)
   ```

2. **`ex02.md`** — para a mesma relação, liste **todas** as dependências funcionais, classifique cada uma em total, parcial ou transitiva, e identifique a chave primária. Justifique cada DF com uma frase sobre o mundo real — não sobre os dados;
3. **`ex03.md`** — normalize `CONSULTA` até a **3FN**, mostrando cada passo separadamente: (a) o estado em 1FN e por quê; (b) a decomposição para 2FN, com a DF parcial que a motivou; (c) a decomposição para 3FN, com a DF transitiva que a motivou. Ao final, liste as relações resultantes com PKs e FKs;
4. **`ex04.md`** — para cada decomposição, verifique se é **sem perda**, mostrando os atributos comuns e de qual relação são chave. Nas que tiverem perda, construa um exemplo com 3 tuplas mostrando as **tuplas espúrias** que a junção inventa:

   ```
   (a) VENDA(nf, produto, cliente, data) → V1(nf, produto) + V2(nf, cliente, data)
   (b) VENDA(nf, produto, cliente, data) → V1(nf, produto) + V2(produto, cliente)
   (c) FUNC(mat, nome, depto, chefe)     → F1(mat, nome, depto) + F2(depto, chefe)
   ```

5. **Desafio 🌶️ `ex05.md`** — construa uma relação que esteja em **3FN mas não em BCNF**, diferente do exemplo da aula. Entregue: (a) o esquema e as regras do mundo que geram as DFs; (b) a prova de que está em 3FN; (c) a prova de que não está em BCNF; (d) a anomalia concreta que isso permite; (e) a decomposição em BCNF; (f) **qual dependência deixa de ser preservada** e como você garantiria essa regra na prática. Termine recomendando parar na 3FN ou seguir até a BCNF, com argumento.

## 🧠 Revisão

[8 questões de múltipla escolha](revisao/README.md) para conferir se os conceitos ficaram sólidos. Responda sem consultar a aula — depois volte e corrija.

## ✅ Entrega

```bash
git add aula-12/
git commit -m "Resolve exercícios da aula 12 (normalização)"
git push
```

---

⬅️ [Aula 11](../aula-11-algebra-relacional/README.md) | ➡️ [Aula 13 — SQL DDL](../../bloco-4-sql-e-projeto-fisico/aula-13-sql-ddl/README.md)

🏁 **Fim do Bloco 3!** O modelo virou tabelas, as tabelas viraram um esquema sem redundância, e você sabe consultar formalmente. No Bloco 4 tudo isso finalmente **roda**: o esquema vira SQL, os dados entram, e você vê o banco defendendo cada restrição que você declarou.
