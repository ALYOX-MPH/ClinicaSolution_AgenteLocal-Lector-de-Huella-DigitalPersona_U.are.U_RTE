      AGENTE LOCAL DE HARDWARE - CLÍNICA SOLUTION

Este paquete instala el comunicador biométrico y de escáner
para conectar su hardware físico con la plataforma web de
Clínica Solution.

REQUISITOS PREVIOS:

- Computadora con Windows 10 o Windows 11.
- Lector de Huellas DigitalPersona U.are.U 4500 conectado al USB.
- Impresora/Escáner encendida y conectada.

---

## PASO 1: INSTALAR LOS DRIVERS DEL LECTOR (Sólo la primera vez)

1. Desconecte el lector de huellas del puerto USB.
2. Entre a la carpeta "1_Drivers".
3. Entra a la Url del Driver y descargalo.
   Instale el primer driver en la carpeta RTE y el segundo en el SDK las opciones por defecto (Siguiente > Siguiente).
4. Reinicie la computadora.
5. Conecte el lector de huellas al puerto USB (Debe encender una luz y apagarse).

---

## PASO 2: INSTALAR EL AGENTE DE CLÍNICA SOLUTION

1. En esta carpeta principal, busque la carpeta llamada "ClinicaAgentes.rar" y descomprime .
2. Haga DOBLE CLIC sobre él archivo llamado instalar.bat.
3. Se abrirá una pantalla negra instalando los archivos. Presione cualquier tecla cuando diga "INSTALACIÓN COMPLETADA".

¡LISTO!`
El software ya está instalado y funcionando de forma invisible. A partir de ahora, cada vez que encienda la computadora, el Agente arrancará solo. Ya puede abrir su navegador y utilizar el sistema web de Clínica Solution con normalidad.

- NOTA TÉCNICA: El agente funciona en el puerto localhost:12412 y localhost:12413. Asegúrese de que su antivirus no bloquee estos puertos internos.

📦 ClinicaSolution_AgenteLocal
┣ 📂 1_Drivers
┃ ┗ 📜 DigitalPersona_U.are.U_RTE.rar (Solo el Run-Time Environment, no necesitan el SDK)(https://drive.google.com/file/d/1g3wZNBzsyoQFNXVV0zH_jLYlZRoQiYO-/view?usp=sharing)
┣ 📂 2_Software
┃ ┗ 📂 ClinicaAgentes
┃ ┗ 📜 AgenteBiometrico.exe (Y todos los .dll de la carpeta Release)
┗ 📜 LEEME_Instrucciones.txt
