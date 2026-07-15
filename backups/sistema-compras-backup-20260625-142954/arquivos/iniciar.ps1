$p = Split-Path -Parent $MyInvocation.MyCommand.Path
$my = "C:\Program Files\MySQL\MySQL Server 8.4\bin\mysqld.exe"
$ini = Join-Path $p "mysql.ini"
if (-not (Get-Process mysqld -ErrorAction SilentlyContinue)) {
    Start-Process $my -ArgumentList "--defaults-file=`"$ini`" --console" -WindowStyle Hidden
    Start-Sleep 3
}
if (-not (Get-Process python -ErrorAction SilentlyContinue)) {
    Start-Process python.exe -ArgumentList "-m flask --app app run --host 127.0.0.1 --port 5000 --no-reload" -WorkingDirectory $p -WindowStyle Hidden
    Start-Sleep 2
}
Start-Process "http://127.0.0.1:5000"
