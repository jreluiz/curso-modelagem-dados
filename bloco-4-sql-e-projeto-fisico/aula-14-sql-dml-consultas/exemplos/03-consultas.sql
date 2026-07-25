-- =============================================================================
-- Aula 14 — Consultas sobre a Biblioteca Universitária
--
-- Rode DEPOIS de 01-ddl.sql e 02-carga.sql:
--   psql -d curso_bd -f 03-consultas.sql
--
-- Cada consulta traz, em comentário, a pergunta que ela responde em português
-- e a expressão equivalente da álgebra relacional (Aula 11), quando existe.
-- =============================================================================

\echo '===== 1. SELECT simples: obras publicadas depois de 2010 ====='
-- Álgebra:  π titulo, ano_publicacao ( σ ano_publicacao > 2010 (OBRA) )
SELECT titulo, ano_publicacao
FROM obra
WHERE ano_publicacao > 2010
ORDER BY ano_publicacao DESC, titulo;


\echo '===== 2. Apelido no ORDER BY funciona; no WHERE, não ====='
-- O SELECT é executado quase por último — por isso o apelido não existe
-- ainda quando o WHERE roda, mas já existe quando o ORDER BY roda.
SELECT titulo, ano_publicacao AS ano
FROM obra
ORDER BY ano DESC
LIMIT 3;


\echo '===== 3. Junção de quatro tabelas: quem está com o quê, em aberto ====='
-- "Nome do usuário, título da obra e data de retirada dos empréstimos
--  que ainda não foram devolvidos."
-- Álgebra: π nome,titulo ( σ data_devolucao IS NULL (EMPRESTIMO) ⋈ EXEMPLAR ⋈ OBRA ⋈ USUARIO )
-- Regra: 4 tabelas exigem 3 condições de junção.
SELECT u.nome, o.titulo, e.data_retirada, e.data_prevista
FROM emprestimo e
JOIN usuario  u ON e.matricula = u.matricula
JOIN exemplar x ON e.tombo     = x.tombo
JOIN obra     o ON x.isbn      = o.isbn
WHERE e.data_devolucao IS NULL
ORDER BY e.data_prevista;


\echo '===== 4. LEFT JOIN: TODOS os usuários, inclusive quem nunca pegou nada ====='
-- COUNT(e.id_emprestimo) e não COUNT(*): num LEFT JOIN, quem não tem par
-- gera uma linha de nulos, e COUNT(*) contaria essa linha como 1.
SELECT u.nome,
       u.tipo,
       COUNT(e.id_emprestimo) AS total_emprestimos
FROM usuario u
LEFT JOIN emprestimo e ON u.matricula = e.matricula
GROUP BY u.matricula, u.nome, u.tipo
ORDER BY total_emprestimos DESC, u.nome;


\echo '===== 5. LEFT JOIN: obras sem nenhum exemplar ====='
-- Álgebra:  π titulo (OBRA) − π titulo (OBRA ⋈ EXEMPLAR)
SELECT o.titulo
FROM obra o
LEFT JOIN exemplar x ON o.isbn = x.isbn
WHERE x.tombo IS NULL;

-- A mesma pergunta com EXCEPT, que é literalmente a diferença da álgebra:
SELECT titulo FROM obra
EXCEPT
SELECT o.titulo FROM obra o JOIN exemplar x ON o.isbn = x.isbn;


\echo '===== 6. GROUP BY com HAVING: obras com mais de um exemplar ====='
-- WHERE filtra LINHAS (antes de agrupar); HAVING filtra GRUPOS (depois).
SELECT o.titulo,
       COUNT(x.tombo)                                    AS total,
       COUNT(*) FILTER (WHERE x.situacao = 'disponivel') AS disponiveis
FROM obra o
JOIN exemplar x ON o.isbn = x.isbn
WHERE o.ano_publicacao < 2021
GROUP BY o.isbn, o.titulo
HAVING COUNT(x.tombo) > 1
ORDER BY total DESC;


\echo '===== 7. Agregação por grupo: média de dias de empréstimo por tipo ====='
SELECT u.tipo,
       COUNT(*)                                           AS emprestimos,
       ROUND(AVG(e.data_prevista - e.data_retirada), 1)    AS media_dias_prazo
FROM emprestimo e
JOIN usuario u ON e.matricula = u.matricula
GROUP BY u.tipo
ORDER BY media_dias_prazo DESC;


\echo '===== 8. Subconsulta com IN ====='
SELECT nome
FROM usuario
WHERE matricula IN (SELECT matricula FROM emprestimo WHERE data_devolucao IS NULL)
ORDER BY nome;


