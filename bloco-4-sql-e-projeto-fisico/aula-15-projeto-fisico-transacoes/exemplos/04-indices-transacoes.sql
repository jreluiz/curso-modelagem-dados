-- =============================================================================
-- Aula 15 — Índices, planos de execução e transações
--
-- Rode DEPOIS de 01-ddl.sql e 02-carga.sql:
--   psql -d curso_bd -f 04-indices-transacoes.sql
--
-- ⚠️ AVISO IMPORTANTE SOBRE ESTE SCRIPT:
-- a base do curso tem 8 linhas por tabela. Nesse tamanho, o otimizador vai
-- ignorar seus índices e fazer varredura sequencial — E ELE ESTÁ CERTO:
-- ler 1 página inteira é mais barato que consultar um índice e depois ler
-- a mesma página. O objetivo aqui é aprender a LER o plano, não a acelerá-lo.
-- A seção 4 cria uma tabela grande, onde a diferença aparece de verdade.
-- =============================================================================

-- ─────────────────────────────────────────────────────────────────────────────
-- 1. O que já existe sem você pedir
-- ─────────────────────────────────────────────────────────────────────────────

\echo '===== Índices criados automaticamente (PK e UNIQUE) ====='
SELECT tablename, indexname
FROM pg_indexes
WHERE schemaname = 'public'
ORDER BY tablename, indexname;

-- Repare: há índice para toda PRIMARY KEY e todo UNIQUE.
-- NÃO há índice para nenhuma FOREIGN KEY. O PostgreSQL não os cria.


-- ─────────────────────────────────────────────────────────────────────────────
-- 2. Índices nas chaves estrangeiras
--    É a primeira coisa a fazer num banco lento: toda junção usa a FK.
-- ─────────────────────────────────────────────────────────────────────────────

CREATE INDEX IF NOT EXISTS idx_exemplar_isbn       ON exemplar   (isbn);
CREATE INDEX IF NOT EXISTS idx_emprestimo_matricula ON emprestimo (matricula);
CREATE INDEX IF NOT EXISTS idx_emprestimo_tombo     ON emprestimo (tombo);
CREATE INDEX IF NOT EXISTS idx_emprestimo_func      ON emprestimo (matricula_func);
CREATE INDEX IF NOT EXISTS idx_reserva_matricula    ON reserva    (matricula);
CREATE INDEX IF NOT EXISTS idx_reserva_isbn         ON reserva    (isbn);
CREATE INDEX IF NOT EXISTS idx_escrita_autor        ON escrita    (id_autor);
CREATE INDEX IF NOT EXISTS idx_class_area           ON classificacao (codigo_area);

-- Índice para uma consulta específica e frequente: "quem está atrasado?"
CREATE INDEX IF NOT EXISTS idx_emprestimo_prevista ON emprestimo (data_prevista);

-- ❌ O que NÃO se deve indexar: exemplar.situacao tem 4 valores distintos
-- em 9 linhas. Índice de baixa seletividade nunca é usado e custa em toda
-- escrita. Deixado aqui como comentário, de propósito:
-- CREATE INDEX idx_exemplar_situacao ON exemplar (situacao);


-- ─────────────────────────────────────────────────────────────────────────────
-- 3. Lendo um plano de execução na base pequena
-- ─────────────────────────────────────────────────────────────────────────────

\echo '===== EXPLAIN: base pequena, Seq Scan é a escolha CORRETA ====='
EXPLAIN ANALYZE
SELECT * FROM emprestimo WHERE data_prevista < CURRENT_DATE;

-- Leia, nesta ordem:
--   Seq Scan / Index Scan ..... como leu
--   cost=X..Y ................. custo estimado (comparar planos, não é tempo)
--   rows=N vs actual rows=N ... estimativa contra realidade. Diferença grande
--                               é o sinal mais útil: estatísticas desatualizadas
--   Rows Removed by Filter .... trabalho jogado fora


-- ─────────────────────────────────────────────────────────────────────────────
-- 4. Onde o índice REALMENTE aparece: 200 mil linhas
-- ─────────────────────────────────────────────────────────────────────────────

DROP TABLE IF EXISTS teste_volume;
CREATE TABLE teste_volume (
    id     INTEGER PRIMARY KEY,
    codigo INTEGER NOT NULL,
    texto  TEXT    NOT NULL
);

INSERT INTO teste_volume (id, codigo, texto)
SELECT g, (random() * 100000)::INT, md5(g::TEXT)
FROM generate_series(1, 200000) AS g;

ANALYZE teste_volume;   -- atualiza as estatísticas que o otimizador consulta

\echo '===== SEM índice em codigo: Seq Scan em 200 mil linhas ====='
EXPLAIN ANALYZE SELECT * FROM teste_volume WHERE codigo = 42;

CREATE INDEX idx_teste_codigo ON teste_volume (codigo);
ANALYZE teste_volume;

\echo '===== COM índice: compare cost e Execution Time ====='
EXPLAIN ANALYZE SELECT * FROM teste_volume WHERE codigo = 42;

\echo '===== Índice IGNORADO de propósito: consulta pouco seletiva ====='
-- Devolve ~metade da tabela. O otimizador prefere varrer, e está certo:
-- ler o índice e depois buscar 100 mil linhas na tabela é mais caro.
EXPLAIN ANALYZE SELECT * FROM teste_volume WHERE codigo < 50000;

