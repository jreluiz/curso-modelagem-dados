# Aula 02 — De Onde Vêm os Bancos de Dados

> 🎯 Objetivos: situar os modelos de banco de dados na ordem em que surgiram, reconhecer os principais SGBD do mercado e escrever a política de segurança de um banco.
> 🎬 Slides da aula: [apresentacao-02-de-onde-vem-os-bancos.pdf](apresentacao/apresentacao-02-de-onde-vem-os-bancos.pdf)

## 1. Antes do banco: o programa que sabia tudo

Nos anos 1960, cada sistema guardava seus próprios arquivos. O sistema de empréstimos da biblioteca tinha o arquivo dele; o sistema da secretaria tinha o dele; o da tesouraria, o dele.

```
   EMPRÉSTIMOS ──▶ arquivo-alunos-biblioteca
   SECRETARIA  ──▶ arquivo-alunos-secretaria
   TESOURARIA  ──▶ arquivo-alunos-financeiro
```

Três arquivos, os mesmos alunos, três verdades possíveis. Quatro problemas nasciam daí, e são eles que explicam tudo o que veio depois:

- **Redundância entre sistemas.** O aluno mudava de endereço e avisava a secretaria. A biblioteca continuava mandando cobrança para a casa antiga;
- **Dependência de formato.** O programa sabia exatamente em que posição do arquivo cada campo estava. Acrescentar um campo obrigava a reescrever e recompilar **todos** os programas que liam aquele arquivo;
- **Nenhum controle de acesso.** Quem tinha o arquivo tinha tudo — inclusive o que não era da sua alçada;
- **Nenhum controle de simultaneidade.** Dois programas gravando ao mesmo tempo, e um sobrescrevia o outro.

> 💡 Repare que os quatro problemas são exatamente as quatro garantias da Aula 01, ditas ao contrário. A história dos bancos de dados é a história de resolver estes quatro itens, um de cada vez.

## 2. Hierárquico e rede

A primeira resposta veio nos anos 1960 e 1970, com dois modelos que compartilhavam a mesma ideia: **guardar os dados uma vez só e ligá-los por ponteiros**.

**Modelo hierárquico** (o IMS, da IBM, 1966). Os dados formam uma árvore: cada registro tem **um** pai. Serve muito bem para o que é naturalmente hierárquico — uma faculdade tem cursos, que têm turmas, que têm alunos.

O problema aparece quando a realidade não é uma árvore. Um aluno que cursa duas turmas não tem um pai: tem dois. E a árvore não comporta isso sem duplicar o aluno.

**Modelo de rede** (o padrão CODASYL, 1969). Resolve exatamente essa limitação: um registro pode ter **vários** pais. A estrutura deixa de ser árvore e vira rede.

```
   HIERÁRQUICO — um pai só          REDE — vários pais
   ┌──────────┐                     ┌──────────┐   ┌──────────┐
   │  CURSO   │                     │ TURMA A  │   │ TURMA B  │
   └────┬─────┘                     └────┬─────┘   └────┬─────┘
        │                                │              │
   ┌────▼─────┐                          └──────┬───────┘
   │  TURMA   │                                 │
   └────┬─────┘                            ┌────▼─────┐
        │                                  │  ALUNO   │
   ┌────▼─────┐                            └──────────┘
   │  ALUNO   │                     o mesmo aluno em duas turmas,
   └──────────┘                     sem precisar ser duplicado
```

Os dois resolveram a redundância, mas cobraram caro por ela: **o caminho até o dado ficava escrito dentro do programa**. Para achar os empréstimos de um aluno, o programa precisava dizer, passo a passo, por quais ponteiros navegar. Mudou a estrutura, quebrou o programa.

> ⚠️ "Hierárquico" aqui é o **modelo do banco de dados**, não um dado em forma de hierarquia. Um banco relacional guarda hierarquias sem problema nenhum — categorias dentro de categorias, por exemplo. As duas coisas têm o mesmo nome e não são a mesma coisa.

## 3. 1970: Codd e o modelo relacional

Em 1970, **Edgar F. Codd**, matemático da IBM, publicou um artigo com uma ideia que soava quase ingênua: e se os dados fossem apenas **tabelas**, e as ligações entre elas fossem feitas por **valores iguais**, em vez de ponteiros?

