# ComprasPro

Sistema SaaS de compras, estoque, recebimentos, orçamentos, histórico de compras e autorizações.

## Estrutura do projeto

```text
Projeto Compras/
├── sistema-compras/
│   ├── app.py
│   ├── config.py
│   ├── requirements.txt
│   ├── database.sql              # schema legado MySQL/local
│   ├── database_supabase.sql     # schema PostgreSQL/Supabase
│   ├── static/
│   └── templates/
├── wsgi.py
├── requirements.txt
├── render.yaml
├── Procfile
├── runtime.txt
└── SUPABASE_RENDER.md
```

## Deploy recomendado

Use:

- Render para hospedar o Flask;
- Supabase para o banco PostgreSQL.

## Passo 1: criar tabelas no Supabase

No Supabase, abra `SQL Editor`, cole e execute o arquivo:

```text
sistema-compras/database_supabase.sql
```

## Passo 2: variáveis no Render

No Render, abra o serviço Web > `Environment` e cadastre:

```text
DATABASE_URL=postgresql://postgres:SUA_SENHA@db.SEU_PROJETO.supabase.co:5432/postgres
SECRET_KEY=uma-chave-grande-e-segura
ADMIN_INITIAL_NAME=Administrador
ADMIN_INITIAL_LOGIN=admin
ADMIN_INITIAL_PASSWORD=sua-senha-admin
```

Para produção com Supabase, não use variáveis `MYSQL_*`.

## Passo 3: comandos no Render

Build Command:

```bash
pip install -r requirements.txt
```

Start Command:

```bash
gunicorn wsgi:app
```

## Login inicial

O sistema cria automaticamente o usuário administrador inicial usando:

```text
ADMIN_INITIAL_NAME
ADMIN_INITIAL_LOGIN
ADMIN_INITIAL_PASSWORD
```

Exemplo:

```text
Login: admin
Senha: definida em ADMIN_INITIAL_PASSWORD
```

## Guia detalhado

Veja também:

```text
SUPABASE_RENDER.md
```

## Observação importante

O projeto nasceu em MySQL e foi preparado para usar Supabase/PostgreSQL. Se alguma tela ainda apresentar erro SQL após o deploy, copie o erro do log do Render para ajustar a consulta específica.