DROP TABLE teste_volume;


-- ─────────────────────────────────────────────────────────────────────────────
-- 5. Transações: atomicidade na prática
-- ─────────────────────────────────────────────────────────────────────────────

\echo '===== ROLLBACK: o DELETE que não aconteceu ====='

SELECT COUNT(*) AS reservas_antes FROM reserva;

BEGIN;
    DELETE FROM reserva WHERE situacao = 'expirada';
    SELECT COUNT(*) AS dentro_da_transacao FROM reserva;
ROLLBACK;

SELECT COUNT(*) AS reservas_depois_do_rollback FROM reserva;
-- Mesmo número do início: o ROLLBACK desfez tudo.


\echo '===== COMMIT: emprestar um exemplar são DOIS efeitos indivisíveis ====='

BEGIN;
    UPDATE exemplar SET situacao = 'emprestado' WHERE tombo = 4419;

    INSERT INTO emprestimo (matricula, tombo, matricula_func,
                            data_retirada, data_prevista)
    VALUES (2024007, 4419, 900, CURRENT_DATE, CURRENT_DATE + 14);
COMMIT;

-- Se a energia caísse entre os dois comandos, o exemplar ficaria marcado
-- como emprestado sem que existisse empréstimo. A transação impede isso.

SELECT x.tombo, x.situacao, e.matricula, e.data_prevista
FROM exemplar x
LEFT JOIN emprestimo e ON x.tombo = e.tombo AND e.data_devolucao IS NULL
WHERE x.tombo = 4419;


\echo '===== A restrição continua valendo DENTRO da transação ====='
-- Consistência (o C de ACID): a transação não pode deixar o banco inválido.
-- Rode o comando abaixo (está comentado para o script não abortar):
--
--   INSERT INTO emprestimo (matricula, tombo, matricula_func,
--                           data_retirada, data_prevista)
--   VALUES (2023101, 99999, 900, CURRENT_DATE, CURRENT_DATE + 14);
--
-- Resposta do PostgreSQL:
--   ERROR:  insert or update on table "emprestimo" violates foreign key
--           constraint "fk_emp_exemplar"
--   DETAIL:  Key (tombo)=(99999) is not present in table "exemplar".
--
-- ⚠️ E aqui está o detalhe que surpreende: DENTRO de uma transação, um erro
-- aborta a transação INTEIRA. Todo comando seguinte responde
-- "current transaction is aborted, commands ignored until end of transaction
-- block" até você dar ROLLBACK. Para tolerar um erro sem perder o que já foi
-- feito, é preciso SAVEPOINT antes dele e ROLLBACK TO SAVEPOINT depois.

BEGIN;
    SAVEPOINT antes_da_tentativa;
    -- (num script real, o INSERT que falha viria aqui)
    ROLLBACK TO SAVEPOINT antes_da_tentativa;   -- volta ao ponto, transação viva
    SELECT COUNT(*) AS emprestimos_ainda_visiveis FROM emprestimo;
COMMIT;


-- ─────────────────────────────────────────────────────────────────────────────
-- 6. Concorrência: como simular uma atualização perdida
--    Precisa de DUAS sessões do psql. Não dá para rodar num script só.
-- ─────────────────────────────────────────────────────────────────────────────

-- SESSÃO A                          | SESSÃO B
-- ----------------------------------+----------------------------------
-- BEGIN;                            |
-- SELECT situacao FROM exemplar     |
--   WHERE tombo = 4419;             |
--   -- lê 'disponivel'              |
--                                   | BEGIN;
--                                   | SELECT situacao FROM exemplar
--                                   |   WHERE tombo = 4419;
--                                   |   -- lê 'disponivel' TAMBÉM
-- UPDATE exemplar                   |
--   SET situacao = 'emprestado'     |
--   WHERE tombo = 4419;             |
-- COMMIT;                           |
--                                   | UPDATE exemplar
--                                   |   SET situacao = 'emprestado'
--                                   |   WHERE tombo = 4419;
--                                   | COMMIT;
--                                   |   -- sobrescreveu sem ver a de A:
--                                   |   -- o mesmo exemplar foi emprestado
--                                   |   -- duas vezes.
--
-- A CURA — trave a linha na leitura:
--    SELECT situacao FROM exemplar WHERE tombo = 4419 FOR UPDATE;
-- A sessão B fica esperando o COMMIT de A e só então lê o valor atualizado.
--
-- Alternativa: BEGIN ISOLATION LEVEL SERIALIZABLE, que aborta uma das duas
-- transações com "could not serialize access" — e cabe à aplicação repeti-la.


-- ─────────────────────────────────────────────────────────────────────────────
-- 7. Autorização: o nível externo com permissão (DCL da Aula 02)
-- ─────────────────────────────────────────────────────────────────────────────

-- Comentado para não criar papéis no seu servidor. Leia e rode se quiser:
--
-- CREATE ROLE atendente LOGIN PASSWORD 'trocar';
-- GRANT SELECT, INSERT, UPDATE ON emprestimo TO atendente;
-- GRANT SELECT ON emprestimos_em_aberto TO atendente;   -- a VIEW da Aula 14
-- REVOKE DELETE ON emprestimo FROM atendente;
--
-- Conceder sobre a VIEW e não sobre as tabelas é como se implementa
-- "o atendente vê empréstimos, não vê tudo": a view é simultaneamente
-- simplificação e mecanismo de segurança.
