import requests

def download_apk(url, output_file):
    response = requests.get(url, stream=True)
    if response.status_code == 200:
        with open(output_file, 'wb') as file:
            for chunk in response.iter_content(chunk_size=8192):
                file.write(chunk)
        print(f"APK descargado correctamente en {output_file}")
    else:
        print(f"Error al obtener el archivo de {url}: {response.status_code}")
