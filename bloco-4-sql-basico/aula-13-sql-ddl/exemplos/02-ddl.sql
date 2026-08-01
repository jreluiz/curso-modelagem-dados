-- =============================================================
-- Aula 13 — O esquema da Biblioteca Universitária em SQL
--
-- O modelo da Aula 08 (13 tabelas) virando banco de dados.
-- As restrições têm nome próprio: quando uma delas for violada,
-- a mensagem de erro vai dizer QUAL regra do modelo falhou.
--
-- Como rodar:
--     psql -d curso_bd -v ON_ERROR_STOP=1 -f 02-ddl.sql
-- =============================================================

-- As visões vêm primeiro: uma VIEW depende das tabelas que consulta, e o
-- banco recusa apagar uma tabela que ainda tem visão apontando para ela.
-- (Estas nascem na Aula 15; aqui só garantimos que o script rode do zero
--  mesmo depois de você já ter chegado lá. Nada de DROP ... CASCADE — o
--  motivo está na seção 5 desta aula.)
DROP VIEW IF EXISTS relatorio_mensal;
DROP VIEW IF EXISTS emprestimos_em_aberto;

-- Ordem inversa das dependências: primeiro quem aponta, depois quem é apontado
DROP TABLE IF EXISTS multa;
DROP TABLE IF EXISTS renovacao;
DROP TABLE IF EXISTS reserva;
DROP TABLE IF EXISTS emprestimo;
DROP TABLE IF EXISTS exemplar;
DROP TABLE IF EXISTS classificacao;
DROP TABLE IF EXISTS escrita;
DROP TABLE IF EXISTS area;
DROP TABLE IF EXISTS autor;
DROP TABLE IF EXISTS obra;
DROP TABLE IF EXISTS telefone;
DROP TABLE IF EXISTS funcionario;
DROP TABLE IF EXISTS usuario;

-- -------------------------------------------------------------
-- Usuários e seus telefones
-- -------------------------------------------------------------
CREATE TABLE usuario (
    matricula     CHAR(9)      NOT NULL,
    nome          VARCHAR(80)  NOT NULL,
    email         VARCHAR(120) NOT NULL,
    categoria     VARCHAR(10)  NOT NULL,
    data_cadastro DATE         NOT NULL DEFAULT CURRENT_DATE,

    CONSTRAINT usuario_pk        PRIMARY KEY (matricula),
    CONSTRAINT usuario_email_uk  UNIQUE (email),
    CONSTRAINT usuario_categoria_ck
        CHECK (categoria IN ('aluno', 'professor', 'servidor'))
);

CREATE TABLE telefone (
    matricula CHAR(9)     NOT NULL,
    numero    VARCHAR(20) NOT NULL,
    tipo      VARCHAR(15) NOT NULL,

    CONSTRAINT telefone_pk      PRIMARY KEY (matricula, numero),
    CONSTRAINT telefone_tipo_ck CHECK (tipo IN ('celular', 'residencial', 'recado')),
    -- Tabela dependente: sem o usuário, o telefone é um número solto
    CONSTRAINT telefone_usuario_fk FOREIGN KEY (matricula)
        REFERENCES usuario (matricula) ON DELETE CASCADE
);

CREATE TABLE funcionario (
    matricula_func CHAR(9)     NOT NULL,
    nome           VARCHAR(80) NOT NULL,
    cargo          VARCHAR(40) NOT NULL,

    CONSTRAINT funcionario_pk PRIMARY KEY (matricula_func)
);

-- -------------------------------------------------------------
-- Acervo: obras, autores, áreas e exemplares
-- -------------------------------------------------------------
CREATE TABLE obra (
    isbn           VARCHAR(17)  NOT NULL,
    titulo         VARCHAR(150) NOT NULL,
    ano_publicacao INTEGER      NOT NULL,
    editora        VARCHAR(80),

    CONSTRAINT obra_pk     PRIMARY KEY (isbn),
    CONSTRAINT obra_ano_ck CHECK (ano_publicacao BETWEEN 1450 AND 2100)
);

CREATE TABLE autor (
    id_autor     SERIAL,
    nome         VARCHAR(80) NOT NULL,
    nacionalidade VARCHAR(40),

    CONSTRAINT autor_pk PRIMARY KEY (id_autor)
);

CREATE TABLE escrita (
    isbn     VARCHAR(17) NOT NULL,
    id_autor INTEGER     NOT NULL,
    ordem    INTEGER     NOT NULL,

    CONSTRAINT escrita_pk       PRIMARY KEY (isbn, id_autor),
    -- Não existem dois "segundo autor" na mesma obra
    CONSTRAINT escrita_ordem_uk UNIQUE (isbn, ordem),
    CONSTRAINT escrita_ordem_ck CHECK (ordem > 0),
    CONSTRAINT escrita_obra_fk  FOREIGN KEY (isbn)
        REFERENCES obra (isbn) ON DELETE CASCADE,
    CONSTRAINT escrita_autor_fk FOREIGN KEY (id_autor)
        REFERENCES autor (id_autor) ON DELETE RESTRICT
);

CREATE TABLE area (
    codigo_area VARCHAR(10) NOT NULL,
    nome        VARCHAR(60) NOT NULL,

    CONSTRAINT area_pk      PRIMARY KEY (codigo_area),
    CONSTRAINT area_nome_uk UNIQUE (nome)
);

CREATE TABLE classificacao (
    isbn        VARCHAR(17) NOT NULL,
    codigo_area VARCHAR(10) NOT NULL,

    CONSTRAINT classificacao_pk      PRIMARY KEY (isbn, codigo_area),
    CONSTRAINT classificacao_obra_fk FOREIGN KEY (isbn)
        REFERENCES obra (isbn) ON DELETE CASCADE,
    CONSTRAINT classificacao_area_fk FOREIGN KEY (codigo_area)
        REFERENCES area (codigo_area) ON DELETE RESTRICT
);

