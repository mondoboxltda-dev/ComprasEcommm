# ComprasPro online com Supabase + Render

Este projeto foi preparado para usar Supabase como banco PostgreSQL em produção.

## 1. Criar o banco no Supabase

1. Acesse o Supabase.
2. Crie um novo projeto.
3. Abra `SQL Editor`.
4. Cole e execute o conteúdo do arquivo:

```text
sistema-compras/database_supabase.sql
```

Esse arquivo cria as tabelas principais do ComprasPro em PostgreSQL.

## 2. Pegar a URL de conexão

No Supabase, procure a conexão PostgreSQL do projeto e copie a URI no formato parecido com:

```text
postgresql://postgres:SUA_SENHA@db.SEU_PROJETO.supabase.co:5432/postgres
```

No Render, essa URL deve ser cadastrada na variável:

```text
DATABASE_URL
```

## 3. Variáveis no Render

No serviço Web do Render, em `Environment`, cadastre:

```text
DATABASE_URL=postgresql://postgres:SUA_SENHA@db.SEU_PROJETO.supabase.co:5432/postgres
SECRET_KEY=uma-chave-grande-e-segura
ADMIN_INITIAL_NAME=Administrador
ADMIN_INITIAL_LOGIN=admin
ADMIN_INITIAL_PASSWORD=sua-senha-admin
```

Não cadastre mais `MYSQL_HOST`, `MYSQL_USER`, `MYSQL_PASSWORD`, `MYSQL_DATABASE` para produção com Supabase.

## 4. Comandos no Render

Build Command:

```bash
pip install -r requirements.txt
```

Start Command:

```bash
gunicorn wsgi:app
```

## 5. Importante

Supabase usa PostgreSQL. O projeto original foi criado em MySQL, então esta preparação inclui:

- suporte a `DATABASE_URL`;
- driver PostgreSQL `psycopg`;
- schema `database_supabase.sql`;
- configuração do Render sem variáveis MySQL.

Ainda pode ser necessário ajustar consultas específicas do `app.py` caso alguma tela use sintaxe antiga de MySQL. Se aparecer erro no Render, olhe o log e corrija a consulta apontada.
