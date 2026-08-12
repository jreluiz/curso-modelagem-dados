# Aula 04 — Requisitos, OLTP e OLAP

> 🎯 Objetivos: fazer as perguntas que revelam a estrutura de um banco, distinguir carga OLTP de carga OLAP e decidir qual delas um sistema exige.
> 🎬 Slides da aula: [apresentacao-04-requisitos-oltp-e-olap.pdf](apresentacao/apresentacao-04-requisitos-oltp-e-olap.pdf)

## 1. Levantar requisitos é fazer perguntas

Na Aula 03 você decidiu se `SITUACAO` era entidade ou atributo. Só que essa decisão não se toma no papel: toma-se **perguntando a quem conhece o assunto**.

**Levantamento de requisitos** é a etapa em que você descobre o que o banco precisa guardar, conversando com quem vai usá-lo. É a etapa 1 do processo, e é a única que acontece inteiramente em português.

O bibliotecário diz: *"o aluno pega o livro e devolve em quinze dias"*. Uma frase, e ela deixa quase tudo em aberto. Quatro perguntas revelam a estrutura escondida:

- **Quantos?** Um aluno pode ter vários empréstimos ao mesmo tempo? Um exemplar pode estar em dois empréstimos? → decide a cardinalidade;
- **Pode zero?** Existe empréstimo sem aluno? Aluno sem nenhum empréstimo? → decide o que é obrigatório;
- **Precisa do histórico?** Quando o livro é devolvido, o empréstimo some ou fica registrado? → decide se o dado é apagado ou preservado;
- **Quem pode ver?** O aluno consulta os empréstimos dos colegas? → decide a política de segurança da Aula 02.

> ⚠️ **"Quantos" e "pode zero" são duas perguntas, não uma.** Um empréstimo tem no máximo um aluno (quantos) **e** obrigatoriamente um aluno (não pode zero). São afirmações diferentes sobre o mundo, e cada uma vira uma coisa diferente no diagrama. Fazer as duas juntas é como se perde metade da informação numa entrevista.

> 💡 A pergunta mais produtiva de todas não está na lista: **"me dá um exemplo de quando isso deu errado?"** As exceções que o cliente lembra são exatamente as regras que ele esqueceu de contar.

## 2. De onde vêm os requisitos

Quatro fontes, e cada uma esconde alguma coisa:

| Fonte | O que dá bem | O que esconde |
|---|---|---|
| **Entrevista** | as regras que a pessoa sabe explicar | o que ela faz sem perceber que faz |
| **Documento** (formulário, relatório, planilha) | os campos que existem de verdade | por que existem, e quais já não se usam |
| **Sistema legado** | o comportamento real, testado por anos | as decisões erradas, que você copiaria junto |
| **Observação** | o passo que ninguém conta | leva tempo, e a pessoa muda de comportamento quando observada |

> 💡 Nenhuma das quatro basta sozinha. O formulário de empréstimo da biblioteca tem um campo "observação" que o bibliotecário nunca mencionou na entrevista — e é lá que ele anota quando o livro voltou danificado. Isso é uma regra de negócio inteira, escondida num campo de texto livre.

## 3. A primeira bifurcação: operar ou analisar?

Antes de desenhar qualquer coisa, há uma pergunta que muda todo o resto do projeto: **este banco existe para operar o dia a dia, ou para analisar o que já aconteceu?**

Compare os dois pedidos que a biblioteca faz:

```
   "Preciso registrar o empréstimo         "Preciso saber quais assuntos foram
    enquanto o aluno espera no balcão."     mais procurados nos últimos 5 anos,
                                             por curso e por período do ano."

   → uma operação, agora, rápida            → uma pergunta sobre milhões de
   → escreve pouca coisa                       empréstimos já encerrados
   → precisa estar certa na hora            → lê muito, não escreve nada
                                             → pode demorar alguns segundos
```

São necessidades tão diferentes que receberam nomes próprios, e é comum uma instituição ter as duas — em bancos separados.