CREATE TABLE exemplar (
    tombo          INTEGER     NOT NULL,
    isbn           VARCHAR(17) NOT NULL,
    data_aquisicao DATE        NOT NULL,
    situacao       VARCHAR(12) NOT NULL DEFAULT 'disponivel',

    CONSTRAINT exemplar_pk          PRIMARY KEY (tombo),
    CONSTRAINT exemplar_situacao_ck
        CHECK (situacao IN ('disponivel', 'emprestado', 'manutencao', 'extraviado')),
    -- O volume físico existe na prateleira: apagar a obra não o faz sumir
    CONSTRAINT exemplar_obra_fk FOREIGN KEY (isbn)
        REFERENCES obra (isbn) ON DELETE RESTRICT
);

-- -------------------------------------------------------------
-- Circulação: empréstimos, renovações, reservas e multas
-- -------------------------------------------------------------
CREATE TABLE emprestimo (
    id_emprestimo  SERIAL,
    matricula      CHAR(9) NOT NULL,
    tombo          INTEGER NOT NULL,
    matricula_func CHAR(9) NOT NULL,
    data_retirada  DATE    NOT NULL DEFAULT CURRENT_DATE,
    data_prevista  DATE    NOT NULL,
    data_devolucao DATE,                     -- vazia = empréstimo em aberto

    CONSTRAINT emprestimo_pk PRIMARY KEY (id_emprestimo),
    CONSTRAINT emprestimo_prazo_ck    CHECK (data_prevista >= data_retirada),
    CONSTRAINT emprestimo_devolucao_ck
        CHECK (data_devolucao IS NULL OR data_devolucao >= data_retirada),
    -- Apagar um usuário apagaria o histórico: recusa-se. Usuário sai é inativado
    CONSTRAINT emprestimo_usuario_fk FOREIGN KEY (matricula)
        REFERENCES usuario (matricula) ON DELETE RESTRICT,
    CONSTRAINT emprestimo_exemplar_fk FOREIGN KEY (tombo)
        REFERENCES exemplar (tombo) ON DELETE RESTRICT,
    CONSTRAINT emprestimo_funcionario_fk FOREIGN KEY (matricula_func)
        REFERENCES funcionario (matricula_func) ON DELETE RESTRICT
);

CREATE TABLE renovacao (
    id_emprestimo      INTEGER NOT NULL,
    sequencia          INTEGER NOT NULL,
    data_renovacao     DATE    NOT NULL DEFAULT CURRENT_DATE,
    nova_data_prevista DATE    NOT NULL,

    CONSTRAINT renovacao_pk           PRIMARY KEY (id_emprestimo, sequencia),
    CONSTRAINT renovacao_sequencia_ck CHECK (sequencia > 0),
    -- Tabela dependente: sem o empréstimo, a renovação não significa nada
    CONSTRAINT renovacao_emprestimo_fk FOREIGN KEY (id_emprestimo)
        REFERENCES emprestimo (id_emprestimo) ON DELETE CASCADE
);

CREATE TABLE reserva (
    id_reserva       SERIAL,
    matricula        CHAR(9)     NOT NULL,
    isbn             VARCHAR(17) NOT NULL,
    data_solicitacao DATE        NOT NULL DEFAULT CURRENT_DATE,
    situacao         VARCHAR(12) NOT NULL DEFAULT 'aguardando',

    CONSTRAINT reserva_pk          PRIMARY KEY (id_reserva),
    CONSTRAINT reserva_situacao_ck
        CHECK (situacao IN ('aguardando', 'atendida', 'cancelada', 'expirada')),
    CONSTRAINT reserva_usuario_fk FOREIGN KEY (matricula)
        REFERENCES usuario (matricula) ON DELETE RESTRICT,
    -- A reserva é da OBRA, não do exemplar: qualquer cópia serve
    CONSTRAINT reserva_obra_fk FOREIGN KEY (isbn)
        REFERENCES obra (isbn) ON DELETE RESTRICT
);

CREATE TABLE multa (
    id_emprestimo        INTEGER      NOT NULL,
    valor                NUMERIC(6,2) NOT NULL,
    data_pagamento       DATE,
    justificativa_perdao VARCHAR(200),
    matricula_func       CHAR(9),     -- quem perdoou; vazio se não foi perdoada

    -- 1:1 com empréstimo: a FK é a própria chave primária
    CONSTRAINT multa_pk       PRIMARY KEY (id_emprestimo),
    CONSTRAINT multa_valor_ck CHECK (valor > 0),
    CONSTRAINT multa_emprestimo_fk FOREIGN KEY (id_emprestimo)
        REFERENCES emprestimo (id_emprestimo) ON DELETE CASCADE,
    -- O funcionário pode sair; a multa continua perdoada
    CONSTRAINT multa_funcionario_fk FOREIGN KEY (matricula_func)
        REFERENCES funcionario (matricula_func) ON DELETE SET NULL
);

-- Conferência: precisa responder 13
\echo '--- Tabelas da Biblioteca criadas (esperado: 13) ---'
SELECT count(*) AS tabelas_da_biblioteca
FROM information_schema.tables
WHERE table_schema = 'public'
  AND table_type = 'BASE TABLE'
  AND table_name IN ('usuario', 'telefone', 'funcionario', 'obra', 'autor',
                     'escrita', 'area', 'classificacao', 'exemplar',
                     'emprestimo', 'renovacao', 'reserva', 'multa');
