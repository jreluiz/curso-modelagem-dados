# 🌍 Catálogo de Minimundos

Doze enunciados prontos para modelar. Servem aos **exercícios autorais** — o terceiro exercício das Aulas 04, 08, 12 e 16, o único lugar do curso em que você recorta uma realidade que não é a Biblioteca. A ideia é que nem todo mundo modele a mesma coisa.

**Como usar:** escolha um, leia duas vezes, grife os substantivos (candidatos a entidade) e os verbos (candidatos a relacionamento) e comece pelo que o enunciado repete mais. Cada minimundo traz uma lista de **armadilhas** — não olhe antes de tentar.

| # | Minimundo | Dificuldade | A partir de | O que treina |
|:---:|-----------|:---:|:---:|---|
| 1 | [Videolocadora de bairro](#1-videolocadora-de-bairro) | ⭐ | Bloco 1 | Título × exemplar, o clássico do curso |
| 2 | [Clínica veterinária](#2-clínica-veterinária) | ⭐ | Bloco 1 | 1:N encadeado, atributo multivalorado |
| 3 | [Academia de ginástica](#3-academia-de-ginástica) | ⭐⭐ | Bloco 2 | N:M com atributo, horário |
| 4 | [Oficina mecânica](#4-oficina-mecânica) | ⭐⭐ | Bloco 2 | Ordem de serviço, peça × serviço |
| 5 | [Hotel](#5-hotel) | ⭐⭐ | Bloco 2 | Período, tipo × unidade, ocupação |
| 6 | [Escola de idiomas](#6-escola-de-idiomas) | ⭐⭐ | Bloco 2 | Turma, pré-requisito (autorrelacionamento) |
| 7 | [E-commerce](#7-e-commerce) | ⭐⭐ | Bloco 3 | **Especialização**, entidade dependente, histórico de preço |
| 8 | [Transportadora](#8-transportadora) | ⭐⭐⭐ | Bloco 2 | Rota com ordem, histórico de situação |
| 9 | [Campeonato esportivo](#9-campeonato-esportivo) | ⭐⭐⭐ | Bloco 2 | Autorrelacionamento com papéis |
| 10 | [Congresso científico](#10-congresso-científico) | ⭐⭐⭐ | Bloco 3 | Papel × tipo — quando **não** usar herança |
| 11 | [Hospital](#11-hospital) | ⭐⭐⭐ | Bloco 3 | **Especialização total e disjunta**, ocupação por período |
| 12 | [Rede de bibliotecas](#12-rede-de-bibliotecas) | ⭐⭐⭐ | Bloco 2 | Reserva × empréstimo, multi-unidade |

> 💡 A coluna **"a partir de"** diz de qual bloco em diante você tem as ferramentas para modelar o enunciado inteiro. Os de ⭐ servem já ao exercício autoral da Aula 04.

> ⚠️ A **Biblioteca Universitária** não está nesta lista de propósito: ela é o caso trabalhado nas aulas, com o modelo publicado na [Aula 08](../bloco-2-modelos-de-banco-de-dados/aula-08-agregacao-e-estudo-de-caso/README.md). Usá-la num exercício autoral seria copiar a resposta.

---

## 1. Videolocadora de bairro

Uma locadora aluga filmes. De cada filme interessam título, ano, duração, gênero e a distribuidora. Um filme tem um ou mais atores no elenco, e um ator trabalha em vários filmes — quando o ator é o protagonista, isso precisa estar registrado.

A locadora possui várias **cópias físicas** do mesmo filme, cada uma com um número de patrimônio, a mídia (DVD ou Blu-ray) e o estado de conservação. É a cópia que é alugada, não o filme.

Clientes têm CPF, nome, endereço e um ou mais telefones. Um cliente aluga cópias, registrando data de retirada e data prevista de devolução; quando devolve, registra-se a data efetiva e a multa, se houver. Um cliente pode ter vários aluguéis em aberto, mas cada cópia só está em um aluguel por vez.

> **Armadilhas:** confundir filme com cópia (o erro que este minimundo existe para ensinar); esquecer que "protagonista" é atributo do relacionamento, não do ator; telefone como atributo simples.

---

## 2. Clínica veterinária

A clínica atende animais. De cada animal registra-se nome, espécie, raça, data de nascimento e sexo. Todo animal pertence a exatamente um dono (nome, CPF, endereço, telefones), e um dono pode ter vários animais.

Consultas são realizadas por um veterinário (CRMV, nome, especialidade) em um animal, em data e hora, com anotação do motivo e do diagnóstico. Um animal tem várias consultas ao longo da vida; um veterinário atende várias consultas.

Em uma consulta podem ser prescritos medicamentos, com dosagem e duração do tratamento. O mesmo medicamento é prescrito em muitas consultas.

Vacinas aplicadas ficam registradas com a data e o lote, e existe uma data prevista para o reforço.

> **Armadilhas:** dosagem é atributo da prescrição, não do medicamento; a idade do animal é derivada e não se armazena; "espécie" e "raça" — atributo ou entidade? (decida e justifique).

---

## 3. Academia de ginástica

Alunos matriculam-se em planos (mensal, trimestral, anual), cada plano com preço e duração. Um aluno tem uma matrícula ativa por vez, mas o histórico de matrículas anteriores precisa ser preservado, com data de início, data de fim e valor pago na época.

A academia oferece aulas coletivas (spinning, pilates, jump) em horários fixos da semana, cada uma com um instrutor responsável e uma sala com capacidade máxima. Alunos se inscrevem nas aulas que vão frequentar; uma aula tem vários alunos inscritos e um aluno frequenta várias aulas.

De cada frequência efetiva interessa a data e o horário de entrada na catraca.

Instrutores têm CREF, nome e as modalidades que estão habilitados a dar.

> **Armadilhas:** "aula" como conceito (spinning) × "aula" como ocorrência (spinning de terça às 19h) — são coisas diferentes; o valor pago é histórico e não pode ser lido do plano atual; inscrição na aula × presença na aula.

---

## 4. Oficina mecânica

A oficina atende veículos. De cada veículo importa a placa, o chassi, o modelo, o ano e a cor; o modelo pertence a uma marca. Todo veículo tem um proprietário, e o proprietário pode mudar ao longo do tempo — o histórico interessa.

Quando um veículo chega, abre-se uma **ordem de serviço** com data de entrada, quilometragem, o problema relatado pelo cliente e a data prevista de conclusão. A ordem contém serviços executados (cada um com descrição, valor de mão de obra e o mecânico responsável) e peças aplicadas (com quantidade e valor unitário no dia).

Mecânicos têm nome, especialidade e data de admissão. Um serviço da ordem é feito por um mecânico; um mecânico executa muitos serviços.

Peças têm código, descrição, fabricante e quantidade em estoque.

> **Armadilhas:** o valor da peça na ordem é o do dia (histórico), não o do cadastro; a troca de proprietário exige tabela própria com período; um serviço da ordem pode precisar de mais de um mecânico — pergunte ao cliente.

---

## 5. Hotel

O hotel tem quartos identificados por número, cada um pertencente a um tipo (standard, luxo, suíte) que define a diária, a capacidade de hóspedes e as comodidades.

Hóspedes fazem reservas informando data de entrada, data de saída e quantidade de pessoas. Uma reserva é para um quarto específico e feita por um hóspede titular, mas pode acomodar vários hóspedes — todos precisam estar identificados por exigência legal.

Uma reserva tem situação (confirmada, em andamento, encerrada, cancelada). Durante a estadia, consumos são lançados na conta: itens do frigobar, refeições, lavanderia, cada um com data, quantidade e valor unitário praticado.

Funcionários registram o check-in e o check-out; interessa saber quem fez cada um.

> **Armadilhas:** tipo de quarto × quarto (a diária é do tipo, o número é do quarto); o titular é um dos hóspedes ou é papel separado?; a reserva não pode sobrepor períodos no mesmo quarto — isso é regra de negócio, e o modelo precisa **permitir verificá-la**.

---

## 6. Escola de idiomas

A escola oferece cursos (Inglês, Espanhol, Francês), cada um dividido em níveis sequenciais. Um nível pode exigir outro como **pré-requisito**.

Para cada nível abrem-se turmas por semestre, com um professor, uma sala, dias da semana e horário. Uma turma tem número máximo de alunos.

Alunos matriculam-se em turmas. Ao final, cada matrícula recebe uma menção (aprovado, reprovado, desistente) e a frequência em percentual. Um aluno pode cursar o mesmo nível mais de uma vez, em semestres diferentes.

Professores têm formação e os idiomas que lecionam.

> **Armadilhas:** o pré-requisito é autorrelacionamento N:M entre níveis; a matrícula do mesmo aluno no mesmo nível repete — a chave precisa contemplar o semestre; "dias da semana" é multivalorado.

---

## 7. E-commerce

A loja vende produtos de categorias organizadas em hierarquia (Eletrônicos → Áudio → Fones). Cada produto tem código, descrição, peso e a categoria a que pertence.

Alguns produtos exigem dados que só fazem sentido para eles: **livros** têm ISBN, autor e número de páginas; **eletrônicos** têm voltagem e prazo de garantia; **vestuário** tem tamanho e cor. Nenhum produto é de dois desses tipos — mas a loja também vende muita coisa que não é nenhum dos três e não precisa de dado extra algum.

O preço de um produto **muda ao longo do tempo**, e todo pedido precisa preservar o preço praticado na data da compra.

Clientes cadastram-se com CPF, nome, e-mail e podem ter vários endereços de entrega, cada um com apelido ("casa", "trabalho").

Um pedido é feito por um cliente, para um endereço de entrega, em uma data, com uma forma de pagamento e uma situação (aguardando pagamento, pago, enviado, entregue, cancelado). O pedido contém itens: produto, quantidade e preço unitário praticado.

O envio tem transportadora, código de rastreio e data prevista. Um pedido pode ser enviado em mais de uma remessa.

Clientes avaliam produtos que compraram, com nota de 1 a 5 e comentário.

> **Armadilhas:** a especialização de produto é **parcial e disjunta** — compare com o [Hospital](#11-hospital), que é total, e diga no diagrama qual é qual; o item de pedido é entidade dependente do pedido; sem o preço praticado no item, mudar o preço reescreve o passado; a hierarquia de categorias é autorrelacionamento 1:N e **não** é especialização; a avaliação só existe para quem comprou — isso é restrição, e ela deve estar registrada em texto.

---

## 8. Transportadora

A empresa transporta cargas entre cidades. Uma cidade pertence a um estado.

Cada **carga** tem remetente, destinatário, peso, volume, valor declarado e a descrição do conteúdo. Ela é despachada de uma cidade de origem para uma cidade de destino.

O transporte é feito por veículos (placa, tipo, capacidade em kg) conduzidos por motoristas (CNH, nome, categoria da habilitação). Uma viagem tem data de saída, data prevista de chegada, um veículo, um ou mais motoristas (revezamento em viagens longas) e transporta várias cargas.

A rota de uma viagem passa por cidades intermediárias, numa ordem que interessa registrar.

Cada carga tem um histórico de situações (coletada, em trânsito, em rota de entrega, entregue, devolvida), com data, hora e a cidade onde a situação foi registrada.

> **Armadilhas:** a ordem das cidades na rota exige um atributo de sequência na tabela associativa; motorista × viagem é N:M por causa do revezamento; o histórico de situação é tabela, nunca um atributo `situacao` sobrescrito; origem e destino são **dois** relacionamentos com `CIDADE`, não um.

---

## 9. Campeonato esportivo

Um campeonato acontece em uma temporada e tem várias rodadas. Times têm nome, cidade, ano de fundação e estádio.

Uma **partida** ocorre em uma rodada, entre dois times — um mandante e um visitante — em uma data, num estádio, com um árbitro. Registra-se o placar de cada lado.

Jogadores pertencem a um time por período (contratos com data de início e fim; um jogador passa por vários times ao longo da carreira). De cada jogador interessa nome, data de nascimento, posição e número da camisa no time atual.

Em uma partida, registram-se os eventos: gols (com o minuto e o jogador), cartões (amarelo/vermelho, minuto, jogador) e substituições (minuto, quem sai, quem entra).

> **Armadilhas:** mandante e visitante são **dois papéis** do mesmo relacionamento com `TIME`; o vínculo jogador-time é tabela com período, não FK simples; gol contra exige saber que o jogador marcou para o outro lado — o modelo precisa comportar isso.

---

## 10. Congresso científico

O congresso tem edições anuais, cada uma numa cidade e num período. Uma edição organiza-se em trilhas temáticas.

Autores (nome, e-mail, instituição) submetem **trabalhos** a uma trilha. Um trabalho tem título, resumo, palavras-chave e vários autores, numa ordem que importa; um deles é o autor de correspondência.

Cada trabalho é avaliado por três revisores, que dão uma nota de 1 a 5 e um parecer em texto. Revisores são pesquisadores cadastrados, com áreas de interesse. Um revisor não pode avaliar trabalho da própria instituição.

Trabalhos aceitos são apresentados em sessões, que ocorrem em uma sala, num dia e horário, com um coordenador de sessão.

Participantes inscrevem-se na edição (categoria: estudante, profissional, palestrante) e podem assistir às sessões.

> **Armadilhas:** a ordem dos autores é atributo do relacionamento, não do autor; "autor de correspondência" também é do relacionamento; a restrição de instituição não cabe no diagrama — registre em texto; a mesma pessoa pode ser autor, revisor e participante — e esta é a armadilha central: **papel não é herança.** Autor, revisor e participante são coisas que uma pessoa *faz*, não coisas que ela *é*, e mudam de uma edição para a outra. Resolva com **uma** entidade `PESSOA` e relacionamentos, nunca com especialização nem com três cadastros. Compare com o [Hospital](#11-hospital), onde a especialização é o caminho certo.

---

## 11. Hospital

O hospital tem pacientes (prontuário, nome, data de nascimento, tipo sanguíneo, convênio) e profissionais (matrícula, nome, data de admissão, setor).

Todo profissional é de **um de três tipos**, e cada tipo guarda coisas que os outros não guardam: **médicos** têm CRM e especialidade, e só eles prescrevem; **enfermeiros** têm COREN e a escala de turno a que pertencem; **técnicos** têm o registro no conselho da sua área e a lista de equipamentos em que são habilitados. Ninguém é de dois tipos ao mesmo tempo, e não existe profissional que não seja de nenhum.

Consultas ambulatoriais têm data, hora, médico, paciente e o diagnóstico registrado com o código do CID.

Uma **internação** tem data de entrada, data de alta, o motivo e o leito ocupado. Leitos pertencem a quartos, que pertencem a alas. Um leito é ocupado por um paciente por vez, mas ao longo do tempo por muitos.

Durante a internação, prescrevem-se medicamentos (dose, via, frequência, período) e realizam-se procedimentos (data, hora, tipo e o profissional responsável).

Exames são solicitados por um médico para um paciente, com data de solicitação, data de realização e o resultado.

> **Armadilhas:** a especialização de profissional é **total e disjunta** — o enunciado afirma as duas coisas numa frase só, ache qual e registre ambas no diagrama; **setor não é especialização**, é atributo, porque um profissional muda de setor sem mudar de tipo; leito ocupado "por vez" exige período, não uma ligação sobrescrita; a prescrição tem atributos próprios e não é um simples N:M; quarto → ala → leito é 1:N encadeado, e é onde se erra a direção da ligação.

---

## 12. Rede de bibliotecas

Uma rede tem várias unidades, cada uma com endereço e horário de funcionamento.

O acervo tem obras (ISBN, título, ano, editora, autores, assuntos). Uma obra tem exemplares, cada um pertencente a **uma** unidade, com número de tombo, situação (disponível, emprestado, em manutenção, extraviado) e data de aquisição.

Usuários (matrícula, nome, categoria: aluno, professor, servidor, comunidade) fazem empréstimos. A categoria define quantos exemplares podem ser levados e por quantos dias.

Um empréstimo é de um exemplar, para um usuário, com data de retirada, data prevista e data de devolução. Empréstimos podem ser **renovados** — cada renovação com data e nova data prevista — desde que não haja reserva na obra.

Usuários **reservam obras** (não exemplares) e entram numa fila de espera. Quando um exemplar da obra é devolvido, o primeiro da fila é avisado e tem 48 horas para retirar.

Multas por atraso são calculadas por dia e podem ser pagas ou perdoadas por um funcionário, com justificativa.

> **Armadilhas:** reserva é da **obra** e empréstimo é do **exemplar** — modelar isso corretamente é o coração do problema; a renovação é tabela, não um contador; o limite por categoria é derivado de um atributo da categoria; a fila de espera precisa de ordem ou de data de solicitação; multa é do empréstimo ou do usuário?

---

## Escolhendo um minimundo para o exercício autoral

Este catálogo abastece o **terceiro exercício das Aulas 04, 08, 12 e 16** — os quatro pontos do curso em que você recorta uma realidade própria, em vez de estender a Biblioteca. Três critérios, nesta ordem:

1. **Você entende o domínio?** Modelar bem exige saber quando o enunciado está mentindo. Um domínio que você conhece de verdade — o trabalho de alguém da família, um hobby, a rotina de um lugar que você frequenta — vale mais que um tema "impressionante";
2. **Ele exercita o que a aula acabou de ensinar?** Use a coluna *"a partir de"* da tabela: um minimundo de Bloco 3 escolhido na Aula 08 vai pedir especialização, que você ainda não viu;
3. **Ele cabe numa noite de estudo?** Modelar o Instagram inteiro não é ambição, é falta de recorte. Recortar é a primeira habilidade do modelador.

> 💡 Minimundo próprio é bem-vindo e até incentivado — escreva o enunciado no mesmo formato dos daqui (três a cinco parágrafos, em português corrido, sem nomear entidades ou tabelas) e valide o recorte antes de começar a desenhar.

---

🏠 [Voltar ao início](../README.md)
