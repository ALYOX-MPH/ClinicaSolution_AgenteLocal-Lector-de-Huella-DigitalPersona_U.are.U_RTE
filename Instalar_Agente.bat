@echo off
color 0A
echo ========================================================
echo      INSTALADOR - AGENTE CLINICA SOLUTION
echo ========================================================
echo.
echo Copiando archivos del sistema a la unidad C:\...
xcopy ".\2_Software\ClinicaAgentes" "C:\ClinicaAgentes" /E /I /H /Y /Q

echo.
echo Configurando el arranque automatico invisible...
set "TARGET_DIR=C:\ClinicaAgentes"
set "EXE_PATH=%TARGET_DIR%\AgenteBiometrico.exe"
set "STARTUP_DIR=%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup"
set "SHORTCUT_PATH=%STARTUP_DIR%\AgenteClinicaSolution.lnk"

:: Usamos PowerShell para crear el acceso directo de forma silenciosa
powershell -Command "$WshShell = New-Object -comObject WScript.Shell; $Shortcut = $WshShell.CreateShortcut('%SHORTCUT_PATH%'); $Shortcut.TargetPath = '%EXE_PATH%'; $Shortcut.WorkingDirectory = '%TARGET_DIR%'; $Shortcut.WindowStyle = 7; $Shortcut.Save()"

echo.
echo Iniciando el Agente por primera vez...
start "" "%EXE_PATH%"

echo.
echo ========================================================
echo INSTALACION COMPLETADA CON EXITO.
echo El Agente Biometrico ya esta funcionando en segundo plano.
echo ========================================================
pause