-- =============================================================================
-- Aula 13 — Biblioteca Universitária: esquema completo (DDL)
--
-- Este é o esquema relacional da Aula 10, seção 10, traduzido para PostgreSQL.
-- Rode com:  psql -d curso_bd -v ON_ERROR_STOP=1 -f 01-ddl.sql
-- O script pode ser rodado quantas vezes quiser: começa apagando tudo.
-- =============================================================================

-- Ordem inversa das dependências: quem referencia é apagado primeiro.
DROP TABLE IF EXISTS multa, renovacao, emprestimo, reserva, classificacao,
                     escrita, exemplar, telefone, aluno, professor, servidor,
                     usuario, obra, autor, area, funcionario CASCADE;

DROP VIEW IF EXISTS emprestimos_em_aberto CASCADE;


-- ─────────────────────────────────────────────────────────────────────────────
-- 1. Entidades fortes sem dependências (Regra 1)
-- ─────────────────────────────────────────────────────────────────────────────

CREATE TABLE usuario (
    matricula      INTEGER      PRIMARY KEY,
    nome           VARCHAR(100) NOT NULL,
    email          VARCHAR(120) NOT NULL,
    data_cadastro  DATE         NOT NULL DEFAULT CURRENT_DATE,
    -- Discriminador da especialização. Não vem das regras de mapeamento:
    -- é o que torna VERIFICÁVEL a restrição "disjunta e total" que a opção A,
    -- sozinha, não consegue expressar (Aula 10, seção 11).
    tipo           VARCHAR(10)  NOT NULL,

    CONSTRAINT uq_usuario_email  UNIQUE (email),
    CONSTRAINT ck_usuario_email  CHECK (email LIKE '%@%'),
    CONSTRAINT ck_usuario_tipo   CHECK (tipo IN ('aluno', 'professor', 'servidor'))
);

CREATE TABLE funcionario (
    matricula_func INTEGER      PRIMARY KEY,
    nome           VARCHAR(100) NOT NULL,
    cargo          VARCHAR(50)  NOT NULL
);

CREATE TABLE obra (
    isbn            VARCHAR(17)  PRIMARY KEY,
    titulo          VARCHAR(200) NOT NULL,
    ano_publicacao  INTEGER      NOT NULL,
    editora         VARCHAR(100),

    CONSTRAINT ck_obra_ano CHECK (ano_publicacao BETWEEN 1450 AND 2100)
);

CREATE TABLE autor (
    id_autor      INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nome          VARCHAR(100) NOT NULL,
    nacionalidade VARCHAR(50)
);

CREATE TABLE area (
    codigo_area VARCHAR(10)  PRIMARY KEY,
    nome        VARCHAR(100) NOT NULL,

    CONSTRAINT uq_area_nome UNIQUE (nome)
);


-- ─────────────────────────────────────────────────────────────────────────────
-- 2. Especialização de USUARIO — opção A (Aula 10, seção 9)
--    Disjunta e total: garantida pelo CHECK em usuario.tipo + o CHECK de cada
--    subclasse, que confere se o tipo do pai bate com a tabela filha.
-- ─────────────────────────────────────────────────────────────────────────────

CREATE TABLE aluno (
    matricula         INTEGER PRIMARY KEY,
    curso             VARCHAR(80) NOT NULL,
    semestre_ingresso VARCHAR(6)  NOT NULL,   -- formato '2023.1'

    CONSTRAINT fk_aluno_usuario FOREIGN KEY (matricula)
        REFERENCES usuario (matricula) ON DELETE CASCADE
);

CREATE TABLE professor (
    matricula    INTEGER PRIMARY KEY,
    departamento VARCHAR(80) NOT NULL,
    titulacao    VARCHAR(30) NOT NULL,

    CONSTRAINT fk_professor_usuario FOREIGN KEY (matricula)
        REFERENCES usuario (matricula) ON DELETE CASCADE,
    CONSTRAINT ck_professor_titulacao
        CHECK (titulacao IN ('graduacao', 'especializacao', 'mestrado', 'doutorado'))
);

CREATE TABLE servidor (
    matricula INTEGER PRIMARY KEY,
    setor     VARCHAR(80) NOT NULL,

    CONSTRAINT fk_servidor_usuario FOREIGN KEY (matricula)
        REFERENCES usuario (matricula) ON DELETE CASCADE
);


