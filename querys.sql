-- Chamados ativos por cliente
SELECT
    cli.id_cliente,
    cli.razao_social,
    COUNT(ch.id_chamado) AS chamados_ativos
FROM cliente cli
JOIN contrato co ON co.id_cliente = cli.id_cliente
JOIN chamado ch  ON ch.id_contrato = co.id_contrato
WHERE ch.status IN ('Aberto', 'Em andamento')
GROUP BY cli.id_cliente, cli.razao_social
ORDER BY chamados_ativos DESC;

-- Chamados ativos por contrato
SELECT
    co.id_contrato,
    COUNT(ch.id_chamado) AS chamados_ativos
FROM contrato co
JOIN chamado ch ON ch.id_contrato = co.id_contrato
WHERE ch.status IN ('Aberto', 'Em andamento')
GROUP BY co.id_contrato
ORDER BY chamados_ativos DESC;

-- Chamados por analista
SELECT
    a.id_analista,
    a.nome,
    COUNT(ca.id_chamado) AS total_chamados
FROM analista a
JOIN chamado_analista ca ON ca.id_analista = a.id_analista
GROUP BY a.id_analista, a.nome
ORDER BY total_chamados DESC;

-- Serviços mais utilizados nos chamados
SELECT
    s.id_servico,
    s.tipo,
    COUNT(cs.id_chamado) AS qtd_utilizacoes
FROM servico s
JOIN chamado_servico cs ON cs.id_servico = s.id_servico
GROUP BY s.id_servico, s.tipo
ORDER BY qtd_utilizacoes DESC;

-- Relação de contrato x quantidade de chamados
SELECT
    co.id_contrato,
    co.status AS status_contrato,
    COUNT(ch.id_chamado) AS qtd_chamados
FROM contrato co
LEFT JOIN chamado ch ON ch.id_contrato = co.id_contrato
GROUP BY co.id_contrato, co.status
ORDER BY qtd_chamados DESC;

-- Chamados que possuem mais de um analista
SELECT
    ch.id_chamado,
    COUNT(ca.id_analista) AS qtd_analistas
FROM chamado ch
JOIN chamado_analista ca ON ca.id_chamado = ch.id_chamado
GROUP BY ch.id_chamado
HAVING COUNT(ca.id_analista) > 1;

-- Chamados que envolvem mais de um serviço
SELECT
    ch.id_chamado,
    COUNT(cs.id_servico) AS qtd_servicos
FROM chamado ch
JOIN chamado_servico cs ON cs.id_chamado = ch.id_chamado
GROUP BY ch.id_chamado
HAVING COUNT(cs.id_servico) > 1;

-- Chamados por nível de analista
SELECT
    a.nivel,
    COUNT(DISTINCT ca.id_chamado) AS qtd_chamados
FROM analista a
JOIN chamado_analista ca ON ca.id_analista = a.id_analista
GROUP BY a.nivel
ORDER BY qtd_chamados DESC;

-- Clientes que abriram chamados envolvendo mais de um serviço
SELECT
    cli.id_cliente,
    cli.razao_social
FROM cliente cli
JOIN contrato co ON co.id_cliente = cli.id_cliente
JOIN chamado ch ON ch.id_contrato = co.id_contrato
JOIN(
    SELECT id_chamado
    FROM chamado_servico
    GROUP BY id_chamado
    HAVING COUNT(cs.id_servico) > 1
) multi_servico ON multi_servico.id_chamado = ch.id_chamado