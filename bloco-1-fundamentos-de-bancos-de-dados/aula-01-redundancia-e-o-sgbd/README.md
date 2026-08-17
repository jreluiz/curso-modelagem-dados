# Aula 01 — A Redundância e a Resposta do SGBD

> 🎯 Objetivos: reconhecer a redundância numa planilha real, nomear as três anomalias que ela produz e explicar o que um banco de dados e um SGBD fazem que uma planilha não faz.
> 🎬 Slides da aula: [apresentacao-01-redundancia-e-o-sgbd.pdf](apresentacao/apresentacao-01-redundancia-e-o-sgbd.pdf)

## 1. A planilha que se contradiz

A biblioteca da faculdade controla os empréstimos numa planilha. Uma linha por empréstimo, e todo mundo entende:

```
┌───────────┬───────────┬────────────┬───────┬───────────────────────┬────────────┐
│ n_emprest │ matricula │ nome_aluno │ tombo │ titulo_livro          │ retirada   │
├───────────┼───────────┼────────────┼───────┼───────────────────────┼────────────┤
│   1001    │  2023101  │ Ana Souza  │ 4417  │ Banco de Dados        │ 2026-03-02 │
│   1002    │  2023101  │ Ana Souza  │ 4418  │ Engenharia de Software│ 2026-03-02 │
│   1003    │  2023102  │ Bruno Lima │ 4417  │ Banco de Dados        │ 2026-03-09 │
│   1004    │  2023101  │ Ana Sousa  │ 4420  │ Redes de Computadores │ 2026-03-11 │
└───────────┴───────────┴────────────┴───────┴───────────────────────┴────────────┘
```

Funciona — até a linha 1004, onde alguém digitou **Ana Sousa** com S. Agora a planilha afirma duas coisas diferentes sobre a matrícula 2023101, e nenhum programa do mundo sabe qual delas é a verdade.

O erro de digitação não é o problema. O problema é que **o nome da Ana está escrito três vezes**.

> 💡 Conte quantas vezes "Banco de Dados" aparece nessas quatro linhas. Agora imagine mil empréstimos — e imagine que o título foi cadastrado errado desde o começo.

## 2. Redundância: o dado escrito duas vezes

**Redundância** é o mesmo dado armazenado em mais de um lugar. Na planilha acima ela aparece três vezes: o nome do aluno, o título do livro e — de forma menos óbvia — a associação entre matrícula e nome.

Todo dado repetido é uma oportunidade de discordar de si mesmo, e alguém sempre aproveita. Não é questão de disciplina da equipe: com volume suficiente, a contradição é inevitável.

Vale separar duas coisas que se confundem:

- **Repetição legítima:** a matrícula 2023101 aparecer em três empréstimos. Isso é *referência* — são três empréstimos diferentes da mesma pessoa, e a informação é essa;
- **Redundância:** o **nome** "Ana Souza" aparecer três vezes. O nome não é informação sobre o empréstimo; é informação sobre o aluno, copiada para dentro dele.

> ⚠️ A pergunta que separa as duas: **"se isto mudar, quantos lugares eu preciso alterar?"** Se a resposta for "mais de um", é redundância.

## 3. As três anomalias

Repetir dado não é só desperdiçar espaço. A repetição produz três problemas com nome próprio, e você vai reencontrar os três no Bloco 4, quando eles ganharem uma cura com regra escrita.

**Anomalia de alteração.** A Ana mudou de nome. Quantas linhas você precisa alterar? Todas as dela. Se esquecer uma, a planilha passa a ter duas Anas — que é exatamente o estado em que ela já está.

**Anomalia de inserção.** Chegou um livro novo, ainda não emprestado por ninguém. Onde você guarda o título dele? Não há linha para isso: a planilha só sabe falar de empréstimos. Para cadastrar o livro, você teria que inventar um empréstimo falso.

**Anomalia de exclusão.** O empréstimo 1004 foi cancelado e você apaga a linha. Junto com ela some a única menção ao livro 4420. O livro continua na prateleira; o registro dele, não.

As três em uma tabela, para consultar depois:

| Anomalia | Quando aparece | O que dá errado |
|---|---|---|
| **Alteração** | ao mudar um dado repetido | algumas cópias mudam, outras não — e a base passa a se contradizer |
| **Inserção** | ao cadastrar algo que ainda não tem par | não há onde guardar, a não ser inventando um registro falso |
| **Exclusão** | ao apagar um registro | some junto uma informação que ninguém pediu para apagar |

