import os
from decompiler import decompile_apk
from injector import inject_payload
from recompiler import recompile_apk
from signer import sign_apk
from permissions import check_permissions
from downloader import download_apk

def show_menu():
    while True:
        print("Seleccione una opción:")
        print("1) Descargar APK específico")
        print("2) Decompilar APK")
        print("3) Inyectar payload")
        print("4) Recompilar APK")
        print("5) Firmar y alinear APK")
        print("6) Verificar permisos de root")
        print("7) Salir")

        option = input("Opción: ")

        if option == "1":
            url = input("URL del APK: ")
            output_file = input("Ruta de salida del APK: ")
            download_apk(url, output_file)
        elif option == "2":
            apk_file = input("Ruta del archivo APK: ")
            output_dir = input("Directorio de salida: ")
            if os.path.isfile(apk_file):
                decompile_apk(apk_file, output_dir)
            else:
                print("El archivo APK no existe.")
        elif option == "3":
            target_dir = input("Directorio objetivo: ")
            payload_file = input("Archivo de payload: ")
            if os.path.isdir(target_dir) and os.path.isfile(payload_file):
                inject_payload(target_dir, payload_file)
            else:
                print("Directorio objetivo o archivo de payload no válido.")
        elif option == "4":
            input_dir = input("Directorio de entrada: ")
            output_apk = input("Archivo APK de salida: ")
            if os.path.isdir(input_dir):
                recompile_apk(input_dir, output_apk)
            else:
                print("El directorio de entrada no existe.")
        elif option == "5":
            apk_file = input("Archivo APK a firmar: ")
            keystore = input("Ruta del keystore: ")
            alias = input("Alias del keystore: ")
            storepass = input("Contraseña del keystore: ")
            if os.path.isfile(apk_file) and os.path.isfile(keystore):
                sign_apk(apk_file, keystore, alias, storepass)
            else:
                print("Archivo APK o keystore no válido.")
        elif option == "6":
            check_permissions()
        elif option == "7":
            print("Saliendo...")
            break
        else:
            print("Opción no válida, por favor intente de nuevo.")
