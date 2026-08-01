-- =============================================================
-- Aula 13 — Carga de dados da Biblioteca Universitária
--
-- Requer que 02-ddl.sql já tenha rodado.
--
-- A ORDEM DOS INSERTS É A ORDEM DAS DEPENDÊNCIAS: primeiro as
-- tabelas referenciadas, depois as que referenciam. Inverter isso
-- produz "violates foreign key constraint".
--
-- Como rodar:
--     psql -d curso_bd -v ON_ERROR_STOP=1 -f 03-carga.sql
-- =============================================================

TRUNCATE multa, renovacao, reserva, emprestimo, exemplar,
         classificacao, escrita, area, autor, obra,
         telefone, funcionario, usuario RESTART IDENTITY CASCADE;

-- -------------------------------------------------------------
-- 1. Tabelas sem dependência
-- -------------------------------------------------------------
INSERT INTO usuario (matricula, nome, email, categoria, data_cadastro) VALUES
    ('202310100', 'Ana Souza',      'ana.souza@escola.br',   'aluno',     DATE '2023-02-14'),
    ('202310200', 'Bruno Lima',     'bruno.lima@escola.br',  'aluno',     DATE '2023-02-14'),
    ('202400700', 'Célia Reis',     'celia.reis@escola.br',  'aluno',     DATE '2024-02-19'),
    ('100200300', 'Daniel Prado',   'daniel.prado@escola.br','professor', DATE '2019-03-04'),
    ('100200400', 'Elena Vaz',      'elena.vaz@escola.br',   'professor', DATE '2020-08-10'),
    ('900100100', 'Fábio Nunes',    'fabio.nunes@escola.br', 'servidor',  DATE '2018-01-22');

INSERT INTO funcionario (matricula_func, nome, cargo) VALUES
    ('700100100', 'Gabriela Alves', 'bibliotecária'),
    ('700100200', 'Heitor Campos',  'auxiliar'),
    ('700100300', 'Iara Menezes',   'coordenadora');

INSERT INTO obra (isbn, titulo, ano_publicacao, editora) VALUES
    ('978-85-1111-111-1', 'Fundamentos de Bancos de Dados', 2008, 'Editora da Unicamp'),
    ('978-85-2222-222-2', 'Engenharia de Software',         2018, 'Pearson'),
    ('978-85-3333-333-3', 'Redes de Computadores',          2011, 'Pearson'),
    ('978-85-4444-444-4', 'Projeto de Algoritmos',          2010, 'Cengage'),
    ('978-85-5555-555-5', 'Introdução à Estatística',       2015, 'LTC');

INSERT INTO autor (nome, nacionalidade) VALUES
    ('Célio C. Guimarães', 'brasileira'),
    ('Ian Sommerville',    'britânica'),
    ('Andrew Tanenbaum',   'holandesa'),
    ('David Wetherall',    'britânica'),
    ('Nivio Ziviani',      'brasileira');

INSERT INTO area (codigo_area, nome) VALUES
    ('BD',  'Banco de Dados'),
    ('ES',  'Engenharia de Software'),
    ('RC',  'Redes de Computadores'),
    ('ALG', 'Algoritmos'),
    ('EST', 'Estatística');

-- -------------------------------------------------------------
-- 2. Tabelas que dependem das anteriores
-- -------------------------------------------------------------
INSERT INTO telefone (matricula, numero, tipo) VALUES
    ('202310100', '(11) 99999-1111', 'celular'),
    ('202310100', '(11) 3399-1111',  'residencial'),
    ('202310200', '(11) 99999-2222', 'celular'),
    ('100200300', '(11) 3399-3000',  'recado');

INSERT INTO escrita (isbn, id_autor, ordem) VALUES
    ('978-85-1111-111-1', 1, 1),
    ('978-85-2222-222-2', 2, 1),
    ('978-85-3333-333-3', 3, 1),
    ('978-85-3333-333-3', 4, 2),   -- Tanenbaum é o 1º, Wetherall o 2º
    ('978-85-4444-444-4', 5, 1);

