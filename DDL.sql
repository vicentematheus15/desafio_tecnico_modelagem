-- CRIAÇÃO DE ENUMS
CREATE TYPE status_contrato_enum    AS ENUM ('Ativo', 'Inativo', 'Encerrado');
CREATE TYPE status_chamado_enum     AS ENUM ('Aberto', 'Em andamento', 'Fechado');
CREATE TYPE prioridade_chamado_enum AS ENUM ('Baixa', 'Média', 'Alta');
CREATE TYPE nivel_analista_enum     AS ENUM ('Estagiário', 'Júnior', 'Pleno', 'Sênior');

-- CLIENTE
CREATE TABLE cliente (
    id_cliente      SERIAL PRIMARY KEY,
    razao_social    VARCHAR(150) NOT NULL
);

-- CONTRATO  (N contratos : 1 cliente)
CREATE TABLE contrato (
    id_contrato     SERIAL PRIMARY KEY,
    id_cliente      INTEGER NOT NULL REFERENCES cliente(id_cliente),
    status          status_contrato_enum NOT NULL
);

-- SERVICO (da pra criar uma tabela pros tipos de serviço, se forem muitos)
CREATE TABLE servico (
    id_servico      SERIAL PRIMARY KEY,
    tipo            VARCHAR(50) NOT NULL UNIQUE
);

-- CONTRATO_SERVICO (N:N entre contrato e serviço)
CREATE TABLE contrato_servico (
    id_contrato     INTEGER NOT NULL REFERENCES contrato(id_contrato),
    id_servico      INTEGER NOT NULL REFERENCES servico(id_servico),
    PRIMARY KEY (id_contrato, id_servico)
);

-- ANALISTA
CREATE TABLE analista (
    id_analista     SERIAL PRIMARY KEY,
    nome            VARCHAR(100) NOT NULL,
    nivel           nivel_analista_enum NOT NULL
);

-- CHAMADO (sempre vinculado a 1 contrato)
CREATE TABLE chamado (
    id_chamado      SERIAL PRIMARY KEY,
    id_contrato     INTEGER NOT NULL REFERENCES contrato(id_contrato),
    data_abertura   DATE NOT NULL,
    status          status_chamado_enum NOT NULL,
    prioridade      prioridade_chamado_enum NOT NULL,
    descricao       VARCHAR(255)
);

-- CHAMADO_SERVICO (N:N entre chamado e serviço)
CREATE TABLE chamado_servico (
    id_chamado      INTEGER NOT NULL REFERENCES chamado(id_chamado),
    id_servico      INTEGER NOT NULL REFERENCES servico(id_servico),
    PRIMARY KEY (id_chamado, id_servico)
);

-- CHAMADO_ANALISTA (N:N entre chamado e analista)
CREATE TABLE chamado_analista (
    id_chamado      INTEGER NOT NULL REFERENCES chamado(id_chamado),
    id_analista     INTEGER NOT NULL REFERENCES analista(id_analista),
    PRIMARY KEY (id_chamado, id_analista)
);
