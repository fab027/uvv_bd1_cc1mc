/* 
Fabricio Nascimento Perusse Júnior | Matricula: 202307855
Banco de Dados I
CC1MC
*/ 




DROP DATABASE IF EXISTS uvv;

DROP USER IF EXISTS cleiton;

CREATE USER cleiton
WITH 
CREATEROLE
CREATEDB
LOGIN
ENCRYPTED PASSWORD '12344321';

SET ROLE cleiton;

CREATE DATABASE uvv
    WITH 
    OWNER = cleiton
    TEMPLATE = template0
    ENCODING = 'UTF8'
    LC_COLLATE = 'pt_BR.UTF-8'
    LC_CTYPE = 'pt_BR.UTF-8'
    ALLOW_CONNECTIONS = true;

COMMENT ON DATABASE uvv IS 'Database sobre as lojas uvv'

\c 'dbname=uvv user=cleiton password=12344321'

CREATE SCHEMA lojas;

ALTER SCHEMA lojas OWNER TO cleiton;

ALTER USER cleiton set search_path to lojas, '$user', public;
set search_path TO lojas, '$user', public;
--
-- Tabelas
--

--
-- Produtos
--
CREATE TABLE lojas.produtos (
                produto_id NUMERIC(38) NOT NULL,
                nome VARCHAR(255) NOT NULL,
                preco_unitario NUMERIC(10,2),
                detalhes BYTEA,
                imagem BYTEA,
                imagem_mime_type VARCHAR(512),
                imagem_arquivo VARCHAR(512),
                imagem_charset VARCHAR(512),
                imagem_ultima_atualizacao DATE,
                CONSTRAINT produto_id PRIMARY KEY (produto_id)
);

ALTER TABLE lojas.produtos OWNER TO cleiton;

COMMENT ON COLUMN lojas.produtos.produto_id IS 'Primary Key Produtos';
COMMENT ON COLUMN lojas.produtos.nome IS 'Nome do produto';
COMMENT ON COLUMN lojas.produtos.preco_unitario IS 'Preco unitario do produto';
COMMENT ON COLUMN lojas.produtos.detalhes IS 'Detalhes do produto';
COMMENT ON COLUMN lojas.produtos.imagem IS 'Imagem do produto';
COMMENT ON COLUMN lojas.produtos.imagem_ultima_atualizacao IS 'Imagem da Ultima Atualizacao do produto';
COMMENT ON TABLE lojas.produtos IS 'Tabela Produtos';
-->
-- Lojas
-->
CREATE TABLE lojas.lojas (
                loja_id NUMERIC(38) NOT NULL,
                nome VARCHAR(255) NOT NULL,
                endereco_web VARCHAR(100),
                endereco_fisico VARCHAR(512),
                latitude NUMERIC,
                longitude NUMERIC,
                logo BYTEA,
                logo_mime_type VARCHAR(512),
                logo_arquivo VARCHAR(512),
                logo_charset VARCHAR(512),
                logo_ultima_atualizacao DATE,
                CONSTRAINT loja_id PRIMARY KEY (loja_id)
);
ALTER TABLE lojas.lojas OWNER TO cleiton;

COMMENT ON COLUMN lojas.lojas.loja_id IS 'Primary Key de Lojas';
COMMENT ON COLUMN lojas.lojas.nome IS 'Nome da Loja';
COMMENT ON COLUMN lojas.lojas.endereco_web IS 'Endereco Web da Loja';
COMMENT ON COLUMN lojas.lojas.endereco_fisico IS 'Endereco fisico (local) da Loja';
COMMENT ON COLUMN lojas.lojas.latitude IS 'Latitude da localizacao da loja';
COMMENT ON COLUMN lojas.lojas.longitude IS 'Longitude da localizacao da loja';
COMMENT ON COLUMN lojas.lojas.logo IS 'Logo da loja';
COMMENT ON COLUMN lojas.lojas.logo_arquivo IS 'Arquivo da logo da loja';
COMMENT ON TABLE lojas.lojas IS 'Tabela de Todas as lojas';

