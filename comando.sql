-- ============================
-- TABELA: cliente
-- ============================
CREATE TABLE cliente (
    id_cliente SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    rua VARCHAR(100),
    numero VARCHAR(10),
    bairro VARCHAR(100),
    cidade VARCHAR(100),
    estado VARCHAR(2),
    telefones TEXT[] NOT NULL,
    created_at TIMESTAMP DEFAULT NOW()
);

-- ============================
-- TABELA: veterinario
-- ============================
CREATE TABLE veterinario (
    id_veterinario SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    especialidade VARCHAR(50),
    telefones TEXT[] NOT NULL,
    created_at TIMESTAMP DEFAULT NOW()
);

-- ============================
-- TABELA: animal
-- ============================
CREATE TABLE animal (
    id_animal SERIAL PRIMARY KEY,
    id_cliente INTEGER REFERENCES cliente(id_cliente),
    nome VARCHAR(100) NOT NULL,
    especie VARCHAR(50) NOT NULL,
    raca VARCHAR(50),
    data_nascimento DATE,
    microchip VARCHAR(50) UNIQUE,
    created_at TIMESTAMP DEFAULT NOW()
);

-- ============================
-- TABELA: servico
-- ============================
CREATE TABLE servico (
    id_servico SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    valor NUMERIC(10,2) NOT NULL,
    created_at TIMESTAMP DEFAULT NOW()
);

-- ============================
-- TABELA: consulta
-- ============================
CREATE TABLE consulta (
    id_consulta SERIAL PRIMARY KEY,
    id_animal INTEGER REFERENCES animal(id_animal),
    id_veterinario INTEGER REFERENCES veterinario(id_veterinario),
    data TIMESTAMP NOT NULL,
    tipo VARCHAR(50) NOT NULL,
    status VARCHAR(50) NOT NULL,
    diagnostico TEXT,
    created_at TIMESTAMP DEFAULT NOW()
);

-- ============================
-- TABELA: consulta_servico (N:N)
-- ============================
CREATE TABLE consulta_servico (
    id_consulta INTEGER REFERENCES consulta(id_consulta),
    id_servico INTEGER REFERENCES servico(id_servico),
    PRIMARY KEY (id_consulta, id_servico)
);

-- ============================
-- inserir 500 dados nas tabelas
-- ============================

-- 500 CLIENTES
INSERT INTO cliente (nome, email, rua, numero, bairro, cidade, estado, telefones, created_at)
SELECT
'Cliente ' || i,
'cliente' || i || '@email.com',
'Rua ' || ((i % 100) + 1),
((i % 200) + 1)::text,
'Bairro ' || ((i % 30) + 1),
'Franca',
'SP',
ARRAY['(16)9' || LPAD((100000000 + i)::text,8,'0')],
NOW() - (i || ' days')::interval
FROM generate_series(1,500) AS s(i);

-- 500 VETERINÁRIOS
INSERT INTO veterinario (nome, especialidade, telefones, created_at)
SELECT
'Veterinario ' || i,
(ARRAY['Clinico Geral','Cirurgia','Dermatologia','Oftalmologia','Cardiologia'])[(i % 5) + 1],
ARRAY['(16)9' || LPAD((200000000 + i)::text,8,'0')],
NOW() - ((i*2) || ' hours')::interval
FROM generate_series(1,500) AS s(i);

-- 500 ANIMAIS
INSERT INTO animal (id_cliente, nome, especie, raca, data_nascimento, microchip, created_at)
SELECT
FLOOR(RANDOM()*500)::int + 1,
'Animal ' || i,
(ARRAY['Cachorro','Gato','Pássaro','Coelho','Outro'])[(i % 5) + 1],
'SRD',
(current_date - ((i % 4000) + 365)::int),
'MC' || LPAD(i::text,6,'0'),
NOW() - (i || ' hours')::interval
FROM generate_series(1,500) AS s(i);

-- 500 SERVIÇOS
INSERT INTO servico (nome, valor, created_at)
SELECT
'Servico ' || i,
((FLOOR(RANDOM()*200) + 30)::numeric(10,2)),
NOW() - ((i % 90) || ' days')::interval
FROM generate_series(1,500) AS s(i);

-- 500 CONSULTAS
INSERT INTO consulta (id_animal, id_veterinario, data, tipo, status, diagnostico, created_at)
SELECT
FLOOR(RANDOM()*500)::int + 1,
FLOOR(RANDOM()*500)::int + 1,
NOW() + ((i % 30) || ' days')::interval + ((i % 8) || ' hours')::interval,
(ARRAY['consulta','vacina','retorno'])[(i % 3) + 1],
(ARRAY['agendada','realizada','cancelada'])[(i % 3) + 1],
'Diagnostico exemplo ' || i,
NOW() - (i || ' minutes')::interval
FROM generate_series(1,500) AS s(i);

-- 500 REGISTROS N:N (consulta_servico)
INSERT INTO consulta_servico (id_consulta, id_servico)
SELECT 
FLOOR(RANDOM()*500)::int + 1,
FLOOR(RANDOM()*500)::int + 1
FROM generate_series(1,500);

-- ============================
-- crud 
-- ============================

-- INSERT
INSERT INTO cliente (nome, email, cidade, estado, telefones)
VALUES ('João Pedro', 'joao@email.com', 'Franca', 'SP', ARRAY['(16)99999-9999']);

-- SELECT
SELECT * FROM cliente ORDER BY nome;

-- UPDATE
UPDATE cliente
SET cidade = 'Ribeirão Preto'
WHERE id_cliente = 1;

-- DELETE
DELETE FROM cliente
WHERE id_cliente = 1;

-- ============================
-- relatórios
-- ============================

-- 1. Listar todos os clientes ordenados por nome
SELECT id_cliente, nome FROM cliente ORDER BY nome;

-- 2. Animais da espécie "Cachorro"
SELECT id_animal, nome FROM animal WHERE especie = 'Cachorro';

-- 3. Dono + Animal (JOIN)
SELECT a.nome AS animal, c.nome AS dono
FROM animal a
JOIN cliente c ON c.id_cliente = a.id_cliente;

-- 4. Consultas com veterinário e animal
SELECT con.id_consulta, a.nome AS animal, v.nome AS veterinario, con.data
FROM consulta con
JOIN animal a ON a.id_animal = con.id_animal
JOIN veterinario v ON v.id_veterinario = con.id_veterinario;

-- 5. Serviços por consulta (JOIN N:N)
SELECT cs.id_consulta, s.nome, s.valor
FROM consulta_servico cs
JOIN servico s ON s.id_servico = cs.id_servico;

-- 6. Consultas realizadas
SELECT * FROM consulta WHERE status = 'realizada';

-- 7. Total de consultas por veterinário
SELECT v.nome, COUNT(con.id_consulta) AS total
FROM veterinario v
LEFT JOIN consulta con ON con.id_veterinario = v.id_veterinario
GROUP BY v.nome;

-- 8. Serviços mais caros
SELECT * FROM servico ORDER BY valor DESC LIMIT 10;

-- 9. Animais com mais de 5 anos
SELECT nome, date_part('year', age(current_date, data_nascimento)) AS idade
FROM animal
WHERE date_part('year', age(current_date, data_nascimento)) > 5;

-- 10. Clientes com mais de um animal
SELECT c.nome, COUNT(a.id_animal)
FROM cliente c
JOIN animal a ON a.id_cliente = c.id_cliente
GROUP BY c.nome
HAVING COUNT(a.id_animal) > 1;
-- FIM DO ARQUIVO