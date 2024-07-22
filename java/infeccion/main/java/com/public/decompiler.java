package com.ejemplo;

import java.io.IOException;

public class Decompiler {
    public static void decompileApk(String apkFile, String outputDir) {
        try {
            Process process = new ProcessBuilder("apktool", "d", apkFile, "-o", outputDir)
                .inheritIO()
                .start();
            process.waitFor();
            System.out.println("APK decompilado correctamente en " + outputDir);
        } catch (IOException | InterruptedException e) {
            System.out.println("Error al decompilar el APK: " + e.getMessage());
        }
    }
}
