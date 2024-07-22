package com.ejemplo;

import java.io.IOException;

public class Recompiler {
    public static void recompileApk(String inputDir, String outputApk) {
        try {
            Process process = new ProcessBuilder("apktool", "b", inputDir, "-o", outputApk)
                .inheritIO()
                .start();
            process.waitFor();
            System.out.println("APK recompilado correctamente en " + outputApk);
        } catch (IOException | InterruptedException e) {
            System.out.println("Error al recompilar el APK: " + e.getMessage());
        }
    }
}
