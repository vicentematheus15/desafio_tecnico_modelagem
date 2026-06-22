-- 3. CARGA DE DADOS FICTÍCIOS
-- =====================================================================

INSERT INTO cliente (razao_social) VALUES
('Alpha Indústria Ltda'),
('Beta Comércio S/A'),
('Gama Tecnologia Ltda');

INSERT INTO contrato (id_cliente, status) VALUES
(1, 'Ativo'),     -- contrato 1 - Alpha
(1, 'Ativo'),     -- contrato 2 - Alpha
(2, 'Ativo'),     -- contrato 3 - Beta
(3, 'Encerrado'); -- contrato 4 - Gama

INSERT INTO servico (tipo) VALUES
('Suporte'),
('Manutenção'),
('Consultoria');

INSERT INTO contrato_servico (id_contrato, id_servico) VALUES
(1, 1), (1, 2),
(2, 3),
(3, 1), (3, 3),
(4, 2);

INSERT INTO analista (nome, nivel) VALUES
('Carlos Souza', 'Sênior'),
('Mariana Lima', 'Pleno'),
('João Pedro', 'Júnior'),
('Ana Beatriz', 'Estagiário');

INSERT INTO chamado (id_contrato, data_abertura, status, prioridade, descricao) VALUES
(1, '2026-05-02', 'Aberto',        'Alta',   'Sistema fora do ar'),
(1, '2026-05-10', 'Fechado',       'Média',  'Erro ao gerar relatório'),
(2, '2026-05-15', 'Em andamento',  'Baixa',  'Dúvida sobre configuração'),
(3, '2026-06-01', 'Aberto',        'Alta',   'Falha de integração'),
(3, '2026-06-05', 'Em andamento',  'Média',  'Consultoria sobre nova feature'),
(4, '2026-04-20', 'Fechado',       'Baixa',  'Manutenção preventiva');

INSERT INTO chamado_servico (id_chamado, id_servico) VALUES
(1, 1),
(2, 1), (2, 2),
(3, 3),
(4, 1), (4, 3),
(5, 3),
(6, 2);

INSERT INTO chamado_analista (id_chamado, id_analista) VALUES
(1, 1),
(2, 1), (2, 2),
(3, 3),
(4, 1), (4, 2),
(5, 2),
(6, 4);