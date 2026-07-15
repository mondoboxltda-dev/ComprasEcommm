import os
import subprocess
import sys


BASE_DIR = os.path.dirname(os.path.abspath(__file__))
stdout_path = os.path.join(BASE_DIR, "server_stdout.log")
stderr_path = os.path.join(BASE_DIR, "server_stderr.log")

creationflags = 0
if os.name == "nt":
    creationflags = subprocess.CREATE_NEW_PROCESS_GROUP | subprocess.DETACHED_PROCESS

with open(stdout_path, "ab") as stdout, open(stderr_path, "ab") as stderr:
    process = subprocess.Popen(
        [sys.executable, os.path.join(BASE_DIR, "serve_wsgi.py")],
        cwd=BASE_DIR,
        stdin=subprocess.DEVNULL,
        stdout=stdout,
        stderr=stderr,
        close_fds=True,
        creationflags=creationflags,
    )

print(process.pid)
