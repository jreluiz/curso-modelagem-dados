# Aula 12 — O Que o SGBD Garante

> 🎯 Objetivos: delimitar uma transação com `BEGIN`, `COMMIT` e `ROLLBACK`, explicar as quatro letras do ACID em linguagem direta e conceder a um usuário só as permissões de que ele precisa.
> 🎬 Slides da aula: [apresentacao-12-o-que-o-sgbd-garante.pdf](apresentacao/apresentacao-12-o-que-o-sgbd-garante.pdf)

> 💡 **Os comandos que alteram dados aparecem nesta aula como gesto a repetir, não como sintaxe a aprender.** Eles são ensinados na Aula 14. Aqui interessa o que está **em volta** deles.

## 1. Duas operações que precisam acontecer juntas

Emprestar um exemplar são dois passos:

```
   1. gravar a linha em EMPRESTIMO
   2. mudar a situação do exemplar para 'emprestado'
```

Entre um e o outro existe um instante — curto, mas existe. Se a energia cair ali, ou a rede cair, ou o programa travar, o banco fica dizendo que o exemplar está disponível enquanto ele está na mochila de alguém. Metade da operação aconteceu.

**Uma transação é um conjunto de operações que o banco trata como uma coisa só:** ou todas acontecem, ou nenhuma acontece. Não existe meio.

```sql
BEGIN;
    INSERT INTO emprestimo_simples (tombo, nome_usuario, data_retirada)
    VALUES (4420, 'Célia Reis', DATE '2026-03-15');

    UPDATE livro SET situacao = 'emprestado' WHERE tombo = 4420;
COMMIT;
```

Entre o `BEGIN` e o `COMMIT`, **nada disso existe para as outras pessoas**. Elas continuam vendo o exemplar como disponível. É no `COMMIT` que os dois passos passam a existir, ao mesmo tempo, para todo mundo.

## 2. `COMMIT` e `ROLLBACK`

Uma transação termina de duas maneiras:

| Comando | O que faz |
|---|---|
| `COMMIT` | **Confirma.** Tudo que foi feito passa a valer, de uma vez, para todos |
| `ROLLBACK` | **Desfaz.** É como se a transação nunca tivesse começado |

E o `ROLLBACK` não precisa ser seu. O banco o executa sozinho quando alguma coisa dá errado:

```sql
BEGIN;
    UPDATE livro SET situacao = 'manutencao' WHERE tombo = 4417;   -- correto
    UPDATE livro SET situacao = 'perdido'    WHERE tombo = 4418;   -- viola o CHECK
COMMIT;
```

```
ERROR:  new row for relation "livro" violates check constraint "livro_situacao_check"
ROLLBACK
```

> ⚠️ **Repare no que aconteceu com o exemplar 4417.** O primeiro comando estava perfeitamente correto e mesmo assim foi desfeito, porque o segundo falhou. É esse o contrato: a transação é indivisível **inclusive no fracasso**. Meia transação não existe nem quando metade dela estava certa.

> 💻 **Script desta aula:** [`01-transacao.sql`](exemplos/01-transacao.sql) — os três casos acima, para rodar e ver acontecer.

## 3. ACID, em linguagem direta

Quatro garantias, uma letra cada:

**A — Atomicidade.** Tudo ou nada. É a seção anterior inteira.

**C — Consistência.** A transação leva o banco de um estado válido a outro estado válido. Se ela tentar deixar o banco num estado que viola alguma restrição declarada, é recusada — como o exemplar `perdido` acima.

**I — Isolamento.** Transações simultâneas não enxergam o meio do trabalho uma da outra. O resultado é como se elas tivessem acontecido em fila, uma de cada vez.

**D — Durabilidade.** Depois do `COMMIT`, está gravado. Se faltar luz um segundo depois, ao religar o dado está lá.

> 💡 As quatro respondem a perguntas diferentes: **A** é sobre falhar no meio, **C** é sobre as regras do seu modelo, **I** é sobre os outros, e **D** é sobre o disco. Quando algo der errado num sistema real, saber qual letra falhou é meio caminho para o diagnóstico.

## 4. Duas pessoas ao mesmo tempo

Na Aula 09 você viu a atualização perdida: dois atendentes leem "disponível", os dois gravam, e a escrita do primeiro desaparece.

```
   Atendente A                          Atendente B
   ─────────────────────────────────────────────────────────
   lê situação do 4417: disponivel
                                        lê situação do 4417: disponivel
   grava: emprestado para Ana
                                        grava: emprestado para Bruno
   ─────────────────────────────────────────────────────────
   Resultado: o sistema diz Bruno, o livro está com Ana.
```

O **isolamento** é a garantia que impede isso — e ele custa. Enquanto A está escrevendo, B espera. Quanto mais rígido o isolamento, mais gente esperando, e é por isso que existem níveis: você escolhe quanta garantia quer pagar.

O PostgreSQL usa por padrão o nível `READ COMMITTED`, que resolve a maior parte dos casos: **ninguém enxerga transação não confirmada de ninguém**. Para o caso acima, a proteção completa exige pedir explicitamente ao banco que segure a linha durante a leitura.

> ⚠️ **A armadilha é achar que o padrão protege de tudo.** Ele protege de ler lixo. Não protege de dois processos decidirem a mesma coisa a partir da mesma leitura. Você vai ver isso acontecer com as próprias mãos no desafio 🌶️.

