package com.ejemplo;

import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        showMenu();
    }

    private static void showMenu() {
        Scanner scanner = new Scanner(System.in);

        while (true) {
            System.out.println("Seleccione una opción:");
            System.out.println("1) Descargar APK específico");
            System.out.println("2) Decompilar APK");
            System.out.println("3) Inyectar payload");
            System.out.println("4) Recompilar APK");
            System.out.println("5) Firmar y alinear APK");
            System.out.println("6) Verificar permisos de root");
            System.out.println("7) Salir");

            int option = scanner.nextInt();
            scanner.nextLine();  // Consume newline

            switch (option) {
                case 1:
                    System.out.print("URL del APK: ");
                    String url = scanner.nextLine();
                    System.out.print("Ruta de salida del APK: ");
                    String outputFile = scanner.nextLine();
                    Downloader.downloadApk(url, outputFile);
                    break;
                case 2:
                    System.out.print("Ruta del archivo APK: ");
                    String apkFile = scanner.nextLine();
                    System.out.print("Directorio de salida: ");
                    String outputDir = scanner.nextLine();
                    Decompiler.decompileApk(apkFile, outputDir);
                    break;
                case 3:
                    System.out.print("Directorio objetivo: ");
                    String targetDir = scanner.nextLine();
                    System.out.print("Archivo de payload: ");
                    String payloadFile = scanner.nextLine();
                    Injector.injectPayload(targetDir, payloadFile);
                    break;
                case 4:
                    System.out.print("Directorio de entrada: ");
                    String inputDir = scanner.nextLine();
                    System.out.print("Archivo APK de salida: ");
                    String outputApk = scanner.nextLine();
                    Recompiler.recompileApk(inputDir, outputApk);
                    break;
                case 5:
                    System.out.print("Archivo APK a firmar: ");
                    String apkFileToSign = scanner.nextLine();
                    System.out.print("Ruta del keystore: ");
                    String keystore = scanner.nextLine();
                    System.out.print("Alias del keystore: ");
                    String alias = scanner.nextLine();
                    System.out.print("Contraseña del keystore: ");
                    String storepass = scanner.nextLine();
                    Signer.signApk(apkFileToSign, keystore, alias, storepass);
                    break;
                case 6:
                    Permissions.checkPermissions();
                    break;
                case 7:
                    System.out.println("Saliendo...");
                    scanner.close();
                    return;
                default:
                    System.out.println("Opción no válida, por favor intente de nuevo.");
            }
        }
    }
}
