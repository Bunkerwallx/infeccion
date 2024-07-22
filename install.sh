#!/bin/bash

# Función para instalar paquetes en Arch Linux
install_arch() {
    echo "Instalando paquetes en Arch Linux..."
    sudo pacman -Syu --noconfirm apktool msfvenom jdk-openjdk curl
}

# Función para instalar paquetes en Parrot (basado en Debian)
install_parrot() {
    echo "Instalando paquetes en Parrot (basado en Debian)..."
    sudo apt update
    sudo apt install -y apktool msfvenom openjdk-11-jdk curl
}

# Función para instalar paquetes en Fedora
install_fedora() {
    echo "Instalando paquetes en Fedora..."
    sudo dnf install -y apktool msfvenom java-openjdk curl
}

# Verificar la distribución del sistema operativo
if [[ -f /etc/arch-release ]]; then
    install_arch
elif grep -qi parrot /etc/os-release; then
    install_parrot
elif grep -qi fedora /etc/os-release; then
    install_fedora
else
    echo "Distribución no soportada. Por favor, instala los paquetes manualmente."
    exit 1
fi

echo "Instalación completada."
