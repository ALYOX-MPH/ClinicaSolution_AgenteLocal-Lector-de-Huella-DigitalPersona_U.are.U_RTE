@echo off
title Estado del Agente Biometrico - Clinica Solution
color 0E

set SERVICE_NAME=AgenteBiometricoClinica

echo ================================================================
echo    Estado del Agente Biometrico
echo ================================================================
echo.
echo --- Estado del servicio de Windows ---
sc query "%SERVICE_NAME%" 2>nul
if %errorLevel% neq 0 (
    echo El servicio NO esta instalado. Ejecuta instalar.bat primero.
    echo.
    pause
    exit /b
)

echo.
echo --- Estado del lector (via /status) ---
powershell -NoProfile -Command ^
    "try { $r = Invoke-RestMethod -Uri http://localhost:12413/status -TimeoutSec 5; if ($r.lector_conectado) { Write-Host 'Lector CONECTADO y listo para usar.' -ForegroundColor Green } else { Write-Host 'El agente esta corriendo pero NO detecta el lector. Verifica el cable USB.' -ForegroundColor Yellow } } catch { Write-Host 'El agente no esta respondiendo en el puerto 12413. Intenta reiniciar el servicio o reinstalar.' -ForegroundColor Red }"

echo.
echo Si algo no funciona:
echo   1. Verifica que el lector este bien conectado por USB.
echo   2. Ejecuta este archivo de nuevo.
echo   3. Si persiste, ejecuta desinstalar.bat y luego instalar.bat.
echo.
pause
