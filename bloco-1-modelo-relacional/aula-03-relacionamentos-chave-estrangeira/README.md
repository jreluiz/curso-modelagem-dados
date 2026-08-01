# Aula 03 — Relacionamentos e Chave Estrangeira

> 🎯 Objetivos: explicar como o modelo relacional liga duas tabelas por valor, decidir de que lado a chave estrangeira mora num 1:N e transformar um relacionamento N:M em tabela associativa.
> 🎬 Slides da aula: [apresentacao-03-relacionamentos-chave-estrangeira.pdf](apresentacao/apresentacao-03-relacionamentos-chave-estrangeira.pdf)

## 1. Duas tabelas que precisam se falar

Na Aula 01 você separou a planilha em três tabelas e ficou com uma coluna estranha:

```
   ALUNO                          EMPRESTIMO
   ┌───────────┬────────────┐     ┌───────────┬───────────┬────────────┐
   │ matricula │ nome       │     │ n_emprest │ matricula │ retirada   │
   ├───────────┼────────────┤     ├───────────┼───────────┼────────────┤
   │  2023101  │ Ana Souza  │◄────┤   1001    │  2023101  │ 2026-03-02 │
   │  2023102  │ Bruno Lima │◄────┤   1002    │  2023102  │ 2026-03-09 │
   └───────────┴────────────┘     └───────────┴───────────┴────────────┘
```

A coluna `matricula` em `EMPRESTIMO` não descreve o empréstimo. Ela **aponta** para uma linha de `ALUNO`. É esse apontar que faz o modelo relacional funcionar, e ele tem nome: **chave estrangeira**.

## 2. Chave estrangeira: ligação por valor

**Chave estrangeira** (FK, de *foreign key*) é um atributo cujo valor precisa existir na chave primária de outra tabela.

E repare no detalhe que muda tudo: a ligação é **por valor**, não por posição nem por endereço. Se `EMPRESTIMO.matricula` vale `2023101`, o empréstimo está ligado ao aluno de matrícula `2023101` — esteja essa linha onde estiver, tenha o banco reorganizado o disco quantas vezes quiser. Ninguém guarda "a terceira linha da tabela ALUNO".

Três regras, e elas não têm exceção:

- A FK referencia uma **chave primária ou candidata** da outra tabela — nunca uma coluna qualquer. `EMPRESTIMO.nome_aluno` apontando para `ALUNO.nome` é erro: nomes repetem;
- A FK tem o **mesmo domínio** do atributo referenciado. Se `matricula` é inteiro lá, é inteiro aqui;
- O valor da FK é **ou** um valor que existe do outro lado, **ou** vazio. Nunca um valor inventado.

> 💡 Uma FK pode apontar para a **própria** tabela. É estranho na primeira vez e comum na centésima — veja a seção 6.

> ⚠️ A partir daqui, "está ligado a" sempre quer dizer "tem uma coluna cujo valor aparece na chave primária do outro". Não existe outro mecanismo de ligação no modelo relacional. Uma seta que você desenhou e não virou coluna nenhuma **não existe** para o banco.

## 3. 1:N — o caso mais comum de todos

Antes de escrever qualquer coluna, faça **duas perguntas, nas duas direções**, sempre no plural:

> *Um aluno pode ter **vários** empréstimos?* → sim.
> *Um empréstimo pode pertencer a **vários** alunos?* → não, é de um só.

Um "sim" e um "não" dão um relacionamento **1:N** (um para muitos): um aluno, muitos empréstimos.

E agora a pergunta que decide o modelo: **de que lado mora a FK?**

```
   Tentativa errada:                    Tentativa certa:
   ALUNO(matricula, nome, n_emprest)    ALUNO(matricula, nome)
   ┌───────────┬───────┬────────────┐   EMPRESTIMO(n_emprest, matricula, retirada)
   │  2023101  │ Ana   │ 1001, 1002 │                        ↑ FK
   └───────────┴───────┴────────────┘   ✅ cabe um valor por célula
   ✗ dois valores numa célula
```

**A FK mora sempre do lado N** — do lado que tem *um só* do outro. Um empréstimo tem um aluno: a coluna `matricula` cabe na linha do empréstimo. Um aluno tem muitos empréstimos: não cabe uma coluna com muitos valores, porque **uma célula guarda um valor só** (é a propriedade que você viu na Aula 01, e a 1FN vai cobrar na Aula 07).

> ⚠️ **Teste de uma linha, para usar pelo resto do curso:** *"deste lado, quantos do outro cabem?"* Se a resposta for "vários", a FK **não** é aqui.

