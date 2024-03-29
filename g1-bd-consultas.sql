-- Inserts na tabela de endereço
INSERT INTO endereco (end_tx_cidade, end_tx_uf, end_tx_cep, end_tx_numero)
VALUES 
('Petrópolis', 'RJ', '25680-195', '286'),
('Cidade do Rio', 'RJ', '21000-111', '381'),
('Cabo Frio', 'RJ', '25444-195', '426'),
('Arraial do Cabo', 'RJ', '31444-194', '141'),
('Vassouras', 'RJ', '35422-195', '171');

-- Inserts na tabela de clientes -> Cliente realiza pedidos
INSERT INTO cliente (cli_tx_nome, 
cli_tx_telefone, 
cli_tx_nome_usuario, 
cli_tx_cpf, 
cli_tx_email, 
cli_dt_nascimento, 
cli_fk_end) 
VALUES ('João', '123456789', 'joao123', '123.456.789-01', 'joao@example.com', '1990-05-15', 1), 
('Maria', '987654321', 'maria789', '987.654.321-02', 'maria@example.com', '1985-08-20', 2), 
('Carlos', '654123987', 'carlos456', '654.123.987-03', 'carlos@example.com', '1978-03-10', 3), 
('Ana', '321987654', 'ana321', '321.987.654-04', 'ana@example.com', '1993-11-25', 5), 
('Pedro', '789456123', 'pedro789', '789.456.123-05', 'pedro@example.com', '1980-07-03', 4);

-- Inserts na tabela de categorias
/*
 * 2. Ao cadastrar um produto no sistema, os funcionários da empresa devem ser capazes de associá-lo à uma categoria. 
 * Cada produto só poderá pertencer à uma categoria.
*/
INSERT INTO public.categoria (cat_tx_nome, cat_tx_descricao)
VALUES ('Eletrônicos', 'Produtos eletrônicos em geral'),
       ('Roupas', 'Roupas e acessórios'),
       ('Alimentos', 'Alimentos diversos'),
       ('Móveis', 'Móveis para casa'),
       ('Livros', 'Livros de diversos gêneros');

-- Inserts na tabela de funcionários
INSERT INTO public.funcionario (fun_tx_nome, fun_tx_cpf, fun_tx_funcao, fun_int_idade)
VALUES ('João Silva', '123.456.789-00', 'Vendedor', 30),
       ('Maria Souza', '987.654.321-00', 'Gerente', 40),
       ('Pedro Santos', '111.222.333-44', 'Caixa', 25),
       ('Ana Oliveira', '555.666.777-88', 'Assistente de Vendas', 28),
       ('Carlos Lima', '999.888.777-66', 'Estoquista', 35);

-- Inserts na tabela de produtos -> 
/* 
 * 1. O sistema deve ser capaz de armazenar informações sobre os produtos da empresa, 
 * sendo eles: código, nome, descrição, quantidade em estoque, data de fabricação e valor unitário.
*/
INSERT INTO public.produto (prod_tx_nome, prod_tx_descricao, prod_dt_fabricacao, prod_int_estoque, prod_fl_valor_unitario, prod_fk_fun, prod_fk_cat)
VALUES ('Smartphone', 'Smartphone de última geração', '2023-01-15', 100, 1500.00, 1, 1),
       ('Camiseta', 'Camiseta casual', '2023-02-20', 200, 50.00, 2, 2),
       ('Arroz', 'Arroz branco', '2022-12-10', 500, 10.00, 3, 3),
       ('Sofá', 'Sofá confortável para sala de estar', '2023-03-05', 20, 1000.00, 4, 4),
       ('Harry Potter e a Pedra Filosofal', 'Livro de ficção', '2022-11-30', 50, 30.00, 5, 5);

-- Inserts na tabela de pedidos
INSERT INTO public.pedido (ped_fl_valor_total, ped_dt_pedido, ped_dt_previsao_entrega, ped_tx_transporte, ped_fk_cli)
VALUES (1800.00, '2023-04-10 10:00:00', '2023-04-15', 'Transportadora A', 1),
       (80.00, '2023-04-12 11:00:00', '2023-04-16', 'Correios', 2),
       (300.00, '2023-04-15 09:00:00', '2023-04-20', 'Transportadora B', 3),
       (1050.00, '2023-04-18 13:00:00', '2023-04-23', 'Transportadora C', 4),
       (50.00, '2023-04-20 15:00:00', '2023-04-25', 'Correios', 5);

-- Inserts na tabela de ligação de produtos e pedidos
INSERT INTO public.pedido_produto (pedprod_fk_ped, pedprod_fk_prod)
VALUES (1, 1),
       (2, 2),
       (3, 3),
       (4, 4),
       (5, 5);

-- Inserts na tabela de clientes
INSERT INTO cliente (cli_tx_nome, 
cli_tx_telefone, 
cli_tx_nome_usuario, 
cli_tx_cpf, 
cli_tx_email, 
cli_dt_nascimento, 
cli_fk_end)
VALUES ('João', '123456789', 'joao123', '123.456.789-01', 'joao@example.com', '1990-05-15', 1), 
('Maria', '987654321', 'maria789', '987.654.321-02', 'maria@example.com', '1985-08-20', 2), 
('Carlos', '654123987', 'carlos456', '654.123.987-03', 'carlos@example.com', '1978-03-10', 3), 
('Ana', '321987654', 'ana321', '321.987.654-04', 'ana@example.com', '1993-11-25', 5), 
('Pedro', '789456123', 'pedro789', '789.456.123-05', 'pedro@example.com', '1980-07-03', 4);

-- Todas as consultas

-- View para visualização da nota fiscal
CREATE VIEW nota_fiscal AS
SELECT 
    C.cli_tx_nome AS NomeCliente,
    C.cli_tx_cpf AS CPFCiente,
    E.end_tx_cidade || ', ' || E.end_tx_uf || ', ' || E.end_tx_cep || ', ' || E.end_tx_numero AS EnderecoCliente,
    P.ped_fl_valor_total AS ValorTotal,
    P.ped_dt_pedido AS DataPedido,
    P.ped_cd_id AS IDPedido
    FROM 
    public.cliente C
JOIN 
    public.endereco E ON C.cli_fk_end = E.end_cd_id
JOIN 
    public.pedido P ON C.cli_cd_id = P.ped_fk_cli;

-- Consulta na View de Nota Fiscal
select * from nota_fiscal;

-- Trocando o type da variável para int8, para guardar um valor maior no estoque
ALTER TABLE produto
ALTER COLUMN prod_int_estoque type int8;

-- Atualização do estoque
/*
 * 3. Seoprodutojáestivercadastradonosistema,ocolaboradordeveráapenas atualizar a quantidade de itens no estoque.
*/
update public.produto set prod_int_estoque = 50000000 
where prod_cd_id = 3;

-- Consulta para verificar o novo valor no estoque
select * from public.produto;

--Consulta para verificar a previsão de entrega dos pedidos por cliente
select c.cli_tx_nome, p.ped_dt_previsao_entrega  
from cliente c 
inner join pedido p on c.cli_cd_id = c.cli_cd_id
;

--Consulta para verificar os pedidos e clientes associados
select p.ped_cd_id, c.cli_tx_nome
from pedido p
left join cliente c on p.ped_fk_cli = c.cli_cd_id;

--Consulta para verificar o total de pedidos por cliente
select c.cli_tx_nome, count(p.ped_cd_id) as total_de_pedidos
from cliente c, pedido p
group by c.cli_tx_nome;
