-- =============================================================
-- Aula 12 — Transações, e o que o SGBD garante
--
-- Requer que 00-primeiro-contato.sql (Aula 11) já tenha rodado.
--
-- ⚠️  Os comandos INSERT e UPDATE aparecem aqui como gesto a repetir,
--     não como sintaxe a aprender. Eles são ensinados na Aula 14.
--     O que interessa nesta aula é o que está EM VOLTA deles:
--     o BEGIN, o COMMIT e o ROLLBACK.
--
-- Como rodar:
--     psql -d curso_bd -f 01-transacao.sql
--
-- 📌 Aqui, de propósito, SEM o -v ON_ERROR_STOP=1: o bloco 3 termina
--    com um erro provocado, e você precisa vê-lo acontecer.
-- =============================================================

\echo '--- Situação inicial do exemplar 4420 ---'
SELECT tombo, titulo, situacao FROM livro WHERE tombo = 4420;

-- -------------------------------------------------------------
-- 1. Uma transação que dá certo: os dois passos ou nenhum
-- -------------------------------------------------------------
\echo '--- 1. Emprestando o 4420 dentro de uma transação ---'

BEGIN;
    INSERT INTO emprestimo_simples (tombo, nome_usuario, data_retirada)
    VALUES (4420, 'Célia Reis', DATE '2026-03-15');

    UPDATE livro SET situacao = 'emprestado' WHERE tombo = 4420;
COMMIT;

SELECT tombo, situacao FROM livro WHERE tombo = 4420;
-- Agora está 'emprestado', e existe a linha do empréstimo. Os dois, juntos.

-- -------------------------------------------------------------
-- 2. Uma transação desfeita: o ROLLBACK apaga o que ainda não valia
-- -------------------------------------------------------------
\echo '--- 2. Uma devolução registrada por engano, e desfeita ---'

BEGIN;
    UPDATE livro SET situacao = 'disponivel' WHERE tombo = 4420;

    -- Dentro da transação, a mudança já é visível PARA VOCÊ:
    SELECT tombo, situacao AS dentro_da_transacao FROM livro WHERE tombo = 4420;
ROLLBACK;

-- E depois do ROLLBACK, é como se nada tivesse acontecido:
SELECT tombo, situacao AS depois_do_rollback FROM livro WHERE tombo = 4420;

-- -------------------------------------------------------------
-- 3. O banco recusando o que não pode: a transação inteira cai
-- -------------------------------------------------------------
\echo '--- 3. Uma transação que o próprio banco aborta ---'

BEGIN;
    UPDATE livro SET situacao = 'manutencao' WHERE tombo = 4417;
    -- A linha abaixo viola o CHECK de situacao e derruba a transação inteira,
    -- inclusive o UPDATE acima, que sozinho estava correto:
    UPDATE livro SET situacao = 'perdido' WHERE tombo = 4418;
COMMIT;