## 4. OLTP — o banco que opera

**OLTP** (*On-Line Transaction Processing*) é o banco do dia a dia: o que registra empréstimos, matrículas, vendas, pagamentos.

- **Muitas operações curtas.** Centenas por minuto, cada uma mexendo em poucas linhas;
- **Escrita frequente.** Insere, atualiza, corrige;
- **Dado atual.** Interessa o estado de agora: este exemplar está emprestado ou não;
- **Modelo normalizado.** Cada dado num lugar só — é o que impede a contradição da Aula 01;
- **Precisa estar certo na hora.** O aluno está no balcão esperando.

Aqui "transação" quer dizer **uma operação completa de negócio** — registrar um empréstimo é uma transação. É desse volume de operações curtas que vem o nome.

## 5. OLAP — o banco que analisa

**OLAP** (*On-Line Analytical Processing*) é o banco das perguntas: relatórios, tendências, comparações ao longo do tempo.

- **Poucas consultas, cada uma pesada.** Uma pergunta pode varrer anos de dados;
- **Leitura quase pura.** Os dados entram em carga programada, não a cada operação;
- **Dado histórico.** Interessa a série inteira, inclusive o que já foi encerrado;
- **Modelo desnormalizado de propósito.** Aceita-se repetir dado para não ter que juntar dezenas de tabelas a cada relatório;
- **Pode demorar.** Ninguém está no balcão esperando um relatório anual.

Aparece aqui uma palavra nova: **granularidade** — o nível de detalhe em que o dado é guardado. Um banco analítico pode guardar cada empréstimo, ou já guardar os totais por mês. Quanto mais grosso o grão, mais rápido o relatório e menos perguntas ele consegue responder.

> ⚠️ **Desnormalizar num banco OLAP é decisão consciente, não descuido.** Ela só é legítima porque o dado analítico **não é alterado** — ele é carregado uma vez e lido muitas. A anomalia de alteração da Aula 01 não acontece onde ninguém altera. Copiar essa decisão para um banco OLTP é o erro que a Aula 01 inteira existe para prevenir.

## 6. Cenários e a convivência

| | OLTP | OLAP |
|---|---|---|
| **Pergunta típica** | "este exemplar está disponível?" | "quais assuntos cresceram em 5 anos?" |
| **Operações** | muitas e curtas | poucas e longas |
| **Predomina** | escrita | leitura |
| **Recorte do tempo** | o estado de agora | a série histórica |
| **Modelo** | normalizado | desnormalizado |

Na prática, a mesma instituição tem os dois, e eles conversam: o banco OLTP registra o dia a dia, e periodicamente uma carga leva esses dados para o banco OLAP, onde as perguntas analíticas são feitas.

O motivo de separar é concreto: um relatório de cinco anos rodando no banco do balcão deixaria o atendimento lento justamente no horário de pico. Bancos diferentes para necessidades diferentes.

> ⚠️ **OLTP e OLAP não são tecnologias, são cargas de trabalho.** Não existe "instalar um OLAP" — o mesmo SGBD da Aula 02 serve aos dois, com modelagens diferentes. Tratá-los como produtos é a confusão mais comum do tópico.

## 7. O que fazer com as respostas

Perguntar é metade. A outra metade é **escrever** — porque o que não foi escrito vira lembrança, e lembrança de duas pessoas nunca é a mesma.

Cada resposta do cliente vira uma frase curta, afirmativa e verificável. Compare:

```
   O QUE O CLIENTE DISSE                    O QUE VOCÊ ESCREVE

   "O aluno pega o livro e devolve     →   RN-01. Um empréstimo refere-se a
    em quinze dias."                          exatamente um exemplar e a
                                              exatamente um aluno.
                                          RN-02. Um aluno pode ter vários
                                              empréstimos simultâneos.
                                          RN-03. O prazo padrão é de 15 dias,
                                              contados da retirada.
                                          RN-04. O empréstimo devolvido é
                                              mantido no histórico.
```

