import subprocess

def recompile_apk(input_dir, output_apk):
    result = subprocess.run(['apktool', 'b', input_dir, '-o', output_apk], capture_output=True, text=True)
    if result.returncode == 0:
        print(f"APK recompilado correctamente en {output_apk}")
    else:
        print(f"Error al recompilar el APK: {result.stderr}")
