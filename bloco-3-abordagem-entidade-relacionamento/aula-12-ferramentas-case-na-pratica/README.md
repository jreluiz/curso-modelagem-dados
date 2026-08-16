# Aula 12 — Ferramentas CASE na Prática

> 🎯 Objetivos: situar as ferramentas CASE na história do software, escolher uma para o tipo de modelo que você faz e revisar criticamente o esquema que a conversão automática produz.
> 🎬 Slides da aula: [apresentacao-12-ferramentas-case-na-pratica.pdf](apresentacao/apresentacao-12-ferramentas-case-na-pratica.pdf)

## 1. De onde vieram

Nos anos 70, projetos de software começaram a atrasar e estourar orçamento com uma regularidade que ganhou nome: *crise do software*. Uma das respostas foi automatizar o próprio trabalho de projetar — daí **CASE**, *Computer-Aided Software Engineering*.

A família se dividiu cedo, e a divisão ainda organiza o mercado:

| Categoria | Cobre | Exemplo do que faz |
|---|---|---|
| **Upper CASE** | análise e projeto | desenhar o DER, o diagrama de classes, o dicionário de dados |
| **Lower CASE** | implementação e manutenção | gerar o esquema do banco, depurar, documentar código |
| **I-CASE** (integrada) | o ciclo inteiro | manter modelo e implementação em sincronia |

Os anos 90 prometeram que a ferramenta geraria o sistema inteiro a partir do modelo, e a promessa não se cumpriu. O que sobrou é modesto e útil: **desenho, verificação de consistência, conversão entre níveis e engenharia reversa** — esta última partindo de um banco que já existe para produzir o modelo correspondente, que é como se documenta sistema herdado.

> 💡 A ferramenta que você vai usar no resto do curso é *upper* CASE. Ela para exatamente onde este curso para: no modelo lógico.

Duas lições dessa história valem mais que os nomes das categorias:

- **A ferramenta nunca substituiu a decisão.** A promessa dos anos 90 falhou justamente na parte que exigia entender o negócio — e essa parte continua sendo entrevista, leitura e discussão, como no Bloco 1;
- **O que sobreviveu foi o que economiza trabalho repetitivo.** Redesenhar um diagrama à mão a cada mudança, converter cinquenta entidades em tabelas, conferir se toda ligação tem cardinalidade: aí a máquina ganha de longe.

## 2. As ferramentas de hoje

| Ferramenta | Notação | Onde brilha | Custo |
|---|---|---|---|
| **brModelo** | **Chen** e conversão para lógico | ensino e a notação deste curso; é brasileira | gratuita |
| **draw.io** | livre, com estêncil de ER | rascunho rápido, funciona no navegador | gratuita |
| **MySQL Workbench** | pé-de-galinha | modelar já pensando na implantação | gratuita |
| **Oracle SQL Developer Data Modeler** | pé-de-galinha e Barker | projetos grandes, versionamento de modelo | gratuita |
| **erwin Data Modeler** | pé-de-galinha | padrão corporativo, governança de dados | paga |
| **Astah / Visual Paradigm** | UML | quando o documento principal é o diagrama de classes | paga, com versão de estudante |

**Este curso adota o brModelo** por um motivo prático: é a única gratuita que desenha em **Chen** — a notação das Aulas 06 a 11 — e ainda converte para o modelo lógico. O `draw.io` fica como alternativa web quando você não puder instalar nada.

> ⚠️ **Ferramenta não é notação.** Trocar de ferramenta é aprender menus; trocar de notação é aprender a ler outro diagrama. O que você aprendeu no Bloco 2 vale nas seis linhas da tabela — o que muda é onde fica o botão. Comece pelo modelo, não pelo *download*.

## 3. O roteiro no brModelo

O guia de instalação está em [`recursos/ambiente.md`](../../recursos/ambiente.md). Com a ferramenta aberta, o roteiro é o mesmo da Aula 09 — e é bom que seja:

```
   1. ENTIDADES        arraste um retângulo por entidade. Nomeie em
                       MAIÚSCULAS e no singular, como no curso.

   2. ATRIBUTOS        clique na entidade e acrescente. Marque o
                       identificador — a ferramenta sublinha sozinha.

   3. RELACIONAMENTOS  arraste o losango e ligue às duas entidades.
                       Nomeie com verbo.

   4. CARDINALIDADE    clique na linha e escolha (1,1), (1,n), (0,n).
                       ⚠️ a ferramenta usa o par (min,max) — ver abaixo.

   5. CONVERSÃO        Ferramentas → Converter para lógico.
                       A ferramenta aplica as regras da Aula 07.

   6. REVISÃO          o passo que ninguém faz, e é a seção 4.
```

