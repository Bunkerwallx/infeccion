# Infeccion

Este proyecto tiene como objetivo proporcionar herramientas para modificar APKs en diferentes lenguajes de programación. A continuación, se detallan las diferentes implementaciones disponibles, incluyendo instrucciones para cada una.

Cada lenguaje tiene su propia implementación del proyecto "Infección". Aquí está la estructura general de las carpetas y archivos para cada uno:

### Lenguajes y Estructura de Archivos

1. **Bash**
    - **Archivos Principales**:
        - `infeccion.sh`: Script principal con menú interactivo.
    - **Dependencias**: `apktool`, `msfvenom`, `jarsigner`, `zipalign`, `keytool`, `curl`
    - **Descripción**: Script Bash para decompilar, inyectar, recompilar, firmar, y alinear APKs.

2. **Perl**
    - **Archivos Principales**:
        - `infeccion.pl`: Script Perl principal.
    - **Dependencias**: `apktool`, `msfvenom`, `jarsigner`, `zipalign`, `keytool`, `curl`
    - **Descripción**: Script Perl para la misma funcionalidad que el script Bash.

3. **PowerShell**
    - **Archivos Principales**:
        - `infeccion.ps1`: Script PowerShell principal.
    - **Dependencias**: `apktool`, `msfvenom`, `jarsigner`, `zipalign`, `keytool`, `curl`
    - **Descripción**: Script PowerShell para manejar las tareas de APK.

4. **Go**
    - **Archivos Principales**:
        - `main.go`: Código Go para el proyecto.
    - **Dependencias**: `apktool`, `jarsigner`, `zipalign`, `curl`
    - **Descripción**: Implementación en Go que proporciona funcionalidades similares a las versiones anteriores.

5. **Python**
    - **Archivos Principales**:
        - `infeccion.py`: Script Python para el proyecto.
    - **Dependencias**: `apktool`, `jarsigner`, `zipalign`, `requests`
    - **Descripción**: Script Python para manejar la decompilación, inyección, recompilación, firma y alineación de APKs.

6. **Java**
    - **Archivos Principales**:
        - `src/main/java/com/ejemplo/Main.java`: Clase principal para el menú interactivo.
    - **Dependencias**: `apktool`, `jarsigner`, `zipalign`
    - **Descripción**: Implementación en Java que ofrece una interfaz gráfica básica para interactuar con las funcionalidades del proyecto.

## Funcionalidades Comunes

Cada implementación del proyecto "Infección" proporciona las siguientes funcionalidades:

1. **Descargar APK Específico**
    - Descarga un APK desde una URL y lo guarda en el directorio de datos.

2. **Decompilar APK**
    - Utiliza `apktool` para descompilar el APK.

3. **Inyectar Payload**
    - Copia el archivo de payload en el directorio decompilado.

4. **Recompilar APK**
    - Usa `apktool` para recompilar el APK modificado.

5. **Firmar y Alinear APK**
    - Firma el APK utilizando `jarsigner` y alinea el APK con `zipalign`.

6. **Verificar Permisos de Root**
    - Verifica si el script se está ejecutando con permisos de root.

7. **Obtener Datos de una URL**
    - Descarga datos de una URL especificada.

## Instalación y Ejecución

### Bash / Perl / PowerShell

1. **Instalación**: Asegúrate de tener todas las dependencias instaladas (`apktool`, `msfvenom`, `jarsigner`, `zipalign`, `keytool`, `curl` para Bash y PowerShell, `requests` para Python).
2. **Ejecución**: Ejecuta el script correspondiente para tu sistema operativo.

### Go

1. **Instalación**: Asegúrate de tener Go instalado y configurado en tu sistema.
2. **Ejecución**: Compila el programa usando `go build` y ejecuta el binario resultante.

### Python

1. **Instalación**: Asegúrate de tener Python y el módulo `requests` instalado.
2. **Ejecución**: Ejecuta el script con `python infeccion.py`.

### Java

1. **Instalación**: Asegúrate de tener JDK y Maven instalados.
2. **Ejecución**: Compila el proyecto con `mvn compile` y ejecuta el programa con `mvn exec:java -Dexec.mainClass="com.ejemplo.Main"`.

## Contribuciones

Si deseas contribuir a este proyecto, por favor, abre un issue o una solicitud de extracción (pull request) en el repositorio correspondiente.

## Licencia

Este proyecto está licenciado bajo la Licencia MIT. Consulta el archivo `LICENSE` para obtener más información.



## Requisitos

- `curl` y `libcurl` para la descarga de datos.
- `apktool` para decompilar y recompilar APKs.
- `jarsigner` y `zipalign` para firmar y alinear APKs.

## Compilación

Para compilar el proyecto, ejecuta:

```sh
make run
```
