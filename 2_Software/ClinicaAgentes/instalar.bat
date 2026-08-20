@echo off
setlocal enabledelayedexpansion

REM ================================================================
REM   Instalador del Agente Biometrico - Clinica Solution
REM   Doble clic y listo. No requiere escribir comandos.
REM ================================================================

REM --- Se auto-eleva a administrador si hace falta ---
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo Solicitando permisos de administrador...
    powershell -Command "Start-Process '%~f0' -Verb RunAs"
    exit /b
)

title Instalador - Agente Biometrico Clinica Solution
color 0B

set SERVICE_NAME=AgenteBiometricoClinica
set SCRIPT_DIR=%~dp0
set EXE_PATH=%SCRIPT_DIR%AgenteBiometrico.exe

echo ================================================================
echo    Instalador del Agente Biometrico - Clinica Solution
echo ================================================================
echo.

if not exist "%EXE_PATH%" (
    echo [ERROR] No se encontro AgenteBiometrico.exe
    echo Se esperaba en: %EXE_PATH%
    echo.
    echo Este archivo .bat debe estar en la MISMA carpeta que
    echo AgenteBiometrico.exe
    echo.
    pause
    exit /b 1
)

echo [1/5] Verificando si ya hay una version instalada...
sc query "%SERVICE_NAME%" >nul 2>&1
if %errorLevel% equ 0 (
    echo       Se encontro una version anterior. Actualizando...
    sc stop "%SERVICE_NAME%" >nul 2>&1
    timeout /t 3 /nobreak >nul
    sc delete "%SERVICE_NAME%" >nul 2>&1
    timeout /t 2 /nobreak >nul
) else (
    echo       No hay instalacion previa. Continuando...
)

echo [2/5] Configurando permisos del servicio...
echo.
echo Para que el lector USB funcione, el servicio necesita tus permisos de Windows.
echo Tu usuario actual es: %USERNAME%
set /p USER_PASS="Escribe tu contrasena de Windows y presiona Enter (no uses el PIN): "

sc create "%SERVICE_NAME%" binPath= "\"%EXE_PATH%\"" start= auto DisplayName= "Agente Biometrico Clinica Solution" obj= ".\%USERNAME%" password= "!USER_PASS!" >nul
if %errorLevel% neq 0 (
    echo [ERROR] No se pudo crear el servicio. Revisa que la contrasena sea correcta.
    pause
    exit /b 1
)

echo [3/5] Configurando reinicio automatico si el programa falla...
sc failure "%SERVICE_NAME%" reset= 86400 actions= restart/5000/restart/5000/restart/5000 >nul
sc failureflag "%SERVICE_NAME%" 1 >nul 2>&1
sc description "%SERVICE_NAME%" "Conecta el lector de huellas DigitalPersona U.are.U con el sistema Clinica Solution. Se reinicia solo si falla." >nul

echo [4/5] Iniciando el servicio...
sc start "%SERVICE_NAME%" >nul 2>&1
timeout /t 3 /nobreak >nul

echo [5/5] Verificando que quedo activo...
sc query "%SERVICE_NAME%" | findstr "RUNNING" >nul
if %errorLevel% equ 0 (
    echo.
    echo ================================================================
    echo    LISTO. El agente quedo instalado y funcionando.
    echo.
    echo    - Arrancara solo cada vez que se encienda la PC.
    echo    - Si se desconecta el lector y se vuelve a conectar,
    echo      se reconecta solo, sin reiniciar nada.
    echo    - Si el programa llega a fallar, Windows lo reinicia
    echo      automaticamente.
    echo ================================================================
) else (
    echo.
    echo [AVISO] El servicio se creo pero no arranco.
    echo Verifica que el lector de huellas este conectado por USB
    echo y ejecuta "verificar_estado.bat" para mas detalles.
)

echo.
pause
