-- Cria da tabela endereço
create table public.endereco (
	end_cd_id serial primary key not null,
	end_tx_cidade varchar(25),
	end_tx_uf varchar(2),
	end_tx_cep varchar(9),
	end_tx_numero varchar(5)
);

-- Cria tabela de clientes com relacionamento na tabela de endereço
create table public.cliente (
	cli_cd_id serial primary key not null,
	cli_tx_nome varchar(50) not null,
	cli_tx_telefone varchar(16) not null,
	cli_tx_nome_usuario varchar(20) not null,
	cli_tx_cpf varchar(14) not null unique, 
	cli_tx_email varchar(50) not null,
	cli_dt_nascimento date not null,
	cli_fk_end int4 not null,
	foreign key (cli_fk_end) references endereco(end_cd_id)
);

-- Cria tabela de categoria
create table public.categoria (
    cat_cd_id serial primary key,
    cat_tx_nome varchar(20) not null,
    cat_tx_descricao varchar(200)
);

-- Cria tabela de funcionários
create table public.funcionario (
    fun_cd_id serial primary key,
    fun_tx_nome varchar(50) not null,
    fun_tx_cpf varchar(14) not null,
    fun_tx_funcao varchar(20) not null,
    fun_int_idade int4
);

-- Cria tabela de produtos
create table public.produto (
    prod_cd_id serial primary key,
    prod_tx_nome varchar(50) not null unique,
    prod_tx_descricao varchar(200) not null,
    prod_dt_fabricacao date not null,
    prod_int_estoque int4 not null,
    prod_fl_valor_unitario float not null,
    prod_fk_fun int4 not null,
    prod_fk_cat int4 not null,
    foreign key (prod_fk_fun) references public.funcionario(fun_cd_id),
    foreign key (prod_fk_cat) references public.categoria(cat_cd_id)
);

-- Cria tabela de pedidos
create table public.pedido (
    ped_cd_id serial primary key,
    ped_fl_valor_total float not null,
    ped_dt_pedido timestamp not null,
    ped_dt_previsao_entrega date not null,
    ped_tx_transporte varchar(30) not null,
    ped_fk_cli int4 not null,
    foreign key (ped_fk_cli) references public.cliente (cli_cd_id)
);

-- Cria tabela de ligação para produtos e pedidos, relação N:M
create table public.pedido_produto (
    pedprod_fk_ped int4 not null,
    pedprod_fk_prod int4 not null,
    foreign key (pedprod_fk_ped) references public.pedido (ped_cd_id),
    foreign key (pedprod_fk_prod) references public.produto (prod_cd_id)
);