E a segunda pergunta, independente da primeira: **pode zero?** Um empréstimo sem aluno não faz sentido — então `EMPRESTIMO.matricula` é obrigatória. Já um aluno sem nenhum empréstimo é perfeitamente normal, e nada precisa ser declarado para isso.

> 💡 São duas perguntas separadas e as pessoas insistem em misturar: *quantos?* decide **onde a FK mora**; *pode zero?* decide se ela é **obrigatória**. Responda uma de cada vez.

## 4. 1:1 — e por que ele costuma ser suspeito

Quando as duas respostas são "não", o relacionamento é **1:1**. Um funcionário chefia uma unidade; uma unidade tem um chefe.

Aqui a FK pode ir para qualquer um dos dois lados — e é justamente por isso que 1:1 merece desconfiança. Duas perguntas antes de aceitar:

1. **Isto não é a mesma coisa partida em duas tabelas?** Se `PESSOA` e `DADOS_DA_PESSOA` sempre existem juntas e sempre na proporção de um para um, são uma tabela só;
2. **O "um" vale para sempre?** "Uma unidade tem um chefe" costuma virar "teve vários chefes ao longo do tempo" na primeira reunião com o cliente — e aí não era 1:1, era 1:N com data.

Quando o 1:1 sobrevive às duas perguntas, ponha a FK **do lado obrigatório**, ou do lado que participa menos:

```
UNIDADE(cod_unidade, nome, matricula_chefe)
        ‾‾‾‾‾‾‾‾‾‾‾              ↑ FK para FUNCIONARIO, UNIQUE
```

> ⚠️ Num 1:1 a FK precisa ser **única**, senão dois registros de um lado apontam para o mesmo do outro e o relacionamento vira 1:N sem ninguém perceber. É o mesmo `UNIQUE` da chave alternativa da Aula 02.

## 5. N:M e a tabela associativa

Quando as duas respostas são "sim", você tem um **N:M** (muitos para muitos):

> *Um aluno cursa **várias** disciplinas?* → sim.
> *Uma disciplina é cursada por **vários** alunos?* → sim.

E agora não existe lado onde a FK caiba. Se você puser `cod_disciplina` em `ALUNO`, um aluno só pode cursar uma. Se puser `matricula` em `DISCIPLINA`, a disciplina só tem um aluno. Os dois lados precisariam de muitos valores numa célula, e isso não existe.

A solução é uma **terceira tabela**:

```
   ALUNO                MATRICULA_DISCIPLINA              DISCIPLINA
   ┌───────────┬──────┐ ┌───────────┬──────────┬───────┐  ┌──────────┬───────────┐
   │ matricula │ nome │ │ matricula │ cod_disc │ nota  │  │ cod_disc │ nome      │
   ├───────────┼──────┤ ├───────────┼──────────┼───────┤  ├──────────┼───────────┤
   │  2023101  │ Ana  │◄┤  2023101  │ BD101    │  8.5  ├─►│ BD101    │ Banco...  │
   │  2023102  │ Bruno│◄┤  2023101  │ ES102    │  7.0  ├─►│ ES102    │ Eng. Soft.│
   └───────────┴──────┘ │  2023102  │ BD101    │  9.0  │  └──────────┴───────────┘
                        └───────────┴──────────┴───────┘
                          PK composta: (matricula, cod_disc)
```

Essa terceira tabela chama-se **tabela associativa**. Ela tem duas FKs — uma para cada lado — e a chave primária dela é justamente o par formado por elas. É a chave composta da Aula 02, aparecendo onde ela é obrigatória e não opcional.

> 💡 **O N:M vira sempre dois 1:N.** Olhe de novo o desenho: `ALUNO` tem muitas linhas na associativa, `DISCIPLINA` também. O N:M não desaparece — ele se decompõe em dois relacionamentos que o modelo sabe representar.

> 📏 **E aqui está o melhor motivo para gostar da tabela associativa:** ela é o único lugar do modelo onde cabe o atributo `nota`. A nota não é do aluno (ele tem várias) nem da disciplina (ela tem várias) — é **do par**. Toda vez que um dado só faz sentido para a combinação de dois, ele mora na associativa.

> ⚠️ O erro clássico: ler o relacionamento em uma direção só. *"Um pedido tem um produto"* parece verdade quando você imagina o pedido mais simples possível — e desmonta no primeiro pedido com dois itens. Leia **sempre** nas duas direções, **sempre** no plural.

## 6. Autorrelacionamento: a tabela que aponta para si mesma

Funcionários têm chefes, e chefes são funcionários. Não há duas tabelas — há uma, apontando para ela mesma:

