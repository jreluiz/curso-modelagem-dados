-- O banco da biblioteca, no PostgreSQL — o esquema da Aula 09, seção 6.
-- Dados fictícios. Ordem: primeiro as tabelas que são apontadas, depois as que apontam.

CREATE TABLE usuario (
  codigo  INTEGER      PRIMARY KEY,
  nome    VARCHAR(100) NOT NULL,
  email   VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE aluno (                         -- especialização, estratégia B
  codigo    INTEGER     PRIMARY KEY REFERENCES usuario (codigo) ON DELETE CASCADE,
  matricula CHAR(7)     NOT NULL UNIQUE,     -- chave alternativa
  curso     VARCHAR(60) NOT NULL
);

CREATE TABLE professor (
  codigo       INTEGER     PRIMARY KEY REFERENCES usuario (codigo) ON DELETE CASCADE,
  siape        CHAR(6)     NOT NULL UNIQUE,
  departamento VARCHAR(60) NOT NULL
);

CREATE TABLE editora (
  cnpj   CHAR(14)     PRIMARY KEY,
  nome   VARCHAR(100) NOT NULL,
  rua    VARCHAR(100),                       -- o endereço composto, uma coluna por parte
  numero VARCHAR(10),
  cidade VARCHAR(60)
);

CREATE TABLE editora_telefone (              -- o atributo multivalorado
  cnpj     CHAR(14)    REFERENCES editora (cnpj) ON DELETE CASCADE,
  telefone VARCHAR(20),
  PRIMARY KEY (cnpj, telefone)
);

CREATE TABLE autor (
  cpf           CHAR(11)    PRIMARY KEY,
  nome          VARCHAR(60) NOT NULL,
  sobrenome     VARCHAR(60) NOT NULL,
  nacionalidade VARCHAR(40)
);

CREATE TABLE livro (
  isbn   CHAR(13)     PRIMARY KEY,
  titulo VARCHAR(200) NOT NULL,
  ano    INTEGER      CHECK (ano BETWEEN 1450 AND 2100),
  cnpj   CHAR(14)     NOT NULL REFERENCES editora (cnpj) ON DELETE RESTRICT
);

CREATE TABLE escreve (                       -- o N:M, com o atributo do losango
  cpf   CHAR(11) REFERENCES autor (cpf),
  isbn  CHAR(13) REFERENCES livro (isbn) ON DELETE CASCADE,
  ordem INTEGER  NOT NULL,
  PRIMARY KEY (cpf, isbn)
);

CREATE TABLE exemplar (                      -- a entidade fraca
  isbn      CHAR(13)    REFERENCES livro (isbn) ON DELETE CASCADE,
  numero_ex INTEGER,
  situacao  VARCHAR(20) NOT NULL
            CHECK (situacao IN ('disponivel', 'emprestado', 'em reparo', 'descartado')),
  PRIMARY KEY (isbn, numero_ex)
);

CREATE TABLE emprestimo (
  numero         INTEGER  PRIMARY KEY,
  data_retirada  DATE     NOT NULL,
  data_devolucao DATE,                       -- vazia enquanto o empréstimo está em aberto
  codigo_usuario INTEGER  NOT NULL REFERENCES usuario (codigo) ON DELETE RESTRICT,
  isbn           CHAR(13) NOT NULL,
  numero_ex      INTEGER  NOT NULL,
  FOREIGN KEY (isbn, numero_ex) REFERENCES exemplar (isbn, numero_ex) ON DELETE RESTRICT
);

CREATE TABLE oficina (
  codigo           INTEGER      PRIMARY KEY,
  tema             VARCHAR(100) NOT NULL,
  data             DATE         NOT NULL,
  codigo_professor INTEGER      NOT NULL REFERENCES professor (codigo)
);

-- ── Dados fictícios ──────────────────────────────────────────────────────────

INSERT INTO usuario VALUES
  (1, 'Ana Souza',     'ana@aluno.br'),
  (2, 'Bruno Lima',    'bruno@aluno.br'),
  (3, 'Carla Dias',    'carla@aluno.br'),
  (4, 'Carlos Mendes', 'carlos@prof.br'),
  (5, 'Dora Alves',    'dora@prof.br'),
  (6, 'Eduardo Reis',  'eduardo@aluno.br');

INSERT INTO aluno VALUES
  (1, '2023101', 'ADS'),
  (2, '2023102', 'Direito'),
  (3, '2024015', 'ADS'),
  (4, '2025001', 'Mestrado em Computação'),  -- Carlos é professor E aluno: sobreposta
  (6, '2024030', 'Letras');

INSERT INTO professor VALUES
  (4, '104577', 'Computação'),
  (5, '118930', 'Letras');

INSERT INTO editora VALUES
  ('11111111000101', 'Editora Aurora',     'Rua das Flores', '100',  'Porto Alegre'),
  ('22222222000102', 'Editora Vértice',    'Av. Central',    '2500', 'São Paulo'),
  ('33333333000103', 'Editora Ponte Alta', NULL,             NULL,   'Curitiba');

INSERT INTO editora_telefone VALUES
  ('11111111000101', '(51) 3000-1000'),
  ('11111111000101', '(51) 3000-1001'),
  ('22222222000102', '(11) 4000-2000');

INSERT INTO autor VALUES
  ('11111111111', 'Marta', 'Ribeiro',   'brasileira'),
  ('22222222222', 'João',  'Pereira',   'brasileira'),
  ('33333333333', 'Lucía', 'Fernández', 'argentina'),
  ('44444444444', 'Paulo', 'Matos',     'portuguesa');

INSERT INTO livro VALUES
  ('9780000000017', 'Introdução aos Bancos de Dados', 2012, '11111111000101'),
  ('9780000000024', 'Modelagem na Prática',           2019, '11111111000101'),
  ('9780000000031', 'SQL para Iniciantes',            2021, '22222222000102'),
  ('9780000000048', 'Algoritmos em Português',        2008, '22222222000102'),
  ('9780000000055', 'História da Computação',         2016, '33333333000103'),
  ('9780000000062', 'Projeto de Sistemas',            2023, '33333333000103');

INSERT INTO escreve VALUES
  ('11111111111', '9780000000017', 1),
  ('22222222222', '9780000000017', 2),
  ('11111111111', '9780000000024', 1),
  ('33333333333', '9780000000031', 1),
  ('22222222222', '9780000000048', 1),
  ('44444444444', '9780000000055', 1),
  ('33333333333', '9780000000062', 1),
  ('44444444444', '9780000000062', 2);

INSERT INTO exemplar VALUES
  ('9780000000017', 1, 'emprestado'),
  ('9780000000017', 2, 'disponivel'),
  ('9780000000024', 1, 'emprestado'),
  ('9780000000031', 1, 'disponivel'),
  ('9780000000031', 2, 'emprestado'),
  ('9780000000048', 1, 'em reparo'),
  ('9780000000055', 1, 'disponivel'),
  ('9780000000062', 1, 'emprestado'),
  ('9780000000062', 2, 'disponivel');

INSERT INTO emprestimo VALUES
  (1, '2026-10-05', '2026-10-19', 1, '9780000000017', 1),
  (2, '2026-10-20', NULL,         1, '9780000000017', 1),
  (3, '2026-11-03', '2026-11-10', 2, '9780000000031', 1),
  (4, '2026-11-20', NULL,         3, '9780000000024', 1),
  (5, '2026-11-05', NULL,         4, '9780000000031', 2),
  (6, '2026-11-28', NULL,         6, '9780000000062', 1),
  (7, '2026-09-15', '2026-09-29', 5, '9780000000055', 1);

INSERT INTO oficina VALUES
  (1, 'Pesquisa em bases de dados', '2026-11-12', 4),
  (2, 'Normas de citação',          '2026-11-19', 5);
