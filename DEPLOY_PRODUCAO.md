# Deploy de produção: Render + Supabase

## 1. Banco

No SQL Editor do Supabase, execute nesta ordem:

1. `sistema-compras/database_supabase.sql`
2. `sistema-compras/supabase_atualizacao.sql`

O segundo arquivo adiciona colunas de compatibilidade, índices e RLS sem apagar dados.

## 2. Conexão

No painel do Supabase, abra `Connect` e copie a URL de `Session pooler`, porta 5432:

```text
postgresql://postgres.PROJETO:SENHA@aws-0-REGIAO.pooler.supabase.com:5432/postgres
```

Cadastre essa URL como `DATABASE_URL` no Render. Não use a conexão direta IPv6 nem
o Transaction pooler para este serviço Flask persistente.

## 3. Variáveis no Render

```text
DATABASE_URL=URL_DO_SESSION_POOLER
SECRET_KEY=CHAVE_ALEATORIA_FORTE
ADMIN_INITIAL_NAME=Administrador
ADMIN_INITIAL_LOGIN=admin
ADMIN_INITIAL_PASSWORD=SENHA_FORTE
DB_POOL_MIN_SIZE=1
DB_POOL_MAX_SIZE=5
DB_POOL_TIMEOUT=10
SESSION_COOKIE_SECURE=1
```

## 4. Região

Escolha regiões geograficamente próximas no Render e no Supabase. Uma grande
distância entre aplicação e banco aumenta o tempo de cada consulta.

## 5. Inicialização

```text
gunicorn --workers 2 --threads 2 --timeout 120 wsgi:app
```

O aplicativo reutiliza uma conexão durante toda a requisição e usa um pool pequeno
por worker. Ajuste `DB_POOL_MAX_SIZE` somente após observar o uso de conexões no
Supabase.
