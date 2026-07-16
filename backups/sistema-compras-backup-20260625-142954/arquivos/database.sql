CREATE DATABASE IF NOT EXISTS sistema_compras CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE sistema_compras;

CREATE TABLE fornecedores (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(150) NOT NULL,
  cnpj VARCHAR(18) NOT NULL UNIQUE,
  contato VARCHAR(100), telefone VARCHAR(30), email VARCHAR(150),
  status ENUM('ativo','inativo') NOT NULL DEFAULT 'ativo',
  criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE unidades_medida (
  id INT AUTO_INCREMENT PRIMARY KEY,
  codigo VARCHAR(20) NOT NULL UNIQUE,
  nome VARCHAR(120) NOT NULL,
  status ENUM('ativo','inativo') NOT NULL DEFAULT 'ativo',
  criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE cadastro_categorias (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(120) NOT NULL UNIQUE,
  status ENUM('ativo','inativo') NOT NULL DEFAULT 'ativo',
  criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  atualizado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE cadastro_tipos_pagamento (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(120) NOT NULL UNIQUE,
  status ENUM('ativo','inativo') NOT NULL DEFAULT 'ativo',
  criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  atualizado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE produtos (
  id INT AUTO_INCREMENT PRIMARY KEY,
  codigo VARCHAR(30) NOT NULL UNIQUE,
  descricao VARCHAR(180) NOT NULL,
  categoria VARCHAR(80) NOT NULL,
  unidade VARCHAR(20) NOT NULL,
  fornecedor_id INT NULL,
  estoque_seguranca DECIMAL(12,2) NOT NULL DEFAULT 0,
  estoque_semanal DECIMAL(12,2) DEFAULT 0,
  consumo_semanal DECIMAL(12,2) DEFAULT 0,
  consumo_mensal DECIMAL(12,2) DEFAULT 0,
  status ENUM('ativo','inativo') NOT NULL DEFAULT 'ativo',
  criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT fk_produto_fornecedor FOREIGN KEY (fornecedor_id) REFERENCES fornecedores(id)
);

CREATE TABLE ordens_compra (
  id INT AUTO_INCREMENT PRIMARY KEY,
  numero_oc VARCHAR(30) NOT NULL UNIQUE,
  data_preenchimento DATE NOT NULL,
  tipo_material VARCHAR(80) NOT NULL,
  fornecedor_id INT NOT NULL,
  produto_id INT NOT NULL,
  quantidade DECIMAL(12,2) NOT NULL,
  preco_negociado DECIMAL(14,2) NOT NULL,
  frete DECIMAL(14,2) NOT NULL DEFAULT 0,
  valor_total DECIMAL(14,2) NOT NULL,
  data_entrega DATE NOT NULL,
  metodo_pagamento VARCHAR(80) NOT NULL,
  prazo_dias INT NOT NULL DEFAULT 0,
  nota_fiscal VARCHAR(60),
  status_compra ENUM('aguardando autorizacao','aprovada','reprovada','em compra','recebida','cancelada') DEFAULT 'aguardando autorizacao',
  criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT fk_oc_fornecedor FOREIGN KEY (fornecedor_id) REFERENCES fornecedores(id),
  CONSTRAINT fk_oc_produto FOREIGN KEY (produto_id) REFERENCES produtos(id)
);

CREATE TABLE autorizacoes (
  id INT AUTO_INCREMENT PRIMARY KEY,
  ordem_id INT NOT NULL UNIQUE,
  autorizado_por VARCHAR(120), data_aprovacao DATE,
  status ENUM('pendente','aprovada','reprovada') DEFAULT 'pendente',
  observacao TEXT,
  CONSTRAINT fk_aut_ordem FOREIGN KEY (ordem_id) REFERENCES ordens_compra(id) ON DELETE CASCADE
);

CREATE TABLE recebimentos (
  id INT AUTO_INCREMENT PRIMARY KEY,
  ordem_id INT NOT NULL UNIQUE,
  data_prevista DATE NOT NULL, data_real DATE,
  status ENUM('aguardando','entregue parcial','entregue completo','atrasado') DEFAULT 'aguardando',
  CONSTRAINT fk_rec_ordem FOREIGN KEY (ordem_id) REFERENCES ordens_compra(id) ON DELETE CASCADE
);

CREATE TABLE produto_fornecedor_relacionamentos (
  id INT AUTO_INCREMENT PRIMARY KEY,
  fornecedor VARCHAR(150) NOT NULL,
  cnpj VARCHAR(18),
  codigo_fornecedor VARCHAR(80) NOT NULL,
  descricao_fornecedor VARCHAR(255) NOT NULL,
  produto_id INT NOT NULL,
  criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  atualizado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  CONSTRAINT fk_rel_produto FOREIGN KEY (produto_id) REFERENCES produtos(id),
  UNIQUE KEY uk_rel_cnpj_codigo (cnpj,codigo_fornecedor),
  KEY idx_rel_fornecedor_codigo (fornecedor,codigo_fornecedor)
);

CREATE TABLE nfe_importacoes (
  id INT AUTO_INCREMENT PRIMARY KEY,
  ordem_id INT NULL,
  fornecedor VARCHAR(150) NOT NULL,
  fornecedor_cnpj VARCHAR(18) NOT NULL,
  numero_nf VARCHAR(30) NOT NULL,
  serie VARCHAR(10),
  chave_nfe VARCHAR(60) NOT NULL UNIQUE,
  data_emissao DATE,
  data_entrada DATE NOT NULL,
  valor_total DECIMAL(14,2) NOT NULL DEFAULT 0,
  criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT fk_nfe_ordem FOREIGN KEY (ordem_id) REFERENCES ordens_compra(id),
  UNIQUE KEY uk_nfe_fornecedor_numero_serie (fornecedor_cnpj,numero_nf,serie)
);

CREATE TABLE nfe_importacao_itens (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nfe_importacao_id INT NOT NULL,
  produto_id INT NULL,
  codigo_fornecedor VARCHAR(80),
  descricao VARCHAR(255) NOT NULL,
  ncm VARCHAR(20),
  cfop VARCHAR(10),
  cest VARCHAR(20),
  unidade VARCHAR(20),
  quantidade DECIMAL(14,4) NOT NULL DEFAULT 0,
  valor_unitario DECIMAL(14,4) NOT NULL DEFAULT 0,
  valor_total DECIMAL(14,2) NOT NULL DEFAULT 0,
  ean VARCHAR(30),
  status ENUM('vinculado','pendente') NOT NULL DEFAULT 'pendente',
  CONSTRAINT fk_nfe_item_importacao FOREIGN KEY (nfe_importacao_id) REFERENCES nfe_importacoes(id) ON DELETE CASCADE,
  CONSTRAINT fk_nfe_item_produto FOREIGN KEY (produto_id) REFERENCES produtos(id)
);

CREATE TABLE orcamentos (
  id INT AUTO_INCREMENT PRIMARY KEY,
  categoria VARCHAR(80) NOT NULL, ano SMALLINT NOT NULL, mes TINYINT NOT NULL,
  orcamento_previsto DECIMAL(14,2) NOT NULL,
  UNIQUE KEY uk_orcamento (categoria,ano,mes)
);

INSERT INTO fornecedores (nome,cnpj,contato,telefone,email,status) VALUES
('Alpha Materiais Ltda','12.345.678/0001-90','Marina Costa','(11) 98888-1111','vendas@alpha.com.br','ativo'),
('Tech Office Brasil','98.765.432/0001-10','Paulo Lima','(11) 97777-2222','paulo@techoffice.com.br','ativo'),
('Logistica Sul S.A.','45.111.222/0001-33','Ana Souza','(41) 96666-3333','comercial@logisticasul.com.br','ativo');

INSERT INTO unidades_medida (codigo,nome,status) VALUES
('UN','Unidade','ativo'),
('CX','Caixa','ativo'),
('PCT','Pacote','ativo'),
('KG','Quilograma','ativo'),
('G','Grama','ativo'),
('L','Litro','ativo'),
('ML','Mililitro','ativo'),
('M','Metro','ativo'),
('ROLO','Rolo','ativo'),
('PALLET','Pallet','ativo'),
('FARDO','Fardo','ativo'),
('KIT','Kit','ativo'),
('PAR','Par','ativo'),
('M2','Metro Quadrado (M²)','ativo'),
('M3','Metro Cúbico (M³)','ativo');

INSERT INTO cadastro_categorias (nome,status) VALUES
('Material de escritorio','ativo'),
('Tecnologia','ativo'),
('Limpeza','ativo'),
('Importado via NF-e','ativo');

INSERT INTO cadastro_tipos_pagamento (nome,status) VALUES
('PIX','ativo'),
('Boleto','ativo'),
('Cartao de Credito','ativo'),
('Cartao de Debito','ativo'),
('Dinheiro','ativo'),
('Transferencia','ativo');

INSERT INTO produtos (codigo,descricao,categoria,unidade,fornecedor_id,estoque_seguranca,status) VALUES
('MAT-001','Papel A4 75g - caixa','Material de escritorio','CX',1,12,'ativo'),
('TI-001','Notebook corporativo 14 polegadas','Tecnologia','UN',2,3,'ativo'),
('LIM-001','Detergente neutro 5 litros','Limpeza','L',3,20,'ativo');

INSERT INTO ordens_compra (numero_oc,data_preenchimento,tipo_material,fornecedor_id,produto_id,quantidade,preco_negociado,frete,valor_total,data_entrega,metodo_pagamento,prazo_dias,nota_fiscal,status_compra) VALUES
('OC-2026-00001','2026-06-02','Material de escritorio',1,1,10,245.90,80,2539.00,'2026-06-12','Boleto 28 dias',10,'NF-1001','recebida'),
('OC-2026-00002','2026-06-08','Tecnologia',2,2,5,4290.00,150,21600.00,'2026-06-25','Transferencia bancaria',17,NULL,'aguardando autorizacao'),
('OC-2026-00003','2026-05-10','Limpeza',3,3,30,39.50,120,1305.00,'2026-05-20','Boleto 21 dias',10,NULL,'aprovada');

INSERT INTO autorizacoes (ordem_id,autorizado_por,data_aprovacao,status,observacao) VALUES
(1,'Carlos Mendes','2026-06-03','aprovada','Compra recorrente aprovada.'),(2,NULL,NULL,'pendente',NULL),(3,'Carlos Mendes','2026-05-11','aprovada','Dentro do orcamento.');
INSERT INTO recebimentos (ordem_id,data_prevista,data_real,status) VALUES
(1,'2026-06-12','2026-06-11','entregue completo'),(2,'2026-06-25',NULL,'aguardando'),(3,'2026-05-20',NULL,'aguardando');
INSERT INTO orcamentos (categoria,ano,mes,orcamento_previsto) VALUES
('Material de escritorio',2026,6,10000),('Tecnologia',2026,6,50000),('Limpeza',2026,5,8000);