-- ─────────────────────────────────────────────────────────────────────────────
-- 3. Entidade fraca: TELEFONE (Regra 6 — atributo multivalorado com atributo)
--    CASCADE porque o telefone não faz sentido sem o usuário (Aula 09, seção 6).
-- ─────────────────────────────────────────────────────────────────────────────

CREATE TABLE telefone (
    matricula INTEGER     NOT NULL,
    numero    VARCHAR(20) NOT NULL,
    tipo      VARCHAR(15) NOT NULL DEFAULT 'celular',

    CONSTRAINT pk_telefone PRIMARY KEY (matricula, numero),
    CONSTRAINT fk_telefone_usuario FOREIGN KEY (matricula)
        REFERENCES usuario (matricula) ON DELETE CASCADE,
    CONSTRAINT ck_telefone_tipo
        CHECK (tipo IN ('celular', 'residencial', 'recado'))
);


-- ─────────────────────────────────────────────────────────────────────────────
-- 4. Relacionamento 1:N — EXEMPLAR (Regra 3)
--    RESTRICT: apagar a obra não pode apagar exemplares que existem na estante.
-- ─────────────────────────────────────────────────────────────────────────────

CREATE TABLE exemplar (
    tombo          INTEGER     PRIMARY KEY,
    isbn           VARCHAR(17) NOT NULL,
    data_aquisicao DATE        NOT NULL DEFAULT CURRENT_DATE,
    situacao       VARCHAR(20) NOT NULL DEFAULT 'disponivel',

    CONSTRAINT fk_exemplar_obra FOREIGN KEY (isbn)
        REFERENCES obra (isbn) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT ck_exemplar_situacao
        CHECK (situacao IN ('disponivel', 'emprestado', 'manutencao', 'extraviado'))
);


-- ─────────────────────────────────────────────────────────────────────────────
-- 5. Relacionamentos N:M — tabelas associativas (Regra 5)
--    ESCRITA carrega o atributo do relacionamento: a ordem do autor na capa.
-- ─────────────────────────────────────────────────────────────────────────────

CREATE TABLE escrita (
    isbn     VARCHAR(17) NOT NULL,
    id_autor INTEGER     NOT NULL,
    ordem    INTEGER     NOT NULL,

    CONSTRAINT pk_escrita PRIMARY KEY (isbn, id_autor),
    CONSTRAINT fk_escrita_obra  FOREIGN KEY (isbn)
        REFERENCES obra (isbn) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_escrita_autor FOREIGN KEY (id_autor)
        REFERENCES autor (id_autor) ON DELETE RESTRICT,
    CONSTRAINT ck_escrita_ordem CHECK (ordem > 0),
    -- Dois autores não ocupam a mesma posição na mesma capa:
    CONSTRAINT uq_escrita_ordem UNIQUE (isbn, ordem)
);

CREATE TABLE classificacao (
    isbn        VARCHAR(17) NOT NULL,
    codigo_area VARCHAR(10) NOT NULL,

    CONSTRAINT pk_classificacao PRIMARY KEY (isbn, codigo_area),
    CONSTRAINT fk_class_obra FOREIGN KEY (isbn)
        REFERENCES obra (isbn) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_class_area FOREIGN KEY (codigo_area)
        REFERENCES area (codigo_area) ON DELETE RESTRICT
);


-- ─────────────────────────────────────────────────────────────────────────────
-- 6. EMPRESTIMO — três relacionamentos 1:N convergindo (Regra 3, ×3)
--    Todas RESTRICT: o histórico de empréstimos não se apaga por efeito colateral.
-- ─────────────────────────────────────────────────────────────────────────────

