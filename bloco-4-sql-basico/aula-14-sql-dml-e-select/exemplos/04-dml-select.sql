-- =============================================================
-- Aula 14 — DML e o SELECT simples
--
-- Requer 02-ddl.sql e 03-carga.sql (Aula 13).
--
-- 📌 As demonstrações que ALTERAM dados estão dentro de
--    BEGIN ... ROLLBACK, para o seu banco continuar igual ao
--    do resto do curso. É a Aula 12 servindo de rede de segurança.
--
-- Como rodar:
--     psql -d curso_bd -v ON_ERROR_STOP=1 -f 04-dml-select.sql
-- =============================================================

-- -------------------------------------------------------------
-- 1. INSERT — sempre com a lista de colunas
-- -------------------------------------------------------------
\echo '--- 1. INSERT ---'
BEGIN;
    INSERT INTO usuario (matricula, nome, email, categoria)
    VALUES ('202500100', 'Joana Ribeiro', 'joana.ribeiro@escola.br', 'aluno');

    -- Várias linhas de uma vez
    INSERT INTO area (codigo_area, nome) VALUES
        ('IA',  'Inteligência Artificial'),
        ('SEG', 'Segurança da Informação');

    SELECT count(*) AS usuarios_apos_insert FROM usuario;
ROLLBACK;

-- -------------------------------------------------------------
-- 2. UPDATE — o WHERE não é opcional
-- -------------------------------------------------------------
\echo '--- 2. UPDATE: primeiro conferir, depois alterar ---'
BEGIN;
    -- O hábito que salva carreiras: escreva como SELECT antes
    SELECT tombo, situacao FROM exemplar WHERE tombo = 4421;

    UPDATE exemplar SET situacao = 'disponivel' WHERE tombo = 4421;
    SELECT tombo, situacao FROM exemplar WHERE tombo = 4421;

    -- Registrando uma devolução: duas colunas de uma vez
    UPDATE emprestimo
       SET data_devolucao = DATE '2026-03-14'
     WHERE id_emprestimo = 1;
ROLLBACK;

-- -------------------------------------------------------------
-- 3. DELETE
-- -------------------------------------------------------------
\echo '--- 3. DELETE ---'
BEGIN;
    DELETE FROM reserva WHERE situacao = 'cancelada';
    SELECT count(*) AS reservas_restantes FROM reserva;
ROLLBACK;

-- -------------------------------------------------------------
-- 4. SELECT, WHERE, ORDER BY
-- -------------------------------------------------------------
\echo '--- 4. Obras publicadas a partir de 2011, da mais nova para a mais antiga ---'
SELECT titulo, ano_publicacao, editora
  FROM obra
 WHERE ano_publicacao >= 2011
 ORDER BY ano_publicacao DESC;

-- -------------------------------------------------------------
-- 5. IS NULL, LIKE, BETWEEN, IN
-- -------------------------------------------------------------
\echo '--- 5a. Empréstimos em aberto (data_devolucao vazia) ---'
SELECT id_emprestimo, matricula, tombo, data_prevista
  FROM emprestimo
 WHERE data_devolucao IS NULL
 ORDER BY data_prevista;

\echo '--- 5b. O mesmo, com = NULL: devolve ZERO linhas, sem erro ---'
SELECT id_emprestimo FROM emprestimo WHERE data_devolucao = NULL;

\echo '--- 5c. LIKE, BETWEEN e IN ---'
SELECT titulo FROM obra WHERE titulo LIKE '%Software%';
SELECT titulo, ano_publicacao FROM obra WHERE ano_publicacao BETWEEN 2010 AND 2015;
SELECT nome, categoria FROM usuario WHERE categoria IN ('professor', 'servidor');

-- -------------------------------------------------------------
-- 6. DISTINCT e LIMIT
-- -------------------------------------------------------------
\echo '--- 6. Editoras distintas, e os 3 exemplares mais antigos ---'
SELECT DISTINCT editora FROM obra ORDER BY editora;

SELECT tombo, data_aquisicao
  FROM exemplar
 ORDER BY data_aquisicao
 LIMIT 3;
