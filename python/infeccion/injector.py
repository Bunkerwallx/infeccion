import shutil
import os

def inject_payload(target_dir, payload_file):
    if os.path.exists(target_dir) and os.path.isfile(payload_file):
        shutil.copy(payload_file, target_dir)
        print(f"Payload inyectado correctamente en {target_dir}")
    else:
        print("Directorio objetivo o archivo de payload no válido.")
