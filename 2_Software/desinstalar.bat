@echo off
REM ================================================================
REM   Desinstalador del Agente Biometrico - Clinica Solution
REM ================================================================

net session >nul 2>&1
if %errorLevel% neq 0 (
    echo Solicitando permisos de administrador...
    powershell -Command "Start-Process '%~f0' -Verb RunAs"
    exit /b
)

title Desinstalador - Agente Biometrico Clinica Solution

set SERVICE_NAME=AgenteBiometricoClinica

echo Deteniendo el servicio...
sc stop "%SERVICE_NAME%" >nul 2>&1
timeout /t 3 /nobreak >nul

echo Eliminando el servicio...
sc delete "%SERVICE_NAME%" >nul 2>&1

echo.
echo Listo. El Agente Biometrico fue desinstalado por completo.
echo.
pause