```
   ALUNO                          EMPRESTIMO
   ┌───────────┬────────────┐     ┌───────────┬───────────┬────────────┐
   │ matricula │ nome       │     │ n_emprest │ matricula │ retirada   │
   ├───────────┼────────────┤     ├───────────┼───────────┼────────────┤
   │  2023101  │ Ana Souza  │◀────│   1001    │  2023101  │ 2026-03-02 │
   │  2023102  │ Bruno Lima │     │   1003    │  2023102  │ 2026-03-09 │
   └───────────┴────────────┘     └───────────┴───────────┴────────────┘
                    a ligação é o valor 2023101 aparecer nos dois lados
```

A consequência é maior do que parece: **o programa deixa de precisar saber o caminho**. Ele diz *o que* quer — "os empréstimos da matrícula 2023101" — e o SGBD decide *como* buscar. Mudou a estrutura interna, o programa continua funcionando.

Essa separação entre *o que* e *como* é a razão de o modelo relacional ter vencido, e de continuar dominante mais de cinquenta anos depois. É também o modelo que este curso inteiro ensina a projetar.

> 📖 O artigo original de Codd é de 1970 e continua legível. Está em `recursos/links-uteis.md`, e vale os quinze minutos.

## 4. Depois do relacional

Duas coisas aconteceram desde então, e nenhuma delas substituiu o modelo relacional:

**Objeto-relacional** (anos 1990). Bancos relacionais ganharam tipos mais ricos — listas, documentos, coordenadas geográficas, JSON. É o que a maioria dos SGBD atuais é hoje, na prática.

**NoSQL** (a partir de 2009). Uma família de bancos que abre mão de parte das garantias relacionais para escalar em muitas máquinas: bancos de documento, de chave-valor, de colunas e de grafos. Nasceram de problemas específicos — o volume de dados de buscadores e redes sociais.

A história inteira em cinco linhas:

| Década | Modelo | A ideia central | O que cobrava em troca |
|:---:|---|---|---|
| 1960 | Arquivos isolados | cada sistema com o seu arquivo | redundância e dependência de formato |
| 1960–70 | Hierárquico | árvore, um pai por registro | não comporta o que não é árvore |
| 1970 | Rede | grafo, vários pais por registro | o caminho continua dentro do programa |
| 1970– | **Relacional** | tabelas ligadas por valores iguais | — é o que este curso ensina |
| 2009– | NoSQL | abre mão de garantias para distribuir | consistência mais fraca |

> ⚠️ **NoSQL não substituiu o relacional, e o nome engana.** Ele não significa "sem SQL", e sim *not only SQL* — "não apenas". São ferramentas para problemas diferentes, e a maioria dos sistemas que você vai encontrar usa um banco relacional. Achar que o relacional foi superado é a confusão mais comum sobre este tópico.

## 5. Os principais SGBD hoje

| SGBD | Licença | Onde costuma aparecer |
|---|---|---|
| **PostgreSQL** | livre | o mais completo dos livres; padrão em projetos novos e no meio acadêmico |
| **MySQL / MariaDB** | livre | web e hospedagem compartilhada; o MariaDB nasceu de uma bifurcação do MySQL |
| **SQLite** | livre | embutido no próprio programa, sem servidor: celulares, navegadores, aplicativos de mesa |
| **Oracle Database** | proprietária | grandes corporações, bancos, governo; caro e muito estabelecido |
| **SQL Server** | proprietária | empresas com infraestrutura Microsoft |
| **MongoDB, Redis** | livre | não são relacionais — documento e chave-valor, respectivamente |

> 💡 Como escolher, no nível deste curso: **licença** (há orçamento?), **porte** (é um aplicativo de celular ou o sistema de um banco?) e **o que a equipe já sabe operar**. Desempenho quase nunca é o critério decisivo — todos os cinco primeiros dão conta de qualquer sistema de faculdade.

Nesta aula os nomes aparecem para você saber que existem e o que os distingue. Instalar e operar um SGBD não faz parte deste curso.

## 6. Política de segurança de um banco de dados

Guardar o dado no lugar certo não adianta se qualquer pessoa pode lê-lo ou apagá-lo. **Política de segurança** é o conjunto de regras que define **quem pode fazer o quê** com cada parte do banco — e ela se escreve, em português, antes de virar configuração.

