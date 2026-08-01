-- =============================================================
-- Aula 15 — Junções e agregação
--
-- Requer 02-ddl.sql e 03-carga.sql (Aula 13).
--
-- Como rodar:
--     psql -d curso_bd -v ON_ERROR_STOP=1 -f 05-juncoes-agregacao.sql
-- =============================================================

-- -------------------------------------------------------------
-- 1. INNER JOIN — desfazendo o que a normalização separou
-- -------------------------------------------------------------
\echo '--- 1a. Empréstimos com o nome do usuário (duas tabelas) ---'
SELECT e.id_emprestimo, u.nome, e.data_retirada
  FROM emprestimo e
  JOIN usuario u ON u.matricula = e.matricula
 ORDER BY e.id_emprestimo;

\echo '--- 1b. Quem está com o quê (quatro tabelas) ---'
SELECT u.nome AS usuario, o.titulo AS obra, x.tombo, e.data_prevista
  FROM emprestimo e
  JOIN usuario  u ON u.matricula = e.matricula
  JOIN exemplar x ON x.tombo     = e.tombo
  JOIN obra     o ON o.isbn      = x.isbn
 WHERE e.data_devolucao IS NULL
 ORDER BY e.data_prevista;

-- -------------------------------------------------------------
-- 2. LEFT JOIN — o que o INNER JOIN esconde
-- -------------------------------------------------------------
\echo '--- 2a. INNER JOIN: obras COM autor (a obra de Estatística some) ---'
SELECT o.titulo, a.nome AS autor
  FROM obra o
  JOIN escrita s ON s.isbn     = o.isbn
  JOIN autor   a ON a.id_autor = s.id_autor
 ORDER BY o.titulo, s.ordem;

\echo '--- 2b. LEFT JOIN: TODAS as obras, com autor quando houver ---'
SELECT o.titulo, a.nome AS autor
  FROM obra o
  LEFT JOIN escrita s ON s.isbn     = o.isbn
  LEFT JOIN autor   a ON a.id_autor = s.id_autor
 ORDER BY o.titulo, s.ordem;

\echo '--- 2c. O uso clássico: encontrar o que NÃO tem par ---'
SELECT o.isbn, o.titulo
  FROM obra o
  LEFT JOIN escrita s ON s.isbn = o.isbn
 WHERE s.isbn IS NULL;

-- -------------------------------------------------------------
-- 3. Agregação: contar, somar, medir
-- -------------------------------------------------------------
\echo '--- 3a. Números gerais do acervo ---'
SELECT count(*)                AS total_emprestimos,
       count(data_devolucao)   AS ja_devolvidos,
       min(data_retirada)      AS primeiro,
       max(data_retirada)      AS ultimo
  FROM emprestimo;

-- -------------------------------------------------------------
-- 4. GROUP BY — um resultado por grupo
-- -------------------------------------------------------------
\echo '--- 4a. Exemplares por obra ---'
SELECT o.titulo, count(x.tombo) AS exemplares
  FROM obra o
  LEFT JOIN exemplar x ON x.isbn = o.isbn
 GROUP BY o.isbn, o.titulo
 ORDER BY exemplares DESC, o.titulo;

\echo '--- 4b. Empréstimos por categoria de usuário ---'
SELECT u.categoria, count(*) AS emprestimos
  FROM emprestimo e
  JOIN usuario u ON u.matricula = e.matricula
 GROUP BY u.categoria
 ORDER BY emprestimos DESC;

-- -------------------------------------------------------------
-- 5. HAVING — filtrar os grupos, não as linhas
-- -------------------------------------------------------------
\echo '--- 5. Obras com mais de um exemplar ---'
SELECT o.titulo, count(x.tombo) AS exemplares
  FROM obra o
  JOIN exemplar x ON x.isbn = o.isbn
 GROUP BY o.isbn, o.titulo
HAVING count(x.tombo) > 1
 ORDER BY exemplares DESC;

-- -------------------------------------------------------------
-- 6. Subconsulta e VIEW
-- -------------------------------------------------------------
\echo '--- 6a. Usuários que nunca pegaram nada emprestado ---'
SELECT u.matricula, u.nome
  FROM usuario u
 WHERE NOT EXISTS (SELECT 1 FROM emprestimo e WHERE e.matricula = u.matricula)
 ORDER BY u.nome;

\echo '--- 6b. Uma VIEW: o nível externo da Aula 10, virando comando ---'
CREATE OR REPLACE VIEW emprestimos_em_aberto AS
SELECT e.id_emprestimo,
       u.nome  AS usuario,
       o.titulo AS obra,
       e.data_prevista,
       CURRENT_DATE - e.data_prevista AS dias_de_atraso
  FROM emprestimo e
  JOIN usuario  u ON u.matricula = e.matricula
  JOIN exemplar x ON x.tombo     = e.tombo
  JOIN obra     o ON o.isbn      = x.isbn
 WHERE e.data_devolucao IS NULL;

SELECT * FROM emprestimos_em_aberto ORDER BY dias_de_atraso DESC;
