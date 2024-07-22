package com.ejemplo;

import java.io.IOException;

public class Signer {
    public static void signApk(String apkFile, String keystore, String alias, String storepass) {
        try {
            Process process = new ProcessBuilder(
                "jarsigner",
                "-keystore", keystore,
                "-storepass", storepass,
                apkFile,
                alias
            ).inheritIO().start();
            process.waitFor();
            System.out.println("APK firmado correctamente");

            Process alignProcess = new ProcessBuilder(
                "zipalign", "-v", "4", apkFile, apkFile.replace(".apk", "_aligned.apk")
            ).inheritIO().start();
            alignProcess.waitFor();
            System.out.println("APK alineado correctamente");
        } catch (IOException | InterruptedException e) {
            System.out.println("Error al firmar el APK: " + e.getMessage());
        }
    }
}