Ela se apoia em três pilares, que se confundem o tempo todo:

- **Autenticação** — *"você é quem diz ser?"* Usuário e senha, crachá, certificado. Acontece **uma vez**, na entrada;
- **Autorização** — *"você pode fazer isso?"* O atendente registra empréstimo, mas não altera o acervo. Acontece **a cada operação**;
- **Auditoria** — *"quem fez isso, e quando?"* O registro do que aconteceu, para depois. Não impede nada; permite descobrir.

> ⚠️ **Autenticação e autorização não são a mesma coisa.** Estar autenticado só prova quem você é; não dá direito a nada. Todo sistema que confunde as duas acaba com um usuário comum apagando o que não devia.

O princípio que organiza tudo isso chama-se **menor privilégio**: cada pessoa recebe exatamente as permissões de que precisa para o seu trabalho, e nada além. Na biblioteca, isso dá mais ou menos assim:

| Perfil | Pode ler | Pode alterar | Nunca pode |
|---|---|---|---|
| Aluno | acervo, os próprios empréstimos | nada | ver empréstimo de outro aluno |
| Atendente | acervo, todos os empréstimos | registrar empréstimo e devolução | apagar histórico |
| Bibliotecário-chefe | tudo | acervo e empréstimos | apagar histórico |

Repare que **ninguém apaga o histórico**, nem o chefe. Dado que registra o que aconteceu não se apaga: corrige-se com um novo registro. E completam a política a **cópia de segurança** regular — com teste de restauração, porque backup que nunca foi restaurado é só esperança — e a **LGPD**, que no Brasil torna obrigação legal boa parte do que acima é boa prática.

> 📖 A evolução dos modelos de dados abre o Guimarães com bastante detalhe histórico. O Heuser vai direto ao relacional, que é o foco dele.

## 🏋️ Exercícios da aula

Na pasta `aula-02/` do seu repositório:

1. **`ex01.md`** — associe cada uma das seis características abaixo ao modelo a que pertence (arquivos isolados, hierárquico, rede, relacional ou NoSQL) e diga em que década ele predominou: (a) cada registro tem exatamente um pai; (b) a ligação entre dados é feita por valores iguais; (c) o caminho até o dado fica escrito dentro do programa, mas um registro pode ter vários pais; (d) cada sistema tem seu próprio arquivo, com os mesmos dados repetidos; (e) abre mão de parte das garantias para distribuir os dados em muitas máquinas; (f) o programa diz o que quer, não como buscar. *Confere assim: cada um dos cinco modelos recebe pelo menos uma característica, e as décadas ficam em ordem crescente quando você organiza as respostas.*

2. **`ex02.md`** — escolha um SGBD da tabela da seção 5 para cada um dos três cenários e justifique em **duas linhas**: (a) o sistema de empréstimos desta biblioteca, sem orçamento para licença; (b) o sistema central de um banco nacional, com contrato de suporte 24 horas; (c) um aplicativo de celular que funciona sem internet. *Confere assim: cada justificativa precisa citar licença, porte ou modo de instalação — se ela serviria igual para os três cenários, você justificou preferência, não escolha.*

3. **`ex03.md`** — escreva a política de segurança do banco da biblioteca para os três perfis da seção 6, agora incluindo um quarto: o **estagiário**, que ajuda no balcão mas ainda está em treinamento. Para cada perfil, diga o que pode ler, o que pode alterar e o que nunca pode — e escreva **uma linha** explicando como o princípio do menor privilégio decidiu o caso do estagiário. *Confere assim: nenhum dos quatro perfis apaga histórico, e o estagiário precisa ter menos permissão que o atendente em pelo menos um ponto concreto.*

## 🧠 Revisão

[8 questões de múltipla escolha](revisao/README.md) para conferir se os conceitos ficaram sólidos. Responda sem consultar a aula — depois volte e corrija.

## ✅ Entrega

```bash
git add aula-02/
git commit -m "Resolve exercícios da aula 02 (evolução, SGBD e segurança)"
git push
```

---

⬅️ [Aula 01 — A Redundância e a Resposta do SGBD](../aula-01-redundancia-e-o-sgbd/README.md) | ➡️ [Aula 03 — Os Elementos de um Banco de Dados](../aula-03-elementos-de-um-banco/README.md)