Uma frase do cliente virou quatro regras numeradas. Três coisas para reparar:

- **Cada regra afirma uma coisa só**, e dá para responder "verdadeiro ou falso" a cada uma na frente do cliente;
- **Elas ganham número** (`RN-01`), porque você vai precisar apontar para uma delas quando alguém perguntar por que o modelo ficou daquele jeito;
- **A RN-04 não estava na fala.** Ela apareceu porque alguém perguntou *"e quando devolve, some?"*. Requisito não levantado não é requisito ausente — é requisito que vai aparecer tarde.

> 💡 Essa lista numerada acompanha o modelo até o fim do projeto. No Bloco 2, quando você desenhar o diagrama, cada linha dele vai poder ser justificada apontando para uma dessas regras — e o que não puder é invenção sua.

> ⚠️ **Nem toda regra cabe no diagrama, e tudo bem.** "O prazo é de 15 dias" não vira desenho nenhum: fica na lista, em texto. Perder a informação porque ela não tem símbolo é pior do que ter duas formas de registro.

> 📖 O Guimarães trata OLTP e OLAP na parte de aplicações de banco de dados. O Heuser foca no projeto do banco operacional, que é o caminho deste curso do Bloco 2 em diante.

## 🏋️ Exercícios da aula

Na pasta `aula-04/` do seu repositório:

1. **`ex01.md`** — o bibliotecário disse: *"O aluno reserva um livro que está emprestado e a gente avisa quando volta. Se ele não vier buscar, passa para o próximo da fila."* Escreva **seis perguntas** de levantamento que essa frase deixa sem resposta, usando as quatro perguntas da seção 1 como guia. *Confere assim: pelo menos duas das suas seis perguntas precisam ser sobre obrigatoriedade ou sobre histórico — se todas forem "quantos", você usou uma pergunta só.*

2. **`ex02.md`** — classifique cada cenário em **OLTP** ou **OLAP** e justifique em uma linha, citando **qual dimensão** da tabela da seção 6 decidiu: (a) registrar a devolução de um exemplar no balcão; (b) descobrir o mês de maior movimento dos últimos três anos; (c) consultar se um aluno tem multa em aberto; (d) comparar o uso do acervo entre dois campi desde 2020; (e) renovar um empréstimo pelo aplicativo; (f) listar as obras que nunca foram emprestadas desde a compra. *Confere assim: são três de cada. Um dos seis é discutível — se você discordar, escreva por quê, que a justificativa vale mais que a resposta.*

3. **`ex03.md`** — **exercício autoral.** Escolha um minimundo de dificuldade ⭐ do [catálogo](../../recursos/minimundos.md) — Videolocadora ou Clínica veterinária —, leia-o duas vezes e entregue: **oito perguntas** de levantamento que você faria ao cliente, e **uma decisão** dizendo se o banco desse sistema é OLTP, OLAP ou os dois, com a justificativa. *Confere assim: as oito perguntas precisam ser sobre o minimundo que você escolheu, não sobre a biblioteca — e a decisão OLTP/OLAP precisa dizer **quem** vai usar o sistema e **para quê**, não só repetir as características da aula.*

## 🧠 Revisão

[8 questões de múltipla escolha](revisao/README.md) para conferir se os conceitos ficaram sólidos. Responda sem consultar a aula — depois volte e corrija.

## ✅ Entrega

```bash
git add aula-04/
git commit -m "Resolve exercícios da aula 04 (requisitos, OLTP e OLAP)"
git push
```

---

⬅️ [Aula 03 — Os Elementos de um Banco de Dados](../aula-03-elementos-de-um-banco/README.md) | ➡️ [Aula 05 — Projeto de Banco de Dados: Conceitual, Lógico e Físico](../../bloco-2-modelos-de-banco-de-dados/aula-05-projeto-conceitual-logico-fisico/README.md)
