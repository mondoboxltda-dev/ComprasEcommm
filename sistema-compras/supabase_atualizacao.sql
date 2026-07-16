-- ComprasPro - atualização do schema PostgreSQL/Supabase
-- Execute após database_supabase.sql no Supabase SQL Editor.
-- Este script é idempotente e não apaga dados existentes.

BEGIN;

ALTER TABLE usuarios ADD COLUMN IF NOT EXISTS ultimo_login TIMESTAMP;
ALTER TABLE usuarios ADD COLUMN IF NOT EXISTS atualizado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP;

ALTER TABLE produtos ADD COLUMN IF NOT EXISTS fornecedor_id INT REFERENCES fornecedores(id);
ALTER TABLE produtos ADD COLUMN IF NOT EXISTS quantidade_por_unidade_compra NUMERIC(14,4) NOT NULL DEFAULT 1;
ALTER TABLE produtos ADD COLUMN IF NOT EXISTS unidade_base VARCHAR(30) NOT NULL DEFAULT 'UN';
ALTER TABLE produtos ADD COLUMN IF NOT EXISTS estoque_seguranca NUMERIC(12,2) NOT NULL DEFAULT 0;
ALTER TABLE produtos ADD COLUMN IF NOT EXISTS unidade_estoque_seguranca VARCHAR(30);
ALTER TABLE produtos ADD COLUMN IF NOT EXISTS estoque_atual NUMERIC(14,4) NOT NULL DEFAULT 0;
ALTER TABLE produtos ADD COLUMN IF NOT EXISTS custo_atual NUMERIC(14,4) NOT NULL DEFAULT 0;

ALTER TABLE ordens_compra ADD COLUMN IF NOT EXISTS parcelas SMALLINT NOT NULL DEFAULT 1;
ALTER TABLE ordens_compra ADD COLUMN IF NOT EXISTS prazos_parcelas VARCHAR(255);
ALTER TABLE ordens_compra ADD COLUMN IF NOT EXISTS ordem_original_id INT REFERENCES ordens_compra(id);

ALTER TABLE ordem_compra_itens ADD COLUMN IF NOT EXISTS categoria VARCHAR(80);
ALTER TABLE ordem_compra_itens ADD COLUMN IF NOT EXISTS unidade_compra VARCHAR(30);
ALTER TABLE ordem_compra_itens ADD COLUMN IF NOT EXISTS quantidade_por_unidade NUMERIC(14,4) NOT NULL DEFAULT 1;
ALTER TABLE ordem_compra_itens ADD COLUMN IF NOT EXISTS unidade_base VARCHAR(30);

ALTER TABLE autorizacoes ADD COLUMN IF NOT EXISTS decidido_em TIMESTAMP;

ALTER TABLE nfe_importacoes ADD COLUMN IF NOT EXISTS ordem_id INT REFERENCES ordens_compra(id);
ALTER TABLE nfe_importacoes ADD COLUMN IF NOT EXISTS origem VARCHAR(20) NOT NULL DEFAULT 'XML';
ALTER TABLE nfe_importacoes ADD COLUMN IF NOT EXISTS tipo_documento VARCHAR(40) NOT NULL DEFAULT 'Nota Fiscal';
ALTER TABLE nfe_importacoes ADD COLUMN IF NOT EXISTS condicao_pagamento VARCHAR(120);
ALTER TABLE nfe_importacoes ADD COLUMN IF NOT EXISTS observacoes TEXT;
ALTER TABLE nfe_importacoes ADD COLUMN IF NOT EXISTS data_entrega DATE;
ALTER TABLE nfe_importacoes ADD COLUMN IF NOT EXISTS tipo_entrega VARCHAR(20);
ALTER TABLE nfe_importacoes ADD COLUMN IF NOT EXISTS ordem_parcial_id INT REFERENCES ordens_compra(id);
ALTER TABLE nfe_importacoes ADD COLUMN IF NOT EXISTS usuario_responsavel VARCHAR(120) NOT NULL DEFAULT 'Sistema';
ALTER TABLE nfe_importacoes ADD COLUMN IF NOT EXISTS status_recebimento VARCHAR(60) NOT NULL DEFAULT 'Pendente';
ALTER TABLE nfe_importacoes ADD COLUMN IF NOT EXISTS confirmado_em TIMESTAMP;