> ⚠️ Repare no padrão: os três problemas têm a mesma causa. **A planilha guarda coisas de naturezas diferentes na mesma linha.** Aluno, livro e empréstimo são três assuntos, amontoados em um.

## 4. O que é um banco de dados

A saída para os três problemas é separar os assuntos e guardar cada um uma vez só, com alguma coisa ligando-os. Isso já é um banco de dados.

**Banco de dados** é uma coleção de dados **relacionados entre si**, com **significado**, organizada para servir a **vários usuários e vários programas** ao mesmo tempo.

Cada pedaço dessa frase exclui alguma coisa:

- **relacionados entre si** — uma pasta com fotos e boletos não é banco de dados. Não há relação entre eles;
- **com significado** — os dados representam um recorte do mundo real, e é esse recorte que decide o que entra. A biblioteca guarda o ISBN do livro, não a cor da capa;
- **vários usuários e vários programas** — é o que separa banco de dados de "arquivo do meu programa". O dado existe independentemente de quem o consulta.

> 💡 A planilha da seção 1 falha nos três critérios ao mesmo tempo, e é por isso que ela quebra em três lugares diferentes.

## 5. O que é um SGBD

Separar os assuntos resolve a estrutura, mas não resolve quem **cuida** dela. Quem impede que alguém digite uma matrícula que não existe? Quem garante que duas pessoas emprestando ao mesmo tempo não se atropelem? Quem devolve os dados se a energia cair no meio da operação?

**SGBD — Sistema Gerenciador de Banco de Dados** — é o programa que fica **entre você e os dados**. Você nunca abre o arquivo: você pede ao SGBD, e ele é o único que mexe.

```
    você / o programa
           │
           ▼
    ┌─────────────┐
    │    SGBD     │  ← recebe pedidos, verifica regras, controla quem mexe
    └─────────────┘
           │
           ▼
    ┌─────────────┐
    │   os dados  │  ← ninguém toca aqui diretamente
    └─────────────┘
```

Essa camada única no meio é a ideia inteira. Como todo acesso passa por um lugar só, é possível verificar regra, controlar simultaneidade e registrar o que aconteceu — coisas impossíveis quando cada programa abre o arquivo por conta própria.

> ⚠️ **Banco de dados, SGBD e aplicação são três coisas.** O banco são os dados; o SGBD é o programa que os gerencia (PostgreSQL, MySQL, Oracle); a aplicação é o sistema da biblioteca que conversa com o SGBD. Dizer "instalei um banco de dados" quando se instalou um SGBD é o deslize mais comum da área — e é distrator garantido.

## 6. Para que serve: as quatro garantias

O que você ganha ao trocar a planilha pelo par banco de dados + SGBD:

**Integridade.** O SGBD recusa dado que viola as regras declaradas. Empréstimo para matrícula inexistente não entra — não porque alguém lembrou de conferir, mas porque a regra está no banco e vale para todo programa que chegar.

**Acesso concorrente.** Duas pessoas emprestando o último exemplar ao mesmo tempo: o SGBD ordena as duas operações e uma delas recebe "não há exemplar disponível". Numa planilha compartilhada, as duas salvam por cima uma da outra e o exemplar some.

**Segurança.** Cada pessoa enxerga e altera só o que lhe compete. O aluno consulta o acervo; o atendente registra empréstimo; ninguém apaga o histórico. Numa planilha, quem tem o arquivo tem tudo.

**Recuperação.** Se a energia cair no meio de uma operação, o SGBD volta a um estado coerente ao reiniciar — não fica meia operação gravada.

> 💡 Duas dessas garantias — **acesso concorrente** e **recuperação** — têm um nome formal que você vai encontrar em livros, concursos e entrevistas: **ACID** (atomicidade, consistência, isolamento e durabilidade), as propriedades que um SGBD garante a cada operação completa. As duas listas não se sobrepõem: segurança não tem letra na sigla, e a recuperação daqui responde sozinha por duas delas. Como o SGBD consegue isso é assunto de um curso de SGBD, não deste.

> 💡 Repare que nenhuma das quatro é sobre velocidade. Banco de dados não existe para ser rápido; existe para o dado continuar **verdadeiro** quando muita gente mexe nele ao mesmo tempo.

