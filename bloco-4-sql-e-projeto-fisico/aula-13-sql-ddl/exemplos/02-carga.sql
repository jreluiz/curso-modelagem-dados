-- =============================================================================
-- Aula 13 — Biblioteca Universitária: carga de dados
--
-- Rode DEPOIS do 01-ddl.sql:
--   psql -d curso_bd -v ON_ERROR_STOP=1 -f 02-carga.sql
--
-- A ORDEM DOS INSERTS NÃO É ARBITRÁRIA: primeiro as tabelas referenciadas,
-- depois as que referenciam. Inverter produz "violates foreign key constraint".
-- =============================================================================

-- ── 1. Entidades fortes sem dependências ────────────────────────────────────

INSERT INTO usuario (matricula, nome, email, data_cadastro, tipo) VALUES
    (2023101, 'Ana Souza',        'ana.souza@uni.br',    '2023-03-01', 'aluno'),
    (2023102, 'Bruno Lima',       'bruno.lima@uni.br',   '2023-03-01', 'aluno'),
    (2024007, 'Celia Reis',       'celia.reis@uni.br',   '2024-08-12', 'aluno'),
    (1998044, 'Daniel Moreira',   'daniel.m@uni.br',     '1998-02-10', 'professor'),
    (2005033, 'Eliane Castro',    'eliane.c@uni.br',     '2005-06-20', 'professor'),
    (2010015, 'Fabio Nogueira',   'fabio.n@uni.br',      '2010-01-15', 'servidor');

INSERT INTO funcionario (matricula_func, nome, cargo) VALUES
    (900, 'Gabriela Pinto', 'Atendente'),
    (901, 'Heitor Alves',   'Bibliotecario'),
    (902, 'Iara Mendes',    'Supervisora');

INSERT INTO obra (isbn, titulo, ano_publicacao, editora) VALUES
    ('978-85-1234-567-8', 'Fundamentos de Bancos de Dados', 2003, 'Editora da Unicamp'),
    ('978-85-9999-111-2', 'Projeto de Algoritmos',          2004, 'Cengage'),
    ('978-85-7522-333-4', 'Engenharia de Software',         2011, 'Pearson'),
    ('978-85-4455-777-1', 'Redes de Computadores',          2020, 'Bookman'),
    ('978-85-3311-888-9', 'Sistemas Operacionais',          2020, 'LTC'),
    ('978-85-2200-444-5', 'Inteligencia Artificial',        2021, 'Campus');

INSERT INTO autor (nome, nacionalidade) VALUES
    ('Celio Cardoso Guimaraes', 'Brasileira'),   -- id 1
    ('Nivio Ziviani',           'Brasileira'),   -- id 2
    ('Ian Sommerville',         'Britanica'),    -- id 3
    ('Andrew Tanenbaum',        'Holandesa'),    -- id 4
    ('Stuart Russell',          'Britanica'),    -- id 5
    ('Peter Norvig',            'Norte-americana'); -- id 6

INSERT INTO area (codigo_area, nome) VALUES
    ('BD',  'Bancos de Dados'),
    ('ALG', 'Algoritmos e Estruturas de Dados'),
    ('ES',  'Engenharia de Software'),
    ('RED', 'Redes de Computadores'),
    ('SO',  'Sistemas Operacionais'),
    ('IA',  'Inteligencia Artificial');


-- ── 2. Subclasses e entidade fraca (dependem de usuario) ────────────────────

INSERT INTO aluno (matricula, curso, semestre_ingresso) VALUES
    (2023101, 'Sistemas de Informacao', '2023.1'),
    (2023102, 'Sistemas de Informacao', '2023.1'),
    (2024007, 'Administracao',          '2024.2');

INSERT INTO professor (matricula, departamento, titulacao) VALUES
    (1998044, 'Computacao', 'doutorado'),
    (2005033, 'Computacao', 'mestrado');

INSERT INTO servidor (matricula, setor) VALUES
    (2010015, 'Secretaria Academica');

INSERT INTO telefone (matricula, numero, tipo) VALUES
    (2023101, '(19) 99999-0101', 'celular'),
    (2023101, '(19) 3399-1111',  'residencial'),
    (2023102, '(19) 99999-0102', 'celular'),
    (1998044, '(19) 99888-4444', 'celular'),
    (2010015, '(19) 3521-0000',  'recado');


-- ── 3. Exemplares (dependem de obra) ────────────────────────────────────────
-- Repare: a obra 'Inteligencia Artificial' NÃO tem exemplar. É proposital —
-- exercita o LEFT JOIN da Aula 14 e o (0,N) decidido na Aula 08.

INSERT INTO exemplar (tombo, isbn, data_aquisicao, situacao) VALUES
    (4417, '978-85-1234-567-8', '2015-04-10', 'emprestado'),
    (4418, '978-85-1234-567-8', '2015-04-10', 'emprestado'),
    (4419, '978-85-1234-567-8', '2018-09-02', 'disponivel'),
    (4420, '978-85-9999-111-2', '2016-02-20', 'emprestado'),
    (4421, '978-85-9999-111-2', '2016-02-20', 'disponivel'),
    (4422, '978-85-7522-333-4', '2019-08-15', 'disponivel'),
    (4423, '978-85-4455-777-1', '2021-03-11', 'emprestado'),
    (4424, '978-85-4455-777-1', '2021-03-11', 'manutencao'),
    (4425, '978-85-3311-888-9', '2022-05-30', 'disponivel');