-->
-- Estoques
-->
CREATE TABLE lojas.estoques (
                estoque_id NUMERIC(38) NOT NULL,
                loja_id NUMERIC(38) NOT NULL,
                produto_id NUMERIC(38) NOT NULL,
                quantidade NUMERIC(38) NOT NULL,
                CONSTRAINT estoque_id PRIMARY KEY (estoque_id)
);
ALTER TABLE lojas.estoques OWNER TO cleiton;

COMMENT ON COLUMN lojas.estoques.estoque_id IS 'Primary Key estoques';
COMMENT ON COLUMN lojas.estoques.loja_id IS 'Foreign Key Lojas';
COMMENT ON COLUMN lojas.estoques.produto_id IS 'Foreign Key produtos';
COMMENT ON COLUMN lojas.estoques.quantidade IS 'Quantidade no Estoque';
COMMENT ON TABLE lojas.estoques IS 'Tabela de estoques dos produtos';

-->
-- Clientes
-->
CREATE TABLE lojas.clientes (
                cliente_id NUMERIC(38) NOT NULL,
                email VARCHAR(255) NOT NULL,
                nome VARCHAR(255) NOT NULL,
                telefone1 VARCHAR(20),
                telefone2 VARCHAR(20),
                telefone3 VARCHAR(20),
                CONSTRAINT cliente_id PRIMARY KEY (cliente_id)
);
ALTER TABLE lojas.clientes OWNER TO cleiton;

COMMENT ON COLUMN lojas.clientes.cliente_id IS 'Primary Key de CLIENTES';
COMMENT ON COLUMN lojas.clientes.email IS 'Email Cliente';
COMMENT ON COLUMN lojas.clientes.nome IS 'nome cliente';
COMMENT ON COLUMN lojas.clientes.telefone1 IS 'Primeiro Telefone Cliente';
COMMENT ON COLUMN lojas.clientes.telefone2 IS 'Segundo Telefone Cliente';
COMMENT ON COLUMN lojas.clientes.telefone3 IS 'Terceiro Telefone Cliente';
COMMENT ON TABLE lojas.clientes IS 'Tabela de Clientes';
-->
-- Pedidos
-->
CREATE TABLE lojas.pedidos (
                pedido_id NUMERIC(38) NOT NULL,
                data_hora TIMESTAMP NOT NULL,
                cliente_id NUMERIC(38) NOT NULL,
                status VARCHAR(15) NOT NULL,
                loja_id NUMERIC(38) NOT NULL,
                CONSTRAINT pedidos_id PRIMARY KEY (pedido_id)
);
ALTER TABLE lojas.pedidos OWNER TO cleiton;

COMMENT ON COLUMN lojas.pedidos.pedido_id IS 'Primary Key Pedidos';
COMMENT ON COLUMN lojas.pedidos.data_hora IS 'Data e Hora do Pedido';
COMMENT ON COLUMN lojas.pedidos.cliente_id IS 'Foreign Key Cliente';
COMMENT ON COLUMN lojas.pedidos.status IS 'Status do Pedido';
COMMENT ON COLUMN lojas.pedidos.loja_id IS 'Foreign Key de Lojas';
COMMENT ON TABLE lojas.pedidos IS 'Tabela de Pedidos';
-->
-- Envios
-->
CREATE TABLE lojas.envios (
                envio_id NUMERIC(38) NOT NULL,
                loja_id NUMERIC(38) NOT NULL,
                cliente_id NUMERIC(38) NOT NULL,
                endereco_entrega VARCHAR(512) NOT NULL,
                status VARCHAR(15) NOT NULL,
                CONSTRAINT envio_id PRIMARY KEY (envio_id)
);
ALTER TABLE lojas.envios OWNER TO cleiton;

