import subprocess

def sign_apk(apk_file, keystore, alias, storepass):
    result = subprocess.run(['jarsigner', '-keystore', keystore, '-storepass', storepass, apk_file, alias], capture_output=True, text=True)
    if result.returncode == 0:
        print("APK firmado correctamente")
        align_result = subprocess.run(['zipalign', '-v', '4', apk_file, f"{apk_file}_aligned.apk"], capture_output=True, text=True)
        if align_result.returncode == 0:
            print("APK alineado correctamente")
        else:
            print(f"Error al alinear el APK: {align_result.stderr}")
    else:
        print(f"Error al firmar el APK: {result.stderr}")