> ⚠️ **A ferramenta escreve a cardinalidade no formato `(min,max)`**, e ele **não** é o do curso. O par `(1,n)` colocado ao lado de uma entidade diz quantas vezes **cada ocorrência dela** participa do relacionamento — e isso joga o "muitos" para o lado oposto:

```
   O curso   [EDITORA] ──1──  {PUBLICA}  ──N── [LIVRO]
                                           ↑ o "muitos" fica junto de LIVRO

   brModelo  [EDITORA] ─(1,n)─ {PUBLICA} ─(1,1)─ [LIVRO]
                         ↑ o "muitos" fica junto de EDITORA
```

Os dois desenhos afirmam **o mesmo fato** — *"uma editora publica muitos livros"* — com os símbolos espelhados. Ao transportar um diagrama do caderno para a ferramenta, confira relacionamento por relacionamento lendo a frase em voz alta. Se a frase continuar verdadeira, está certo, seja qual for o símbolo.

## 4. O que a conversão automática entrega

A conversão é útil e é rascunho. Este é um esquema típico saído da ferramenta, a partir do DER da biblioteca:

```
   USUARIO(id_usuario, nome, email)
   LIVRO(id_livro, titulo, ano, id_editora)
   EXEMPLAR(id_exemplar, situacao, id_livro)
   EMPRESTIMO(id_emprestimo, data_retirada, id_usuario, id_exemplar)
```

Funciona. E tem **quatro coisas para revisar**, todas conhecidas do Bloco 2:

| O que a ferramenta fez | Por que revisar |
|---|---|
| criou `id_exemplar` como chave própria | o `EXEMPLAR` era **entidade fraca** — a chave natural é `(isbn, numero_ex)`. Decida qual das duas você quer, e escreva por quê |
| trocou `isbn` por `id_livro` | a ferramenta prefere chave artificial em tudo. `isbn` já identificava e é o que o bibliotecário usa |
| não declarou nenhuma política de exclusão | recusar, propagar ou anular é decisão do modelo (Aula 07, seção 5). A ferramenta deixa tudo no padrão dela |
| não disse o que aceita vazio | a participação total do diagrama tinha essa informação, e ela se perdeu na tradução |

### Quando a ferramenta não tem a construção

Duas coisas do Bloco 2 e 3 costumam faltar, e há saída conhecida para as duas:

- **Agregação.** Poucas ferramentas desenham o retângulo em volta do losango. A saída é a da Aula 08: desenhe a **entidade associativa** no lugar — `RESERVA` com chave própria — e registre numa decisão que aquilo era uma agregação no conceitual. O esquema gerado fica igual; o que se perde é a intenção, e é por isso que ela vai por escrito;
- **Especialização.** Quando a ferramenta não tem o círculo `d`/`o`, desenhe a superclasse e as subclasses como entidades ligadas por relacionamentos `1:1` de participação total, e escreva ao lado qual das quatro combinações da Aula 11 é. Na conversão, escolha à mão uma das três estratégias de tabela.

> 💡 **Isso não é gambiarra — é a diferença entre o modelo e a ferramenta.** O modelo é o que você decidiu; a ferramenta é onde você o desenha. Quando a segunda não alcança o primeiro, quem cede é o desenho, nunca a decisão — e a decisão fica no texto, onde nenhuma limitação de menu a apaga.

> ⚠️ **Chave artificial em toda tabela é a opinião da ferramenta, não uma regra do modelo relacional.** Ela é conveniente para quem programa e custa uma coisa concreta: o esquema deixa de dizer quem identifica a linha **no mundo**. Se você aceitar, aceite **por escrito** — e mantenha a chave natural como chave alternativa.

## 5. Estudo de caso: da ferramenta ao esquema revisado

O mesmo esquema, depois da revisão de dez minutos:

```
   USUARIO(matricula, nome, email)
   EDITORA(cnpj, nome, cidade)
   LIVRO(isbn, titulo, ano, cnpj → EDITORA)
   EXEMPLAR(isbn → LIVRO, numero_ex, situacao)
   EMPRESTIMO(numero, data_retirada, data_devolucao,
              matricula → USUARIO, isbn + numero_ex → EXEMPLAR)
```

E o registro do que foi decidido na revisão, no formato da Aula 09:

```
   D-05  As chaves naturais foram mantidas (matricula, isbn, cnpj).
         Alternativa descartada: as chaves artificiais geradas pela
                  ferramenta (id_usuario, id_livro, id_editora).
         Por quê: as três já identificam no mundo, são estáveis e são
                  o que aparece no balcão. Chave artificial entraria
                  se alguma delas mudasse com frequência.

   D-06  Apagar LIVRO propaga para EXEMPLAR; apagar EDITORA é recusado.
         Por quê: exemplar é entidade fraca; obra sem editora, não.
```

