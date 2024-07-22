import subprocess

def decompile_apk(apk_file, output_dir):
    result = subprocess.run(['apktool', 'd', apk_file, '-o', output_dir], capture_output=True, text=True)
    if result.returncode == 0:
        print(f"APK decompilado correctamente en {output_dir}")
    else:
        print(f"Error al decompilar el APK: {result.stderr}")
