@echo off
setlocal

set DUMP_PATH=%~1

powershell -ExecutionPolicy Bypass -File "%~dp0windows_setup_and_restore.ps1" -DumpPath "%DUMP_PATH%"

endlocal