-- ── 4. Tabelas associativas (dependem de obra + autor / obra + area) ────────

INSERT INTO escrita (isbn, id_autor, ordem) VALUES
    ('978-85-1234-567-8', 1, 1),
    ('978-85-9999-111-2', 2, 1),
    ('978-85-7522-333-4', 3, 1),
    ('978-85-4455-777-1', 4, 1),
    ('978-85-3311-888-9', 4, 1),
    ('978-85-2200-444-5', 5, 1),
    ('978-85-2200-444-5', 6, 2);   -- dois autores, e a ordem importa

INSERT INTO classificacao (isbn, codigo_area) VALUES
    ('978-85-1234-567-8', 'BD'),
    ('978-85-1234-567-8', 'ES'),   -- uma obra em duas áreas
    ('978-85-9999-111-2', 'ALG'),
    ('978-85-7522-333-4', 'ES'),
    ('978-85-4455-777-1', 'RED'),
    ('978-85-3311-888-9', 'SO'),
    ('978-85-2200-444-5', 'IA');


-- ── 5. Empréstimos (dependem de usuario, exemplar e funcionario) ────────────
-- Celia Reis (2024007) NUNCA pegou nada: exercita o NOT EXISTS da Aula 14.

INSERT INTO emprestimo (matricula, tombo, matricula_func,
                        data_retirada, data_prevista, data_devolucao) VALUES
    (2023101, 4417, 900, '2026-06-01', '2026-06-15', '2026-06-14'),  -- devolvido em dia
    (2023101, 4420, 900, '2026-07-01', '2026-07-15', NULL),          -- em aberto
    (2023102, 4418, 901, '2026-05-20', '2026-06-03', '2026-06-10'),  -- devolvido com atraso
    (2023102, 4423, 900, '2026-07-10', '2026-07-24', NULL),          -- em aberto
    (1998044, 4419, 901, '2026-04-01', '2026-05-31', '2026-05-28'),  -- professor: 60 dias
    (1998044, 4417, 902, '2026-06-20', '2026-08-19', NULL),          -- em aberto
    (2010015, 4421, 900, '2026-03-05', '2026-03-19', '2026-03-18'),
    (2010015, 4422, 901, '2026-02-01', '2026-02-15', '2026-03-01'),  -- atraso grande
    -- Este empréstimo faz de Bruno Lima o único usuário que pegou exemplares
    -- das DUAS obras de 2020 (Redes, tombo 4423, e Sistemas Operacionais).
    -- É o que dá um resultado não vazio à divisão relacional da Aula 14.
    (2023102, 4425, 901, '2026-06-05', '2026-06-19', '2026-06-18');


-- ── 6. Renovações e multas (dependem de emprestimo) ─────────────────────────
-- Os ids são gerados por IDENTITY na ordem dos INSERTs acima: 1 a 8.

INSERT INTO renovacao (id_emprestimo, sequencia, data_renovacao, nova_data_prevista) VALUES
    (5, 1, '2026-04-25', '2026-05-15'),
    (5, 2, '2026-05-14', '2026-05-31'),
    (6, 1, '2026-07-15', '2026-08-19');

-- Multa do empréstimo 3 (7 dias de atraso): paga.
-- Multa do empréstimo 8 (14 dias de atraso): perdoada pela supervisora.
INSERT INTO multa (id_emprestimo, valor, data_pagamento,
                   justificativa_perdao, matricula_func) VALUES
    (3,  3.50, '2026-06-11', NULL, NULL),
    (8,  7.00, NULL, 'Usuario esteve em licenca medica no periodo', 902);


-- ── 7. Reservas (dependem de usuario e obra) ────────────────────────────────
-- Reserva é da OBRA, nunca do exemplar (regra do minimundo).

INSERT INTO reserva (matricula, isbn, data_solicitacao, situacao) VALUES
    (2023102, '978-85-1234-567-8', '2026-07-05', 'aguardando'),
    (2024007, '978-85-4455-777-1', '2026-07-12', 'aguardando'),
    (2005033, '978-85-1234-567-8', '2026-06-01', 'atendida'),
    (2023101, '978-85-7522-333-4', '2026-01-10', 'expirada');


-- ── Conferência ─────────────────────────────────────────────────────────────

SELECT 'usuario' AS tabela, COUNT(*) FROM usuario
UNION ALL SELECT 'funcionario',   COUNT(*) FROM funcionario
UNION ALL SELECT 'obra',          COUNT(*) FROM obra
UNION ALL SELECT 'autor',         COUNT(*) FROM autor
UNION ALL SELECT 'area',          COUNT(*) FROM area
UNION ALL SELECT 'aluno',         COUNT(*) FROM aluno
UNION ALL SELECT 'professor',     COUNT(*) FROM professor
UNION ALL SELECT 'servidor',      COUNT(*) FROM servidor
UNION ALL SELECT 'telefone',      COUNT(*) FROM telefone
UNION ALL SELECT 'exemplar',      COUNT(*) FROM exemplar
UNION ALL SELECT 'escrita',       COUNT(*) FROM escrita
UNION ALL SELECT 'classificacao', COUNT(*) FROM classificacao
UNION ALL SELECT 'emprestimo',    COUNT(*) FROM emprestimo
UNION ALL SELECT 'renovacao',     COUNT(*) FROM renovacao
UNION ALL SELECT 'multa',         COUNT(*) FROM multa
UNION ALL SELECT 'reserva',       COUNT(*) FROM reserva
ORDER BY 1;
