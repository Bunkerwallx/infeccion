package com.ejemplo;

import java.io.IOException;
import java.io.InputStream;
import java.io.FileOutputStream;
import java.net.URL;

public class Downloader {
    public static void downloadApk(String url, String outputFile) {
        try (InputStream in = new URL(url).openStream();
             FileOutputStream fos = new FileOutputStream(outputFile)) {
            byte[] buffer = new byte[1024];
            int bytesRead;
            while ((bytesRead = in.read(buffer)) != -1) {
                fos.write(buffer, 0, bytesRead);
            }
            System.out.println("APK descargado correctamente en " + outputFile);
        } catch (IOException e) {
            System.out.println("Error al obtener el archivo de " + url + ": " + e.getMessage());
        }
    }
}
