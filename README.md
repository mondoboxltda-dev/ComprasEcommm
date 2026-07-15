# ComprasPro

Sistema SaaS de compras, estoque, fornecedores, produtos, ordens de compra, recebimentos, orcamentos e historico de compras.

## Estrutura

```text
Projeto Compras/
├── sistema-compras/
│   ├── app.py
│   ├── config.py
│   ├── requirements.txt
│   ├── database.sql
│   ├── static/
│   └── templates/
├── wsgi.py
├── requirements.txt
├── render.yaml
├── Procfile
└── runtime.txt
```

## Primeiro acesso

O sistema cria o primeiro administrador automaticamente quando a tabela de usuarios estiver vazia.

Configure estas variaveis antes do primeiro deploy:

```text
ADMIN_INITIAL_NAME=Administrador
ADMIN_INITIAL_LOGIN=admin
ADMIN_INITIAL_PASSWORD=defina-uma-senha-forte
```

Depois de entrar, altere a senha pelo menu **Usuarios**.

## Rodar localmente

```bash
cd sistema-compras
pip install -r requirements.txt
python app.py
```

Acesse:

```text
http://127.0.0.1:5000
```

## Variaveis de ambiente local

Crie um arquivo `.env` baseado em `sistema-compras/.env.example`:

```env
SECRET_KEY=sua-chave-secreta
ADMIN_INITIAL_NAME=Administrador
ADMIN_INITIAL_LOGIN=admin
ADMIN_INITIAL_PASSWORD=defina-uma-senha-forte
MYSQL_HOST=127.0.0.1
MYSQL_PORT=3306
MYSQL_USER=root
MYSQL_PASSWORD=sua-senha
MYSQL_DATABASE=sistema_compras
```

## Banco de dados

O arquivo base do banco esta em:

```text
sistema-compras/database.sql
```

No Render, o MySQL local do computador nao funciona. Use um banco MySQL externo, como Railway, Aiven, PlanetScale, Clever Cloud ou outro provedor MySQL.

## Deploy no Render - recomendado

Se voce subir o repositorio completo para o GitHub, deixe o **Root Directory vazio** no Render.

Use estes comandos:

**Build Command**

```bash
pip install -r requirements.txt
```

**Start Command**

```bash
gunicorn wsgi:app
```

Essa configuracao usa o arquivo `wsgi.py` da raiz para carregar o Flask que esta dentro de `sistema-compras/app.py`.

## Deploy no Render - alternativa

Se voce configurar no Render:

```text
Root Directory: sistema-compras
```

use:

**Build Command**

```bash
pip install -r requirements.txt
```

**Start Command**

```bash
gunicorn app:app
```

## Environment no Render

Cadastre estas variaveis no Render:

```text
SECRET_KEY
ADMIN_INITIAL_NAME
ADMIN_INITIAL_LOGIN
ADMIN_INITIAL_PASSWORD
MYSQL_HOST
MYSQL_PORT
MYSQL_USER
MYSQL_PASSWORD
MYSQL_DATABASE
```

Exemplo:

```text
MYSQL_PORT=3306
MYSQL_DATABASE=sistema_compras
```

## Arquivos importantes para deploy

- `requirements.txt` na raiz: aponta para `sistema-compras/requirements.txt`.
- `sistema-compras/requirements.txt`: dependencias reais do projeto.
- `wsgi.py`: entrada usada pelo Gunicorn quando o Render roda pela raiz.
- `render.yaml`: configuracao opcional do Render.
- `Procfile`: alternativa para plataformas que leem Procfile.
- `runtime.txt`: versao do Python.

## Erros comuns

### gunicorn: command not found

Confirme que `sistema-compras/requirements.txt` possui:

```text
gunicorn==22.0.0
```

### ModuleNotFoundError: No module named app

Se o Root Directory estiver vazio, use:

```bash
gunicorn wsgi:app
```

Se o Root Directory for `sistema-compras`, use:

```bash
gunicorn app:app
```

### Erro de MySQL

Confira as variaveis `MYSQL_HOST`, `MYSQL_USER`, `MYSQL_PASSWORD` e `MYSQL_DATABASE` no Render. O banco precisa aceitar conexao externa.