CREATE TABLE emprestimo (
    id_emprestimo  INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    matricula      INTEGER NOT NULL,
    tombo          INTEGER NOT NULL,
    matricula_func INTEGER NOT NULL,
    data_retirada  DATE    NOT NULL DEFAULT CURRENT_DATE,
    data_prevista  DATE    NOT NULL,
    data_devolucao DATE,                        -- NULO = empréstimo em aberto

    CONSTRAINT fk_emp_usuario     FOREIGN KEY (matricula)
        REFERENCES usuario (matricula) ON DELETE RESTRICT,
    CONSTRAINT fk_emp_exemplar    FOREIGN KEY (tombo)
        REFERENCES exemplar (tombo) ON DELETE RESTRICT,
    CONSTRAINT fk_emp_funcionario FOREIGN KEY (matricula_func)
        REFERENCES funcionario (matricula_func) ON DELETE RESTRICT,

    CONSTRAINT ck_emp_prazo     CHECK (data_prevista > data_retirada),
    -- O 'IS NULL OR' é obrigatório: sem ele, todo empréstimo em aberto seria
    -- rejeitado, porque comparação com NULL resulta em UNKNOWN.
    CONSTRAINT ck_emp_devolucao CHECK (data_devolucao IS NULL
                                       OR data_devolucao >= data_retirada)
);


-- ─────────────────────────────────────────────────────────────────────────────
-- 7. Entidade fraca: RENOVACAO (Regra 2)
--    Chave = chave do proprietário + chave parcial. CASCADE, como toda fraca.
-- ─────────────────────────────────────────────────────────────────────────────

CREATE TABLE renovacao (
    id_emprestimo      INTEGER NOT NULL,
    sequencia          INTEGER NOT NULL,
    data_renovacao     DATE    NOT NULL DEFAULT CURRENT_DATE,
    nova_data_prevista DATE    NOT NULL,

    CONSTRAINT pk_renovacao PRIMARY KEY (id_emprestimo, sequencia),
    CONSTRAINT fk_renovacao_emprestimo FOREIGN KEY (id_emprestimo)
        REFERENCES emprestimo (id_emprestimo) ON DELETE CASCADE,
    CONSTRAINT ck_renovacao_seq CHECK (sequencia > 0)
);


-- ─────────────────────────────────────────────────────────────────────────────
-- 8. RESERVA — da OBRA, nunca do exemplar (regra do minimundo, Aula 08)
-- ─────────────────────────────────────────────────────────────────────────────

CREATE TABLE reserva (
    id_reserva       INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    matricula        INTEGER     NOT NULL,
    isbn             VARCHAR(17) NOT NULL,
    data_solicitacao DATE        NOT NULL DEFAULT CURRENT_DATE,
    situacao         VARCHAR(15) NOT NULL DEFAULT 'aguardando',

    CONSTRAINT fk_reserva_usuario FOREIGN KEY (matricula)
        REFERENCES usuario (matricula) ON DELETE RESTRICT,
    CONSTRAINT fk_reserva_obra    FOREIGN KEY (isbn)
        REFERENCES obra (isbn) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT ck_reserva_situacao
        CHECK (situacao IN ('aguardando', 'atendida', 'cancelada', 'expirada'))
);


-- ─────────────────────────────────────────────────────────────────────────────
-- 9. MULTA — relacionamento 1:1 com EMPRESTIMO (Regra 4, opção a)
--    A FK vira a própria PK: é o que garante o 1:1 sem precisar de UNIQUE.
--    matricula_func é SET NULL: o funcionário pode sair da biblioteca,
--    e a multa continua perdoada — perde-se só quem autorizou.
-- ─────────────────────────────────────────────────────────────────────────────

CREATE TABLE multa (
    id_emprestimo        INTEGER       PRIMARY KEY,
    valor                NUMERIC(10,2) NOT NULL,
    data_pagamento       DATE,                     -- NULO = ainda não paga
    justificativa_perdao VARCHAR(200),             -- NULO = não perdoada
    matricula_func       INTEGER,                  -- quem perdoou

    CONSTRAINT fk_multa_emprestimo FOREIGN KEY (id_emprestimo)
        REFERENCES emprestimo (id_emprestimo) ON DELETE CASCADE,
    CONSTRAINT fk_multa_funcionario FOREIGN KEY (matricula_func)
        REFERENCES funcionario (matricula_func) ON DELETE SET NULL,

    CONSTRAINT ck_multa_valor CHECK (valor > 0),
    -- Perdão exige as duas coisas juntas: justificativa E quem autorizou.
    CONSTRAINT ck_multa_perdao CHECK (
        (justificativa_perdao IS NULL     AND matricula_func IS NULL) OR
        (justificativa_perdao IS NOT NULL AND matricula_func IS NOT NULL)
    )
);
