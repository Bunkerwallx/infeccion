#!/bin/bash

# Función para decompilar un APK
function decompile_apk {
    local apk_file=$1
    local output_dir=$2
    apktool d "$apk_file" -o "$output_dir"
    if [[ $? -eq 0 ]]; then
        echo "APK decompilado correctamente en $output_dir"
    else
        echo "Error al decompilar el APK"
        exit 1
    fi
}

# Función para inyectar un payload en el directorio decompilado
function inject_payload {
    local target_dir=$1
    local payload_file=$2
    cp "$payload_file" "$target_dir"
    if [[ $? -eq 0 ]]; then
        echo "Payload inyectado correctamente en $target_dir"
    else
        echo "Error al inyectar el payload"
        exit 1
    fi
}

# Función para recompilar un APK
function recompile_apk {
    local input_dir=$1
    local output_apk=$2
    apktool b "$input_dir" -o "$output_apk"
    if [[ $? -eq 0 ]]; then
        echo "APK recompilado correctamente en $output_apk"
    else
        echo "Error al recompilar el APK"
        exit 1
    fi
}

# Función para firmar y alinear un APK
function sign_apk {
    local apk_file=$1
    local keystore=$2
    local alias=$3
    local storepass=$4
    jarsigner -keystore "$keystore" -storepass "$storepass" "$apk_file" "$alias"
    if [[ $? -eq 0 ]]; then
        echo "APK firmado correctamente"
        zipalign -v 4 "$apk_file" "${apk_file%.apk}_aligned.apk"
        if [[ $? -eq 0 ]]; then
            echo "APK alineado correctamente"
        else
            echo "Error al alinear el APK"
            exit 1
        fi
    else
        echo "Error al firmar el APK"
        exit 1
    fi
}

# Función para verificar permisos de root
function check_permissions {
    if [[ "$EUID" -ne 0 ]]; then
        echo "Este script debe ejecutarse como root"
        exit 1
    else
        echo "Permisos de root verificados"
    fi
}

# Función para obtener datos de una URL
function fetch_data {
    local url=$1
    curl -O "$url"
    if [[ $? -eq 0 ]]; then
        echo "Datos obtenidos correctamente de $url"
    else
        echo "Error al obtener datos de $url"
        exit 1
    fi
}

# Función para descargar un APK desde una URL
function download_apk {
    local url=$1
    local output_file=$2
    curl -o "$output_file" "$url"
    if [[ $? -eq 0 ]]; then
        echo "APK descargado correctamente en $output_file"
    else
        echo "Error al descargar el APK"
        exit 1
    fi
}

# Función para mostrar el menú interactivo
function show_menu {
    while true; do
        echo "Seleccione una opción:"
        echo "1) Descargar APK específico"
        echo "2) Decompilar APK"
        echo "3) Inyectar payload"
        echo "4) Recompilar APK"
        echo "5) Firmar y alinear APK"
        echo "6) Verificar permisos de root"
        echo "7) Obtener datos de una URL"
        echo "8) Salir"
        read -p "Opción: " option

        case $option in
            1)
                read -p "URL del APK: " url
                read -p "Ruta de salida del APK: " output_file
                download_apk "$url" "$output_file"
                ;;
            2)
                read -p "Ruta del archivo APK: " apk_file
                read -p "Directorio de salida: " output_dir
                if [[ -f "$apk_file" ]]; then
                    decompile_apk "$apk_file" "$output_dir"
                else
                    echo "El archivo APK no existe."
                fi
                ;;
            3)
                read -p "Directorio objetivo: " target_dir
                read -p "Archivo de payload: " payload_file
                if [[ -d "$target_dir" && -f "$payload_file" ]]; then
                    inject_payload "$target_dir" "$payload_file"
                else
                    echo "Directorio objetivo o archivo de payload no válido."
                fi
                ;;
            4)
                read -p "Directorio de entrada: " input_dir
                read -p "Archivo APK de salida: " output_apk
                if [[ -d "$input_dir" ]]; then
                    recompile_apk "$input_dir" "$output_apk"
                else
                    echo "El directorio de entrada no existe."
                fi
                ;;
            5)
                read -p "Archivo APK a firmar: " apk_file
                read -p "Ruta del keystore: " keystore
                read -p "Alias del keystore: " alias
                read -s -p "Contraseña del keystore: " storepass
                echo
                if [[ -f "$apk_file" && -f "$keystore" ]]; then
                    sign_apk "$apk_file" "$keystore" "$alias" "$storepass"
                else
                    echo "Archivo APK o keystore no válido."
                fi
                ;;
            6)
                check_permissions
                ;;
            7)
                read -p "URL para obtener datos: " url
                fetch_data "$url"
                ;;
            8)
                echo "Saliendo..."
                break
                ;;
            *)
                echo "Opción no válida, por favor intente de nuevo."
                ;;
        esac
    done
}

# Mostrar el menú interactivo
show_menu
