import os

from dotenv import load_dotenv


load_dotenv()


class Config:
    SECRET_KEY = os.getenv("SECRET_KEY", "troque-esta-chave-em-producao")

    # Supabase/PostgreSQL. Em produção no Render, use DATABASE_URL.
    DATABASE_URL = os.getenv("DATABASE_URL", "").strip()

    # Fallback local legado em MySQL, útil enquanto a migração completa não termina.
    MYSQL_HOST = os.getenv("MYSQL_HOST", "localhost")
    MYSQL_PORT = int(os.getenv("MYSQL_PORT", "3306"))
    MYSQL_USER = os.getenv("MYSQL_USER", "root")
    MYSQL_PASSWORD = os.getenv("MYSQL_PASSWORD", "")
    MYSQL_DATABASE = os.getenv("MYSQL_DATABASE", "sistema_compras")
