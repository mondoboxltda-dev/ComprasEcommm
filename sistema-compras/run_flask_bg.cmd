@echo off
cd /d "%~dp0"
python -m flask --app app run --host 127.0.0.1 --port 5000 --no-debugger --no-reload > flask_runtime.log 2>&1