A revisão inteira cabe em seis perguntas, e é o que você aplica em qualquer conversão, de qualquer ferramenta:

```
   1. As chaves são as que identificam no mundo?
   2. A entidade fraca continuou fraca?
   3. As chaves estrangeiras estão do lado N?
   4. O que não aceita vazio está marcado?
   5. As políticas de exclusão foram escolhidas, uma por ligação?
   6. As regras que não viraram desenho estão na lista?
```

Nenhuma delas é sobre a ferramenta. Todas são do Bloco 2 — o que a ferramenta fez foi acelerar o rascunho, e o rascunho ainda precisa passar pelo mesmo crivo de sempre.

> 💡 **O trabalho não é desenhar — é decidir.** A ferramenta faz o desenho em minutos e a conversão em um clique. As duas decisões acima levaram mais tempo que tudo isso junto, e são elas que alguém vai ler daqui a dois anos.

> 💻 **Modelos desta aula:** [`roteiro-brmodelo.md`](exemplos/roteiro-brmodelo.md) — o roteiro completo com o checklist de revisão da conversão, para usar em qualquer modelo.

## 6. O que fecha o Bloco 3

Você entrou neste bloco sabendo desenhar um DER e sai sabendo **conduzir** uma modelagem: escolher por onde começar (Aula 09), apresentar o modelo a dois públicos (Aula 09), traduzi-lo para a notação de quem programa (Aula 10), tratar tipos e subtipos sem repetir atributo (Aula 11) e operar a ferramenta sem ser operado por ela (esta aula).

O que falta é o assunto do Bloco 4: o modelo pode estar bem desenhado, bem documentado, feito em ferramenta — **e ainda guardar o mesmo dado em dois lugares**. A cura tem regra escrita, e é a normalização.

## 🏋️ Exercícios da aula

Na pasta `aula-12/` do seu repositório:

1. **`ex01.md`** — a conversão automática de um modelo de eventos produziu o esquema abaixo. Aponte **quatro coisas a revisar**, dizendo em cada uma o que você faria e por quê:

   ```
   PESSOA(id_pessoa, nome, email)
   EVENTO(id_evento, titulo, carga_horaria, id_sala)
   SALA(id_sala, capacidade)
   INSCRICAO(id_inscricao, data_inscricao, id_pessoa, id_evento)
   ```

   *Confere assim: duas das quatro estão na tabela da seção 4 e valem para qualquer conversão; as outras duas você encontra comparando este esquema com o modelo da Aula 09 — uma delas é uma regra de negócio que sumiu.*

2. **`ex02.md`** — escolha a ferramenta para cada situação, justificando em duas linhas com a tabela da seção 2: (a) você vai desenhar em Chen o modelo da biblioteca para entregar no seu repositório do curso; (b) a equipe precisa documentar um banco que já está em produção, sem modelo nenhum; (c) você está num laboratório onde não pode instalar programas e tem 20 minutos para rascunhar um DER. *Confere assim: uma das três respostas não é sobre desenhar, é sobre **engenharia reversa** — e ela está na seção 1.*

3. **`ex03.md`** — **exercício autoral.** Escolha um minimundo do [catálogo](../../recursos/minimundos.md) marcado como "a partir do Bloco 3" — E-commerce, Congresso científico ou Hospital — e entregue o projeto conceitual completo, agora com o que o bloco acrescentou: (i) as **regras numeradas**; (ii) o **DER em Mermaid**, incluindo **pelo menos uma especialização** classificada nos dois eixos; (iii) o **esquema lógico**; (iv) **dois registros de decisão** no formato da Aula 09, sendo um deles sobre a especialização. *Confere assim: no Congresso científico e no Hospital, a especialização que parece óbvia é uma armadilha — um dos dois pede papel, não subtipo, e a sua decisão precisa dizer qual dos três testes da Aula 11 você aplicou.*

### 📤 Entrega

Estes exercícios são feitos em sala e vão para o **seu repositório** `exercicios-modelagem-dados`:

```bash
cd ..                 # da pasta da aula para a raiz do repositório
git add aula-12/
git commit -m "Resolve exercícios da aula 12"
git push
```

Confira no navegador que a pasta apareceu em `github.com/SEU-USUARIO/exercicios-modelagem-dados`.

## 🧠 Revisão

[8 questões de múltipla escolha](revisao/README.md) para conferir se os conceitos ficaram sólidos. Responda sem consultar a aula — depois volte e corrija.

---

⬅️ [Aula 11 — Especialização, Generalização e as Ferramentas](../aula-11-especializacao-e-generalizacao/README.md) | ➡️ [Aula 13 — Por que Normalizar](../../bloco-4-normalizacao-de-dados/aula-13-por-que-normalizar/README.md)