ALTER TABLE nfe_importacao_itens ADD COLUMN IF NOT EXISTS desconto NUMERIC(14,2) NOT NULL DEFAULT 0;

ALTER TABLE historico_custos ADD COLUMN IF NOT EXISTS unidade_compra VARCHAR(30);
ALTER TABLE historico_custos ADD COLUMN IF NOT EXISTS quantidade_por_unidade_compra NUMERIC(14,4) NOT NULL DEFAULT 1;
ALTER TABLE historico_custos ADD COLUMN IF NOT EXISTS unidade_base VARCHAR(30);
ALTER TABLE historico_custos ADD COLUMN IF NOT EXISTS quantidade_total_base NUMERIC(14,4) NOT NULL DEFAULT 0;
ALTER TABLE historico_custos ADD COLUMN IF NOT EXISTS valor_unitario_base NUMERIC(14,4) NOT NULL DEFAULT 0;

ALTER TABLE orcamentos ADD COLUMN IF NOT EXISTS categoria_id INT REFERENCES cadastro_categorias(id);
ALTER TABLE orcamentos ADD COLUMN IF NOT EXISTS valor_orcamento NUMERIC(14,2);
ALTER TABLE orcamentos ADD COLUMN IF NOT EXISTS orcamento_previsto NUMERIC(14,2);
ALTER TABLE orcamentos ADD COLUMN IF NOT EXISTS data_importacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP;
ALTER TABLE orcamentos ADD COLUMN IF NOT EXISTS usuario_importacao VARCHAR(120);

DO $$
BEGIN
  IF EXISTS (
    SELECT 1 FROM information_schema.columns
    WHERE table_schema='public' AND table_name='orcamentos' AND column_name='categoria'
  ) THEN
    EXECUTE $sql$
      UPDATE orcamentos o SET categoria_id=c.id
      FROM cadastro_categorias c
      WHERE o.categoria_id IS NULL AND o.categoria=c.nome
    $sql$;
  END IF;
END $$;

UPDATE orcamentos SET valor_orcamento=orcamento_previsto
WHERE valor_orcamento IS NULL AND orcamento_previsto IS NOT NULL;
UPDATE orcamentos SET orcamento_previsto=valor_orcamento
WHERE orcamento_previsto IS NULL AND valor_orcamento IS NOT NULL;
UPDATE produtos SET quantidade_por_unidade_compra=1
WHERE quantidade_por_unidade_compra IS NULL OR quantidade_por_unidade_compra<=0;
UPDATE produtos SET unidade_base=unidade
WHERE unidade_base IS NULL OR BTRIM(unidade_base)='';

CREATE OR REPLACE FUNCTION public.compraspro_set_atualizado_em()
RETURNS TRIGGER LANGUAGE plpgsql AS $$
BEGIN
  NEW.atualizado_em = CURRENT_TIMESTAMP;
  RETURN NEW;
END;
$$;

DROP TRIGGER IF EXISTS trg_usuarios_atualizado_em ON usuarios;
CREATE TRIGGER trg_usuarios_atualizado_em BEFORE UPDATE ON usuarios
FOR EACH ROW EXECUTE FUNCTION public.compraspro_set_atualizado_em();
DROP TRIGGER IF EXISTS trg_categorias_atualizado_em ON cadastro_categorias;
CREATE TRIGGER trg_categorias_atualizado_em BEFORE UPDATE ON cadastro_categorias
FOR EACH ROW EXECUTE FUNCTION public.compraspro_set_atualizado_em();
DROP TRIGGER IF EXISTS trg_pagamentos_atualizado_em ON cadastro_tipos_pagamento;
CREATE TRIGGER trg_pagamentos_atualizado_em BEFORE UPDATE ON cadastro_tipos_pagamento
FOR EACH ROW EXECUTE FUNCTION public.compraspro_set_atualizado_em();
DROP TRIGGER IF EXISTS trg_produto_fornecedor_atualizado_em ON produto_fornecedor_relacionamentos;
CREATE TRIGGER trg_produto_fornecedor_atualizado_em BEFORE UPDATE ON produto_fornecedor_relacionamentos
FOR EACH ROW EXECUTE FUNCTION public.compraspro_set_atualizado_em();