\echo '===== 9. Subconsulta correlacionada com EXISTS (mesma pergunta) ====='
SELECT u.nome
FROM usuario u
WHERE EXISTS (SELECT 1 FROM emprestimo e
              WHERE e.matricula = u.matricula AND e.data_devolucao IS NULL)
ORDER BY u.nome;


\echo '===== 10. NOT EXISTS: quem nunca pegou nada emprestado ====='
-- Prefira SEMPRE NOT EXISTS a NOT IN: se a subconsulta do NOT IN devolver
-- um único NULL, o resultado vem VAZIO, sem erro e sem aviso (Aula 09).
SELECT u.nome
FROM usuario u
WHERE NOT EXISTS (SELECT 1 FROM emprestimo e WHERE e.matricula = u.matricula);


\echo '===== 11. Autojunção: obras com mais de um autor, com a ordem da capa ====='
SELECT o.titulo,
       a1.nome AS primeiro_autor,
       a2.nome AS segundo_autor
FROM escrita e1
JOIN escrita e2 ON e1.isbn = e2.isbn AND e1.ordem = 1 AND e2.ordem = 2
JOIN autor a1   ON e1.id_autor = a1.id_autor
JOIN autor a2   ON e2.id_autor = a2.id_autor
JOIN obra  o    ON e1.isbn = o.isbn;


\echo '===== 12. Tabela derivada no FROM ====='
SELECT tipo, ROUND(AVG(total), 2) AS media_por_usuario
FROM (SELECT u.matricula, u.tipo, COUNT(e.id_emprestimo) AS total
      FROM usuario u
      LEFT JOIN emprestimo e ON u.matricula = e.matricula
      GROUP BY u.matricula, u.tipo) AS por_usuario
GROUP BY tipo
ORDER BY media_por_usuario DESC;


\echo '===== 13. VIEW: o nível externo da Aula 02, tornado concreto ====='
CREATE OR REPLACE VIEW emprestimos_em_aberto AS
SELECT u.matricula,
       u.nome,
       o.titulo,
       e.data_retirada,
       e.data_prevista,
       CURRENT_DATE - e.data_prevista AS dias_atraso   -- atributo DERIVADO
FROM emprestimo e
JOIN usuario  u ON e.matricula = u.matricula
JOIN exemplar x ON e.tombo     = x.tombo
JOIN obra     o ON x.isbn      = o.isbn
WHERE e.data_devolucao IS NULL;

-- A junção de quatro tabelas virou um nome:
SELECT nome, titulo, dias_atraso
FROM emprestimos_em_aberto
ORDER BY dias_atraso DESC;

-- E quem está de fato atrasado:
SELECT nome, titulo, dias_atraso
FROM emprestimos_em_aberto
WHERE dias_atraso > 0;


\echo '===== 14. DIVISÃO RELACIONAL: a consulta mais difícil do curso ====='
-- "Quais usuários pegaram emprestado exemplares de TODAS as obras
--  publicadas em 2020?"
--
-- Álgebra:  R ÷ S,  onde
--    R = π matricula, isbn (EMPRESTIMO ⋈ EXEMPLAR)
--    S = π isbn (σ ano_publicacao = 2020 (OBRA))
--
-- Não existe operador ÷ em SQL. Escreve-se com DUPLA NEGAÇÃO:
-- "usuários para os quais NÃO EXISTE obra de 2020 que eles NÃO tenham pego".
SELECT u.nome
FROM usuario u
WHERE NOT EXISTS (
    SELECT 1
    FROM obra o
    WHERE o.ano_publicacao = 2020
      AND NOT EXISTS (
          SELECT 1
          FROM emprestimo e
          JOIN exemplar x ON e.tombo = x.tombo
          WHERE e.matricula = u.matricula
            AND x.isbn      = o.isbn
      )
);
-- Nos dados de carga, as obras de 2020 são 'Redes de Computadores' e
-- 'Sistemas Operacionais'. Só Bruno Lima pegou exemplares das DUAS
-- (tombos 4423 e 4425) — por isso ele é o único no resultado.
--
-- Repare no detalhe que engana: Ana Souza pegou 4 exemplares, mais que Bruno,
-- e mesmo assim não aparece. A divisão não premia quantidade — exige COBERTURA.
-- E Bruno pegou ainda o tombo 4418, que não é de 2020: pegar coisas A MAIS
-- não desclassifica (Aula 11, seção 7).


\echo '===== 15. Relatório: multas por situação ====='
SELECT CASE
           WHEN m.data_pagamento IS NOT NULL       THEN 'paga'
           WHEN m.justificativa_perdao IS NOT NULL THEN 'perdoada'
           ELSE                                         'em aberto'
       END                AS situacao,
       COUNT(*)           AS quantidade,
       SUM(m.valor)       AS total
FROM multa m
GROUP BY 1
ORDER BY total DESC;
