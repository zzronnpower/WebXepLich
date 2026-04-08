@echo off
setlocal

set BRANCH=%~1
if "%BRANCH%"=="" set BRANCH=main

powershell -ExecutionPolicy Bypass -File "%~dp0windows_update_code.ps1" -Branch "%BRANCH%"

endlocal
