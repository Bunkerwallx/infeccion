# Función para decompilar un APK
function Decompile-Apk {
    param (
        [string]$apkFile,
        [string]$outputDir
    )
    & apktool d $apkFile -o $outputDir
    if ($LASTEXITCODE -eq 0) {
        Write-Output "APK decompilado correctamente en $outputDir"
    } else {
        Write-Error "Error al decompilar el APK"
        exit 1
    }
}

# Función para inyectar un payload en el directorio decompilado
function Inject-Payload {
    param (
        [string]$targetDir,
        [string]$payloadFile
    )
    Copy-Item $payloadFile -Destination $targetDir
    if ($LASTEXITCODE -eq 0) {
        Write-Output "Payload inyectado correctamente en $targetDir"
    } else {
        Write-Error "Error al inyectar el payload"
        exit 1
    }
}

# Función para recompilar un APK
function Recompile-Apk {
    param (
        [string]$inputDir,
        [string]$outputApk
    )
    & apktool b $inputDir -o $outputApk
    if ($LASTEXITCODE -eq 0) {
        Write-Output "APK recompilado correctamente en $outputApk"
    } else {
        Write-Error "Error al recompilar el APK"
        exit 1
    }
}

# Función para firmar y alinear un APK
function Sign-Apk {
    param (
        [string]$apkFile,
        [string]$keystore,
        [string]$alias,
        [string]$storepass
    )
    & jarsigner -keystore $keystore -storepass $storepass $apkFile $alias
    if ($LASTEXITCODE -eq 0) {
        Write-Output "APK firmado correctamente"
        & zipalign -v 4 $apkFile "${apkFile.Replace('.apk', '_aligned.apk')}"
        if ($LASTEXITCODE -eq 0) {
            Write-Output "APK alineado correctamente"
        } else {
            Write-Error "Error al alinear el APK"
            exit 1
        }
    } else {
        Write-Error "Error al firmar el APK"
        exit 1
    }
}

# Función para verificar permisos de root
function Check-Permissions {
    if (-not [Security.Principal.WindowsIdentity]::GetCurrent().Groups -contains [Security.Principal.WindowsBuiltInRole]::Administrator) {
        Write-Error "Este script debe ejecutarse como administrador"
        exit 1
    } else {
        Write-Output "Permisos de administrador verificados"
    }
}

# Función para obtener datos de una URL
function Fetch-Data {
    param (
        [string]$url
    )
    Invoke-WebRequest -Uri $url -OutFile 'data/temp_file'
    if ($?) {
        Write-Output "Datos obtenidos correctamente de $url"
    } else {
        Write-Error "Error al obtener datos de $url"
        exit 1
    }
}

# Función para descargar un APK desde una URL
function Download-Apk {
    param (
        [string]$url,
        [string]$outputFile
    )
    Invoke-WebRequest -Uri $url -OutFile $outputFile
    if ($?) {
        Write-Output "APK descargado correctamente en $outputFile"
    } else {
        Write-Error "Error al descargar el APK"
        exit 1
    }
}

# Función para mostrar el menú interactivo
function Show-Menu {
    while ($true) {
        Write-Output "Seleccione una opción:"
        Write-Output "1) Descargar APK específico"
        Write-Output "2) Decompilar APK"
        Write-Output "3) Inyectar payload"
        Write-Output "4) Recompilar APK"
        Write-Output "5) Firmar y alinear APK"
        Write-Output "6) Verificar permisos de administrador"
        Write-Output "7) Obtener datos de una URL"
        Write-Output "8) Salir"
        $option = Read-Host "Opción"

        switch ($option) {
            1 {
                $url = Read-Host "URL del APK"
                $outputFile = Read-Host "Ruta de salida del APK"
                Download-Apk -url $url -outputFile $outputFile
            }
            2 {
                $apkFile = Read-Host "Ruta del archivo APK"
                $outputDir = Read-Host "Directorio de salida"
                if (Test-Path $apkFile) {
                    Decompile-Apk -apkFile $apkFile -outputDir $outputDir
                } else {
                    Write-Error "El archivo APK no existe."
                }
            }
            3 {
                $targetDir = Read-Host "Directorio objetivo"
                $payloadFile = Read-Host "Archivo de payload"
                if (Test-Path $targetDir -and Test-Path $payloadFile) {
                    Inject-Payload -targetDir $targetDir -payloadFile $payloadFile
                } else {
                    Write-Error "Directorio objetivo o archivo de payload no válido."
                }
            }
            4 {
                $inputDir = Read-Host "Directorio de entrada"
                $outputApk = Read-Host "Archivo APK de salida"
                if (Test-Path $inputDir) {
                    Recompile-Apk -inputDir $inputDir -outputApk $outputApk
                } else {
                    Write-Error "El directorio de entrada no existe."
                }
            }
            5 {
                $apkFile = Read-Host "Archivo APK a firmar"
                $keystore = Read-Host "Ruta del keystore"
                $alias = Read-Host "Alias del keystore"
                $storepass = Read-Host "Contraseña del keystore"
                if (Test-Path $apkFile -and Test-Path $keystore) {
                    Sign-Apk -apkFile $apkFile -keystore $keystore -alias $alias -storepass $storepass
                } else {
                    Write-Error "Archivo APK o keystore no válido."
                }
            }
            6 {
                Check-Permissions
            }
            7 {
                $url = Read-Host "URL para obtener datos"
                Fetch-Data -url $url
            }
            8 {
                Write-Output "Saliendo..."
                break
            }
            default {
                Write-Error "Opción no válida, por favor intente de nuevo."
            }
        }
    }
}

# Mostrar el menú interactivo
Show-Menu