CREATE INDEX IF NOT EXISTS idx_produtos_fornecedor ON produtos (fornecedor_id);
CREATE INDEX IF NOT EXISTS idx_produtos_codigo ON produtos (codigo);
CREATE INDEX IF NOT EXISTS idx_produtos_categoria_status ON produtos (categoria, status);
CREATE INDEX IF NOT EXISTS idx_ordens_fornecedor ON ordens_compra (fornecedor_id);
CREATE INDEX IF NOT EXISTS idx_ordens_data_status ON ordens_compra (data_preenchimento, status_compra);
CREATE INDEX IF NOT EXISTS idx_ordem_itens_ordem ON ordem_compra_itens (ordem_id);
CREATE INDEX IF NOT EXISTS idx_ordem_itens_produto ON ordem_compra_itens (produto_id);
CREATE INDEX IF NOT EXISTS idx_nfe_ordem ON nfe_importacoes (ordem_id);
CREATE INDEX IF NOT EXISTS idx_nfe_data_entrada ON nfe_importacoes (data_entrada);
CREATE INDEX IF NOT EXISTS idx_nfe_itens_nfe ON nfe_importacao_itens (nfe_importacao_id);
CREATE INDEX IF NOT EXISTS idx_nfe_itens_produto ON nfe_importacao_itens (produto_id);
CREATE INDEX IF NOT EXISTS idx_movimentacoes_produto_data ON movimentacoes_estoque (produto_id, data_movimentacao);
CREATE INDEX IF NOT EXISTS idx_historico_produto_data ON historico_custos (produto_id, data_entrada);
CREATE INDEX IF NOT EXISTS idx_recebimento_auditoria_recebimento ON recebimento_auditoria (recebimento_id);
CREATE INDEX IF NOT EXISTS idx_orcamentos_competencia ON orcamentos (ano, mes, categoria_id);

-- O backend Flask usa DATABASE_URL. O RLS sem políticas públicas impede que
-- chaves anon/authenticated acessem diretamente os dados pela API Supabase.
ALTER TABLE fornecedores ENABLE ROW LEVEL SECURITY;
ALTER TABLE unidades_medida ENABLE ROW LEVEL SECURITY;
ALTER TABLE cadastro_categorias ENABLE ROW LEVEL SECURITY;
ALTER TABLE cadastro_tipos_pagamento ENABLE ROW LEVEL SECURITY;
ALTER TABLE usuarios ENABLE ROW LEVEL SECURITY;
ALTER TABLE usuario_permissoes ENABLE ROW LEVEL SECURITY;
ALTER TABLE produtos ENABLE ROW LEVEL SECURITY;
ALTER TABLE ordens_compra ENABLE ROW LEVEL SECURITY;
ALTER TABLE ordem_compra_itens ENABLE ROW LEVEL SECURITY;
ALTER TABLE autorizacoes ENABLE ROW LEVEL SECURITY;
ALTER TABLE recebimentos ENABLE ROW LEVEL SECURITY;
ALTER TABLE produto_fornecedor_relacionamentos ENABLE ROW LEVEL SECURITY;
ALTER TABLE nfe_importacoes ENABLE ROW LEVEL SECURITY;
ALTER TABLE nfe_importacao_itens ENABLE ROW LEVEL SECURITY;
ALTER TABLE movimentacoes_estoque ENABLE ROW LEVEL SECURITY;
ALTER TABLE historico_custos ENABLE ROW LEVEL SECURITY;
ALTER TABLE recebimento_auditoria ENABLE ROW LEVEL SECURITY;
ALTER TABLE orcamentos ENABLE ROW LEVEL SECURITY;

COMMIT;
