import os

def check_permissions():
    if os.geteuid() != 0:
        print("Este script debe ejecutarse como root")
    else:
        print("Permisos de root verificados")
