Chamados ativos por cliente:
Chamados ativos por contrato:
Chamados por analista:
Quais serviços são mais utilizados nos chamados:
Relação de contrato x quantida de chamados:
Chamados que possuem mais de um analista:
Chamados que envolvem mais de um serviço:
Chamados por nível de analista:
Clientes que abriram chamados envolvendo mais de um serviço:

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