## 7. O que o SGBD não resolve sozinho

Vale terminar desfazendo um mal-entendido que se instala cedo e atrapalha o curso inteiro.

**O SGBD não elimina a redundância.** Ele obedece ao modelo que você desenhar. Se você criar uma tabela de empréstimos com o nome do aluno dentro dela, o SGBD vai guardar o nome repetido mil vezes sem reclamar uma única vez — a redundância é decisão de **projeto**, não de ferramenta. Quem elimina redundância é a modelagem, e é disso que trata o resto do curso.

**O SGBD não sabe o que é verdade no seu mundo.** Ele só garante as regras que você declarou. Se ninguém disse que a data de devolução não pode ser anterior à de retirada, ele aceita a data invertida com o maior prazer.

**O SGBD não conserta dado que já entrou errado.** As garantias valem a partir do momento em que a regra existe. Dado ruim carregado antes continua ruim depois.

> 💡 Essa é a razão de a modelagem vir antes da ferramenta neste curso, e de você só abrir uma ferramenta no Bloco 3. Um SGBD excelente sobre um modelo ruim é uma planilha cara: os mesmos três problemas da seção 3, agora com backup.

> 📖 A definição de banco de dados e de SGBD, e as razões para usá-los, abrem tanto o Heuser quanto o Guimarães. O Guimarães dedica mais espaço à motivação histórica — vale a leitura antes da próxima aula.

## 🏋️ Exercícios da aula

Na pasta `aula-01/` do seu repositório:

1. **`ex01.md`** — na planilha da seção 1, liste **todos** os valores redundantes (diga a coluna e quantas vezes o valor se repete) e, para cada uma das três anomalias, escreva **uma linha** provando que a planilha permite aquela anomalia, citando números de empréstimo concretos. *Confere assim: são três colunas com dado redundante, e cada prova precisa citar pelo menos duas linhas da tabela ou uma linha que não existe.*

2. **`ex02.md`** — separe a planilha da seção 1 em **três tabelas por assunto**, desenhando cada uma como a da seção 1 (pode ser texto simples). Abaixo, escreva **uma linha por tabela** dizendo qual anomalia aquela separação resolveu. *Confere assim: a tabela de empréstimo fica só com o que é do empréstimo — se sobrou nome de aluno ou título de livro nela, a separação não terminou.*

3. **`ex03.md`** — a biblioteca decidiu trocar a planilha por um SGBD e o diretor perguntou "para quê?". Escreva as **quatro garantias** da seção 6 e, para cada uma, **uma frase** contando o que aconteceria na biblioteca sem ela — um problema concreto, com pessoas e livros, não uma definição. *Confere assim: se a sua frase serviria igual para uma padaria, ela ainda é uma definição. Reescreva citando empréstimo, exemplar ou aluno.*

### 📤 Entrega

Estes exercícios são feitos em sala e vão para o **seu repositório** `exercicios-modelagem-dados`:

```bash
cd ..                 # da pasta da aula para a raiz do repositório
git add aula-01/
git commit -m "Resolve exercícios da aula 01"
git push
```

Confira no navegador que a pasta apareceu em `github.com/SEU-USUARIO/exercicios-modelagem-dados`.

## 🧠 Revisão

[8 questões de múltipla escolha](revisao/README.md) para conferir se os conceitos ficaram sólidos. Responda sem consultar a aula — depois volte e corrija.

**A entrega é pelo formulário:** [responder a revisão da Aula 01](https://docs.google.com/forms/d/e/1FAIpQLSeSfrJIQsOkjSccqwXQFNXzpfSsAx3sJ04jaVQMXiFXPGUVXA/viewform)

Entre com uma conta Google, selecione seu nome na lista e informe seu usuário do GitHub — só o usuário, não o endereço do perfil. Se o seu nome ainda não estiver na lista, marque a última opção e escreva o nome completo no campo seguinte. É **uma resposta por aluno** e não dá para editar depois de enviar, então confira antes. A nota é liberada no AVA depois da revisão em sala e da divulgação do gabarito.

---

🏠 [Início](../../README.md) | ➡️ [Aula 02 — De Onde Vêm os Bancos de Dados](../aula-02-de-onde-vem-os-bancos/README.md)
