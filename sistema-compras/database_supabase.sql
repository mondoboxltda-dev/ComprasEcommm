-- ComprasPro - schema PostgreSQL/Supabase
-- Rode este arquivo no Supabase: SQL Editor > New query > Run.

CREATE TABLE IF NOT EXISTS fornecedores (
  id SERIAL PRIMARY KEY,
  nome VARCHAR(150) NOT NULL,
  cnpj VARCHAR(18) UNIQUE,
  contato VARCHAR(100),
  telefone VARCHAR(30),
  email VARCHAR(150),
  status VARCHAR(20) NOT NULL DEFAULT 'ativo' CHECK (status IN ('ativo','inativo')),
  criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS unidades_medida (
  id SERIAL PRIMARY KEY,
  codigo VARCHAR(20) NOT NULL UNIQUE,
  nome VARCHAR(120) NOT NULL,
  status VARCHAR(20) NOT NULL DEFAULT 'ativo' CHECK (status IN ('ativo','inativo')),
  criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS cadastro_categorias (
  id SERIAL PRIMARY KEY,
  nome VARCHAR(120) NOT NULL UNIQUE,
  status VARCHAR(20) NOT NULL DEFAULT 'ativo' CHECK (status IN ('ativo','inativo')),
  criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  atualizado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS cadastro_tipos_pagamento (
  id SERIAL PRIMARY KEY,
  nome VARCHAR(120) NOT NULL UNIQUE,
  status VARCHAR(20) NOT NULL DEFAULT 'ativo' CHECK (status IN ('ativo','inativo')),
  criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  atualizado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS usuarios (
  id SERIAL PRIMARY KEY,
  nome VARCHAR(160) NOT NULL,
  login VARCHAR(80) NOT NULL UNIQUE,
  senha_hash VARCHAR(255) NOT NULL,
  tipo_acesso VARCHAR(30) NOT NULL DEFAULT 'comum' CHECK (tipo_acesso IN ('administrador','comum')),
  status VARCHAR(20) NOT NULL DEFAULT 'ativo' CHECK (status IN ('ativo','inativo')),
  ultimo_login TIMESTAMP,
  criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS usuario_permissoes (
  id SERIAL PRIMARY KEY,
  usuario_id INT NOT NULL REFERENCES usuarios(id) ON DELETE CASCADE,
  modulo VARCHAR(80) NOT NULL,
  pode_visualizar SMALLINT NOT NULL DEFAULT 0,
  atualizado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  UNIQUE (usuario_id, modulo)
);

CREATE TABLE IF NOT EXISTS produtos (
  id SERIAL PRIMARY KEY,
  codigo VARCHAR(30) NOT NULL,
  descricao VARCHAR(180) NOT NULL,
  categoria VARCHAR(80) NOT NULL,
  unidade VARCHAR(20) NOT NULL,
  quantidade_por_unidade_compra NUMERIC(14,4) NOT NULL DEFAULT 1,
  unidade_base VARCHAR(30) NOT NULL DEFAULT 'UN',
  fornecedor_id INT REFERENCES fornecedores(id),
  estoque_seguranca NUMERIC(12,2) NOT NULL DEFAULT 0,
  unidade_estoque_seguranca VARCHAR(30),
  estoque_atual NUMERIC(14,4) NOT NULL DEFAULT 0,
  custo_atual NUMERIC(14,4) NOT NULL DEFAULT 0,
  estoque_semanal NUMERIC(12,2) DEFAULT 0,
  consumo_semanal NUMERIC(12,2) DEFAULT 0,
  consumo_mensal NUMERIC(12,2) DEFAULT 0,
  status VARCHAR(30) NOT NULL DEFAULT 'ativo' CHECK (status IN ('ativo','inativo','pendente revisao')),
  criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS ordens_compra (
  id SERIAL PRIMARY KEY,
  numero_oc VARCHAR(30) NOT NULL UNIQUE,
  data_preenchimento DATE NOT NULL,
  tipo_material VARCHAR(80) NOT NULL,
  fornecedor_id INT NOT NULL REFERENCES fornecedores(id),
  produto_id INT REFERENCES produtos(id),
  quantidade NUMERIC(12,2) NOT NULL DEFAULT 0,
  preco_negociado NUMERIC(14,2) NOT NULL DEFAULT 0,
  frete NUMERIC(14,2) NOT NULL DEFAULT 0,
  valor_total NUMERIC(14,2) NOT NULL DEFAULT 0,
  data_entrega DATE NOT NULL,
  metodo_pagamento VARCHAR(80) NOT NULL,
  parcelas SMALLINT NOT NULL DEFAULT 1,
  prazos_parcelas VARCHAR(255),
  prazo_dias INT NOT NULL DEFAULT 0,
  nota_fiscal VARCHAR(60),
  status_compra VARCHAR(60) DEFAULT 'aguardando autorizacao',
  ordem_original_id INT REFERENCES ordens_compra(id),
  criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS ordem_compra_itens (
  id SERIAL PRIMARY KEY,
  ordem_id INT NOT NULL REFERENCES ordens_compra(id) ON DELETE CASCADE,
  produto_id INT NOT NULL REFERENCES produtos(id),
  quantidade NUMERIC(14,4) NOT NULL DEFAULT 0,
  preco_negociado NUMERIC(14,4) NOT NULL DEFAULT 0,
  frete NUMERIC(14,2) NOT NULL DEFAULT 0,
  valor_total_item NUMERIC(14,2) NOT NULL DEFAULT 0,
  categoria VARCHAR(80),
  unidade_compra VARCHAR(30),
  quantidade_por_unidade NUMERIC(14,4) NOT NULL DEFAULT 1,
  unidade_base VARCHAR(30),
  criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Compatibilidade para bancos Supabase que já foram criados com uma versão antiga deste schema.
ALTER TABLE ordem_compra_itens ADD COLUMN IF NOT EXISTS categoria VARCHAR(80);
ALTER TABLE ordem_compra_itens ADD COLUMN IF NOT EXISTS quantidade_por_unidade NUMERIC(14,4) NOT NULL DEFAULT 1;
ALTER TABLE ordem_compra_itens ADD COLUMN IF NOT EXISTS unidade_base VARCHAR(30);
DO $$
BEGIN
  IF EXISTS (
    SELECT 1 FROM information_schema.columns
    WHERE table_schema='public' AND table_name='ordem_compra_itens' AND column_name='qtd_por_unidade'
  ) THEN
    EXECUTE 'UPDATE ordem_compra_itens SET quantidade_por_unidade = qtd_por_unidade WHERE quantidade_por_unidade = 1';
  END IF;
END $$;

CREATE TABLE IF NOT EXISTS autorizacoes (
  id SERIAL PRIMARY KEY,
  ordem_id INT NOT NULL UNIQUE REFERENCES ordens_compra(id) ON DELETE CASCADE,
  autorizado_por VARCHAR(120),
  data_aprovacao DATE,
  decidido_em TIMESTAMP,
  status VARCHAR(20) DEFAULT 'pendente' CHECK (status IN ('pendente','aprovada','reprovada')),
  observacao TEXT
);

CREATE TABLE IF NOT EXISTS recebimentos (
  id SERIAL PRIMARY KEY,
  ordem_id INT NOT NULL UNIQUE REFERENCES ordens_compra(id) ON DELETE CASCADE,
  data_prevista DATE NOT NULL,
  data_real DATE,
  status VARCHAR(40) DEFAULT 'aguardando'
);

CREATE TABLE IF NOT EXISTS produto_fornecedor_relacionamentos (
  id SERIAL PRIMARY KEY,
  fornecedor VARCHAR(150) NOT NULL,
  cnpj VARCHAR(18),
  codigo_fornecedor VARCHAR(80) NOT NULL,
  descricao_fornecedor VARCHAR(255) NOT NULL,
  produto_id INT NOT NULL REFERENCES produtos(id),
  criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  atualizado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  UNIQUE (cnpj, codigo_fornecedor)
);
CREATE INDEX IF NOT EXISTS idx_rel_fornecedor_codigo ON produto_fornecedor_relacionamentos (fornecedor, codigo_fornecedor);

CREATE TABLE IF NOT EXISTS nfe_importacoes (
  id SERIAL PRIMARY KEY,
  ordem_id INT REFERENCES ordens_compra(id),
  origem VARCHAR(20) NOT NULL DEFAULT 'XML' CHECK (origem IN ('XML','Manual')),
  fornecedor VARCHAR(150) NOT NULL,
  fornecedor_cnpj VARCHAR(18) NOT NULL,
  numero_nf VARCHAR(30) NOT NULL,
  tipo_documento VARCHAR(40) NOT NULL DEFAULT 'Nota Fiscal',
  serie VARCHAR(10),
  chave_nfe VARCHAR(80) NOT NULL UNIQUE,
  data_emissao DATE,
  data_entrada DATE NOT NULL,
  data_entrega DATE,
  tipo_entrega VARCHAR(20) CHECK (tipo_entrega IN ('completa','parcial')),
  ordem_parcial_id INT REFERENCES ordens_compra(id),
  valor_total NUMERIC(14,2) NOT NULL DEFAULT 0,
  condicao_pagamento VARCHAR(120),
  observacoes TEXT,
  usuario_responsavel VARCHAR(120) NOT NULL DEFAULT 'Sistema',
  status_recebimento VARCHAR(60) NOT NULL DEFAULT 'Pendente',
  confirmado_em TIMESTAMP,
  criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  UNIQUE (fornecedor_cnpj, numero_nf, serie)
);

CREATE TABLE IF NOT EXISTS nfe_importacao_itens (
  id SERIAL PRIMARY KEY,
  nfe_importacao_id INT NOT NULL REFERENCES nfe_importacoes(id) ON DELETE CASCADE,
  produto_id INT REFERENCES produtos(id),
  codigo_fornecedor VARCHAR(80),
  descricao VARCHAR(255) NOT NULL,
  ncm VARCHAR(20),
  cfop VARCHAR(10),
  cest VARCHAR(20),
  unidade VARCHAR(20),
  quantidade NUMERIC(14,4) NOT NULL DEFAULT 0,
  valor_unitario NUMERIC(14,4) NOT NULL DEFAULT 0,
  desconto NUMERIC(14,2) NOT NULL DEFAULT 0,
  valor_total NUMERIC(14,2) NOT NULL DEFAULT 0,
  ean VARCHAR(30),
  status VARCHAR(20) NOT NULL DEFAULT 'pendente' CHECK (status IN ('vinculado','pendente'))
);

CREATE TABLE IF NOT EXISTS movimentacoes_estoque (
  id SERIAL PRIMARY KEY,
  produto_id INT NOT NULL REFERENCES produtos(id),
  recebimento_id INT NOT NULL REFERENCES nfe_importacoes(id),
  recebimento_item_id INT NOT NULL REFERENCES nfe_importacao_itens(id) ON DELETE CASCADE,
  data_movimentacao TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  tipo VARCHAR(30) NOT NULL,
  quantidade NUMERIC(14,4) NOT NULL,
  valor_unitario NUMERIC(14,4) NOT NULL DEFAULT 0,
  valor_total NUMERIC(14,2) NOT NULL DEFAULT 0,
  origem VARCHAR(20) NOT NULL,
  usuario VARCHAR(120) NOT NULL DEFAULT 'Sistema',
  UNIQUE (recebimento_item_id, tipo)
);

CREATE TABLE IF NOT EXISTS historico_custos (
  id SERIAL PRIMARY KEY,
  produto_id INT NOT NULL REFERENCES produtos(id),
  fornecedor VARCHAR(150) NOT NULL,
  documento VARCHAR(60),
  data_entrada DATE NOT NULL,
  quantidade NUMERIC(14,4) NOT NULL,
  unidade_compra VARCHAR(30),
  quantidade_por_unidade_compra NUMERIC(14,4) NOT NULL DEFAULT 1,
  unidade_base VARCHAR(30),
  quantidade_total_base NUMERIC(14,4) NOT NULL DEFAULT 0,
  valor_unitario NUMERIC(14,4) NOT NULL,
  valor_unitario_base NUMERIC(14,4) NOT NULL DEFAULT 0,
  valor_total NUMERIC(14,2) NOT NULL,
  origem VARCHAR(20) NOT NULL,
  recebimento_id INT NOT NULL REFERENCES nfe_importacoes(id),
  recebimento_item_id INT NOT NULL REFERENCES nfe_importacao_itens(id) ON DELETE CASCADE,
  criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  UNIQUE (recebimento_item_id, origem)
);

CREATE TABLE IF NOT EXISTS recebimento_auditoria (
  id SERIAL PRIMARY KEY,
  recebimento_id INT NOT NULL REFERENCES nfe_importacoes(id) ON DELETE CASCADE,
  usuario VARCHAR(120) NOT NULL DEFAULT 'Sistema',
  acao VARCHAR(80) NOT NULL,
  origem VARCHAR(20) NOT NULL,
  detalhes TEXT,
  criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS orcamentos (
  id SERIAL PRIMARY KEY,
  mes SMALLINT NOT NULL CHECK (mes BETWEEN 1 AND 12),
  ano SMALLINT NOT NULL,
  categoria_id INT NOT NULL REFERENCES cadastro_categorias(id),
  valor_orcamento NUMERIC(14,2) NOT NULL,
  orcamento_previsto NUMERIC(14,2),
  data_importacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  usuario_importacao VARCHAR(120),
  UNIQUE (categoria_id, ano, mes)
);

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
('M3','Metro Cúbico (M³)','ativo')
ON CONFLICT (codigo) DO UPDATE SET nome = EXCLUDED.nome, status = EXCLUDED.status;

INSERT INTO cadastro_tipos_pagamento (nome,status) VALUES
('PIX','ativo'),
('Boleto','ativo'),
('Cartão de Crédito','ativo'),
('Cartão de Débito','ativo'),
('Dinheiro','ativo'),
('Transferência','ativo')
ON CONFLICT (nome) DO NOTHING;