## 5. Usuários e permissões

O banco não tem um usuário só. Cada pessoa — ou cada programa — entra com uma identidade, e cada identidade pode exatamente o que foi concedido a ela:

```sql
CREATE ROLE consulta_biblioteca LOGIN PASSWORD 'trocar_depois';

GRANT CONNECT ON DATABASE curso_bd TO consulta_biblioteca;
GRANT USAGE ON SCHEMA public TO consulta_biblioteca;
GRANT SELECT ON livro, emprestimo_simples TO consulta_biblioteca;
```

Pronto: essa identidade **lê e não escreve**. Um `INSERT` feito por ela é recusado com `permission denied`. E é assim que se faz o nível externo da Aula 10 valer de verdade — o atendente vê empréstimos e não vê salários porque alguém concedeu uma coisa e não a outra.

`REVOKE` faz o caminho inverso, retirando o que foi concedido.

> 📏 **Regra do curso, e do mercado:** conceda o **mínimo necessário**, e conceda por papel, não por pessoa. A aplicação que só mostra relatório não precisa de permissão de escrita — e no dia em que ela tiver uma falha de segurança, essa decisão é a diferença entre um vazamento e um desastre.

## 6. Backup e restauração

Transação protege de falha no meio da operação. **Não protege de alguém apagar a tabela errada**, nem de o disco morrer. Para isso, cópia.

```bash
pg_dump curso_bd > curso_bd_2026-03-15.sql     # gera o backup
psql -d curso_bd_novo -f curso_bd_2026-03-15.sql   # restaura
```

O `pg_dump` gera um arquivo de texto com os comandos que reconstroem tudo: as tabelas, as restrições e os dados. É legível, versionável, e roda em qualquer PostgreSQL.

> ⚠️ **Backup que nunca foi restaurado não é backup — é esperança.** A única forma de saber que o arquivo presta é restaurá-lo num banco vazio e conferir. Faça isso pelo menos uma vez com o seu; é o exercício 4.

> 📖 Transações, ACID e controle de concorrência ocupam um capítulo próprio no livro-base, com muito mais profundidade do que esta aula. Os níveis de isolamento e os problemas que cada um resolve estão bem tratados lá.

## 🏋️ Exercícios da aula

Na pasta `aula-12/` do seu repositório:

1. **`ex01.md`** — rode o [`01-transacao.sql`](exemplos/01-transacao.sql) e cole a saída. Depois responda: no bloco 3, o exemplar 4417 ficou com qual situação, e por quê? Explique em três linhas o que esse resultado prova sobre a letra **A** do ACID. *Confira assim: consulte a situação do 4417 depois de rodar — se ela mudou, o seu banco não é ACID, o que é improvável; releia o script.*
2. **`ex02.md`** — para cada falha, diga **qual letra do ACID** foi violada e justifique: (a) faltou luz e metade da transferência foi gravada; (b) o sistema aceitou um empréstimo para um usuário que não existe; (c) dois caixas venderam o mesmo último ingresso; (d) o `COMMIT` respondeu "ok" e, depois de reiniciar o servidor, o dado não estava lá. *Confira assim: são quatro letras e quatro casos, um para cada.*
3. **`ex03.md`** — escreva os comandos que criam uma identidade `auditoria` que pode **ler todas** as tabelas do `curso_bd` e não pode escrever em nenhuma. Rode, conecte-se com ela (`psql -d curso_bd -U auditoria`), tente um `INSERT` e cole a mensagem de erro recebida. *Confira assim: a mensagem precisa conter `permission denied`; se o `INSERT` funcionou, você concedeu demais.*
4. **`ex04.md`** — faça um `pg_dump` do seu `curso_bd`, crie um banco novo vazio, restaure o arquivo nele e **prove** que a restauração funcionou: cole a saída de um `\dt` e de uma contagem de linhas nos dois bancos, lado a lado. Depois responda: o arquivo gerado contém dados, estrutura, ou os dois? *Confira assim: as contagens dos dois bancos precisam bater exatamente.*
5. **Desafio 🌶️ `ex05.md`** — reproduza a atualização perdida com as próprias mãos. Abra **dois terminais**, os dois com `psql -d curso_bd`, e execute a sequência da seção 4 alternando entre eles, com `BEGIN` nos dois e `COMMIT` no fim. Entregue: a sequência exata de comandos em cada terminal na ordem em que você os deu, o resultado final da tabela, e a explicação de por que o isolamento padrão **não** impediu o problema. Depois pesquise `SELECT ... FOR UPDATE`, refaça o teste usando-o na leitura, e mostre o que muda. *Confira assim: no primeiro teste um dos dois nomes precisa sumir; no segundo, o segundo terminal precisa ficar parado esperando.*

## 🧠 Revisão

[8 questões de múltipla escolha](revisao/README.md) para conferir se os conceitos ficaram sólidos. Responda sem consultar a aula — depois volte e corrija.

## ✅ Entrega

```bash
git add aula-12/
git commit -m "Resolve exercícios da aula 12 (o que o SGBD garante)"
git push
```

---

⬅️ [Aula 11](../aula-11-postgresql-na-pratica/README.md) | ➡️ [Aula 13 — SQL DDL: criando o esquema](../../bloco-4-sql-basico/aula-13-sql-ddl/README.md)
