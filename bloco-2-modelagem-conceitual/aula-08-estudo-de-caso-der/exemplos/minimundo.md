# Minimundo — Biblioteca Universitária

> O enunciado completo do caso que atravessa o curso. Ele é o ponto de partida do DER da Aula 08, do esquema relacional da Aula 10, da análise de normalização da Aula 12 e do banco que roda nas Aulas 13 a 15.

---

## O enunciado

A biblioteca central atende **usuários** vinculados à universidade, identificados pela matrícula, com nome, e-mail e a data em que se cadastraram. Um usuário pode informar vários telefones, cada um com um tipo (celular, residencial, recado). Todo usuário é **aluno**, **professor** ou **servidor** — nunca mais de um. De alunos interessam o curso e o semestre de ingresso; de professores, o departamento e a titulação; de servidores, o setor de lotação.

O acervo é formado por **obras**, identificadas pelo ISBN, com título, ano de publicação e editora. Uma obra é escrita por um ou mais **autores**, e a ordem em que os autores aparecem na capa importa. Uma obra é classificada em uma ou mais **áreas de conhecimento**.

De cada obra a biblioteca possui **exemplares** físicos. Cada exemplar tem um número de tombo, único em todo o acervo, a data em que foi adquirido e uma situação (disponível, emprestado, em manutenção, extraviado). É o exemplar que é emprestado, nunca a obra.

Um **empréstimo** registra a saída de um exemplar para um usuário, com a data de retirada, a data prevista de devolução e, quando ocorre, a data de devolução efetiva. Todo empréstimo é registrado por um **funcionário** da biblioteca. Um empréstimo pode ser **renovado** várias vezes; cada renovação registra a data em que foi feita e a nova data prevista, e as renovações de um empréstimo são numeradas em sequência.

Usuários podem **reservar** obras que estão todas emprestadas — a reserva é da obra, não de um exemplar específico. A reserva guarda a data da solicitação e a situação (aguardando, atendida, cancelada, expirada).

Quando a devolução atrasa, gera-se uma **multa** para aquele empréstimo, com o valor devido e a data de pagamento. Uma multa pode ser perdoada por um funcionário, que precisa registrar a justificativa.

---

## Regras de negócio

O que o diagrama não consegue expressar, e que **faz parte do modelo**:

1. O limite de exemplares e o prazo de devolução dependem do tipo de usuário: **aluno** 3 exemplares / 14 dias, **professor** 10 / 60 dias, **servidor** 3 / 14 dias;
2. Só se pode reservar uma obra cujos exemplares estejam **todos** emprestados;
3. Um usuário não pode reservar obra da qual já tem exemplar emprestado;
4. Um empréstimo só pode ser renovado se **não houver reserva** para a obra;
5. A multa é de valor fixo por dia de atraso, contado a partir da última `nova_data_prevista` (ou da `data_prevista`, se não houve renovação);
6. Um exemplar em situação `manutencao` ou `extraviado` não pode ser emprestado;
7. `data_devolucao` nula significa **empréstimo em aberto** — é o único significado admitido para nulo nesse campo;
8. Uma reserva atendida expira em 48 horas se o usuário não retirar o exemplar.

---

## Decisões de recorte

O que ficou **de fora** do minimundo, e por quê:

| Fora | Motivo |
|---|---|
| Endereço do usuário | Já existe no cadastro acadêmico da universidade; duplicá-lo criaria duas verdades |
| Editora como entidade | O enunciado só pede o nome. Vira entidade no dia em que pedirem endereço ou contato |
| Unidades da biblioteca | Há uma só. É a extensão proposta no desafio 🌶️ da Aula 08 |
| Histórico de leitura por usuário | Decisão de privacidade: guarda-se o empréstimo, não um perfil de leitura |
| Valor monetário do acervo | Interessa ao patrimônio, não à biblioteca |

E as decisões que estavam **na fronteira**, resolvidas por escrito:

- **Uma obra pode existir sem nenhum exemplar?** Sim — obras podem estar catalogadas antes da chegada física. Por isso `(0,N)` do lado de `OBRA`;
- **Um autor pode não ter obra?** Não — autor só é cadastrado ao se cadastrar uma obra dele. Por isso `(1,N)`;
- **O tombo é único no acervo ou por obra?** **No acervo inteiro** — o que torna `EXEMPLAR` uma entidade **forte**. Se fosse por obra, seria fraca com chave `(isbn, numero)`.

---

## As sete perguntas que geraram este enunciado

O enunciado não caiu do céu — ele é o resultado de uma conversa. As perguntas que mais mudaram o modelo:

1. *"Vocês emprestam o título ou o volume físico?"* → separou `OBRA` de `EXEMPLAR`, e é a decisão mais importante do caso inteiro;
2. *"A reserva é de um exemplar específico ou de qualquer um da obra?"* → `RESERVA` aponta para `OBRA`;
3. *"Vocês precisam saber **quando** cada renovação foi feita, ou só quantas foram?"* → `RENOVACAO` virou entidade em vez de contador;
4. *"Um usuário pode ter mais de um vínculo?"* → especialização **disjunta**;
5. *"Existe usuário que não é nenhum dos três?"* → especialização **total**;
6. *"A ordem dos autores na capa importa?"* → o atributo `ordem` no relacionamento N:M;
7. *"Quem perdoou a multa precisa ficar registrado?"* → a FK opcional de `MULTA` para `FUNCIONARIO`.

---

⬅️ [Voltar à Aula 08](../README.md) · [Ver o DER completo](der-completo.md) | 🏠 [Início do curso](../../../README.md)