COMMENT ON COLUMN lojas.envios.envio_id IS 'Primary Key envios';
COMMENT ON COLUMN lojas.envios.loja_id IS 'Foreign Key Lojas';
COMMENT ON COLUMN lojas.envios.cliente_id IS 'Foreign Key clientes';
COMMENT ON COLUMN lojas.envios.endereco_entrega IS 'Endereco de Entrega';
COMMENT ON COLUMN lojas.envios.status IS 'Status do envio';
COMMENT ON TABLE lojas.envios IS 'Tabela de produtos enviados';
-->
--Pedidos Itens
-->
CREATE TABLE lojas.pedidos_itens (
                produto_id NUMERIC(38) NOT NULL,
                pedido_id NUMERIC(38) NOT NULL,
                numero_da_linha NUMERIC(38) NOT NULL,
                preco_unitario NUMERIC(10,2) NOT NULL,
                quantidade NUMERIC(38) NOT NULL,
                envio_id NUMERIC(38),
                CONSTRAINT pedido_id PRIMARY KEY (produto_id, pedido_id)
);
ALTER TABLE lojas.pedidos_itens OWNER TO cleiton;

COMMENT ON COLUMN lojas.pedidos_itens.produto_id IS 'Primary Foreign Key de pedidos_itens';
COMMENT ON COLUMN lojas.pedidos_itens.pedido_id IS 'Primary Foreign Key de pedidos_itens';
COMMENT ON COLUMN lojas.pedidos_itens.envio_id IS 'Foreign Key de envios';
COMMENT ON COLUMN lojas.pedidos_itens.preco_unitario is 'Preco do pedido';
COMMENT ON COLUMN lojas.pedidos_itens.quantidade is 'Quantidade de itens no pedido';
COMMENT ON COLUMN lojas.pedidos_itens.envio_id is 'identificador do envio';
COMMENT ON TABLE lojas.pedidos_itens IS 'Tabela de itens nos pedidos';

--
-- Fk's
--

ALTER TABLE lojas.estoques ADD CONSTRAINT produtos_estoques_fk
FOREIGN KEY (produto_id)
REFERENCES lojas.produtos (produto_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE lojas.pedidos_itens ADD CONSTRAINT produtos_pedidos_itens_fk
FOREIGN KEY (produto_id)
REFERENCES lojas.produtos (produto_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE lojas.envios ADD CONSTRAINT lojas_envios_fk
FOREIGN KEY (loja_id)
REFERENCES lojas.lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE lojas.pedidos ADD CONSTRAINT lojas_pedidos_fk
FOREIGN KEY (loja_id)
REFERENCES lojas.lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE lojas.estoques ADD CONSTRAINT lojas_estoques_fk
FOREIGN KEY (loja_id)
REFERENCES lojas.lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE lojas.envios ADD CONSTRAINT clients_envios_fk
FOREIGN KEY (cliente_id)
REFERENCES lojas.clientes (cliente_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE lojas.pedidos ADD CONSTRAINT clients_pedidos_fk
FOREIGN KEY (cliente_id)
REFERENCES lojas.clientes (cliente_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE lojas.pedidos_itens ADD CONSTRAINT pedidos_pedidos_itens_fk
FOREIGN KEY (pedido_id)
REFERENCES lojas.pedidos (pedido_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE lojas.pedidos_itens ADD CONSTRAINT envios_pedidos_itens_fk
FOREIGN KEY (envio_id)
REFERENCES lojas.envios (envio_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

--
-- Checagem
--

ALTER TABLE lojas.produtos
ADD CONSTRAINT cc_lojas_produtos_preco
CHECK (preco_unitario BETWEEN 0.1 and 999999);

ALTER TABLE lojas.estoques
ADD CONSTRAINT cc_lojas_estoques_quantidade
CHECK (quantidade BETWEEN 0 and 999999);

ALTER TABLE lojas.pedidos
ADD CONSTRAINT cc_lojas_pedidos_status
CHECK (status IN ('CANCELADO', 'COMPLETO', 'ABERTO', 'PAGO', 'REEMBOLSADO', 'ENVIADO'));

ALTER TABLE lojas.envios
ADD CONSTRAINT cc_lojas_envios_status
CHECK (status IN ('CRIADO', 'ENVIADO', 'TRANSITO', 'ENTREGUE'));

ALTER TABLE lojas.lojas
ADD CONSTRAINT cc_lojas_lojas_endereco
CHECK (endereco_web IS NOT NULL or endereco_fisico IS NOT NULL);