INSERT INTO classificacao (isbn, codigo_area) VALUES
    ('978-85-1111-111-1', 'BD'),
    ('978-85-1111-111-1', 'ALG'),  -- a mesma obra em duas áreas
    ('978-85-2222-222-2', 'ES'),
    ('978-85-3333-333-3', 'RC'),
    ('978-85-4444-444-4', 'ALG'),
    ('978-85-5555-555-5', 'EST');

INSERT INTO exemplar (tombo, isbn, data_aquisicao, situacao) VALUES
    (4417, '978-85-1111-111-1', DATE '2019-04-10', 'emprestado'),
    (4418, '978-85-2222-222-2', DATE '2019-04-10', 'emprestado'),
    (4419, '978-85-1111-111-1', DATE '2021-08-03', 'emprestado'),
    (4420, '978-85-3333-333-3', DATE '2022-02-17', 'disponivel'),
    (4421, '978-85-4444-444-4', DATE '2022-02-17', 'manutencao'),
    (4422, '978-85-3333-333-3', DATE '2023-09-01', 'emprestado'),
    (4423, '978-85-5555-555-5', DATE '2024-03-12', 'disponivel');
    -- Repare: a obra 978-85-5555-555-5 tem exemplar, mas nenhum autor cadastrado

-- -------------------------------------------------------------
-- 3. Circulação
-- -------------------------------------------------------------
INSERT INTO emprestimo (matricula, tombo, matricula_func, data_retirada, data_prevista, data_devolucao) VALUES
    ('202310100', 4417, '700100100', DATE '2026-03-02', DATE '2026-03-16', NULL),
    ('202310100', 4418, '700100100', DATE '2026-03-02', DATE '2026-03-16', NULL),
    ('202310200', 4419, '700100200', DATE '2026-03-09', DATE '2026-03-23', NULL),
    ('100200300', 4422, '700100100', DATE '2026-01-15', DATE '2026-03-15', NULL),
    ('202400700', 4420, '700100300', DATE '2026-02-10', DATE '2026-02-24', DATE '2026-02-20'),
    ('202310200', 4421, '700100200', DATE '2026-01-05', DATE '2026-01-19', DATE '2026-02-02');
    -- O último foi devolvido com 14 dias de atraso: gera multa

INSERT INTO renovacao (id_emprestimo, sequencia, data_renovacao, nova_data_prevista) VALUES
    (4, 1, DATE '2026-02-14', DATE '2026-03-15');

INSERT INTO reserva (matricula, isbn, data_solicitacao, situacao) VALUES
    ('100200400', '978-85-1111-111-1', DATE '2026-03-05', 'aguardando'),
    ('900100100', '978-85-1111-111-1', DATE '2026-03-08', 'aguardando'),
    ('202400700', '978-85-2222-222-2', DATE '2026-03-06', 'cancelada');

INSERT INTO multa (id_emprestimo, valor, data_pagamento, justificativa_perdao, matricula_func) VALUES
    (6, 14.00, NULL, 'Aluno em afastamento médico comprovado', '700100300');

-- -------------------------------------------------------------
-- Conferência: as contagens de todas as tabelas
-- -------------------------------------------------------------
\echo '--- Linhas por tabela ---'
SELECT 'usuario' AS tabela, count(*) FROM usuario
UNION ALL SELECT 'telefone',      count(*) FROM telefone
UNION ALL SELECT 'funcionario',   count(*) FROM funcionario
UNION ALL SELECT 'obra',          count(*) FROM obra
UNION ALL SELECT 'autor',         count(*) FROM autor
UNION ALL SELECT 'escrita',       count(*) FROM escrita
UNION ALL SELECT 'area',          count(*) FROM area
UNION ALL SELECT 'classificacao', count(*) FROM classificacao
UNION ALL SELECT 'exemplar',      count(*) FROM exemplar
UNION ALL SELECT 'emprestimo',    count(*) FROM emprestimo
UNION ALL SELECT 'renovacao',     count(*) FROM renovacao
UNION ALL SELECT 'reserva',       count(*) FROM reserva
UNION ALL SELECT 'multa',         count(*) FROM multa;
