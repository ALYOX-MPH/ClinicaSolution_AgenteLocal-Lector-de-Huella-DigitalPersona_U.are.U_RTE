# Agente Biométrico - Clínica Solution

Conecta el lector de huellas DigitalPersona U.are.U con el sistema Clínica Solution.

## Instalación (solo la primera vez)

1. Descarga esta carpeta completa (o el `.zip` de la última versión en **Releases**).
2. Conecta el lector de huellas por USB.
3. Haz **doble clic en `instalar.bat`**.
4. Si Windows pregunta "¿Deseas permitir que esta app haga cambios?", dale **Sí**.
5. Espera a que diga **"LISTO"**. Cierra la ventana.

Ya está. No hay que hacer nada más — el agente:
- Arranca solo cada vez que se enciende la computadora.
- Si se desconecta y se vuelve a conectar el lector, se reconecta solo.
- Si el programa llega a fallar por cualquier motivo, Windows lo reinicia automáticamente.

## Si algo no funciona

Haz doble clic en **`verificar_estado.bat`**. Te va a decir en pantalla:
- Si el servicio está corriendo.
- Si el lector está conectado.

Si sigue sin funcionar:
1. Verifica que el cable USB del lector esté bien puesto.
2. Ejecuta `desinstalar.bat` y luego `instalar.bat` de nuevo.
3. Si el problema persiste, contacta a soporte con una foto de lo que muestra `verificar_estado.bat`.

## Archivos de esta carpeta

| Archivo | Para qué sirve |
|---|---|
| `AgenteBiometrico.exe` | El programa que habla con el lector de huellas |
| `instalar.bat` | Lo instala como servicio (doble clic, una sola vez) |
| `desinstalar.bat` | Lo quita por completo de la PC |
| `verificar_estado.bat` | Revisa si está funcionando bien |

## Notas técnicas (para quien mantenga el proyecto)

- El agente corre como **servicio de Windows** (`AgenteBiometricoClinica`), con inicio automático y reinicio en caso de fallo (`sc failure`, 3 intentos por día, 5s entre cada uno).
- Expone dos endpoints locales:
  - `GET http://localhost:12413/capture` — captura de huella.
  - `GET http://localhost:12412/scan` — escaneo de documentos (WIA).
  - `GET http://localhost:12413/status` — diagnóstico rápido (¿lector conectado?).
- Un watchdog interno reintenta abrir el lector cada 5 segundos, así que una desconexión/reconexión de USB no requiere reiniciar el servicio.
- **Importante:** el módulo `/scan` (WIA) depende de un diálogo interactivo. Un servicio de Windows corre en Session 0 sin escritorio, así que si el escaneo de documentos deja de funcionar al correr como servicio, ese módulo necesita ejecutarse aparte (con sesión de usuario) — pendiente de validar en campo.
- Para generar un nuevo `AgenteBiometrico.exe` publicado (self-contained, no requiere .NET instalado en el cliente):
  ```
  dotnet publish -c Release -r win-x64 --self-contained true -p:PublishSingleFile=true
  ```