```
   FUNCIONARIO
   ┌───────────┬────────────┬─────────────────┐
   │ matricula │ nome       │ matricula_chefe │
   ├───────────┼────────────┼─────────────────┤
   │    100    │ Marina     │      (vazio)    │  ← diretora, não tem chefe
   │    101    │ Ana Souza  │       100       │  ← reporta à Marina
   │    102    │ Bruno Lima │       101       │  ← reporta à Ana
   └───────────┴────────────┴─────────────────┘
```

`matricula_chefe` é uma FK que referencia `FUNCIONARIO.matricula` — a mesma tabela. Vale tudo que você já sabe: o valor precisa existir, e vazio é permitido (a diretora não tem chefe).

O mesmo padrão resolve categoria dentro de categoria, peça composta de peças, resposta de comentário. E, quando o autorrelacionamento é N:M — um nível de curso que exige vários pré-requisitos, cada um exigido por vários níveis —, vale a seção 5 sem mudança nenhuma: nasce uma tabela associativa com **duas FKs para a mesma tabela**, com nomes de coluna diferentes.

> 📖 O livro-base chama a FK de "chave estrangeira" e trata a ligação por valor como propriedade central do modelo. A decomposição do N:M em tabela associativa aparece no capítulo de mapeamento — que neste curso é a Aula 06.

## 🏋️ Exercícios da aula

Na pasta `aula-03/` do seu repositório:

1. **`ex01.md`** — para cada par abaixo, faça as duas perguntas no plural, escreva as duas respostas e classifique em 1:1, 1:N ou N:M: (a) `AUTOR` e `LIVRO`; (b) `CIDADE` e `ESTADO`; (c) `PACIENTE` e `PRONTUARIO`; (d) `MEDICO` e `CONSULTA`; (e) `ATOR` e `FILME`. Depois, para cada 1:N, diga **em qual tabela a FK vai morar**. *Confira assim: em todo 1:N que você marcou, a FK tem que estar do lado que tem "um só" do outro — releia o teste de uma linha da seção 3.*
2. **`ex02.md`** — o modelo abaixo está errado. `DEPARTAMENTO(cod_dep, nome, matricula_funcionario)` com a intenção de registrar que um departamento tem vários funcionários. Explique **o que acontece** quando o segundo funcionário entra no departamento, corrija o modelo e escreva os dois esquemas corrigidos. *Confira assim: no modelo corrigido, cadastrar o décimo funcionário do departamento não pode exigir alterar nenhuma linha de `DEPARTAMENTO`.*
3. **`ex03.md`** — uma escola precisa registrar quais alunos participam de quais projetos de extensão, guardando **a função de cada aluno no projeto** (bolsista, voluntário, coordenador) e a data de entrada. Modele: escreva os três esquemas, marque PKs e FKs e explique em uma linha por que a função e a data não podem morar em `ALUNO` nem em `PROJETO`. *Confira assim: tente colocar a função em `ALUNO` e descreva o que quebra quando o aluno entra num segundo projeto com outra função.*
4. **`ex04.md`** — modele um catálogo de categorias de produto em que uma categoria pode conter subcategorias, em qualquer profundidade (Eletrônicos → Áudio → Fones → Fones sem fio). Escreva o esquema, diga qual coluna é a FK e para onde ela aponta, e monte uma instância com pelo menos 5 linhas cobrindo três níveis. *Confira assim: a categoria do topo precisa ter a FK vazia, e nenhuma linha pode apontar para si mesma.*
5. **Desafio 🌶️ `ex05.md`** — a biblioteca quer registrar **reservas**: um usuário reserva uma obra, entra numa fila e é avisado quando um exemplar é devolvido. Modele isso sabendo que (a) o mesmo usuário pode reservar várias obras, (b) a mesma obra pode ser reservada por vários usuários, (c) a **ordem da fila** importa e (d) o mesmo usuário pode reservar a mesma obra outra vez, meses depois, se desistiu na primeira. Escreva o esquema completo e defenda a chave primária que você escolheu para a associativa — o item (d) provavelmente quebra a escolha óbvia. *Confira assim: monte uma instância que satisfaça (d) e verifique se a sua chave aceita as duas linhas.*

## 🧠 Revisão

[8 questões de múltipla escolha](revisao/README.md) para conferir se os conceitos ficaram sólidos. Responda sem consultar a aula — depois volte e corrija.

## ✅ Entrega

```bash
git add aula-03/
git commit -m "Resolve exercícios da aula 03 (relacionamentos e chave estrangeira)"
git push
```

---

⬅️ [Aula 02](../aula-02-chaves/README.md) | ➡️ [Aula 04 — Integridade e o valor nulo](../aula-04-integridade-e-nulo/README.md)
