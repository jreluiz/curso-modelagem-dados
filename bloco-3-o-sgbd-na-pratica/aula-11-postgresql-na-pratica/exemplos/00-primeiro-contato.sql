-- =============================================================
-- Aula 11 — Primeiro contato com o PostgreSQL
--
-- ⚠️  NÃO tente entender este arquivo ainda. A linguagem que cria
--     tabelas é a Aula 13; aqui ele serve só para o seu banco ter
--     alguma coisa dentro, e você poder olhar em volta.
--
-- Como rodar:
--     psql -d curso_bd -v ON_ERROR_STOP=1 -f 00-primeiro-contato.sql
-- =============================================================

DROP TABLE IF EXISTS emprestimo_simples;
DROP TABLE IF EXISTS livro;

-- Uma tabela de livros, com as restrições da Aula 04 já declaradas
CREATE TABLE livro (
    tombo    INTEGER      PRIMARY KEY,
    titulo   VARCHAR(120) NOT NULL,
    autor    VARCHAR(80)  NOT NULL,
    ano      INTEGER      CHECK (ano BETWEEN 1450 AND 2100),
    situacao VARCHAR(20)  NOT NULL DEFAULT 'disponivel'
             CHECK (situacao IN ('disponivel', 'emprestado', 'manutencao'))
);

-- E uma tabela de empréstimos, com chave estrangeira para a primeira
CREATE TABLE emprestimo_simples (
    id             SERIAL      PRIMARY KEY,
    tombo          INTEGER     NOT NULL REFERENCES livro (tombo),
    nome_usuario   VARCHAR(80) NOT NULL,
    data_retirada  DATE        NOT NULL DEFAULT CURRENT_DATE,
    data_devolucao DATE
);

INSERT INTO livro (tombo, titulo, autor, ano, situacao) VALUES
    (4417, 'Fundamentos de Bancos de Dados', 'Célio C. Guimarães', 2008, 'emprestado'),
    (4418, 'Engenharia de Software',         'Ian Sommerville',    2018, 'emprestado'),
    (4419, 'Fundamentos de Bancos de Dados', 'Célio C. Guimarães', 2008, 'disponivel'),
    (4420, 'Redes de Computadores',          'Andrew Tanenbaum',   2011, 'disponivel'),
    (4421, 'Algoritmos',                     'Nivio Ziviani',      2010, 'manutencao');

INSERT INTO emprestimo_simples (tombo, nome_usuario, data_retirada, data_devolucao) VALUES
    (4417, 'Ana Souza',  DATE '2026-03-02', NULL),
    (4418, 'Ana Souza',  DATE '2026-03-02', NULL),
    (4419, 'Bruno Lima', DATE '2026-02-10', DATE '2026-02-20');

-- Conferência: se as duas linhas abaixo aparecerem, deu certo.
SELECT count(*) AS livros_cadastrados FROM livro;
SELECT count(*) AS emprestimos_cadastrados FROM emprestimo_simples;
